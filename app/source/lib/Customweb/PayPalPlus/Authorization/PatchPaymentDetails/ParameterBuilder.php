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
require_once 'Customweb/Payment/Util.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_PatchPaymentDetails_ParameterBuilder extends Customweb_PayPalPlus_Authorization_ParameterBuilder {
	
	private $transaction;
	
	public function __construct(Customweb_DependencyInjection_IContainer $container, Customweb_PayPalPlus_Authorization_Transaction $transaction){
		parent::__construct($container, $transaction->getTransactionContext()->getOrderContext());
		$this->transaction = $transaction;
	}
	
	
	public function buildPatchParameter(){
		$orderDetails = $this->getOrderDetails();
		$amount = $orderDetails['amount'];
		$shipping = $orderDetails['item_list']['shipping_address'];
		$parameters = array(
			array(
				'op' => 'replace',
				'path' => '/transactions/0/amount',
				'value' => $amount
				
			),
			array(
				'op' => 'add',
				'path' => '/potential_payer_info/billing_address',
				'value' => $this->getBillingAddress()
			),
			array(
				'op' => 'add',
				'path' => '/transactions/0/item_list/shipping_address',
				'value' => $shipping,
			),
			array(
				'op' => 'replace',
				'path' => '/transactions/0/invoice_number',
				'value' => Customweb_Payment_Util::applyOrderSchemaImproved(
						$this->getConfiguration()->getOrderDescriptionSchema($this->getOrderContext()->getLanguage()),
						$this->getTransaction()->getExternalTransactionId(), 127)
			)
		);			
		return $parameters;
	}
	
	protected function getTransaction(){
		return $this->transaction;
	}
	
	
}