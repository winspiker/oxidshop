<?php

/**
 *  CrefoPay Tansaction
 */
class crefoPayTransaction
{

    // Parameter array
    private $param = array();

    // Default settings for online transactions
    private $context = 'ONLINE';

    private $integrationType = 'SecureFields';

    private $supportedLang = array(
        'DE',
        'EN',
        'ES',
        'FR',
        'IT',
        'NL'
    );

    // Basic settings
    private $merchantID;

    private $storeID;

    private $privateKey;

    private $url;


    // Additional settings
    private $autoCapture;

    private $locale;

    private $basketValidity = null;

    // User info
    private $userID;

    private $userType;

    private $userRiskClass;

    private $companyData = null;

    private $userData;

    // Order info
    private $orderID;

    private $amount;

    private $basketItems;

    // Address info
    private $billingRecipient = null;

    private $billingAddress = null;

    private $shippingRecipient = null;

    private $shippingAddress = null;

    // Security value
    private $mac;

    // Return values
    private $headerSize;

    private $responseBody;

    private $resultCode;

    private $redirectUrl;

    private $errorMessage;

    private $allowedPaymentMethods;

    private $userDataSet;

    private $status;

    private $logger;
    

    // Currently non required params
    // private $userIpAddress;
    // private $additionalPaymentOptions;
    // private $solvencyCheckInformation;
    // private $hostedPagesTexts;
    // private $shippingRecipientAddition;
    // private $billingRecipientAddition;
    
    /**
     * Constructor
     *
     * Setup the static values:
     * - url
     * - merchantID
     * - storeID
     * - autoCapture
     * - basketValidity
     * - locale
     */
    function __construct()
    {
        // Load Module Config
        $config = oxRegistry::getConfig();
        $cpConf = oxNew('crefoPayConfig');
        
        // Initialize Logger
        $this->logger = oxNew('crefoPayLogger');
        
        // Setup url (Sandbox or Production)
        $this->url = $cpConf->getApiUrl();
        
        // Setup account information
        $this->merchantID = $config->getConfigParam('CrefoPayMerchantId');
        $this->storeID = $config->getConfigParam('CrefoPayStoreId');
        $this->privateKey = $config->getConfigParam('CrefoPayPrivateKey');
        
        // Setup transaction settings
        if ($config->getConfigParam('CrefoPayAutoCapture')) {
            $this->autoCapture = 1;
        } else {
            $this->autoCapture = 0;
        }
        
        // Basket validity
        if ($config->getConfigParam('CrefoPayBasketVal') != null) {
            $this->basketValidity = $config->getConfigParam('CrefoPayBasketVal') . $config->getConfigParam('CrefoPayBasketValUnit');
        }
        
        // Setup locale settings
        $oLang = oxRegistry::getLang();
        $this->locale = strtoupper($oLang->getLanguageAbbr());
        
        if (! in_array($this->locale, $this->supportedLang)) {
            $this->locale = $config->getConfigParam('CrefoPayDefaultLang');
        }
    }

    public function createTransaction($user, $basket, $riskClass, $billAddress, $deliveryAddress = null)
    {
        $this->userDataSet = array(
            'user' => $user,
            'basket' => $basket,
            'billAddress' => $billAddress,
            'deliveryAddress' => $deliveryAddress
        );

        // set user data
        $this->userID = $user->getUserId();
        $this->userType = $user->getUserType();
        if ($this->userType == 'BUSINESS')
        {
            $this->companyData = $user->getCompanyData();
        }
        $this->userData = $user->getUserData();
        
        // set order data
        $this->userRiskClass = $riskClass;
        if (empty($this->orderID)) {
            $this->orderID = $this->createOrderId();
        }
        $this->amount = $basket->getTotalAmount();
        $this->basketItems = $basket->getBasketItems();
        
        // set bill and (optional) shipping data
        $this->billingRecipient = $billAddress->getRecipient();
        $this->billingAddress = $billAddress->getAddress();
        
        if ($deliveryAddress != null) {
            $this->shippingRecipient = $deliveryAddress->getRecipient();
            $this->shippingAddress = $deliveryAddress->getAddress();
        }
        
        try {
            $this->create();
            if ($this->resultCode <= 1)
            {
                if ($this->logger->getLevel() == 0)
                {
                    $this->logger->log(0, __FILE__, "Transaktion " . $this->getOrderId() . " erfolgreich erstellt");
                }
            } else {
                $this->logger->log(1, __FILE__, "Fehler bei CrefoPay Transaktionserstellung: \n" . $this->getErrorMessage());
                $this->handleError();
            }
            
        } catch (Exception $e) {
            $this->logger->log(2, __FILE__, "Exception bei Transaktionserstellung: \n" . $e->getMessage());
        }
    }

    public function getUserDataSet()
    {
        return $this->getUserDataSet;
    }

    public function getStatus($orderID = null)
    {
        $api = oxNew('crefoPayApi');
        if ($orderID == null)
        {
            $orderID = $this->orderID;
        }
        $param = array(
            'merchantID' => $this->merchantID,
            'storeID' => $this->storeID,
            'orderID' => $orderID
        );
        
        try {
            // execute call
            $this->responseBody = $api->call($param, 'getTransactionStatus');

            if ($this->responseBody->resultCode != 0)
            {
                $this->logger->log(1, __FILE__, "Fehler bei getStatus für Order ID " . $orderID . ": " . $this->responseBody->message . ':' . $this->responseBody->errorDetails);
                return null;
            }
            
            // collect resultCode, redirect URL and error message from response
            $additionalData = array(
                'transactionAmount' => $this->responseBody->additionalData->transactionAmount,
                'transactionCurrency' => $this->responseBody->additionalData->transactionCurrency,
                'paymentMethod' => $this->responseBody->additionalData->paymentMethod
            );

            switch ($this->responseBody->additionalData->paymentMethod) {
                case 'CIA';
                case 'BILL';
                    $additionalData['bankname'] = $this->responseBody->additionalData->bankname;
                    $additionalData['bic'] = $this->responseBody->additionalData->bic;
                    $additionalData['iban'] = $this->responseBody->additionalData->iban;
                    $additionalData['bankAccountHolder'] = $this->responseBody->additionalData->bankAccountHolder;
                    $additionalData['paymentReference'] = $this->responseBody->additionalData->paymentReference;
                    break;
                case 'DD':
                    $additionalData['sepaMandate'] = $this->responseBody->additionalData->sepaMandate;
                    break;
                default:
                    # code... 
                    break;
            }

            return array(
                'resultCode' => $this->responseBody->resultCode,
                'message' => $this->responseBody->message,
                'transactionStatus' => $this->responseBody->transactionStatus,
                'additionalData' => $additionalData,
                'errorDetails' => $this->responseBody->errorDetails
            );
            

        } catch (Exception $e) {
            $this->logger->log(2, __FILE__, "Unerwarteter Fehler bei getStatus: \n" . $e->getMessage());
        }   
    }

    public function getErrorMessage()
    {
        return $this->errorMessage;
    }

    public function getAllowedPaymentMethods()
    {
        return $this->allowedPaymentMethods;
    }

    public function getOrderId()
    {
        return $this->orderID;
    }

    public function getSql()
    {
        $txStatus = $this->getStatus();
        switch ($txStatus['transactionStatus']) {
            case 'NEW':
                $values = '(';
                $values .= "'" . oxRegistry::getSession()->getId() . "', ";
                $values .= "'" . $this->storeID . "', ";
                $values .= "'" . $this->orderID . "', ";
                $values .= "'" . "New" . "', ";
                $values .= "'" . $this->userID . "', ";
                $values .= "'" . $this->userType . "', ";
                $values .= "'" . date("Y-m-d H:i:s", time()) . "'";
                $values .= ')';
                
                $txArray = array (
                    'keys' => '(OXSESSIONID, CPSTOREID, CPORDERID, CPORDERSTATE, CPUSERID, CPUSERTYPE, CPORDERUPDATE)',
                    'values' => $values
                );
                break;
            
            default:
                $this->logger->log(1, __FILE__, "unbekannter Transaktionsstatus: " . $txStatus['transactionStatus']);
                $txArray = null;
                break;
        }
        
        return $txArray;
    }

    private function handleError()
    {
        // switching result codes
        switch ($this->resultCode) {
            case 2039:
                # User type cannot be changed
                $this->logger->log(1, __FILE__, 'userType ' . $this->userType . ' nicht erlaubt fuer userID ' . $this->userID);
                break;
            case 1002:
                # If Date of Birth is invalid, we will delete it from the params.
                if ($this->errorMessage == 'The field userData.dateOfBirth is not a valid.') {
                    $userData = json_decode($this->userData, true);
                    unset($userData['dateOfBirth']);
                    $this->userData = json_encode($userData);
                    try {
                        $this->create();
                        if ($this->resultCode <= 1)
                        {
                            if ($this->logger->getLevel() == 0)
                            {
                                $this->logger->log(0, __FILE__, "Transaktion " . $this->getOrderId() . " erfolgreich erstellt");
                            }
                        } else {
                            $this->logger->log(1, __FILE__, "Wiederholter Fehler bei CrefoPay Transaktionserstellung: \n" . $this->getErrorMessage());
                        }
                        
                    } catch (Exception $e) {
                        $this->logger->log(2, __FILE__, "Exception bei Transaktionserstellung: \n" . $e->getMessage());
                    }
                }
                break;
            default:
                # code...
                break;
        }
    }

    private function create()
    {
        $api = oxNew('crefoPayApi');
        
        try {
            // execute call
            if ($this->initParam())
            {
                $this->responseBody = $api->call($this->param, 'createTransaction');
            }
            
            // collect resultCode, redirect URL and error message from response
            $this->resultCode = $this->responseBody->resultCode;
            $this->redirectUrl = $this->responseBody->redirectUrl;
            $this->errorMessage = $this->responseBody->message;
            $this->errorDetails = $this->responseBody->errorDetails;
            $this->allowedPaymentMethods = $this->responseBody->allowedPaymentMethods;
        } catch (Exception $e) {
            throw $this->logger->log(2, __FILE__, $e->getMessage());
        }
    }

    public function getTransactionPaymentInstruments($orderID)
    {
        $api = oxNew('crefoPayApi');
        
        $param = array(
            'merchantID' => $this->merchantID,
            'storeID' => $this->storeID,
            'orderID' => $orderID
        );
        
        try {
            $this->responseBody = $api->call($param, 'getTransactionPaymentInstruments');
            
            // collect resultCode, redirect URL and error message from response
            if ($this->responseBody->resultCode == 0)
            {
                return $this->responseBody->allowedPaymentMethods;
            } else {
                $this->logger->log(1, __FILE__, $this->responseBody->message . ': ' . $this->responseBody->errorDetails);
                return null;
            }
            
        } catch (Exception $e) {
            $this->logger->log(2, __FILE__, "Fehler beim Versuch die erlaubten Bezahlarten zu holen: " . $e->getMessage());
        }
    }

    private function createOrderId()
    {
        return microtime(true) * 10000;
    }

    private function initParam()
    {
        // mandatory first
        $this->param['merchantID'] = $this->merchantID;
        $this->param['storeID'] = $this->storeID;
        $this->param['orderID'] = $this->orderID;
        $this->param['userID'] = $this->userID;
        $this->param['integrationType'] = $this->integrationType;
        $this->param['context'] = $this->context;
        $this->param['userType'] = $this->userType;
        $this->param['userData'] = $this->userData;
        $this->param['billingAddress'] = $this->billingAddress;
        $this->param['amount'] = $this->amount;
        $this->param['basketItems'] = $this->basketItems;
        $this->param['locale'] = $this->locale;
        
        // optional second
        $this->param['autoCapture'] = $this->autoCapture;
        $this->param['userRiskClass'] = $this->userRiskClass;
        
        if ($this->companyData != null) {
            $this->param['companyData'] = $this->companyData;
        }
        if (!empty($this->billingRecipient)) {
            $this->param['billingRecipient'] = $this->billingRecipient;
        }
        if (!empty($this->shippingAddress)) {
            $this->param['shippingAddress'] = $this->shippingAddress;
        }
        if (!empty($this->shippingRecipient)) {
            $this->param['shippingRecipient'] = $this->shippingRecipient;
        }
        if (!empty($this->basketValidity)) {
            $this->param['basketValidity'] = $this->basketValidity;
        }

        return true;
    }

    public function setOrderId($orderId)
    {
        $this->orderID = $orderId;
    }
}
