<?php

namespace Exonn\Asum\Core;

use Exception;
use OxidEsales\Eshop\Core\DatabaseProvider;
use OxidEsales\Eshop\Core\Model\BaseModel;

class ExonnAsumEvent extends BaseModel
{
    public static function onActivate()
    {
        $oDb = DatabaseProvider::getDb();

        // Tabellenfeld für unique id in oxarticles erstellen
        $asumQuery =
            '
			ALTER TABLE oxarticles add column `exonn_unique_article_id` char(8) default NULL;
		';

        try {
            $oDb->execute($asumQuery);
        } catch (Exception $e) {
            echo __FILE__ . " : " . __LINE__ . "\n";
            echo "<pre>";
            print_r($e->getMessage());
            echo "</pre>";

        }
    }

    public static function onDeactivate()
    {

    }
}
