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

namespace Exonn\LiveSearch\Application\Controller;

use Exonn\LiveSearch\Application\Model\LiveSearch;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\DatabaseProvider;

/**
 * Articles searching class.
 * Performs searching through articles in database.
 */
class LiveSearchController extends \OxidEsales\Eshop\Application\Controller\SearchController
{
    protected $_aArticleList = null;
    protected $_aSearchArticleList = [];
    /** @var \OxidEsales\Eshop\Application\Model\Search $_oSearchHandler */
    protected $_oSearchHandler = null;
    protected $_aSearchHandlerParams = [];
    /** @var bool $_blIsJson */
    protected $_blIsJson = false;
    protected $_blIsDebug = false;

    /**
     * Fetches search parameter from GET/POST/session, prepares search
     * SQL (search::GetWhere()), and executes it forming the list of
     * found articles. Article list is stored at search::_aSearchArticleList
     * array.
     *
     * @return null
     */
    public function init()
    {
        parent::init();
        if ($this->_blEmptySearch) {
            return false;
        }
        $this->_blIsJson = isset($_REQUEST['type']) && strtoupper($_REQUEST['type']) == 'JSON';

        $myConfig = Registry::getConfig();

        // #1184M - specialchar search
        $sSearchParamForQuery = $myConfig->getRequestParameter('searchparam', true);
        // searching in category ?
        $sInitialSearchCat = $this->_sSearchCatId = rawurldecode(Registry::getConfig()->getRequestParameter('searchcnid'));
        // searching in vendor #671
        $sInitialSearchVendor = $this->_sSearchVendor = rawurldecode(Registry::getConfig()->getRequestParameter('searchvendor'));
        // searching in Manufacturer #671
        $sInitialSearchManufacturer = $this->_sSearchManufacturer = rawurldecode(Registry::getConfig()->getRequestParameter('searchmanufacturer'));

        // config allows to search in Manufacturers ?
        if (!$myConfig->getConfigParam('bl_perfLoadManufacturerTree')) {
            $sInitialSearchManufacturer = null;
        }

        /* EXONN */
        $blExactSearch = $myConfig->getConfigParam('aSearchExact');
        if ($this->_blIsJson) {
            if ($myConfig->getConfigParam('aSearchExact') !== true) {
                $myConfig->setConfigParam('aSearchExact', true);
            }
            $sort = getViewName('oxarticles') . '.oxtitle';
        } else {
            $sort = $this->getSortingSql('oxsearch');
        }

        $this->_oSearchHandler = oxNew(\OxidEsales\Eshop\Application\Model\Search::class);
        $this->_setSearchHandlerParams($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sort);
        // list of found articles
        $this->_aSearchArticleList = $this->_oSearchHandler->getSearchArticles($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sort);
        // skip count calculation if no articles in list found
        if ($this->_aSearchArticleList->count()) {
            $this->_iAllArtCnt = $this->_oSearchHandler->getSearchArticleCount($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer);
        }

        foreach ($this->_aSearchArticleList as $key => $article) {
            if ($article->getStockStatus() == 2 && $article->oxarticles__oxstock->value <= 0) {
                //Wird auch im Template geprüft, darum hier Counter reduzieren sonst falsche Anzeige der Anzahl gefundener Artikel
                $this->_iAllArtCnt--;
                unset($this->_aSearchArticleList[$key]);
            }
        }

        $iNrofCatArticles = (int) $myConfig->getConfigParam('iNrofCatArticles');
        $iNrofCatArticles = $iNrofCatArticles ? $iNrofCatArticles : 1;
        $this->_iCntPages  = round($this->_iAllArtCnt / $iNrofCatArticles + 0.49);

        if ($this->_blIsJson) {
            // Exakte Suche wieder auf den Ausgangswert stellen.
            if ($myConfig->getConfigParam('aSearchExact') !== $blExactSearch) {
                $myConfig->setConfigParam('aSearchExact', $blExactSearch);
            }
        }
    }

    /**
     * Forms serach navigation URLs, executes parent::render() and
     * returns name of template to render search::_sThisTemplate.
     *
     * @return  string  current template file name
     */
    public function render()
    {
        // Avoid retrieving request parameters again in favour of stored ones.
        list( $sSearch, $sCnid, $sVendor, $sManufacturer, $sSortBy ) = $this->_getSearchHandlerParams();

        $myConfig = $this->getConfig();
        $result = array();
        if ($myConfig->getConfigParam('EXONN_LIVESEARCH_STATSAVE')) {
            DatabaseProvider::getDb()->execute("insert into exonn_livesearch set
                insertdate=now(),
                ip_address = " . DatabaseProvider::getDb()->quote($_SERVER["REMOTE_ADDR"]) . ",
                searchparam  = " . DatabaseProvider::getDb()->quote($sSearch) . "
            ");
        }

        $this->log($_REQUEST);
        if ($this->_blIsJson) {
            foreach ($this->getArticleList() as $article) {
                if ($article->getStockStatus() == -1 or $article->_blNotBuyable) {
                    continue;
                }
                $res = array();
                $res["ico"] = $article->getIconUrl();
                $res["title"] = $article->oxarticles__oxtitle->value . " ";
                if (($pos = strpos(strtolower($res["title"]), $sSearch)) !== false) {
                    $res["title"] = substr($res["title"], 0, $pos) . "<span>" . substr($res["title"], $pos, strlen($sSearch))
                            . "</span>" . substr($res["title"], $pos + strlen($sSearch), strlen($res["title"]));
                }
                $res["link"] = $article->getLink();
                $res["artnum"] = $article->oxarticles__oxartnum->value;
                if (strpos($res["artnum"], $sSearch) !== false) {
                    $res["artnum"] = str_replace($sSearch, "<span>" . $sSearch . "</span>", $res["artnum"]);
                }
                $res["desc"] = $article->oxarticles__oxshortdesc->value;
                if ($res["desc"]) {
                    $res["desc"] = substr($res["desc"], 0, 50) . (strlen($res["desc"]) > 50 ? "..." : "");
                    if (($pos = strpos(strtolower($res["desc"]), $sSearch)) !== false) {
                        $res["desc"] = substr($res["desc"], 0, $pos) . "<span>" . substr($res["desc"], $pos, strlen($sSearch))
                                       . "</span>" . substr($res["desc"], $pos + strlen($sSearch), strlen($res["desc"]));
                    }
                }

                //fix encoding errors
                $res["desc"] = utf8_encode($res["desc"]);

                $result[] = $res;
            }

            header('Content-Type: application/json');
            echo $_GET['callback'] . '(' . json_encode($result) . ')';
            exit;
        }

        return parent::render();
    }


    /**
     * Utility method to store the search params per request
     *
     * @param string|false $sSearchParamForQuery       query parameter
     * @param string|false $sInitialSearchCat          initial category to search in
     * @param string|false $sInitialSearchVendor       initial vendor to search for
     * @param string|false $sInitialSearchManufacturer initial Manufacturer to search for
     * @param string|false $sSortBy                    sort by
     */
    protected function _setSearchHandlerParams(
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false
    ) {
        $this->_aSearchHandlerParams = func_get_args();
    }

    /**
     * Utility method to retrieve and possibly append the stored search params
     *
     * @param ...$append
     *
     * @return array
     */
    protected function _getSearchHandlerParams(...$append)
    {
        if ($append) {
            return array_merge($this->_aSearchHandlerParams, $append);
        }
        return $this->_aSearchHandlerParams;
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
