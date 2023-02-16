<?php

class exonn_connector_action extends oxUBase
{

    public function doActivateModule() {
        $myConfig = $this->getConfig();
        $sModule = $myConfig->getRequestParameter("sModule");
        $check = $myConfig->getRequestParameter("check");
        if ($check != md5($sModule . "exonnconnector"))exit;

        /** @var oxModule $oModule */
        $oModule = oxNew('oxModule');
        if (!$oModule->load($sModule)) {
            exit;
        }

        //if ($oModule->isActive()) exit;

        try {
            oxRegistry::getUtils()->writeToLog( "Start activateModule: " . $sModule . "\r\n", 'exonn_connector.txt' );
            $oModule_Main = oxNew("Module_Main");
            echo "Create class" . "<br>";
            $oModule_Main->setEditObjectId($sModule);
            echo "set id $sModule" . "<br>";
            $oModule_Main->activateModule();
            echo "activate ok" . "<br>";
            oxRegistry::getUtils()->writeToLog( "(" . date('m/d/Y h:i:s a', time()) . ") End activateModule: " . $sModule . "\r\n", 'exonn_connector.txt' );
            //$this->onActivateEvent($sModule);
        } catch (Exception $oEx) {
            oxRegistry::getUtils()->writeToLog( "activateModule: " . $oEx->getLine() . $oEx->getMessage() . "\r\n", 'exonn_connector.txt' );
        }
        echo "ok";
        exit;
    }

    public function doDeactivateModule() {

        $myConfig = $this->getConfig();
        $sModule = $myConfig->getRequestParameter("sModule");
        $check = $myConfig->getRequestParameter("check");
        if ($check != md5($sModule . "exonnconnector"))exit;

        oxRegistry::getUtils()->writeToLog( "doDeactivateModule: " . $sModule . "\r\n", 'exonn_connector.txt' );

        /** @var oxModule $oModule */
        $oModule = oxNew('oxModule');
        if (!$oModule->load($sModule)) {
            exit;
        }

        if (!$oModule->isActive()) exit;

        try {
            oxRegistry::getUtils()->writeToLog( "Start deactivateModule: " . $sModule . "\r\n", 'exonn_connector.txt' );
            /**
             * @var $oModule_Main Module_Main
             */
            $oModule_Main = oxNew("Module_Main");
            echo "Create class" . "<br>";
            $oModule_Main->setEditObjectId($sModule);
            echo "set id $sModule" . "<br>";
            $oModule_Main->deactivateModule();
            echo "deactivate ok" . "<br>";
            oxRegistry::getUtils()->writeToLog( "(" . date('m/d/Y h:i:s a', time()) . ") End deactivateModule: " . $sModule . "\r\n", 'exonn_connector.txt' );
            //$this->onActivateEvent($sModule);
        } catch (Exception $oEx) {
            oxRegistry::getUtils()->writeToLog( "deactivateModule: " . $oEx->getLine() . $oEx->getMessage() . "\r\n", 'exonn_connector.txt' );
        }
        echo "ok";
        exit;
    }
}