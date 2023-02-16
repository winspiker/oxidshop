<?php

class exonn_connector_event extends oxBase
{
	public static function onDeactivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONN_CONNECTOR_IS_ACTIVE', false );
	}
	
	public static function onActivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONN_CONNECTOR_IS_ACTIVE', true );


        $oDb = oxDb::getDb();
        try {
        $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_updater` (
            moduleid varchar (50) NOT NULL default '',
            oldversion varchar (50) NOT NULL default ''
        );");
        } catch (Exception $e) {}

        try {
        $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_updaterequest` (
            moduleid varchar (50) NOT NULL default '',
            reqdate timestamp NOT NULL default CURRENT_TIMESTAMP
        );");
        } catch (Exception $e) {}

        try {
        $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_selfupdate` (
            inprocess tinyint (1)
        );");
        } catch (Exception $e) {}
	}
}