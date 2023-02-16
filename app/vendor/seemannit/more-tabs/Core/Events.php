<?php
namespace SeemannIT\MoreTabsModule\Core;

class Events {
    public static function onActivate() {
        // create the new table
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
        $handle = fopen(dirname(__FILE__)."/../sql/install.sql", "r");
        $cmd = "";
        while(($line = fgets($handle)) !== false) {
            $cmd .= $line." ";
        }
        $oDb->execute($cmd);
        fclose($handle);
    }
}
