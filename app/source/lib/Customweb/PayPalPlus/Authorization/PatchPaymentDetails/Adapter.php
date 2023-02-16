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
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Payment/Exception/PaymentErrorException.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/PayPalPlus/Authorization/PatchPaymentDetails/ParameterBuilder.php';
require_once 'Customweb/Core/Logger/Factory.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Authorization_PatchPaymentDetails_Adapter extends Customweb_PayPalPlus_AbstractAdapter {
	
	/**
	 * @var Customweb_Core_ILogger
	 */
	private $logger;
	
	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		parent::__construct($container);
		$this->logger = Customweb_Core_Logger_Factory::getLogger(get_class($this));
	}

	public function updatePaymentDetails(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		$parameterBuilder = new Customweb_PayPalPlus_Authorization_PatchPaymentDetails_ParameterBuilder($this->getContainer(), 
				$transaction);
		$patchRequest = $parameterBuilder->buildPatchParameter();
		
		$authorizationParameters = $transaction->getAuthorizationParameters();
		if (!isset($authorizationParameters['registrationId'])) {
			$userErrorMessage = Customweb_I18n_Translation::__('Error updating the payment details.');
			$backendErrorMessage = Customweb_I18n_Translation::__('Error updating the payment details, registration id is missing.');
			throw new Customweb_Payment_Exception_PaymentErrorException(
					new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $backendErrorMessage));
		}
		
		$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment/' . $authorizationParameters['registrationId'];
		try {
			$response = $this->sendRequestToRESTEndpoint($url, 'PATCH', str_replace('\\/', '/', json_encode($patchRequest)));
		}
		catch (Exception $e) {
			$this->logger->logException($e);
			$userErrorMessage = Customweb_I18n_Translation::__('Error updating the payment details.');
			throw new Customweb_Payment_Exception_PaymentErrorException(
					new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $e->getMessage()));
		}
		$responseArray = json_decode(trim($response->getBody()), true);
		if (!isset($responseArray['id'])) {
			$userErrorMessage = Customweb_I18n_Translation::__('Error updating the payment details.');
			$backendErrorMessage = Customweb_I18n_Translation::__('Error updating the payment details for unkown reason.');
			if (isset($responseArray['name'])) {
				$backendErrorMessage = $responseArray['name'];
			}
			if (isset($responseArray['details'])) {
				foreach ($responseArray['details'] as $detail) {
					if (isset($detail['issue'])) {
						$backendErrorMessage = $detail['issue'];
						break;
					}
				}
			}
			throw new Customweb_Payment_Exception_PaymentErrorException(
					new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $backendErrorMessage));
		}
	}
	
	
}