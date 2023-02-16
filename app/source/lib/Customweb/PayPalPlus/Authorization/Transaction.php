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

require_once 'Customweb/PayPalPlus/Authorization/TransactionRefund.php';
require_once 'Customweb/Core/DateTime.php';
require_once 'Customweb/PayPalPlus/Authorization/PaymentInformation/Formatter.php';
require_once 'Customweb/Util/Currency.php';
require_once 'Customweb/PayPalPlus/Authorization/TransactionCapture.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Core/Util/Rand.php';
require_once 'Customweb/Payment/Authorization/DefaultTransaction.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_Transaction extends Customweb_Payment_Authorization_DefaultTransaction {
	private $authorizationType;
	private $approvalUrl;
	
	private $pendingReason = null;
	
	private $protectionUncertain = false;
	
	private $endpointKey = null;
	
	private $returnedAddress = null;
	
	private $isAddressCheckDisabled = false;
	
	private $retryCounter = 0;
	
	
	public function __construct(Customweb_Payment_Authorization_ITransactionContext $transactionContext) {
		parent::__construct($transactionContext);
		$this->endpointKey = Customweb_Core_Util_Rand::getRandomString(64);
		$this->setUpdateExecutionDate(Customweb_Core_DateTime::_()->addMinutes(30));
	}


	public function setAuthorizationType($authorizationType){
		$this->authorizationType = $authorizationType;
	}

	public function getAuthorizationType(){
		return $this->authorizationType;
	}
	
	public function addAuthorizationParameters(array $params){
		$authParams = $this->getAuthorizationParameters();
		if(!is_array($authParams)){
			$authParams = array();
		}
		foreach ($params as $key => $value) {
			$authParams[$key] = $value;
		}
		$this->setAuthorizationParameters($authParams);
	}

	public function setApprovalUrl($url){
		$this->approvalUrl = $url;
		return $this;
	}
	
	public function getApprovalUrl(){
		return $this->approvalUrl;
	}	
	
	public function setProtectionUncertain($bool = true){
		$this->protectionUncertain = true;
		return $this;
	}
	
	public function isProtectionUncertain(){
		return $this->protectionUncertain;
	}
	
	public function setPendingReason($reason) {
		$this->pendingReason = $reason;
		return $this;
	}
	
	public function getPendingReason() {
		return $this->pendingReason;
	}
	
	public function setEndpointKey($key){
		$this->endpointKey = $key;
		return $this;
	}
	
	public function getEndpointKey(){
		return $this->endpointKey;
	}

	protected function buildNewCaptureObject($captureId, $amount, $status = NULL){
		return new Customweb_PayPalPlus_Authorization_TransactionCapture($captureId, $amount, $status);
	}
	
	protected function buildNewRefundObject($refundId, $amount, $status = NULL) {
		return new Customweb_PayPalPlus_Authorization_TransactionRefund($refundId, $amount, $status);
	}

	protected function getTransactionSpecificLabels(){
		$authorizationParameters = $this->getAuthorizationParameters();
		$labels = array();
		if (isset($authorizationParameters['protectionEligibility'])) {
			if ($authorizationParameters['protectionEligibility'] == 'INELIGIBLE') {
				$labels['sellerProtection'] = array(
					'label' => Customweb_I18n_Translation::__('Seller Protection'),
					'value' => Customweb_I18n_Translation::__('Ineligible')
				);
			}
			elseif($authorizationParameters['protectionEligibility'] == 'ELIGIBLE') {
				$labels['sellerProtection'] = array(
					'label' => Customweb_I18n_Translation::__('Seller Protection'),
					'value' => Customweb_I18n_Translation::__('Eligible')
				);
			}
			else {
				$value = Customweb_I18n_Translation::__('Partial');
				if(isset($authorizationParameters['protectionEligibilityType'])){
					$partial = explode(',', $authorizationParameters['protectionEligibilityType']);
					if(in_array('ITEM_NOT_RECEIVED_ELIGIBLE', $partial)){
						$value = Customweb_I18n_Translation::__('Item not received eligible.');
					}
					elseif(in_array('UNAUTHORIZED_PAYMENT_ELIGIBLE', $partial)){
						$value = Customweb_I18n_Translation::__('Unauthorized payment eligible.');
					}					
				}
				$labels['sellerProtection'] = array(
					'label' => Customweb_I18n_Translation::__('Seller Protection'),
					'value' => $value
				);
			}
		}
		if(isset($authorizationParameters['payerId'])) {
			$labels['payerId'] = array(
				'label' => Customweb_I18n_Translation::__('PayerId'),
				'value' => $authorizationParameters['payerId']
			);
		}
		if(isset($authorizationParameters['paymentMode'])) {
			$labels['paymentMode'] = array(
				'label' => Customweb_I18n_Translation::__('Payment Mode'),
				'value' => $authorizationParameters['paymentMode']
			);
		}
		if(isset($authorizationParameters['executionId'])) {
			$labels['executionId'] = array(
				'label' => Customweb_I18n_Translation::__('PayPal Execution Id'),
				'value' => $authorizationParameters['executionId']
			);
		}
		if(isset($authorizationParameters['saleId'])) {
			$labels['saleId'] = array(
				'label' => Customweb_I18n_Translation::__('PayPal Sale Id'),
				'value' => $authorizationParameters['saleId']
			);
		}
		if(isset($authorizationParameters['authorizeId'])) {
			$labels['authorizeId'] = array(
				'label' => Customweb_I18n_Translation::__('PayPal Authorize Id'),
				'value' => $authorizationParameters['authorizeId']
			);
		}
		if(isset($authorizationParameters['orderId'])) {
			$labels['orderId'] = array(
				'label' => Customweb_I18n_Translation::__('PayPal OrderId Id'),
				'value' => $authorizationParameters['orderId']
			);
		}
		if(isset($authorizationParameters['cart'])) {
			$labels['cart'] = array(
				'label' => Customweb_I18n_Translation::__('PayPal Cart'),
				'value' => $authorizationParameters['cart']
			);
		}
		$feeValue = 0;
		foreach($this->getCaptures() as $capture){
			$fees = $capture->getTransactionFee();
			if(isset($fees['value'])){
				$feeValue += $fees['value'];
			}
		}
		if(Customweb_Util_Currency::compareAmount($feeValue, 0, $this->getCurrencyCode()) != 0){
			$labels['fee'] = array(
				'label' => Customweb_I18n_Translation::__('Transaction Fee'),
				'value' => Customweb_Util_Currency::formatAmount($feeValue, $this->getCurrencyCode()).' '.$this->getCurrencyCode()
			);
		}
		
		if($this->isAddressCheckDisabled() && !empty($this->returnedAddress)){
			$name = $this->returnedAddress['recipient_name'];
			$street = $this->returnedAddress['line1'];
			if(isset($this->returnedAddress['line2'])){
				$street.' '.$this->returnedAddress['line2'];
			}
			$city = $this->returnedAddress['city'];
			$postalCode = $this->returnedAddress['postal_code'];
			$country = $this->returnedAddress['country_code'];
			$state = null;
			if(isset($this->returnedAddress['state'])){
				$state = $this->returnedAddress['state'];
			}
			$labels['changedName'] = array(
				'label' => Customweb_I18n_Translation::__('Name entered'),
				'value' => $name
				
			);
			$labels['changedStreet'] = array(
				'label' => Customweb_I18n_Translation::__('Street entered'),
				'value' => $street
			
			);
			$labels['changedPostalCode'] = array(
				'label' => Customweb_I18n_Translation::__('Postal Code entered'),
				'value' => $postalCode
			
			);
			$labels['changedCity'] = array(
				'label' => Customweb_I18n_Translation::__('City entered'),
				'value' => $city
			
			);
			$labels['changedCountry'] = array(
				'label' => Customweb_I18n_Translation::__('Country entered'),
				'value' => $country
			
			);
			if(!empty($state)){
				$labels['changedState'] = array(
					'label' => Customweb_I18n_Translation::__('State entered'),
					'value' => $state
						
				);
			}
			
		}
		return $labels;
	}
	
	public function getPaymentInformation(){
		$parameters = $this->getAuthorizationParameters();
		if(isset($parameters['paymentInformation'])){
			return Customweb_PayPalPlus_Authorization_PaymentInformation_Formatter::formatInformation($parameters['paymentInformation'], $parameters['shopName']);		
		}
		return null;
	}

	public function setReturnedAddress($address){
		$this->returnedAddress = $address;
		
	}
	
	public function isAddressCheckDisabled(){
		return $this->isAddressCheckDisabled;
	}
	
	public function setAddressCheckDisabled($disable){
		$this->isAddressCheckDisabled = $disable;
		return $this;
	}
	
	public function increaseRetryCounter(){
		$this->retryCounter++;
	}
	
	public function getRetryCounter(){
		return $this->retryCounter;
	}

}