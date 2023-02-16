<?php

namespace Netensio\Sitemap\Controller\Admin;

use stdClass;
use \OxidEsales\Eshop\Core\Field;
use \OxidEsales\Eshop\Core\Registry;

class SitemapContentController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    public function render()
    {
        $myConfig = $this->getConfig();
        parent::render();
        $soxId = $this->_aViewData["oxid"] = $this->getEditObjectId();

        $oContent = oxNew(\OxidEsales\Eshop\Application\Model\Content::class);
        if ($soxId != "-1" && isset($soxId)) {
            $oContent->loadInLang($this->_iEditLang, $soxId);

            $oOtherLang = $oContent->getAvailableInLangs();
            if (!isset($oOtherLang[$this->_iEditLang])) {
                $oContent->loadInLang(key($oOtherLang), $soxId);
            }

            $aLang = array_diff(Registry::getLang()->getLanguageNames(), $oOtherLang);
            if (count($aLang)) {
                $this->_aViewData["posslang"] = $aLang;
            }
            foreach ($oOtherLang as $id => $language) {
                $oLang = new stdClass();
                $oLang->sLangDesc = $language;
                $oLang->selected = ($id == $this->_iEditLang);
                $this->_aViewData["otherlang"][$id] = clone $oLang;
            }
            if ($oContent->oxcontents__oxcatid->value && isset($oCatTree[$oContent->oxcontents__oxcatid->value])) {
                $oCatTree[$oContent->oxcontents__oxcatid->value]->selected = 1;
            }

        } else {
            // create ident to make life easier
            $sUId = Registry::get("oxUtilsObject")->generateUId();
            $oContent->oxcontents__oxloadid = new Field($sUId);
        }

        $this->_aViewData["edit"] = $oContent;

        return "net_sitemap_content.tpl";
    }

    public function save() {
        parent::save();

        $aParams = Registry::getConfig()->getRequestParameter("editval");

        $soxId = $this->getEditObjectId();

        $oContent = oxNew(\OxidEsales\Eshop\Application\Model\Content::class);
        $oContent->load($soxId);
        $oContent->assign($aParams);
        $oContent->save();
    }
}
