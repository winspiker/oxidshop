<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 02.09.2020
 * Time: 13:28
 */

class exonn_marketplace_basket extends exonn_marketplace_basket_parent
{

	protected $deliveryMethodMode;


	public function setDeliveryMethodMode($deliveryMethodMode)
	{
		$this->deliveryMethodMode = $deliveryMethodMode;
	}

	public function getDeliveryMethodMode()
	{
		return $this->deliveryMethodMode;
	}


	public function _calcDeliveryCost($call = null)
	{



		if(!is_object($this->getBasketUser()) || !$this->getBasketUser()->getId())
		{
			$oUser = oxNew('oxuser');

			$location = oxNew('exonn_geolocation_receiver');

			// wenn session noch nicht gesetzt ist, setzen (passiert vor der rückgabe in getCountryNameByIp...)
			if($location->checkIfSessionIsSet())
			{
				$oxidCountryCode = $location->getSessionCountryCode();
			}

			$oUser->_aFieldNames['oxcountryid']->value = 1;
			$oUser->oxuser__oxcountryid->value = $oxidCountryCode;


			$this->setBasketUser($oUser);

//			echo __FILE__ . " : " . __LINE__ ."\n";
//			echo "<pre>";
//			print_r($oUser);
//			echo "</pre>";
//			die();


		}

		\OxidEsales\Eshop\Core\Registry::getSession()->setBasket($this);

//		$user = $this->getBasketUser();


//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($user);
//		print_r($oUser);
//		echo "</pre>";
//		die();

//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($this);
//		echo "</pre>";
//		die();


//		if ($this->_oDeliveryPrice !== null)
//		{
////			echo "Preis bereits gesetzt, hier würde jetzt rausgegangen...";
//			return $this->_oDeliveryPrice;
//		}

		$myConfig = $this->getConfig();
		$oDeliveryPrice = oxNew(\OxidEsales\Eshop\Core\Price::class);

		if ($this->getConfig()->getConfigParam('blDeliveryVatOnTop'))
		{
			$oDeliveryPrice->setNettoPriceMode();
		}
		else
		{
			$oDeliveryPrice->setBruttoPriceMode();
		}

		// don't calculate if not logged in
		$oUser = $this->getBasketUser();

//		if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//		{
//			echo __FILE__ . " : " . __LINE__ ."\n";
//			echo "<pre>";
//			var_dump($oUser);
//			echo "</pre>";
//			die();
//		}



//		$this->_save();



//		if (!$this->getBasketUser()->getId() && !$myConfig->getConfigParam('blCalculateDelCostIfNotLoggedIn'))
//		{
//			return $oDeliveryPrice;
//		}

		$fDelVATPercent = $this->getAdditionalServicesVatPercent();
		$oDeliveryPrice->setVat($fDelVATPercent);


//		if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//		{
//			echo __FILE__ . " : " . __LINE__ ."\n";
//			echo "<pre>";
//			print_r($this);
//			print_r($oUser);
//			print_r($this->_findDelivCountry());
//			print_r($this->getShippingId());
//			echo "</pre>";
//			die();
//		}

		// list of active delivery costs
		if ($myConfig->getConfigParam('bl_perfLoadDelivery'))
		{
			$aDeliveryList = \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Application\Model\DeliveryList::class)->getDeliveryList(
				$this,
				$oUser,
				$this->_findDelivCountry(),
				$this->getShippingId()
			);



//			echo __FILE__ . " : " . __LINE__ ."\n";
//			echo "<pre>";
//			print_r($this->_findDelivCountry());
//			print_r($this->getShippingId());
//			echo "</pre>";
//			die();





//			if($_SERVER['REMOTE_ADDR'] == "79.213.57.123" && (count($aDeliveryList) > 0 || count($this->getBasketArticles()) > 0))
//			{
//				echo __FILE__ . " : " . __LINE__ ."\n";
//				echo "<pre>Anzahl Versandkostenregeln: ";
//
//				print_r(count($aDeliveryList));
//
//				echo "Anzahl Artikel: ";
//				print_r(count($this->getBasketArticles()));
//				print_r($this->getBasketArticles());
//				echo "</pre>";
//
//			}

//if($_SERVER['REMOTE_ADDR'] == "87.166.121.131")
//{
//				echo __FILE__ . " : " . __LINE__ ."\n";
//				echo "<pre>";
//				print_r(array_keys($aDeliveryList));
//				echo "</pre>";
//	//			die();
//}


//			$this->calculateBasket(true);


			if (count($aDeliveryList) > 0)
			{
				foreach ($aDeliveryList as $oDelivery)
				{
					//debug trace
					if ($myConfig->getConfigParam('iDebug') == 5)
					{
						echo("DelCost : " . $oDelivery->oxdelivery__oxtitle->value . "<br>");
					}

					if($call !== null)
					{
						$this->setDeliveryMethodMode($oDelivery->oxdelivery__oxfixed->value);
					}

					// prüfen, wie die preisberechnung für die lieferung eingestellt ist...
					// pro warenkorb, pro artikelposition oder pro artikel

					switch($oDelivery->oxdelivery__oxaddsumtype->value)
					{
						// einmal pro warenkorb
						case "0":
						default:
							$oDeliveryPrice->addPrice($oDelivery->getDeliveryPrice($fDelVATPercent));
						break;
						// einmal pro unterschiedlicher artikel
						case "1":
							$oDeliveryPrice->addPrice($oDelivery->getDeliveryPrice($fDelVATPercent));
						break;
						// einmal pro artikel
						case "2":
							$oDeliveryPrice->addPrice($call*$oDelivery->getDeliveryPrice($fDelVATPercent));
						break;
					}

					// wenn nach der regel keine weiteren berechnet werden sollen
					if($oDelivery->oxdelivery__oxfinalize->value != 0)
					{
						break;
					}

				}
			}
		}

		unset($aDeliveryList);



		\OxidEsales\Eshop\Core\Registry::getSession()->setBasket($this);



//		$blForceUpdate = true;
//
//		if ($blForceUpdate) {
//			$this->onUpdate();
//		}
//
//		if (!($this->_blUpdateNeeded || $blForceUpdate)) {
//			return;
//		}
//
//		$this->_aCosts = [];
//
		//  1. saving basket to the database
		$this->_save();
//
		//  2. remove all bundles
//		$this->_clearBundles();
//
//		//  3. generate bundle items
//		$this->_addBundles();
//
//		//  4. calculating item prices
//		$this->_calcItemsPrice();
//
//		//  5. calculating/applying discounts
//		$this->_calcBasketDiscount();
//
//		//  6. calculating basket total discount
//		$this->_calcBasketTotalDiscount();
//
//		//  7. check for vouchers
//		$this->_calcVoucherDiscount();
//
//		//  8. applies all discounts to pricelist
//		$this->_applyDiscounts();
//
//
		//  9. calculating additional costs:
		//  9.1: delivery
//		$this->setCost('oxdelivery', $this->_calcDeliveryCost());

		//  9.2: adding wrapping and gift card costs
//		$this->setCost('oxwrapping', $this->_calcBasketWrapping());
//
//		$this->setCost('oxgiftcard', $this->_calcBasketGiftCard());
//
//		//  9.3: adding payment cost
//		$this->setCost('oxpayment', $this->_calcPaymentCost());
//
//		//  10. calculate total price
//		$this->_calcTotalPrice();
////
////		//  11. formatting discounts
//		$this->formatDiscount();
//
//		//  12.setting to up-to-date status
//		$this->afterUpdate();

//		$a = $this->getBasketSummary();
//
//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($a);
//		echo "</pre>";
//		die();

//		$this->calculateBasket(true);
//
//		$this->onUpdate();

//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($oDeliveryPrice);
//		echo "</pre>";
//		die();


		return $oDeliveryPrice;


	}


}