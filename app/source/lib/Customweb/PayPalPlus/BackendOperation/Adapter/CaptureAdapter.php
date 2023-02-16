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

require_once 'Customweb/Payment/Authorization/ITransactionCapture.php';
require_once 'Customweb/Util/Currency.php';
require_once 'Customweb/Payment/BackendOperation/Adapter/Service/ICapture.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Util/Invoice.php';


/**
 * 
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_BackendOperation_Adapter_CaptureAdapter extends Customweb_PayPalPlus_AbstractAdapter implements 
		Customweb_Payment_BackendOperation_Adapter_Service_ICapture {

	public function capture(Customweb_Payment_Authorization_ITransaction $transaction){
		/* @var $transaction Customweb_PayPalPlus_Authorization_Transaction */
		$items = $transaction->getUncapturedLineItems();
		$this->partialCapture($transaction, $items, true);
	}
		
	public function partialCapture(Customweb_Payment_Authorization_ITransaction $transaction, $items, $close){
		$authorizationParameters = $transaction->getAuthorizationParameters();
		$url = null;
		if(isset($authorizationParameters['captureUrl'])) {
			$url = $authorizationParameters['captureUrl'];
		}
		else{
			if($transaction->getAuthorizationType() == 'authorization') {
				if(isset($authorizationParameters['authorizationId'])){
					$url = $this->getConfiguration()->getRestApiUrl().'/v1/payments/authorization/'.$authorizationParameters['authorizationId'].'/capture';
				}
			}
			if ($transaction->getAuthorizationType() == 'order') {
				if(isset($authorizationParameters['orderId'])){
					$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/orders/' . $authorizationParameters['orderId'] .
					'/capture';
				}
			}
		}
		if(empty($url)) {
			throw new Exception(Customweb_I18n_Translation::__('Could not create URI to capture the transaction'));
		}
		$amount = Customweb_Util_Invoice::getTotalAmountIncludingTax($items);
		if(Customweb_Util_Currency::compareAmount($amount, $transaction->getCapturableAmount(), $transaction->getCurrencyCode()) >= 0) {
			$close = true;
		}
		$captureParameters =  array(
			'amount' => array(
				'total' => Customweb_Util_Currency::formatAmount($amount, $transaction->getCurrencyCode(), '.', ''),
				'currency' => $transaction->getCurrencyCode(),
			),
			'is_final_capture' => $close
		);
	
		$responseArray = $this->sendRequestToRESTEndpointCheckResponse($url, 'POST', json_encode($captureParameters));
		
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) || (strtolower($responseArray['state']) != 'completed' && strtolower($responseArray['state'] != 'pending')))) {
			$errorMessage = Customweb_I18n_Translation::__('Capture failed with unkown error.');
			if (isset($responseArray['name'])) {
				$errorMessage = $responseArray['name'];
			}
			if (isset($responseArray['message'])) {
				$errorMessage = $responseArray['message'];
			}
			throw new Exception($errorMessage);
		}
		$captureId = $responseArray['id'];
		$state = Customweb_Payment_Authorization_ITransactionCapture::STATUS_SUCCEED;
		
		if($responseArray['state'] == 'pending') {
			$state = Customweb_Payment_Authorization_ITransactionCapture::STATUS_PENDING;
		}
		
		$transactionFee = $responseArray['transaction_fee'];
		$refundUrl = null;
		
		foreach ($responseArray['links'] as $linkSet) {
			if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'refund') {
				$refundUrl = $linkSet['href'];
				break;
			}
		}
		$captureItem = $transaction->partialCapture($items);
		$captureItem->setExternalId($captureId)->setRefundUrl($refundUrl)->setTransactionFee($transactionFee);
		$captureItem->setStatus($state);
		
	}

}