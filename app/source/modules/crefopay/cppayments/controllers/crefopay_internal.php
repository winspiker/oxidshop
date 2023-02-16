<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;

class crefopay_internal extends oxUBase
{
    /**
     * insert CrefoPay paymentInstrumentId into cporders for paymentMehods:
     *  1. CC
     *  2. CC3D
     *  3. DD
     */
    public function render()
    {
        $postData = $_POST;
        $logger = oxNew('crefoPayLogger');

        $dbUpdateRequired = false;

        // check if additional information has to be updated
        if (isset($postData['dateOfBirth'])) {
            $logger->debug(__FILE__, 'DateOfBirth erhalten: ' . $postData['dateOfBirth']);
            $update['additionalInformation']['dateOfBirth'] = $postData['dateOfBirth'];
            $dbUpdateRequired = true;
        }

        if (isset($postData['salutation'])) {
            $logger->debug(__FILE__, 'Salutation erhalten: ' . $postData['salutation']);
            $update['additionalInformation']['salutation'] = $postData['salutation'];
            $dbUpdateRequired = true;
        }

        if ($postData['paymentMethod'] == "CC" || $postData['paymentMethod'] == "CC3D" || $postData['paymentMethod'] == "DD") {
            $logger->debug(__FILE__, 'PaymentInstrumentId erhalten: ' . $postData['paymentInstrumentId']);
            $update['paymentInstrumentId'] = $postData['paymentInstrumentId'];
            $dbUpdateRequired = true;
        }

        if ($dbUpdateRequired) {
            $cpOrderId = $postData['orderNo'];
            $cpPID = null;
            $cpAdditional = null;

            foreach ($update as $key => $value) {
                switch ($key) {
                    case 'paymentInstrumentId':
                        $cpPID = $value;
                        break;
                    case 'additionalInformation':
                        $cpAdditional= json_encode($value);
                        break;
                    default:
                        $logger->warn(__FILE__, "ungültiger Key " . $key . " für Parameter: additionalInformation");
                        break;
                }
            }

            try {
                $logger->debug( __FILE__, 'Aktualisiere cporders Tabelle');
                $cporders = oxNew('crefopay_cporders');
                $cporders->setOrderId($cpOrderId);
           
                if ($cpAdditional !== null)                 {
                    $cporders->saveAdditionalData($cpAdditional);
                }

                if ($cpPID !== null)                 {
                    $cporders->savePaymentInstrumentId($cpPID);
                }
            } catch (DbException $de) {
                $logger->error(__FILE__, "DatenbankException: " . $de->getMessage());
            } catch (\Exception $e) {
                $logger->error(__FILE__, "Exception: " . $e->getMessage());
            }
        }

        http_response_code(200);
        exit();
    }

    /**
     * CrefoPay notification handler
     */
    public function notify()
    {
        $logger = oxNew('crefoPayLogger');
        $postData = $_POST;

        $logger->debug(__FILE__, "Notification:\n" . print_r($postData, true));


        // MAC check
        if ($this->macInvalid($postData)) {
            $logger->error(__FILE__, "Notification Verarbeitung abgelehnt: invalide MAC");
            http_response_code(500);
            exit();
        } else {
            $logger->debug(__FILE__, "MAC Validierung erfolgreich");
        }

        // make it compatible with old mns versions
        switch ($postData['version']) {
            case '2.2':
                $logger->debug(__FILE__, "korrektes Notification Format erhalten (2.2)");
                break;
            case '2.1':
                $logger->debug(__FILE__, "korrektes Notification Format erhalten (2.1)");
                break;
            case '2.0':
                $logger->warn(__FILE__, "falsches Notification Format: 2.1 erwartet aber " . $postData['version'] . " erhalten");
                break;
            default:
                $logger->warn(__FILE__, "falsches Notification Format: 2.1 erwartet aber " . $postData['version'] . " erhalten");
                $postData['orderID'] = $postData['orderNo'];
            break;
        }
        
        // Check Order ID
        $cpOrderId = $postData['orderID'];
        if (empty($cpOrderId)) {
            $logger->error(__FILE__, "Notification Verabeitung abgelehnt: fehlende OrderID");
            http_response_code(500);
            exit();
        }
        
        try {
            // Do the update
            if ($postData['orderStatus'] != "") {
                $result = $this->orderUpdate($postData, $logger);
            } else if ($postData['transactionStatus'] != "") {
                $result = $this->transactionUpdate($postData, $logger);
            } else {
                $logger->error(__FILE__, "Notification Verabeitung abgelehnt: weder Transaktions- noch Orderupdate");
                http_response_code(500);
                exit();
            }

            if (!$result) {
                $logger->error(__FILE__, "Aktualisierung der Bestellung mit CrefoPay OrderID " . $cpOrderId . " fehlgeschlagen");
                http_response_code(500);
                exit();
            }
        } catch (Exception $e) {
            if (empty($e->getMessage())) {
                $e = new \Exception($result->errorMsg());
            }
            $logger->error(__FILE__, $e->getMessage());
            http_response_code(500);
            exit();
        }

        http_response_code(200);
        exit();
    }

    /**
     * orderUpdate function takes the notification data and checks what have to been updated
     *
     * @param array $data
     * @param crefoPayLogger $logger
     *
     * @throws \Exception
     * @return bool
     */
    private function orderUpdate($data, $logger)
    {
        if ($this->validate('order', $data) == false) {
            throw new \Exception("Invalide Notification Daten", 500);      
        }

        try {
            $oxOrder = oxNew('crefopay_oxorder');
            $oxOrder->cpLoad($data['orderID']);
            if ($oxOrder) {
                $oxOrder->setTimestamp($data['timestamp']);
                $logger->debug(__FILE__, "Bestellung mit OrderID " . $oxOrder->getCpOrderId() . " erfolgreich geladen");
            } else {
                $logger->warn(__FILE__, "Konnte keine Bestellung mit OrderID " . $data['orderID'] . " finden");
                return true;
            }
            $status = $data['orderStatus'];
            switch ($status) {
                case 'PAID':
                    if ($this->savePayment($oxOrder, $logger, $data['amount'], $data['currency'], $data['timestamp']) < 0) {
                        $logger->error(__FILE__, "fehler beim speichern der Zahlung");
                        return false;
                    }
                break;
                default:
                    $logger->debug(__FILE__, "Setze neuen Transaktionsstatus: " . $data['orderStatus']);
                break;
            }
            $logger->debug(__FILE__, "Bestellung mit CrefoPay OrderID " . $data['orderID'] . " erfolgreich aktualisiert");
            return true;
        } catch (Exception $e) {
            $logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }

    /**
     * transactionUpdate function takes the notification updates the order
     *
     * @param array $data
     * @param crefoPayLogger $logger
     * 
     * @throws \Exception
     * @return bool
     */
    private function transactionUpdate($data, $logger)
    {
        if ($this->validate('transaction', $data) == false) {
            throw new \Exception("Invalide Notification Daten", 500);      
        }

        try {
            $cporders = oxNew('crefopay_cporders');
            $cporders->cpLoad($data['orderID']);
            if (!$cporders) {
                $logger->warn(__FILE__, "Konnte keine Bestellung mit OrderID " . $data['orderID'] . " finden");
                return true;
            }
            
            switch ($data['transactionStatus']) {
                case 'ACKNOWLEDGEPENDING':
                    $oxOrderNr = $cporders->getOxOrderNr();
                    if (empty($oxOrderNr)) {
                        $logger->error(__FILE__, "Keine Oxid Bestellung mit CrefoPay OrderID " . $data['orderID'] . " gefunden");
                    } else {
                        $logger->debug(__FILE__, "CrefoPay Transaktion " . $data['orderID'] . " der Oxid Bestellung " . $oxOrderNr . " wird abgeschlossen");
                    }

                    // now update CrefoPay transaction data
                    if (!empty($data['orderID']) && !empty($oxOrderNr)) {
                        $this->updateTransactionData($data['orderID'], $oxOrderNr);
                    } else {
                        $logger->warn(__FILE__, "updating CrefoPay transactionData skipped");
                    }

                    if (!empty($data['paymentReference'])) {
                        $this->updatePaymentReference($data['orderID'], $data['paymentReference'], $logger);
                    }
                break;
                default:
                    $logger->debug(__FILE__, "Setze neuen Transaktionsstatus: " . $data['transactionStatus']);
                break;
            }
            return $cporders->setOrderState($data['transactionStatus'])
                            ->setOrderUpdate($data['timestamp'])
                            ->save();
        } catch (Exception $e) {
            $logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }


    /**
     * Set the payment reference from third-party payments
     *
     * @param string $orderID
     * @param string $paymentReference
     * @param crefoPayLogger $logger
     * 
     * @throws Exception
     * @return void
     */
    private function updatePaymentReference($orderID, $paymentReference, $logger)
    {
        $sql = 'insert into cpadditionals (CPORDERID, CPPAYMENTREFERENCE) VALUES (?, ?)';
        $values = [
            $orderID,
            $paymentReference
        ];
        try {
            $cpOxDb = oxDb::getDb();
            $cpOxDb->setFetchMode(2);
            if ($cpOxDb->getRow('SELECT CPORDERID FROM cpadditionals WHERE CPORDERID=?', [$orderID])) {
                $logger->debug(__FILE__, "Payment Referenz der Bestellung " . $orderID . " ist bereits vorhaden");
            } else {
                $logger->debug(__FILE__, "Payment Referenz der Bestellung " . $orderID . " wird gesetzt auf " . $paymentReference);
                $cpOxDb->execute($sql, $values);
            }
        } catch (Exception $e) {
            throw $e;
        }
    }


    /**
     * set oxid order number as CrefoPay merchantReference
     *
     * @param string $cpOrderId
     * @param string $oxOrderNr
     * 
     * @throws Exception
     * @return void
     */
    private function updateTransactionData(string $cpOrderId, string $oxOrderNr)
    {
        $config = oxNew('crefoPayConfig');
        $params = $config->getApiAuth();

        $params['orderID'] = $cpOrderId;
        $params['merchantReference'] = $oxOrderNr;

        try {
            $api = oxNew('crefoPayApi');
            $response = $api->call($params, 'updateTransactionData');
            if ($this->response->resultCode != 0)
            {
                $this->logger->error(__FILE__, "Fehler bei getStatus für Order ID " . $orderID . ": " . $response->message . ':' . $response->errorDetails);
                throw new Exception($response->message);
            }
        } catch (Exception $e) {
            $logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }


    /**
     * The savePayment function takes a CrefoPay OrderId, amount, currency and timestamp;
     * it loads the referring oxid order and tries to set oxorder__oxpaid to the given timestamp.
     *
     * @param crefopay_oxorder $cpOrder
     * @param crefopayLogger $logger
     * @param string $amount
     * @param string $currency
     *
     * @throws Exception
     *
     * @return int
     *      -1: Error code
     *       0: Full payment
     *       1: Partial payment
     *       2: Over payment
     */
    private function savePayment(crefopay_oxorder $oxOrder, crefoPayLogger $logger, string $amount, string $currency, string $timestamp)
    {
        $logger = oxNew('crefoPayLogger');
        $resultCode = -1;
        $logger->debug(__FILE__, 'Zahlungseingang fuer CrefoPay OrderID ' . $oxOrder->getCpOrderId() . ' ueber ' . number_format($amount / 100, 2) . $currency . ' registriert.'); 

        if ($oxOrder == null) {
            $logger->error(__FILE__, 'Keine Bestellung zum speichern der Zahlung vorhanden');
            return -2;
        } else {
            $logger->debug(__FILE__, 'Speichere Zahlung der Bestellung ' . $oxOrder->getCpOrderId());
        }

        try {
            // debug log
            $logger->debug(__FILE__, 'Bestellung  ' . $oxOrder->getCpOrderId() . ' wird nun aktualisiert');
            // check if it's full payment, partial payment or over payment
            $totalamount = number_format($oxOrder->getTotalOrderSum() * 100);
            if ($totalamount > number_format($amount)) {
                // partial payment
                $logger->debug(__FILE__, 'Fuer Bestellung ' . $oxOrder->getCpOrderId() . ' wurde eine Teilzahlung erfasst');
                $type = 1;
            } else if ($totalamount < number_format($amount)) {
                // over payment
                $logger->debug(__FILE__, 'Fuer Bestellung ' . $oxOrder->getCpOrderId() . ' wurde eine Ueberzahlung erfasst');
                $type = 2;
            } else {
                $type = 0;
            }

            // now update the order
            $oxOrder->pay($type, $timestamp);
            $logger->debug(__FILE__, 'Bestellung ' . $oxOrder->getCpOrderId() . ' erfolgreich aktualisiert');
            return $type;
        } catch (\Exception $e) {
            $logger->warn(__FILE__, 'Fehler beim speichern der Zahlung fuer Bestellung ' . $oxOrder->getCpOrderId());
            throw $e;
        }
        
    }

    /**
     * this function is able to change an existing $old_key of an $array to $new_key
     */
    private function changeKey($array, $old_key, $new_key)
    {
        if (!array_key_exists($old_key, $array)) {
            return $array;
        }

        $keys = array_keys($array);
        $keys[array_search($old_key, $keys)] = $new_key;

        return array_combine($keys, $array);
    }

    /**
     * checks if the mac of an incoming notification call is valid
     */
    private function macInvalid($data)
    {
        $post_mac = $data['mac'];
        unset($data['mac']);
        ksort($data);

        // calculate mac
        $calc_mac = oxNew('crefoPayApi')->calculateMac(implode("", $data));

        if ($calc_mac != $post_mac) {
            return true;
        }

        return false;
    }

    /**
     * Data validation for order/transaction updates
     *
     * @param string $type [order|transaction]
     * @param array $data
     * @return void
     */
    private function validate(string $type, array $data)
    {
        switch ($type) {
            case 'order':
                if (
                    empty($data['amount']) ||
                    empty($data['currency']) ||
                    empty($data['orderID']) ||
                    empty($data['orderStatus']) ||
                    empty($data['timestamp'])
                ) return false;
            break;

            case 'transaction':
                if (
                    empty($data['orderID']) ||
                    empty($data['transactionStatus']) ||
                    empty($data['timestamp'])
                ) return false;
            break;

            default: return false;
        }
        return true;
    }
}
