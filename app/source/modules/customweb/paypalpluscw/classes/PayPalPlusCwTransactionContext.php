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
 *
 * @category	Customweb
 * @package		Customweb_PayPalPlusCw
 * @version		2.0.224
 */

PayPalPlusCwHelper::bootstrap();

require_once 'Customweb/Payment/Authorization/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/Hidden/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/Server/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/Ajax/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/PaymentPage/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/Iframe/ITransactionContext.php';
require_once 'Customweb/Payment/Authorization/Widget/ITransactionContext.php';


class PayPalPlusCwTransactionContext implements Customweb_Payment_Authorization_ITransactionContext,
	Customweb_Payment_Authorization_PaymentPage_ITransactionContext,
	Customweb_Payment_Authorization_Hidden_ITransactionContext,
	Customweb_Payment_Authorization_Iframe_ITransactionContext,
	Customweb_Payment_Authorization_Server_ITransactionContext,
	Customweb_Payment_Authorization_Ajax_ITransactionContext,
	Customweb_Payment_Authorization_Widget_ITransactionContext
{
	/**
	 * @transient
	 * @var PayPalPlusCwTransaction
	 */
	private $transaction = null;

	/**
	 * @transient
	 * @var PayPalPlusCwTransaction
	 */
	private $alias = null;

	/**
	 * @var integer
	 */
	protected $transactionId;

	/**
	 * @var string
	 */
	protected $orderId = null;

	/**
	 *
	 * @var string
	 */
	protected $shopId = null;

	/**
	 * @var PayPalPlusCwOrderContext
	 */
	protected $orderContext;

	/**
	 * @var PayPalPlusCwPaymentCustomerContext
	 */
	protected $customerContext;

	/**
	 * @var string|integer
	 */
	protected $aliasTransactionId = null;

	/**
	 * @var string
	 */
	protected $capturingMode;

	/**
	 * Create a transaction context.
	 *
	 * @param PayPalPlusCwTransactionContext $transaction
	 * @param oxOrder $order
	 * @param oxPayment $paymentMethod
	 * @param string|integer $aliasTransactionId
	 */
	public function __construct(PayPalPlusCwTransaction $transaction, oxOrder $order, PayPalPlusCwPaymentMethod $paymentMethod, $aliasTransactionId = NULL)
	{
		$this->transaction = $transaction;
		$this->transactionId = $transaction->getTransactionId();
		if ($order->oxorder__oxordernr && $order->oxorder__oxordernr->value) {
			$this->orderId = $order->oxorder__oxordernr->value;
		}
		if ($order->oxorder__oxshopid && $order->oxorder__oxshopid->value) {
			$this->shopId = $order->oxorder__oxshopid->value;
		}
		$this->orderContext = new PayPalPlusCwOrderContext($order);
		$this->customerContext = PayPalPlusCwHelper::loadCustomerContext($this->orderContext->getCustomerId());
		$this->capturingMode = $paymentMethod->getPaymentMethodConfigurationValue('capturing');

		if ($paymentMethod->getPaymentMethodConfigurationValue('alias_manager') == 'active') {
			if ($aliasTransactionId === NULL || $aliasTransactionId === 'new') {
				$this->aliasTransactionId = 'new';
			} else {
				$this->aliasTransactionId = intval($aliasTransactionId);
			}
		}

		unset($_SESSION['paypalpluscw_checkout_id']);
	}

	public function __sleep() {
		return array('transactionId', 'orderId', 'shopId', 'capturingMode', 'aliasTransactionId', 'customerContext', 'orderContext');
	}

	public function getOrderContext()
	{
		return $this->orderContext;
	}

	public function getTransactionId()
	{
		return $this->transactionId;
	}

	public function getOrderId()
	{
		return $this->orderId;
	}

	public function isOrderIdUnique()
	{
		if (oxRegistry::getConfig()->getShopConfVar('paypalpluscw_order_id', null, 'module:paypalpluscw') == 'enforce') {
			return true;
		}
		foreach (oxRegistry::getConfig()->getShopIds() as $shopId) {
			if (oxRegistry::getConfig()->getShopConfVar('blSeparateNumbering', $shopId)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * @return PayPalPlusCwTransaction
	 */
	public function getTransaction()
	{
		if ($this->transaction === NULL) {
			$this->transaction = PayPalPlusCwHelper::loadTransaction($this->getInternalTransactionId());
		}
		return $this->transaction;
	}

	/**
	 * @return number
	 */
	public function getInternalTransactionId()
	{
		return $this->transactionId;
	}

	public function getCapturingMode()
	{
		return null;
	}

	public function getAlias()
	{
		if ($this->getOrderContext()->getPaymentMethod()->getPaymentMethodConfigurationValue('alias_manager') !== 'active') {
			return null;
		}

		if ($this->aliasTransactionId === 'new') {
			return 'new';
		}

		if ($this->aliasTransactionId !== null) {
			if ($this->alias == null) {
				$alias = PayPalPlusCwHelper::loadTransaction($this->aliasTransactionId);
				$this->alias = $alias->getTransactionObject();
			}
			return $this->alias;
		}

		return null;
	}

	public function setAlias($aliasTransactionId)
	{
		$this->aliasTransactionId = $aliasTransactionId;
		$this->alias = null;
		return $this;
	}

	public function createRecurringAlias()
	{
		return $this->getOrderContext()->isRecurring();
	}

	public function getCustomParameters()
	{
		return array(
			'cstrxid' => $this->getInternalTransactionId(),
			//oxRegistry::getSession()->getName() => oxRegistry::getSession()->getId(),
			//'rtoken' => oxRegistry::getSession()->getRemoteAccessToken()
		);
	}

	public function getPaymentCustomerContext()
	{
		return $this->customerContext;
	}

	protected function getProcessUrl()
	{
		return PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_process'
		));
	}

	public function getNotificationUrl()
	{
		return $this->getProcessUrl();
	}

	public function getSuccessUrl()
	{
		return PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_process',
			'fnc' => 'success'
		));
	}

	public function getFailedUrl()
	{
		return PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_process',
			'fnc' => 'fail'
		));
	}

	public function getIframeBreakOutUrl()
	{
		return PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_breakout'
		));
	}

	public function getJavaScriptSuccessCallbackFunction()
	{
		return "function(url){window.location = url;}";
	}

	public function getJavaScriptFailedCallbackFunction()
	{
		return "function(url){window.location = url;}";
	}
}