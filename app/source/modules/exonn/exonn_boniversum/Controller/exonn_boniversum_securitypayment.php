<?php

class exonn_boniversum_securitypayment extends oxAdminDetails
{


    public function render()
    {
        parent::render();

           // $this->_aViewData["orderdone"] = $myConfig->getRequestParameter( 'orderdone' );

        $this->_aViewData["mylist"] = $oPayments = oxNew("oxpaymentlist");
        $oPayments->selectString("select * from ".getViewName("oxpayments"));


        return "exonn_boniversum_securitypayment.tpl";

    }


    public function save()
    {

        $aBoniversumsecuritypayment = $this->getConfig()->getRequestParameter("boniversumsecuritypayment");
        if (!$aBoniversumsecuritypayment)
            $aBoniversumsecuritypayment = array();

        $oPayments = oxNew("oxpaymentlist");
        $oPayments->selectString("select * from ".getViewName("oxpayments"));
        foreach($oPayments as $oPayment) {
            $oPayment->assign(array('oxpayments__boniversumsecuritypayment' => $aBoniversumsecuritypayment[$oPayment->getId()]));
            $oPayment->save();
        }

        oxDb::getDb()->execute("delete from exonn_boniversum2payments where oxpaymentid in (select oxid from oxpayments where boniversumsecuritypayment = 1)");
    }


}
