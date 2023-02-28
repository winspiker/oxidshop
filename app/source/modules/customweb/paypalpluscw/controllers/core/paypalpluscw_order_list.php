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



class paypalpluscw_order_list extends paypalpluscw_order_list_parent
{
	public function render()
	{
		parent::render();

		$this->_aViewData['enabledModule'] = false;
		$this->_aViewData['noSelection'] = false;

		$orderId = $this->getEditObjectId();
		if ($orderId != '-1' && isset($orderId)) {
            // load object
            $order = oxNew('oxorder');
            $order->load($orderId);

            if (PayPalPlusCwHelper::isPaypalpluscwPaymentMethod($order->oxorder__oxpaymenttype->value)) {
            		$this->_aViewData['enabledModule'] = 'paypalpluscw';
            }
		} else {
			$this->_aViewData['noSelection'] = true;
		}

		return "paypalpluscw_order_list.tpl";
	}
}