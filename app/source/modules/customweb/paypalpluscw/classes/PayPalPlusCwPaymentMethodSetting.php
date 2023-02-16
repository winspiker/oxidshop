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


class PayPalPlusCwPaymentMethodSetting
{
	protected static $_configFormCache = array();

	protected static function getConfigElements($paymentId)
	{
		
			if ($paymentId === 'paypalpluscw_paypal') {
				$result = array(
					array(
						'name' => 'capturing',
 						'options' => array(
							'sale' => 'Directly after order (sale)',
 							'authorize' => 'Deferred (authorization)',
 							'order' => 'Do only check the payment information (order)
						',
 						),
 						'description' => 'By setting the capturing the reservation can becaptured directly after the order or later manually over thebackend of the store. The difference between \'order\' and\'authorization\' is that on \'order\' only checks the paymentinformationand does not create a reservation.',
 						'type' => 'select',
 						'title' => 'Capturing',
 						'value' => 'sale',
 						'required' => 1,
 					),
					array(
						'name' => 'status_finallydeclined',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status of payments, whichare declined after being pending atPayPal Plus. ',
 						'type' => 'select',
 						'title' => 'Status for declined payments',
 						'value' => 'no_status_change',
 						'required' => 1,
 					),
					array(
						'name' => 'status_authorized',
 						'options' => self::getOrderFolders(array(
					)),
 						'description' => 'This status is set, when the payment was successfulland it is authorized.',
 						'type' => 'select',
 						'title' => 'Authorized Status',
 						'value' => 'ORDERFOLDER_NEW',
 						'required' => 1,
 					),
					array(
						'name' => 'status_uncertain',
 						'options' => self::getOrderFolders(array(
					)),
 						'description' => 'You can specify the order status for new orders thathave an uncertain authorisation status.',
 						'type' => 'select',
 						'title' => 'Uncertain Status',
 						'value' => 'ORDERFOLDER_PROBLEMS',
 						'required' => 1,
 					),
					array(
						'name' => 'status_cancelled',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status when an order iscancelled.',
 						'type' => 'select',
 						'title' => 'Cancelled Status',
 						'value' => 'ORDERFOLDER_FINISHED',
 						'required' => 1,
 					),
					array(
						'name' => 'status_captured',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status for orders that arecaptured either directly after the order or manually in thebackend.',
 						'type' => 'select',
 						'title' => 'Captured Status',
 						'value' => 'no_status_change',
 						'required' => 1,
 					),
					array(
						'name' => 'authorizationMethod',
 						'options' => array(
							'PaymentPage' => 'Payment Page',
 						),
 						'description' => 'Select the authorization method to use for processing this payment method.',
 						'type' => 'select',
 						'title' => 'Authorization Method',
 						'value' => 'PaymentPage',
 						'required' => 1,
 					),
					array(
						'name' => 'min_order_total',
 						'description' => 'This payment method is only available in case the order total is equal to or greater than the specified amount.',
 						'type' => 'str',
 						'title' => 'Minimal Order Total',
 						'value' => '',
 						'required' => 0,
 					),
					array(
						'name' => 'max_order_total',
 						'description' => 'This payment method is only available in case the order total is equal to or less than the specified amount.',
 						'type' => 'str',
 						'title' => 'Maximal Order Total',
 						'value' => '',
 						'required' => 0,
 					),
					array(
						'name' => 'order_status',
 						'options' => self::getOrderFolders(),
 						'description' => 'You can decide on the order status new orders should have that have an uncertain authorization status.',
 						'type' => 'select',
 						'title' => 'New Order Status',
 						'value' => '0',
 						'required' => 1,
 					),
					array(
						'name' => 'form_position',
 						'options' => array('payment' => 'On payment selection page', 'checkout' => 'On checkout page', 'separate' => 'On separate page'),
 						'description' => 'Decide where the payment form should be displayed.',
 						'type' => 'select',
 						'title' => 'Payment Form Position',
 						'value' => 'checkout',
 						'required' => 1,
 					),
				);
			}

			if ($paymentId === 'paypalpluscw_paypalplus') {
				$result = array(
					array(
						'name' => 'status_authorized',
 						'options' => self::getOrderFolders(array(
					)),
 						'description' => 'This status is set, when the payment was successfulland it is authorized.',
 						'type' => 'select',
 						'title' => 'Authorized Status',
 						'value' => 'ORDERFOLDER_NEW',
 						'required' => 1,
 					),
					array(
						'name' => 'status_uncertain',
 						'options' => self::getOrderFolders(array(
					)),
 						'description' => 'You can specify the order status for new orders thathave an uncertain authorisation status.',
 						'type' => 'select',
 						'title' => 'Uncertain Status',
 						'value' => 'ORDERFOLDER_PROBLEMS',
 						'required' => 1,
 					),
					array(
						'name' => 'status_cancelled',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status when an order iscancelled.',
 						'type' => 'select',
 						'title' => 'Cancelled Status',
 						'value' => 'ORDERFOLDER_FINISHED',
 						'required' => 1,
 					),
					array(
						'name' => 'status_captured',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status for orders that arecaptured either directly after the order or manually in thebackend.',
 						'type' => 'select',
 						'title' => 'Captured Status',
 						'value' => 'no_status_change',
 						'required' => 1,
 					),
					array(
						'name' => 'status_finallydeclined',
 						'options' => self::getOrderFolders(array(
						'no_status_change' => 'Don\'t change order status',
 					)),
 						'description' => 'You can specify the order status of payments, whichare declined after being pending atPayPal Plus. ',
 						'type' => 'select',
 						'title' => 'Status for declined payments',
 						'value' => 'no_status_change',
 						'required' => 1,
 					),
					array(
						'name' => 'authorizationMethod',
 						'options' => array(
							'AjaxAuthorization' => 'Ajax Authorization',
 						),
 						'description' => 'Select the authorization method to use for processing this payment method.',
 						'type' => 'select',
 						'title' => 'Authorization Method',
 						'value' => 'AjaxAuthorization',
 						'required' => 1,
 					),
					array(
						'name' => 'min_order_total',
 						'description' => 'This payment method is only available in case the order total is equal to or greater than the specified amount.',
 						'type' => 'str',
 						'title' => 'Minimal Order Total',
 						'value' => '',
 						'required' => 0,
 					),
					array(
						'name' => 'max_order_total',
 						'description' => 'This payment method is only available in case the order total is equal to or less than the specified amount.',
 						'type' => 'str',
 						'title' => 'Maximal Order Total',
 						'value' => '',
 						'required' => 0,
 					),
					array(
						'name' => 'order_status',
 						'options' => self::getOrderFolders(),
 						'description' => 'You can decide on the order status new orders should have that have an uncertain authorization status.',
 						'type' => 'select',
 						'title' => 'New Order Status',
 						'value' => '0',
 						'required' => 1,
 					),
					array(
						'name' => 'form_position',
 						'options' => array('payment' => 'On payment selection page', 'checkout' => 'On checkout page', 'separate' => 'On separate page'),
 						'description' => 'Decide where the payment form should be displayed.',
 						'type' => 'select',
 						'title' => 'Payment Form Position',
 						'value' => 'checkout',
 						'required' => 1,
 					),
				);
			}


		return $result;
	}

	/**
	 * Return the configuration form fields of a payment method.
	 *
	 * @param integer $paymentId
	 * @return array
	 */
	public static function getConfigForm($paymentId)
	{
		$oStr = getStr();

		if (!isset(self::$_configFormCache[$paymentId])) {
			$result = self::getConfigElements($paymentId);

			foreach ($result as $key => $setting) {
				$result[$key]['key'] = substr($paymentId, strlen('paypalpluscw_')) . '_' . $setting['name'];

				$value = oxRegistry::getConfig()->getShopConfVar($result[$key]['key'], null, 'module:paypalpluscw');
				if ($value !== null) {
					$result[$key]['value'] = $value;
				} else {
					$result[$key]['value'] = self::unserializeValue($result[$key]['value'], $setting['type']);
				}

				if (is_array($result[$key]['value'])) {
					foreach ($result[$key]['value'] as $k => $v) {
						$result[$key]['value'][$k] = utf8_decode($v);
					}
				} else {
					$result[$key]['value'] = utf8_decode($result[$key]['value']);
				}

				switch ($setting['type']) {
					case 'multilang':
						if (is_string($result[$key]['value'])) {
							$result[$key]['value'] = $oStr->htmlentities($result[$key]['value']);
						} else {
							foreach ($result[$key]['value'] as $k => $v) {
								$result[$key]['value'][$k] = $oStr->htmlentities($v);
							}
						}
						break;
					case 'multiselect':
						break;
					case 'file':
						$result[$key]['options'] = PayPalPlusCwHelper::getFileOptions($result[$key]['allowedFileExtensions']);
						break;
					default:
						$result[$key]['value'] = $oStr->htmlentities($result[$key]['value']);
						break;
				}
			}
			self::$_configFormCache[$paymentId] = $result;
		}

		return self::$_configFormCache[$paymentId];
	}

	/**
	 * Return a specific form fields of a payment method.
	 *
	 * @param integer $paymentId
	 * @param string $name
	 * @return array|boolean
	 */
	protected static function getElement($paymentId, $name)
	{
		$elements = self::getConfigElements($paymentId);
		foreach ($elements as $element) {
			if ($element['name'] == $name) {
				return $element;
			}
		}

		return false;
	}

	/**
	 * Return default value of a specific field.
	 *
	 * @param integer $paymentId
	 * @param string $name
	 * @return mixed
	 */
	public static function getDefaultValue($paymentId, $name)
	{
		$element = self::getElement($paymentId, $name);
		if ($element === false) {
			return;
		}
		return self::unserializeValue($element['value'], $element['type']);
	}

	/**
	 * Return the value of a specific field.
	 *
	 * @param integer $paymentId
	 * @param string $name
	 * @param integer $shopId
	 * @return mixed
	 */
	public static function getConfigValue($paymentId, $name, $languageCode = null)
	{
		$configValueDb = oxRegistry::getConfig()->getShopConfVar(substr($paymentId, strlen('paypalpluscw_')) . '_' . $name, null, 'module:paypalpluscw');
		$element = self::getElement($paymentId, $name);
		$configValue = self::unserializeValue($configValueDb, $element['type']);
		if ($element['type'] == 'multilang') {
			if ($languageCode !== null) {
				if (is_array($configValue) && isset($configValue[$languageCode])) {
					return $configValue[$languageCode];
				} else {
					return '';
				}
			}
		} elseif ($element['type'] == 'file') {
			$defaultValue = self::getDefaultValue($paymentId, $name);
			if (empty($configValue) || $configValue == $defaultValue) {
				return PayPalPlusCwHelper::getAssetResolver()->resolveAssetStream($defaultValue);
			} else {
				return new Customweb_Core_Stream_Input_File(PayPalPlusCwHelper::getUploadDirectory() . $configValue);
			}
		} 
		if ($configValueDb === null) {
			$configValue = self::getDefaultValue($paymentId, $name);
		}

		return $configValue;
	}

	protected static function getOrderFolders($options = array())
	{
		$folders = oxRegistry::getConfig()->getConfigParam('aOrderfolder');
		foreach ($folders as $folder => $color) {
			$options[$folder] = $folder;
		}
		return $options;
	}

	protected static function unserializeValue($value, $type)
	{
		if ($type == 'multilang') {
			if (!is_array($value)) {
				$newValue = array();
				foreach (oxRegistry::getConfig()->getConfigParam('aLanguages') as $langKey => $lang) {
					$newValue[$langKey] = $value;
				}
				$value = $newValue;
			}
		}
		if ($type == 'multiselect') {
			if (empty($value)) {
				$value = array();
			}elseif(is_array($value)){
				$value = $value;	
			}else {			
				$value = explode(',', $value);
			}
		}

		return $value;
	}
}