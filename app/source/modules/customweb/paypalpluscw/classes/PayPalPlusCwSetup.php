<?php
/**
 * You are allowed to use this API in your web application.
 *
 * Copyright (C) 2018 by customweb GmbH
 *
 * This program is licenced under the customweb software licence. With the
 * purchase or the installation of the software in your application you
 * accept the licence agreement. The allowed usage is outlined in the
 * customweb software licence which can be found under
 * http://www.sellxed.com/en/software-license-agreement
 *
 * Any modification or distribution is strictly forbidden. The license
 * grants you the installation in one application. For multiuse you will need
 * to purchase further licences at http://www.sellxed.com/shop.
 *
 * See the customweb software licence agreement for more details.
 *
 *
 * @category	Customweb
 * @package		Customweb_PayPalPlusCw
 * @version		2.0.224
 */

PayPalPlusCwHelper::bootstrap();

require_once 'Customweb/Database/Migration/Manager.php';


class PayPalPlusCwSetup
{
	/**
	 * Execute action on activate event
	 */
	public static function onActivate()
	{
		$scriptDir = dirname(dirname(__FILE__)) . '/scripts/';
		$manager = new Customweb_Database_Migration_Manager(PayPalPlusCwHelper::getDriver(), $scriptDir, 'paypalpluscw_schema_version');
		$manager->migrate();

		self::installPaymentMethods();
		PayPalPlusCwHelper::cleanupTransactions();
	}

	/**
	 * Execute action on deactivate event
	 */
	public static function onDeactivate()
	{

	}

	private static function installPaymentMethods()
	{
		$paymentMethods = array(
			'paypalpluscw_paypal' => array(
				'name' => 'paypalpluscw_paypal',
 				'description' => 'PayPal',
 			),
 			'paypalpluscw_paypalplus' => array(
				'name' => 'paypalpluscw_paypalplus',
 				'description' => 'PayPal Plus',
 			),
 		);

		$driver = PayPalPlusCwHelper::getDriver();
		foreach ($paymentMethods as $paymentMethod) {
			$oPayment = oxNew('oxPayment');
			if(!$oPayment->load($paymentMethod['name'])) {
				$driver->query("INSERT INTO `oxpayments` (
					`OXID`, `OXACTIVE`, `OXDESC`, `OXDESC_1`, `OXTOAMOUNT`
				) VALUES (
					>name, 0, >description, >description, 1000000
				)")->execute(array(
						'>name' => $paymentMethod['name'],
						'>description' => $paymentMethod['description']
					));
			}
		}
	}
}