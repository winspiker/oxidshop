<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
class crefopay_paymentgateway extends crefopay_paymentgateway_parent
{

    public function executePayment($dAmount, &$oOrder)
    {
        $this->_iLastErrorNo = null;
        $this->_sLastError = null;

        // if payment has been already reserved return true
        if (oxRegistry::getSession()->getReservationExists()) {
            return true;
        }

        $logger = oxNew('crefoPayLogger');
        $crefoConfig = oxNew('crefoPayConfig');

        // proceed with no payment
        // used for other countries
        $oxPaymentId = @$this->_oPaymentInfo->oxuserpayments__oxpaymentsid->value;
        if ($oxPaymentId == 'oxempty') {
            return true;
        }

        // proceed with oxid workflow if no crefo payment
        if (!array_key_exists($oxPaymentId, $crefoConfig->getPaymentMethods())) {
            return parent::executePayment($dAmount, $oOrder);
        }

        // DatabaseUpdate
        $oxOrderId = @$this->_oPaymentInfo->oxuserpayments__oxid->value;
        try {
            if (empty($oxOrderId)) {
                $logger->log(1, __FILE__, "keine OxOrderId enhalten; nicht zu aktualisieren");
            } else {
                $cpOxDb = oxDb::getDb();
                $sql = "update cporders set OXORDERID=? where OXSESSIONID=?";
                $result = $cpOxDb->execute($sql, [$oxOrderId, oxRegistry::getSession()->getId()]);
                if ($result) {
                    $logger->log(0, __FILE__, "update erfolgreich");
                } else {
                    $logger->log(0, __FILE__, "update nicht erfolgreich");
                }
            }
        } catch (Exception $e) {
            $logger->log(2, __FILE__, $e->getMessage());
            $this->_sLastError = $e->getMessage();
            return false;
        }

        return $this->reserve($oxPaymentId, $dAmount);
    }

    private function reserve($oxPid, $amount)
    {
        $api = oxNew('crefoPayApi');
        $config = oxRegistry::getConfig();
        $logger = oxNew('crefoPayLogger');
        $merchantID = $config->getConfigParam('CrefoPayMerchantId');
        $session = oxRegistry::getSession();
        $storeID = $config->getConfigParam('CrefoPayStoreId');

        // get payment method
        $crefoConf = oxNew('crefoPayConfig');
        $paymentMethod = $crefoConf->getPaymentTag($oxPid);
        $pidRequired = $crefoConf->getPidIsRequired($paymentMethod);

        // get order id
        $cpOxDb = oxDb::getDb();
        $cpOxDb->setFetchMode(2); // FETCH_MODE_ASSOC
        
        $sql = 'select CPORDERID, CPPID, CPORDERSTATE, CPADDITIONAL from cporders where OXSESSIONID = "' . $session->getId() . '"';
        
        try {
            $result = $cpOxDb->getRow($sql);
        } catch (Exception $e) {
            $logger->log(2, __FILE__, $e->getMessage());
            return false;
        }
        
        $orderID = $result["CPORDERID"];

        // check if the payment really has been done when transaction status is AuthPending 
        if ($result["CPORDERSTATE"] == 'AuthPending') {
            $api = oxNew('crefoPayApi');
            $data = array(
                'merchantID' => $merchantID,
                'storeID'    => $storeID,
                'orderID'    => $orderID
            );
            $responseBody = $api->call($data, 'getTransactionStatus');
            if ($responseBody->transactionStatus === 'ACKNOWLEDGEPENDING')
            {
                return true;
            }
        } 

        $paymentInstrumentID = $result['CPPID'];
        
        $param = array(
            'amount'        => intval($amount * 100),
            'merchantID'    => $merchantID,
            'storeID'       => $storeID,
            'orderID'       => $orderID,
            'paymentMethod' => $paymentMethod
        );

        // set payment instrument id
        if (sizeof($paymentInstrumentID) > 0 && $pidRequired) {
            $param['paymentInstrumentID'] = $paymentInstrumentID;
        }

        // set additional data
        $additionalData = json_decode($result['CPADDITIONAL'], true);
        if (sizeof($additionalData) > 0) {
            $param['additionalInformation'] = json_encode($additionalData);
        }

        try {
            // execute call
            $responseBody = $api->call($param, 'reserve');
            if ($logger->getLevel() == 0)
            {
                $logger->log(0, __FILE__, "Ergebnis reserve Call: " . print_r($responseBody, true));
            }

            // collect resultCode, redirect URL and error message from response
            if ($responseBody->resultCode == 0) {
                try {
                    $session->setReservationExists();
                    // update cporders
                    $sql = 'update cporders set CPORDERSTATE = "AcknowledgePending", CPPAYMENTMETHOD = "' . $oxPid .'" where OXSESSIONID = "' . $session->getId() . '"';
                    $cpOxDb->execute($sql);

                    // update additionals if neccessary
                    if (isset($responseBody->additionalData)) {
                        $ad = $responseBody->additionalData;
                        $sql = 'insert into cpadditionals (CPORDERID, CPBANKNAME, CPBANKACCOUNTHOLDER, CPIBAN, CPBIC, CPPAYMENTREFERENCE) VALUES (?, ?, ?, ?, ?, ?)';
                        $values = [
                            $orderID,
                            $ad->bankname,
                            $ad->bankAccountHolder,
                            $ad->iban,
                            $ad->bic,
                            $ad->paymentReference
                        ];
                        $cpOxDb->execute($sql, $values);
                        $logger->debug(__FILE__, "Additional Data aktualisiert");
                    }
                } catch (Exception $e) {
                    $logger->error(__FILE__, "Datenbank Zugriffsfehler: " . $e->getMessage());
                }
                return true;
            } elseif ($responseBody->resultCode == 1) {
                $sql = 'update cporders set CPORDERSTATE = "AuthPending", CPPAYMENTMETHOD = "' . $oxPid .'" where OXSESSIONID = "' . $session->getId() . '"';
                try {
                    $cpOxDb->execute($sql);
                } catch (Exception $e) {
                    $logger->error(__FILE__, "Datenbank Zugriffsfehler: " . $e->getMessage());
                }
                $this->_sLastError = $responseBody->redirectUrl;
                return false;
            } else {
                if ($responseBody->resultCode == 2017) {
                    $sql = 'update cporders set CPRISKCLASS = "2" where OXSESSIONID = "' . $session->getId() . '"';
                    try {
                        $cpOxDb->execute($sql);
                    } catch (Exception $e) {
                        $logger->log(1, __FILE__, "Datenbank Zugriffsfehler: " . $e->getMessage());
                    }
                }
                $this->_iLastErrorNo = $responseBody->resultCode;

                $translationKey = 'cppayments_error_' . $responseBody->resultCode;
                $lang = oxRegistry::getLang();
                if($lang) {
                    $translatedMessage = $lang->translateString($translationKey);
                    // Language::translateString gibt den originalen "Key" zurück wenn es keine Übersetzung findet, daher prüfen wir das Ergebnis nochmal
                    if($translatedMessage !== $translationKey) {
                        $this->_sLastError = $translatedMessage;
                    } else {
                        $this->_sLastError = $responseBody->message;
                    }
                } else {
                    $this->_sLastError = $responseBody->message;
                }
                return false;
            }

        } catch (Exception $e) {
            $logger->log(2, __FILE__, $e->getMessage());
            return false;
        }
    }
}