<?php

class exonn_connector_shop extends oxAdminDetails
{

    public function render()
    {
        parent::render();
        $myConfig = $this->getConfig();
        $this->_aViewData["modules"] = $this->getModules();
        $this->_aViewData["shop"] = $myConfig->getActiveShop();
        $this->_aViewData["shop_url"] = $_SERVER['SERVER_NAME'];
        $utils = oxNew("exonn_connector_utils");
        if ($this->_aViewData["updatenav"]) {
            $utils->updateViews();
            $utils->tmpClear();
        }

        $selfInfo = $utils->getLocalModInfo("exonn_connector");
        $this->_aViewData["selfversion"] = $selfInfo["nowver"];
        return "exonn_connector_shop.tpl";
    }

    public function updateLastError($err, $info = "") {
        $this->_aViewData["lasterr"] = $this->_aViewData["lasterr"] ? $this->_aViewData["lasterr"] : $err;
        $this->_aViewData["lasterr_info"] = $this->_aViewData["lasterr_info"] ? $this->_aViewData["lasterr_info"] : $info;
    }

    public function getDemoFromServer($orderInfo) {
        /**
         * @var exonn_connector_utils $utils
         */
        $utils = oxNew("exonn_connector_utils");
        $resinfo = $utils->getDemoFromServer($orderInfo);

        if ($resinfo[0] == "ok") {
            return $resinfo;
        } else {
            $this->updateLastError($resinfo[1]);
            exonn_connector_utils::writeToLog( "Get demo error: " . $resinfo[1], 'exonn_connector.txt' );
            return "";
        }
    }

    public function orderDemo() {
        $myConfig = $this->getConfig();
        $demoorder = $myConfig->getRequestParameter("demoorder");
        $demoorder["url"] = exonn_connector_utils::url();
        $demoorder["php"] = exonn_connector_utils::phpver();
        $demoorder["ioncube"] = exonn_connector_utils::ionnCubeVer();

        /**
         * @var exonn_connector_utils $utils
         */
        $utils = oxNew("exonn_connector_utils");
        $servModInfo = $utils->getServerModInfo($demoorder['modid'], $demoorder["php"], $demoorder["artid"]);
        $this->_aViewData["modTitle"] = $servModInfo["title"];
        $this->_aViewData["installedModInfo"] = $servModInfo;

        if ($demo = $this->getDemoFromServer($demoorder)) {
            $extFile = $demo[2];
            $modId = $demo[1];

            exonn_connector_utils::writeToLog( "Start install demo: " . $modId, 'exonn_connector.txt' );

            $path = $this->getConfig()->getModulesDir() . $modId;

            $utilsPath = $this->getConfig()->getModulesDir() . "/exonnutils";
            if (file_exists($utilsPath) && ($errFile = $utils->checkModuleRights($utilsPath))) {
                exonn_connector_utils::writeToLog( "Wrong file rights: " . $errFile, 'exonn_connector.txt' );
                $this->_aViewData["rights_updaterr"] = $errFile;
                return false;
            }

            $update = $utils->installModule($modId, $path, $extFile);

            if ($update != "err") {
                $this->_aViewData["updateres"] = "ok";
                $this->_aViewData["updatenav"] = "1";
                $this->_aViewData["installedModInfo"] = $utils->getLocalModInfo($modId);
                exonn_connector_utils::writeToLog( "Install demo ok", 'exonn_connector.txt' );
            } else {
                exonn_connector_utils::writeToLog( "Install demo error: " . $utils->_last_error, 'exonn_connector.txt' );
                $this->updateLastError($utils->_last_error, $utils->_last_error_info);
            }
        } else {
            $this->_aViewData["updateres"] = "err";
        }
    }

    public function sendSupportEmail() {
        $utils = oxNew("exonn_connector_utils");
        $utils->sendSupportEmail();
        $this->_aViewData["email_sent"] = 1;
    }

    public function getModules() {
        $sModulesDir = $this->getConfig()->getModulesDir();
        $oModuleList = oxNew( "oxModuleList" );
        $aModules = $oModuleList->getModulesFromDir( $sModulesDir );
        $myConfig = $this->getConfig();

        /**
         * @var $utils exonn_connector_utils
         */
        $utils = oxNew("exonn_connector_utils");
        $userModList = $utils->getServerModList();
        $serverModList = $utils->getServerqAllModList();

        $this->updateLastError($utils->_last_error, $utils->_last_error_info);

        foreach($serverModList as $key => $modInfo) {
            $jsversions = "";
            $i = 0;
            foreach($modInfo["versions"] as $vers) {
                $jsversions .= "pos" . $i . ": {ver: '" . $vers["ver"] . "', id: '" . $vers["id"] . "'},";
                $i++;
            }
            $modInfo["jsvers"] = "{" . $jsversions . "}";
            if ($userInfo = $userModList[$modInfo["id"]]) {
                $modInfo['trial'] = $userInfo["trial"];
                $modInfo['trialdownloaded'] = $userInfo["trialdownloaded"];
            }

            if ($aModules[$modInfo["id"]]) {
                    $modInfo["installed"] = 1;
            }
            if (!$myConfig->iUtfMode) {
                $modInfo["desc"] = mb_convert_encoding($modInfo["desc"], "ISO-8859-1", "UTF-8");
            }
            $serverModList[$key] = $modInfo;
        }

        return $serverModList;
    }


}