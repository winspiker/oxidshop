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

require_once 'Customweb/Payment/Authorization/DefaultTransactionCapture.php';



/**
 *
 * @author Nico Eigenmann
 */
class Customweb_PayPalPlus_Authorization_TransactionCapture extends Customweb_Payment_Authorization_DefaultTransactionCapture {

	private $refundedAmount = 0;
	
	private $refundUrl = null;
	
	private $transactionFee = array();
	
	private $externalId = null;
	
	public function setExternaLid($id){
		$this->externalId = $id;
		return $this;
	}
	
	public function getExternalId(){
		return $this->externalId;
	}
	
	public function getRefundedAmount() {
		return $this->refundedAmount;
	}
	
	public function setRefundedAmount($refundedAmount) {
		$this->refundedAmount = $refundedAmount;
		return $this;
	}
		
	public function setRefundUrl($url){
		$this->refundUrl = $url;
		return $this;
	}
	
	public function getRefundUrl(){
		return $this->refundUrl;
	}

	public function setTransactionFee(array $transactionFee){
		$this->transactionFee = $transactionFee;
		return $this;
	}
	
	public function getTransactionFee(){
		return $this->transactionFee;
	}
}