<?php

class exonn_connector_update extends oxBase {
    var $_last_error_info = "";

    public function selfUpdate($php, $curVersion, $ionCube) {
        $reqUrl = "fnc=getSelfUpdate&php=".$php."&nowver=".$curVersion . "&ioncube=" . $ionCube;

        $resp = exonn_connector_utils::curlGetContent($reqUrl);
        $result = json_decode($resp, true);
        if (is_array($result) && $result["new"] == 1) {
            $extFile = $result["file"];

            $utils = oxNew("exonn_connector_utils");

            $myConfig = $this->getConfig();
            $path = $myConfig->getConfigParam("sShopDir") . '/modules/exonn_connector/';
            $newfile = $myConfig->getConfigParam("sShopDir") . '/modules/exonn_connector/tmp/connector.zip';

            if ($errFile = $utils->checkModuleRights($path)) {
                $this->_last_error_info = $errFile;
                $this->_last_error = "cant_copy_update";
                return -1;
            }

            $utils->beforeSelfUpdate();
            if ( copy($extFile, $newfile) ) {
                $zip = new ZipArchive();
                if ($zip->open($newfile) === TRUE) {
                    try {
                        $zip->extractTo($path);
                        oxDb::getDb()->execute("delete from exonn_selfupdate");
                        oxDb::getDb()->execute("insert into exonn_selfupdate values (1)");
                        return 1;
                    } catch (Exception $ex) {
                        exonn_connector_utils::writeToLog( "selfUpdate: " . $ex->getLine() . $ex->getMessage(), 'exonn_connector.txt' );
                        return -1;
                    }
                }
            }
        }
        return 0;
    }
}
 
