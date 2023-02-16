<?php

use oxObjectException as ObjectException;
use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
use \OxidEsales\Eshop\Core\Exception\DatabaseException;
use \OxidEsales\Eshop\Core\Field;

class crefopay_oxorder extends crefopay_oxorder_parent
{
    /**
     * Order related CrefoPay transaction
     *
     * @var crefopay_cporders
     */
    private $transaction;

    /**
     * Database representation of a timestamp
     *
     * @var string
     */
    private $timestamp;

    /**
     * Load oxid order model referenced by CrefoPay orderID
     *
     * @return bool
     */
    public function cpLoad($orderId)
    {
        $logger = oxNew('crefoPayLogger');
        
        try {
            $this->transaction = oxNew('crefopay_cporders');
            $this->transaction->cpLoad($orderId);
        } catch (ObjectException $e) {
            $logger->error(__FILE__, $e->getMessage());
        }

        return parent::load($this->transaction->getOxId());
    }

    /**
     * Validates the delivery address
     *
     * @param \OxidEsales\Eshop\Application\Model\User $oUser
     * @return OxidEsales\Eshop\Application\Model\Order::ORDER_STATE_INVALIDDElADDRESSCHANGED
     */
    public function validateDeliveryAddress($oUser)
    {   
        $sDeliveryAddress = $oUser->getEncodedDeliveryAddress();

        /** @var oxRequiredAddressFields $oRequiredAddressFields */
        $oRequiredAddressFields = oxNew('oxRequiredAddressFields');

        /** @var oxRequiredFieldsValidator $oFieldsValidator */
        $oFieldsValidator = oxNew('oxRequiredFieldsValidator');
        $oFieldsValidator->setRequiredFields($oRequiredAddressFields->getBillingFields());
        $blFieldsValid = $oFieldsValidator->validateFields($oUser);

        /** @var oxAddress $oDeliveryAddress */
        $oDeliveryAddress = $this->getDelAddressInfo();
        if ($blFieldsValid && $oDeliveryAddress) {
            $sDeliveryAddress .= $oDeliveryAddress->getEncodedDeliveryAddress();

            $oFieldsValidator->setRequiredFields($oRequiredAddressFields->getDeliveryFields());
            $blFieldsValid = $oFieldsValidator->validateFields($oDeliveryAddress);
        }

        $iState = 0; 
        if (!$blFieldsValid) {
            $iState = self::ORDER_STATE_INVALIDDElADDRESSCHANGED;
        }

        return $iState;
    }

    /**
     * Loads an oxid order model by provided CrefoPay OrderID
     *
     * @deprecated
     * 
     * @param string $orderID
     * 
     * @throws DatabaseException
     * @return OxidEsales\Eshop\Application\Model\Order
     */
    public function loadByCpOrderId($orderID)
    {
        $cpOxDb = oxDb::getDb();
        $cpOxDb->setFetchMode(2);
        
        try {
            $sql = 'select oxorder.OXID from oxorder inner join cporders on cporders.OXORDERID=oxorder.OXORDERNR where cporders.CPORDERID=?';
            $result = $cpOxDb->getRow($sql, [$orderID]);
            $oxId = $result['OXID'];

            if (empty($oxId)) {
                // if we are unable to fetch oxId from oxorder table
                $logger = oxNew('crefoPayLogger');
                $logger->warn(__FILE__, "Konnte die Oxid Bestellung für Order ID " . $orderID . " in oxorder nicht finden, versuche es über Zahlungsreferenz");

                $sql = "select oxorder.OXID from oxorder inner join cporders on cporders.OXORDERID=oxorder.OXPAYMENTID where cporders.CPORDERID=?";
                $result = $cpOxDb->getRow($sql, [$orderID]);
                $oxId = $result['OXID'];

                if (empty($oxId)) {
                    $logger->warn(__FILE__, "Konnte die Oxid Bestellung für Order ID " . $orderID . " auch  über Zahlungsreferenz in oxorder nicht finden");
                } else {
                    $logger->debug(__FILE__, "Konnte die Oxid Bestellung für Order ID " . $orderID . " über Zahlungsreferenz gefunden");
                }
            }
        } catch (DatabaseException $dbe) {
            throw $dbe;
        } catch (\Exception $e) {
            throw new DatabaseException($e->getMessage(), $e->getCode(), $e);
        }
        return $this->load($oxId);
    }

    /**
     * Mark an order as paid and save it
     * 
     * @param string $timestamp
     * @param int $type
     *     -1: Error code
     *      0: Full payment
     *      1: Partial payment
     *      2: Over payment
     * 
     * @return crefopay_oxorder
     */
    public function pay(int $type, string $timestamp = null)
    {
        $logger = oxNew('crefoPayLogger');
        try {
            switch ($type) {
                case 0:
                    $this->transaction->setOrderState("PAID");
                break;
                case 1:
                    $this->transaction->setOrderState("PARTIALPAID");
                break;
                case 2:
                    $this->transaction->setOrderState("OVERPAID");
                break;
                default: 
                $logger->error(__FILE__, "Invalider Payment Typ");
                return $this;
            }
    
            if ($timestamp == null) {
                $this->timestamp = $this->setTimestamp();
            } else {
                $this->timestamp = date("Y-m-d H:i:s", time($timestamp));
            }
            $logger->debug(__FILE__, "Setze Bestellstatus der CrefoPay Bestellung " . $this->getCpOrderId() . " auf " . $this->timestamp);
            $this->oxorder__oxpaid->rawValue = $this->timestamp;
            $this->cpSave();
        } catch (\Exception $e) {
            $logger->error(__FILE__, "Exception: " . $e->getMessage());
        }
        
        return $this;
    }


    /**
     * Additionally saves the CpOrder
     *
     * @return bool
     */
    public function cpSave()
    {
        $this->transaction->save();
        return $this->save();
    }


    /**
     * try to find additionalData for a given orderID
     * returns additionalData if found
     * ohterwise false
     */
    public function getAdditionalData($orderID)
    {
        $cpOxDb = oxDb::getDb();
        $cpOxDb->setFetchMode(2);

        try {
            // return null if there are no additionalData
            $sql = 'select CPBANKNAME, CPBANKACCOUNTHOLDER, CPIBAN, CPBIC, CPPAYMENTREFERENCE from cpadditionals where CPORDERID="' . $orderID . '"';
            $result = $cpOxDb->getRow($sql);
            if ($result['CPPAYMENTREFERENCE'] == "") {
                return null;
            }
    
            // otherwise return additional data
            return array(
                'bankname' => $result['CPBANKNAME'],
                'accountHolder' => $result['CPBANKACCOUNTHOLDER'],
                'iban' => $result['CPIBAN'],
                'bic' => $result['CPBIC'],
                'paymentReference' => $result['CPPAYMENTREFERENCE']
            );
        } catch (Exception $e) {
            throw $e;
        }
    }

    /**
     * Get the orderID of CrefoPay transaction
     *
     * @return string
     */
    public function getCpOrderId()
    {
        return $this->transaction->getCpOrderId();
    }

    /**
     * Sets the timestamp
     *
     * @param string $time
     * @return void
     */
    public function setTimestamp($time = null)
    {
        $this->timestamp = date("Y-m-d H:i:s", time($time));
    }
}