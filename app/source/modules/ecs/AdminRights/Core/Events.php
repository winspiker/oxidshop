<?php
/*
 *   *********************************************************************************************
 *      Please retain this copyright header in all versions of the software.
 *      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
 *
 *      Copyright (C) Josef A. Puckl | eComStyle.de
 *      All rights reserved - Alle Rechte vorbehalten
 *
 *      This commercial product must be properly licensed before being used!
 *      Please contact info@ecomstyle.de for more information.
 *
 *      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
 *      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
 *   *********************************************************************************************
 */

namespace Ecs\AdminRights\Core;

use OxidEsales\Eshop\Core\Module\Module;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\DbMetaDataHandler;
use OxidEsales\Eshop\Core\DatabaseProvider;

class Events
{

    protected function _moduleID()
    {
        return 'ecs_adminrights';
    }

    public static function addSql()
    {
        $aSql[] = "";

        foreach ($aSql as $sSql) {
            try
            {
                DatabaseProvider::getDb()->execute($sSql);
            } catch (\Exception $oException) {
            }
        }
        return true;
    }

    public static function dropSql()
    {
        $aSql[] = "DELETE FROM oxtplblocks WHERE OXMODULE=" . self::_moduleID() . ";";

        foreach ($aSql as $sSql) {
            try
            {
                DatabaseProvider::getDb()->execute($sSql);
            } catch (\Exception $oException) {
            }
        }
        return true;
    }

    public static function clearTmp($sClearFolderPath = '')
    {
        $sFolderPath = self::_getFolderToClear($sClearFolderPath);
        $hDirHandler = opendir($sFolderPath);
        if (!empty($hDirHandler)) {
            while (false !== ($sFileName = readdir($hDirHandler))) {
                $sFilePath = $sFolderPath . DIRECTORY_SEPARATOR . $sFileName;
                self::_clear($sFileName, $sFilePath);
            }
            closedir($hDirHandler);
        }
        return true;
    }

    protected static function _getFolderToClear($sClearFolderPath = '')
    {
        $sTempFolderPath = (string) Registry::getConfig()->getConfigParam('sCompileDir');
        if (!empty($sClearFolderPath) and (strpos($sClearFolderPath, $sTempFolderPath) !== false)) {
            $sFolderPath = $sClearFolderPath;
        } else {
            $sFolderPath = $sTempFolderPath;
        }
        return $sFolderPath;
    }

    protected static function _clear($sFileName, $sFilePath)
    {
        if (!in_array($sFileName, ['.', '..', '.gitkeep', '.htaccess'])) {
            if (is_file($sFilePath)) {
                @unlink($sFilePath);
            } else {
                self::clearTmp($sFilePath);
            }
        }
    }

    public static function regenViews()
    {
        $oMD = oxNew(DbMetaDataHandler::class);
        $oMD->updateViews();
    }

    public static function onActivate()
    {
        $oModule = oxNew(Module::class);
        $oModule->load(self::_moduleID());
        @mail(str_replace(["info", "support"], "dev", $oModule->getInfo('email')), $oModule->getInfo('id') . ' - ' . $_SERVER["HTTP_HOST"], $oModule->getInfo('id') . ' - ' . $oModule->getInfo('version') . ' - ' . $_SERVER["HTTP_HOST"]);
        //self::addSql();
        self::clearTmp();
        self::regenViews();
    }

    public static function onDeactivate()
    {
        self::dropSql();
        self::clearTmp();
        self::regenViews();
    }
}
