<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;

/**
 * cpOxViewConf class wrapper for CrefoPay module.
 */
class cpCrefoPayOxViewConfig extends cpCrefoPayOxViewConfig_parent
{
    private $cpConfig;
    private $cpSession;
    private $oxConfig;

    function __construct()
    {
        parent::__construct();
        $this->cpConfig  = oxNew('crefoPayConfig');
        $this->cpSession = oxRegistry::getSession();
        $this->oxConfig  = oxRegistry::getConfig();
    }

    public function isAllowedPaymentMethod($key)
    {
        return $this->cpSession->isAllowedPaymentMethod($key);
    }

    public function allowOtherPayments()
    {
        if ($this->oxConfig->getConfigParam('CrefoPayAllowOtherPayments') == 1) {
            return true;
        } else {
            return false;
        }
    }

    public function getPlaceholder($key)
    {
        switch ($key) {
            case 'accountHolder':
                return 'accountHolder';
                break;
            case 'cardNumber':
                return '0000111122223333';
                break;
            case 'cvv':
                return 'CVV';
                break;
            default:
                return null;
                break;
        }
    }

    public function getCpsfUrl()
    {
        return $this->cpConfig->getApiUrl('CPSF');
    }

    public function getCpsfLib()
    {
        return $this->cpConfig->getApiUrl('LIBSF');
    }

    public function getCpJQ()
    {
        return $this->cpConfig->getApiUrl('CPJQ');
    }

    public function getPaymentTag($key)
    {
        return $this->cpConfig->getPaymentTag($key);
    }

    public function getShopPublicKey()
    {
        return $this->oxConfig->getConfigParam('CrefoPayShopPublicKey');
    }

    public function isCrefoPay($key)
    {
        return $this->cpConfig->isCrefoPay($key);
    }

    public function logoEnabled($name)
    {
        switch ($name) {
            case 'cvv':
                if ($this->oxConfig->getConfigParam('CrefoPayCvvLogo')) {
                    $ret = true;
                }
                break;
            case 'mc':
                if ($this->oxConfig->getConfigParam('CrefoPayMcLogo')) {
                    $ret = true;
                }
                break;
            case 'visa':
                if ($this->oxConfig->getConfigParam('CrefoPayVisaLogo')) {
                    $ret = true;
                }
                break;
            default:
                $ret = false;
                break;
        }
        return $ret;
    }

    public function hasAdditionalData($paymentMethod)
    {
        return $this->cpConfig->hasAdditionalData($paymentMethod);
    }

    public function getAdditionalData()
    {
        $cpOxDb = oxDb::getDb();
        $cpOxDb->setFetchMode(2);
        $logger = oxNew('crefoPayLogger');
        
        try {
            // get CrefoPay orderID
            $sql = 'select CPORDERID from cporders where OXSESSIONID="' . $this->cpSession->getId() . '"';
            $result = $cpOxDb->getRow($sql);
            $orderID = $result['CPORDERID'];

            // return false if orderID is empty
            if ($orderID == "")
            {
                $logger->log(1, __FILE__, "keine Bestellung zu Session " . $this->cpSession->getId() . " gefunden");
                return false;
            }

            $order = oxNew('crefopay_oxorder');
            
            return $order->getAdditionalData($orderID);

        } catch (Exception $e) {
            $logger->log(1, __FILE__, $e->getMessage());
            
            return false;
        }
    }

    public function getBillPeriod()
    {

        return $this->oxConfig->getConfigParam('CrefoPayBillPeriod');
    }

    public function getPrepaidPeriod()
    {
        return $this->oxConfig->getConfigParam('CrefoPayPrepaidPeriod');
    }

    public function convertAmount($amount)
    {
        return number_format($amount / 100, 2);
    }

    public function regenerateSessionId()
    {
        $this->cpSession->regenerateSessionId();
    }

}
