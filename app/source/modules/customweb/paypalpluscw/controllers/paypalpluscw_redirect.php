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



class paypalpluscw_redirect extends oxUBase
{
	protected $_sThisTemplate = 'paypalpluscw_redirect.tpl';

	public function render()
	{
		parent::render();

		try {
			$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('cstrxid'));

			$order = PayPalPlusCwHelper::getOrderFromBasket();
			if ($transaction->getOrder() !== null) {
				$order = $transaction->getOrder();
			}

			$adapter = PayPalPlusCwHelper::getCheckoutAdapterByContext($transaction->getTransactionObject()->getTransactionContext()->getOrderContext());
			$adapter->prepare($order, $transaction->getTransactionObject()->getTransactionContext()->getOrderContext()->getPaymentMethod(), null, $transaction);

			$headerRedirection = $adapter->isHeaderRedirectionSupported();
			if ($headerRedirection) {
				$redirectionUrl = $adapter->getRedirectionUrl();
				header("Location: " . $redirectionUrl);
				die();
			} else {
				$vars = $adapter->getRedirectionTemplateVars();
				foreach ($vars as $key => $value) {
					$this->_aViewData[$key] = $value;
				}

				return $this->_sThisTemplate;
			}
		} catch (Exception $e) {
			oxRegistry::get("oxUtilsView")->addErrorToDisplay('Unfortunately, there has been a problem during the payment process. Please try again.');

			$redirectionUrl = PayPalPlusCwHelper::getUrl(array(
				'cl' => 'order',
			));

			header("Location: " . $redirectionUrl);
			die();
		}
	}
}