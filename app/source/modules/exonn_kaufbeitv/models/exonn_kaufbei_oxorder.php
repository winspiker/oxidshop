<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxorder extends exonn_kaufbei_oxorder_parent
{


    protected function _setPayment($sPaymentid)
    {
        $oUserpayment = parent::_setPayment($sPaymentid);

        if (!$oUserpayment) {
            return $oUserpayment;
        }

        $oPayment = oxNew(\OxidEsales\Eshop\Application\Model\Payment::class);

        if (!$oPayment->load($sPaymentid)) {
            return null;
        }


        $oUserpayment->oxpayments__installmentpayment = clone $oPayment->oxpayments__installmentpayment;

        return $oUserpayment;
    }


    protected function _insert()
    {

        if ($oPayment = $this->getPaymentMethodeOrder()) {
            if ($oPayment->oxpayments__installmentpayment->value) {
                $oSession = $this->getSession();
                $oBasket = $oSession->getBasket();
                $sum = $oBasket->getFirstinstallmentTotal();
                $this->oxorder__firstinstallment = new oxfield($sum, oxfield::T_RAW);
                $this->oxorder__is_paymentinstallment = new oxfield(1, oxfield::T_RAW);
                if ($sum<0.001) {
                    $oUtilsDate = Registry::getUtilsDate();
                    $this->oxorder__oxpaid = new oxfield(date('Y-m-d H:i:s', $oUtilsDate->getTime()), oxfield::T_RAW);
                }
            }
        }



        $blInsert = parent::_insert();

        return $blInsert;
    }


    public function getPaymentMethodeOrder() {
        if ($this->_oPaymentMethodeOrder===null) {

            $this->_oPaymentMethodeOrder = oxNew(oxpayment::class);
            $this->_oPaymentMethodeOrder->load($this->oxorder__oxpaymenttype->value);
        }


        return $this->_oPaymentMethodeOrder;

    }


}
