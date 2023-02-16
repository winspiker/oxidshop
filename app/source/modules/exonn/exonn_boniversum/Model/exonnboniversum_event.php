<?php

class exonnboniversum_event extends oxBase
{
	public static function onDeactivate()
	{

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("delete from `oxtplblocks` where OXMODULE='exonn_boniversum'");
        } catch (Exception $e) {

        }

	}
	
	public static function onActivate()
	{

        $oDb = oxDb::getDb();
        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_boniversum` (
  `oxid` char(32) NOT NULL,
  `create_date` datetime NOT NULL,
  `geschaeftszeichen` int(11) NOT NULL AUTO_INCREMENT,
  `oxuserid` char(32) NOT NULL,
  `geschlecht` varchar(2) NOT NULL,
  `nachname` varchar(30) NOT NULL,
  `vorname` varchar(20) NOT NULL,
  `geburtsdatum` varchar(10) NOT NULL,
  `strasse` varchar(46) NOT NULL,
  `hausnr` varchar(10) NOT NULL,
  `plz` varchar(5) NOT NULL,
  `ort` varchar(40) NOT NULL,
  `strasse_valide` varchar(100) NOT NULL,
  `hausnr_valide` varchar(30) NOT NULL,
  `plz_valide` varchar(30) NOT NULL,
  `ort_valide` varchar(30) NOT NULL,
  `errorcode` varchar(20) NOT NULL,
  `produktergebnis` varchar(150) NOT NULL,
  `auftragerstellungsdatum` varchar(10) NOT NULL,
  `auftragerstellungsuhrzeit` varchar(5) NOT NULL,
  `boniversum_auftragsnummer` varchar(40) NOT NULL,
  `adressvalidierung` varchar(225) NOT NULL,
  `identifizierung` varchar(255) NOT NULL,
  `scoretyp` varchar(30) NOT NULL,
  `wert` int(11) NOT NULL,
  `ampel` varchar(10) NOT NULL,
  `scoreklasse` int(11) NOT NULL,
  PRIMARY KEY (`geschaeftszeichen`),
  UNIQUE KEY `oxid` (`oxid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;");
        } catch (Exception $e) {

        }

        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_boniversum2payments` (
  `oxid` char(32) NOT NULL,
  `oxboniversumid` char(32) NOT NULL,
  `oxpaymentid` char(32) NOT NULL,
  PRIMARY KEY (`oxid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
        } catch (Exception $e) {

        }


        try {
            $oDb->execute("CREATE TABLE IF NOT EXISTS `exonn_boniversumpayments` (
  `oxid` char(32) NOT NULL,
  `oxadressvalidierung` text NOT NULL,
  `oxpersonidentifikation` text NOT NULL,
  `scorecalc` varchar(10) NOT NULL,
  `scoreklassefrom` int(11) NOT NULL,
  `scoreklasseto` int(11) NOT NULL,
  `scoreampel` varchar(100) NOT NULL,
  `scorewertfrom` int(11) NOT NULL,
  `scorewertto` int(11) NOT NULL,
  `kreditlimit` double NOT NULL,
  PRIMARY KEY (`oxid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
        } catch (Exception $e) {

        }


        try {
            $oDb->execute("ALTER TABLE `oxpayments` ADD `boniversumsecuritypayment` TINYINT NOT NULL;");
        } catch (Exception $e) {

        }
    }
}