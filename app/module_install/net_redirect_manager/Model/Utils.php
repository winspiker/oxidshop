<?php

namespace Netensio\RedirectManager\Model;

use \OxidEsales\Eshop\Core\Registry;
use Exception;

class Utils extends Utils_parent {

    public function netHandlePageNotFoundError410($sUrl = '')
    {
        $this->setHeader("HTTP/1.0 410 Gone");
        if (Registry::getConfig()->isUtf()) {
            $this->setHeader("Content-Type: text/html; charset=UTF-8");
        }

        $sReturn = "Page not found.";
        try {
            $oView = oxNew(OxidEsales\Eshop\Application\Controller\FrontendController::class);
            $oView->init();
            $oView->render();
            $oView->setClassName('oxUBase');
            $oView->addTplParam('sUrl', $sUrl);
            if ($sRet = Registry::get("oxUtilsView")->getTemplateOutput('message/err_410.tpl', $oView)) {
                $sReturn = $sRet;
            }
        } catch (Exception $e) {
        }
        $this->showMessageAndExit($sReturn);
    }

}