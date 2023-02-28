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
 *
 * @category Customweb
 * @package Customweb_PayPalPlusCw
 * @version 2.0.224
 */

PayPalPlusCwHelper::bootstrap();

require_once 'Customweb/Form/Element.php';
require_once 'Customweb/Form/Control/Select.php';
require_once 'Customweb/Util/Html.php';


abstract class PayPalPlusCwAdapterAbstractAdapter implements PayPalPlusCwAdapterIAdapter {
	/**
	 *
	 * @var Customweb_Payment_Authorization_IAdapter
	 */
	private $interfaceAdapter;

	/**
	 *
	 * @var PayPalPlusCwOrderContext
	 */
	private $orderContext = null;

	/**
	 *
	 * @var oxorder
	 */
	private $order = null;

	/**
	 *
	 * @var PayPalPlusCwPaymentMethod
	 */
	private $paymentMethod = null;

	/**
	 *
	 * @var PayPalPlusCwTransaction
	 */
	private $transaction = null;

	/**
	 *
	 * @var PayPalPlusCwTransaction
	 */
	private $failedTransaction = null;

	/**
	 *
	 * @var PayPalPlusCwTransaction
	 */
	private $aliasTransaction = null;

	/**
	 *
	 * @var int
	 */
	private $aliasTransactionId = null;

	/**
	 *
	 * @var Customweb_Payment_Authorization_IPaymentCustomerContext
	 */
	private $paymentCustomerContext = null;

	/**
	 *
	 * @return PayPalPlusCwPaymentMethod
	 */
	final protected function getPaymentMethod(){
		return $this->paymentMethod;
	}

	/**
	 *
	 * @return PayPalPlusCwOrderContext
	 */
	final protected function getOrderContext(){
		return $this->orderContext;
	}

	/**
	 *
	 * @return oxorder
	 */
	final protected function getOrder(){
		return $this->order;
	}

	/**
	 *
	 * @return PayPalPlusCwTransaction
	 */
	final public function getTransaction(){
		return $this->transaction;
	}

	/**
	 *
	 * @return PayPalPlusCwTransaction
	 */
	final protected function getAliasTransactionObject(){
		$aliasTransactionObject = null;
		if ($this->getPaymentMethod()->getPaymentMethodConfigurationValue('alias_manager') == 'active') {
			$aliasTransactionObject = 'new';
		}
		if ($this->aliasTransaction !== null) {
			$aliasTransactionObject = $this->aliasTransaction->getTransactionObject();
		}

		return $aliasTransactionObject;
	}

	/**
	 *
	 * @return PayPalPlusCwTransaction
	 */
	final protected function getFailedTransactionObject(){
		$failedTransactionObject = null;
		$orderContext = $this->getOrderContext();
		if ($this->failedTransaction !== null && $this->failedTransaction->getCustomerId() !== null &&
				 $this->failedTransaction->getCustomerId() == $orderContext->getCustomerId()) {
			$failedTransactionObject = $this->failedTransaction->getTransactionObject();
		}
		return $failedTransactionObject;
	}

	final protected function getPaymentCustomerContext(){
		if ($this->paymentCustomerContext === null) {
			if ($this->getTransaction() instanceof PayPalPlusCwTransaction) {
				$userId = $this->getTransaction()->getCustomerId();
			}
			else {
				$userId = $this->getOrderContext()->getCustomerId();
			}
			$this->paymentCustomerContext = PayPalPlusCwHelper::loadCustomerContext($userId);
		}

		return $this->paymentCustomerContext;
	}

	final public function setInterfaceAdapter(Customweb_Payment_Authorization_IAdapter $interface){
		$this->interfaceAdapter = $interface;
	}

	public function getInterfaceAdapter(){
		return $this->interfaceAdapter;
	}

	final public function prepareForm($order, PayPalPlusCwPaymentMethod $payment){
		$this->paymentMethod = $payment;
		$this->order = $order;
		$this->orderContext = $payment->getOrderContext($order, $payment);

		$this->prepareAliasManager();
	}

	final public function prepare($order, PayPalPlusCwPaymentMethod $payment, $failedTransaction = null, $transaction = null){
		$this->prepareForm($order, $payment);

		$this->transaction = $transaction;
		if ($transaction !== null) {
			if (!($transaction instanceof PayPalPlusCwTransaction)) {
				throw new Exception("The transaction must be of instance PayPalPlusCwTransaction.");
			}
			$this->order = $this->getTransaction()->getOrder();
		}
		$this->failedTransaction = $failedTransaction;

		$this->prepareTransaction();
		$this->prepareAdapter();
	}

	final protected function prepareAliasManager(){
		$this->aliasTransaction = null;
		$this->aliasTransactionId = null;

		
	}

	final protected function prepareTransaction(){
		if ($this->transaction !== null) {
			if ($this->aliasTransactionId != null) {
				$this->getTransaction()->getTransactionObject()->getTransactionContext()->setAlias($this->aliasTransactionId);
				PayPalPlusCwHelper::getEntityManager()->persist($this->getTransaction());
			}
			return;
		}

		$failedTransaction = null;
		if ($this->failedTransaction !== null) {
			$failedTransaction = $this->failedTransaction->getTransactionObject();
		}

		// New transaction
		$this->transaction = $this->createTransaction($this->getOrder());
		$transactionContext = new PayPalPlusCwTransactionContext($this->getTransaction(), $this->getOrder(), $this->getPaymentMethod(),
				$this->aliasTransactionId);
		$transactionObject = $this->getInterfaceAdapter()->createTransaction($transactionContext, $failedTransaction);
		$this->getTransaction()->setTransactionObject($transactionObject);

		if (!PayPalPlusCwHelper::isCreateOrderBefore()) {
			$this->getTransaction()->setSessionData(base64_encode(serialize($_SESSION)));
		}

		PayPalPlusCwHelper::getEntityManager()->persist($this->getTransaction());
	}

	private function createTransaction($order){
		$transaction = new PayPalPlusCwTransaction();
		$transaction->setOrderId($order->getId());
		$transaction->setPaymentMachineName($this->getPaymentMethod()->getPaymentMethodName());
		$transaction->setShopId(oxRegistry::getConfig()->getShopId());
		PayPalPlusCwHelper::getEntityManager()->persist($transaction);
		return $transaction;
	}

	protected function prepareAdapter(){
		// Override
	}

	protected function getFormActionUrl(){
		return null;
	}

	public function getVisibleFormFields(){
		return $this->getInterfaceAdapter()->getVisibleFormFields($this->getOrderContext(), $this->getAliasTransactionObject(),
				$this->getFailedTransactionObject(), $this->getPaymentCustomerContext());
	}

	protected function getHiddenFormFields(){
		return null;
	}

	final public function getAliasFormContent(){
		
	}

	public function getConfirmationPageVariables(){
		$templateVars = array();

		$formActionUrl = $this->getFormActionUrl();
		if ($formActionUrl !== null) {
			$templateVars['formActionUrl'] = $formActionUrl;
		}

		$hiddenFormFields = $this->getHiddenFormFields();
		if ($hiddenFormFields !== null && count($hiddenFormFields) > 0) {
			$templateVars['hiddenFormFields'] = Customweb_Util_Html::buildHiddenInputFields($hiddenFormFields);
		}

		$visibleFormFields = $this->getVisibleFormFields();
		if ($visibleFormFields !== null && count($visibleFormFields) > 0) {
			$renderer = new PayPalPlusCwFormRenderer();
			$renderer->setRenderOnLoadJs(false);
			$renderer->setNamespacePrefix($this->getPaymentMethod()->getPaymentMethodId());
			$renderer->setControlCssClassResolver(new PayPalPlusCwControlCssClassResolver());
			$templateVars['visibleFormFields'] = $renderer->renderElements($visibleFormFields);
		}

		$templateVars['aliasFormFields'] = PayPalPlusCwHelper::toDefaultEncoding($this->getAliasFormContent());
		$templateVars['paymentMethodId'] = $this->getPaymentMethod()->getPaymentMethodId();

		$templateVars['mobileActive'] = PayPalPlusCwHelper::isMobileTheme();

		return $templateVars;
	}

	public function processOrderConfirmationRequest(){}
}
