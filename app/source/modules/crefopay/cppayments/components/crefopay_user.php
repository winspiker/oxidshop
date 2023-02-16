<?php

/**
 *  CrefoPay User
 */
class crefoPayUser
{
    // CrefoPay Person
    private $salutation;
    private $name;
    private $surname;
    private $dateOfBirth;
    private $email;
    private $phoneNumber;
    private $faxNumber;
    
    // CrefoPay Company
    private $companyName;
    private $companyRegisterType;
    private $companyRegistrationID;
    private $companyVatID;
    private $companyTaxID;
    
    // Additional Information
    private $isGuest;
    private $cpConfig;

    
    function init($oxUser) 
    {
        $this->cpConfig = oxNew('crefoPayConfig');
                
        // Guest or registered User
        $this->isGuest = !(0 < strlen($oxUser->oxuser__oxpassword->value));

        $oxsal             = clone $oxUser->oxuser__oxsal;
        $this->name        = clone $oxUser->oxuser__oxfname;
        $this->surname     = clone $oxUser->oxuser__oxlname;
        $this->dateOfBirth = clone $oxUser->oxuser__oxbirthdate;
        $this->email       = clone $oxUser->oxuser__oxusername;
        $this->phoneNumber = clone $oxUser->oxuser__oxfon;
        $this->faxNumber   = clone $oxUser->oxuser__oxfax;

        $this->companyName  = clone $oxUser->oxuser__oxcompany;
        $this->companyVatID = clone $oxUser->oxuser__oxustid;
        
        switch ($oxsal->value) {
            case "MR":
                $this->salutation = 'M';
                break;
            case "MRS":
                $this->salutation = 'F';
                break;
            default:
                $logger = oxNew('crefoPayLogger');
                $logger->log(1, __FILE__, "konnte Geschlecht nicht bestimmen fuer: " . $oxsal->value);
                $logger->log(1, __FILE__, "nutze stattdessen weiblich");
                $this->salutation = 'F';
                break;
        }
    }

    // Checks if User is a Company
    private function isCompany() 
    {
        if (strlen($this->companyName->value) > 0 && $this->cpConfig->B2Benabled())
        {
            return true;
        } else {
            return false;
        }
    }
    
    // Checks if User is Guest
    public function isGuest() 
    {
        return $this->isGuest;
    }
    
    public function getUserId() 
    {
        $ret = $this->email->value;
        // while B2B functionality is enabled, we use a suffix for userID
        if ($this->cpConfig->B2Benabled())
        {
            if ($this->isCompany())
            {
                $ret .= '_B2B';
            } else {
                $ret .= '_B2C';
            }
        }
        return md5($ret);
    }
    
    public function getUserType()
    {
        if ($this->isCompany() && $this->cpConfig->B2Benabled())
        {
            return 'BUSINESS';
        } else {
            return 'PRIVATE';
        }
    }
    
    public function getUserData() {
        // mandatory data
        $userData = array
            (
                'salutation'  => $this->salutation,
                'name'        => $this->name->value,
                'surname'     => $this->surname->value,
                'email'       => $this->email->value
            );
        // optional data
        if ($this->dateOfBirth->value != '0000-00-00')
        {
            $userData['dateOfBirth'] = $this->dateOfBirth->value;
        }
        
        if (sizeof($this->phoneNumber->value) > 1)
        {
            $userData['phoneNumber'] = $this->phoneNumber->value;
        }
        
        if (sizeof($this->faxNumber->value) > 1)
        {
            $userData['faxNumber'] = $this->faxNumber->value;
        }
        
        return json_encode($userData);
    }
    
    public function getCompanyData() {
        if ($this->isCompany())
        {
            return json_encode(array
                (
                    'companyName'  => $this->companyName->value,
                    'companyVatID' => $this->companyVatID->value
                )
            );
        } else
        {
            return null;
        }
    }

    public function dateOfBirthMissing() {
        if ($this->getUserType() === 'PRIVATE') {
            if ($this->dateOfBirth->value == '0000-00-00') {
                return true;
            } else if (strtotime($this->dateOfBirth->value) > time()) {
                return true;
            } else {
                return false;
            }
        }
    }
}