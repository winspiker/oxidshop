<?php

/**
 *
 * @package   tabslImageTags
 * @version   3.0.1
 * @license   kaufbei.tv
 * @link      https://oxid-module.eu
 * @author    Tobias Merkl <support@oxid-module.eu>
 * @copyright Tobias Merkl | 2021-09-23
 *
 * This Software is the property of Tobias Merkl
 * and is protected by copyright law, it is not freeware.
 *
 * Any unauthorized use of this software without a valid license
 * is a violation of the license agreement and will be
 * prosecuted by civil and criminal law.
 *
 * 58fdc7af16ec0fe83c4774f81b336f31
 *
 **/

namespace Tabsl\ImageTags\Core;

class Setup extends \OxidEsales\Eshop\Core\Base
{
    /*
     * Module id
     */
    public static $sModuleId = 'tabslImageTags';


    /**
     * Module activation script.
     * @return bool
     */
    public static function onActivate()
    {
        # setup/sql/install.sql
        $res = self::_dbEvent('install.sql', 'onActivate()', 'oxarticles;tabsl_imagetag1');
        if ($res) {
            self::_getModuleActivation();
        }
        return $res;
    }

    /**
     * Module deactivation script.
     */
    public static function onDeactivate()
    {
        # setup/sql/uninstall.sql
        self::_dbEvent('', 'onDeactivate()');
    }

    /**
     * Install/uninstall event.
     * Executes SQL queries form a file.
     *
     * @param string $sSqlFile SQL file located in module setup folder (usually install.sql or uninstall.sql).
     * @param string $sFailureError An error message to show on failure.
     * @return bool
     */
    protected static function _dbEvent($sSqlFile = "", $sAction = "", $sDbCheck = "")
    {
        if ($sSqlFile != "") {
            try {
                $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();

                if (!empty($sDbCheck)) {
                    $aDbCheck = explode(";", $sDbCheck);
                    if (count($aDbCheck) > 0 && self::dbColumnExist($aDbCheck[0], $aDbCheck[1])) {
                        return true;
                    }
                }

                $sSql = file_get_contents(dirname(__FILE__) . '/../setup/sql/' . (string)$sSqlFile);
                $aSql = (array)explode(';', $sSql);
                foreach ($aSql as $sQuery) {
                    if (!empty($sQuery)) {
                        $oDb->execute($sQuery);
                    }
                }
            } catch (Exception $ex) {
                error_log($sAction . " failed: " . $ex->getMessage());
            }

            /** @var oxDbMetaDataHandler $oDbHandler */
            $oDbHandler = oxNew(\OxidEsales\Eshop\Core\DbMetaDataHandler::class);
            $oDbHandler->updateViews();

            self::clearTmp();
        }
        return true;
    }

    /**
     * Check if database column already exists
     *
     * @param $sTable
     * @param $sColumn
     * @return string
     */
    public static function dbColumnExist($sTable, $sColumn)
    {
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
        $sDbName = \OxidEsales\Eshop\Core\Registry::getConfig()->getConfigParam('dbName');
        try {
            $sSql = "SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ? AND COLUMN_NAME = ?";
            $blRet = $oDb->getOne($sSql, [$sDbName, $sTable, $sColumn]);
        } catch (Exception $oEx) {
            $blRet = false;
        }
        return $blRet;
    }

    /**
     * Clean temp folder content.
     *
     * @param string $sClearFolderPath Sub-folder path to delete from. Should be a full, valid path inside temp folder.
     *
     * @return boolean
     */
    public static function clearTmp($sClearFolderPath = '')
    {
        $sFolderPath = self::_getFolderToClear230921($sClearFolderPath);
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

    /**
     * Check if provided path is inside eShop `tmp/` folder or use the `tmp/` folder path.
     *
     * @param string $sClearFolderPath The folder to clear
     *
     * @return string
     */
    protected static function _getFolderToClear230921($sClearFolderPath = '')
    {
        $sTempFolderPath = (string)\OxidEsales\Eshop\Core\Registry::getConfig()->getConfigParam('sCompileDir');
        if (!empty($sClearFolderPath) and (strpos($sClearFolderPath, $sTempFolderPath) !== false)) {
            $sFolderPath = $sClearFolderPath;
        } else {
            $sFolderPath = $sTempFolderPath;
        }
        return $sFolderPath;
    }

    /**
     * Check if resource could be deleted, then delete it's a file or
     * call recursive folder deletion if it's a directory.
     *
     * @param string $sFileName The filename to delete
     * @param string $sFilePath The path to delete
     */
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

    /**
     * Sends email with module information to proudcommerce support (for debug information only)
     */
    protected static function _getModuleActivation()
    {
        $oConfig = \OxidEsales\Eshop\Core\Registry::getConfig();
        $aModuleInfo = self::_getModuleInformation();
        $sModuleInfo = date("d.m.Y H:i:s");
        $sModuleInfo .= ' /  ';
        $sModuleInfo .= $oConfig->getShopId();
        $sModuleInfo .= ' / ';
        $sModuleInfo .= $oConfig->getEdition() . ' ' . $oConfig->getVersion() . ' (' . $oConfig->getRevision() . ')';
        $sModuleInfo .= ' / ';
        $sModuleInfo .= $oConfig->getShopUrl();
        $sModuleInfo .= ' (';
        $sModuleInfo .= $_SERVER["HTTP_HOST"];
        $sModuleInfo .= ') / ';
        $sModuleInfo .= $_SERVER["SERVER_ADDR"];
        $sModuleInfo .= ' / ';
        $sModuleInfo .= $aModuleInfo["title"]["de"] . ' (' . $aModuleInfo["version"] . ')';
        @mail($aModuleInfo["email"], "[" . self::$sModuleId . "] Activation " . $oConfig->getShopUrl(), $sModuleInfo);
    }

    /**
     * Returns module information
     *
     * @return array
     */
    protected static function _getModuleInformation()
    {
        $oModule = oxNew(\OxidEsales\Eshop\Core\Module\Module::class);
        if ($oModule->load(self::$sModuleId)) {
            $aModule["title"] = $oModule->getinfo("title");
            $aModule["version"] = $oModule->getinfo("version");
            $aModule["author"] = $oModule->getinfo("author");
            $aModule["email"] = $oModule->getinfo("email");
            $aModule["id"] = self::$sModuleId;
            return $aModule;
        }
        return [];
    }
}
