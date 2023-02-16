<?php

namespace Netensio\RedirectManager\Core;

use \OxidEsales\Eshop\Core\DatabaseProvider;
use \OxidEsales\Eshop\Core\Registry;
use \OxidEsales\Eshop\Core\DbMetaDataHandler;

class Events {

    public static function onActivate() {
        // Cleaning up
        self::clearTmp();

        // Adding module tables
        self::addCheckCustomTable("netredirectmanager");

        // Cleaning up
        self::clearTmp();
        $oDbMetaDataHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);
        $oDbMetaDataHandler->updateViews();
    }


    public static function addCheckCustomTable($sTableName) {
        $oDbMetaDataHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);

        switch(strtolower($sTableName)) {
            case "netredirectmanager":
                $sSql =  "CREATE TABLE netredirectmanager ( ";
                $sSql .= "OXID char(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL PRIMARY KEY, ";
                $sSql .= "OXSHOPID varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '', ";
                $sSql .= "OXHTTPCODE int(3) NOT NULL, ";
                $sSql .= "OXHTTPMESSAGE varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXSOURCE varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXSOURCE_1 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXSOURCE_2 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXSOURCE_3 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXTARGET varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXTARGET_1 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXTARGET_2 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXTARGET_3 varchar(255) NOT NULL DEFAULT '', ";
                $sSql .= "OXACTIVE tinyint(1) NOT NULL DEFAULT '1', ";
                $sSql .= "OXTIMESTAMP timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ";
                $sSql .= ") ENGINE=MyISAM DEFAULT CHARSET=utf8";
                break;
            default:
        }

        if (!$oDbMetaDataHandler->tableExists($sTableName)) {
            DatabaseProvider::getDb()->execute($sSql);
        }

    }

    public static function clearTmp() {
        $sShopTmpDir = Registry::getConfig()->getConfigParam("sCompileDir");
        $sClearCacheCmd = "rm -R -f ".$sShopTmpDir."/*";
        exec($sClearCacheCmd);
    }

}