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

require_once 'Customweb/Util/Currency.php';
require_once 'Customweb/Payment/Authorization/DefaultInvoiceItem.php';
require_once 'Customweb/Payment/Authorization/IInvoiceItem.php';


class paypalpluscw_transaction_capture_form extends oxAdminDetails
{
	/**
	 * Executes parent method parent::render(), creates oxorder and
	 * oxlist objects, passes it's data to Smarty engine and returns
	 * name of template file "user_remark.tpl".
	 *
	 * @return string
	 */
	public function render()
	{
		parent::render();

		$orderId = $this->getEditObjectId();
		if ($orderId != '-1' && isset( $orderId)) {
			$oOrder = oxNew('oxorder');
			$oOrder->load($orderId);

			$paymentId = $oOrder->oxorder__oxpaymenttype->value;
			if (PayPalPlusCwHelper::isPaypalpluscwPaymentMethod($paymentId)) {
				$transaction = PayPalPlusCwHelper::loadTransaction($oOrder->oxorder__oxtransid->value);

				$this->_aViewData['referer'] = oxRegistry::getConfig()->getRequestParameter('referer');
				$this->_aViewData['refererId'] = oxRegistry::getConfig()->getRequestParameter('refererId');

				$this->_aViewData['transactionId'] = $transaction->getTransactionId();

				$this->_aViewData['isCapturePossible'] = $transaction->getTransactionObject()->isCapturePossible();
				$this->_aViewData['isPartialCapturePossible'] = $transaction->getTransactionObject()->isPartialCapturePossible();
				$this->_aViewData['isCaptureClosable'] = array($transaction->getTransactionObject()->isCaptureClosable());
				$this->_aViewData['capturableAmount'] = Customweb_Util_Currency::formatAmount($transaction->getTransactionObject()->getCapturableAmount(), $transaction->getTransactionObject()->getCurrencyCode());

				$this->_aViewData['decimalPlaces'] = Customweb_Util_Currency::getDecimalPlaces($transaction->getTransactionObject()->getCurrencyCode());
				$this->_aViewData['currencyCode'] = strtoupper($transaction->getTransactionObject()->getCurrencyCode());

				$uncapturedLineItems = array();
				foreach ($transaction->getTransactionObject()->getUncapturedLineItems() as $item) {
					$amountExcludingTax = Customweb_Util_Currency::formatAmount($item->getAmountExcludingTax(), $transaction->getTransactionObject()->getCurrencyCode());
					$amountIncludingTax = Customweb_Util_Currency::formatAmount($item->getAmountIncludingTax(), $transaction->getTransactionObject()->getCurrencyCode());
					if ($item->getType() == Customweb_Payment_Authorization_IInvoiceItem::TYPE_DISCOUNT) {
						$amountExcludingTax = $amountExcludingTax * -1;
						$amountIncludingTax = $amountIncludingTax * -1;
					}

					$uncapturedLineItems[] = array(
						'name' => PayPalPlusCwHelper::toDefaultEncoding($item->getName()),
						'sku' => PayPalPlusCwHelper::toDefaultEncoding($item->getSku()),
						'type' => $item->getType(),
						'tax_rate' => $item->getTaxRate(),
						'qty' => $item->getQuantity(),
						'amount_excl' => $amountExcludingTax,
						'amount_incl' => $amountIncludingTax
					);
				}
				$this->_aViewData['uncapturedLineItems'] = $uncapturedLineItems;

				return "paypalpluscw_transaction_capture_form.tpl";
			}
		}

		return "paypalpluscw_order_transactions_invalid.tpl";
	}

	public function capture()
	{
		$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('transactionId'));
		$payment = $transaction->getTransactionObject()->getPaymentMethod();

		try {
			if (isset($_POST['quantity'])) {
				$captureLineItems = array();
				$lineItems = $transaction->getTransactionObject()->getUncapturedLineItems();
				foreach ($_POST['quantity'] as $index => $quantity) {
					if (isset($_POST['price_including'][$index]) && floatval($_POST['price_including'][$index]) != 0) {
						$originalItem = $lineItems[$index];
						$priceModifier = 1;
						if ($originalItem->getType() == Customweb_Payment_Authorization_IInvoiceItem::TYPE_DISCOUNT) {
							$priceModifier = -1;
						}
						$captureLineItems[$index] = new Customweb_Payment_Authorization_DefaultInvoiceItem (
								$originalItem->getSku(), $originalItem->getName(), $originalItem->getTaxRate(), $priceModifier *floatval($_POST['price_including'][$index]), $quantity, $originalItem->getType()
						);
					}
				}
				if (count($captureLineItems) > 0) {
					$close = false;
					if (isset($_POST['close']) && $_POST['close'] == 'on') {
						$close = true;
					}
					$payment->capture($transaction, $captureLineItems, $close);
				}
			} else {
				$payment->capture($transaction);
			}

			oxRegistry::get("oxUtilsView")->addErrorToDisplay('Capture was successful.');

			if (oxRegistry::getConfig()->getRequestParameter('referer') == 'transaction') {
				return 'paypalpluscw_transaction_view?oxid=' . oxRegistry::getConfig()->getRequestParameter('refererId');
			}
			return 'paypalpluscw_order_transactions?oxid=' . $this->getEditObjectId();
		} catch (Exception $e) {
			oxRegistry::get("oxUtilsView")->addErrorToDisplay($e);
		}
	}
}