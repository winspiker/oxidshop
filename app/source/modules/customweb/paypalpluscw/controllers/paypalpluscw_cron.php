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

require_once 'Customweb/Cron/Processor.php';


class paypalpluscw_cron extends oxUBase
{
	public function render()
	{
		PayPalPlusCwHelper::cleanupTransactions();

		try {
			$packages = array(
			0 => 'Customweb_PayPalPlus',
 			1 => 'Customweb_Payment_Authorization',
 		);
			$packages[] = 'PayPalPlusCw';
			$packages[] = 'Customweb_Payment_Update_ScheduledProcessor';
			$cronProcessor = new Customweb_Cron_Processor(PayPalPlusCwHelper::createContainer(), $packages);
			$cronProcessor->run();
		} catch (Exception $e) {}

		die();
	}
}