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
 */

require_once 'Customweb/PayPalPlus/Container.php';
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Core/Http/Client/Factory.php';
require_once 'Customweb/Core/Http/Request.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_AbstractAdapter
{
	/**
	 * Configuration object.
	 *
	 * @var Customweb_PayPalPlus_Container
	 */
	private $container;
	
	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		$this->container = new Customweb_PayPalPlus_Container($container);
	}
	
	public function getContainer() {
		return $this->container;
	}
	
	/**
	 * @return Customweb_PayPalPlus_Configuration
	 */
	public function getConfiguration() {
		return $this->getContainer()->getConfiguration();
	}
	
	
	protected function sendRequestToRESTEndpoint($url, $method ='GET', $body = null){
		$request = new Customweb_Core_Http_Request($url);
	
		$request->setMethod($method);
		if($body !==null ){
			$request->setBody($body);	
		}
		$request->appendHeader('Content-Type:application/json');
		$request->appendHeader('Authorization: Bearer ' . $this->getBearerAuthorizationToken());
		$request->appendHeader('PayPal-Partner-Attribution-Id: '.$this->getBuildNotationCode());
		$client = Customweb_Core_Http_Client_Factory::createClient();
		$response =  $client->send($request);
		return $response;
		
	}
	
	
	protected function sendRequestToRESTEndpointCheckResponse($url, $method ='GET', $body = null){
		try {
			$response = $this->sendRequestToRESTEndpoint($url, $method, $body);
		}
		catch (Exception $e) {
			throw new Exception(Customweb_I18n_Translation::__('Connection error.'));
		}
		$responseArray = json_decode(trim($response->getBody()), true);
		if ($responseArray === false) {
			throw new Exception(Customweb_I18n_Translation::__(
					'Received malformatted response from PayPal Plus'));
		}
		return $responseArray;
	
	}
	
	protected function getBearerAuthorizationToken(){
		$tokenAdapter = $this->getContainer()->getBean('Customweb_PayPalPlus_AuthTokenAdapter');
		return $tokenAdapter->getToken();
	}
	
	protected function handleSellerProtection(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		$transactionParameters = $transaction->getAuthorizationParameters();
		$selectedValues = $this->getConfiguration()->getSellerProtectionSelection();
		$uncertain = false;
		if (isset($transactionParameters['protectionEligibility']) && $transactionParameters['protectionEligibility'] == 'INELIGIBLE' && in_array('ineligible', $selectedValues)) {
			$uncertain = true;
				
		}
		elseif (isset($transactionParameters['protectionEligibility']) && $transactionParameters['protectionEligibility'] == 'PARTIALLY_ELIGIBLE') {
			if(isset($transactionParameters['protectionEligibilityType'])){
				$partial = explode(',', $transactionParameters['protectionEligibilityType']);
				if (in_array('itemNotReceived', $selectedValues) && !in_array('ITEM_NOT_RECEIVED_ELIGIBLE', $partial)) {
					$uncertain = true;
				}
				if (in_array('unauthorizedPayment', $selectedValues) && !in_array('UNAUTHORIZED_PAYMENT_ELIGIBLE', $partial)) {
					$uncertain = true;
				}
			}
		}
		$transaction->setProtectionUncertain($uncertain);
	
		if($transaction->getPendingReason() == null) {
			$transaction->setAuthorizationUncertain($uncertain);
		}
	}

	protected function getBuildNotationCode(){
		return 'Customweb_Plus_OX';
	}
	
	protected function updatePaymentInstructions(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		try{
			$parameters = $transaction->getAuthorizationParameters();
			if(!isset($parameters['paymentInformation'])) {
				//No information to update
				return;
			}
			$url = '';
			foreach ($parameters['paymentInformation']['links'] as $linkSet) {
				if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'self') {
					$url = $linkSet['href'];
					break;
				}
			}
			if(empty($url)){
				$url = $this->getConfiguration()->getRestApiUrl().'/v1/payments/payment/'.$transaction->getPaymentId().'/payment-instruction';
			}
			$responseArray = $this->sendRequestToRESTEndpointCheckResponse($url);
			$updateParameters = array();
			$updateParameters['paymentInformation'] = $responseArray['payment_instruction'];
				
		}
		catch(Exception $e){
			$transaction->addErrorMessage(new Customweb_Payment_Authorization_ErrorMessage(Customweb_I18n_Translation::__('Could not update payment information')));
		}
	
	}
}