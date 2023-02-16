<?php

/**
 *  add to metadata.php in extend section: 'oxdelivery' => 'exonn_deliveryext/core/exonn_delext_oxdelivery',
 **/ 
class exonn_delext_oxdelivery extends exonn_delext_oxdelivery_parent {

    public function isArticlesForBasket($oBasket)
    {
        // amount for conditional check
        $blHasArticles = $this->hasArticles();
        $blHasCategories = $this->hasCategories();
        $blUse = true;
        $iAmount = 0;
        $blForBasket = false;
        $articles = array();

        //echo $this->oxdelivery__oxtitle->value . "<br>";
        // category & article check
        if ($blHasCategories || $blHasArticles) {
            $blUse = false;

            $aDeliveryArticles = $this->getArticles();
            $aDeliveryCategories = $this->getCategories();

            foreach ($oBasket->getContents() as $oContent) {

                //V FS#1954 - load delivery for variants from parent article
                $oArticle = $oContent->getArticle(false);
                $sProductId = $oArticle->getProductId();
                $sParentId = $oArticle->getParentId();

                //echo "<b>" . $oArticle->oxarticles__oxtitle->value . "</b><br>";

                if ($blHasArticles && (in_array($sProductId, $aDeliveryArticles) || ($sParentId && in_array($sParentId, $aDeliveryArticles)))) {
                    $blUse = true;
                    $iArtAmount = $this->getDeliveryAmount($oContent);
                    //if ($this->getCalculationRule() != self::CALCULATION_RULE_ONCE_PER_CART) {
                        //echo "check is for basket: ";
                        if ($this->_isForArticle($oContent, $iArtAmount)) {
                            $blForBasket = true;
                            //echo "for basket" . "<br>";
                            $articles[] = $oArticle->getId();
                        } else {
                            //echo "no" . "<br>";
                        }
                    /*} else {
                        //echo "CALCULATION_RULE_ONCE_PER_CART" . "<br>";
                    }*/
                    if (!$blForBasket) {
                        $iAmount += $iArtAmount;
                    }

                } elseif ($blHasCategories) {

                    if (isset(self::$_aProductList[$sProductId])) {
                        $oProduct = self::$_aProductList[$sProductId];
                    } else {
                        $oProduct = oxNew('oxArticle');
                        $oProduct->setSkipAssign(true);

                        if (!$oProduct->load($sProductId)) {
                            continue;
                        }

                        $oProduct->setId($sProductId);
                        self::$_aProductList[$sProductId] = $oProduct;
                    }

                    foreach ($aDeliveryCategories as $sCatId) {

                        if ($oProduct->inCategory($sCatId)) {
                            $blUse = true;
                            $iArtAmount = $this->getDeliveryAmount($oContent);
                            //if ($this->getCalculationRule() != self::CALCULATION_RULE_ONCE_PER_CART) {
                                if ($this->_isForArticle($oContent, $iArtAmount)) {
                                    $blForBasket = true;
                                    //echo "for basket" . "<br>";
                                    $articles[] = $oArticle->getId();
                                }
                            //}
                            if (!$blForBasket) {
                                $iAmount += $iArtAmount;
                            }
                            //HR#5650 product might be in multiple rule categories, counting it once is enough
                            break;
                        }
                    }

                }
            }
            /*if ($blUse) {
                //echo "have used" . "<br>";
            } else {
                //echo "have no used" . "<br>";

            }*/
        } else {
            //echo "just check" . "<br>";
            // regular amounts check
            foreach ($oBasket->getContents() as $oContent) {
                $oArticle = $oContent->getArticle(false);
                //echo "<b>" . $oArticle->oxarticles__oxtitle->value . "</b><br>";
                $iArtAmount = $this->getDeliveryAmount($oContent);
                //if ($this->getCalculationRule() != self::CALCULATION_RULE_ONCE_PER_CART) {
                    if ($this->_isForArticle($oContent, $iArtAmount)) {
                        $blForBasket = true;
                        //echo "for basket" . "<br>";
                        $articles[] = $oArticle->getId();
                    }
                //}
                if (!$blForBasket) {
                    $iAmount += $iArtAmount;
                }
            }
        }

        /* if ( $this->getConditionType() == self::CONDITION_TYPE_PRICE ) {
             $iAmount = $oBasket->_getDiscountedProductsSum();
         }*/

        //#M1130: Single article in Basket, checked as free shipping, is not buyable (step 3 no payments found)
        if (!$blForBasket && $blUse && ($this->_checkDeliveryAmount($iAmount) || $this->_blFreeShipping)) {
            $blForBasket = true;
        }

        return $articles;
    }
}
