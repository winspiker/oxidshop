<?php

/**
 *  add to metadata.php in extend section: 'contact' => 'exonn_cb/core/cb_contact',
 **/ 
class cb_contact extends cb_contact_parent {

    public function getCbContent($cbid) {
        $exonn_cb_content = oxNew("exonn_cb_content");
        return $exonn_cb_content->getCbContent($cbid);
    }

    protected $_sActContIDForCB=null;


    public function getActContentIDForCB() {

        if ($this->_sActContIDForCB===null) {
            $this->_sActContIDForCB = "contact";
        }

        return $this->_sActContIDForCB;

    }

}
