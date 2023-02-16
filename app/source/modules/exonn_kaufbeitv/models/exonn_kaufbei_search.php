<?php

class exonn_kaufbei_search extends exonn_kaufbei_search_parent
{

    protected $isArtNumSearch = false;
    protected $iArtListCnt = 0;
    protected $_blIsDebug = false;

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
        $this->determineArticleSearch($sSelect, $sSearchParamForQuery);

        return parent::getSearchArticles(...func_get_args());
    }

    /**
     * Bestimmt ob es sich um eine Artikelsuche handelt
     *
     * @param string $sSelect
     * @param string $sSearchParamForQuery
     */
    protected function determineArticleSearch($sSelect, $sSearchParamForQuery)
    {
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC);
        $rs = $oDb->select($sSelect, []);
        // Durchsucht alle Artikelnummern der Ergebnisse nach der Suchanfrage um festzustellen ob es sich um eine Artikelsuche handelt.
        if ($rs != false && $rs->count() > 0) {
            while (!$rs->EOF) {
                if (isset($rs->fields['OXARTNUM']) && $rs->fields['OXARTNUM'] === $sSearchParamForQuery) {
                    $this->isArtNumSearch = true;
                    break;
                }
                $rs->fetchRow();
            }
        }
    }

    /**
     * Returns the appropriate SQL select for a search according to search parameters
     *
     * @param string $sSearchParamForQuery       query parameter
     * @param string $sInitialSearchCat          initial category to search in
     * @param string $sInitialSearchVendor       initial vendor to search for
     * @param string $sInitialSearchManufacturer initial Manufacturer to search for
     * @param string $sSortBy                    sort by
     *
     * @return string
     */
    protected function _getSearchSelect(
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false
    ) {
        $sSelect = parent::_getSearchSelect(...func_get_args());
        // Wir benötigen immer auch die Artikelnummer im Select-Statement
        $aParts = explode(' from ', strtr($sSelect, [' FROM ' => ' from ']), 2);
        if ($aParts) {
            if (
                false === stripos($aParts[0], 'oxartnum')
                && preg_match('/oxv_oxarticles.+?\b/i', $aParts[0], $aMatches)
            ) {
                list( $sViewName ) = $aMatches;
                $aParts[0] .= ", `$sViewName`.`oxartnum`";
            }

            // Da auch Varianten angezeigt werden, muss der Min- und Max-Preis
            // für die Varianten auf deren Preis angepasst werden, damit die
            // Sortierung funktioniert
            if (
                false !== strpos($sSortBy, 'oxvarminprice')
                || false !== strpos($sSortBy, 'oxvarmaxprice')
            ) {
                $aParts[0] = preg_replace(
                    '/((`oxv_oxarticles[^`]+`).`(oxvar(?:min|max)price)`),/',
                    'IF($2.`oxparentid` != \'\', $2.`oxprice`, $1) as \'$3\',',
                    $aParts[0]
                );
            }

            $sSelect = implode(' from ', $aParts);
        }
        return $sSelect;
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
            $sWhere = ' and `oxartnum` LIKE ' . $oDb->quote("$sSearchString%");
        } else {
            $sWhere = parent::_getWhere(...func_get_args());
        }
        return $sWhere;
    }

    /**
     * Utility logging Method
     */
    private function log()
    {
        if (!$this->_blIsDebug) {
            return;
        }
        $sPayload = json_encode(func_get_args());
        $sHash = md5($sPayload);
        error_log(date('c').': (' . $sHash . ') '.$sPayload.PHP_EOL, 3, 'log/kaufbei_search_debug.log');
    }
}
