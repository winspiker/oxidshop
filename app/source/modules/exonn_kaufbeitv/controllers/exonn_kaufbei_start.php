<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_start extends exonn_kaufbei_start_parent
{
    protected $_oStartCatList = null;
    protected $_oArticleTimer = null;
    protected $_sTimerTo = null;
    protected $_sTimerToStamp = null;

	public function getTopMenuCategories()
	{
		$db = oxdb::getDb(2);

		$topMenuCategoriesQuery =
			'
	        SELECT 
            		oxid 
	        from
	        		oxcategories
			where 
					oxtopmenu = 1
	    ';


		$topMenuCategoriesResult = $db->getAll($topMenuCategoriesQuery);


		$topMenuItems = [];

		foreach($topMenuCategoriesResult as $topMenuCategory)
		{
			$categoryItem = oxNew('oxcategory');
			$categoryItem->load($topMenuCategory['oxid']);
			$topMenuItems[] = $categoryItem;
		}

		return $topMenuItems;

	}


	public function getBadgeList()
    {
        if ($this->_oBadgeList===null) {

            $this->_oBadgeList = oxNew("oxactionlist");
            $this->_oBadgeList->loadBadge();

        }

        return $this->_oBadgeList;

    }


    public function getStartCategories()
    {
        if ($this->_oStartCatList===null) {

            $this->_oStartCatList = oxNew("oxcategorylist");
            $this->_oStartCatList->loadStartCategories();

        }

        return $this->_oStartCatList;

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


            #$this->_oArticleTimer = oxNew("oxarticle");
            $this->_oArticleTimer->load($aRow["oxartid"]);
            $this->_sTimerTo = $aRow["oxactiveto"];
            $this->_sTimerToStamp = strtotime($aRow["oxactiveto"]);
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

    public function getArticleTimerToStamp()
    {
        if ($this->_sTimerToStamp===null) {
            $this->getArticleTimer();
        }

        return $this->_sTimerToStamp;
    }


}
