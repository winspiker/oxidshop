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

require_once 'Customweb/Payment/Update/PullProcessor.php';


class paypalpluscw_order_transactions extends oxAdminDetails
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
				try {
					$transaction = PayPalPlusCwHelper::loadTransaction($oOrder->oxorder__oxtransid->value);
				}
				catch(Exception $e){
					return "paypalpluscw_order_transactions_missing.tpl";
				}

				$this->_aViewData['transactionId'] = $transaction->getTransactionId();

				$this->_aViewData['paymentInformation'] = (string) $transaction->getTransactionObject()->getPaymentInformation();

				$this->_aViewData['isCapturePossible'] = $transaction->getTransactionObject()->isCapturePossible();
				$this->_aViewData['isPartialCapturePossible'] = $transaction->getTransactionObject()->isPartialCapturePossible();

				$this->_aViewData['isRefundPossible'] = $transaction->getTransactionObject()->isRefundPossible();
				$this->_aViewData['isPartialRefundPossible'] = $transaction->getTransactionObject()->isPartialRefundPossible();

				$this->_aViewData['isCancelPossible'] = $transaction->getTransactionObject()->isCancelPossible();

				$this->_aViewData['isUpdatable'] = $transaction->getTransactionObject()->isUpdatable();

				$labels = $transaction->getTransactionObject()->getTransactionLabels();
				foreach ($labels as $index => $label) {
					$labels[$index]['label'] = PayPalPlusCwHelper::toDefaultEncoding($label['label']);
					$labels[$index]['value'] = PayPalPlusCwHelper::toDefaultEncoding($label['value']);
					$labels[$index]['description'] = PayPalPlusCwHelper::toDefaultEncoding($label['description']);
				}
				$this->_aViewData['labels'] = $labels;

				$items = array();
				foreach ($transaction->getTransactionObject()->getHistoryItems() as $item) {
					$items[] = array(
						'creationdate' => $item->getCreationDate()->format(oxRegistry::getLang()->translateString('DATE_FORMAT')),
						'action' => $item->getActionPerformed(),
						'message' => PayPalPlusCwHelper::toDefaultEncoding($item->getMessage())
					);
				}
				$this->_aViewData['history'] = $items;

				$captures = array();
				foreach ($transaction->getTransactionObject()->getCaptures() as $capture) {
					$captures[] = array(
						'date' => $capture->getCaptureDate()->format(oxRegistry::getLang()->translateString('DATE_FORMAT')),
						'amount' => $capture->getAmount(),
						'status' => PayPalPlusCwHelper::toDefaultEncoding($capture->getStatus()),
						'id' => $capture->getCaptureId()
					);
				}
				$this->_aViewData['captures'] = $captures;

				$refunds = array();
				foreach ($transaction->getTransactionObject()->getRefunds() as $refund) {
					$refunds[] = array(
						'date' => $refund->getRefundedDate()->format(oxRegistry::getLang()->translateString('DATE_FORMAT')),
						'amount' => $refund->getAmount(),
						'status' => PayPalPlusCwHelper::toDefaultEncoding($refund->getStatus()),
						'id' => $refund->getRefundId()
					);
				}
				$this->_aViewData['refunds'] = $refunds;

				$cancels = array();
				$cancelLabels = array();
				foreach ($transaction->getTransactionObject()->getCancels() as $cancel) {
					$cancels[] = $cancel->getCancelLabels();

					if (empty($cancelLabels)) {
						foreach ($cancel->getCancelLabels() as $field) {
							$cancelLabels[] = $field['label'];
						}
					}
				}
				$this->_aViewData['cancels'] = $cancels;
				$this->_aViewData['cancelLabels'] = $cancelLabels;

				return "paypalpluscw_order_transactions.tpl";
			}
		}

		return "paypalpluscw_order_transactions_invalid.tpl";
	}

	public function update()
	{
		
		$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('transactionId'));

		try {
			$updateHandler = PayPalPlusCwHelper::createContainer()->getBean('Customweb_Payment_Update_IHandler');
			$updateProcessor = new Customweb_Payment_Update_PullProcessor($updateHandler, $transaction->getTransactionId());
			$updateProcessor->process();

			oxRegistry::get("oxUtilsView")->addErrorToDisplay('Update was successful.');
		}
		catch (Exception $e) {
			$message = "Updating of transaction with id '" . $transaction->getTransactionId() . "' failed. \nReason: ".$e->getMessage();
			oxRegistry::get("oxUtilsView")->addErrorToDisplay($message);
		}
		

		if (oxRegistry::getConfig()->getRequestParameter('referer') == 'transaction') {
			return 'paypalpluscw_transaction_view?oxid=' . oxRegistry::getConfig()->getRequestParameter('refererId');
		}
	}

	public function cancel()
	{
		try {
			$transaction = PayPalPlusCwHelper::loadTransaction(oxRegistry::getConfig()->getRequestParameter('transactionId'));
			$payment = $transaction->getTransactionObject()->getPaymentMethod();

			$close = false;
			if (oxRegistry::getConfig()->getRequestParameter('close') == 'on') {
				$close = true;
			}

			$payment->cancel($transaction);

			oxRegistry::get("oxUtilsView")->addErrorToDisplay('Cancel was successful.');
		} catch (Exception $e) {
			oxRegistry::get("oxUtilsView")->addErrorToDisplay($e);
		}

		if (oxRegistry::getConfig()->getRequestParameter('referer') == 'transaction') {
			return 'paypalpluscw_transaction_view?oxid=' . oxRegistry::getConfig()->getRequestParameter('refererId');
		}
	}
}