<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 18.09.2020
 * Time: 15:34
 */



class exonn_marketplace_delivery extends exonn_marketplace_delivery_parent
{

	/**
	 * Checks if delivery fits for current basket
	 *
	 * @param \OxidEsales\Eshop\Application\Model\Basket $oBasket shop basket
	 *
	 * @return bool
	 */
	public function isForBasket($oBasket)
	{
		// amount for conditional check
		$blHasArticles = $this->hasArticles();
		$blHasCategories = $this->hasCategories();
		$blUse = true;
		$aggregatedDeliveryAmount = 0;
		$blForBasket = false;
		//
		//        if($_SERVER['REMOTE_ADDR'] == "87.166.113.119")
		//        {
		//	        echo "<pre>";
		//	        print_r($this->getId());
		//	        echo "</pre>";
		//        }


		$articles = [];

		// category & article check
		if ($blHasCategories || $blHasArticles)
		{
			$blUse = false;

			$aDeliveryArticles = $this->getArticles();
			$aDeliveryCategories = $this->getCategories();

			foreach ($oBasket->getContents() as $oContent) {

				//	            $articles[$this->getId()][] = $oContent->getArticle();

				//V FS#1954 - load delivery for variants from parent article
				$oArticle = $oContent->getArticle(false);
				$sProductId = $oArticle->getProductId();
				$sParentId = $oArticle->getParentId();
				// wenn die position (artikel) mit der regel verknüpft sind...
				if ($blHasArticles && (in_array($sProductId, $aDeliveryArticles) || ($sParentId && in_array($sParentId, $aDeliveryArticles)))) {
					$blUse = true;
					$artAmount = $this->getDeliveryAmount($oContent);



					if ($this->isDeliveryRuleFitByArticle($artAmount)) {
						$blForBasket = true;
						$this->updateItemCount($oContent);
						$this->increaseProductCount();

						//						if($_SERVER['REMOTE_ADDR'] == "87.166.113.119")
						//						{
						//							echo __FILE__ . " : " . __LINE__ ."\n";
						//							echo "<pre>";
						//							print_r($this->getId());
						//							echo "</pre>";
						////							die();
						//						}


						//                        echo "passt!"; die();

						$articles[$this->getId()]['articles'] = $sProductId;
						$articles[$this->getId()]['cost'] = $this->getAddSum();
					}
					if (!$blForBasket) {
						$aggregatedDeliveryAmount += $artAmount;
					}
				} elseif ($blHasCategories) {


					if (isset(self::$_aProductList[$sProductId])) {
						$oProduct = self::$_aProductList[$sProductId];
					} else {
						$oProduct = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
						$oProduct->setSkipAssign(true);

						if (!$oProduct->load($sProductId)) {
							continue;
						}

						$oProduct->setId($sProductId);
						self::$_aProductList[$sProductId] = $oProduct;
					}

					foreach ($aDeliveryCategories as $sCatId) {
						if ($oProduct->inCategory($sCatId)) {
							$artAmount = $this->getDeliveryAmount($oContent);

							$blUse = true;
							if ($this->isDeliveryRuleFitByArticle($artAmount)) {
								$blForBasket = true;
								$this->updateItemCount($oContent);
								$this->increaseProductCount();

								$articles[$this->getId()]['articles'] = $sProductId;
								$articles[$this->getId()]['cost'] = $this->getAddSum();

							}
							if (!$blForBasket) {
								$aggregatedDeliveryAmount += $artAmount;
							}

							//HR#5650 product might be in multiple rule categories, counting it once is enough
							break;
						}
					}
				}
			}
		} else {
			// regular amounts check
			foreach ($oBasket->getContents() as $oContent) {


				$artAmount = $this->getDeliveryAmount($oContent);

				$oArticle = $oContent->getArticle(false);
				$sProductId = $oArticle->getProductId();

				if ($this->isDeliveryRuleFitByArticle($artAmount)) {
					$blForBasket = true;
					$this->updateItemCount($oContent);
					$this->increaseProductCount();

					$articles[$this->getId()]['articles'] = $sProductId;
					$articles[$this->getId()]['cost'] = $this->getAddSum();
				}
				if (!$blForBasket) {
					$aggregatedDeliveryAmount += $artAmount;
				}
			}
		}

//		if($_SERVER['REMOTE_ADDR'] == "87.166.121.131" && count($articles) > 0)
//		{
//
//			//			foreach($articles as $deliveryId => $articleArray)
//			//			{
//			//				$deliveryPrice = oxNew('oxdelivery');
//			//				$deliveryPrice->load($deliveryId);
//			//
//			//				echo __FILE__ . " : " . __LINE__ ."\n";
//			//				echo "<pre>";
//			//				print_r($deliveryPrice->oxdelivery__oxaddsum->value);
//			//				echo "</pre>";
//			//				die();
//			//
//			//			}
//
////			echo __FILE__ . " : " . __LINE__ ."\n";
////			echo "<pre>";
////			print_r($articles);
////			echo "</pre>";
//		}


		//#M1130: Single article in Basket, checked as free shipping, is not buyable (step 3 no payments found)
		if (!$blForBasket && $blUse && ($this->_checkDeliveryAmount($aggregatedDeliveryAmount) || $this->_blFreeShipping)) {
			$blForBasket = true;
		}

		return $blForBasket;
	}
}