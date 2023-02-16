<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_alist extends exonn_kaufbei_alist_parent
{
    protected $_oBadgeList = null;
    protected $_oArticleTimer = null;
    protected $_sTimerTo = null;


    public function getBadgeList()
    {
        if ($this->_oBadgeList===null) {

            $this->_oBadgeList = oxNew("oxactionlist");
            $this->_oBadgeList->loadBadge();

        }

        return $this->_oBadgeList;

    }



    public function getArticleTimer()
    {

        if ($this->_oArticleTimer===null) {

            $this->_oArticleTimer = false;
            $this->_sTimerTo = false;

            $sDate = date('Y-m-d H:i:s', oxRegistry::get("oxUtilsDate")->getTime());

            $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
            $aRow = $oDb->getRow("select oxactions2article.oxartid, oxactions.oxactiveto from oxactions join oxactions2article on (oxactions2article.oxactionid=oxactions.oxid) where oxactions.oxtype=5 and (oxactions.oxactive=1 or oxactions.oxactiveto > " . $oDb->quote($sDate) . " and oxactions.oxactivefrom < " . $oDb->quote($sDate) . ") and oxactions.oxshopid='" . $this->getConfig()->getShopId() . "' ");




	        $this->_oArticleTimer = oxNew("oxarticle");
	        // wenn kein Artikel ermittelbar ist, gebe leeres artikel objekt zurück, damit der shop nicht abstürzt.. :P
            if (!$aRow)
            {
                return $this->_oArticleTimer;
            }


//            $this->_oArticleTimer = oxNew("oxarticle");
            $this->_oArticleTimer->load($aRow["oxartid"]);
            $this->_sTimerTo = $aRow["oxactiveto"];
        }

        return $this->_oArticleTimer;
    }

    public function getArticleTimerTo()
    {
        if ($this->_sTimerTo===null) {
            $this->getArticleTimer();
        }

        return $this->_sTimerTo;
    }



}
