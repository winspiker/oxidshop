<?php

namespace Netensio\Sitemap\Model;

use \OxidEsales\Eshop\Core\DatabaseProvider;
use \OxidEsales\Eshop\Core\Registry;

class SitemapExport extends \OxidEsales\Eshop\Core\Model\BaseModel
{

    public function genExport() {


        $sUrlsetStart = '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.google.com/schemas/sitemap/0.84" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/sitemap.xsd">';

        $sUrlsetStop = '</urlset>';

        $aLanguages = Registry::getLang()->getLanguageArray();
        $aObjects = $this->_getExportObjectArray();

        foreach($aLanguages as $oLang) {
            if ($oLang->active == "1") {

                foreach($aObjects as $sObject) {

                    $handle = $this->_netOpenFile($sObject, $oLang->id);


                    if ($sObject == "static") {
                        fwrite($handle, $sUrlsetStart);

                        $sShopUrl = Registry::getConfig()->getConfigParam("sShopURL");
                        $sPriority = $this->_getStaticPriority();
                        $sChangeFreq = $this->_getStaticChangeFreq();

                        if ($oLang->id == 0) {
                            $aTimestamp = explode(" ", date("Y-m-d H:i:s"));
                            $aList = array();
                            $aList[] = array(
                                'loc' => $sShopUrl,
                                'priority' => $sPriority,
                                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                                'changefreq' => $sChangeFreq,
                            );
                            $this->_putToSitemap($aList, $handle);

                        }

                        $sSql = "SELECT distinct oxseourl, oxtimestamp from oxseo where oxlang='" . $oLang->id . "' and oxtype='static' and oxseourl != ''";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);

                        foreach ($res as $aLoad) {
                            $aList = array();
                            $sLink = $sShopUrl . $aLoad["oxseourl"];
                            $aTimestamp = explode(" ", $aLoad["oxtimestamp"]);

                            $aList[] = array(
                                'loc' => $sLink,
                                'priority' => $sPriority,
                                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                                'changefreq' => $sChangeFreq,
                            );
                            if (!in_array($sLink, Registry::getConfig()->getConfigParam("aNetSitemapExlude"))) {
                                $this->_putToSitemap($aList, $handle);
                            }
                        }
                        fwrite($handle, $sUrlsetStop);
                    }
                    elseif ($sObject == "oxarticle" && $this->_blExportArticles()) {
                        fwrite($handle, $sUrlsetStart);
//                        $sSql = "SELECT distinct oxart.oxid as oxid, oxart.oxtitle as oxtitle, oxart.oxtimestamp as oxtimestamp FROM oxarticles as oxart LEFT JOIN oxobject2category as oxobj2cat ON ( oxobj2cat.oxobjectid = oxart.oxid ) LEFT JOIN oxcategories as oxcat ON ( oxcat.oxid = oxobj2cat.oxcatnid ) WHERE oxart.oxactive = 1 AND oxart.oxparentid = '' AND oxcat.oxactive = 1 AND oxcat.oxhidden = 0 ORDER by oxart.oxid ASC";
                        $sSql = "SELECT distinct oxart.oxid as oxid, oxart.oxtitle as oxtitle, oxart.oxtimestamp as oxtimestamp FROM oxarticles as oxart LEFT JOIN oxobject2category as oxobj2cat ON ( oxobj2cat.oxobjectid = oxart.oxid ) LEFT JOIN oxcategories as oxcat ON ( oxcat.oxid = oxobj2cat.oxcatnid ) WHERE oxart.oxactive = 1 AND oxart.oxparentid = '' AND oxcat.oxactive = 1 AND oxcat.oxhidden = 0 ORDER by oxart.oxid ASC";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);
                        foreach ($res as $aLoad) {
                            $oArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
                            $oArticle->loadInLang($oLang->id, $aLoad["oxid"]);
                            if ($oArticle->isVisible()) { //sonst wird Link nicht funktionieren.
                                $aList = $this->_getArticleData($oArticle);
                                $this->_putToSitemap($aList, $handle);
                            }
                        }
                        fwrite($handle, $sUrlsetStop);
                    }
                    elseif($sObject == "oxcategory" && $this->_blExportCategories()) {
                        fwrite($handle, $sUrlsetStart);

                        if (Registry::getConfig()->getConfigParam("blNetSitemapBoolHiddenCats") === false) {
                            $sHiddenConfig = "AND oxhidden = 0 ";
                        }
                        else $sHiddenConfig = "";

						// Filter für Kategorien ohne Artikel
	                    // alle kategorien auslesen
	                    $allCategoriesQuery =
	                    '
	                        SELECT 
	                            distinct oxcatnid
                            FROM
								oxobject2category
	                    ';

						$allCategoriesResult = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($allCategoriesQuery);



						$categoryArray = [];
						foreach($allCategoriesResult as $categoryId)
						{
							$categoryArray[] = $categoryId['oxcatnid'];
						}

						$categoryString = "'".join("','",$categoryArray)."'";




	                    // alle kategorien in der tabelle object2categroie prüfen
	                    // nur kategorien mit eintrag erlauben

                        $sSql = "SELECT oxid, oxtitle FROM oxcategories WHERE oxid in (".$categoryString.") {$sHiddenConfig}and oxextlink = '' ORDER by oxtitle ASC";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);




                        foreach ($res as $aLoad) {
                            $oCategory = oxNew(\OxidEsales\Eshop\Application\Model\Category::class);
                            $oCategory->loadInLang($oLang->id, $aLoad["oxid"]);
                            if ($oCategory->oxcategories__oxactive->value) {
                                $aList = $this->_getCategoryData($oCategory);
                                $this->_putToSitemap($aList, $handle);
                            }
                        }
                        fwrite($handle, $sUrlsetStop);
                    }
                    elseif($sObject == "oxcontent" && $this->_blExportContents()) {
                        fwrite($handle, $sUrlsetStart);
                        $sSql = "SELECT oxid, oxtitle FROM oxcontents WHERE oxactive = 1 AND oxfolder = 'CMSFOLDER_USERINFO' ORDER by oxtitle ASC";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);
                        foreach ($res as $aLoad) {
                            $oContent = oxNew(\OxidEsales\Eshop\Application\Model\Content::class);
                            $oContent->loadInLang($oLang->id, $aLoad["oxid"]);
                            $aList = $this->_getContentData($oContent);
                            $this->_putToSitemap($aList, $handle);
                        }
                        fwrite($handle, $sUrlsetStop);
                    }
                    elseif ($sObject == "oxmanufacturer" && $this->_blExportManufacturers()) {
                        fwrite($handle, $sUrlsetStart);

                        $sSql = "SELECT oxseourl, oxtimestamp from oxseo where oxobjectid='root' and oxlang='" . $oLang->id . "' and oxtype='oxmanufacturer'";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);
                        $sShopUrl = Registry::getConfig()->getConfigParam("sShopURL");
                        $sPriority = Registry::getConfig()->getConfigParam("sNetSmpManufactPrio");
                        $sChangeFreq = Registry::getConfig()->getConfigParam("sNetSmpManufactCF");
                        $aTimestamp = explode(" ", $res["0"]["oxtimestamp"]);
                        $sLink = $sShopUrl . $res["0"]["oxseourl"];
                        $aList = array();
                        $aList[] = array(
                            'loc' => $sLink,
                            'priority' => $sPriority,
                            'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                            'changefreq' => $sChangeFreq,
                        );
                        $this->_putToSitemap($aList, $handle);



                        $sSql = "SELECT oxid, oxtitle FROM oxmanufacturers WHERE oxactive = 1 ORDER by oxtitle ASC";
                        $res = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);
                        foreach ($res as $aLoad) {
                            $oManufacturer = oxNew(\OxidEsales\Eshop\Application\Model\Manufacturer::class);
                            $oManufacturer->loadInLang($oLang->id, $aLoad["oxid"]);
                            $aList = $this->_getManufacturerData($oManufacturer);
                            $this->_putToSitemap($aList, $handle);
                        }
                        fwrite($handle, $sUrlsetStop);
                    }

                    $this->_netCloseFile($handle);

                }
            }
        }

        $this->_generateSitemapIndex();

    }



    protected function _generateSitemapIndex() {
        $sSitemapIndexStart = '<?xml version="1.0" encoding="UTF-8"?><sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';

        $sSitemapIndexStop = '</sitemapindex>';

        $aLanguages = Registry::getLang()->getLanguageArray();
        $aObjects = $this->_getExportObjectArray();

        $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap.xml", "w+");

        fwrite($handle, $sSitemapIndexStart);
        $aTimestamp = explode(" ", date("Y-m-d H:i:s"));
        foreach($aLanguages as $oLang) {
            if ($oLang->active == "1") {
                foreach($aObjects as $sObject) {

                    if ($sObject == "static") {
                        if ($oLang->id == 0) {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_static.xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        else {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_static_" . $oLang->id . ".xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        fwrite($handle, $sLine);
                    }
                    elseif ($sObject == "oxarticle" && $this->_blExportArticles()) {
                        if ($oLang->id == 0) {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_products.xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        else {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_products_" . $oLang->id . ".xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        fwrite($handle, $sLine);
                    }
                    elseif($sObject == "oxcategory" && $this->_blExportCategories()) {
                        if ($oLang->id == 0) {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_categories.xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        else {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_categories_" . $oLang->id . ".xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        fwrite($handle, $sLine);
                    }
                    elseif($sObject == "oxcontent" && $this->_blExportContents()) {
                        if ($oLang->id == 0) {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_contents.xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        else {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_contents_" . $oLang->id . ".xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        fwrite($handle, $sLine);
                    }
                    elseif ($sObject == "oxmanufacturer" && $this->_blExportManufacturers()) {
                        if ($oLang->id == 0) {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_manufacturers.xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        else {
                            $sLine = "<sitemap><loc>" . $this->getConfig()->getConfigParam('sShopURL') . "sitemaps/sitemap_manufacturers_" . $oLang->id . ".xml</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                        }
                        fwrite($handle, $sLine);
                    }
                    elseif ($sObject == "external") {
                        if ($oLang->id == 0) {
                            $aExternalSitemaps = Registry::getConfig()->getConfigParam("sNetExternalSitemap");
                            if (!is_null($aExternalSitemaps) && isset($aExternalSitemaps) && is_array($aExternalSitemaps) && count($aExternalSitemaps) >= 1) {
                                foreach ($aExternalSitemaps as $sExternalSitemap) {
                                    $sLine = "<sitemap><loc>" . $sExternalSitemap . "</loc><lastmod>" . $aTimestamp[0] . "T" . $aTimestamp[1] . "+00:00"  . "</lastmod></sitemap>";
                                    fwrite($handle, $sLine);
                                }
                            }
                        }
                    }

                }
            }
        }

        fwrite($handle, $sSitemapIndexStop);

        fclose($handle);


    }





    protected function _getArticleData($oArticle) {
        $list = array();
        $oFullVariantList = $oArticle->getFullVariants(true);


        if (!$oArticle->isVariant() && $this->_blExportVariants() && count($oFullVariantList) != 0) {
            if ($oArticle->oxarticles__netsitemapexclude->value == "0") {
                $sPriority = $this->_getArticlePriority($oArticle);
                $sChangeFreq = $this->_getArticleChangeFreq($oArticle);
                $aTimestamp = explode(" ", $oArticle->oxarticles__oxtimestamp->value);
                $list[] = array(
                    'loc' => $oArticle->getLink(),
                    'priority' => $sPriority,
                    'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                    'changefreq' => $sChangeFreq,
                );



                foreach ($oFullVariantList as $oVariant) {
                    $sPriority = $this->_getArticlePriority($oVariant);
                    $sChangeFreq = $this->_getArticleChangeFreq($oVariant);
                    $aTimestamp = explode(" ", $oVariant->oxarticles__oxtimestamp->value);
                    $list[] = array(
                        'loc' => $oVariant->getLink(),
                        'priority' => $sPriority,
                        'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                        'changefreq' => $sChangeFreq,
                    );
                }
            }
        }
        else {
            if ($oArticle->oxarticles__netsitemapexclude->value == "0") {
                $sPriority = $this->_getArticlePriority($oArticle);
                $sChangeFreq = $this->_getArticleChangeFreq($oArticle);
                $aTimestamp = explode(" ", $oArticle->oxarticles__oxtimestamp->value);
                $list[] = array(
                    'loc' => $oArticle->getLink(),
                    'priority' => $sPriority,
                    'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                    'changefreq' => $sChangeFreq,
                );
            }
        }
        return $list;
    }

    protected function _getCategoryData($oCategory) {
        $list = array();
        if ($oCategory->oxcategories__netsitemapexclude->value == "0" && $this->_blExportPagination()) {
            $sPriority = $this->_getCategoryPriority($oCategory);
            $sChangeFreq = $this->_getCategoryChangeFreq($oCategory);
            $aTimestamp = explode(" ", $oCategory->oxcategories__oxtimestamp->value);
            $list[] = array(
                'loc' => $oCategory->getLink(),
                'priority' => $sPriority,
                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                'changefreq' => $sChangeFreq,
            );


            $sSelect = "SELECT max(oxparams) from oxseo where oxstdurl LIKE 'index.php?cl=alist&amp;cnid=" . $oCategory->getId() ."%' and oxtype='oxcategory' and oxparams != ''";
            $iPages = DatabaseProvider::getDb()->getOne($sSelect);

            if (!is_null($iPages)) {
                for ($i=2;$i<=$iPages;$i++) {
                    $list[] = array(
                        'loc' => $oCategory->getLink() . $i ."/",
                        'priority' => $sPriority,
                        'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                        'changefreq' => $sChangeFreq,
                    );
                }
            }
        }
        elseif ($oCategory->oxcategories__netsitemapexclude->value == "0" && !$this->_blExportPagination()) {
            $sPriority = $this->_getCategoryPriority($oCategory);
            $sChangeFreq = $this->_getCategoryChangeFreq($oCategory);
            $aTimestamp = explode(" ", $oCategory->oxcategories__oxtimestamp->value);
            $list[] = array(
                'loc' => $oCategory->getLink(),
                'priority' => $sPriority,
                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                'changefreq' => $sChangeFreq,
            );
        }
        return $list;
    }

    protected function _getContentData($oContent) {
        $list = array();
        if ($oContent->oxcontents__netsitemapexclude->value == "0") {
            $sPriority = $this->_getContentPriority($oContent);
            $sChangeFreq = $this->_getContentChangeFreq($oContent);
            $aTimestamp = explode(" ", $oContent->oxcontents__oxtimestamp->value);
            $list[] = array(
                'loc' => $oContent->getLink(),
                'priority' => $sPriority,
                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                'changefreq' => $sChangeFreq,
            );
        }
        return $list;
    }

    protected function _getManufacturerData($oManufacturer) {
        $list = array();
        if ($oManufacturer->oxmanufacturers__netsitemapexclude->value == "0" && $this->_blExportPagination()) {
            $sPriority = $this->_getManufacturerPriority($oManufacturer);
            $sChangeFreq = $this->_getManufacturerChangeFreq($oManufacturer);
            $aTimestamp = explode(" ", $oManufacturer->oxmanufacturers__oxtimestamp->value);
            $list[] = array(
                'loc' => $oManufacturer->getLink(),
                'priority' => $sPriority,
                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                'changefreq' => $sChangeFreq,
            );

            $sSelect = "SELECT max(oxparams) from oxseo where oxstdurl LIKE 'index.php?cl=manufacturerlist&amp;mnid=" . $oManufacturer->getId() ."%' and oxtype='oxmanufacturer' and oxparams != ''";
            $iPages = DatabaseProvider::getDb()->getOne($sSelect);

            if (!is_null($iPages)) {
                for ($i=2;$i<=$iPages;$i++) {
                    $list[] = array(
                        'loc' => $oManufacturer->getLink() . $i ."/",
                        'priority' => $sPriority,
                        'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                        'changefreq' => $sChangeFreq,
                    );
                }
            }


        }
        elseif ($oManufacturer->oxmanufacturers__netsitemapexclude->value == "0" && !$this->_blExportPagination()) {
            $sPriority = $this->_getManufacturerPriority($oManufacturer);
            $sChangeFreq = $this->_getManufacturerChangeFreq($oManufacturer);
            $aTimestamp = explode(" ", $oManufacturer->oxmanufacturers__oxtimestamp->value);
            $list[] = array(
                'loc' => $oManufacturer->getLink(),
                'priority' => $sPriority,
                'lastmod' => $aTimestamp[0] . 'T' . $aTimestamp[1] . '+00:00',
                'changefreq' => $sChangeFreq,
            );
        }
        return $list;
    }


    protected function _putToSitemap($aList, $handle) {
        foreach($aList as $key => $value) {
            $xmlInsert = "<url><loc>" . $value['loc'] . "</loc><priority>" . $value['priority'] . "</priority><lastmod>" . $value['lastmod'] . "</lastmod><changefreq>" . $value['changefreq'] . "</changefreq></url>";
            fwrite($handle, $xmlInsert);
        }
    }


    protected function _getStaticPriority() {
        return Registry::getConfig()->getConfigParam("sNetSmpStaticPrio");
    }

    protected function _getArticlePriority($oArticle) {
        if ($oArticle->oxarticles__netsitemappriority->value != "") {
            return $oArticle->oxarticles__netsitemappriority->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpArticlePrio");
    }

    protected function _getCategoryPriority($oCategory) {
        if ($oCategory->oxcategories__netsitemappriority->value != "") {
            return $oCategory->oxcategories__netsitemappriority->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpCategoryPrio");
    }

    protected function _getContentPriority($oContent) {
        if ($oContent->oxcontents__netsitemappriority->value != "") {
            return $oContent->oxcontents__netsitemappriority->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpContentPrio");
    }

    protected function _getManufacturerPriority($oManufacturer) {
        if ($oManufacturer->oxmanufacturers__netsitemappriority->value != "") {
            return $oManufacturer->oxmanufacturers__netsitemappriority->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpManufactPrio");
    }

    protected function _getStaticChangeFreq() {
        return Registry::getConfig()->getConfigParam("sNetSmpStaticCF");
    }

    protected function _getArticleChangeFreq($oArticle) {
        if ($oArticle->oxarticles__netsitemapchangefreq->value != "") {
            return $oArticle->oxarticles__netsitemapchangefreq->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpArticleCF");
    }

    protected function _getCategoryChangeFreq($oCategory) {
        if ($oCategory->oxcategories__netsitemapchangefreq->value != "") {
            return $oCategory->oxcategories__netsitemapchangefreq->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpCategoryCF");
    }

    protected function _getContentChangeFreq($oContent) {
        if ($oContent->oxcontents__netsitemapchangefreq->value != "") {
            return $oContent->oxcontents__netsitemapchangefreq->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpContentCF");
    }

    protected function _getManufacturerChangeFreq($oManufacturer) {
        if ($oManufacturer->oxmanufacturers__netsitemapchangefreq->value != "") {
            return $oManufacturer->oxmanufacturers__netsitemapchangefreq->value;
        }
        return Registry::getConfig()->getConfigParam("sNetSmpManufactCF");
    }




    protected function _getExportObjectArray() {

        $aObjects = array();

        $aObjects[] = "static";

        if ($this->_blExportArticles()) {
            $aObjects[] = "oxarticle";
        }
        if ($this->_blExportCategories()) {
            $aObjects[] = "oxcategory";
        }
        if ($this->_blExportContents()) {
            $aObjects[] = "oxcontent";
        }
        if ($this->_blExportManufacturers()) {
            $aObjects[] = "oxmanufacturer";
        }

        $aExternalSitemaps = Registry::getConfig()->getConfigParam("sNetExternalSitemap");

        if (!is_null($aExternalSitemaps) && isset($aExternalSitemaps) && is_array($aExternalSitemaps) && count($aExternalSitemaps) >= 1) {
            $aObjects[] = "external";
        }

        return $aObjects;

    }



    protected function _netOpenFile($sObject, $iLang) {
        if ($iLang == 0) {
            if ($sObject == "static") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_static.xml", "w+");
            }
            elseif ($sObject == "oxarticle") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_products.xml", "w+");
            }
            elseif ($sObject == "oxcategory") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_categories.xml", "w+");
            }
            elseif ($sObject == "oxcontent") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_contents.xml", "w+");
            }
            elseif ($sObject == "oxmanufacturer") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_manufacturers.xml", "w+");
            }
        }
        else {
            if ($sObject == "static") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_static_". $iLang .".xml", "w+");
            }
            elseif ($sObject == "oxarticle") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_products_". $iLang .".xml", "w+");
            }
            elseif ($sObject == "oxcategory") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_categories_". $iLang .".xml", "w+");
            }
            elseif ($sObject == "oxcontent") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_contents_". $iLang .".xml", "w+");
            }
            elseif ($sObject == "oxmanufacturer") {
                return $handle = fopen($this->getConfig()->getConfigParam('sShopDir') . "sitemaps/sitemap_manufacturers_". $iLang .".xml", "w+");
            }
        }
    }


    /**
     * Closes th given file handle
     * @param $handle
     * @return bool
     */
    protected function _netCloseFile($handle) {

        return fclose($handle);
    }


    /**
     * Ticksize getter
     */
    protected function _netGetSitemapTicksize()
    {
        return $this->getConfig()->getConfigParam("sNetSitemapTicksize");
    }



    protected function _convertDateTime2UTC($sDateTime) {
        $sDateTimeUTC = str_replace(" ", "T", $sDateTime);
        return $sDateTimeUTC;
    }


    protected function _blExportVariants() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolVariants");
    }

    protected function _blExportArticles() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolArticle");
    }

    protected function _blExportCategories() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolCategory");
    }

    protected function _blExportContents() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolContent");
    }

    protected function _blExportManufacturers() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolManufact");
    }

    protected function _blExportPagination() {
        return Registry::getConfig()->getConfigParam("blNetSitemapBoolPagination");
    }


}