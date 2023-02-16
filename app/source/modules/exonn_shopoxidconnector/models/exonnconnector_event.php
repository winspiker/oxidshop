<?php

class exonnconnector_event extends oxBase
{
	public static function onDeactivate()
	{
        $myConfig = oxRegistry::getConfig();

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_shopoxidconnector';");
        } catch (Exception $e) {

        }

	}
	
	public static function onActivate()
	{

        $oDb = oxDb::getDb();


        /* payment usergroups */

        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `oxlongdescusergroup_1` TEXT NOT NULL");
            $oDb->execute("ALTER TABLE `oxpayments` ADD `oxlongdescusergroup_2` TEXT NOT NULL");
            $oDb->execute("ALTER TABLE `oxpayments` ADD `oxlongdescusergroup_3` TEXT NOT NULL");
        } catch(Exception $e){}

        try {
            $oDb->execute("ALTER TABLE  `oxpaymentamount2group` CHANGE  `connectortimestamp`  `connectortimestamp` DATETIME NOT NULL");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `oxpaymentamount2group` (
  `OXID` char(32) NOT NULL COMMENT 'Record id',
  `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXOBJECTID` char(32) NOT NULL DEFAULT '' COMMENT 'User id',
  `OXGROUPSID` char(32) NOT NULL DEFAULT '' COMMENT 'Group id',
  `OXTIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp',
  `connectortimestamp` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `connector_update` tinyint(4) NOT NULL,
  `exformtimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`OXID`),
  UNIQUE KEY `UNIQ_OBJECTGROUP` (`OXGROUPSID`,`OXOBJECTID`,`OXSHOPID`),
  KEY `OXOBJECTID` (`OXOBJECTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;");
        } catch(Exception $e){}


        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `oxfromamountusergroup` DOUBLE NOT NULL ,
ADD `oxtoamountusergroup` DOUBLE NOT NULL");
        } catch(Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `oxlongdescusergroup` TEXT NOT NULL");
        } catch(Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `oxpaymentamount2group` ADD `oxtype` VARCHAR( 20 ) NOT NULL AFTER `OXGROUPSID`");
        } catch(Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `oxpaymentamount2group` DROP INDEX `UNIQ_OBJECTGROUP`;");
        } catch(Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `oxpaymentamount2group` ADD UNIQUE( `OXSHOPID`, `OXOBJECTID`, `OXGROUPSID`, `oxtype`);");
        } catch(Exception $e){}


        // end *****************


        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `oxbankingkonten` (
  `oxid` varchar(32) COLLATE latin1_general_ci NOT NULL,
  `kontotype` enum('bank','paypal') COLLATE latin1_general_ci NOT NULL DEFAULT 'bank',
  `oxkontonum` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `blz` varchar(8) COLLATE latin1_general_ci NOT NULL,
  `bankname` varchar(150) CHARACTER SET utf8 NOT NULL,
  `username` varchar(30) COLLATE latin1_general_ci NOT NULL,
  `komment` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `hbciurl` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `paypal_email` varchar(150) COLLATE latin1_general_ci NOT NULL,
  `paypal_username` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `paypal_password` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `paypal_signature` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `usertitle` varchar(50) COLLATE latin1_general_ci NOT NULL,
  `hbciversion` int(11) NOT NULL,
  `oxiban` varchar(60) COLLATE latin1_general_ci NOT NULL,
  `oxbic` varchar(60) COLLATE latin1_general_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;");
        } catch (Exception $e) {
        }



        $oAPI = oxNew("exonnconnector_oxid");
        $aTables = array_merge(
            $oAPI->getExportTables(),
            $oAPI->getImportTables(),
            $oAPI->getImportExportTables(),
            $oAPI->getFirstInstallArticles(),
            $oAPI->getFirstInstallOrder()
        );

        foreach($aTables as $sTable => $val) {

            try {
                $oDb->execute("ALTER TABLE  `".$sTable."` CHANGE  `connectortimestamp`  `connectortimestamp` DATETIME NOT NULL");
            } catch (Exception $e) {
            }

            try {
                $oDb->execute("ALTER TABLE  `".$sTable."` ADD  `connectortimestamp` DATETIME NOT NULL ");
            } catch (Exception $e) {
            }


            try {
                $oDb->execute("ALTER TABLE  `".$sTable."` ADD  `connector_update` TINYINT NOT NULL ");
            } catch (Exception $e) {
            }
            try {
                $oDb->execute("ALTER TABLE `oxcategories` CHANGE `connector_update` `connector_update` TINYINT(4)  NULL DEFAULT '0';");
            } catch (Exception $e) {
            }

            try {

                $oDb->execute("CREATE TRIGGER `".$sTable."_insert` BEFORE INSERT ON  `".$sTable."`
FOR EACH
ROW IF NEW.connector_update =1 THEN SET NEW.connector_update =0;

ELSE SET NEW.connectortimestamp = NOW( ) ;

END IF ;
");
            } catch (Exception $e) {
            }



            try {

                $oDb->execute("CREATE TRIGGER `".$sTable."_update` BEFORE UPDATE ON  `".$sTable."` FOR EACH ROW IF NEW.connector_update =1 THEN SET NEW.connector_update =0;

ELSE SET NEW.connectortimestamp = NOW( ) ;

END IF ;
");
            } catch (Exception $e) {
            }


        }


        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `exonnwawi_config` (
  `oxvar` varchar(70) COLLATE latin1_general_ci NOT NULL,
  `oxvalue` varchar(50) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`oxvar`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `exonnwawi_config` ADD PRIMARY KEY(`oxvar`);");
        } catch (Exception $e) {
        }


        try {
            if ($oDb->execute("ALTER TABLE `oxorderarticles` ADD `oxstockcondition` VARCHAR( 30 ) NOT NULL;")) {
                $oDb->execute("update `oxorderarticles` set `oxstockcondition`='Neu' ");
            }

        } catch (Exception $e) {

        }


        try {

            $oDb->execute("DROP TRIGGER IF EXISTS `oxorderarticles_insert`;");

            $oDb->execute("CREATE TRIGGER `oxorderarticles_insert` BEFORE INSERT ON `oxorderarticles` FOR EACH ROW IF NEW.connector_update =1 THEN SET NEW.connector_update =0, NEW.oxstockcondition ='Neu';

ELSE SET NEW.connectortimestamp = NOW( ), NEW.oxstockcondition ='Neu' ;

END IF
");
        } catch (Exception $e) {
        }


        // wenn module sofortüberweisung löscht eine zeile, die muss auch in wawi gelöscht werden
        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `oxorderarticles_del` (
  `oxid` varchar(32) COLLATE latin1_general_ci NOT NULL,
  KEY `oxid` (`oxid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci; ");
        } catch (Exception $e) {
        }
        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `oxorder_del` (
  `oxid` varchar(32) COLLATE latin1_general_ci NOT NULL,
  KEY `oxid` (`oxid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci; ");
        } catch (Exception $e) {
        }
        $oDb->execute("DROP TRIGGER IF EXISTS  `oxorderarticles_delete`");
        $oDb->execute("CREATE TRIGGER `oxorderarticles_delete` BEFORE DELETE ON `oxorderarticles` FOR EACH ROW insert into oxorderarticles_del set oxid=OLD.oxid ");
        $oDb->execute("DROP TRIGGER IF EXISTS  `oxorder_delete`");
        $oDb->execute("CREATE TRIGGER `oxorder_delete` BEFORE DELETE ON `oxorder` FOR EACH ROW insert into oxorder_del set oxid=OLD.oxid ");



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
            $oDb->execute("ALTER TABLE  oxarticles ADD  `oxmediafromparent` TINYINT NOT NULL ");
        } catch (Exception $e) {

        }

        self::tmpClear();

        $oMetaData = oxNew('oxDbMetaDataHandler');
        $oMetaData->updateViews();

    }

    static public function tmpClear($sCompileDir="") {
        $myConfig = oxRegistry::getConfig();

        if (!$sCompileDir) {
            $sCompileDir = $myConfig->getConfigParam( 'sCompileDir' );
        } else {
            $sCompileDir = $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.str_replace('/', 'AAA', $sCompileDir);
        }

        $files = glob($sCompileDir . '/*'); // get all file names
        foreach($files as $file){ // iterate files
            if(is_file($file))
            {
                unlink($file); // delete file
            }
            elseif ($file==$sCompileDir . "/smarty") {

                $files_smarty = glob($sCompileDir . '/smarty/*'); // get all file names
                if ($files_smarty) {
                    foreach($files_smarty as $file_smarty){ // iterate files
                        if(is_file($file_smarty))
                            unlink($file_smarty); // delete file
                    }
                }
            }

        }


    }
}