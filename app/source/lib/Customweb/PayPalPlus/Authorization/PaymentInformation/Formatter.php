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



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_PaymentInformation_Formatter {

	private function __construct(){}

	public static function formatInformation(array $instructions, $shopname){
		$html = '';
		if (isset($instructions['instruction_type']) && $instructions['instruction_type'] == 'MANUAL_BANK_TRANSFER') {
			
			$html .= Customweb_I18n_Translation::__('Please wire the amount of  <b>!amount !currency</b> to:<br />', 
					array(
						'!amount' => $instructions['amount']['value'],
						'!currency' => $instructions['amount']['currency'] 
					));
			
			$html .= '<b>' . Customweb_I18n_Translation::__('Reference') . '</b>: ' . $instructions['reference_number'] . '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('Account Holder') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['account_holder_name'] . '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('Account Number') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['account_number'] . '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('Bank Name') . '</b>: ' . $instructions['recipient_banking_instruction']['bank_name'] .
					 '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('Routing Number') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['routing_number'] . '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('IBAN') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['international_bank_account_number'] . '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('BIC') . '</b>: ' . $instructions['recipient_banking_instruction']['bank_identifier_code'] .
					 '<br />';
			
			return $html;
		}
		if (isset($instructions['instruction_type']) && $instructions['instruction_type'] == 'PAY_UPON_INVOICE') {
			$html .= Customweb_I18n_Translation::__(
					'!shopname hat die Forderung gegen Sie im Rahmen eines laufenden Factoringvertrages an die PayPal (Europe) S.àr.l. et Cie, S.C.A. abgetreten. Zahlungen
mit schuldbefreiender Wirkung können nur an die PayPal (Europe) S.àr.l. et Cie, S.C.A. geleistet werden.', 
					array(
						'!shopname' => $shopname 
					));
			$html .= '<br />';
			$html .= '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('Bank Name') . '</b>: ' . $instructions['recipient_banking_instruction']['bank_name'] .
					 '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('Account Holder') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['account_holder_name'] . '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('IBAN') . '</b>: ' .
					 $instructions['recipient_banking_instruction']['international_bank_account_number'] . '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('BIC') . '</b>: ' . $instructions['recipient_banking_instruction']['bank_identifier_code'] .
					 '<br />';
			$html .= '<br />';
			
			$html .= '<b>' . Customweb_I18n_Translation::__('Amount due / currency') . '</b>: ' . $instructions['amount']['value'] . ' ' .
					 $instructions['amount']['currency'] . '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('Payment due date') . '</b>: ' . $instructions['payment_due_date'] . '<br />';
			$html .= '<b>' . Customweb_I18n_Translation::__('Reference') . '</b>: ' . $instructions['reference_number'] . '<br />';
			$html .= '<br />';
			return $html;
		}
	}
}