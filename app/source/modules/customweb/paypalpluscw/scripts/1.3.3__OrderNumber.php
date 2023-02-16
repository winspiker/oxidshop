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

require_once 'Customweb/Database/Migration/IScript.php';


class PayPalPlusCw_Migration_1_3_3 implements Customweb_Database_Migration_IScript {

	public function execute(Customweb_Database_IDriver $driver){
		$result = $driver->query("SHOW COLUMNS FROM `paypalpluscw_transaction` LIKE 'orderNumber'");
		if ($result->getRowCount() <= 0) {
			$driver->query("ALTER TABLE `paypalpluscw_transaction` ADD `orderNumber` INT(11)")->execute();

		}

		$result = $driver->query("SHOW COLUMNS FROM `paypalpluscw_transaction` LIKE 'paymentType'");
		if ($result->getRowCount() <= 0) {
			$driver->query("ALTER TABLE `paypalpluscw_transaction` ADD `paymentType` CHAR(32)")->execute();
		}

		$driver->query("UPDATE paypalpluscw_transaction, oxorder
				SET paypalpluscw_transaction.orderNumber = oxorder.oxordernr, paypalpluscw_transaction.paymentType = oxorder.oxpaymenttype
				WHERE paypalpluscw_transaction.orderId = oxorder.oxid AND paypalpluscw_transaction.orderNumber IS NULL;")->execute();
	}
}