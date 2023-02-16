<?php

use OxidEsales\EshopCommunity\Core\Registry;

/**
 * Shows bigger tag cloud
 * Class oetagsTagsController
 */
class oetagsTagsController extends \oxubase
{
    /**
     * Class template
     *
     * @var string
     */
    protected $_sThisTemplate = 'page/oetagstagscontroller.tpl';

    /**
     * If tags are ON - returns parent::render() value, else - displays 404
     * page, as tags are off
     *
     * @return string
     */
    public function render()
    {
        // if tags are off - showing 404 page
        if (!$this->getViewConfig()->showTags($this)) {
            error_404_handler();
        }

        return parent::render();
    }

    /**
     * Returns tag cloud manager class
     *
     * @return oetagsTagCloud
     */
    public function getTagCloudManager()
    {
        $oTagList = oxNew("oetagsTagList");
        //$oTagList->loadList();
        $oTagCloud = oxNew("oetagsTagCloud");
        $oTagCloud->setTagList($oTagList);
        $oTagCloud->setExtendedMode(true);

        return $oTagCloud;
    }

    /**
     * get Meta Keywords from Config
     * @return mixed|string
     */
    public function getMetaKeywords()
    {
        $metaKeywords = parent::getMetaKeywords();
        $config       = Registry::getConfig();
        $keywords     = $config->getConfigParam('oetagsMetaKeywords');

        if ($keywords) {
            $metaKeywords = $keywords;
        }

        return $metaKeywords;
    }

    /**
     * get Meta Description from Config
     * @return mixed|string
     */
    public function getMetaDescription()
    {
        $metaDesc    = parent::getMetaDescription();
        $config      = Registry::getConfig();
        $description = $config->getConfigParam('oetagsMetaDescription');

        if ($description) {
            $metaDesc = $description;
        }

        return $metaDesc;
    }

    /**
     * Returns SEO suffix for page title
     */
    public function getTitleSuffix()
    {
    }

    /**
     * Returns title page suffix used in template
     *
     * @return string|null
     */
    public function getTitlePageSuffix()
    {
        if (($iPage = $this->getActPage())) {
            return oxRegistry::getLang()->translateString('PAGE') . " " . ($iPage + 1);
        }
        return null;
    }

    /**
     * Returns Bread Crumb - you are here page1/page2/page3...
     *
     * @return array
     */
    public function getBreadCrumb()
    {
        $aPaths = array();
        $aCatPath = array();

        $iBaseLanguage = oxRegistry::getLang()->getBaseLanguage();
        $aCatPath['title'] = oxRegistry::getLang()->translateString('TAGS', $iBaseLanguage, false);
        $aCatPath['link'] = $this->getLink();
        $aPaths[] = $aCatPath;

        return $aPaths;
    }

}
