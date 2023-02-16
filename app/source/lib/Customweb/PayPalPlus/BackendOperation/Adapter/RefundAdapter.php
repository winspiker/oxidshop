<?php

/**
 *  * You are allowed to use this API in your web application.
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
 */

require_once 'Customweb/PayPalPlus/Authorization/Transaction.php';
require_once 'Customweb/Util/Currency.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Payment/BackendOperation/Adapter/Service/IRefund.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Util/Invoice.php';



/**
 * 
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_BackendOperation_Adapter_RefundAdapter extends Customweb_PayPalPlus_AbstractAdapter implements 
		Customweb_Payment_BackendOperation_Adapter_Service_IRefund {

	public function refund(Customweb_Payment_Authorization_ITransaction $transaction){
		$items = $transaction->getTransactionContext()->getOrderContext()->getInvoiceItems();
		return $this->partialRefund($transaction, $items, true);
	}

	public function partialRefund(Customweb_Payment_Authorization_ITransaction $transaction, $items, $close){
		if (!$transaction instanceof Customweb_PayPalPlus_Authorization_Transaction) {
			throw new Exception("Transaction must be of type Customweb_PayPalPlus_Authorization_Transaction.");
		}

		$transaction->refundByLineItemsDry($items, $close);
		$amount = Customweb_Util_Invoice::getTotalAmountIncludingTax($items);
		$totalNotRefundedAmount = $transaction->getRefundableAmount();
	
		$residualAmount = $amount;
	
		if ($amount >= $totalNotRefundedAmount) {
			$close = true;
		}
		//The logic to refund from different captures
		foreach ($transaction->getCaptures() as $capture) {
			// Check if we are finished with refunding
			if ($residualAmount <= 0) {
				break;
			}				
			$amountToRefund = $residualAmount;
			$refundableAmount = $capture->getAmount() - $capture->getRefundedAmount();
			if ($refundableAmount < $residualAmount) {
				$amountToRefund = $refundableAmount;
			}
				
			if ($amountToRefund <= 0) {
				continue;
			}
				
			$residualAmount = $residualAmount - $amountToRefund;
				
			$closeRefund = false;
			if ($close) {
				if ($residualAmount <= 0) {
					$closeRefund = true;
				}
			}
			$this->doRefund($amountToRefund, $closeRefund, $transaction, $capture);
		}
		$this->updatePaymentInstructions($transaction);
	}

	
	//Processing the HTTP-Request to refund
	protected function doRefund($amountToRefund, $close, Customweb_PayPalPlus_Authorization_Transaction $transaction, Customweb_PayPalPlus_Authorization_TransactionCapture $capture){
		$url = $capture->getRefundUrl();
		if($url === null){
			if($transaction->getAuthorizationType() == 'sale') {
				if($capture->getExternalId() !== null){
					$url = $this->getConfiguration()->getRestApiUrl().'/v1/payments/sale/'.$capture->getExternalId().'/refund';
					
				}
				
			}
			if($transaction->getAuthorizationType() == 'authorization' || $transaction->getAuthorizationType() == 'order') {
				if($capture->getExternalId() !== null){
					$url = $this->getConfiguration()->getRestApiUrl().'/v1/payments/capture/'.$capture->getExternalId().'/refund';
				}
			}
		}
		if(empty($url)) {
			throw new Exception(Customweb_I18n_Translation::__('Could not create URI to refund the transaction'));
		}
		$amount = Customweb_Util_Currency::formatAmount($amountToRefund, $transaction->getCurrencyCode(), '.', '');
		$refundParameters =  array(
			'amount' => array(
				'total' => $amount,
				'currency' => $transaction->getCurrencyCode(),
			),
		);
		
		$responseArray = $this->sendRequestToRESTEndpointCheckResponse($url, 'POST', json_encode($refundParameters));
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) || (strtolower($responseArray['state']) != 'completed' && strtolower($responseArray['state'] != pending)))) {
			$errorMessage = Customweb_I18n_Translation::__('Refund failed with unkown error.');
			if (isset($responseArray['name'])) {
				$errorMessage = $responseArray['name'];
			}
			if (isset($responseArray['message'])) {
				$errorMessage = $responseArray['message'];
			}
			throw new Exception($errorMessage);
		}
		$refundId = $responseArray['id'];
		
		$refundItem = $transaction->refund($amount, $close);
		$refundItem->setExternalId($refundId);
		
		$capture->setRefundedAmount(($capture->getRefundedAmount() + $amount));
	}
	

}