<?php

namespace Netensio\RedirectManager\Controller\Admin;

use stdClass;
use \OxidEsales\Eshop\Core\DatabaseProvider;
use \OxidEsales\Eshop\Core\Registry;

class RedirectManagerMainController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    public function render()
    {
        parent::render();

        $soxId = $this->_aViewData["oxid"] = $this->getEditObjectId();
        if ( $soxId != "-1" && isset( $soxId)) {
            // load object
            $oRedirectManager = oxNew(\Netensio\RedirectManager\Model\RedirectManager::class);
            $oRedirectManager->loadInLang( $this->_iEditLang, $soxId);

            $oOtherLang = $oRedirectManager->getAvailableInLangs();
            if (!isset($oOtherLang[$this->_iEditLang])) {
                $oRedirectManager->loadInLang( key($oOtherLang), $soxId );
            }

            $this->_aViewData["edit"] =  $oRedirectManager;

            $aLang = array_diff ( Registry::getLang()->getLanguageNames(), $oOtherLang );

            if ( count( $aLang))
                $this->_aViewData["posslang"] = $aLang;

            foreach ( $oOtherLang as $id => $language) {
                $oLang= new stdClass();
                $oLang->sLangDesc = $language;
                $oLang->selected = ($id == $this->_iEditLang);
                $this->_aViewData["otherlang"][$id] = clone $oLang;
            }
        }

        return "redirectmanager_main.tpl";
    }



    public function save()
    {

        parent::save();

        $soxId = $this->getEditObjectId();
        $aParams = Registry::getConfig()->getRequestParameter("editval");

        $oRedirectManager = oxNew(\Netensio\RedirectManager\Model\RedirectManager::class);
        if ($soxId != "-1") {
            $oRedirectManager->load($soxId);
        } else {
            $aParams['netredirectmanager__oxid'] = null;
        }

        if (!$aParams['netredirectmanager__oxactive']) {
            $aParams['netredirectmanager__oxactive'] = 0;
        }

        $oRedirectManager->setLanguage(0);
        $oRedirectManager->assign($aParams);
        $oRedirectManager->setLanguage($this->_iEditLang);
        $oRedirectManager = Registry::get("oxUtilsFile")->processFiles($oRedirectManager);
        $oRedirectManager->save();
        
        $this->setEditObjectId($oRedirectManager->getId());
    }


    public function saveinnlang()
    {
        $this->save();
    }

}
