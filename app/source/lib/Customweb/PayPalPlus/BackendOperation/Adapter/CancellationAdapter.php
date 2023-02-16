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

require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Payment/BackendOperation/Adapter/Service/ICancel.php';



/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_BackendOperation_Adapter_CancellationAdapter extends Customweb_PayPalPlus_AbstractAdapter implements 
		Customweb_Payment_BackendOperation_Adapter_Service_ICancel {

	public function cancel(Customweb_Payment_Authorization_ITransaction $transaction){
		$authorizationParameters = $transaction->getAuthorizationParameters();
		$url = null;
		if (isset($authorizationParameters['cancelUrl'])) {
			$url = $authorizationParameters['cancelUrl'];
		}
		else {
			if ($transaction->getAuthorizationType() == 'authorization') {
				if (isset($authorizationParameters['authorizationId'])) {
					$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/authorization/' . $authorizationParameters['authorizationId'] .
							 '/void';
				}
			}
			if ($transaction->getAuthorizationType() == 'order') {
				if(isset($authorizationParameters['orderId'])){
					$url = $this->getConfiguration()->getRestApiUrl() . '/v1/payments/orders/' . $authorizationParameters['orderId'] .
					'/do-void';
				}
			}
		}
		if (empty($url)) {
			throw new Exception(Customweb_I18n_Translation::__('Could not create URI to cancel the transaction'));
		}
		$responseArray = $this->sendRequestToRESTEndpointCheckResponse($url, 'POST');
			
		if (!isset($responseArray['id']) || (!isset($responseArray['state']) && strtolower($responseArray['state']) != 'voided')) {
			$errorMessage = Customweb_I18n_Translation::__('Cancel failed with unkown error.');
			if (isset($responseArray['name'])) {
				$errorMessage = $responseArray['name'];
			}
			if (isset($responseArray['message'])) {
				$errorMessage = $responseArray['message'];
			}
			throw new Exception($errorMessage);
		}
		$transaction->cancel();
	}
}