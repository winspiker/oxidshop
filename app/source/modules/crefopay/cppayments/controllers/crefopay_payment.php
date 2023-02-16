<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;

/** 
 * CrefoPay Payment Controller
 */
class crefopay_payment extends crefopay_payment_parent
{

    private $crefoUser;

    private $crefoTx;

    private $crefoBasket;

    private $crefoBillAddress;

    private $crefoDeliveryAddress = null;

    private $riskClass;

    private $logger;

    private $sfinit = false;

    public function render()
    {
        $redirected = $_GET['redirected'] == 1 ? true: false;
        
        $this->logger = oxNew('crefoPayLogger');
        
        if ($this->getUser() == null)
        {
            return parent::render();
        }

        if ($redirected) {
            $cpOrderId = $_GET['orderId'];
            $this->crefoTx = oxNew('crefoPayTransaction');
            $this->crefoTx->setOrderId($cpOrderId);
            $this->getSession()->setAllowedPaymentMethods($this->crefoTx->getTransactionPaymentInstruments($cpOrderId));

            $this->logger->debug(__FILE__, "redirect payment for transaction " . $this->crefoTx->getOrderId() . " was canceled by user");
        } else {
            // CrefoPay user data
            $this->crefoUser = oxNew('crefoPayUser');
            $this->crefoUser->init($this->getUser());
            
            // CrefoPay basket
            $this->crefoBasket = oxNew('crefoPayBasket');
            $basket = $this->getSession()->getBasket();
            $this->crefoBasket->init($basket);
            
            // CrefoPay bill address
            $oxAddress = oxNew('oxaddress');
            $this->crefoBillAddress = oxNew('crefoPayAddress');
            $this->crefoBillAddress->init($oxAddress, 'bill', $this->getUser());
            
            // CrefoPay delivery address
            foreach ($this->getUser()->getUserAddresses() as $oxAddress) {
                if ($oxAddress->_blSelected == 1) {
                    $this->crefoDeliveryAddress = oxNew('crefoPayAddress');
                    $this->crefoDeliveryAddress->init($oxAddress, 'delivery');
                }
            }
            
            // Try to find RiskClass for existing order by session id
            try {
                $cpOrders = oxNew('crefopay_cporders');
                $cpRiskClass = $cpOrders->getRiskClassBySessionId($this->getSession()->getId());

                $this->riskClass = (int) $cpRiskClass;
                $this->logger->debug(__FILE__, 'Setze Risikoklasse ' . $this->riskClass . ' bei Session ID ' . $this->getSession()->getId());
            } catch (Exception $e) {
                $this->logger->error(__FILE__, $e->getMessage());
                return parent::render();
            }

            // create transaction
            if (!$this->getSession()->getTransactionExists()) {
                try {
                    $this->crefoTx = oxNew('crefoPayTransaction');
                    $this->crefoTx->createTransaction($this->crefoUser, $this->crefoBasket, $this->riskClass, $this->crefoBillAddress, $this->crefoDeliveryAddress);
                    $this->getSession()->setTransactionExists();
                    
                } catch (\Exception $e) {
                    $this->logger->error(__FILE__, $e->getMessage());
                    return parent::render();
                }
            }
            
            // Update allowed Payment Methods
            $this->logger->debug(__FILE__, "Allowed Payment Methods for crefoTransaction " . $this->crefoTx->getOrderId() . ": \n" . print_r($this->crefoTx->getAllowedPaymentMethods(), true));
            $this->getSession()->setAllowedPaymentMethods($this->crefoTx->getAllowedPaymentMethods());
             
            try {
                $cpOxDb = oxDb::getDb();
                
                if ($cpOxDb->select("SELECT 1 from cporders where OXSESSIONID = '" . $this->getSession()->getId() . "';")->EOF) {
                    // session id doesn't exist
                    $cpSql = $this->crefoTx->getSql();
                    if ($cpSql != null)
                    {
                        $cpOxDb->execute("INSERT INTO cporders" . $cpSql['keys'] . " values " . $cpSql['values'] . ";");
                    } else {
                        $this->logger->log(1, __FILE__, 'konnte Transaktionsinformationen nicht finden');
                    }
                    
                } else {
                    // session id already exist
                    $timestamp = date("Y-m-d H:i:s", time());
                    $cpOrderState = $this->crefoTx->getStatus();
                    $cpOxDb->execute("UPDATE cporders SET CPORDERID='" . $this->crefoTx->getOrderId() . "', CPORDERUPDATE='" . $timestamp . "' WHERE OXSESSIONID='" . $this->getSession()->getId() . "';");
                }
                
            } catch (Exception $e) {
                $this->logger->log(2, __FILE__, $e->getMessage());
            }
        }

        return parent::render();
    }

    public function failure()
    {
        // reload payment selection
        $conf = oxRegistry::getConfig();
        oxRegistry::getUtils()->redirect($conf->getShopCurrentURL() . '&cl=payment&orderId=' . $_GET['orderID'] , true, 302);
    }

    public function getOrderId()
    {
        return $this->crefoTx->getOrderId();
    }

    public function secureFieldsInitialized()
    {
        if ($this->sfinit == false)
        {
            if ($this->logger->getLevel() == 0)
            {
                $this->logger->log(0, __FILE__, "Secure Fields initialized");    
            }
            $this->sfinit = true;
            return false;
        } 

        return true;

    }

    public function dobMissing()
    {
        if (empty($this->crefoUser)) {
            $this->crefoUser = oxNew('crefoPayUser');
            $this->crefoUser->init($this->getUser());

        } 
        return $this->crefoUser->dateOfBirthMissing();
    }
}