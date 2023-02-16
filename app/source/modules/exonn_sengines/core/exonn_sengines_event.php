<?php

class exonn_sengines_event extends oxBase
{
	public static function onDeactivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONN_SENGINES_IS_ACTIVE', false );
        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from oxtplblocks where oxmodule='exonn_sengines'");
        } catch (Exception $e) {
        }
	}
	
	public static function onActivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONN_SENGINES_IS_ACTIVE', true );


        $oDb = oxDb::getDb();

        $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_googlem` (
          `oxid` char(32) COLLATE latin1_general_ci NOT NULL,
          `active` tinyint(1) NOT NULL,
          `is_category` tinyint(1) NOT NULL,
          `acondition` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `gender` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `age_group` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `color` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `size` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `material` varchar(100) COLLATE latin1_general_ci NOT NULL,
          `pattern` varchar(100) COLLATE latin1_general_ci NOT NULL,
          `adult` tinyint(1) NOT NULL,
          `adwords_grouping` varchar(100) COLLATE latin1_general_ci NOT NULL,
          `adwords_labels` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `adwords_redirect` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `unit_pricing_measure` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `unit_pricing_base_measure` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `energy_efficiency_class` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `multipack` varchar(50) COLLATE latin1_general_ci NOT NULL,
          `custom_label_0` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `custom_label_1` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `custom_label_2` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `custom_label_3` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `custom_label_4` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `item_group_id` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `googlecategory` text COLLATE latin1_general_ci NOT NULL,
          `sale_price` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `sale_price_effective_date1` varchar(250) COLLATE latin1_general_ci NOT NULL,
          `sale_price_effective_date2` varchar(250) COLLATE latin1_general_ci NOT NULL,
          PRIMARY KEY (`oxid`)
        )");

        try {
            $oDb->execute("ALTER TABLE `exonn_googlem` ADD (useshipping TINYINT(1) not null)");
        } catch (Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `exonn_googlem` ADD (title2 varchar (250) not null)");
        } catch (Exception $e){}

        try {
            $oDb->execute("ALTER TABLE `oxdeliveryset` ADD (skipgmerch TINYINT(1) not null)");
        } catch (Exception $e){}

		try {
			$oDb->execute("ALTER TABLE `oxcountry` ADD `google_feed_active` TINYINT(1) NOT NULL DEFAULT '0'");
		} catch (Exception $e){}

	}
}