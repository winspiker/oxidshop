<?php

class exonn_shopconnector extends oxUBase
{
    protected $_allowFunktion = array('oxResetFileCache', 'resetCatArticleCount', 'resetPriceCatArticleCount', 'resetVendorArticleCount', 'resetManufacturerArticleCount');


    public function resetcash()
    {
        $oConfig = $this->getConfig();
        $functionname = $oConfig->getRequestParameter('functionname');
        $parameter = $oConfig->getRequestParameter('parameter');

        if (!in_array($functionname, $this->_allowFunktion)) {
            exit();
        }

        if ($functionname=="oxResetFileCache") {
            oxRegistry::getUtils()->oxResetFileCache();

        } else {
            $myUtilsCount = oxRegistry::get("oxUtilsCount");
            $myUtilsCount->$functionname($parameter);
        }

        exit();

    }

}