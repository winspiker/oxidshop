<?php

/**
 *  add to metadata.php in extend section: 'alist' => 'exonn_cb/core/cb_alist',
 **/ 
class cb_alist extends cb_alist_parent {
    protected $_sActContIDForCB=null;


    public function getActContentIDForCB() {

        if ($this->_sActContIDForCB===null) {
            $this->_sActContIDForCB = $this->getCategoryId();
        }

        return $this->_sActContIDForCB;

    }
}
