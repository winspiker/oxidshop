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
class Customweb_PayPalPlus_Authorization_Ajax_ParameterBuilder extends Customweb_PayPalPlus_Authorization_ParameterBuilder {
	private $endpointKey;

	public function __construct(Customweb_DependencyInjection_IContainer $container, Customweb_Payment_Authorization_IOrderContext $orderContext, $endpointKey){
		parent::__construct($container, $orderContext);
		$this->endpointKey = $endpointKey;
	}

	protected function getEndpointKey(){
		return $this->endpointKey;
	}

	public function buildApprovalUrlParameters(){
		$parameters = array(
			'intent' => 'sale',
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

	protected function getPayerDetails(){
		return array(
			'payment_method' => 'paypal' 
		);
	}

	protected function getOrderDetails(){
		$result = parent::getOrderDetails();
		unset($result['item_list']['shipping_address']);
		return $result;
	}

	protected function getReturnUrl(){
		return $this->getContainer()->getEndpointAdapter()->getUrl('endpoint', 'process', 
				array(
					'cwoccid' => $this->getOrderContext()->getCheckoutId(),
					'cwhash' => Customweb_PayPalPlus_Util::computeSecuritySignature('endpoint/process', 
							$this->getOrderContext()->getCheckoutId(), $this->getEndpointKey()) 
				));
	}

	protected function getCancelUrl(){
		return $this->getContainer()->getEndpointAdapter()->getUrl('endpoint', 'cancel', 
				array(
					'cwoccid' => $this->getOrderContext()->getCheckoutId(),
					'cwhash' => Customweb_PayPalPlus_Util::computeSecuritySignature('endpoint/cancel', 
							$this->getOrderContext()->getCheckoutId(), $this->getEndpointKey()) 
				));
	}

	protected function getOrderDescription(){
		return Customweb_Payment_Util::applyOrderSchemaImproved(
				$this->getConfiguration()->getOrderDescriptionSchema($this->getOrderContext()->getLanguage()), $this->getOrderContext()->getCheckoutId(), 127);
	}
}