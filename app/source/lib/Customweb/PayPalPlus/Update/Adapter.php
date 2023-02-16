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
require_once 'Customweb/PayPalPlus/Authorization/Transaction.php';
require_once 'Customweb/Core/Exception/CastException.php';
require_once 'Customweb/Payment/Update/IAdapter.php';
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Core/Logger/Factory.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Update_Adapter extends Customweb_PayPalPlus_AbstractAdapter implements Customweb_Payment_Update_IAdapter {
	
	/**
	 * @var Customweb_Core_ILogger
	 */
	private $logger;
	
	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		parent::__construct($container);
		$this->logger = Customweb_Core_Logger_Factory::getLogger(get_class($this));
	}
	

	public function updateTransaction(Customweb_Payment_Authorization_ITransaction $transaction){
		if (!$transaction instanceof Customweb_PayPalPlus_Authorization_Transaction) {
			throw new Customweb_Core_Exception_CastException('Customweb_PayPalPlus_Authorization_Transaction');
		}
		
		if(!$transaction->isAuthorized() && !$transaction->isAuthorizationFailed()){
			
			$authorizeParameters = $transaction->getAuthorizationParameters();
			if (isset($authorizeParameters['registrationId'])) {
				$transaction->setPaymentId($authorizeParameters['registrationId']);
			}
			
			$checkUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment/' . $transaction->getPaymentId();
			try {
				$checkResponse = $this->sendRequestToRESTEndpointCheckResponse($checkUrl, 'GET', null);
				if (!isset($checkResponse['id']) || (!isset($checkResponse['state']) || strtolower($checkResponse['state']) == 'failed')) {
					$this->logger->logDebug('Transaction execution failed', $checkResponse);
					$userErrorMessage = Customweb_I18n_Translation::__('Transaction execution failed');
					$errorMessage = Customweb_I18n_Translation::__('Transaction execution failed');
					if (isset($checkResponse['name'])) {
						$errorMessage = $checkResponse['name'];
					}
					if (isset($checkResponse['message'])) {
						$errorMessage = $checkResponse['message'];
					}
					$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $errorMessage));
					return;
				}
				if(strtolower($checkResponse['state']) != 'approved') {
					if($transaction->getRetryCounter() < 7) {
						$transaction->increaseRetryCounter();
						$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addMinutes(10));
					}
					else{
						$transaction->setAuthorizationFailed(Customweb_I18n_Translation::__('The Transaction timed out.'));
					}
					return;
				}
				$executionParameters = array(
					'executionId' => $checkResponse['id'],
					'executionState' => $checkResponse['state'] 
				);
				$transaction->addAuthorizationParameters($executionParameters);
					
				$authorizationHandler = $this->getContainer()->getBean('Customweb_PayPalPlus_Authorization_Handler');
				$authorizationHandler->processExecutionResponse($transaction, $checkResponse);
				
			}
			catch (Exception $e) {
				$this->logger->logException($e);
				if($transaction->getRetryCounter() < 7) {
					$transaction->increaseRetryCounter();	
					$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addMinutes(10));
				}
				else{
					$transaction->setAuthorizationFailed(Customweb_I18n_Translation::__('Transaction timed out.'));
				}
				return;
			}
		}
		if($transaction->isAuthorized() && $transaction->isAuthorizationUncertain()){
			try {
				if ($transaction->getAuthorizationType() == 'sale') {
					$parameters = $transaction->getAuthorizationParameters();
					if (!isset($parameters['saleId'])) {
						$transaction->addErrorMessage(
								new Customweb_Payment_Authorization_ErrorMessage(
										Customweb_I18n_Translation::__('Can not update transaction, saleId not set')));
						$transaction->setUpdateExecutionDate(null);
						return;
					}
					
					$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/sale/' . $parameters['saleId'];
					$response = $this->sendRequestToRESTEndpointCheckResponse($url, 'GET');
					
					$updatedParameters = array();
					if (isset($response['state'])) {
						$updatedParameters['saleState'] = $response['state'];
						if ($response['state'] == 'denied') {
							$transaction->setUncertainTransactionFinallyDeclined();
							$transaction->addAuthorizationParameters($updatedParameters);
							$transaction->setUpdateExecutionDate(null);
						}
						elseif ($response['state'] == 'completed') {
							if (!$transaction->isProtectionUncertain()) {
								$transaction->setAuthorizationUncertain(false);
							}
							$transaction->setPendingReason(null);
							if (isset($response['protection_eligibility'])) {
								$updatedParameters['protectionEligibility'] = $response['protection_eligibility'];
							}
							if (isset($response['protection_eligibility_type'])) {
								$updatedParameters['protectionEligibilityType'] = $response['protection_eligibility_type'];
							}
							$transaction->addAuthorizationParameters($updatedParameters);
							$this->handleSellerProtection($transaction);
							$transaction->setUpdateExecutionDate(null);
						}
						elseif ($response['state'] == 'pending') {
							$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addHours(1));
						}
					}
				}
				elseif ($transaction->getAuthorizationType() == 'authorize') {
					$parameters = $transaction->getAuthorizationParameters();
					if (!isset($parameters['authorizeId'])) {
						$transaction->addErrorMessage(
								new Customweb_Payment_Authorization_ErrorMessage(
										Customweb_I18n_Translation::__('Can not update transaction, authorizeId not set')));
						$transaction->setUpdateExecutionDate(null);
						return;
					}
					
					$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/authorization/' . $parameters['authorizeId'];
					$response = $this->sendRequestToRESTEndpointCheckResponse($url, 'GET');
					
					$updatedParameters = array();
					if (isset($response['state'])) {
						$updatedParameters['authorizedState'] = $response['state'];
						if ($response['state'] == 'denied') {
							$transaction->setUncertainTransactionFinallyDeclined();
							$transaction->addAuthorizationParameters($updatedParameters);
							$transaction->setUpdateExecutionDate(null);
						}
						elseif ($response['state'] == 'authorized') {
							if (!$transaction->isProtectionUncertain()) {
								$transaction->setAuthorizationUncertain(false);
							}
							$transaction->setPendingReason(null);
							if (isset($response['protection_eligibility'])) {
								$updatedParameters['protectionEligibility'] = $response['protection_eligibility'];
							}
							if (isset($response['protection_eligibility_type'])) {
								$updatedParameters['protectionEligibilityType'] = $response['protection_eligibility_type'];
							}
							$transaction->addAuthorizationParameters($updatedParameters);
							$this->handleSellerProtection($transaction);
							$transaction->setUpdateExecutionDate(null);
						}
						elseif ($response['state'] == 'pending') {
							$transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addHours(1));
						}
					}
				}
			}
			catch (Exception $e) {
				$this->logger->logException($e);
				$transaction->addErrorMessage(
						new Customweb_Payment_Authorization_ErrorMessage(
								Customweb_I18n_Translation::__('Error updating transaction: !error', 
										array(
											'!error' => $e->getMessage() 
										))));
				$transaction->setUpdateExecutionDate($transaction->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addHours(1)));
			}
		}
	}
}
