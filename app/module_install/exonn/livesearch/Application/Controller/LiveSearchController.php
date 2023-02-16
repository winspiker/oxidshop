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

use Exception;
use Exonn\Connector\Framework\ForwardCompatibility;
use Exonn\LiveSearch\Application\Model\LiveSearch;
use OxidEsales\Eshop\Application\Model\RssFeed;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\Request;
use OxidEsales\Eshop\Core\TableViewNameGenerator;
use OxidEsales\EshopCommunity\Internal\Container\ContainerFactory;
use OxidEsales\EshopCommunity\Internal\Framework\Database\QueryBuilderFactoryInterface;

/**
 * Articles searching class.
 * Performs searching through articles in database.
 */
class LiveSearchController extends \OxidEsales\Eshop\Application\Controller\SearchController
{
    protected $_aArticleList = null;
    protected $_aSearchArticleList = [];
    protected $_oSearchHandler = null;
    protected $_aSearchHandlerParams = [];

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
        $oConfig = Registry::getConfig();
        $oRequest = Registry::get(Request::class);

        // #1184M - specialchar search
        $sSearchParamForQuery = trim($oRequest->getRequestParameter('searchparam'));
        // searching in category ?
        $sInitialSearchCat = $this->_sSearchCatId
            = rawurldecode($oRequest->getRequestEscapedParameter('searchcnid'));
        // searching in vendor #671
        $sInitialSearchVendor = $this->_sSearchVendor
            = rawurldecode($oRequest->getRequestEscapedParameter('searchvendor'));
        // searching in Manufacturer #671
        $sInitialSearchManufacturer = $this->_sSearchManufacturer
            = rawurldecode($oRequest->getRequestEscapedParameter('searchmanufacturer'));

        $this->_blEmptySearch = false;
        if (!$sSearchParamForQuery && !$sInitialSearchCat && !$sInitialSearchVendor && !$sInitialSearchManufacturer) {
        //no search string
            $this->_aArticleList = null;
            $this->_blEmptySearch = true;
            return;
        }

        //@deprecated in v.4.5.7, since 2012-02-15; config option removed bug #0003385
        if (!$oConfig->getConfigParam('bl_perfLoadVendorTree')) {
            $sInitialSearchVendor = null;
        }

        // config allows to search in Manufacturers ?
        if (!$oConfig->getConfigParam('bl_perfLoadManufacturerTree')) {
            $sInitialSearchManufacturer = null;
        }

        /* EXONN */
        $isJsonRequest = 'JSON' === $_REQUEST['type'];
        if ($isJsonRequest) {
            $oConfig->setConfigParam('aSearchExact', $isJsonRequest);
            $oViewNameGenerator = Registry::get(TableViewNameGenerator::class);
            $sSort = $oViewNameGenerator->getViewName('oxarticles') . '.oxtitle';
        } else {
            $sSort = $this->getSortingSql('oxsearch');
        }

        $this->_oSearchHandler = oxNew(LiveSearch::class);
        $this->_setSearchHandlerParams($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sSort);
        // list of found articles
        $this->_aSearchArticleList = $this->_oSearchHandler->getSearchArticles($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sSort);
        // skip count calculation if no articles in list found
        if ($this->_aSearchArticleList->count()) {
            $this->_iAllArtCnt = $this->_oSearchHandler->getSearchArticleCount($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer);
        }

        foreach ($this->_aSearchArticleList as $key => $article) {
            if ($article->getStockStatus() == -1 or $article->_blNotBuyable) {
                //Wird auch im Template geprüft, darum hier Counter reduzieren sonst falsche Anzeige der Anzahl gefundener Artikel
                $this->_iAllArtCnt--;
                unset($this->_aSearchArticleList[$key]);
            }
        }

        $iNrofCatArticles = (int) $oConfig->getConfigParam('iNrofCatArticles') ?: 1;
        $this->_iCntPages = round($this->_iAllArtCnt / $iNrofCatArticles + 0.49);

        $oConfig->setConfigParam('aSearchExact', 0);
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
        // Avoid retrieving request parameters again in favour of stored ones.
        list( $sSearch, $sCnid, $sVendor, $sManufacturer, $sSortBy ) = $this->_getSearchHandlerParams();

        $oConfig = Registry::getConfig();
        if ($oConfig->getConfigParam('bl_rssSearch')) {
            $oRss = oxNew(RssFeed::class);
            $this->addRssFeed($oRss->getSearchArticlesTitle($sSearch, $sCnid, $sVendor, $sManufacturer), $oRss->getSearchArticlesUrl($sSearch, $sCnid, $sVendor, $sManufacturer), 'searchArticles');
        }

        $result = array();
        if ($oConfig->getConfigParam('EXONN_LIVESEARCH_STATSAVE')) {
            $oContainer = ContainerFactory::getInstance()->getContainer();
            $oQueryBuilderFactory = $oContainer->get(QueryBuilderFactoryInterface::class);
            try {
                $oQueryBuilder = $oQueryBuilderFactory->create();
                $oQueryBuilder
                    ->insert('exonn_livesearch')
                    ->values([
                         'ip_address'  => ':ipAddress',
                         'searchparam' => ':searchParam',
                     ])
                    ->setParameters([
                        'ipAddress'   => $_SERVER['REMOTE_ADDR'],
                        'searchParam' => $sSearch,
                    ]);
                $oQueryBuilder->execute();
            } catch (Exception $oException) {
            }
        }

        // _processListArticles wird in den nächsten Oxid-Versionen umbenannt
        ForwardCompatibility::maybeCallMethod($this,  'processListArticles', '_processListArticles');

        $inStr = "";
        if ($sSearch) {
            // Find variants matching the search query.
            $oArticleList = $this->_oSearchHandler->getSearchArticles(...$this->_getSearchHandlerParams(true));
            foreach ($oArticleList as $child) {
                $inStr .= "'" . $child->oxarticles__oxparentid->value . "',";
            }
            $inStr = rtrim($inStr, ",");
            if ($inStr != "") {
                $this->_aSearchArticleList = $this->_oSearchHandler->getSearchArticles(...$this->_getSearchHandlerParams($inStr));
            }
        }

        $isJsonRequest = 'JSON' === $_REQUEST['type'];
        if ($isJsonRequest) {
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

            $inStr = "";
            $oArticleList = $this->_oSearchHandler->getSearchArticles(...$this->_getSearchHandlerParams(true));
            foreach ($oArticleList as $child) {
            //Die Varianten mit dem Suchbegriff finden
                $inStr .= "'" . $child->oxarticles__oxparentid->value . "',";
            }
            $inStr = rtrim($inStr, ",");
            if ($inStr != "") {
                $oArticleList = $this->_oSearchHandler->getSearchArticles(...$this->_getSearchHandlerParams($inStr));
                //Die zu den Varianten gehörigen Vaterartikel finden
                foreach ($oArticleList as $child) {
                    if ($child->getStockStatus() == -1) {
                        continue;
                    }
                    $res["ico"] = $child->getIconUrl();
                    $res["title"] = $child->oxarticles__oxtitle->value . " ";
                    if (($pos = strpos(strtolower($res["title"]), $sSearch)) !== false) {
                            $res["title"] = substr($res["title"], 0, $pos) . "<span>" . substr($res["title"], $pos, strlen($sSearch))
                                        . "</span>" . substr($res["title"], $pos + strlen($sSearch), strlen($res["title"]));
                    }
                    $res["link"] = $child->getLink();
                    $res["artnum"] = $child->oxarticles__oxartnum->value;
                    if (strpos($res["artnum"], $sSearch) !== false) {
                                $res["artnum"] = str_replace($sSearch, "<span>" . $sSearch . "</span>", $res["artnum"]);
                    }
                    $res["desc"] = $child->oxarticles__oxshortdesc->value;
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
            }

            header('Content-Type: application/json');
            echo $_GET['callback'] . '(' . json_encode($result, JSON_PRETTY_PRINT) . ')';
            exit;
        } else {
            return $this->_sThisTemplate;
        }
    }

    /**
     * Template variable getter. Returns search parameter for Html
     *
     * @return string
     */
    public function getSearchParamForHtml()
    {
        if (null === $this->_sSearchParamForHtml) {
            $oRequest = Registry::get(Request::class);
            $this->_sSearchParamForHtml = trim($oRequest->getRequestParameter('searchparam'));
        }

        return $this->_sSearchParamForHtml;
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
    protected function _setSearchHandlerParams($sSearchParamForQuery = false, $sInitialSearchCat = false, $sInitialSearchVendor = false, $sInitialSearchManufacturer = false, $sSortBy = false)
    {
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
}
