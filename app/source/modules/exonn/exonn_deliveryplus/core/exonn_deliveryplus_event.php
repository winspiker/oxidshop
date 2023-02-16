<?php

/*
    'events'       => array(
    	'onActivate' 	=> 'exonn_deliveryext_event::onActivate',
		'onDeactivate' 	=> 'exonn_deliveryext_event::onDeactivate',
        ),
        
    to files
    'exonn_deliveryext_event' => 'exonn_deliveryext/core/exonn_deliveryext_event.php',    
*/
class exonn_deliveryplus_event extends oxBase
{


    public static function onDeactivate()
    {
        $myConfig = oxRegistry::getConfig();

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_deliveryplus';");
        } catch (Exception $e) {

        }

    }

	public static function onActivate()
    {
        $myConfig = oxRegistry::getConfig();

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("
                ALTER TABLE oxdelivery ADD (
                    `oxdelservice` varchar (30) NOT NULL
                    );");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute($q = "
                CREATE TABLE oxdelivery2order (
                    `oxid` char (32) NOT NULL,
                    `oxorderid` char (32) NOT NULL,
                    `oxdeliveryid` char (32) NOT NULL,
                    `oxarticleid` char (32) NOT NULL
                    );");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute($q = "
                ALTER TABLE `oxdelivery2order`
                  ADD PRIMARY KEY `oxid` (`oxid`);");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute($q = "
                CREATE TABLE oxdelivery2order (
                    `oxid` char (32) NOT NULL,
                    `oxorderid` char (32) NOT NULL,
                    `oxdeliveryid` char (32) NOT NULL,
                    `oxarticleid` char (32) NOT NULL,
                    PRIMARY KEY (`OXID`)
                    );");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE  `oxarticles` ADD  (`oxpackets` TINYINT( 3 ) NOT NULL,
                                                            addweight VARCHAR (250) NOT NULL );");
        } catch (Exception $e) {

        }


        try {
            $oDb->execute($q = "CREATE TABLE  `oxdeliverylabels` (
                `oxid` char (32) NOT NULL,
                `oxorderid` char (32) NOT NULL,
                `oxartid` char (32) NOT NULL,
                `oxartamount` int (3) NOT NULL,
                `oxartweight` DOUBLE NOT NULL DEFAULT 0,
                `oxlabelid` VARCHAR(128) NOT NULL,
                `oxtrackcode` VARCHAR(128) NOT NULL,
                `oxlabelurl` TEXT NOT NULL,
                `oxlabelinfo` VARCHAR(250) NOT NULL,
                `oxlabelerr` text NOT NULL,
                `oxweight` DOUBLE NOT NULL DEFAULT 0,
                `oxcodsum` double NOT NULL DEFAULT 0,
                `oxdelservice` VARCHAR(50) NOT NULL,
                `oxlabelgroup` CHAR(32) NOT NULL,
                `OXTIMESTAMP` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

                 PRIMARY KEY (`OXID`));");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD  (`oxposprice` DOUBLE NOT NULL DEFAULT 0);");
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD  (`oxcanceled` TINYINT(1) NOT NULL DEFAULT 0);");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD  (`oxdeliveryid` char (32) NOT NULL DEFAULT '');");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxdocsurl` TEXT NOT NULL DEFAULT ''");
        } catch (Exception $e) {

        }try {
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxdocs2url` TEXT NOT NULL DEFAULT ''");
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxmainlabelid` TEXT NOT NULL DEFAULT ''");
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxurltype` TEXT NOT NULL DEFAULT ''");
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxarttitle` TEXT NOT NULL DEFAULT ''");
            $oDb->execute("ALTER TABLE  `oxdeliverylabels` ADD `oxartnum` TEXT NOT NULL DEFAULT ''");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE oxdelivery ADD (`DHLISPARTNER_ID` VARCHAR(128) NOT NULL,
                                                `DHLISPROD_CODE` VARCHAR(128) NOT NULL);");
        } catch (Exception $e) {

        }
        try {
            $oDb->execute("ALTER TABLE oxpayments ADD (
                                                   dhliscod int(1) NOT NULL);");
        } catch (Exception $e) {

        }

        try {
        $oDb->execute("ALTER TABLE oxcountry ADD `oxeuropunion` tinyint (1)");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("ALTER TABLE oxarticles ADD (`DHLISTITLE` VARCHAR(40) NOT NULL,
                                                   `DHLISORIGNCOUNTRY` VARCHAR(2) NOT NULL,
                                                   `DHLISCOMMODITYCODE` VARCHAR(30) NOT NULL);");
        } catch (Exception $e) {

        }
    }
}