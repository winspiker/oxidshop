<?php

class exonn_basketmix_event extends oxBase
{
    static function onDeactivate()
    {
        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_basketmix';");
        } catch (Exception $e) {

        }
    }

	static function onActivate()
	{
        $oDb = oxDb::getDb();

        try {
            $oDb->execute("ALTER TABLE  `oxcategories` ADD  `oxonlysingle` TINYINT(1) NOT NULL");
        } catch(Exception $e){}
    }
}