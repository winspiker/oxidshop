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
require_once 'Customweb/I18n/LocalizableString.php';

/**
 * 
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_Configuration {
	
	/**
	 *        					    			 	 
	 *
	 * @var Customweb_Payment_IConfigurationAdapter
	 */
	private $configurationAdapter = null;

	public function __construct(Customweb_Payment_IConfigurationAdapter $configurationAdapter){
		$this->configurationAdapter = $configurationAdapter;
	}

	/**
	 * Returns whether the gateway is in test mode or in live mode.
	 *        					    			 	 
	 *
	 * @return boolean True if the system is in test mode. Else return false.
	 */
	public function isTestMode(){
		return $this->getConfigurationAdapter()->getConfigurationValue('operation_mode') != 'live';
	}

	public function getRestApiUrl(){
		if ($this->isTestMode()) {
			return "https://api.sandbox.paypal.com";
		}
		else {
			return "https://api.paypal.com";
		}
	}
	
	public function isAddressCheckDisabled(){
		$check = $this->getConfigurationAdapter()->getConfigurationValue('address_check');
		if($check == 'disabled'){
			return true;
		}
		return false;
		
	}

	public function getRestAPIClientId(){
		$clientId = null;
		if ($this->isTestMode()) {
			$clientId = $this->getConfigurationAdapter()->getConfigurationValue('rest_client_id_test');
		}
		else {
			$clientId = $this->getConfigurationAdapter()->getConfigurationValue('rest_client_id_live');
		}
		$clientId = trim($clientId);
		if (empty($clientId)) {
			throw new Exception(new Customweb_I18n_LocalizableString("Rest API Client Id not configured"));
		}
		return $clientId;
	}

	public function getRestAPIClientSecret(){
		$clientSecret = null;
		if ($this->isTestMode()) {
			$clientSecret = $this->getConfigurationAdapter()->getConfigurationValue('rest_client_secret_test');
		}
		else {
			$clientSecret = $this->getConfigurationAdapter()->getConfigurationValue('rest_client_secret_live');
		}
		$clientSecret = trim($clientSecret);
		if (empty($clientSecret)) {
			throw new Exception(new Customweb_I18n_LocalizableString("Rest API Client Secret not configured"));
		}
		return $clientSecret;
	}


	public function getSellerProtectionSelection(){
		return $this->getConfigurationAdapter()->getConfigurationValue('seller_protection');
	}

	public function getOrderDescriptionSchema($language = null){
		return $this->getConfigurationAdapter()->getConfigurationValue('order_description_schema');
	}

	public function getShopName(){
		$shopName = trim($this->getConfigurationAdapter()->getConfigurationValue('shop_name'));
		return $shopName;
	}
	
	/**
	 *
	 * @return Customweb_Payment_IConfigurationAdapter
	 */
	public function getConfigurationAdapter(){
		return $this->configurationAdapter;
	}

}
