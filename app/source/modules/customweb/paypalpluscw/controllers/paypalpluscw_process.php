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

require_once 'Customweb/Util/Encoding.php';
require_once 'Customweb/Core/Http/Response.php';


class paypalpluscw_process extends oxUBase
{
	public function render()
	{
		$dispatcher = PayPalPlusCwHelper::getEndpointDispatcher();
		$response = $dispatcher->invokeControllerAction(PayPalPlusCwContextRequest::getInstance(), 'process', 'index');
		$wrapper = new Customweb_Core_Http_Response($response);
		$wrapper->send();
		die();
	}

	public function authorize()
	{
		$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('cstrxid'));
		$adapter = PayPalPlusCwHelper::getAuthorizationAdapter($transaction->getAuthorizationType());

		$transactionObject = $transaction->getTransactionObject();
		$response = $adapter->processAuthorization($transactionObject, Customweb_Util_Encoding::toUTF8($_REQUEST));
		PayPalPlusCwHelper::createContainer()->getBean('Customweb_Payment_ITransactionHandler')->persistTransactionObject($transactionObject);

		$wrapper = new Customweb_Core_Http_Response($response);
		$wrapper->send();
		die();
	}

	public function success()
	{
		$sameSiteFix = oxRegistry::getConfig()->getRequestParameter('s');
		if (empty($sameSiteFix)) {
			header_remove('Set-Cookie');
			header('Location: ' . PayPalPlusCwHelper::getUrl(array(
				'cl' => 'paypalpluscw_process',
				'fnc' => 'success',
				'cstrxid' => oxRegistry::getConfig()->getRequestParameter('cstrxid'),
				's' => 1
			)));
			die();
		} else {
			$redirectionUrl = PayPalPlusCwHelper::waitForNotification(oxRegistry::getConfig()->getRequestParameter('cstrxid'));

			header("Location: " . $redirectionUrl);
			die();
		}
	}

	public function fail()
	{
		$sameSiteFix = oxRegistry::getConfig()->getRequestParameter('s');
		if (empty($sameSiteFix)) {
			header_remove('Set-Cookie');
			header('Location: ' . PayPalPlusCwHelper::getUrl(array(
				'cl' => 'paypalpluscw_process',
				'fnc' => 'fail',
				'cstrxid' => oxRegistry::getConfig()->getRequestParameter('cstrxid'),
				's' => 1
			)));
			die();
		} else {
			$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('cstrxid'));

			$errorMessages = $transaction->getTransactionObject()->getErrorMessages();
			if (is_array($errorMessages) && !empty($errorMessages)) {
				$messageToDisplay = nl2br((string) end($errorMessages));
				reset($errorMessages);
				oxRegistry::get("oxUtilsView")->addErrorToDisplay(PayPalPlusCwHelper::toDefaultEncoding($messageToDisplay));
			}

			$user = $this->getUser();
			if (!$user || $transaction->getOrder()->oxorder__oxuserid->value != $user->getId()) {
				header("Location: " . PayPalPlusCwHelper::getUrl(array(
					'cl' => 'user'
				)));
				die();
			}

			if (PayPalPlusCwHelper::isCreateOrderBefore() && $transaction->getOrder() instanceof oxOrder) {
				if (PayPalPlusCwHelper::isDeleteOrderOnFailedAuthorization()) {
					$transaction->getOrder()->delete();
				} else {
					$transaction->getOrder()->setPaymentFailedStatus();
					oxRegistry::getSession()->deleteVariable( 'sess_challenge' );
				}
			}

			if (PayPalPlusCwHelper::isPaymentFormOnPaymentPage($transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod())) {
				$redirectionUrl = PayPalPlusCwHelper::getUrl(array(
					'cl' => 'payment',
				));
			} else {
				$redirectionUrl = PayPalPlusCwHelper::getUrl(array(
					'cl' => 'order',
				));
			}

			header("Location: " . $redirectionUrl);
			die();
		}
	}
}