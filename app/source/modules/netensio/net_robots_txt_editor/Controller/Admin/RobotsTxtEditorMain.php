<?php

namespace Netensio\RobotsTxtEditor\Controller\Admin;

use \OxidEsales\Eshop\Core\Registry;

class RobotsTxtEditorMain extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    protected $_sObject = "main";

    public function render() {
        $myConfig = $this->getConfig();
        parent::render();
        $this->_aViewData['IsOXDemoShop'] = $myConfig->isDemoShop();


        return "robots_txt_editor_main.tpl";
    }


    public function getRobotsTxtContent() {
        $oConfig = Registry::getConfig();
        $sShopBasePath = $oConfig->getConfigParam("sShopDir");
        if (($sShopBasePath[strlen($sShopBasePath)-1]) != "/") {
            $sShopBasePath = $sShopBasePath . "/";
        }
        $sFile = $sShopBasePath . "robots.txt";

        if (is_readable($sFile)) {
            $sFileContent = file_get_contents($sFile);
            return $sFileContent;
        }
        else return false;
    }


    public function save() {
        $oConfig = Registry::getConfig();
        $sShopBasePath = $oConfig->getConfigParam("sShopDir");
        if (($sShopBasePath[strlen($sShopBasePath)-1]) != "/") {
            $sShopBasePath = $sShopBasePath . "/";
        }
        $sFile = $sShopBasePath . "robots.txt";


        $sFileContent = Registry::getConfig()->getRequestParameter("robots_txt");

        $handle = fopen($sFile, "w+");

        fwrite($handle, $sFileContent);

        fclose($handle);
        chmod($sFile, 0777);

    }

}
