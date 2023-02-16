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


class paypalpluscw_payment extends oxUBase
{
	protected $_sThisTemplate = 'paypalpluscw_payment.tpl';

	public function render()
	{
		parent::render();

		try {
			$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter( 'paypalpluscw_transaction_id' ));
			if (PayPalPlusCwHelper::isCreateOrderBefore()) {
				$order = $transaction->getOrder();
			} else {
				$order = PayPalPlusCwHelper::getOrderFromBasket();
			}
			$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($transaction->getTransactionObject()->getTransactionContext()->getOrderContext());
			$adapter->prepare($order, $transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod(), null, $transaction);

			$vars = $adapter->getConfirmationPageVariables();

			if ($adapter instanceof PayPalPlusCwAdapterPaymentPageAdapter && (!isset($vars['visibleFormFields']) || empty($vars['visibleFormFields']))) {
				header("Location: " . $vars['formActionUrl']);
				die();
			}

			foreach ($vars as $key => $value) {
				$this->_aViewData[$key] = $value;
			}
			$this->_aViewData['visibleFormFields'] = PayPalPlusCwHelper::toDefaultEncoding($this->_aViewData['visibleFormFields']);

			$this->_aViewData['aliasUrl'] = PayPalPlusCwHelper::getUrl(array(
				'cl' => 'paypalpluscw_alias',
			));
			$this->_aViewData['previousUrl'] = PayPalPlusCwHelper::getUrl(array(
				'cl' => 'paypalpluscw_payment',
				'fnc' => 'cancel',
				'paypalpluscw_transaction_id' => $transaction->getTransactionId()
			));
			$this->_aViewData['selfUrl'] = html_entity_decode($this->_aViewData['oViewConf']->getSslSelfLink());
			$this->_aViewData['preventDefault'] = true;
			$this->_aViewData['processingLabel'] = Customweb_I18n_Translation::__('Processing...');
			$this->_aViewData['transactionId'] = $adapter->getTransaction()->getTransactionId();

			return $this->_sThisTemplate;
		} catch (Exception $e) {
			oxRegistry::get("oxUtilsView")->addErrorToDisplay('Unfortunately, there has been a problem during the payment process. Please try again.');

			$redirectionUrl = PayPalPlusCwHelper::getUrl(array(
				'cl' => 'order',
			));

			header("Location: " . $redirectionUrl);
			die();
		}
	}

	public function cancel()
	{
		$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter( 'paypalpluscw_transaction_id' ));
		$transaction->getTransactionObject()->setAuthorizationFailed('The transaction was cancelled by the customer.');
		PayPalPlusCwHelper::getEntityManager()->persist($transaction);

		$redirectionUrl = PayPalPlusCwHelper::getUrl(array(
			'cl' => 'order',
		));
		header("Location: " . $redirectionUrl);
		die();
	}

	public function pay()
	{
		$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter( 'paypalpluscw_transaction_id' ));
		$order = PayPalPlusCwHelper::getOrderFromBasket();
		if ($transaction->getOrder() !== null) {
			$order = $transaction->getOrder();
		}
		$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($transaction->getTransactionObject()->getTransactionContext()->getOrderContext());
		$adapter->prepare($order, $transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod(), null, $transaction);

		$interfaceClass = $adapter->getPaymentAdapterInterfaceName();
		$return['authorizationMethod'] = $interfaceClass::AUTHORIZATION_METHOD_NAME;

		$vars = $adapter->processOrderConfirmationRequest();
		foreach ($vars as $key => $value) {
			$return[$key] = $value;
		}

		echo json_encode($return);
		die();
	}
}