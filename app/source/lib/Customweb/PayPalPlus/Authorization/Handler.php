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
require_once 'Customweb/Core/DateTime.php';
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Payment/Authorization/OrderContext/Address/Default.php';
require_once 'Customweb/PayPalPlus/Util.php';
require_once 'Customweb/Core/Logger/Factory.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Authorization_Handler extends Customweb_PayPalPlus_AbstractAdapter {
	
	/**
	 * @var Customweb_Core_ILogger
	 */
	private $logger;
	
	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		parent::__construct($container);
		$this->logger = Customweb_Core_Logger_Factory::getLogger(get_class($this));
	}
	

	public function processAuthorization(Customweb_PayPalPlus_Authorization_Transaction $transaction, array $parameters){
		$userErrorMessage = Customweb_I18n_Translation::__('Technical problem, please contact the merchant.');
		if (!isset($parameters['paymentId']) || !isset($parameters['PayerID'])) {
			$authorizeParameters = $transaction->getAuthorizationParameters();
			if (isset($authorizeParameters['registrationId'])) {
				$transaction->setPaymentId($authorizeParameters['registrationId']);
			}
			$transaction->setAuthorizationFailed(
					new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, 
							Customweb_I18n_Translation::__('No PayerId or paymentId returned')));
			return;
		}
		$authorizationParameters = array(
			'paymentId' => $parameters['paymentId'],
			'payerId' => $parameters['PayerID'] 
		);
		$transaction->setPaymentId($parameters['paymentId']);
		$transaction->addAuthorizationParameters($authorizationParameters);
		
		$checkUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment/' . $parameters['paymentId'];
		try {
			$checkResponse = $this->sendRequestToRESTEndpointCheckResponse($checkUrl, 'GET', null);
			if (!isset($checkResponse['payer']['payer_info']['shipping_address'])) {
				throw new Exception(Customweb_I18n_Translation::__('Incomplete Address Check Response'));
			}
			$shippingArray = $checkResponse['payer']['payer_info']['shipping_address'];
			$shippingAddress = new Customweb_Payment_Authorization_OrderContext_Address_Default();
			$firstName = $shippingArray['recipient_name'];
			$lastName = "";
			if(strpos(trim($shippingArray['recipient_name']), " ") !== false){
				list($firstName, $lastName) = explode(' ', trim($shippingArray['recipient_name']), 2);
			}
			$shippingAddress->setFirstName(trim($firstName))->setLastName(trim($lastName));
			$shippingAddress->setStreet(trim($shippingArray['line1']));
			if (isset($shippingArray['line2']) && trim($shippingArray['line2']) != '') {
				$shippingAddress->setStreet(trim($shippingAddress->getStreet() . ' ' . trim($shippingArray['line2'])));
			}
			$shippingAddress->setPostCode(trim($shippingArray['postal_code']));
			$shippingAddress->setCity(trim($shippingArray['city']));
			$shippingAddress->setCountryIsoCode(trim($shippingArray['country_code']));
			if (isset($shippingArray['state']) && trim($shippingArray['state']) != '') {
				$shippingAddress->setState(trim($shippingArray['state']));
			}
			$transaction->setReturnedAddress($shippingArray);
			if (!$transaction->isAddressCheckDisabled() && !Customweb_PayPalPlus_Util::compareAddresses(
					$transaction->getTransactionContext()->getOrderContext()->getShippingAddress(), $shippingAddress)) {
				$errorMessage = Customweb_I18n_Translation::__('Modifications to the shipping address are not allowed.');
				$transaction->setAuthorizationFailed($errorMessage);
				return;
			}
		}
		catch (Exception $e) {
			$this->logger->logException($e);
			$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $e->getMessage()));
			return;
		}
		$storage = $this->getContainer()->getStorage();
		try {
			$storage->remove('PayPalPlusURL', $transaction->getTransactionContext()->getOrderContext()->getCheckoutId());
		}
		catch (Exception $e) {
			//Ignore
		}
		$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment/' . $parameters['paymentId'] . '/execute/';
		$executeRequestParameters = array(
			'payer_id' => $parameters['PayerID'] 
		);
		try {
			$response = $this->sendExecuteRequest($url, $executeRequestParameters);
			$checkUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment/' . $parameters['paymentId'];
			$responseArray = $this->checkAlreadyExecute($response, $checkUrl);
		}
		catch (Exception $e) {
			$this->logger->logException($e);
			$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $e->getMessage()));
			return;
		}
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) || strtolower($responseArray['state']) != 'approved')) {
			$this->logger->logDebug('Transaction execution failed', $responseArray);
			$errorMessage = Customweb_I18n_Translation::__('Transaction execution failed');
			if (isset($responseArray['name'])) {
				$errorMessage = $responseArray['name'];
			}
			if (isset($responseArray['message'])) {
				$errorMessage = $responseArray['message'];
			}
			$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $errorMessage));
			return;
		}
		$executionParameters = array(
			'executionId' => $responseArray['id'],
			'executionState' => $responseArray['state'] 
		);
		$transaction->addAuthorizationParameters($executionParameters);
		$this->processExecutionResponse($transaction, $responseArray);
	}
	
	private function sendExecuteRequest($url, array $parameters){
		$lastException = null;
		for($i=0; $i<3;$i++){
			try {
				$response = $this->sendRequestToRESTEndpoint($url, 'POST', json_encode($parameters));
				$responseArray = json_decode(trim($response->getBody()), true);
				if ($responseArray === false) {
					throw new Exception(Customweb_I18n_Translation::__('Received malformatted response from PayPal Plus during execution.')." ".$response->getBody());
				}
				return $response;
			}
			catch (Exception $e) {
				$lastException = $e;
			}
		}
		throw $lastException;
	}
	
	private function checkAlreadyExecute($response, $checkUrl){
		$responseArray = json_decode(trim($response->getBody()), true);
		if($response->getStatusCode() == 400 && isset($responseArray['name']) && $responseArray['name'] == 'PAYMENT_ALREADY_DONE'){
			$lastException = null;
			for($i=0; $i<3;$i++){
				try{
					$checkResponse = $this->sendRequestToRESTEndpoint($checkUrl, 'GET', null);
					$responseArray = json_decode(trim($checkResponse->getBody()), true);
					if ($responseArray === false) {
						throw new Exception(Customweb_I18n_Translation::__('Received malformatted response from PayPal Plus during execution.')." ".$checkResponse->getBody());
					}
					return $responseArray;
				}catch (Exception $e) {
						$lastException = $e;
					}
			}
			throw $lastException;
		}		
		else{
			return $responseArray;
		}
	}
	
	

	public function processExecutionResponse(Customweb_PayPalPlus_Authorization_Transaction $transaction, array $responseArray){
		switch (strtolower($responseArray['intent'])) {
			case 'sale':
				$this->handleSaleResponse($transaction, $responseArray);
				break;
			case 'authorize':
				$this->handleAuthorizeResponse($transaction, $responseArray);
				break;
			case 'order':
				$this->handleOrderResponse($transaction, $responseArray);
				break;
			default:
				$reason = Customweb_I18n_Translation::__('Not supported intent. Please contact the merchant for more information about your payment');
				$transaction->setAuthorizationFailed($reason);
				break;
		}
	}

	private function handleSaleResponse(Customweb_PayPalPlus_Authorization_Transaction $transaction, array $responseArray){
		$saleParameters = array();
		if (isset($responseArray['cart'])) {
			$saleParameters['cart'] = $responseArray['cart'];
		}
		$transactionFee = array();
		$refundUrl = null;
		$saleId = null;
		if (isset($responseArray['transactions']) && is_array($responseArray['transactions']) && count($responseArray['transactions']) > 0) {
			$transctionArray = end($responseArray['transactions']);
			if (isset($transctionArray['related_resources']) && is_array($transctionArray['related_resources'])) {
				foreach ($transctionArray['related_resources'] as $relatedResource) {
					if (isset($relatedResource['sale'])) {
						$saleArray = $relatedResource['sale'];
						if (isset($saleArray['id'])) {
							$saleParameters['saleId'] = $saleArray['id'];
							$saleId = $saleArray['id'];
						}
						if (isset($saleArray['state'])) {
							$saleParameters['saleState'] = $saleArray['state'];
							if ($saleArray['state'] == 'pending') {
								$transaction->setAuthorizationUncertain(true);
								$reason = 'UNKOWN';
								if (isset($saleArray['reason_code'])) {
									$reason = $saleArray['reason_code'];
								}
								$transaction->setPendingReason($reason);
								$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addHours(1));
							}
						}
						if (isset($saleArray['payment_mode'])) {
							$saleParameters['paymentMode'] = $saleArray['payment_mode'];
						}
						if (isset($saleArray['protection_eligibility'])) {
							$saleParameters['protectionEligibility'] = $saleArray['protection_eligibility'];
						}
						if (isset($saleArray['protection_eligibility_type'])) {
							$saleParameters['protectionEligibilityType'] = $saleArray['protection_eligibility_type'];
						}
						if (isset($saleArray['transaction_fee'])) {
							$transactionFee = $saleArray['transaction_fee'];
						}
						foreach ($saleArray['links'] as $linkSet) {
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'refund') {
								$refundUrl = $linkSet['href'];
								break;
							}
						}
						break;
					}
				}
			}
		}
		if (isset($responseArray['payment_instruction'])) {
			$saleParameters['paymentInformation'] = $responseArray['payment_instruction'];
			$saleParameters['shopName'] = $this->getConfiguration()->getShopName();
		}
		$transaction->addAuthorizationParameters($saleParameters);
		$transaction->authorize();
		
		$captureItem = $transaction->capture();
		$captureItem->setExternalId($saleId)->setRefundUrl($refundUrl)->setTransactionFee($transactionFee);
		$this->handleSellerProtection($transaction);
	}

	private function handleAuthorizeResponse(Customweb_PayPalPlus_Authorization_Transaction $transaction, array $responseArray){
		$authorizeParameters = array();
		if (isset($responseArray['cart'])) {
			$authorizeParameters['cart'] = $responseArray['cart'];
		}
		if (isset($responseArray['transactions']) && is_array($responseArray['transactions']) && count($responseArray['transactions']) > 0) {
			$transctionArray = end($responseArray['transactions']);
			if (isset($transctionArray['related_resources']) && is_array($transctionArray['related_resources'])) {
				foreach ($transctionArray['related_resources'] as $relatedResource) {
					if (isset($relatedResource['authorization'])) {
						$authorizeArray = $relatedResource['authorization'];
						if (isset($authorizeArray['id'])) {
							$authorizeParameters['authorizeId'] = $authorizeArray['id'];
						}
						if (isset($authorizeArray['state'])) {
							$authorizeParameters['authorizationState'] = $authorizeArray['state'];
							if ($authorizeArray['state'] == 'pending') {
								$transaction->setAuthorizationUncertain(true);
								$reason = 'UNKOWN';
								if (isset($authorizeArray['reason_code'])) {
									$reason = $authorizeArray['reason_code'];
								}
								$transaction->setPendingReason($reason);
								$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addHours(1));
							}
						}
						if (isset($authorizeArray['payment_mode'])) {
							$authorizeParameters['paymentMode'] = $authorizeArray['payment_mode'];
						}
						if (isset($authorizeArray['protection_eligibility'])) {
							$authorizeParameters['protectionEligibility'] = $authorizeArray['protection_eligibility'];
						}
						if (isset($authorizeArray['protection_eligibility_type'])) {
							$authorizeParameters['protectionEligibilityType'] = $authorizeArray['protection_eligibility_type'];
						}
						foreach ($authorizeArray['links'] as $linkSet) {
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'capture') {
								$authorizeParameters['captureUrl'] = $linkSet['href'];
							}
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'void') {
								$authorizeParameters['cancelUrl'] = $linkSet['href'];
							}
						}
						break;
					}
				}
			}
		}
		if (isset($responseArray['payment_instruction'])) {
			$authorizeParameters['paymentInformation'] = $responseArray['payment_instruction'];
			$authorizeParameters['shopName'] = $this->getConfiguration()->getShopName();
		}
		$transaction->addAuthorizationParameters($authorizeParameters);
		$transaction->authorize();
		
		$this->handleSellerProtection($transaction);
	}

	private function handleOrderResponse(Customweb_PayPalPlus_Authorization_Transaction $transaction, array $responseArray){
		$orderParameters = array();
		
		if (isset($responseArray['transactions']) && is_array($responseArray['transactions']) && count($responseArray['transactions']) > 0) {
			$transctionArray = end($responseArray['transactions']);
			if (isset($transctionArray['related_resources']) && is_array($transctionArray['related_resources'])) {
				foreach ($transctionArray['related_resources'] as $relatedResource) {
					if (isset($relatedResource['order'])) {
						$orderArray = $relatedResource['order'];
						if (isset($orderArray['id'])) {
							$orderParameters['orderId'] = $orderArray['id'];
						}
						if (isset($orderArray['state'])) {
							$orderParameters['orderState'] = $orderArray['state'];
						}
						if (isset($orderArray['payment_mode'])) {
							$orderParameters['paymentMode'] = $orderArray['payment_mode'];
						}
						foreach ($orderArray['links'] as $linkSet) {
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'capture') {
								$orderParameters['captureUrl'] = $linkSet['href'];
							}
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'void') {
								$orderParameters['cancelUrl'] = $linkSet['href'];
							}
							if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'authorization') {
								$orderParameters['authorizeUrl'] = $linkSet['href'];
							}
						}
						break;
					}
				}
			}
		}
		$transaction->addAuthorizationParameters($orderParameters);
		$transaction->authorize();
	}
}