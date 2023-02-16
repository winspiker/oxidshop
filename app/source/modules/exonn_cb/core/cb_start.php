<?php
class cb_start extends cb_start_parent
{
    public function getCbContent($cbid) {
        $exonn_cb_content = oxNew("exonn_cb_content");
        return $exonn_cb_content->getCbContent($cbid);
    }

    protected $_sActContIDForCB=null;


    public function getActContentIDForCB() {

        if ($this->_sActContIDForCB===null) {
            $this->_sActContIDForCB = "start";
        }

        return $this->_sActContIDForCB;

    }

}