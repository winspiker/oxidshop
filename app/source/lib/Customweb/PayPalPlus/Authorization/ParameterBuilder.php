<?php

require_once 'Customweb/PayPalPlus/Container.php';
require_once 'Customweb/Util/Currency.php';
require_once 'Customweb/PayPalPlus/BackendOperation/Form/ExperienceProfile.php';
require_once 'Customweb/Payment/Authorization/IInvoiceItem.php';
require_once 'Customweb/Filter/Input/String.php';
require_once 'Customweb/Payment/Util.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_ParameterBuilder {
	private $container;
	private $orderContext;

	public function __construct(Customweb_DependencyInjection_IContainer $container, Customweb_Payment_Authorization_IOrderContext $orderContext){
		if (!$container instanceof Customweb_PayPalPlus_Container) {
			$container = new Customweb_PayPalPlus_Container($container);
		}
		$this->container = $container;
		$this->orderContext = $orderContext;
	}

	protected function getPayerDetails(){
		return array(
			'payment_method' => 'paypal',
			'payer_info' => $this->getPayerInfo() 
		);
	}



	protected function getPayerInfo(){
		$billingAddress = $this->getOrderContext()->getBillingAddress();
		$parameters = array(
			'first_name' => Customweb_Filter_Input_String::_($billingAddress->getFirstName(), 50)->filter(),
			'last_name' => Customweb_Filter_Input_String::_($billingAddress->getLastName(), 50)->filter(),
			'billing_address' => $this->getBillingAddress(),
		);
		
		return $parameters;
	}

	protected function getTransactionDetails(){
		$parameters = $this->getOrderDetails();
		$parameters['description'] = $this->getOrderDescription();
		$parameters['invoice_number'] = $this->getOrderDescription();
		return array(
			$parameters 
		);
	}

	protected function getBillingAddress(){
		$billingAddress = $this->getOrderContext()->getBillingAddress();
		$result = array(
			'line1' => Customweb_Filter_Input_String::_($billingAddress->getStreet(), 100)->filter(),
			'city' => Customweb_Filter_Input_String::_($billingAddress->getCity(), 50)->filter(),
			'country_code' => $billingAddress->getCountryIsoCode(),
			'postal_code' => Customweb_Filter_Input_String::_($billingAddress->getPostCode(), 20)->filter(), 
		);
		if ($billingAddress->getState() != null) {
			$result['state'] = Customweb_Filter_Input_String::_($billingAddress->getState(), 100)->filter();
		}
		return $result;
	}

	protected function getShippingAddress(){
		$shipping = $this->getOrderContext()->getShippingAddress();
		$result = array(
			'recipient_name' => Customweb_Filter_Input_String::_($shipping->getFirstName() . ' ' . $shipping->getLastName(), 50)->filter(),
			'line1' => Customweb_Filter_Input_String::_($shipping->getStreet(), 100)->filter(),
			'city' => Customweb_Filter_Input_String::_($shipping->getCity(), 50)->filter(),
			'country_code' => $shipping->getCountryIsoCode(),
			'postal_code' => Customweb_Filter_Input_String::_($shipping->getPostCode(), 20)->filter() 
		);
		if ($shipping->getState() != null) {
			$result['state'] = Customweb_Filter_Input_String::_($shipping->getState(), 100)->filter();
		}
		return $result;
	}
	
	protected function getExperienceProfileId(){
		$settingsHandler = $this->getContainer()->getBean('Customweb_Payment_SettingHandler');
		$profileId = $settingsHandler->getSettingValue(Customweb_PayPalPlus_BackendOperation_Form_ExperienceProfile::STORAGE_PROFILE_KEY);
		if(is_array($profileId) && isset($profileId['id'])){
			return $profileId['id'];
		}
		
	}

	protected function getOrderDetails(){
		$orderAmount = Customweb_Util_Currency::formatAmount($this->getOrderContext()->getOrderAmountInDecimals(), 
				$this->getOrderContext()->getCurrencyCode(), '.', '');
		$currency = $this->getOrderContext()->getCurrencyCode();
		$totalItem = 0;
		
		$invoiceItems = $this->getOrderContext()->getInvoiceItems();
		$items = array();
		$discountAmount = 0;
		foreach ($invoiceItems as $invoiceItem) {
			$amount = Customweb_Util_Currency::formatAmount($invoiceItem->getAmountIncludingTax(), $currency, '.', '');
			if ($invoiceItem->getType() == Customweb_Payment_Authorization_IInvoiceItem::TYPE_SHIPPING || $invoiceItem->getType() == Customweb_Payment_Authorization_IInvoiceItem::TYPE_FEE) {
				continue;
			}
			if ($invoiceItem->getType() == Customweb_Payment_Authorization_IInvoiceItem::TYPE_DISCOUNT) {
				$discountAmount += Customweb_Util_Currency::formatAmount($invoiceItem->getAmountIncludingTax() * -1, $currency, '.', '');
				continue;
			}
			$totalItem += $amount;
			$item = array(
				'quantity' => '1',
				'name' => Customweb_Filter_Input_String::_($invoiceItem->getName(), 127)->filter(),
				'price' => $amount,
				'currency' => $currency,
				'sku' => Customweb_Filter_Input_String::_($invoiceItem->getSku(), 50)->filter() 
			);
			$items[] = $item;
		}
		$totalItem = Customweb_Util_Currency::formatAmount($totalItem, $currency, '.', '');
		$discountAmount = Customweb_Util_Currency::formatAmount($discountAmount, $currency, '.', '');
		$totalShipping = Customweb_Util_Currency::formatAmount($orderAmount - $totalItem - $discountAmount, $currency, '.', '');
		
		return array(
			'amount' => array(
				'total' => $orderAmount,
				'currency' => $currency,
				'details' => array(
					'subtotal' => $totalItem,
					'shipping' => $totalShipping,
					'shipping_discount' => $discountAmount,
				) 
			),
			'item_list' => array(
				'shipping_address' => $this->getShippingAddress(),
				'items' => $items 
			)
			 
		);
	}

	/**
	 *
	 * @return Customweb_Payment_Authorization_IOrderContext
	 */
	protected function getOrderContext(){
		return $this->orderContext;
	}

	/**
	 *
	 * @return Customweb_PayPalPlus_Configuration
	 */
	protected function getConfiguration(){
		return $this->getContainer()->getConfiguration();
	}

	protected function getContainer(){
		return $this->container;
	}

	protected function getOrderDescription(){
		return Customweb_Payment_Util::applyOrderSchemaImproved($this->getConfiguration()->getOrderDescriptionSchema($this->getOrderContext()->getLanguage()), 
				'', 127);
	}
}