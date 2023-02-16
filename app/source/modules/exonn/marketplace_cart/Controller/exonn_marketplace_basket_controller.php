<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 09.09.2020
 * Time: 13:35
 */

class exonn_marketplace_basket_controller extends exonn_marketplace_basket_controller_parent
{
	/**
	 * EXONN Anpassung:
	 *
	 * Hier wird das Session-Management für die Landesermittlung über IP
	 * beim Warenkorbaufruf angesprochen, und
	 *
	 * @return mixed
	 */
	public function render()
	{

		// nur das Land über IP ermitteln, wenn Benutzer nicht eingeloggt ist.
		if(!$this->getUser())
		{
//			echo "Benutzer nicht eingeloggt!<br>";

			$location = oxNew('exonn_geolocation_receiver');

			// wenn session noch nicht gesetzt ist, setzen (passiert vor der rückgabe in getCountryNameByIp...)
			if(!$location->checkIfSessionIsSet())
			{
//				echo "Land in Session nicht gesetzt!<br>";
				$oxidCountryCode = $location->getOxidCountryCodeByIp($_SERVER['REMOTE_ADDR']);
//				echo "oxidCountryCode: ".$oxidCountryCode."<br>";
			}
			else
			{
//				echo "Sesson gesetzt, hole Land aus Session!<br>";
				$oxidCountryCode = $location->getSessionCountryCode();
//				echo "Land: ".$oxidCountryCode."<br>";
			}
		}




		parent::render();


		$basket = \OxidEsales\Eshop\Core\Registry::getSession()->getBasket();

		$basket->calculateBasket(true);
		$basket->onUpdate();

		\OxidEsales\Eshop\Core\Registry::getSession()->setBasket($basket);

		return $this->_sThisTemplate;

	}
}