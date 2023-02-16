<?php

class exonn_boniversum_payment extends oxAdminDetails
{
    protected $_oListitemNew = null;
    protected $_oMyList = null;


    public function render()
    {
        parent::render();

           // $this->_aViewData["orderdone"] = $myConfig->getRequestParameter( 'orderdone' );

        $this->_aViewData["oPayments"] = $oPayments = oxNew("oxpaymentlist");
        $oPayments->selectString("select * from ".getViewName("oxpayments")." where boniversumsecuritypayment=0");

        $this->_aViewData["mylist"] = $this->getMyList();




        return "exonn_boniversum_payment.tpl";

    }


    public function getMyList()
    {
        if ($this->_oMyList === null) {
            $this->_oMyList = oxNew("oxlist");
            $this->_oMyList->init("exonn_boniversumpayments", "exonn_boniversumpayments");
            $this->_oMyList->getList();

        }

        return $this->_oMyList;
    }


    public function getListitemNew()
    {
        if ($this->_oListitemNew===null) {
            $this->_oListitemNew = oxNew("exonn_boniversumpayments");
        }

        return $this->_oListitemNew;

    }



    public function savepayment($oBoniversumPayment = null, $aParams = null, $aPayments=null)
    {
        $oConfig = $this->getConfig();
        if (!isset($oBoniversumPayment) && !isset($aParams)) {
            $aPayments = $oConfig->getRequestParameter("editval_payments");
            $aParams = $oConfig->getRequestParameter("editval");
            $oBoniversumPayment = $this->getListitemNew();
        }

        if ($aParams["exonn_boniversumpayments__oxadressvalidierung"]) {
            $aParams['exonn_boniversumpayments__oxadressvalidierung'] = implode(",", $aParams["exonn_boniversumpayments__oxadressvalidierung"]);
        } else {
            $aParams['exonn_boniversumpayments__oxadressvalidierung'] = "";
        }
        if ($aParams["exonn_boniversumpayments__oxpersonidentifikation"]) {
            $aParams['exonn_boniversumpayments__oxpersonidentifikation'] = implode(",", $aParams["exonn_boniversumpayments__oxpersonidentifikation"]);
        } else {
            $aParams["exonn_boniversumpayments__oxpersonidentifikation"] = "";
        }
        if ($aParams["exonn_boniversumpayments__scoreampel"]) {
            $aParams['exonn_boniversumpayments__scoreampel'] = implode(",", $aParams["exonn_boniversumpayments__scoreampel"]);
        } else {
            $aParams["exonn_boniversumpayments__scoreampel"] = "";
        }

        $oBoniversumPayment->assign($aParams);

        $oBoniversumPayment->save();

        oxdb::getDb()->execute("delete from exonn_boniversum2payments where oxboniversumid = ".oxdb::getDb()->quote($oBoniversumPayment->getId()));


        foreach ($aPayments as $sPaymentId) {
            $oPayments = oxNew("oxbase");
            $oPayments->init("exonn_boniversum2payments");
            $oPayments->assign(array(
                'exonn_boniversum2payments__oxboniversumid' => $oBoniversumPayment->getId(),
                'exonn_boniversum2payments__oxpaymentid' => $sPaymentId,
            ));
            $oPayments->save();

        }

        // reset
        $this->_oListitemNew = oxNew("exonn_boniversumpayments");

    }


    /**
     * Saves all article variants at once.
     */
    public function savepayments()
    {

        $aParams = $this->getConfig()->getRequestParameter("editval");
        $aPayments = $this->getConfig()->getRequestParameter("editval_payments");
        $oMyList = $this->getMyList();
        foreach($oMyList as $oBoniversumpayment) {
            $this->savepayment($oBoniversumpayment, $aParams[$oBoniversumpayment->getId()], $aPayments[$oBoniversumpayment->getId()]);
        }

    }

    public function deleteBoniversumPayment()
    {


        $soxId = $this->getConfig()->getRequestParameter("oxid");
        $oDelete = oxNew("exonn_boniversumpayments");
        $oDelete->delete($soxId);

        oxdb::getDb()->execute("delete from exonn_boniversum2payments where oxboniversumid = ".oxdb::getDb()->quote($soxId));


    }


}
