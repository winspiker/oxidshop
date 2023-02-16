<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
class cppayments_events
{ 

    /**
     * Execute action on activate event.
     *
     * @return void
     */
    public static function onActivate()
    {
        $logger = oxNew('crefoPayLogger');
        // init cpMessage
        $cpMessage = "";
        
        // load oxConfig
        $cpMessage .= self::out("Konfiguration wird geladen... ");
        $cpConfig = oxRegistry::getConfig();
        $cpConfig != null ? $cpMessage .= self::out("ok", true, "green") : $cpMessage .= self::out("fail", true, "red");
        
        // get instance of oxDb
        $cpMessage .= self::out("Hole Datenbank Instanz... ");
        try {
            $cpOxDb = oxDb::getDb();
            $cpMessage .= self::out("ok", true, "green");
        } catch (Exception $e) {
            $cpMessage .= self::out("fail - " . $e->getMessage() . " - ", true, "red");
            $logger->error(__FILE__, "konnte Datenbankinstanz nicht holen");
        }
        
        // add payment methods
        $cpMessage .= self::out("CrefoPay Bezahlarten werden hinzugef&uuml;gt... ") . self::addPaymentMethods($cpOxDb, $cpConfig->getShopId(), $logger);
        
        // add reference tables
        $cpMessage .= self::out("CrefoPay Referenz-Tabelle wird hinzugef&uuml;gt... ") . self::addReferences($cpOxDb, $logger);
        if (version_compare($cpConfig->getVersion(), '1.1.0', '>')) {
            $cpMessage .= self::out("CrefoPay Referenz-Tabelle wird angepasst... ") . self::alterReferences($cpOxDb, $logger);
        }
        $cpMessage .= self::out("CrefoPay Zusatzinformations-Tabelle wird hinzugef&uuml;gt... ") . self::addAdditionalInformation($cpOxDb, $logger);
        $cpMessage .= self::out("CrefoPay Notification-Tabelle werden hinzugef&uuml;gt... ") . self::addNotifications($cpOxDb, $logger);
        
        // clear cache
        $cpMessage .= self::out("Oxid Cache wird geleert... ") . self::clearTmp();
        
        oxRegistry::get("oxUtilsView")->addErrorToDisplay($cpMessage, false, true);
    }

    /**
     * Execute action on deactivate event.
     *
     * @return void
     */
    public static function onDeactivate()
    {
        $logger = oxNew('crefoPayLogger');

        $cpMessage = "";
        // get instance of oxDb
        $cpMessage .= self::out("Hole Datenbank Instanz... ");
        try {
            $cpOxDb = oxDb::getDb();
            $cpMessage .= self::out("ok", true, "green");
        } catch (Exception $e) {
            $cpMessage .= self::out("fail - " . $e->getMessage() . " - ", true, "red");
            $logger->error(__FILE__, "konnte Datenbankinstanz nicht holen");
        }
        
        // remove payment methods
        $cpMessage .= self::out("CrefoPay Bezahlarten werden deaktiviert... ") . self::removePaymentMethods($cpOxDb, $logger);
        
        $cpMessage .= self::out("Oxid Cache wird geleert... ") . self::clearTmp();
        
        oxRegistry::get("oxUtilsView")->addErrorToDisplay($cpMessage, false, true);
    }

    /**
     * Clear tmp directory and smarty cache.
     *
     * @return string ok or error message when catch an exception
     */
    public static function clearTmp()
    {
        $tmpDir = getShopBasePath() . "/tmp/";
        $smartyDir = $tmpDir . "smarty/";
        
        try {
            foreach (glob($tmpDir . "*.txt") as $fileName) {
                unlink($fileName);
            }
            foreach (glob($smartyDir . "*.php") as $fileName) {
                unlink($fileName);
            }
            return self::out("ok", true, "green");
        } catch (Exception $e) {
            return self::out($e->getMessage(), true, "red");
        }
    }

    private static function addPaymentMethods($cpOxDb, $cpShopId = 'oxbaseshop', $logger)
    {
        $out = "";
        $cpConfig = oxNew('CrefoPayConfig');
        
        foreach ($cpConfig->getPaymentMethods() as $cpPaymentKey => $cpPaymentName) {
            $cpPaymentTag = $cpConfig->getPaymentTag($cpPaymentKey);
            
            // Register CrefoPay payment methods in oxpayments
            try {
                $cpOxDb->execute("INSERT INTO oxpayments(OXID,OXACTIVE,OXDESC,OXADDSUM,OXADDSUMTYPE,OXFROMBONI,OXFROMAMOUNT,OXTOAMOUNT,OXVALDESC,OXCHECKED,OXDESC_1,OXVALDESC_1,OXDESC_2,OXVALDESC_2,OXDESC_3,OXVALDESC_3,OXLONGDESC,OXLONGDESC_1,OXLONGDESC_2,OXLONGDESC_3,OXSORT) VALUES ('{$cpPaymentKey}', 1, '{$cpPaymentName}', 0, 'abs', 0, 0, 1000000, '', 0, '{$cpPaymentTag}', '', '', '', '', '', '', '', '', '', 0);");
                
                // Link object to group
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidadmin');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidcustomer');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxiddealer');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidforeigncustomer');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidgoodcust');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidmiddlecust');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidnewcustomer');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidnewsletter');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidnotyetordered');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidpowershopper');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidpricea');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidpriceb');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidpricec');");
                $cpOxDb->execute("INSERT INTO oxobject2group(OXID,OXSHOPID,OXOBJECTID,OXGROUPSID) values (MD5(CONCAT(NOW(), RAND())), '{$cpShopId}', '{$cpPaymentKey}', 'oxidsmallcust');");
                
                // Link object to payment
                $cpOxDb->execute("INSERT INTO oxobject2payment(OXID,OXPAYMENTID,OXOBJECTID,OXTYPE) values (MD5(CONCAT(NOW(),RAND())), '{$cpPaymentKey}', 'oxidstandard', 'oxdelset');");

                $msg .= self::out("ok", true, "green");
                if ($logger->getLevel() == 0) {
                    $logger->log(0, __FILE__, "CrefoPay Bezahlmethode " . $cpPaymentKey . " erfolgreich mit der Oxid Standardversandart verknüpft");
                }
            } catch (Exception $e) {
                $msg .= self::out(" (Exception: " . $e->getMessage() . ") ") . self::out("fail", true, "red");                
                if ($logger->getLevel() < 2) {
                    $logger->log(1, __FILE__, "CrefoPay Bezahlmethoden konnten nicht erfolgreich mit der Oxid Standardversandart verknüpft werden");
                }
            }
        }
        return $out;
    }

    /**
     * adding the CrefoPay reference table:
     *
     * +---------------------+-------------+------+-----+---------------------+-------+
     * | Field               | Type        | Null | Key | Default             | Extra |
     * +---------------------+-------------+------+-----+---------------------+-------+
     * | OXSESSIONID         | char(32)    | YES  |     | NULL                |       |
     * | OXORDERID           | char(32)    | YES  |     | NULL                |       |
     * | CPSTOREID           | varchar(60) | YES  |     | NULL                |       |
     * | CPORDERID           | varchar(30) | YES  |     | NULL                |       |
     * | CPORDERSTATE        | varchar(20) | YES  |     | NULL                |       |
     * | CPUSERID            | varchar(50) | YES  |     | NULL                |       |
     * | CPUSERTYPE          | varchar(8)  | YES  |     | NULL                |       |
     * | CPPAYMENTMETHOD     | varchar(16) | YES  |     | NULL                |       |
     * | CPPID               | varchar(50) | YES  |     | NULL                |       |
     * | CPADDITIONAL        | varchar(50) | YES  |     | NULL                |       |
     * | CPRISKCLASS         | varchar(50) | YES  |     | NULL                |       |
     * | CPORDERDATE         | datetime    | NO   |     | CURRENT_TIMESTAMP   |       |
     * | CPORDERUPDATE       | timestamp   | NO   |     | 0000-00-00 00:00:00 |       |
     * +---------------------+-------------+------+-----+---------------------+-------+ 
     */
    private static function addReferences($cpOxDb, $logger)
    {
        $msg = "";
        try {
            if ($cpOxDb->select("SHOW TABLES LIKE 'cporders'")->EOF) {
                $cpOxDb->execute("CREATE TABLE cporders (
                    OXSESSIONID char(32),
                    OXORDERID char(32), 
                    CPSTOREID varchar(60),
                    CPORDERID varchar(30),
                    CPORDERSTATE varchar(20),
                    CPUSERID varchar(50),
                    CPUSERTYPE varchar(8),
                    CPPAYMENTMETHOD varchar(16),
                    CPPID varchar(50),
                    CPADDITIONAL varchar(50),
                    CPRISKCLASS integer(2),
                    CPORDERUPDATE DATETIME,
                    CPORDERDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP) COLLATE latin1_general_ci");
                $msg .= self::out("ok", true, "green");
                $logger->debug(__FILE__, "CrefoPay Referenztabelle erfolgreich erstellt");
            } else {
                $msg .= self::out(" (table <i>cporders</i> already exists)... ") . self::out("ok", true, "green");
                $logger->debug(__FILE__, "CrefoPay Referenztabelle war bereits vorhanden");
            }
        } catch (Exception $e) {
            $msg .= self::out(" (Exception: " . $e->getMessage() . ") ") . self::out("fail", true, "red");
            $logger->debug(__FILE__, "CrefoPay Referenztabelle konnte nicht erfolgreich erstellt werden");
        }
        return $msg;
    }

    /**
     * Alternate reference table from version 1.1.0+
     *
     * @param DatabaseProvider $cpOxDb
     * @param crefoPayLogger $logger
     * 
     * @throws Exception
     * @return string
     */
    private static function alterReferences($cpOxDb, $logger)
    {
        $msg = "";
        try {
            $cpOxDb->execute('ALTER table cporders ADD OXID varchar(32) FIRST');
            $msg .= self::out(" (Spalte <i>cporders.OXID</i> hinzugefügt)... ") . self::out("ok", true, "green");
        } catch (Exception $e) {
            $msg .= self::out(" (Spalte <i>cporders.OXID</i> war bereits vorhanden)... ") . self::out("ok", true, "green");
        }
        return $msg;
    }


    /**
     * Adding the CrefoPay additional information table:
     *
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | Field               | Type         | Null | Key | Default             | Extra |
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | CPORDERID           | varchar(30)  | YES  |     | NULL                |       |
     * | CPBANKNAME          | varchar(256) | YES  |     | NULL                |       |
     * | CPBANKACCOUNTHOLDER | varchar(256) | YES  |     | NULL                |       |
     * | CPIBAN              | varchar(32)  | YES  |     | NULL                |       |
     * | CPBIC               | varchar(16)  | YES  |     | NULL                |       |
     * | CPPAYMENTREFERENCE  | varchar(16)  | YES  |     | NULL                |       |
     * | CPCREATEDAT         | timestamp    | NO   |     | CURRENT_TIMESTAMP   |       |
     * | CPLASTUPDATE        | timestamp    | NO   |     | 0000-00-00 00:00:00 |       |
     * +---------------------+--------------+------+-----+---------------------+-------+ 
     */
    private static function addAdditionalInformation($cpOxDb, $logger)
    {
        $msg = "";
        try {
            if ($cpOxDb->select("SHOW TABLES LIKE 'cpadditionals'")->EOF) {
                $cpOxDb->execute("CREATE TABLE cpadditionals (CPORDERID varchar(30), CPBANKNAME varchar(256), CPBANKACCOUNTHOLDER varchar(256), CPIBAN  varchar(32), CPBIC varchar(16), CPPAYMENTREFERENCE varchar(16), CPLASTUPDATE DATETIME, CPCREATEDAT TIMESTAMP DEFAULT CURRENT_TIMESTAMP) COLLATE latin1_general_ci");
                $msg .= self::out("ok", true, "green");
                $logger->debug(__FILE__, "CrefoPay Informationstabelle erfolgreich erstellt");
            } else {
                $msg .= self::out(" (table <i>cpadditionals</i> already exists)... ") . self::out("ok", true, "green");
                $logger->debug(__FILE__, "CrefoPay Zusatz-Informationstabelle war bereits vorhanden");
            }
        } catch (Exception $e) {
            $msg .= self::out(" (Exception: " . $e->getMessage() . ") ") . self::out("fail", true, "red");
            $logger->error(__FILE__, "CrefoPay Zusatz-Informationstabelle konnte nicht erfolgreich erstellt werden");
        }
        return $msg;
    }

    /**
     * adding the CrefoPay notification table:
     *
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | Field               | Type         | Null | Key | Default             | Extra |
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | CPMERCHANTID        | char(16)     | YES  |     | NULL                |       |
     * | CPSTOREID           | varchar(60)  | YES  |     | NULL                |       |
     * | CPORDERID           | varchar(30)  | YES  |     | NULL                |       |
     * | CPCAPTUREID         | varchar(30)  | YES  |     | NULL                |       |
     * | CPMARCHANTREFERENCE | varchar(30)  | YES  |     | NULL                |       |
     * | CPPAYMENTREFERENCE  | varchar(16)  | YES  |     | NULL                |       |
     * | CPUSERID            | varchar(50)  | YES  |     | NULL                |       |
     * | CPAMOUNT            | char(16)     | YES  |     | NULL                |       |
     * | CPCURRENCY          | varchar(16)  | YES  |     | NULL                |       |
     * | CPTRANSACTIONSTATUS | varchar(32)  | YES  |     | NULL                |       |
     * | CPORDERSTATUS       | varchar(32)  | NO   |     | NULL                |       |
     * | CPADDITIONALDATA    | varchar(256) | YES  |     | NULL                |       |
     * | CPCREATEDAT         | timestamp    | YES  |     | CURRENT_TIMESTAMP   |       |
     * | CPTIMESTAMP         | timestamp    | YES  |     | 0000-00-00 00:00:00 |       |
     * | CPVERSION           | varchar(8)   | YES  |     | NULL                |       |
     * +---------------------+--------------+------+-----+---------------------+-------+ 
     */
    private static function addNotifications($cpOxDb, $logger)
    {
        $msg = "";
        try {
            if ($cpOxDb->select("SHOW TABLES LIKE 'cpnotifications'")->EOF) {
                $cpOxDb->execute("CREATE TABLE cpnotifications (CPMERCHANTID char(16), CPSTOREID varchar(60), CPORDERID varchar(30), CPCAPTUREID varchar(30), CPMARCHANTREFERENCE varchar(30), CPPAYMENTREFERENCE varchar(16), CPUSERID varchar(50), CPAMOUNT varchar(16), CPCURRENCY varchar(16), CPTRANSACTIONSTATUS varchar(32), CPORDERSTATUS varchar(32), CPADDITIONALDATA varchar(256), CPTIMESTAMP DATETIME, CPVERSION varchar(8), CPCREATEDAT TIMESTAMP DEFAULT CURRENT_TIMESTAMP) COLLATE latin1_general_ci"); 
                $msg .= self::out("ok", true, "green");
                $logger->debug(__FILE__, "CrefoPay Notificationtabelle erfolgreich erstellt");
            } else {
                $msg .= self::out(" (table <i>cpnotifications</i> already exists)... ") . self::out("ok", true, "green");
                $logger->log(0, __FILE__, "CrefoPay Notificationtabelle war bereits vorhanden");
            }
        } catch (Exception $e) {
            $msg .= self::out(" (Exception: " . $e->getMessage() . ") ") . self::out("fail", true, "red");
            $logger->debug(__FILE__, "CrefoPay Notificationtabelle konnte nicht erfolgreich erstellt werden");
        }
        return $msg;
    }


    private static function removePaymentMethods($cpOxDb, $logger)
    {
        $cpConfig = oxNew('CrefoPayConfig');
        foreach ($cpConfig->getPaymentMethods() as $cpPaymentKey => $cpPaymentName) {
            $cpPaymentTag = $cpConfig->getPaymentTag($cpPaymentKey);
            
            // Try to delete payment method
            try {
                $cpOxDb->execute("DELETE FROM oxpayments WHERE OXID = '{$cpPaymentKey}' AND OXDESC_1 = '{$cpPaymentTag}'");
                $cpOxDb->execute("DELETE FROM oxobject2group WHERE OXOBJECTID = '{$cpPaymentKey}'");
                $cpOxDb->execute("DELETE FROM oxobject2payment WHERE OXPAYMENTID = '{$cpPaymentKey}'");
            } catch (Exception $e) {
                self::out(" Exception: " . $e->getMessage() . " ");
                return self::out("fail", true, "red");
            }
        }
        return self::out("ok", true, "green");
    }

    private static function out($message, $nl = false, $color = null)
    {
        switch ($color) {
            case "green":
                $color = "#007700";
                break;
            case "red":
                $color = "#DD0000";
                break;
            default:
                $color = "#000000";
                break;
        }
        $cpOut = '<span style="color: ' . $color . '">' . $message . '</span>';
        if ($nl) {
            $cpOut .= '<br />';
        }
        return $cpOut;
    }

}
