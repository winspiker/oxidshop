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

require_once 'Customweb/Core/Stream/Input/File.php';
require_once 'Customweb/Core/Language.php';
require_once 'Customweb/Payment/IConfigurationAdapter.php';


/**
 * @Bean
 */
class PayPalPlusCwConfigurationAdapter implements Customweb_Payment_IConfigurationAdapter
{
	public function getConfigurationValue($key, $language = null)
	{
		$languageCode = (string)$language;

		$value = oxRegistry::getConfig()->getShopConfVar('paypalpluscw_' . $key, null, 'module:paypalpluscw');

		$setting = $this->getSetting($key);
		$sVarType = $setting['type'];
		if ($sVarType == 'multilang') {
			if (is_string($value)) {
				$value = unserialize($value);
			}
			if ($languageCode !== null) {
				if (is_array($value) && isset($value[$languageCode])) {
					return $value[$languageCode];
				} else {
					return '';
				}
			}
		}
		else if ($sVarType == 'file') {
			if (empty($value) || $value == $setting['value']) {
				return PayPalPlusCwHelper::getAssetResolver()->resolveAssetStream($setting['value']);
			} else {
				return new Customweb_Core_Stream_Input_File(PayPalPlusCwHelper::getUploadDirectory() . $value);
			}
		}

		return $value;
	}

	public function getDefaultTemplateUrl()
	{
		return PayPalPlusCwHelper::getUrl(array(
			'cl' => 'paypalpluscw_template'
		));
	}

	public function existsConfiguration($key, $language = null)
	{
		return oxRegistry::getConfig()->getShopConfVar('paypalpluscw_' . $key, null, 'module:paypalpluscw') != null;
	}

	private function getSetting($key)
	{
		$settings = array(
		array(
			'name' => 'paypalpluscw_operation_mode',
 			'type' => 'cwselect',
 			'value' => 'test',
 			'constraints' => 'test|live',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_id_live',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_secret_live',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_id_test',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_secret_test',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_description_schema',
 			'type' => 'str',
 			'value' => 'Order {id}',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_shop_name',
 			'type' => 'str',
 			'value' => 'This shop',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_seller_protection',
 			'type' => 'multiselect',
 			'value' => 'ineligible',
 			'constraints' => 'ineligible|itemNotReceived|unauthorizedPayment',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_address_check',
 			'type' => 'cwselect',
 			'value' => 'enabled',
 			'constraints' => 'enabled|disabled',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_update_interval',
 			'type' => 'str',
 			'value' => '0',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_creation',
 			'type' => 'cwselect',
 			'value' => 'after',
 			'constraints' => 'before|after',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_id',
 			'type' => 'cwselect',
 			'value' => 'default',
 			'constraints' => 'default|enforce',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_delete_failed_orders',
 			'type' => 'cwselect',
 			'value' => 'no',
 			'constraints' => 'yes|no',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_logging_level',
 			'type' => 'cwselect',
 			'value' => 'error',
 			'constraints' => 'error|info|debug',
 			'group' => 'paypalpluscw',
 		),
		);

		foreach ($settings as $setting) {
			if ($setting['name'] == 'paypalpluscw_' . $key) {
				return $setting;
			}
		}
	}

	private function getVarType($sVarName)
	{
		$sShopId = oxRegistry::getConfig()->getShopId();

		$oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);

		$sQ  = "select oxvartype from oxconfig where oxshopid = '{$sShopId}' and oxmodule = 'module:paypalpluscw' and oxvarname = ".$oDb->quote($sVarName);
		$oRs = $oDb->select($sQ);

		$sVarType = null;
		if ($oRs != false && $oRs->count() > 0) {
			$sVarType = $oRs->fields['oxvartype'];
		}
		return $sVarType;
	}

	public function getLanguages($currentStore = false)
	{
		$languages = array();
		$langs = oxRegistry::getConfig()->getConfigParam('aLanguages');
		foreach (array_keys($langs) as $lang) {
			$languages[$lang] = new Customweb_Core_Language($lang);
		}
		return $languages;
	}

	public function getStoreHierarchy()
	{
		$shop = oxRegistry::getConfig()->getActiveShop();
		return array(
			'default' => 'default',
			$shop->oxshops__oxid->value => $shop->oxshops__oxname->value
		);
	}

	public function useDefaultValue(Customweb_Form_IElement $element, array $formData)
	{
		$controlName = implode('_', $element->getControl()->getControlNameAsArray());
		return (isset($formData['default'][$controlName]) && $formData['default'][$controlName] == 'default');
	}

	public function getOrderStatus()
	{
		$folders = oxRegistry::getConfig()->getShopConfVar('aOrderfolder');
		$orderStatus = array();
		foreach (array_keys($folders) as $value) {
			$orderStatus[$value] = $value;
		}
		return $orderStatus;
	}

}
