<?php

class exonnkaufbei_event extends oxBase
{
	public static function onDeactivate()
	{

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_kaufbeitv'");
        } catch (Exception $e) {

        }

	}
	
	public static function onActivate()
	{

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `oxarticleset` (
                          `OXID` char(32) NOT NULL,
                          `OXOBJECTID` char(32) NOT NULL DEFAULT '' COMMENT 'Teil',
                          `oxarticleid` varchar(32) NOT NULL COMMENT 'SET Artikel',
                          `connectortimestamp` datetime NOT NULL,
                          `connector_update` tinyint(4) NOT NULL,
                          `exformtimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          PRIMARY KEY (`OXID`),
                          KEY `OXOBJECTID` (`OXOBJECTID`),
                          KEY `oxarticleid` (`oxarticleid`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
            ");
        } catch (Exception $e) {
        }

		try {
			$oDb->execute("ALTER TABLE `oxcategories` ADD `oxtopmenu` TINYINT(2) NOT NULL AFTER `OXPARENTID` ");
		} catch (Exception $e) {
		}

        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `installmentpayment`  TINYINT NOT NULL");
        } catch (\Throwable $oError) {
        }


        try {
            $oDb->execute("ALTER TABLE `oxarticles` ADD `isnotcod` TINYINT(1) DEFAULT 0");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxarticles` ADD `numberinstallments`  INT NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxarticles` ADD `firstinstallment`  DOUBLE NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxorderarticles` ADD `numberinstallments`  INT NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxorderarticles` ADD `firstinstallment`  DOUBLE NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxorder` ADD `firstinstallment`  DOUBLE NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxorder` ADD `order_del_scan_soll` TINYINT NOT NULL  ");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxorder` ADD `is_paymentinstallment`  TINYINT NOT NULL");
        } catch (\Throwable $oError) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `exclude_group`  CHAR(32) NOT NULL");
        } catch (\Throwable $oError) {
        }


        try {
            $oDb->execute("ALTER TABLE `oxcategories` ADD `oxremove_edit` TINYINT(2) NOT NULL ");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxcategories` CHANGE `oxremove` `oxremove` TINYINT(2) NOT NULL DEFAULT '1'; ");
        } catch (Exception $e) {
        }

        try {
            $oDb->execute("ALTER TABLE `oxcategories` ADD `hierarchy` SMALLINT;");
        } catch (Exception $e) {
        }

        /**
         * Sets the zero level of the hierarchy
         */
        try {
            $oDb->execute("UPDATE `oxcategories`
                           SET hierarchy = 0
                           WHERE OXPARENTID='oxrootid'
                                AND OXACTIVE=1
                                AND OXHIDDEN=0;
            ");
        } catch (Exception $e) {
        }

        /**
         * Sets the rest of the hierarchy levels up to 10
         */
        try {
            for ($i = 0; $i < 10; $i++) {
                $oDb->execute("UPDATE `oxcategories` edit, `oxcategories` find
                               SET edit.hierarchy = $i+1
                               WHERE find.hierarchy = $i
                                  AND edit.OXPARENTID = find.OXID;
                ");
            }
        } catch (Exception $e) {
        }
    }
}