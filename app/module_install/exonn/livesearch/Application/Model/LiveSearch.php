<?php

namespace Exonn\LiveSearch\Application\Model;

use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\Request;
use OxidEsales\EshopCommunity\Application\Model\ArticleList;

/**
 * LiveSearch Model to allow searching for article variations
 */
class LiveSearch extends LiveSearch_parent
{
    /**
     * Returns the appropriate SQL select for a search according to search parameters
     *
     * @param string|false $sSearchParamForQuery       query parameter
     * @param string|false $sInitialSearchCat          initial category to search in
     * @param string|false $sInitialSearchVendor       initial vendor to search for
     * @param string|false $sInitialSearchManufacturer initial Manufacturer to search for
     * @param string|false $sSortBy                    sort by
     * @param string|bool  $sSearchChilds              whether to search for variants
     *
     * @return string|null
     */
    protected function _getSearchSelect( // phpcs:ignore PSR2.Methods.MethodDeclaration.Underscore
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false,
        $sSearchChilds = false
    ) {
        $sSelect = parent::_getSearchSelect($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sSortBy);
        if (null === $sSelect) {
            return null;
        }
        if ($sSearchChilds) {
            // Gather replacements for the original select statement.
            $aReplacements = [];
            $aReplacements += [
                '.oxparentid = \'\' and ' => '.oxparentid != \'\' and '
            ];
            // Modfiy the select statement.
            $sSelect = strtr($sSelect, $aReplacements);
        }
        return $sSelect;
    }

    /**
     * Returns a list of articles according to search parameters. Returns matched
     *
     * @param string|false $sSearchParamForQuery       query parameter
     * @param string|false $sInitialSearchCat          initial category to search in
     * @param string|false $sInitialSearchVendor       initial vendor to search for
     * @param string|false $sInitialSearchManufacturer initial Manufacturer to search for
     * @param string|false $sSortBy                    sort by
     * @param string|bool  $sSearchChilds              whether to search for variants
     *
     * @return ArticleList
     */
    public function getSearchArticles(
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false,
        $sSearchChilds = false
    ) {
        $oConfig = Registry::getConfig();
        $oRequest = Registry::get(Request::class);
        // sets active page
        $this->iActPage = (int) $oRequest->getRequestParameter('pgNr');
        $this->iActPage = ($this->iActPage < 0) ? 0 : $this->iActPage;

        // load only articles which we show on screen
        //setting default values to avoid possible errors showing article list
        $iNrofCatArticles = $oConfig->getConfigParam('iNrofCatArticles') ?: 10;

        $oArtList = oxNew(ArticleList::class);
        $oArtList->setSqlLimit($iNrofCatArticles * $this->iActPage, $iNrofCatArticles);

        // Exonn - added additional $sSearchChilds parameter to _getSearchSelect
        $sSelect = $this->_getSearchSelect($sSearchParamForQuery, $sInitialSearchCat, $sInitialSearchVendor, $sInitialSearchManufacturer, $sSortBy, $sSearchChilds);
        if ($sSelect) {
            $oArtList->selectString($sSelect);
        }

        return $oArtList;
    }
}
