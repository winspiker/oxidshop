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

require_once 'Customweb/Payment/AbstractContainer.php';

/**
 * 
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Container extends Customweb_Payment_AbstractContainer {
	
	/**
	 * @return Customweb_PayPalPlus_Configuration
	 */
	public function getConfiguration(){
		return $this->getBean('Customweb_PayPalPlus_Configuration');
	}

	/**
	 *
	 * @return Customweb_PayPalPlus_Method_Factory
	 */
	public function getMethodFactory(){
		return $this->getBean('Customweb_PayPalPlus_Method_Factory');
	}
	
	/**
	 * @param Customweb_Payment_Authorization_IPaymentMethod $paymentMethod
	 * @param string $authorizationName The name of the authorization method.
	 * @return Customweb_PayPalPlus_Method_PayPal
	 */
	public function getPaymentMethod(Customweb_Payment_Authorization_IPaymentMethod $paymentMethod, $authorizationName){
		return $this->getMethodFactory()->getPaymentMethod($paymentMethod, $authorizationName);
	}

	/**
	 * @param Customweb_PayPalPlus_Authorization_Transaction $transaction
	 * @return Customweb_PayPalPlus_Method_PayPal
	 */
	public function getPaymentMethodByTransaction(Customweb_PayPalPlus_Authorization_Transaction $transaction){
		return $this->getPaymentMethod($transaction->getTransactionContext()->getOrderContext()->getPaymentMethod(), 
				$transaction->getAuthorizationMethod());
	}
	
	/**
	 * @return Customweb_Storage_IBackend
	 */
	public function getStorage(){
		return $this->getBean("Customweb_Storage_IBackend");
	}

}