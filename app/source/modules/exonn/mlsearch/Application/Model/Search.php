<?php

namespace Exonn\MultilangualSearch\Application\Model;

use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\ViewConfig;
use OxidEsales\Eshop\Application\Model\Article;

class Search extends Search_parent
{

    /**
     * Returns the appropriate SQL select for a search according to search parameters
     *
     * @param string|false $sSearchParamForQuery       query parameter
     * @param string|false $sInitialSearchCat          initial category to search in
     * @param string|false $sInitialSearchVendor       initial vendor to search for
     * @param string|false $sInitialSearchManufacturer initial Manufacturer to search for
     * @param string|false $sSortBy                    sort by
     *
     * @return string|null
     */
    protected function _getSearchSelect( // phpcs:ignore PSR2.Methods.MethodDeclaration.Underscore
        $sSearchParamForQuery = false,
        $sInitialSearchCat = false,
        $sInitialSearchVendor = false,
        $sInitialSearchManufacturer = false,
        $sSortBy = false
    ) {
        if (!$sSearchParamForQuery && !$sInitialSearchCat && !$sInitialSearchVendor && !$sInitialSearchManufacturer) {
            //no search string
            return null;
        }

        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();

        // performance
        if ($sInitialSearchCat) {
            // lets search this category - is no such category - skip all other code
            $oCategory = oxNew(\OxidEsales\Eshop\Application\Model\Category::class);
            $sCatTable = $oCategory->getViewName();

            $sQ = "select 1 from $sCatTable 
                where $sCatTable.oxid = :oxid ";
            $sQ .= "and " . $oCategory->getSqlActiveSnippet();

            $params = [
                ':oxid' => $sInitialSearchCat
            ];

            if (!$oDb->getOne($sQ, $params)) {
                return;
            }
        }

        // performance:
        if ($sInitialSearchVendor) {
            // lets search this vendor - if no such vendor - skip all other code
            $oVendor = oxNew(\OxidEsales\Eshop\Application\Model\Vendor::class);
            $sVndTable = $oVendor->getViewName();

            $sQ = "select 1 from $sVndTable 
                where $sVndTable.oxid = :oxid ";
            $sQ .= "and " . $oVendor->getSqlActiveSnippet();

            $params = [
                ':oxid' => $sInitialSearchVendor
            ];

            if (!$oDb->getOne($sQ, $params)) {
                return;
            }
        }

        // performance:
        if ($sInitialSearchManufacturer) {
            // lets search this Manufacturer - if no such Manufacturer - skip all other code
            $oManufacturer = oxNew(\OxidEsales\Eshop\Application\Model\Manufacturer::class);
            $sManTable = $oManufacturer->getViewName();

            $sQ = "select 1 from $sManTable 
                where $sManTable.oxid = :oxid ";
            $sQ .= "and " . $oManufacturer->getSqlActiveSnippet();

            $params = [
                ':oxid' => $sInitialSearchManufacturer
            ];

            if (!$oDb->getOne($sQ, $params)) {
                return;
            }
        }

        /**@#+
         * EXONN
         */
        // Determine available languages.
        $oLanguage = Registry::getLang();
        $iLanguageBase = $oLanguage->getBaseLanguage();

        // Only search in languages that are enabled.
        $aLanguages = $oLanguage->getLanguageArray( null, true );
        // Selected language will have the highest priority.
        usort(
            $aLanguages,
            function( $oLanguage_a, $oLanguage_b ) {
                return $oLanguage_b->selected ? 1 : -1;
            }
        );

        $aUnionSelectParts = [];

        foreach ( $aLanguages as $iLangIndex => $oLanguage ) {
            $this->setLanguage( $oLanguage->id );
	        /**@#-
	         * EXONN
	         */

            $sWhere = null;
            if ($sSearchParamForQuery) {
                $sWhere = $this->_getWhere($sSearchParamForQuery);
            }

            $oArticle = oxNew(Article::class);
	        /**@#+
	         * EXONN
	         */
            $oArticle->setLanguage( $oLanguage->id );
	        /**@#-
	         * EXONN
	         */

            $sArticleTable = $oArticle->getViewName();
            $sO2CView = getViewName('oxobject2category');

	        /**@#+
	         * EXONN
	         * No need to retrieve the default select fields in the loop
	         */
            //$sSelectFields = $oArticle->getSelectFields();
	        /**@#-
	         * EXONN
	         */

            // longdesc field now is kept on different table
            $sDescJoin = $this->getDescriptionJoin($sArticleTable);

            // Select articles only be their OXID as the true selection will come later.
            $sSelect = "select {$sArticleTable}.`oxid` from {$sArticleTable} {$sDescJoin} where ";

            // must be additional conditions in select if searching in category
            if ($sInitialSearchCat) {
                $sCatView = getViewName('oxcategories', $this->_iLanguage);
                $sInitialSearchCatQuoted = $oDb->quote($sInitialSearchCat);
                $sSelectCat = "select oxid from {$sCatView} where oxid = $sInitialSearchCatQuoted and (oxpricefrom != '0' or oxpriceto != 0)";
                if ($oDb->getOne($sSelectCat)) {
                    $sSelect = "select {$sArticleTable}.`oxid` from {$sArticleTable} $sDescJoin " .
                            "where {$sArticleTable}.oxid in ( select {$sArticleTable}.oxid as id from {$sArticleTable}, {$sO2CView} as oxobject2category, {$sCatView} as oxcategories " .
                            "where (oxobject2category.oxcatnid=$sInitialSearchCatQuoted and oxobject2category.oxobjectid={$sArticleTable}.oxid) or (oxcategories.oxid=$sInitialSearchCatQuoted and {$sArticleTable}.oxprice >= oxcategories.oxpricefrom and
                                {$sArticleTable}.oxprice <= oxcategories.oxpriceto )) and ";
                } else {
                    $sSelect = "select {$sArticleTable}.`oxid` from {$sO2CView} as
                                oxobject2category, {$sArticleTable} {$sDescJoin} where oxobject2category.oxcatnid=$sInitialSearchCatQuoted and
                                oxobject2category.oxobjectid={$sArticleTable}.oxid and ";
                }
            }

            $sSelect .= $oArticle->getSqlActiveSnippet();
            $sSelect .= " and {$sArticleTable}.oxparentid = '' and {$sArticleTable}.oxissearch = 1 ";

            if ($sInitialSearchVendor) {
                $sSelect .= " and {$sArticleTable}.oxvendorid = " . $oDb->quote($sInitialSearchVendor) . " ";
            }

            if ($sInitialSearchManufacturer) {
                $sSelect .= " and {$sArticleTable}.oxmanufacturerid = " . $oDb->quote($sInitialSearchManufacturer) . " ";
            }

            $sSelect .= $sWhere;

	        /**@#+
	         * EXONN
	         * Order by needs to be appended onto the finished query
	         */
            /*if ($sSortBy) {
                $sSelect .= " order by {$sSortBy} ";
            }*/
            $aUnionSelectParts[ $iLangIndex ] = $sSelect;
        }

        // Reset the language to the base.
        $this->setLanguage( $iLanguageBase );

        // Need the table and fields for the base language.
        $oArticle = oxNew(Article::class);
        $oArticle->setLanguage( $iLanguageBase );

        $sArticleTable = $oArticle->getViewName();
        $sSelectFields = $oArticle->getSelectFields();

        // Glue the union selects together.
        $sUnionQuery = implode( ' UNION ', $aUnionSelectParts );
        $sUnionQuery = "SELECT distinct uQ.* from ({$sUnionQuery}) as uQ";
        $sUnionQuery = "SELECT {$sSelectFields}, {$sArticleTable}.oxtimestamp from {$sArticleTable} where {$sArticleTable}.`oxid` in ({$sUnionQuery})";

	    if ($sSortBy) {
		    $sUnionQuery .= " order by {$sSortBy} ";
	    }

        // Für den Fall, dass auch nach Varianten gesucht werden soll
        if (Registry::getConfig()->getConfigParam('bExonnSearchInVariants')) {
            $sUnionQuery = preg_replace('/oxv_oxarticles_[a-z]+\.oxparentid\s*=\s*[\'"]{2}/', '1=1', $sUnionQuery);
        }

	    return $sUnionQuery;
	    /**@#-
	     * EXONN
	     */
    }

}
