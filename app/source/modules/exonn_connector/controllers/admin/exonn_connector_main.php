<?php

class exonn_connector_main extends oxAdminDetails
{

    public function render()
    {
        parent::render();
        $utils = oxNew("exonn_connector_utils");

        if ($this->selfUpdate() == 1) {
            $this->_aViewData["reload"] = 1;

            $utils->updateViews();
            $utils->tmpClear();
        }

        $this->_aViewData["installed"] = $this->getInstalledModules();
        $this->_aViewData["rights"] = $utils->checkRights();

        $selfInfo = $utils->getLocalModInfo("exonn_connector");

        $this->_aViewData["selfversion"] = $selfInfo["nowver"];
        if ($this->_aViewData["updatenav"]) {
            $utils->updateViews();
            $utils->tmpClear();
        }
        return "exonn_connector_main.tpl";
    }

    public function updateLastError($err, $info) {
        $this->_aViewData["lasterr"] = $this->_aViewData["lasterr"] ? $this->_aViewData["lasterr"] : $err;
        $this->_aViewData["lasterr_info"] = $this->_aViewData["lasterr_info"] ? $this->_aViewData["lasterr_info"] : $info;
    }

    public function sendSupportEmail() {
        $utils = oxNew("exonn_connector_utils");
        $utils->sendSupportEmail();
        $this->_aViewData["email_sent"] = 1;
    }

    private function selfUpdate() {
        $db = oxDb::getDb();
        $utils = oxNew("exonn_connector_utils");
        if ($db->getOne("select 1 from exonn_selfupdate where inprocess=1")) {
            $utils->afterSelfUpdate();
            $db->execute("delete from exonn_selfupdate");
            $utils->tmpClear();
            $utils->updateViews();
            return 0;
        } else {
            $updater = oxNew("exonn_connector_update");
            $selfInfo = $utils->getLocalModInfo("exonn_connector");
            $result = $updater->selfUpdate(exonn_connector_utils::phpver(), $selfInfo["nowver"], exonn_connector_utils::ionnCubeVer());
            if ($result == -1) {
                $this->updateLastError("cant_self_update", $updater->_last_error_info);
                return -1;
            } else return $result;
        }
    }



    public function updateModules() { 

        $result = array();
        $myConfig = $this->getConfig();

        if ($myConfig->getRequestParameter("testfunctions")) {
            $this->testfunctions();
            return;
        }

        exonn_connector_utils::writeToLog( "--------------------------" . "\r\n", 'exonn_connector.txt' );

        $action = "";
        if ($actionId = $myConfig->getRequestParameter("update_module")) {
            $action = "update";
        } elseif ($actionId = $myConfig->getRequestParameter("install_module")) {
            $action = "install";
        } elseif ($actionId = $myConfig->getRequestParameter("update_request")) {
            $action = "request";
        } elseif ($actionId = $myConfig->getRequestParameter("restore_module")) {
            $action = "restore";
        }
        exonn_connector_utils::writeToLog( "Start updateModules: " . $action, 'exonn_connector.txt' );
        /**
         * @var exonn_connector_utils $utils
         */
        $utils = oxNew("exonn_connector_utils");

        if ($actionId) {
            $actionIdArr = explode("-", $actionId);
            $modId = $actionIdArr[1];
            $artid = $actionIdArr[0];
            $servModInfo = $utils->getServerModInfo($modId);

            $this->_aViewData["installedModInfo"] = $servModInfo;
            $this->_aViewData["modTitle"] = $servModInfo["title"];
        }
        if ($action == "restore") {
            $modInfo = $utils->getLocalModInfo($modId = $actionId);
            try {
                $utils->deactivateModule($modId);
            } catch (oxException $e) {

            }
            $utils->restoreOldModule($modId, $modInfo["path"]);
            $this->_aViewData["updatenav"] = "1";
            $this->updateLastError($utils->_last_error, "");

            exonn_connector_utils::writeToLog( "Restore OK ", 'exonn_connector.txt' );
            $update = "ok";
        } elseif ($action == "request") {
            $oEmail = oxNew( 'oxemail' );
            $subj = "Url: " . exonn_connector_utils::url() . "\r\n";
            $subj .= "PHP: " . exonn_connector_utils::phpver() . "\r\n";
            $subj .= "ionCube: " . exonn_connector_utils::ionnCubeVer() . "\r\n";
            $subj .= "Shop version: " . $this->getShopVersion() . "\r\n";
            $subj .= "Modul: " . $actionId . "\r\n";
            $oEmail->sendEmail("support@exonn.de", "Update anfrage " . exonn_connector_utils::url(), $subj);
            oxDb::getDb()->execute("insert into exonn_updaterequest (moduleid) VALUES ('".$actionId."')");
            $update = "ok";
        } elseif ($action) {
            $update = $utils->sendUpdateRequest($artid);

            exonn_connector_utils::writeToLog( "Update request result: " . print_r($update,1), 'exonn_connector.txt' );
            if ($update[0] == "ok") {
                $extFile = $update[2];
                $modInfo = array();

                if ($action == "update") {
                    if (!($modInfo = $utils->getLocalModInfo($modId))) return;
                    $path = $modInfo["path"];
                }

                if ($action == "install") {
                    $path = $this->getConfig()->getModulesDir() . $modId;
                }

                if (file_exists($path) && ($errFile = $utils->checkModuleRights($path))) {
                    exonn_connector_utils::writeToLog( "Wrong file rights: " . $errFile , 'exonn_connector.txt' );
                    $this->_aViewData["rights_updaterr"] = $errFile;
                    return false;
                }

                $utilsPath = $this->getConfig()->getModulesDir() . "/exonnutils";
                if (file_exists($utilsPath) && ($errFile = $utils->checkModuleRights($utilsPath))) {
                    exonn_connector_utils::writeToLog( "Wrong file rights: " . $errFile, 'exonn_connector.txt' );
                    $this->_aViewData["rights_updaterr"] = $errFile;
                    return false;
                }

                $update = $utils->installModule($modId, $path, $extFile, $action == "update", $modInfo["nowver"], $modInfo["newver"]);

                if ($update != "err") {
                    $this->_aViewData["updatenav"] = "1";
                    $this->_aViewData["installedModInfo"] = $utils->getLocalModInfo($modId);
                }
                $this->updateLastError($utils->_last_error, $utils->_last_error_info);
            } else {
                $this->updateLastError($update[1], "");
                exonn_connector_utils::writeToLog( "updateModules: " . $update[1], 'exonn_connector.txt' );
                $update = "err";
            }
        }
        $this->_aViewData["updateres"] = $update;
        $this->_aViewData["lastaction"] = $action;
    }

    public function testfunctions() {
        $myConfig = $this->getConfig();
        $actionId = $myConfig->getRequestParameter("testfunctions");
        /**
         * @var $utils exonn_connector_utils
         */
        $utils = oxNew("exonn_connector_utils");
        $utils->activateModule($actionId);
    }

    private function findServerModInfo($serverModList, $modid) {
        foreach ($serverModList as $key => $modInfo) {
            if ($modInfo["id"] == $modid) {
                $modInfo["installed"] = $key;
                return $modInfo;
            }
        }
        return "";
    }

    public function getInstalledModules() {
        $result = array();

        /**
         * @var exonn_connector_utils $utils
         */
        $utils = oxNew("exonn_connector_utils");
        $serverModList = $utils->getServerModList();

        $this->updateLastError($utils->_last_error, $utils->_last_error_info);

        $requested = oxDb::getDb()->getAll("select moduleid from exonn_updaterequest");

        /**
         * @var oxModuleList $oModuleList
         */
        $sModulesDir = $this->getConfig()->getModulesDir();
        $oModuleList = oxNew( "oxModuleList" );
        $aModules = $oModuleList->getModulesFromDir( $sModulesDir );

        $myConfig = $this->getConfig();
        foreach ($aModules as $oModuleId => $oModule) {
            if ($oModuleId == "exonn_connector") continue;
            if ($oModuleId == "exonnutils") continue;

            if (strpos($oModuleId, "exonn") !== false) {
                $modInfo = $utils->getLocalModInfo($oModuleId);
                $modInfo['installed'] = true;
                if (file_exists($myConfig->getConfigParam("sShopDir") . "/modules/" . $oModuleId . "/readme.txt")) {
                    $modInfo['readme'] = $myConfig->getConfigParam("sShopURL") . "/modules/" . $oModuleId . "/readme.txt";
                }

                if (is_array($serverModList) && $serverInfo = $this->findServerModInfo($serverModList, $oModuleId)) {

                    $modInfo['newver'] = $serverInfo["newver"];
                    $modInfo['mustpaid'] = $serverInfo["mustpaid"];
                    $modInfo['paylink'] = $serverInfo["paylink"];
                    $modInfo['notpaid'] = $serverInfo["notpaid"];
                    $modInfo['valid'] = $serverInfo["valid"];
                    $modInfo['artid'] = $serverInfo["artid"];
                    $modInfo['trial'] = $serverInfo["trial"];
                    $modInfo['trialdownloaded'] = $serverInfo["trialdownloaded"];
                    $modInfo['daysLeft'] = $serverInfo["daysLeft"];
                    $modInfo['docs'] = $serverInfo["docs"];
                    $modInfo['installed'] = true;

                    $serverModList[$serverInfo["installed"]]["installed"] = true;
                    if ($serverInfo["title"]) {
                        $modInfo['title'] = $serverInfo["title"];
                    }
                }
                //get extended module info from server
                if ($exServerInfo = $utils->getServerModInfo($oModuleId, $modInfo['nowver'], $modInfo['artid'])) {
                    //print_r($exServerInfo);
                    $modInfo['newver'] = $exServerInfo["newver"];
                    if ($exServerInfo["title"]) {
                        $modInfo['title'] = $exServerInfo["title"];
                    }
                    $brief = $exServerInfo["brief"];
                    $brieText = "";
                    if (is_array($brief) && count($brief)) {
                        $brieTextStart = "<table border='1' width='100%' cellspacing='0' cellpadding='4'><tr><th width='20%'>Version</th><th>Info</th></tr>";
                        foreach($brief as $row) {
                            if (trim($row["text"])) {
                                if (!$myConfig->isUtf()) $row["text"] = utf8_decode($row["text"]);
                                $brieText .= "<tr><td valign='top'>" . $row["ver"] . "</td><td>" . $row["text"] . "</td></tr>";
                            }
                        }
                        if ($brieText) {
                            $brieText = $brieTextStart . $brieText . "</table>";
                        }
                    }
                    $modInfo['brief'] = str_replace("'", "", $brieText);
                    $modInfo['brief'] = str_replace('"', '', $modInfo['brief']);
                    $modInfo['brief'] = preg_replace('/\s\s+/', '',$modInfo['brief']);
                }

                if (is_array($requested))
                    foreach ($requested as $row) {
                        if ($row[0] == $oModuleId) {
                            $modInfo['requested'] = 1;
                        }
                    }
                $result[] = $modInfo;
            }
        }


        foreach($serverModList as $serverInfo) {
            if (!$serverInfo["installed"]) {
                $result[] = $serverInfo;
            }
        }
        //print_r( $result);
        return $result;
    }


}