<?php

class exonn_boniversum_extend_oxpaymentlist extends exonn_boniversum_extend_oxpaymentlist_parent
{

    protected function _getFilterSelect($sShipSetId, $dPrice, $oUser)
    {
        $sQ = parent::_getFilterSelect($sShipSetId, $dPrice, $oUser);

        if ($oBasket = $this->getSession()->getBasket()) {
            if ($oBasket->blOnlySecurePayment || $this->getSession()->getVariable('deladrid') || $this->getConfig()->getRequestParameter('deladrid')) {
                $sTable = getViewName('oxpayments');
                $sQ = str_replace(" {$sTable}.oxactive='1' ", " {$sTable}.oxactive='1' AND {$sTable}.boniversumsecuritypayment='1' ", $sQ);
            }
        }

        return $sQ;
    }

}
