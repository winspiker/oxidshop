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
require_once 'Customweb/PayPalPlus/Authorization/ParameterBuilder.php';
require_once 'Customweb/PayPalPlus/Util.php';
require_once 'Customweb/Payment/Util.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_PaymentPage_ParameterBuilder extends Customweb_PayPalPlus_Authorization_ParameterBuilder {
	private $transaction;

	public function __construct(Customweb_DependencyInjection_IContainer $container, Customweb_PayPalPlus_Authorization_Transaction $transaction){
		parent::__construct($container, $transaction->getTransactionContext()->getOrderContext());
		$this->transaction = $transaction;
	}

	/**
	 *
	 * @return Customweb_PayPalPlus_Authorization_Transaction
	 */
	protected function getTransaction(){
		return $this->transaction;
	}

	public function buildApprovalUrlParameters(){
		$parameters = array(
			'intent' => $this->getIntentParameter(),
			'redirect_urls' => $this->getRedirectUrls(),
			'payer' => $this->getPayerDetails(),
			'transactions' => $this->getTransactionDetails(),
			'experience_profile_id' => $this->getExperienceProfileId() 
		);
		
		return $parameters;
	}

	protected function getRedirectUrls(){
		return array(
			'return_url' => $this->getReturnUrl(),
			'cancel_url' => $this->getCancelUrl() 
		);
	}

	protected function getIntentParameter(){
		$paymentAction = 'sale';
		if ($this->getOrderContext()->getPaymentMethod()->existsPaymentMethodConfigurationValue('capturing')) {
			$capturingMode = $this->getOrderContext()->getPaymentMethod()->getPaymentMethodConfigurationValue('capturing');
			if ($capturingMode == 'order') {
				$paymentAction = "order";
			}
			else if ($capturingMode == 'authorize') {
				$paymentAction = "authorize";
			}
			else {
				$paymentAction = "sale";
			}
		}
		
		$this->getTransaction()->setAuthorizationType($paymentAction);
		return $paymentAction;
	}

	protected function getReturnUrl(){
		return $this->getContainer()->getBean('Customweb_Payment_Endpoint_IAdapter')->getUrl('endpoint', 'process', 
				array(
					'cw_transaction_id' => $this->getTransaction()->getExternalTransactionId(),
					'cwhash' => Customweb_PayPalPlus_Util::computeSecuritySignature('endpoint/process', 
							$this->getTransaction()->getTransactionContext()->getOrderContext()->getCheckoutId(), 
							$this->getTransaction()->getEndpointKey()) 
				));
	}

	protected function getCancelUrl(){
		return $this->getContainer()->getBean('Customweb_Payment_Endpoint_IAdapter')->getUrl('endpoint', 'cancel', 
				array(
					'cw_transaction_id' => $this->getTransaction()->getExternalTransactionId(),
					'cwhash' => Customweb_PayPalPlus_Util::computeSecuritySignature('endpoint/cancel', 
							$this->getTransaction()->getTransactionContext()->getOrderContext()->getCheckoutId(), 
							$this->getTransaction()->getEndpointKey()) 
				));
	}

	protected function getOrderDescription(){
		return Customweb_Payment_Util::applyOrderSchemaImproved(
				$this->getConfiguration()->getOrderDescriptionSchema($this->getOrderContext()->getLanguage()), 
				$this->getTransaction()->getExternalTransactionId(), 127);
	}
}