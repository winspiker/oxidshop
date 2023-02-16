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


class paypalpluscw_order extends paypalpluscw_order_parent
{
	private $_finalizeResult = null;

	public function render()
	{
		if (empty($this->_aViewData['formActionUrl'])) {
			$this->_aViewData['formActionUrl'] = $this->getConfig()->getSslShopUrl();
		}
		if (!isset($this->_aViewData['includeAGBTemplate'])) {
			$this->_aViewData['includeAGBTemplate'] = (version_compare($this->getConfig()->getVersion(), '4.8.6') >= 0);
		}

		$this->_removeExistingOrder();

		$paymentId = oxRegistry::getSession()->getBasket()->getPaymentId();
		if (PayPalPlusCwHelper::isPaypalpluscwPaymentMethod($paymentId)) {
			$payment = new PayPalPlusCwPaymentMethod($paymentId);
			if (PayPalPlusCwHelper::isPaymentFormOnCheckoutPage($payment)) {
				$order = PayPalPlusCwHelper::getOrderFromBasket();
				$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($payment->getOrderContext($order));
				$adapter->prepareForm($order, $payment);

				$vars = $adapter->getConfirmationPageVariables();
				foreach ($vars as $key => $value) {
					$this->_aViewData[$key] = $value;
				}
				$this->_aViewData['visibleFormFields'] = PayPalPlusCwHelper::toDefaultEncoding($this->_aViewData['visibleFormFields']);

				$this->_aViewData['aliasUrl'] = PayPalPlusCwHelper::getUrl(array(
					'cl' => 'paypalpluscw_alias',
				));
				$this->_aViewData['selfUrl'] = html_entity_decode($this->_aViewData['oViewConf']->getSslSelfLink());
				$this->_aViewData['preventDefault'] = true;
				$this->_aViewData['isPaypalpluscwModule'] = true;
				$this->_aViewData['processingLabel'] = Customweb_I18n_Translation::__('Processing...');
				$this->_aViewData['mobileActive'] = PayPalPlusCwHelper::isMobileTheme();
			} elseif (PayPalPlusCwHelper::isPaymentFormOnPaymentPage($payment)) {
				unset($_SERVER['HTTP_X_REQUESTED_WITH']);

				$order = PayPalPlusCwHelper::getOrderFromBasket();
				$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($payment->getOrderContext($order));
				$adapter->prepareForm($order, $payment);

				$this->_aViewData['paymentMethodId'] = $paymentId;
				$this->_aViewData['selfUrl'] = html_entity_decode($this->_aViewData['oViewConf']->getSslSelfLink());
				$this->_aViewData['preventDefault'] = true;
				$this->_aViewData['isPaypalpluscwModule'] = true;
				$this->_aViewData['processingLabel'] = Customweb_I18n_Translation::__('Processing...');
				$this->_aViewData['mobileActive'] = PayPalPlusCwHelper::isMobileTheme();
			}
		}

		// Using pending orders: When the customer orders with a paypalpluscw payment method but leaves the payment process
		// and checks out with a different payment method, no new order is created for the second try. This happens because
		// oxid prevents the creation of duplicate orders with the sess_challenge value and this value is only reset when the
		// customer reaches the thankyou page.
		oxRegistry::getSession()->deleteVariable('sess_challenge');

		return parent::render();
	}

	protected function _removeExistingOrder()
	{
		$sGetChallenge = oxRegistry::getSession()->getVariable('sess_challenge');
		if ( $this->_checkOrderExist($sGetChallenge)) {
			$order = oxNew( 'oxorder' );
			$order->load( oxRegistry::getSession()->getVariable( 'sess_challenge' ) );
			if (PayPalPlusCwHelper::isPaypalpluscwPaymentMethod($order->oxorder__oxpaymenttype->value)) {
				if (PayPalPlusCwHelper::isDeleteOrderOnFailedAuthorization()) {
					$order->delete();
				} else {
					$order->setPaymentFailedStatus();
					oxRegistry::getSession()->deleteVariable( 'sess_challenge' );
				}
			}
		}
	}

	protected function _checkOrderExist( $sOxId = null )
    {
        if ( !$sOxId) {
            return false;
        }

        $oDb = oxDb::getDb();
        if ($oDb->getOne( 'select oxid from oxorder where OXTRANSSTATUS = '.$oDb->quote('PAYMENT_PENDING').' AND oxid = '.$oDb->quote( $sOxId ), false, false)) {
            return true;
        }

        return false;
    }

	public function execute()
	{
		if (!$this->getSession()->checkSessionChallenge()) {
			return;
		}

		$myConfig = $this->getConfig();

		if ( !oxRegistry::getConfig()->getRequestParameter( 'ord_agb' ) && $myConfig->getConfigParam( 'blConfirmAGB' ) ) {
			$this->_blConfirmAGBError = 1;
			return;
		}

		// for compatibility reasons for a while. will be removed in future
		if ( oxRegistry::getConfig()->getRequestParameter( 'ord_custinfo' ) !== null && !oxRegistry::getConfig()->getRequestParameter( 'ord_custinfo' ) && $this->isConfirmCustInfoActive() ) {
			$this->_blConfirmCustInfoError =  1;
			return;
		}

		// additional check if we really really have a user now
		if ( !$oUser = $this->getUser() ) {
			return 'user';
		}

		$order = oxNew( 'oxorder' );
		try {
			$validationResult = $order->validateOrder(oxRegistry::getSession()->getBasket(), $oUser);
			if ($validationResult) {
				return;
			}
		} catch (\OxidEsales\Eshop\Core\Exception\OutOfStockException $oEx) {
			$oEx->setDestination('basket');
			\OxidEsales\Eshop\Core\Registry::getUtilsView()->addErrorToDisplay($oEx, false, true, 'basket');
			return;
		}

		if (PayPalPlusCwHelper::isPaypalpluscwPaymentMethod(oxRegistry::getSession()->getBasket()->getPaymentId())) {
			$paymentId = oxRegistry::getSession()->getBasket()->getPaymentId();
			$payment = new PayPalPlusCwPaymentMethod($paymentId);
			if (oxRegistry::getConfig()->getRequestParameter( 'paypalpluscw_create_order' ) !== 'active') {
				if (PayPalPlusCwHelper::isCreateOrderBefore()) {
					$result = parent::execute();

					if (strpos($result, 'thankyou') === 0) {
						$order = oxNew( 'oxorder' );
						$order->load( oxRegistry::getSession()->getVariable( 'sess_challenge' ) );
						$transaction = PayPalPlusCwHelper::loadTransaction($order->oxorder__oxtransid->value);
						$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($transaction->getTransactionObject()->getTransactionContext()->getOrderContext());
						$adapter->prepare($order, $transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod(), null, $transaction);
					}

					if ($this->_finalizeResult > 1) {
						return $result;
					}
				} else {
					$order = PayPalPlusCwHelper::getOrderFromBasket();
					$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($payment->getOrderContext($order));
					$adapter->prepare($order, $payment);
				}
				return 'paypalpluscw_payment?paypalpluscw_transaction_id=' . $adapter->getTransaction()->getTransactionId();
			} else {
				if (PayPalPlusCwHelper::isCreateOrderBefore()) {
					$result = parent::execute();

					if (strpos($result, 'thankyou') === 0) {
						$order = oxNew( 'oxorder' );
						$order->load( oxRegistry::getSession()->getVariable( 'sess_challenge' ) );
						$transaction = PayPalPlusCwHelper::loadTransaction($order->oxorder__oxtransid->value);
						$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($transaction->getTransactionObject()->getTransactionContext()->getOrderContext());
						$adapter->prepare($order, $transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod(), null, $transaction);
					}
				} else {
					$order = PayPalPlusCwHelper::getOrderFromBasket();
					$this->_finalizeResult = 1;

					$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($payment->getOrderContext($order));
					$adapter->prepare($order, $payment);
				}

				$return = array();
				if ($this->_finalizeResult <= 1 && $adapter != null) {
					$return['success'] = true;

					$interfaceClass = $adapter->getPaymentAdapterInterfaceName();
					$return['authorizationMethod'] = $interfaceClass::AUTHORIZATION_METHOD_NAME;

					$vars = $adapter->processOrderConfirmationRequest();
					foreach ($vars as $key => $value) {
						$return[$key] = $value;
					}
				} else {
					$return['success'] = false;
					$return['controller'] = empty($result) ? 'order' : $result;
				}

				echo json_encode($return);
				die();
			}
		} else {
			return parent::execute();
		}
	}

	protected function _getNextStep( $iSuccess )
	{
		$this->_finalizeResult = $iSuccess;

		return parent::_getNextStep( $iSuccess );
	}

	public function validateTermsAndConditions()
	{
		if (method_exists($this, '_validateTermsAndConditions')) {
			return $this->_validateTermsAndConditions();
		} else {
			return !oxRegistry::getConfig()->getConfigParam('blConfirmAGB') || oxConfig::getParameter('ord_agb');
		}
	}
}
