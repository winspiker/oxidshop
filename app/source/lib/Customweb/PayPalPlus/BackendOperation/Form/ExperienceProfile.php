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

require_once 'Customweb/Payment/BackendOperation/Form/Abstract.php';
require_once 'Customweb/Form/Element.php';
require_once 'Customweb/Form/ElementGroup.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/Form/IButton.php';
require_once 'Customweb/Form/Control/Html.php';
require_once 'Customweb/Form/Control/Select.php';
require_once 'Customweb/Form/Button.php';
require_once 'Customweb/Form/Control/TextInput.php';


/**
 * @BackendForm
 */
final class Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile extends Customweb_Payment_BackendOperation_Form_Abstract {
	const STORAGE_PROFILE_KEY = 'profile_value';

	public static function getProfileFields(){
		return array(
			'profileName' => array(
				'label' => Customweb_I18n_Translation::__('Profile Name'),
				'desc' => Customweb_I18n_Translation::__('Name of the web experience profile. Unique only among the profiles for this merchant.'),
				'type' => 'text',
				'default' => '' 
			),
			'brandName' => array(
				'label' => Customweb_I18n_Translation::__('Brand Name'),
				'desc' => Customweb_I18n_Translation::__('A label that overrides the business name in the PayPal account on the PayPal pages.'),
				'type' => 'text',
				'default' => '' 
			),
			'logoUrl' => array(
				'label' => Customweb_I18n_Translation::__('Logo Url'),
				'desc' => Customweb_I18n_Translation::__(
						'A URL to logo image. Allowed file formats: .gif, .jpg, or .png. Limit the image to 190 pixels wide by 60 pixels high, larger images will be cropped.'),
				'type' => 'text',
				'default' => '' 
			),
			'addressOverride' => array(
				'label' => Customweb_I18n_Translation::__('Address Override'),
				'desc' => Customweb_I18n_Translation::__('Should th customer be able to override the address at PayPal? If you set this to yes, please disable the address verification in the main configuration.'),
				'type' => 'select',
				'options' => array(
					'yes' => Customweb_I18n_Translation::__('Yes'),
					'no' => Customweb_I18n_Translation::__('No') 
				),
				'default' => 'no' 
			) 
		
		);
	}

	public function isProcessable(){
		return true;
	}

	public function getTitle(){
		return Customweb_I18n_Translation::__("Experience Profile");
	}

	public function getElementGroups(){
		$elementGroups = array();
		$elementGroups[] = $this->getExperienceProfile();
		return $elementGroups;
	}

	private function getExperienceProfile(){
		$profile = new Customweb_Form_ElementGroup();
		$profile->setTitle(Customweb_I18n_Translation::__('Experience Profile'));
		foreach (self::getProfileFields() as $key => $value) {
			if($value['type'] == 'text'){
				$control = new Customweb_Form_Control_TextInput($key, $this->getPrefillValue($key, $value['default']));
				$element = new Customweb_Form_Element($value['label'], $control, $value['desc'], false, false);
			}
			elseif($value['type'] == 'select'){
				$control = new Customweb_Form_Control_Select($key, $value['options'], $this->getPrefillValue($key, $value['default']));
				$element = new Customweb_Form_Element($value['label'], $control, $value['desc'], false, false);
				
			}
			$profile->addElement($element);
		}
		if ($this->getSettingHandler()->hasCurrentStoreSetting(self::STORAGE_PROFILE_KEY)) {
			$profileId = $this->getSettingHandler()->getSettingValue(self::STORAGE_PROFILE_KEY);
			
			if (is_array($profileId) && isset($profileId['id'])) {
				$control = new Customweb_Form_Control_Html('profileId', $profileId['id']);
				$element = new Customweb_Form_Element(Customweb_I18n_Translation::__('Profile Id'), $control);
				$element->setRequired(false);
				$profile->addElement($element);
			}
			else {
				$control = new Customweb_Form_Control_Html('profileId', Customweb_I18n_Translation::__('No Profile registered'));
				$element = new Customweb_Form_Element(Customweb_I18n_Translation::__('Profile Id'), $control);
				$element->setRequired(false);
				$profile->addElement($element);
			}
			if (is_array($profileId) && isset($profileId['error'])) {
				$control = new Customweb_Form_Control_Html('errorMessage', $profileId['error']);
				$element = new Customweb_Form_Element(Customweb_I18n_Translation::__('Error Message'), $control);
				$element->setRequired(false);
				$profile->addElement($element);
			}
		}
		
		return $profile;
	}

	private function getPrefillValue($key, $default){
		$stored = $this->getSettingValue($key);
		if ($stored === null) {
			return $default;
		}
		return $stored;
	}

	/**
	 *
	 * @return Customweb_Storage_IBackend
	 */
	private function getStorageBackend(){
		return $this->getContainer()->getBean('Customweb_Storage_IBackend');
	}

	public function getButtons(){
		$buttons = array(
			$this->getSaveButton() 
		);
		if ($this->getSettingHandler()->hasCurrentStoreSetting(self::STORAGE_PROFILE_KEY)) {
			$profileId = $this->getSettingHandler()->getSettingValue(self::STORAGE_PROFILE_KEY);
			if (is_array($profileId) && isset($profileId['id'])) {
				$buttons[] = $this->getDeleteButton();
			}
		}
		
		return $buttons;
	}

	protected function getSaveButton(){
		$saveButton = new Customweb_Form_Button();
		$saveButton->setMachineName("save")->setType(Customweb_Form_IButton::TYPE_SUCCESS)->setTitle(Customweb_I18n_Translation::__("Register"));
		if ($this->getSettingHandler()->hasCurrentStoreSetting(self::STORAGE_PROFILE_KEY)) {
			$profileId = $this->getSettingHandler()->getSettingValue(self::STORAGE_PROFILE_KEY);
			if (is_array($profileId) && isset($profileId['id'])) {
				$saveButton->setTitle(Customweb_I18n_Translation::__("Update"));
			}
		}
		return $saveButton;
	}

	private function getDeleteButton(){
		$button = new Customweb_Form_Button();
		$button->setMachineName("delete")->setTitle(Customweb_I18n_Translation::__("Deregister"))->setType(Customweb_Form_IButton::TYPE_CANCEL);
		return $button;
	}

	public function process(Customweb_Form_IButton $pressedButton, array $formData){
		if ($pressedButton->getMachineName() === 'save') {
			$this->getSettingHandler()->processForm($this, $formData);
			$this->getExperienceProfileAdapter()->storeExperienceProfile();
		}
		elseif ($pressedButton->getMachineName() === 'delete') {
			$this->getExperienceProfileAdapter()->removeExperienceProfile();
		}
	}

	/**
	 * 
	 * @return Customweb_PayPalPlus_ExperienceProfileAdapter
	 */
	protected function getExperienceProfileAdapter(){
		return $this->getContainer()->getBean('Customweb_PayPalPlus_ExperienceProfileAdapter');
	}
}