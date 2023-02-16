<?php

/**
 *  CrefoPay Config
 */
class crefoPayConfig
{
    public $cpPaymentMethods = array(
        'cpdebit' => 'CrefoPay Lastschrift',
        'cpcredit' => 'CrefoPay Kreditkarte',
        'cpcredit3d' => 'CrefoPay Kreditkarte mit 3D Secure',
        'cpprepaid' => 'CrefoPay Vorkasse',
        'cppaypal' => 'CrefoPay PayPal',
        'cpsofort' => 'CrefoPay Sofort',
        'cpbill' => 'CrefoPay Rechnung',
        'cpcod' => 'CrefoPay Nachnahme'
    );

    public $cpUrls = array(
        'apiLive' => 'https://api.crefopay.de/2.0/',
        'apiSandbox' => 'https://sandbox.crefopay.de/2.0/',
        'sfLive' => 'https://api.crefopay.de/secureFields/',
        'sfSandbox' => 'https://sandbox.crefopay.de/secureFields/',
        'libSecure' => 'https://libs.crefopay.de/3.0/secure-fields.js',
        'libJQuery' => 'https://code.jquery.com/jquery-3.2.1.min.js'
    );

    public function B2Benabled() {
        $conf = oxRegistry::getConfig();

        if ($conf->getConfigParam('CrefoPayB2BEnabled')) {
            return true;
        } else {
            return false;
        }
    }

    
    public function getApiAuth()
    {
        // Load Module Config
        $conf = oxRegistry::getConfig();
        
        // return CrefoPay account information
        return [
            'merchantID' => $conf->getConfigParam('CrefoPayMerchantId'),
            'storeID' => $conf->getConfigParam('CrefoPayStoreId'),
            'privateKey' => $conf->getConfigParam('CrefoPayPrivateKey')
        ];
    }


    public function getApiUrl($key = null)
    {
        $apiUrl = '';
        $conf = oxRegistry::getConfig();

        switch ($key)
        {
            case 'CPSF': 
                if ($conf->getConfigParam('CrefoPaySystemMode') == 1)
                {
                    $apiUrl .= $this->cpUrls['sfLive'];
                } else {
                    $apiUrl .= $this->cpUrls['sfSandbox'];
                } 
                break;

            case 'CPJQ':
                $apiUrl .= $this->cpUrls['libJQuery'];
                break;

            case 'LIBSF':
                $apiUrl .= $this->cpUrls['libSecure'];
                break;
                
            default:
                if ($conf->getConfigParam('CrefoPaySystemMode') == 1)
                {
                    $apiUrl .= $this->cpUrls['apiLive'];
                } else {
                    $apiUrl .= $this->cpUrls['apiSandbox'];
                } 
                break;
        }

        return $apiUrl;
    }
    
    public function getPaymentMethods()
    {
        return $this->cpPaymentMethods;
    }

    public function getPaymentTag($key)
    {
        switch ($key) {
            case "cpdebit":
                $tag = 'DD';
                break;
            case "cpcredit":
                $tag = 'CC';
                break;
            case "cpcredit3d":
                $tag = 'CC3D';
                break;
            case "cpprepaid":
                $tag = 'PREPAID';
                break;
            case "cppaypal":
                $tag = 'PAYPAL';
                break;
            case "cpsofort":
                $tag = 'SU';
                break;
            case "cpbill":
                $tag = 'BILL';
                break;
            case "cpcod":
                $tag = 'COD';
                break;
            default:
                $tag = null;
                break;
        }
        return $tag;
    }

    public function getPidIsRequired($paymentMethod)
    {
        switch ($paymentMethod) {
            case 'DD':
                return true;
            case 'CC':
                return true;
            case 'CC3D':
                return true;
            default:
                return false;
        }
    }

    public function hasAdditionalData($key)
    {       
        switch ($key) {
            case 'cpbill':
            case 'cpprepaid':
                return true;
                break;
            
            default:
                return false;
                break;
        }
    }

    public function isCrefoPay($key)
    {
        return array_key_exists($key, $this->cpPaymentMethods);
    }

}