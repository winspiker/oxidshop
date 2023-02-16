<?php
class cb_details extends cb_details_parent
{
    protected $_sActContIDForCB=null;


    public function getActContentIDForCB() {

        if ($this->_sActContIDForCB===null) {
            $this->_sActContIDForCB = $this->getProduct()->getId();
        }

        return $this->_sActContIDForCB;
        
    }


}