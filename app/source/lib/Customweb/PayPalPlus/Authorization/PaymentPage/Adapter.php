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
require_once 'Customweb/PayPalPlus/Authorization/PaymentPage/ParameterBuilder.php';
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Payment/Authorization/PaymentPage/IAdapter.php';
require_once 'Customweb/PayPalPlus/Util.php';
require_once 'Customweb/Core/Logger/Factory.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Authorization_PaymentPage_Adapter extends Customweb_PayPalPlus_AbstractAdapter implements
		Customweb_Payment_Authorization_PaymentPage_IAdapter {

	/**
	 * @var Customweb_Core_ILogger
	 */
	private $logger;

	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		parent::__construct($container);
		$this->logger = Customweb_Core_Logger_Factory::getLogger(get_class($this));
	}


	public function getAuthorizationMethodName(){
		return self::AUTHORIZATION_METHOD_NAME;
	}

	public function getAdapterPriority(){
		return 100;
	}

	public function createTransaction(Customweb_Payment_Authorization_PaymentPage_ITransactionContext $transactionContext, $failedTransaction){
		$transaction = new Customweb_PayPalPlus_Authorization_Transaction($transactionContext, $this->getContainer());
		$transaction->setAuthorizationMethod(self::AUTHORIZATION_METHOD_NAME);
		$transaction->setLiveTransaction(!$this->getConfiguration()->isTestMode());
		$transaction->setAddressCheckDisabled($this->getConfiguration()->isAddressCheckDisabled());
		return $transaction;
	}


	public function isHeaderRedirectionSupported(Customweb_Payment_Authorization_ITransaction $transaction, array $formData){
		$url = $this->getRedirectionUrl($transaction, $formData);
		if (strlen($url) > 2000) {
			return false;
		}
		else {
			return true;
		}
	}


	public function validate(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext, array $formData) {
		return true;
	}

	public function preValidate(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext) {
		return $this->getContainer()->getPaymentMethod($orderContext->getPaymentMethod(), $this->getAuthorizationMethodName())->prevalidate($orderContext, $paymentContext);
	}

	public function isDeferredCapturingSupported(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext) {
		return $this->getContainer()->getPaymentMethod($orderContext->getPaymentMethod(), $this->getAuthorizationMethodName())->isDeferredCapturingSupported();
	}

	public function getParameters(Customweb_Payment_Authorization_ITransaction $transaction, array $formData){
		return array();
	}

	public function getRedirectionUrl(Customweb_Payment_Authorization_ITransaction $transaction, array $formData){
		return $this->getRedirectUrl($transaction);
	}


	public function getFormActionUrl(Customweb_Payment_Authorization_ITransaction $transaction, array $formData){
		return $this->getRedirectUrl($transaction);
	}

	private function getRedirectUrl(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		$paramters = array();
		$paramters["cw_transaction_id"] = $transaction->getExternalTransactionId();
		$paramters["cwhash"] = Customweb_PayPalPlus_Util::computeSecuritySignature('endpoint/redirect', $transaction->getTransactionContext()->getOrderContext()->getCheckoutId(), $transaction->getEndpointKey());
		return $this->getContainer()->getEndpointAdapter()->getUrl("endpoint", "redirect", $paramters);
	}

	public function isAuthorizationMethodSupported(Customweb_Payment_Authorization_IOrderContext $orderContext){
		return true;
	}

	public function getVisibleFormFields(Customweb_Payment_Authorization_IOrderContext $orderContext, $aliasTransaction, $failedTransaction, $customerPaymentContext){
		return array();
	}

	public function buildApprovalUrl(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		if ($transaction->getApprovalUrl() != null) {
			return $transaction->getApprovalUrl();
		}
		$builder = new Customweb_PayPalPlus_Authorization_PaymentPage_ParameterBuilder($this->getContainer(), $transaction);
		$parameters = $builder->buildApprovalUrlParameters();
		$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment';
		try {
			$response = $this->sendRequestToRESTEndpoint($url, 'POST', json_encode($parameters));
		}
		catch (Exception $e) {
			$this->logger->logException($e);
			$errorMessage = Customweb_I18n_Translation::__('HTTP error during the registration of the transaction.');
			$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($errorMessage, $e->getMessage()));
			$transaction->setApprovalUrl($transaction->getFailedUrl());
			return $transaction->getFailedUrl();
		}
		$responseArray = json_decode(trim($response->getBody()), true);
		if ($responseArray === false) {
			$errorMessage = Customweb_I18n_Translation::__(
					'Received malformatted response from PayPal Plus during registration');
			$transaction->setAuthorizationFailed($errorMessage);
			$transaction->setApprovalUrl($transaction->getFailedUrl());
			return $transaction->getFailedUrl();
		}
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) && strtolower($responseArray['state']) != 'created')) {

			$errorMessage = Customweb_I18n_Translation::__('Transaction failed with an unkown reason.');
			if (isset($responseArray['name'])) {
				$errorMessage = $responseArray['name'];
			}
			if (isset($responseArray['details'])) {
				foreach ($responseArray['details'] as $detail) {
					if (isset($detail['issue'])) {
						$errorMessage = $detail['issue'];
						break;
					}
				}
			}
			$transaction->setAuthorizationFailed($errorMessage);
			$transaction->setApprovalUrl($transaction->getFailedUrl());
			return $transaction->getFailedUrl();
		}

		$authorizationParameters = array(
			'registrationId' => $responseArray['id'],
			'registrationState' => $responseArray['state']
		);
		$transaction->setPaymentId($responseArray['id']);
		$transaction->addAuthorizationParameters($authorizationParameters);

		$approvalUrl = null;
		foreach ($responseArray['links'] as $linkSet) {
			if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'approval_url') {
				$approvalUrl = $linkSet['href'];
				break;
			}
		}
		if ($approvalUrl == null) {
			$errorMessage = Customweb_I18n_Translation::__('Can not redirect customer, approval URL missing in registration response.');
			$transaction->setAuthorizationFailed(new Customweb_Payment_Authorization_ErrorMessage($errorMessage, $e->getMessage()));
			$transaction->setApprovalUrl($transaction->getFailedUrl());
			return $transaction->getFailedUrl();
		}

		$transaction->setApprovalUrl($approvalUrl);

		return $approvalUrl;
	}


}