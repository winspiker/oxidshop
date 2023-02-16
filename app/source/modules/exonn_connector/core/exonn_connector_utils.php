<?php

class exonn_connector_utils extends oxBase {

    public $_last_error = "";
    public $_last_error_info = "";

    public function beforeSelfUpdate() {

    }

    public function afterSelfUpdate() {
        $this->reactivateSelf();
    }

    public function reactivateSelf() {
        $sModule = "exonn_connector";

        /** @var oxModule $oModule */
        $oModule = oxNew('oxModule');
        if (!$oModule->load($sModule)) {
            return;
        }
        try {
            exonn_connector_utils::writeToLog( "Start activateModule: " . $sModule , 'exonn_connector.txt' );
            $oModule_Main = oxNew("Module_Main");
            $oModule_Main->setEditObjectId($sModule);
            $oModule_Main->activateModule();
            //$this->onActivateEvent($sModule);
        } catch (Exception $oEx) {
            exonn_connector_utils::writeToLog( "activateModule: " . $oEx->getLine() . $oEx->getMessage() , 'exonn_connector.txt' );
        }
    }

    public static function phpver() {
        $phpver = phpversion();
        $phpver = substr($phpver, 0, 3);
        return $phpver;
    }

    public static function ionnCubeVer() {

        $extensions = get_loaded_extensions();

        if (in_array('ionCube Loader', $extensions)) {
            $ioncubeVersion = '';
            if (function_exists('ioncube_loader_version')) {
                $ioncubeVersion = ioncube_loader_version();
                $ioncubeMajorVersion = (int)substr($ioncubeVersion, 0, strpos($ioncubeVersion, '.'));
                $ioncubeMinorVersion = (int)substr($ioncubeVersion, strpos($ioncubeVersion, '.')+1);
            }
            return $ioncubeMajorVersion . "." . $ioncubeMinorVersion;
        } else {
            return "not_ion_cube_installed";
        }
    }

    public static function url(){
        /*return isset($_SERVER['HTTP_X_FORWARDED_HOST']) ?  
              $_SERVER['HTTP_X_FORWARDED_HOST'] : $_SERVER("HTTP_HOST");*/
          return $_SERVER["HTTP_HOST"];
    }

    public function getOldFilesPath() {
        $myConfig = $this->getConfig();
        return $myConfig->getConfigParam("sShopDir") . '/modules/exonn_connector/old/';
    }

    public function checkRights() {
        $result = array("tmp" => "ok", "modules" => "ok");
        $myConfig = $this->getConfig();
        if (!$this->isWriteable($myConfig->getConfigParam("sShopDir") . '/modules/exonn_connector/tmp/')) {
            $result["tmp"] = "";
        }
        if (!$this->isWriteable($myConfig->getConfigParam("sShopDir") . '/modules/')) {
            $result["modules"] = "";
        }
        return $result;
    }

    public function sendSupportEmail() {
        $myConfig = $this->getConfig();
        $email = oxNew("oxemail");
        $email->setRecipient("support@exonn.de");
        $email->setFrom($myConfig->getActiveShop()->oxshops__oxowneremail->value, $myConfig->getActiveShop()->oxshops__oxname->getRawValue());
        $email->setSubject("EXONN Connector Problem an " . exonn_connector_utils::url());
        $email->setBody("Error code: " . $myConfig->getRequestParameter("last_err"));
        $email->addAttachment($myConfig->getConfigParam("sShopDir") . "/log/exonn_connector.txt", "exonn_connector.txt");
        return $email->send();
    }

    public function isWriteable($path) {
        clearstatcache();
        $result =   is_writable($path);
        //echo $path . ": " . $result . " (" . decoct(fileperms($path) & 0777) . "," . decoct(fileperms($path) & 0755) . ")" . "<br>";
        return $result;
                //(decoct(fileperms($path) & 0777) == 777) || (decoct(fileperms($path) & 0755) == 755);
    }

    public function checkModuleRights($path) {
        if (!$this->isWriteable($path)) return $path;

        $nodes = glob($path . '/*');
        if (is_array($nodes))
        foreach ($nodes as $node) {
            //echo $node . " " . decoct(fileperms($path)& 0777) . "<br>";
            if (is_dir($node)) {
                if ($fail = $this->checkModuleRights($node)) return $fail;
            } else if (is_file($node))  {
                if (!$this->isWriteable($node)) return $node;
            }
        }
        return 0;
    }

    public function getPrevVersion($modId) {
        $db = oxDb::getDb();
        return $db->getOne("select oldversion from exonn_updater where moduleid = '".$modId."'");
    }

    public function restoreOldModule($modId, $path) {
        $db = oxDb::getDb();
        $oldExistsVer = $db->getOne("select oldversion from exonn_updater where moduleid = '".$modId."'");
        $oldFile = $modId ."_" . $oldExistsVer . ".zip";
        if ($oldFile && file_exists($oldZip = $this->getOldFilesPath() . $oldFile)) {
            $this->clearDir($path);
            $this->extractZip($oldZip, $path);
            unlink($oldZip);
            $db->execute("delete from exonn_updater where moduleid = '".$modId."'");
        }

    }

    private function remoteFileExists($url) {
        $curl = curl_init($url);

        //don't fetch the actual page, you only want to check the connection is ok
        curl_setopt($curl, CURLOPT_NOBODY, true);

        //do request
        $result = curl_exec($curl);
        $ret = false;

        //if request did not fail
        if ($result !== false) {
            //if request was ok, check response code
            $statusCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            if ($statusCode == 200) {
                $ret = true;
            }
        }

        curl_close($curl);

        return $ret;
    }

    private function extractZip($from, $to) {
        $zip = new ZipArchive();
        if ($zip->open($from) === TRUE) {
            $zip->extractTo($to);
        }
        $zip->close();
    }

    /**
     * @param  $path
     * @param  ZipArchive $zip
     * @param string $zipPath
     * @return void
     */
    private function addDirToZip($path, $zip, $zipPath = "") {
        if (substr($zipPath, -1) == "/") $zipPath = substr($zipPath, 0, -1);
        if ($zipPath) {
            $zip->addEmptyDir($zipPath);
        }
        $nodes = glob($path . '/*');
        if (is_array($nodes))
        foreach ($nodes as $node) {
            if (is_dir($node)) {
                $this->addDirToZip($node, $zip, ($zipPath ?  $zipPath . "/" : "") . basename($node));
            } else if (is_file($node))  {
                $zip->addFile($node, $zipPath . "/" . basename($node));
            }
        }
    }

    /**
     * Download zip and install new module, save old module.
     *
     * @param  $modId           module exonn-id
     * @param  $path            local path to install
     * @param  $extFile         zip file to download
     * @param int $isupdate     if 1 then store old module
     * @param string $nowver    current version of module
     * @param string $newver    new version of module
     * @return string
     */
    public function installModule($modId, $path, $extFile, $isupdate = 0, $nowver = "", $newver = "") {
        /*error_reporting(E_ALL ^ E_NOTICE);
        ini_set('display_errors', 1);*/

        $myConfig = $this->getConfig();
        $newfile = $myConfig->getConfigParam("sShopDir") . '/modules/exonn_connector/tmp/' . $modId . $newver . ".zip";
        exonn_connector_utils::writeToLog( "start installModule: " , 'exonn_connector.txt' );
        if ( (!file_exists($newfile) || $this->isWriteable($newfile)) && ($copyResult = copy($extFile, $newfile)) ) {
            exonn_connector_utils::writeToLog( " Ok\r\nstart deactivateModule: " , 'exonn_connector.txt' );
            //$this->deactivateModule($modId);


            if ($isupdate) {
                exonn_connector_utils::writeToLog( " Ok\r\nstart storeOldModule: " , 'exonn_connector.txt' );
                $this->storeOldModule($modId, $nowver, $path);
            }
            exonn_connector_utils::writeToLog( " Ok\r\nstart unzip: " , 'exonn_connector.txt' );
            $zip = new ZipArchive();
            if ($zip->open($newfile) === TRUE) {
                try {
                    if (!file_exists($path)) {
                        if (!mkdir($path, 0777, true)) {
                            $this->_last_error = "cant_extract_update";
                            $this->_last_error_info = $path;
                            exonn_connector_utils::writeToLog( "installModule: Cant create module dir (from: $extFile to $newfile)." , 'exonn_connector.txt' );
                            return "err";
                        }
                    }
                    $zip->extractTo($myConfig->getModulesDir());
                    exonn_connector_utils::writeToLog( " Ok\r\nstart activateModule: " , 'exonn_connector.txt' );
                    $this->activateModule($modId);
                    exonn_connector_utils::writeToLog( " Ok\r\n" , 'exonn_connector.txt' );
                    return "ok";
                } catch (Exception $ex) {
                    exonn_connector_utils::writeToLog( "installModule: " . $ex->getLine() . $ex->getMessage() , 'exonn_connector.txt' );
                    $this->_last_error = "cant_extract_update";
                    $this->_last_error_info = $path;
                    if ($isupdate) {
                        $this->restoreOldModule($modId, $path);
                        return "err";
                    }
                }
            }
        } else {
            $this->_last_error = ($copyResult === false ? "cant_copy_update" : "no_rights_to_copy");
            $this->_last_error_info = $newfile;

            exonn_connector_utils::writeToLog( "installModule: Cant copy zip (".($copyResult === false ? "copy error" : "no rights").") (from: $extFile to $newfile)." , 'exonn_connector.txt' );

            if ($copyResult === false) {
                $errors = error_get_last();

                exonn_connector_utils::writeToLog( "COPY ERROR: " . $errors['type'] . " : " . $errors['message'], 'exonn_connector.txt' );
            }
            return "err";
        }
    }

    public function storeOldModule($modId, $oldver, $path) {

        $db = oxDb::getDb();

        $oldExistsVer = $db->getOne("select oldversion from exonn_updater where moduleid = '".$modId."'");
        $oldFile = $modId ."_" . $oldExistsVer . ".zip";
        if ($oldFile && file_exists($oldZip = $this->getOldFilesPath() . $oldFile)) {
            unlink($oldZip);
        }
        $db->execute("delete from exonn_updater where moduleid = '".$modId."'");

        $zipPath = $this->getOldFilesPath() . $modId . "_" . $oldver . ".zip";
        $zip = new ZipArchive();
        if ($zip->open($zipPath, ZIPARCHIVE::CREATE) != TRUE) {
            return;
        }
        $this->addDirToZip($path, $zip);
        $zip->close();
        $db->execute("insert into exonn_updater values ('".$modId."', '".$oldver."')");
    }

    private function clearDir($path) {
        if (!$path || strpos($path, "modules") === false) return;
        $files = glob($path.'/*'); // get all file names
        foreach($files as $file){ // iterate files
          if(is_file($file)) {
              if (strpos($file, "license.txt") === false) unlink($file); // delete file
          } else {
              $this->clearDir($file);
              rmdir($file);
          }
        }
    }

    public function deactivateModule($sModule)
    {
        /** @var oxModule $oModule */
        $oModule = oxNew('oxModule');
        if (!$oModule->load($sModule)) {
            return false;
        }
        try {
            $oModule_Main = oxNew("Module_Main");
            $oModule_Main->setEditObjectId($sModule);
            $oModule_Main->deactivateModule();
            oxDb::getDb()->execute("delete from oxtplblocks where OXMODULE='$sModule'");
            //}
        } catch (Exception $oEx) {
            exonn_connector_utils::writeToLog( "deactivateModule: " . $oEx->getLine() . $oEx->getMessage() , 'exonn_connector.txt' );
            return false;
        }
        return true;
    }

    public function tmpClear() {
        $myConfig = $this->getConfig();
        $files = glob($myConfig->getConfigParam( 'sCompileDir' ) . '/*'); // get all file names
        if (is_array($files))
        foreach($files as $file){ // iterate files
          if(is_file($file))
            unlink($file); // delete file
        }
        $files = glob($myConfig->getConfigParam( 'sCompileDir' ) . '/smarty/*'); // get all file names
        if (is_array($files))
        foreach($files as $file){ // iterate files
          if(is_file($file))
            unlink($file); // delete file
        }
    }

    public function updateViews()
    {
        $oMetaData = oxNew('oxDbMetaDataHandler');
        $oMetaData->updateViews();
    }

    public function activateModule($sModule)
    {
        $curl = curl_init();
        $myConfig = $this->getConfig();
        curl_setopt_array($curl, array(
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $url = $myConfig->getConfigParam('sShopURL') . '/index.php?cl=exonn_connector_action&fnc=doActivateModule&sModule=' . urlencode($sModule) . "&check=" . md5($sModule . "exonnconnector"),
            CURLOPT_USERAGENT => ''
        ));
        exonn_connector_utils::writeToLog( date('m/d/Y h:i:s a', time()) . " activate url: " . $url , 'exonn_connector.txt' );

        $resp = curl_exec($curl);
        curl_close($curl);

        try {
            $this->tmpClear();
        } catch (Exception $oEx) {
            $this->_last_error = "cant_clear_tmp";
            exonn_connector_utils::writeToLog( "tmpClear: " . $oEx->getLine() . $oEx->getMessage() , 'exonn_connector.txt' );
        }

        try {
            $this->updateViews();
        } catch (Exception $oEx) {
            $this->_last_error = "cant_update_views";
            exonn_connector_utils::writeToLog( "updateViews: " . $oEx->getLine() . $oEx->getMessage() , 'exonn_connector.txt' );
        }
    }

    public function onActivateEvent($sModuleId) {

        $aModuleEvents = (array) $this->getConfig()->getConfigParam('aModuleEvents');
        $sEvent = "onActivate";
        if (isset($aModuleEvents[$sModuleId], $aModuleEvents[$sModuleId][$sEvent])) {
            $eventCall = $aModuleEvents[$sModuleId][$sEvent];
            $eventClassArr = explode("::", $eventCall);
            $eventClass = $eventClassArr[0];
            if (!class_exists($eventClass)) {
                $aFiles = (array) $this->getConfig()->getConfigParam('aModuleFiles');
                $eventFile = $this->getConfig()->getConfigParam('sShopDir') . "modules/" . $aFiles[$sModuleId][$eventClass];
                if(file_exists($eventFile)) {
                    include_once($eventFile);
                }
            }

            $mEvent = $aModuleEvents[$sModuleId][$sEvent];
            if (is_callable($mEvent)) {
                exonn_connector_utils::writeToLog( "call onActivateEvent: " . $sModuleId , 'exonn_connector.txt' );
                call_user_func($mEvent);
            }
        }
    }

    /**
     * Get module information from server (version, update-history)
     *
     * @param  $modId           exonn-id
     * @param string $nowver    current version
     * @param string $artid
     * @return array|mixed
     */
    public function getServerModInfo($modId, $nowver = "", $artid = "") {
        $reqUrl = "fnc=checkModuleOnUpdates&modid=". urldecode($modId) ."&nowver=" . urldecode($nowver) . "&artid=" . urldecode($artid);
        //echo $reqUrl ."<br/>";
        $res = exonn_connector_utils::curlGetContent($reqUrl);
        $resarr = json_decode($res, true);
        if (is_array($resarr)) {
            return $resarr;
        } else {
            $this->_last_error = "cant_get_module_info";
            exonn_connector_utils::writeToLog( "error: getServerModInfo cant get info\r\n--server return: \r\n" . $res, 'exonn_connector.txt' );
            return array();
        }
    }

    /**
     * Get list of already buyed modules
     *
     * @return array|mixed
     */
    public function getServerModList() {
        $reqUrl = "fnc=getModulesList&url=" . urlencode(exonn_connector_utils::url());
        $res = exonn_connector_utils::curlGetContent($reqUrl);
        $modsinfo = json_decode($res, true);

        if (is_array($modsinfo)) {
            return $modsinfo;
        } else {
            $this->_last_error = "cant_get_module_list";
            exonn_connector_utils::writeToLog( "error: getServerModList cant get list\r\n--server return: \r\n" . $res, 'exonn_connector.txt' );
            return array();
        }
    }

    /**
     * Get list of all available modules (shoplist).
     *
     * @return array|mixed
     */
    public function getServerqAllModList() {
        $reqUrl = "fnc=getAllModulesList&url=" . urlencode(exonn_connector_utils::url());

        $res = exonn_connector_utils::curlGetContent($reqUrl);
        $modsinfo = json_decode($res, true);

        if (is_array($modsinfo)) {
            return $modsinfo;
        } else {
            $this->_last_error = "cant_get_list_all_modules";
            exonn_connector_utils::writeToLog( "error: getServerqAllModList cant get list\r\n--server return: \r\n" . $res, 'exonn_connector.txt' );
            return array();
        }
    }

    /**
     * Sending request to update module.
     * Server will return commaseparated string:  ok/err;link to zip with update
     *
     * @param  $ordernr
     * @return array
     */
    public function sendUpdateRequest($artid) {

        $reqUrl = "fnc=getUpdate&artid=" . urlencode($artid)."&url=" . urlencode(exonn_connector_utils::url())
                  ."&php=".urldecode(exonn_connector_utils::phpver() . "&ioncube=" . exonn_connector_utils::ionnCubeVer());
        //echo $reqUrl;exit;
        $resp = exonn_connector_utils::curlGetContent($reqUrl);
        $result = explode(";", $resp);

        if (is_array($result)) {
            return $result;
        } else {
            exonn_connector_utils::writeToLog( "error: sendUpdateRequest cant get update\r\n--server return: \r\n" . $resp, 'exonn_connector.txt' );
            return array("err", "cant_get_update_content");
        }
    }

    /**
     * Get link to install demo module.
     *
     * @param  $orderInfo
     * @return array
     */
    public function getDemoFromServer($orderInfo) {
        $orderInfoParam = json_encode($orderInfo);
        $reqUrl = "fnc=orderDemo&orderInfo=" . urlencode($orderInfoParam);
        $resp = exonn_connector_utils::curlGetContent($reqUrl);
        //echo $resp;
        $resinfo = explode(";", $resp);
        if (is_array($resinfo)) {
            return $resinfo;
        } else {
            exonn_connector_utils::writeToLog( "error: getDemoFromServer cant get demo\r\n--server return: \r\n" . $resp, 'exonn_connector.txt' );
            return array("err", "cant_get_demo_content");
        }
    }

    public function getLocalModInfo($oModuleId) {
        /**
         * @var oxModule $oModule
         */
        $modInfo = null;

        $oModule = oxNew("oxmodule");
        if ($oModule->load($oModuleId)) {
            //$sModulePath = $oModule->getModuleFullPath( $oModuleId );
            $sModulePath = $oModule->getModulePath( $oModuleId );
            $sModulePath =  $this->getConfig()->getModulesDir() . $sModulePath;

            $sInfoPath = $sModulePath . "/modinfo.php";
            $utils = oxNew("exonn_connector_utils");
            $modInfo = array('id' => $oModuleId,
                      "title" => $oModule->getTitle(),
                      'nowver' => $oModule->getInfo("version"),
                      'path' => $sModulePath,
                      'prevver' => $utils->getPrevVersion($oModuleId),
                      'active' => $oModule->isActive());

            if ( $sModulePath && file_exists( $sInfoPath ) && is_readable( $sInfoPath ) ) {
                include $sInfoPath;
                $modInfo['ordernr'] = $aModuleInfo["version"];
            }
        }
        return $modInfo;
    }

    public static function curlGetContent($url) {
        $url = "https://www.oxidmodule24.de/" . "index.php?cl=autoencoderjob&" . $url;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_ENCODING, 'UTF-8');

        curl_setopt ($ch, CURLOPT_AUTOREFERER, true);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 2);

        $contents = curl_exec($ch);
        if (curl_errno($ch)) {
            exonn_connector_utils::writeToLog("CURL ERROR: " . curl_errno($ch), 'exonn_connector.txt');
            $contents = '';
        } else {
            curl_close($ch);
        }

        if (!is_string($contents) || !strlen($contents)) {
            exonn_connector_utils::writeToLog("Cant get content ($url)", 'exonn_connector.txt');
        }

        $contents = str_replace('\u00c3\u0080', '&Agrave;', $contents);
        $contents = str_replace('\u00c3\u0081', '&Aacute;', $contents);
        $contents = str_replace('\u00c3\u0082', '&Acirc;', $contents);
        $contents = str_replace('\u00c3\u0083', '&Atilde;', $contents);
        $contents = str_replace('\u00c3\u0084', '&Auml;', $contents);
        $contents = str_replace('\u00c3\u0085', '&Aring;', $contents);
        $contents = str_replace('\u00c3\u0086', '&AElig;', $contents);
        $contents = str_replace('\u00c3\u00a0', '&agrave;', $contents);
        $contents = str_replace('\u00c3\u00a1', '&aacute;', $contents);
        $contents = str_replace('\u00c3\u00a2', '&acirc;', $contents);
        $contents = str_replace('\u00c3\u00a3', '&atilde;', $contents);
        $contents = str_replace('\u00c3\u00a4', '&auml;', $contents);
        $contents = str_replace('\u00c3\u00a5', '&aring;', $contents);
        $contents = str_replace('\u00c3\u00a6', '&aelig;', $contents);
        $contents = str_replace('\u00c3\u0087', '&Ccedil;', $contents);
        $contents = str_replace('\u00c3\u00a7', '&ccedil;', $contents);
        $contents = str_replace('\u00c3\u0090', '&ETH;', $contents);
        $contents = str_replace('\u00c3\u00b0', '&eth;', $contents);
        $contents = str_replace('\u00c3\u0088', '&Egrave;', $contents);
        $contents = str_replace('\u00c3\u0089', '&Eacute;', $contents);
        $contents = str_replace('\u00c3\u008a', '&Ecirc;', $contents);
        $contents = str_replace('\u00c3\u008b', '&Euml;', $contents);
        $contents = str_replace('\u00c3\u00a8', '&egrave;', $contents);
        $contents = str_replace('\u00c3\u00a9', '&eacute;', $contents);
        $contents = str_replace('\u00c3\u00aa', '&ecirc;', $contents);
        $contents = str_replace('\u00c3\u00ab', '&euml;', $contents);
        $contents = str_replace('\u00c3\u008c', '&Igrave;', $contents);
        $contents = str_replace('\u00c3\u008d', '&Iacute;', $contents);
        $contents = str_replace('\u00c3\u008e', '&Icirc;', $contents);
        $contents = str_replace('\u00c3\u008f', '&Iuml;', $contents);
        $contents = str_replace('\u00c3\u00ac', '&igrave;', $contents);
        $contents = str_replace('\u00c3\u00ad', '&iacute;', $contents);
        $contents = str_replace('\u00c3\u00ae', '&icirc;', $contents);
        $contents = str_replace('\u00c3\u00af', '&iuml;', $contents);
        $contents = str_replace('\u00c3\u0091', '&Ntilde;', $contents);
        $contents = str_replace('\u00c3\u00b1', '&ntilde;', $contents);
        $contents = str_replace('\u00c3\u0092', '&Ograve;', $contents);
        $contents = str_replace('\u00c3\u0093', '&Oacute;', $contents);
        $contents = str_replace('\u00c3\u0094', '&Ocirc;', $contents);
        $contents = str_replace('\u00c3\u0095', '&Otilde;', $contents);
        $contents = str_replace('\u00c3\u0096', '&Ouml;', $contents);
        $contents = str_replace('\u00c3\u0098', '&Oslash;', $contents);
        $contents = str_replace('\u00c5\u0092', '&OElig;', $contents);
        $contents = str_replace('\u00c3\u00b2', '&ograve;', $contents);
        $contents = str_replace('\u00c3\u00b3', '&oacute;', $contents);
        $contents = str_replace('\u00c3\u00b4', '&ocirc;', $contents);
        $contents = str_replace('\u00c3\u00b5', '&otilde;', $contents);
        $contents = str_replace('\u00c3\u00b6', '&ouml;', $contents);
        $contents = str_replace('\u00c3\u00b8', '&oslash;', $contents);
        $contents = str_replace('\u00c5\u0093', '&oelig;', $contents);
        $contents = str_replace('\u00c3\u0099', '&Ugrave;', $contents);
        $contents = str_replace('\u00c3\u009a', '&Uacute;', $contents);
        $contents = str_replace('\u00c3\u009b', '&Ucirc;', $contents);
        $contents = str_replace('\u00c3\u009c', '&Uuml;', $contents);
        $contents = str_replace('\u00c3\u00b9', '&ugrave;', $contents);
        $contents = str_replace('\u00c3\u00ba', '&uacute;', $contents);
        $contents = str_replace('\u00c3\u00bb', '&ucirc;', $contents);
        $contents = str_replace('\u00c3\u00bc', '&uuml;', $contents);
        $contents = str_replace('\u00c3\u009d', '&Yacute;', $contents);
        $contents = str_replace('\u00c5\u00b8', '&Yuml;', $contents);
        $contents = str_replace('\u00c3\u00bd', '&yacute;', $contents);
        $contents = str_replace('\u00c3\u00bf', '&yuml;', $contents);
        return $contents;
    }

    public static function writeToLog($msg) {
        oxRegistry::getUtils()->writeToLog( date("Y-m-d H:i:s") . ": " .  $msg . "\r\n", 'exonn_connector.txt' );
    }
}
 
