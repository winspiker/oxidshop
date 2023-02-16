<?php

namespace Netensio\Sitemap\Controller\Admin;

use stdClass;
use \OxidEsales\Eshop\Core\Registry;

class SitemapManufacturerController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    public function render()
    {
        parent::render();

        $soxId = $this->_aViewData["oxid"] = $this->getEditObjectId();
        if ($soxId != "-1" && isset($soxId)) {
            $oManufacturer = oxNew(\OxidEsales\Eshop\Application\Model\Manufacturer::class);
            $oManufacturer->loadInLang($this->_iEditLang, $soxId);

            $oOtherLang = $oManufacturer->getAvailableInLangs();
            if (!isset($oOtherLang[$this->_iEditLang])) {
                $oManufacturer->loadInLang(key($oOtherLang), $soxId);
            }
            $this->_aViewData["edit"] = $oManufacturer;

            if ($oManufacturer->isDerived()) {
                $this->_aViewData['readonly'] = true;
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
        }

        return "net_sitemap_manufacturer.tpl";
    }


    public function save() {
        parent::save();

        $aParams = Registry::getConfig()->getRequestParameter("editval");

        $soxId = $this->getEditObjectId();

        $oManufacturer = oxNew(\OxidEsales\Eshop\Application\Model\Manufacturer::class);
        $oManufacturer->load($soxId);
        $oManufacturer->assign($aParams);
        $oManufacturer->save();
    }
}
