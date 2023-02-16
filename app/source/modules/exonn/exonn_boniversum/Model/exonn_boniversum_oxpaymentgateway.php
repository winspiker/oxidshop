<?php

class exonn_boniversum_oxpaymentgateway extends exonn_boniversum_oxpaymentgateway_parent
{

    public function executePayment($dAmount, & $oOrder)
    {
        $blRet = parent::executePayment($dAmount, $oOrder);

        if ($blRet ) {

            $oPayment = oxNew("oxpayment");
            $oPayment->load($this->_oPaymentInfo->oxuserpayments__oxpaymentsid->value);

            if (!$oPayment->oxpayments__boniversumsecuritypayment->value) {

                if ($oBasket = $this->getSession()->getBasket()) {

                    if ($oBasket->sPaymentTypeCheckBoniversum<>$oPayment->getId()) {
                        return false;
                    }

                } else {

                    return false;
                }

            }

        }


        return $blRet;

    }


}
