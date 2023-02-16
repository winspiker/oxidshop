<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxactionlist extends exonn_kaufbei_oxactionlist_parent
{


    public function loadBadge($sArticleId = null)
    {
        $sViewName = $this->getBaseObject()->getViewName();
        $sDate = date('Y-m-d H:i:s', oxRegistry::get("oxUtilsDate")->getTime());
        $oDb = oxDb::getDb();
        $sQ = "select * from {$sViewName} where oxtype=4 and (oxactive=1 or oxactiveto > " . $oDb->quote($sDate) . " and oxactivefrom < " . $oDb->quote($sDate) . ") and oxshopid='" . $this->getConfig()->getShopId() . "'".
            (($sArticleId) ? " and oxid in (select oxactionid from oxactions2article where oxartid=".$oDb->quote($sArticleId).")" : "")."

               order by oxactiveto, oxactivefrom";

        $this->selectString($sQ);
    }


}
