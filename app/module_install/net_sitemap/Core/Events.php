<?php

namespace Netensio\Sitemap\Core;

use \OxidEsales\Eshop\Core\DatabaseProvider;
use \OxidEsales\Eshop\Core\Registry;
use \OxidEsales\Eshop\Core\DbMetaDataHandler;

class Events {

    public static function onActivate() {

        // Cleaning up
        self::clearTmp();
        $oDbMetaDataHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);
        $oDbMetaDataHandler->updateViews();

        // Adding additional category fields
        self::addCheckCustomField("netsitemapexclude", "oxarticles");
        self::addCheckCustomField("netsitemapchangefreq", "oxarticles");
        self::addCheckCustomField("netsitemappriority", "oxarticles");

        self::addCheckCustomField("netsitemapexclude", "oxcategories");
        self::addCheckCustomField("netsitemapchangefreq", "oxcategories");
        self::addCheckCustomField("netsitemappriority", "oxcategories");

        self::addCheckCustomField("netsitemapexclude", "oxcontents");
        self::addCheckCustomField("netsitemapchangefreq", "oxcontents");
        self::addCheckCustomField("netsitemappriority", "oxcontents");

        self::addCheckCustomField("netsitemapexclude", "oxmanufacturers");
        self::addCheckCustomField("netsitemapchangefreq", "oxmanufacturers");
        self::addCheckCustomField("netsitemappriority", "oxmanufacturers");

        // Cleaning up
        self::clearTmp();
        $oDbMetaDataHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);
        $oDbMetaDataHandler->updateViews();
    }

    public static function addCheckCustomField($sFieldName, $sTableName) {
        $oDbMetaDataHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);

        switch(strtolower($sFieldName . "|" . $sTableName)) {
            case "netsitemapexclude|oxarticles":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} INT( 1 ) NOT NULL DEFAULT '0'";
                break;
            case "netsitemapchangefreq|oxarticles":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 7 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemappriority|oxarticles":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemapexclude|oxcategories":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} INT( 1 ) NOT NULL DEFAULT '0'";
                break;
            case "netsitemapchangefreq|oxcategories":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 7 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemappriority|oxcategories":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemapexclude|oxcontents":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} INT( 1 ) NOT NULL DEFAULT '0'";
                break;
            case "netsitemapchangefreq|oxcontents":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 7 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemappriority|oxcontents":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemapexclude|oxmanufacturers":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} INT( 1 ) NOT NULL DEFAULT '0'";
                break;
            case "netsitemapchangefreq|oxmanufacturers":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 7 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
            case "netsitemappriority|oxmanufacturers":
                $sSql = "ALTER TABLE {$sTableName} ADD {$sFieldName} VARCHAR( 3 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''";
                break;
        }

        if (!$oDbMetaDataHandler->fieldExists($sFieldName, $sTableName)) {
            DatabaseProvider::getDb()->execute($sSql);
        }
    }


    public static function clearTmp() {
        $sShopTmpDir = Registry::getConfig()->getConfigParam("sCompileDir");
        $sClearCacheCmd = "rm -R -f ".$sShopTmpDir."/*";
        exec($sClearCacheCmd);
    }

}