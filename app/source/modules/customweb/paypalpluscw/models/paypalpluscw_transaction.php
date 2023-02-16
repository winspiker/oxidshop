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



class paypalpluscw_transaction extends oxBase
{
	/**
	 * Object core table name
	 *
	 * @var string
	 */
	protected $_sCoreTable = 'paypalpluscw_transaction';

	/**
   	 * Current class name
   	 *
   	 * @var string
   	 */
  	protected $_sClassName = 'paypalpluscw_transaction';

  	protected $orderCache = null;

  	protected $paymentMethodCache = null;

  	public function __construct()
  	{
  		parent::__construct();

  		$this->init();
  	}

  	public function getTransactionId()
  	{
  		return $this->paypalpluscw_transaction__transactionid->value;
  	}

  	public function getOrder()
  	{
  		if ($this->orderCache == null && $this->paypalpluscw_transaction__orderid->value !== null) {
  			$order = oxNew('oxorder');
  			$order->load($this->paypalpluscw_transaction__orderid->value);
  			$this->orderCache = $order;
  		}
  		return $this->orderCache;
  	}

  	public function getPaymentMethod()
  	{
  		if ($this->paymentMethodCache == null && $this->paypalpluscw_transaction__paymentmachinename->value !== null) {
  			$paymentMethod = oxNew('oxpayment');
  			$paymentMethod->load('paypalpluscw_' . $this->paypalpluscw_transaction__paymentmachinename->value);
  			$this->paymentMethodCache = $paymentMethod;
  		}
  		return $this->paymentMethodCache;
  	}

  	/**
  	 * Assigns data, stored in DB to oxorder object
  	 *
  	 * @param mixed $dbRecord DB record
  	 *
  	 * @return null
  	 */
  	public function assign($dbRecord)
  	{
  		parent::assign($dbRecord);

  		$oUtilsDate = oxRegistry::get("oxUtilsDate");
  		$this->paypalpluscw_transaction__createdon = new oxField($oUtilsDate->formatDBDate($this->paypalpluscw_transaction__createdon->value),  oxField::T_RAW);
  		$this->paypalpluscw_transaction__updatedon = new oxField($oUtilsDate->formatDBDate($this->paypalpluscw_transaction__updatedon->value),  oxField::T_RAW);
  	}

  	/**
  	 * Inserts order object information in DB. Returns true on success.
  	 *
  	 * @return bool
  	 */
  	protected function _insert()
  	{
  		return false;
  	}

  	/**
  	 * Updates object parameters to DB.
  	 *
  	 * @return bool
  	 */
  	protected function _update()
  	{
  		return false;
  	}
}