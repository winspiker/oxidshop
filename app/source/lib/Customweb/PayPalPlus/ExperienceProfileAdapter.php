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
 */

require_once 'Customweb/PayPalPlus/BackendOperation/Form/ExperienceProfile.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';



/**
 *
 * @author Nico Eigenmann
 * 
 * @Bean
 */
class Customweb_PayPalPlus_ExperienceProfileAdapter extends Customweb_PayPalPlus_AbstractAdapter{
		
	public function removeExperienceProfile(){
		$profileId = $this->getSettingsHandler()->getSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY);
		$profileUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payment-experience/web-profiles/'.$profileId['id'];
		try {
			$response = $this->sendRequestToRESTEndpoint($profileUrl, 'DELETE');
			
			if($response->getStatusCode() != 204){
				$errorMessage = Customweb_I18n_Translation::__('Could not delete experience profile.');
				$responseArray = json_decode($response->getBody(), true);
				if($responseArray['name'] != 'INVALID_RESOURCE_ID') {
					if (isset($responseArray['message'])) {
						$errorMessage .= ' ' . $responseArray['message'];
					}
					throw new Exception($errorMessage);
				}
			}
				
			
			$values = array();
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
		catch(Exception $e){
			$values = array();
			$values['error'] = $e->getMessage();
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
	}
	
	public function storeExperienceProfile(){
		if($this->getSettingsHandler()->hasCurrentStoreSetting(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY)) {
			$profileId = $this->getSettingsHandler()->getSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY);
	
			if (!isset($profileId['id']) || $profileId['id'] == '') {
				$this->createProfile();
			}
			else{
				$this->updateProfile();
			}
		}
		else{
			$this->createProfile();
		}
		
	}
	
	private function createProfile(){
		$registerParameters = array(
			'name' => $this->getSettingsHandler()->getSettingValue('profileName'),
			'presentation' => array(
				'brand_name' => $this->getSettingsHandler()->getSettingValue('brandName'),
				'logo_image' => $this->getSettingsHandler()->getSettingValue('logoUrl'),
			)
			
		);
		if($this->getSettingsHandler()->getSettingValue('addressOverride') != 'yes'){
			$registerParameters['input_fields'] = array('address_override' => 1);
		}
		$profileUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payment-experience/web-profiles';
		try {
			$responseArray = $this->sendRequestToRESTEndpointCheckResponse($profileUrl, 'POST', json_encode($registerParameters));
			if (!isset($responseArray['id'])) {
				$errorMessage = Customweb_I18n_Translation::__('Could not register experience profile.');
				if (isset($responseArray['message'])) {
					$errorMessage .= ' ' . $responseArray['message'];
				}
				throw new Exception($errorMessage);
			}
			$values = array(
				'id' => $responseArray['id'],
			);
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
		catch (Exception $e) {
			$values = array(
				'error' => $e->getMessage()
			);
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
	}
	
	private function updateProfile(){
		$updateParameters = array(
			'name' => $this->getSettingsHandler()->getSettingValue('profileName'),
			'presentation' => array(
				'brand_name' => $this->getSettingsHandler()->getSettingValue('brandName'),
				'logo_image' => $this->getSettingsHandler()->getSettingValue('logoUrl'),
			)
		);
		if($this->getSettingsHandler()->getSettingValue('addressOverride') != 'yes'){
			$updateParameters['input_fields'] = array('address_override' => 1);
		}
		$profileId = $this->getSettingsHandler()->getSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY);
		$profileUrl = $this->getConfiguration()->getRestApiUrl() . '/v1/payment-experience/web-profiles/'.$profileId['id'];
		try {
			$response = $this->sendRequestToRESTEndpoint($profileUrl, 'PUT', json_encode($updateParameters));
			if($response->getStatusCode() != '204') {
				$responseArray = json_decode(trim($response->getBody()), true);
				$errorMessage = Customweb_I18n_Translation::__('Could not update experience profile.');
				if ($responseArray !== false && isset($responseArray['message'])) {
					$errorMessage .= ' ' . $responseArray['message'];
				}
				throw new Exception($errorMessage);

			}
			$values = array(
				'id' => $profileId['id'],
			);
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
		catch(Exception $e){
			$values = $this->getSettingsHandler()->getSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY);
			$values['error'] = $e->getMessage();
			$this->getSettingsHandler()->setSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY, $values);
		}
	}
	
	/**
	 * 
	 * @return Customweb_Payment_SettingHandler
	 */
	protected function getSettingsHandler(){
		return $this->getContainer()->getBean('Customweb_Payment_SettingHandler');
	}
}