<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxactions extends exonn_kaufbei_oxactions_parent
{


    public function loadbadgeForArticle($sArticleId)
    {
        $sDate = date('Y-m-d H:i:s', oxRegistry::get("oxUtilsDate")->getTime());

        $oDb = oxDb::getDb();
        $sOxid = $oDb->getOne("select oxactions.oxid from oxactions join oxactions2article on (oxactions2article.oxactionid=oxactions.oxid) where oxactions.oxtype=4 and (oxactions.oxactive=1 or oxactions.oxactiveto > " . $oDb->quote($sDate) . " and oxactions.oxactivefrom < " . $oDb->quote($sDate) . ") and oxactions.oxshopid='" . $this->getConfig()->getShopId() . "' && oxactions2article.oxartid=".$oDb->quote($sArticleId));

        if (!$sOxid)
            return;



        $this->load($sOxid);


    }




}
