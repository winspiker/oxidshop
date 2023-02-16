<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 13.01.2021
 * Time: 11:47
 */

class exonn_marketplace_user extends exonn_marketplace_user_parent
{
	public function createUser()
	{
		$blOk = parent::createUser();

		$basket = \OxidEsales\Eshop\Core\Registry::getSession()->getBasket();

		$basket->setBasketUser($this);
		$basket->calculateBasket(true);
		$basket->onUpdate();

		\OxidEsales\Eshop\Core\Registry::getSession()->setBasket($basket);

		return $blOk;
	}
}