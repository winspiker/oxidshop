<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_oxemail extends exonn_order_oxemail_parent
{

    public function sendStockReminder( $aBasketContents, $sSubject = null )
    {
        $oShop = $this->_getShop();

        $oldOwnerEmail = $oShop->oxshops__oxowneremail->value;

        if ($oShop->oxshops__oxstockemail->value)
            $oShop->oxshops__oxowneremail->value = $oShop->oxshops__oxstockemail->value;

        $blSend = parent::sendStockReminder( $aBasketContents, $sSubject );

        $oShop->oxshops__oxowneremail->value = $oldOwnerEmail;


        return $blSend;
    }




}
