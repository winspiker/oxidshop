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



class paypalpluscw_alias extends oxUBase
{
	/**
	 * Return the alias form elements required by the alias manager.
	 */
	public function render()
	{
		$paymentId = oxRegistry::getConfig()->getRequestParameter( 'paypalpluscw_payment_id' );
		$payment = new PayPalPlusCwPaymentMethod($paymentId);
		if (PayPalPlusCwHelper::isPaymentFormOnPaymentPage($payment)) {
			$order = PayPalPlusCwHelper::getOrderFromBasket();
			$adapter = PayPalPlusCwHelper::getCheckoutAdapterByAuthorizationMethod($payment->getPaymentMethodConfigurationValue('authorizationMethod'));
			$adapter->prepareForm($order, $payment);

			$visibleFormFields = $adapter->getVisibleFormFields();
			if ($visibleFormFields !== null && count($visibleFormFields) > 0) {
				$renderer = new PayPalPlusCwFormRenderer();
				$renderer->setRenderOnLoadJs(false);
				$renderer->setNamespacePrefix($paymentId);
				$visibleFormFields = $renderer->renderElements($visibleFormFields);
			}

			echo json_encode(array(
				'visibleFormFields' => $visibleFormFields
			));
			die();
		} else {
			$order = PayPalPlusCwHelper::getOrderFromBasket();
			$adapter = PayPalPlusCwHelper::getCheckoutAdapterByAuthorizationMethod($payment->getPaymentMethodConfigurationValue('authorizationMethod'));
			$adapter->prepareForm($order, $payment);

			$vars = $adapter->getConfirmationPageVariables();

			echo json_encode(array(
				'visibleFormFields' => $vars['visibleFormFields'],
				'hiddenFormFields' => $vars['hiddenFormFields'],
				'formActionUrl' => $vars['formActionUrl']
			));
			die();
		}
	}
}