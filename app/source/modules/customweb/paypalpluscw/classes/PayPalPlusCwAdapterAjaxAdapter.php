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



/**
 * @Bean
 */
class PayPalPlusCwAdapterAjaxAdapter extends PayPalPlusCwAdapterAbstractAdapter
{
	private $ajaxScriptUrl = null;
	private $javaScriptCallbackFunction = null;

	public function getPaymentAdapterInterfaceName() {
		return 'Customweb_Payment_Authorization_Ajax_IAdapter';
	}

	/**
	 * @return Customweb_Payment_Authorization_Ajax_IAdapter
	 */
	public function getInterfaceAdapter() {
		return parent::getInterfaceAdapter();
	}

	protected function prepareAdapter() {
		$this->ajaxScriptUrl = $this->getInterfaceAdapter()->getAjaxFileUrl($this->getTransaction()->getTransactionObject());
		$this->javaScriptCallbackFunction = $this->getInterfaceAdapter()->getJavaScriptCallbackFunction($this->getTransaction()->getTransactionObject());
		PayPalPlusCwHelper::getEntityManager()->persist($this->getTransaction());
	}

	public function processOrderConfirmationRequest() {
		$vars = array(
			'ajaxScriptUrl' => $this->ajaxScriptUrl,
			'ajaxSubmitCallback' => $this->javaScriptCallbackFunction,
		);
		return $vars;
	}
}