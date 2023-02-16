<?php

class exonn_cb_event extends oxBase
{
	public static function onDeactivate()
	{
        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from oxtplblocks where oxmodule='exonn_cb'");
        } catch (Exception $e) {
        }

	}
	
	public static function onActivate()
	{
        $oDb = oxDb::getDb();
        try {
            $oDb->execute('CREATE TABLE IF NOT EXISTS `cb_contents` (`OXID` char(32) not null,`oxshopid` char(32) not null, cbid varchar (50) not null, content text not null)');
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `cb_contents` ADD (oxshopid char(32) not null)");
        } catch (Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `cb_contents` ADD (content_1 text not null, content_2 text not null, content_3 text not null)");
        } catch (Exception $e){}
        
        $oConfig = oxRegistry::getConfig();


        require_once $oConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules'.DIRECTORY_SEPARATOR."exonnutils".DIRECTORY_SEPARATOR."exonnutils.php";

        exonnutils::tmpClear();

        $oMetaData = oxNew('oxDbMetaDataHandler');
        $oMetaData->updateViews();


    }
}