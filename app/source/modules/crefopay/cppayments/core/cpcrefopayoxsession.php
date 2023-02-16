<?php

/**
 * cpCrefoPayOxSession class wrapper for CrefoPay module.
 */
class cpCrefoPayOxSession extends cpCrefoPayOxSession_parent
{

    // List of allowed payment methods
    protected $allowedPaymentMethods;
    protected $crefoOrderId;
    protected $crefoReservationExists;
    protected $crefoTransactionExists;

    function __construct()
    {
        parent::__construct();
        $this->crefoTransactionExists = false;
        $this->crefoReservationExists = false;
    }
    
    /**
     * get the allowed payment methods
     */
    public function getAllowedPaymentMethods()
    {
        return $this->allowedPaymentMethods;
    }

    /**
     * get the CrefoPay orderID
     */
    public function getCrefoOrderId()
    {
        return $this->crefoOrderId;
    }

    /**
     * get the information about the CrefoPay reservation already exists
     */
    public function getReservationExists()
    {
        return $this->crefoReservationExists;
    }

    /**
     * Returns current timestamp in database compatible format
     *
     * @return string
     */
    public function getCurrentTimestamp()
    {
        return date("Y-m-d H:i:s", time());
    }

    /**
     * get the information about the CrefoPay transaction already exists
     */
    public function getTransactionExists()
    {
        return $this->crefoTransactionExists;
    }

    /**
     * set the allowed payment methods
     */
    public function setAllowedPaymentMethods($pm)
    {
        $this->allowedPaymentMethods = $pm;
    }

    /**
     * set the CrefoPay orderID
     */
    public function setCrefoOrderId($orderID)
    {
        $this->crefoOrderId = $orderID;
    }
    
    /**
     * mark CrefoPay transaction as existing
     */
    public function setTransactionExists()
    {
        if ($this->crefoTransactionExists == true)
        {
            return false;
        } else {
            $this->crefoTransactionExists = true;
            return true;
        }
    }
    
    /**
     * mark CrefoPay resevation as existing
     */
    public function setReservationExists()
    {
        if ($this->crefoReservationExists == true)
        {
            return false;
        } else {
            $this->crefoReservationExists = true;
            return true;
        }
    }

    /**
     * mark CrefoPay transaction as not existing
     */
    public function unsetTransactionExists()
    {
        if ($this->crefoTransactionExists == false)
        {
            return false;
        } else {
            $this->crefoTransactionExists = false;
            return true;
        }
    }
    

    /** 
     * checks if a provided $key represents 
     * an allowed CrefoPay payment method
     */
    public function isAllowedPaymentMethod($key)
    {
        if (!empty($this->allowedPaymentMethods) && !empty($key)) {
            return in_array($key, $this->allowedPaymentMethods);
        } else{
            return null;
        }
    }
}
