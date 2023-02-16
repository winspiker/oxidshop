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

require_once 'Customweb/Core/String.php';
require_once 'Customweb/Core/Util/Language.php';
require_once 'Customweb/I18n/Translation.php';



/**
 *
 * @author Nico Eigenmann
 */
final class Customweb_PayPalPlus_Util {

	private function __construct(){
		// prevent any instantiation of this class
	}

	public static function getCleanLanguageCode($lang){
		$supportedLanguages = array(
			'de_DE',
			'en_US',
			'fr_FR',
			'da_DK',
			'cs_CZ',
			'es_ES',
			'hr_HR',
			'it_IT',
			'hu_HU',
			'nl_NL',
			'no_NO',
			'pl_PL',
			'pt_PT',
			'ru_RU',
			'ro_RO',
			'sk_SK',
			'sl_SI',
			'fi_FI',
			'sv_SE',
			'tr_TR',
			'el_GR',
			'ja_JP' 
		);
		return Customweb_Core_Util_Language::getCleanLanguageCode($lang, $supportedLanguages);
	}

	public static function computeSecuritySignature($entity, $id, $secret){
		$entity = (string) $entity;
		
		return hash_hmac('sha512', $entity . $id, $secret);
	}

	public static function checkSecuritySignature($entity, $id, $secret, $providedSignature){
		$signature = self::computeSecuritySignature($entity, $id, $secret);
		if ($signature !== $providedSignature) {
			throw new Exception(Customweb_I18n_Translation::__('The provided signature does not match with the one calculated.'));
		}
		
		return true;
	}

	/**
	 * This method takes two order context addresses and compares them.
	 * The method returns true, when they match.
	 *
	 * @param Customweb_Payment_Authorization_OrderContext_IAddress $address1
	 * @param Customweb_Payment_Authorization_OrderContext_IAddress $address2
	 * @return boolean
	 */
	public static function compareAddresses(Customweb_Payment_Authorization_OrderContext_IAddress $address1, Customweb_Payment_Authorization_OrderContext_IAddress $address2){
		if (!self::tolerantStringCompare($address1->getCity(), $address2->getCity())) {
			return false;
		}
		if (!self::tolerantStringCompare($address1->getCountryIsoCode(), $address2->getCountryIsoCode())) {
			return false;
		}
		if (!self::tolerantNamesCompare($address1->getFirstName(), $address1->getLastName(), $address2->getFirstName(), $address2->getLastName())) {
			return false;
		}
		if (!self::tolerantStringCompare($address1->getPostCode(), $address2->getPostCode())) {
			return false;
		}
		if (!self::tolerantStringCompare($address1->getStreet(), $address2->getStreet())) {
			return false;
		}
		
		return true;
	}
	
	
	protected static function tolerantNamesCompare($firstName1, $lastName1, $firstName2, $lastName2){
		if(self::tolerantStringCompare($firstName1, $firstName2) && self::tolerantStringCompare($lastName1, $lastName2)){
			return true;			
		}
		if($firstName1 === null){
			$firstName1 = "";
		}
		if($lastName1 === null){
			$lastName1 = "";
		}
		if($firstName2 === null){
			$firstName2 = "";
		}
		if($lastName2 === null){
			$lastName2 = "";
		}
		if(self::tolerantStringCompare(trim($firstName1).trim($lastName1), trim($firstName2).trim($lastName2))){
			return true;
		}
		return false;
		
	}

	protected static function tolerantStringCompare($value1, $value2){
		$lower1 = strtolower($value1);
		$lower2 = strtolower($value2);
		if (trim($lower1) == trim($lower2)) {
			return true;
		}
		$ascii1 = Customweb_Core_String::_($lower1)->convertTo('ASCII')->toLowerCase()->toString();
		$ascii2 = Customweb_Core_String::_($lower2)->convertTo('ASCII')->toLowerCase()->toString();
		if (trim($ascii1) == trim($ascii2)) {
			return true;
		}
		return false;
	}
}