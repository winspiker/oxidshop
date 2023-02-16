<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 09.09.2020
 * Time: 14:11
 */

class exonn_marketplace_article extends exonn_marketplace_article_parent
{

	protected function getDeliveryMethodMode($deliveryId)
	{
		$getDeliveryMethodModeQuery =
			'
				SELECT oxfixed from oxdelivery where oxid = ?
			';

		$getDeliveryMethodModeResult = oxDB::getDb(OXDB::FETCH_MODE_ASSOC)->getOne($getDeliveryMethodModeQuery, [$deliveryId]);

		return $getDeliveryMethodModeResult;
	}


	public function getDeliveryCostForArticle($articleAmount)
	{
		$articleOxid = $this->getId();

//		echo "wurde aufgerufen...";


		$oBasketTest = oxNew('oxbasket');

		$oBasketTest->addToBasket($articleOxid, $articleAmount, $aSel = null, $aPersParam = null, $blOverride = false, $blBundle = false, $sOldBasketItemId = null);

//		if($_SERVER['REMOTE_ADDR'] == "87.166.121.131")
//		{
//		    echo __FILE__ . " : " . __LINE__ ."\n";
//		    echo "<pre>";
//		    mail('alert@exonn.de', 'dalert mail' . __FILE__ . __LINE__, 'message'.print_r($oBasketTest,1));
//
//		    echo "</pre>";
//		}

		// erst delivery methode feststellen
		// dann entscheiden, wenn methode für jeden artikel berechnet werden soll, muss überhaupt nur angezeigt werden

		// muss ausgeführt werden um folgende zeile zu ermitteln
		$deliveryCosts = $oBasketTest->_calcDeliveryCost($articleAmount);


//		if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//		{
//			echo __FILE__ . " : " . __LINE__ ."\n";
//			echo "<pre>";
//			print_r($deliveryCosts->getPrice());
////			print_r($oBasketTest);
//			echo "</pre>";
////			die();
//		}

		if(is_object($deliveryCosts))
		{
			return $deliveryCosts;
		}
		else
		{
			return oxNew('oxprice');
		}



	}

}