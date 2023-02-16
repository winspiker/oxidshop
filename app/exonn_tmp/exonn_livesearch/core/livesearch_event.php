<?php

class livesearch_event extends oxBase
{
	public static function onDeactivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONNLIVESEARCH_IS_ACTIVE', false );
	}
	
	public static function onActivate()
	{
        $myConfig = oxRegistry::getConfig();
        $myConfig->saveShopConfVar( "bool", 'EXONNLIVESEARCH_IS_ACTIVE', true );

        try {
            oxDb::getDb()->execute("CREATE TABLE `exonn_livesearch` (
  `id` int(11) NOT NULL,
  `insertdate` datetime NOT NULL,
  `ip_address` varchar(20) NOT NULL,
  `searchparam` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
        } catch(Exception $e){}

        try {
            oxDb::getDb()->execute("ALTER TABLE `exonn_livesearch`
  ADD PRIMARY KEY (`id`);");
        } catch(Exception $e){}

        try {
            oxDb::getDb()->execute("ALTER TABLE `exonn_livesearch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;");
        } catch(Exception $e){}
	}
}