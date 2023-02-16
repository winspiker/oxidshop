<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxbasket extends exonn_kaufbei_oxbasket_parent
{
    public function getFirstinstallmentTotal()
    {
        $firstinstallment = $this->getPrice()->getBruttoPrice();
        foreach ($this->_aBasketContents as $oBasketItem) {
            $oArticle = $oBasketItem->getArticle();
            if ( $oArticle->oxarticles__numberinstallments->value>0) {
                $firstinstallment-=$oBasketItem->getPrice()->getBruttoPrice() - $oArticle->oxarticles__firstinstallment->value*$oBasketItem->getAmount();
            }
        }

        return $firstinstallment;
    }

}
