<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxpaymentlist extends exonn_kaufbei_oxpaymentlist_parent
{

    protected function _getFilterSelect($sShipSetId, $dPrice, $oUser)
    {
        $sQ = parent::_getFilterSelect($sShipSetId, $dPrice, $oUser);


        $oSession = $this->getSession();
        $oBasket = $oSession->getBasket();
        $oDb = oxDb::getDb();

        //ist auch noch notwendig für ratenzahlung
        $aArticleIds = array();
        $aArticleIdsWithVarianten = array();
        if ($oBasket) {
            foreach($oBasket->getContents() as $oBasketItem) {
                $oArticle = $oBasketItem->getArticle(false);
                $aArticleIdsWithVarianten[] = $oDb->quote($oBasketItem->getArticle(false)->getId());
                if ($oArticle->oxarticles__oxparentid->value) {
                    $aArticleIds[] = $oDb->quote($oArticle->oxarticles__oxparentid->value);
                } else {
                    $aArticleIds[] = $oDb->quote($oBasketItem->getArticle(false)->getId());
                }
            }


            // wenn kein artikel mit ratenzahlunggibt, dann darf diese Zahlungsart nicht verwendet werden
            if (!$aArticleIds || !$oDb->getOne("select oxid from oxarticles where numberinstallments>0 && oxid in (" . implode(", ", $aArticleIdsWithVarianten) . ") ")) {
                $sTable = getViewName('oxpayments');
                $sQ = str_replace(" {$sTable}.oxactive='1' ", " {$sTable}.oxactive='1' AND {$sTable}.installmentpayment=0 ", $sQ);
            }


            // wenn in warenkorb ein Artikel liegt, wo keine nachnahme verwendet werden darf
            if (count($aArticleIds) > 0) {
                if ($oDb->getOne("select oxid from oxarticles where isnotcod=1 && oxid in (" . implode(", ", $aArticleIds) . ") limit 1 ")) {
                    $sQ = str_replace(" {$sTable}.oxactive='1' ", " {$sTable}.oxactive='1' && " . $sTable . ".dhliscod=0 ", $sQ);
                }
            }
        }



        //usergruppe ausschlissen
        $sGroupIds  = '';
        if ( $oUser ) {
            // user groups ( maybe would be better to fetch by function oxuser::getUserGroups() ? )
            foreach ( $oUser->getUserGroups() as $oGroup ) {
                if ( $sGroupIds ) {
                    $sGroupIds .= ', ';
                }
                $sGroupIds .= "'".$oGroup->getId()."'";
            }
        }
        if ($sGroupIds) {
            $sTable = getViewName('oxpayments');
            $sQ = str_replace(" {$sTable}.oxactive='1' ", " {$sTable}.oxactive='1'  and {$sTable}.exclude_group not in ( {$sGroupIds} ) ", $sQ);
        }


        return $sQ;
    }


}
