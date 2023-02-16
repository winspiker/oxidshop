<?php

class exonn_kaufbei_search extends exonn_kaufbei_search_parent
{

    protected $isArtNumSearch = false;
    protected $iArtListCnt = 0;
    protected $isDebug = true;

    /**
     * Returns a list of articles according to search parameters. Returns matched
     *
     * @param string $sSearchParamForQuery       query parameter
     * @param string $sInitialSearchCat          initial category to seearch in
     * @param string $sInitialSearchVendor       initial vendor to seearch for
     * @param string $sInitialSearchManufacturer initial Manufacturer to seearch for
     * @param string $sSortBy                    sort by
     *
     * @return ArticleList
     */
    public function getSearchArticles(
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false
    ) {
        // Suchanfrage ohne Limit
        $sSelect = $this->_getSearchSelect($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sSortBy);
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC);
        $rs = $oDb->select($sSelect, []);
        if ($rs != false && $rs->count() > 0) {
            while (!$rs->EOF) {
                if (isset($rs->fields['OXARTNUM']) && $rs->fields['OXARTNUM'] === $sSearchParamForQuery) {
                    $this->isArtNumSearch = true;
                    break;
                }
                $rs->fetchRow();
            }
        }
        $this->isDebug && error_log(json_encode([$this->isArtNumSearch, $sSearchParamForQuery]).PHP_EOL, 3, 'log/kaufbei_search_debug.log');

        return parent::getSearchArticles(...func_get_args());
    }

    /**
     * Forms and returns SQL query string for search in DB.
     *
     * @param string $sSearchString searching string
     *
     * @return string
     */
    protected function _getWhere($sSearchString)
    {
        if ($this->isArtNumSearch) {
            $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
            $sWhere = ' and OXARTNUM LIKE ' . $oDb->quote("$sSearchString%");
        } else {
            $sWhere = parent::_getWhere(...func_get_args());
        }
        $this->isDebug && error_log(json_encode([__LINE__,$sWhere]).PHP_EOL, 3, 'log/kaufbei_search_debug.log');
        return $sWhere;
    }

    /**
     * Gibt an, ob es sich um eine Artikelnummer Suche handelt
     * 
     * @param \OxidEsales\Eshop\Application\Model\ArticleList $oArtList
     * @param string $sSearchParamForQuery
     * 
     * @return bool
     */
    protected function isArtNumSearch($oArtList, $sSearchParamForQuery): bool
    {
        if (!$this->isArtNumSearch && is_numeric($sSearchParamForQuery)) {
            foreach ($oArtList as $oArticle) {
                if ($sSearchParamForQuery === $oArticle->oxarticles__oxartnum->value) {
                    $this->isArtNumSearch = true;
                    break;
                }
            }
        }
        return $this->isArtNumSearch;
    }

    /**
     * Entfernt alle Artikel, die nicht der gegebenen Artikelnummer angehören
     * 
     * @param \OxidEsales\Eshop\Application\Model\ArticleList $oArtList
     * @param string $sNum
     * 
     * @return \OxidEsales\Eshop\Application\Model\ArticleList
     */
    protected function listOnlyArtNum(
        \OxidEsales\Eshop\Application\Model\ArticleList $oArtList,
        string $sNum
    ): \OxidEsales\Eshop\Application\Model\ArticleList {
        foreach ($oArtList as $iIndex => $oArticle) {
            if (0 !== strpos($oArticle->oxarticles__oxartnum->value, $sNum)) {
                unset($oArtList[$iIndex]);
            }
        }
        return $oArtList;
    }
}