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
require_once 'Customweb/Form/HiddenElement.php';
require_once 'Customweb/Form/Control/Html.php';
require_once 'Customweb/Payment/Exception/PaymentErrorException.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Core/Util/Rand.php';
require_once 'Customweb/PayPalPlus/Authorization/Transaction.php';
require_once 'Customweb/PayPalPlus/MethodSelectedValidator.php';
require_once 'Customweb/Core/Exception/CastException.php';
require_once 'Customweb/Form/Control/HiddenInput.php';
require_once 'Customweb/PayPalPlus/Authorization/Ajax/ParameterBuilder.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Payment/Authorization/Ajax/IAdapter.php';
require_once 'Customweb/Form/WideElement.php';
require_once 'Customweb/Core/Logger/Factory.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Authorization_Ajax_Adapter extends Customweb_PayPalPlus_AbstractAdapter implements
		Customweb_Payment_Authorization_Ajax_IAdapter {


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

	public function createTransaction(Customweb_Payment_Authorization_Ajax_ITransactionContext $transactionContext, $failedTransaction){
		$transaction = new Customweb_PayPalPlus_Authorization_Transaction($transactionContext, $this->getContainer());
		$transaction->setAuthorizationMethod(self::AUTHORIZATION_METHOD_NAME);
		$transaction->setLiveTransaction(!$this->getConfiguration()->isTestMode());
		$transaction->setAddressCheckDisabled($this->getConfiguration()->isAddressCheckDisabled());
		return $transaction;
	}

	public function validate(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext, array $formData){
		return true;
	}

	public function preValidate(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext){
		return $this->getContainer()->getPaymentMethod($orderContext->getPaymentMethod(), $this->getAuthorizationMethodName())->prevalidate(
				$orderContext, $paymentContext);
	}

	public function isDeferredCapturingSupported(Customweb_Payment_Authorization_IOrderContext $orderContext, Customweb_Payment_Authorization_IPaymentCustomerContext $paymentContext){
		return $this->getContainer()->getPaymentMethod($orderContext->getPaymentMethod(), $this->getAuthorizationMethodName())->isDeferredCapturingSupported();
	}

	public function isAuthorizationMethodSupported(Customweb_Payment_Authorization_IOrderContext $orderContext){
		return true;
	}

	public function getVisibleFormFields(Customweb_Payment_Authorization_IOrderContext $orderContext, $aliasTransaction, $failedTransaction, $customerPaymentContext){
		try {
			$approvalUrl = $this->getApprovalUrl($orderContext);

			$language = $orderContext->getLanguage()->getIetfCode();
			$country = strtoupper($orderContext->getBillingAddress()->getCountryIsoCode());
			$testValues = '';
			$mode = 'live';
			if ($this->getConfiguration()->isTestMode()) {
				$testValues = '"showPuiOnSandbox": true,';
				$mode = 'sandbox';
			}

			$content = "<div id='paypalplus-container' style='width:100%;'><div id='ppplus' style='width:inherit;max-width:100%'></div></div>";
			$script = '
						if(typeof paypalplusPPPLoaded == "undefined" || !paypalplusPPPLoaded) {
							var scriptTag = document.createElement("script");
							scriptTag.setAttribute("type", "text/javascript");
							scriptTag.setAttribute("src", "https://www.paypalobjects.com/webstatic/ppplus/ppplus.min.js");
							document.getElementsByTagName("head")[0].appendChild(scriptTag);
							paypalplusPPPLoaded = true;
						}

				paypalplusPPPContinue = true;
				paypalplusWidthFixed = false;

				var paypalplusFixIframeWidth = function(){
					var elements = document.getElementById("ppplus").getElementsByTagName("iframe");
					if(typeof elements[0] != "undefined") {
						elements[0].style.width="100%";
						paypalplusWidthFixed = true;
					}
					if(!paypalplusWidthFixed){
						setTimeout(paypalplusFixIframeWidth, 100);
					}
				};

				var paypalplusInitPPP = function(){

					if(document.getElementById("ppplus") && typeof PAYPAL != "undefined" && typeof PAYPAL.apps != "undefined" && typeof PAYPAL.apps.PPP == "function") {

							paypalplusPPP = PAYPAL.apps.PPP({
								"approvalUrl": "' . $approvalUrl . '",
								"placeholder": "ppplus",
								"mode": "' . $mode . '",
								"preselection" : "paypal",
								"country": "' . $country . '",
								"language" : "' . $language . '",
								"buttonLocation": "outside",
								"disableContinue" : function() {
									paypalplusPPPContinue = false;
								},
								"enableContinue" : function() {
									paypalplusPPPContinue = true;
								},
								"showLoadingIndicator" : true,
								"useraction" : "commit",
								' . $testValues . '
							});
							paypalplusFixIframeWidth();
					}
					else {
						setTimeout(paypalplusInitPPP, 500);
					}
				}
				paypalplusInitPPP();
			';
			$controlPP = new Customweb_Form_Control_Html('ppPlus', $content);
			$elementPP = new Customweb_Form_WideElement($controlPP);
			$elementPP->appendJavaScript($script);
			$elementPP->setRequired(false);

			$controlVal = new Customweb_Form_Control_HiddenInput('ppPlusValidator', 'false');
			$validator = new Customweb_PayPalPlus_MethodSelectedValidator($controlVal,
					Customweb_I18n_Translation::__('Please specify the payment method.'));
			$controlVal->addValidator($validator);
			$elementVal = new Customweb_Form_HiddenElement($controlVal);

			return array(
				$elementPP,
				$elementVal
			);
		}
		catch (Exception $e) {
			$controlPP = new Customweb_Form_Control_Html('ppPlus', $e->getMessage());
			$controlPP->setCssClass('error danger');
			$elementPP = new Customweb_Form_WideElement($controlPP);
			$elementPP->setRequired(false);
			return array(
				$elementPP
			);
		}
	}

	public function getAjaxFileUrl(Customweb_Payment_Authorization_ITransaction $transaction){
		$assetResolver = $this->getContainer()->getBean('Customweb_Asset_IResolver');
		return (string) $assetResolver->resolveAssetUrl('dummy.js');
	}

	public function getJavaScriptCallbackFunction(Customweb_Payment_Authorization_ITransaction $transaction){
		if (!($transaction instanceof Customweb_PayPalPlus_Authorization_Transaction)) {
			throw new Customweb_Core_Exception_CastException('Customweb_PayPalPlus_Authorization_Transaction');
		}

		$transaction->setAuthorizationType('sale');
		$transaction->setPaymentId($transaction->getTransactionContext()->getOrderContext()->getCheckoutId());
		$storage = $this->getContainer()->getStorage();
		$patcher = $this->getContainer()->getBean('Customweb_PayPalPlus_Authorization_PatchPaymentDetails_Adapter');
		try {
			$registrationParameters = $storage->read('PayPalPlusURL',
					$transaction->getTransactionContext()->getOrderContext()->getCheckoutId());
			if (empty($registrationParameters) || isset($registrationParameters['errorMessage']) || !isset($registrationParameters['data']) ||
					 !isset($registrationParameters['endpointKey'])) {
				$backendErrorMessage = Customweb_I18n_Translation::__('There was an error during the initial registration of the payment wall.');
				$userErrorMessage = Customweb_I18n_Translation::__('Technical error please contact the merchant.');
				if (isset($registrationParameters['errorMessage'])) {
					$backendErrorMessage = $registrationParameters['errorMessage'];
				}
				$storage->remove('PayPalPlusURL', $transaction->getTransactionContext()->getOrderContext()->getCheckoutId());
				throw new Customweb_Payment_Exception_PaymentErrorException(
						new Customweb_Payment_Authorization_ErrorMessage($userErrorMessage, $backendErrorMessage));
			}
			$transaction->addAuthorizationParameters($registrationParameters['data']);
			$transaction->setEndpointKey($registrationParameters['endpointKey']);
			$patcher->updatePaymentDetails($transaction);
		}
		catch (Customweb_Payment_Exception_PaymentErrorException $pe) {
			$transaction->setAuthorizationFailed($pe->getErrorMessage());
			$url = $transaction->getFailedUrl();
			return 'function (formFieldValues) {
					var url = "' . $url . '";
					window.location.replace(url);
			}';
		}
		catch (Exception $e) {
			$transaction->setAuthorizationFailed($e->getMessage());
			$url = $transaction->getFailedUrl();
			return 'function (formFieldValues) {
					var url = "' . $url . '";
					window.location.replace(url);
			}';
		}

		return 'function (formFieldValues) {
				paypalplusPPP.doCheckout();
			}';
	}

	private function getApprovalUrl(Customweb_Payment_Authorization_IOrderContext $orderContext){
		$storage = $this->getContainer()->getStorage();
		$registrationParameters = $storage->read('PayPalPlusURL', $orderContext->getCheckoutId());
		if (!empty($registrationParameters) && isset($registrationParameters['approvalUrl']) && isset($registrationParameters['itemHash']) &&
				 $registrationParameters['itemHash'] == hash('sha256', serialize($orderContext->getInvoiceItems()))) {
			return $registrationParameters['approvalUrl'];
		}
		$endpointKey = Customweb_Core_Util_Rand::getRandomString(64);
		if(isset($registrationParameters['endpointKey'])){
			$endpointKey = $registrationParameters['endpointKey'];
		}

		$builder = new Customweb_PayPalPlus_Authorization_Ajax_ParameterBuilder($this->getContainer(), $orderContext, $endpointKey);
		$parameters = $builder->buildApprovalUrlParameters();
		$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/payment';
		try {
			$response = $this->sendRequestToRESTEndpoint($url, 'POST', json_encode($parameters));
		}
		catch (Exception $e) {
			$this->logger->logException($e);
			$errorMessage = Customweb_I18n_Translation::__('HTTP error during the registration of the payment wall.');
			$storage->write('PayPalPlusURL', $orderContext->getCheckoutId(), array(
				'errorMessage' => $errorMessage
			));
			throw new Exception($errorMessage);
		}

		$responseArray = json_decode(trim($response->getBody()), true);

		if ($responseArray === false) {
			$this->logger->logError("Received malformatted response during registration.", $response->getBody());
			$errorMessage = Customweb_I18n_Translation::__(
					'Received malformatted response from PayPal Plus during registration');
			$storage->write('PayPalPlusURL', $orderContext->getCheckoutId(), array(
				'errorMessage' => $errorMessage
			));
			throw new Exception($errorMessage);
		}
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) && strtolower($responseArray['state']) != 'created')) {
			$this->logger->logError("Payment wall creation failed with an unkown reason.", $responseArray);
			$errorMessage = Customweb_I18n_Translation::__('Payment wall creation failed with an unkown reason.');
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
			$storage->write('PayPalPlusURL', $orderContext->getCheckoutId(), array(
				'errorMessage' => $errorMessage
			));
			throw new Exception($errorMessage);
		}

		$authorizationParameters = array(
			'registrationId' => $responseArray['id'],
			'registrationState' => $responseArray['state']
		);
		$approvalUrl = null;
		foreach ($responseArray['links'] as $linkSet) {
			if (isset($linkSet['rel']) && strtolower($linkSet['rel']) == 'approval_url') {
				$approvalUrl = $linkSet['href'];
				break;
			}
		}
		if ($approvalUrl == null) {
			$this->logger->logError("Approval URL missing in registration response.", $responseArray);
			$errorMessage = Customweb_I18n_Translation::__('Approval URL missing in registration response.');
			$storage->write('PayPalPlusURL', $orderContext->getCheckoutId(), array(
				'errorMessage' => $errorMessage
			));
			throw new Exception($errorMessage);
		}

		$storage->write('PayPalPlusURL', $orderContext->getCheckoutId(),
				array(
					'approvalUrl' => $approvalUrl,
					'data' => $authorizationParameters,
					'endpointKey' => $endpointKey,
					'itemHash' => hash('sha256', serialize($orderContext->getInvoiceItems()))
				));
		return $approvalUrl;
	}
}