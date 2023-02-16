<?php
/**
 *    This file is part of OXID eShop Community Edition.
 *
 *    OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @package   views
 * @copyright (C) OXID eSales AG 2003-2012
 * @version OXID eShop CE
 * @version   SVN: $Id: search.php 42364 2012-02-20 15:11:38Z linas.kukulskis $
 */

/**
 * Articles searching class.
 * Performs searching through articles in database.
 */
class exonnsearch extends search
{

    /**
     * Fetches search parameter from GET/POST/session, prepares search
     * SQL (search::GetWhere()), and executes it forming the list of
     * found articles. Article list is stored at search::_aArticleList
     * array.
     *
     * @return null
     */
    public function init()
    {
        parent::init();

        $myConfig = $this->getConfig();

        // #1184M - specialchar search
        $sSearchParamForQuery = oxRegistry::getConfig()->getRequestParameter( 'searchparam', true );

        // searching in category ?
        $sInitialSearchCat = $this->_sSearchCatId = rawurldecode( oxRegistry::getConfig()->getRequestParameter( 'searchcnid' ) );

        // searching in vendor #671
        $sInitialSearchVendor = $this->_sSearchVendor = rawurldecode( oxRegistry::getConfig()->getRequestParameter( 'searchvendor' ) );

        // searching in Manufacturer #671
        $sInitialSearchManufacturer = $this->_sSearchManufacturer = rawurldecode( oxRegistry::getConfig()->getRequestParameter( 'searchmanufacturer' ) );

        $this->_blEmptySearch = false;
        if ( !$sSearchParamForQuery && !$sInitialSearchCat && !$sInitialSearchVendor && !$sInitialSearchManufacturer ) {
            //no search string
            $this->_aArticleList = null;
            $this->_blEmptySearch = true;
            return false;
        }

        //@deprecated in v.4.5.7, since 2012-02-15; config option removed bug #0003385
        if ( !$myConfig->getConfigParam( 'bl_perfLoadVendorTree' ) ) {
            $sInitialSearchVendor = null;
        }

        // config allows to search in Manufacturers ?
        if ( !$myConfig->getConfigParam( 'bl_perfLoadManufacturerTree' ) ) {
            $sInitialSearchManufacturer = null;
        }

        /* EXONN */
        $myConfig->setConfigParam( 'aSearchExact',  $_REQUEST['type'] == 'JSON');
        $aSearchCols = $myConfig->getConfigParam( 'aSearchCols' );

        if ($_REQUEST['type'] == 'JSON') {
            $sort = getViewName('oxarticles') . '.oxtitle';
        } else {
            $sort = $this->getSortingSql( 'oxsearch' );
        }

        $oSearchHandler = oxNew('oxSearch');

        $oSearchList = $oSearchHandler->getSearchArticles( $sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sort );

        // list of found articles
        $this->_aArticleList = $oSearchList;
        $this->_iAllArtCnt    = 0;

        // skip count calculation if no articles in list found
        if ( $oSearchList->count() ) {
            $this->_iAllArtCnt = $oSearchHandler->getSearchArticleCount( $sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer );
        }

        foreach($oSearchList as $key => $article) {
            if($article->getStockStatus() == -1 or $article->_blNotBuyable) { //Wird auch im Template geprüft, darum hier Counter reduzieren sonst falsche Anzeige der Anzahl gefundener Artikel
                $this->_iAllArtCnt--;
                unset($oSearchList[$key]);
            }
        }

        $iNrofCatArticles = (int) $myConfig->getConfigParam( 'iNrofCatArticles' );
        $iNrofCatArticles = $iNrofCatArticles?$iNrofCatArticles:1;
        $this->_iCntPages  = round( $this->_iAllArtCnt / $iNrofCatArticles + 0.49 );
        $myConfig->setConfigParam( 'aSearchExact', 0 );
        $myConfig->setConfigParam( 'aSearchCols', $aSearchCols );
    }

    /**
     * Forms serach navigation URLs, executes parent::render() and
     * returns name of template to render search::_sThisTemplate.
     *
     * @return  string  current template file name
     */
    public function render()
    {
        parent::render();
        $myConfig = $this->getConfig();
        if ( $myConfig->getConfigParam( 'bl_rssSearch' ) ) {
            $oRss = oxNew('oxrssfeed');
            $sSearch = oxRegistry::getConfig()->getRequestParameter( 'searchparam', true );
            $sCnid = oxRegistry::getConfig()->getRequestParameter( 'searchcnid', true );
            $sVendor = oxRegistry::getConfig()->getRequestParameter( 'searchvendor', true );
            $sManufacturer = oxRegistry::getConfig()->getRequestParameter( 'searchmanufacturer', true );
            $this->addRssFeed($oRss->getSearchArticlesTitle($sSearch, $sCnid, $sVendor, $sManufacturer), $oRss->getSearchArticlesUrl($sSearch, $sCnid, $sVendor, $sManufacturer), 'searchArticles');
        }

        $result = array();


        if ($myConfig->getConfigParam('EXONN_LIVESEARCH_STATSAVE')) {

            oxDb::getDb()->execute("insert into exonn_livesearch set
                insertdate=now(),
                ip_address = ".oxDb::getDb()->quote($_SERVER["REMOTE_ADDR"]).",
                searchparam  = ".oxDb::getDb()->quote($sSearch)."
            ");


        }

        // processing list articles
        $this->_processListArticles();
        $str = strtolower(oxRegistry::getConfig()->getRequestParameter( 'searchparam', true ));

        $inStr = "";
        if($str) {
            foreach ($this->getSearchArticles($str,true) as $child) { //Die Varianten mit dem Suchbegriff finden
                $inStr .= "'" . $child->oxarticles__oxparentid->value . "',";
            }
            $inStr = rtrim($inStr,",");
            if($inStr != "") {
                $this->_aSearchArticleList = $this->getSearchArticles($str,$inStr);
            }
        }


        if ($_REQUEST['type'] == 'JSON') {

            foreach ($this->getArticleList() as $article) {
                if($article->getStockStatus() == -1 or $article->_blNotBuyable) continue;
                $res = array();
                $res["ico"] = $article->getIconUrl();
                $res["title"] = $article->oxarticles__oxtitle->value." ";
                if (($pos = strpos(strtolower($res["title"]), $str)) !== false) {
                    $res["title"] = substr($res["title"], 0, $pos ) . "<span>" . substr($res["title"], $pos, strlen($str))
                        . "</span>" . substr($res["title"], $pos + strlen($str), strlen($res["title"]));
                }
                $res["link"] = $article->getLink();
                $res["artnum"] = $article->oxarticles__oxartnum->value;
                if (strpos($res["artnum"], $str) !== false) {
                    $res["artnum"] = str_replace($str, "<span>" . $str . "</span>", $res["artnum"]);
                }
                $res["desc"] = $article->oxarticles__oxshortdesc->value;
                if ($res["desc"]) {
                    $res["desc"] = substr($res["desc"], 0, 50) . (strlen($res["desc"]) > 50 ? "..." : "");
                    if (($pos = strpos(strtolower($res["desc"]), $str)) !== false) {
                        $res["desc"] = substr($res["desc"], 0, $pos ) . "<span>" . substr($res["desc"], $pos, strlen($str))
                            . "</span>" . substr($res["desc"], $pos + strlen($str), strlen($res["desc"]));
                    }

                }

                $res["desc"] = utf8_encode($res["desc"]); //fix encoding errors

                $result[] = $res;
            }

            $inStr = "";
            foreach ($this->getSearchArticles($str,true) as $child) { //Die Varianten mit dem Suchbegriff finden
                $inStr .= "'" . $child->oxarticles__oxparentid->value . "',";
            }
            $inStr = rtrim($inStr,",");
            if($inStr != "") {
                foreach ($this->getSearchArticles($str, $inStr) as $child) { //Die zu den Varianten gehörigen Vaterartikel finden

                    if($child->getStockStatus() == -1 ) continue;
                    $res["ico"] = $child->getIconUrl();
                    $res["title"] = $child->oxarticles__oxtitle->value . " ";
                    if (($pos = strpos(strtolower($res["title"]), $str)) !== false) {
                        $res["title"] = substr($res["title"], 0, $pos) . "<span>" . substr($res["title"], $pos, strlen($str))
                            . "</span>" . substr($res["title"], $pos + strlen($str), strlen($res["title"]));
                    }
                    $res["link"] = $child->getLink();
                    $res["artnum"] = $child->oxarticles__oxartnum->value;
                    if (strpos($res["artnum"], $str) !== false) {
                        $res["artnum"] = str_replace($str, "<span>" . $str . "</span>", $res["artnum"]);
                    }
                    $res["desc"] = $child->oxarticles__oxshortdesc->value;
                    if ($res["desc"]) {
                        $res["desc"] = substr($res["desc"], 0, 50) . (strlen($res["desc"]) > 50 ? "..." : "");
                        if (($pos = strpos(strtolower($res["desc"]), $str)) !== false) {
                            $res["desc"] = substr($res["desc"], 0, $pos) . "<span>" . substr($res["desc"], $pos, strlen($str))
                                . "</span>" . substr($res["desc"], $pos + strlen($str), strlen($res["desc"]));
                        }

                    }
                    $res["desc"] = utf8_encode($res["desc"]); //fix encoding errors
                    $result[] = $res;
                }
            }

            header('Content-Type: application/json');
            echo $_GET['callback'] . '('.json_encode($result, JSON_PRETTY_PRINT) . ')';
            exit;
        } else {
            return $this->_sThisTemplate;
        }
    }

    /**
     * Article count getter
     *
     * @return int
     */
    public function getArticleCount()
    {
        return $this->_iAllArtCnt + count($this->_aSearchArticleList);
    }


    protected function _getCustomSearchSelect($sSearchParamForQuery = false, $sSearchChilds = false)
    {

        if (!$sSearchParamForQuery) {
            //no search string
            return null;
        }

        $sWhere = null;
        if ($sSearchParamForQuery) {
            if(!$sSearchChilds) {
                $sWhere = " oxid IN (".$sSearchChilds.")";
            } else {
                $sWhere = $this->_getWhere($sSearchParamForQuery);
            }
        }

        $oArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
        $sArticleTable = $oArticle->getViewName();
        $sSelectFields = $oArticle->getSelectFields();

        // longdesc field now is kept on different table
        $sDescJoin = $this->getDescriptionJoin($sArticleTable);

        //select articles
        $sSelect = "select {$sSelectFields}, {$sArticleTable}.oxtimestamp from {$sArticleTable} {$sDescJoin} where ";

        $sSelect .= $oArticle->getSqlActiveSnippet();
        if($sSearchChilds) {
            $sSelect .= " and {$sArticleTable}.oxparentid != '' and {$sArticleTable}.oxissearch = 1 ";
        } else {
            $sSelect .= " and {$sArticleTable}.oxparentid = '' and {$sArticleTable}.oxissearch = 1 ";
        }

        $sSelect .= $sWhere;

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
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
        $myConfig = $this->getConfig();
        $blSep = false;
        $sArticleTable = getViewName('oxarticles', $this->_iLanguage);

        $aSearchCols = $myConfig->getConfigParam('aSearchCols');
        if (!(is_array($aSearchCols) && count($aSearchCols))) {
            return '';
        }

        $sSearchSep = $myConfig->getConfigParam('blSearchUseAND') ? 'and ' : 'or ';
        $aSearch = explode(' ', $sSearchString);
        $sSearch = ' and ( ';
        $myUtilsString = \OxidEsales\Eshop\Core\Registry::getUtilsString();

        foreach ($aSearch as $sSearchString) {
            if (!strlen($sSearchString)) {
                continue;
            }

            if ($blSep) {
                $sSearch .= $sSearchSep;
            }

            $blSep2 = false;
            $sSearch .= '( ';

            foreach ($aSearchCols as $sField) {
                if ($blSep2) {
                    $sSearch .= ' or ';
                }

                // as long description now is on different table table must differ
                $sSearchField = $this->getSearchField($sArticleTable, $sField);

                $sSearch .= " {$sSearchField} like " . $oDb->quote("%$sSearchString%");

                // special chars ?
                if (($sUml = $myUtilsString->prepareStrForSearch($sSearchString))) {
                    $sSearch .= " or {$sSearchField} like " . $oDb->quote("%$sUml%");
                }

                $blSep2 = true;
            }
            $sSearch .= ' ) ';

            $blSep = true;
        }

        $sSearch .= ' ) ';

        return $sSearch;
    }

    /**
     * Get search field name.
     * Needed in case of searching for data in table oxartextends or its views.
     *
     * @param string $table
     * @param string $field Chose table depending on field.
     *
     * @return string
     */
    protected function getSearchField($table, $field)
    {
        if ($field == 'oxlongdesc') {
            $searchField = getViewName('oxartextends', $this->_iLanguage) . ".{$field}";
        } else {
            $searchField = "{$table}.{$field}";
        }
        return $searchField;
    }

    protected function getDescriptionJoin($table)
    {
        $descriptionJoin = '';
        $searchColumns = $this->getConfig()->getConfigParam('aSearchCols');

        if (is_array($searchColumns) && in_array('oxlongdesc', $searchColumns)) {
            $viewName = getViewName('oxartextends', $this->_iLanguage);
            $descriptionJoin = " LEFT JOIN {$viewName } ON {$table}.oxid={$viewName }.oxid ";
        }
        return $descriptionJoin;
    }

    public function getSearchArticleList() {
        return $this->_aSearchArticleList;
    }

    public function getSearchArticles($sSearchParamForQuery = false, $bSearchChilds = false)
    {
        // sets active page
        $this->iActPage = (int) \OxidEsales\Eshop\Core\Registry::getConfig()->getRequestParameter('pgNr');
        $this->iActPage = ($this->iActPage < 0) ? 0 : $this->iActPage;

        // load only articles which we show on screen
        //setting default values to avoid possible errors showing article list
        $iNrofCatArticles = $this->getConfig()->getConfigParam('iNrofCatArticles');
        $iNrofCatArticles = $iNrofCatArticles ? $iNrofCatArticles : 10;

        $oArtList = oxNew(\OxidEsales\Eshop\Application\Model\ArticleList::class);
        $oArtList->setSqlLimit($iNrofCatArticles * $this->iActPage, $iNrofCatArticles);

        $sSelect = $this->_getCustomSearchSelect($sSearchParamForQuery, $bSearchChilds);
        if ($sSelect) {
            $oArtList->selectString($sSelect);
        }
        $this->_aSearchArticleList = $oArtList;
        return $oArtList;
    }

}
