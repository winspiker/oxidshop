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

require_once 'Customweb/Payment/Endpoint/Controller/Abstract.php';
require_once 'Customweb/Payment/Authorization/ErrorMessage.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Payment/Endpoint/Annotation/ExtractionMethod.php';
require_once 'Customweb/PayPalPlus/Util.php';
require_once 'Customweb/Core/Logger/Factory.php';
require_once 'Customweb/Core/Http/Response.php';



/**
 *
 * @author Nico Eigenmann
 * @Controller("endpoint")
 */
class Customweb_PayPalPlus_Endpoint_Process extends Customweb_Payment_Endpoint_Controller_Abstract {

	
	/**
	 * @var Customweb_Core_ILogger
	 */
	private $logger;
	
	/**
	 * @param Customweb_DependencyInjection_IContainer $container
	 */
	public function __construct(Customweb_DependencyInjection_IContainer $container) {
		parent::__construct($container);
		$this->logger = Customweb_Core_Logger_Factory::getLogger(get_class($this));
	}
	
	/**
	 * @Action("redirect")
	 *
	 * @param Customweb_PayPalPlus_Authorization_Transaction $transaction
	 * @param Customweb_Core_Http_IRequest $request
	 * @return Customweb_Core_Http_Response
	 */
	public function redirect(Customweb_PayPalPlus_Authorization_Transaction $transaction, Customweb_Core_Http_IRequest $request){
		$parameters = $request->getParameters();
		if (!isset($parameters['cwhash'])) {
			throw new Exception("Request could not be verified.");
		}
		Customweb_PayPalPlus_Util::checkSecuritySignature('endpoint/redirect', 
				$transaction->getTransactionContext()->getOrderContext()->getCheckoutId(), $transaction->getEndpointKey(), $parameters['cwhash']);
		
		$ppAdapter = $this->getContainer()->getBean('Customweb_PayPalPlus_Authorization_PaymentPage_Adapter');
		$approvalUrl = $ppAdapter->buildApprovalUrl($transaction);
		return Customweb_Core_Http_Response::redirect($approvalUrl);
	}

	/**
	 * @Action("process")
	 */
	public function process(Customweb_Core_Http_IRequest $request){
		//load for validation purpose
		try{
			$transaction = $this->loadTransaction($request);
		}
		catch(Exception $e){
			return Customweb_Core_Http_Response::_($e->getMessage())->setStatusCode(500);
		}
		
		$this->logger->logInfo("The return process has been started for the transaction " . $transaction->getTransactionId() . ".");
		$parameters = $request->getParameters();
		if (!isset($parameters['cwhash'])) {
			return Customweb_Core_Http_Response::_("Request could not be verified.")->setStatusCode(500);
		}
		Customweb_PayPalPlus_Util::checkSecuritySignature('endpoint/process',
				$transaction->getTransactionContext()->getOrderContext()->getCheckoutId(), $transaction->getEndpointKey(), $parameters['cwhash']);
		
		$lastException = null;
		for ($i = 0; $i < 5; $i++) {
			try {
				$this->getTransactionHandler()->beginTransaction();
				$transaction = $this->loadTransaction($request);
				if ($transaction->isAuthorizationFailed()) {
					$this->getTransactionHandler()->commitTransaction();
					return Customweb_Core_Http_Response::redirect($transaction->getFailedUrl());
				}
				elseif ($transaction->isAuthorized()) {
					$this->getTransactionHandler()->commitTransaction();
					return Customweb_Core_Http_Response::redirect($transaction->getSuccessUrl());
				}
				$transactionHandler = $this->getContainer()->getBean('Customweb_PayPalPlus_Authorization_Handler');
				$transactionHandler->processAuthorization($transaction, $request->getParameters());
				$this->logger->logInfo("The return process has been finished for the transaction " . $transaction->getTransactionId() . ".");
				$this->getTransactionHandler()->persistTransactionObject($transaction);
				$this->getTransactionHandler()->commitTransaction();
				if ($transaction->isAuthorizationFailed()) {
					return Customweb_Core_Http_Response::redirect($transaction->getFailedUrl());
				}
				else {
					return Customweb_Core_Http_Response::redirect($transaction->getSuccessUrl());
				}	
			}
			catch (Customweb_Payment_Exception_OptimisticLockingException $lockingException) {
				$lastException = $lockingException;
				$this->getTransactionHandler()->rollbackTransaction();
				sleep(2);
			}
			catch(Exception $e){
				$this->getTransactionHandler()->rollbackTransaction();
				throw $e;
			}
		}
		if ($lastException != null) {
			throw $lastException;
		}
		throw new Exception("This should never been reached");
	}

	/**
	 * @Action("cancel")
	 */
	public function cancel(Customweb_PayPalPlus_Authorization_Transaction $transaction, Customweb_Core_Http_IRequest $request){
		$parameters = $request->getParameters();
		if (!isset($parameters['cwhash'])) {
			throw new Exception("Request could not be verified.");
		}
		Customweb_PayPalPlus_Util::checkSecuritySignature('endpoint/cancel', 
				$transaction->getTransactionContext()->getOrderContext()->getCheckoutId(), $transaction->getEndpointKey(), $parameters['cwhash']);
		
		$transaction->setAuthorizationFailed(
				new Customweb_Payment_Authorization_ErrorMessage(Customweb_I18n_Translation::__('Transaction failed'), 
						Customweb_I18n_Translation::__('Transaction failed or cancelled by the customer')));
		
		return Customweb_Core_Http_Response::redirect($transaction->getFailedUrl());	
	}
	
	/**
	 *
	 * @param Customweb_Core_Http_IRequest $request
	 * @return Customweb_PayPalPlus_Authorization_Transaction
	 * @throws Exception
	 */
	public function loadTransaction(Customweb_Core_Http_IRequest $request){
		$idMap = $this->getTransactionId($request);
		if ($idMap['key'] == Customweb_Payment_Endpoint_Annotation_ExtractionMethod::EXTERNAL_TRANSACTION_ID_KEY) {
			$transaction = $this->getTransactionHandler()->findTransactionByTransactionExternalId($idMap['id'], false);
		}
		else if ($idMap['key'] == Customweb_Payment_Endpoint_Annotation_ExtractionMethod::PAYMENT_ID_KEY) {
			$transaction = $this->getTransactionHandler()->findTransactionByPaymentId($idMap['id'], false);
		}
		if ($transaction === null) {
			throw new Exception('No transaction found');
		}
		return $transaction;
	}

	/**
	 *
	 * @param Customweb_Core_Http_IRequest $request @ExtractionMethod
	 */
	public function getTransactionId(Customweb_Core_Http_IRequest $request){
		$parameters = $request->getParameters();
		if (isset($parameters['cw_transaction_id'])) {
			return array(
				'id' => $parameters['cw_transaction_id'],
				'key' => Customweb_Payment_Endpoint_Annotation_ExtractionMethod::EXTERNAL_TRANSACTION_ID_KEY 
			);
		}
		if (isset($parameters['cwoccid'])) {
			return array(
				'id' => $parameters['cwoccid'],
				'key' => Customweb_Payment_Endpoint_Annotation_ExtractionMethod::PAYMENT_ID_KEY 
			);
		}
		
		throw new Exception("No transaction id present in the request.");
	}
}