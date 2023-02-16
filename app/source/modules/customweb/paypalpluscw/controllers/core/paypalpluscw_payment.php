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

require_once 'Customweb/I18n/Translation.php';


class paypalpluscw_payment extends paypalpluscw_payment_parent
{
	public function render()
	{
		$this->_aViewData['selfUrl'] = html_entity_decode($this->_aViewData['oViewConf']->getSslSelfLink());
		$this->_aViewData['paypalpluscwAliasUrl'] = PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_alias',
		));
		$this->_aViewData['processingLabel'] = Customweb_I18n_Translation::__('Processing...');

		return parent::render();
	}

	public function validatePayment()
	{
		$result = parent::validatePayment();

		if ($result == 'order' && oxRegistry::getConfig()->getRequestParameter('paypalpluscw_alias_id') !== null) {
			return 'order?paypalpluscw_alias_id=' . oxRegistry::getConfig()->getRequestParameter('paypalpluscw_alias_id');
		}

		return $result;
	}

	public function getPaymentList()
	{
		if ( $this->_oPaymentList === null ) {
			$paymentList = parent::getPaymentList();

			$filteredPaymentList = array();
			if (is_array($paymentList)) {
				foreach ($paymentList as $key => $payment) {
					if (!$payment->isPaypalpluscwPaymentMethod() || $payment->validateBefore()) {
						$filteredPaymentList[$key] = $payment;
					}
				}
			}
			$this->_oPaymentList = $filteredPaymentList;
		}
		return $this->_oPaymentList;
	}
}