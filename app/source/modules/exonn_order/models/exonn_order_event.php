<?php

class exonn_order_event extends oxBase
{
    public static function onDeactivate()
    {
        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_order';");
        } catch (Exception $e) {

        }
    }

	public static function onActivate()
	{
        $oDb = oxDb::getDb();



        $oConfig = oxRegistry::getConfig();
        require_once $oConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules'.DIRECTORY_SEPARATOR."exonnutils".DIRECTORY_SEPARATOR."exonnutils.php";

        exonnutils::tmpClear();

        $oMetaData = oxNew('oxDbMetaDataHandler');
        $oMetaData->updateViews();


    }

}