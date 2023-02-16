<?php

/**
 *  CrefoPay User
 */
class crefoPayAddress
{
    // CrefoPay Address
    private $street;
    private $no;
    private $zip;
    private $city;
    private $state;
    private $country;
    private $type;    
    private $fname;
    private $lname;

    
    function init($oxAddress, $type, $oxUser = null)
    {   
        if ($type == 'delivery') {
            $this->fname = $oxAddress->oxaddress__oxfname->value;
            $this->lname = $oxAddress->oxaddress__oxlname->value;
        }

        // Use oxUser for address initialisation
        if ($oxUser != null) {
            // Address
            $oxAddress->oxaddress__oxstreet    = clone $oxUser->oxuser__oxstreet;
            $oxAddress->oxaddress__oxstreetnr  = clone $oxUser->oxuser__oxstreetnr;
            $oxAddress->oxaddress__oxzip       = clone $oxUser->oxuser__oxzip;
            $oxAddress->oxaddress__oxcity      = clone $oxUser->oxuser__oxcity;
            $oxAddress->oxaddress__oxstateid   = clone $oxUser->oxuser__oxstateid;
            $oxAddress->oxaddress__oxcountryid = clone $oxUser->oxuser__oxcountryid;
            
            // Name
            if (sizeof($oxUser->oxuser__oxfname->value) > 0)
            {
                $this->fname = $oxUser->oxuser__oxfname->value;
        
            }
            if (sizeof($oxUser->oxuser__oxlname->value) > 0)
            {
                $this->lname = $oxUser->oxuser__oxlname->value;
            }
        }

        // Address type (Bill | Delivery)
        $this->type    = $type;

        // Address parameters
        $oxCountry = oxNew('oxcountry');
        $oxState   = oxNew('oxstate');
        
        $oxCountry->load($oxAddress->oxaddress__oxcountryid->value);
        $oxState->load($oxAddress->oxaddress__stateid->value);
        
        $oxAddress->oxaddress__oxcountry = $oxCountry->oxcountry__oxisoalpha2;
        $oxAddress->oxaddress__oxstate   = $oxCountry->oxcountry__oxtitle;
        
        $this->street  = $oxAddress->oxaddress__oxstreet->value;
        $this->no      = $oxAddress->oxaddress__oxstreetnr->value;
        $this->zip     = $oxAddress->oxaddress__oxzip->value;
        $this->city    = $oxAddress->oxaddress__oxcity->value;
        $this->state   = $oxAddress->oxaddress__oxstate->value;
        $this->country = $oxAddress->oxaddress__oxcountry->value;
    }

    // Returns address type
    public function getType()
    {
        return $this->type;
    }
    
    // Returns Address
    public function getAddress()
    {
        return json_encode(
            array(
                'street'    => $this->street,
                'no'        => $this->no,
                'zip'       => $this->zip,
                'city'      => $this->city,
                'state'     => $this->state,
                'country'   => $this->country
            )
        );
    }
    
    public function getRecipient()
    {
        return $this->fname . ' ' . $this->lname;
    }

    public function isNotEqual($crefoAddress)
    {
        if ($this->street != $crefoAddress['street']) return true;
        if ($this->no != $crefoAddress['no']) return true;
        if ($this->zip != $crefoAddress['zip']) return true;
        if ($this->city != $crefoAddress['city']) return true;
        if ($this->state != $crefoAddress['state']) return true;
        if ($this->country != $crefoAddress['country']) return true;
        if ($this->type != $crefoAddress['type']) return true;
        if ($this->fname != $crefoAddress['fname']) return true;
        if ($this->lname != $crefoAddress['lname']) return true;
        return false;
    }

}