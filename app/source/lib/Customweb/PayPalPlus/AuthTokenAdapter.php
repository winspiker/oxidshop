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

require_once 'Customweb/Storage/IBackend.php';
require_once 'Customweb/I18n/Translation.php';
require_once 'Customweb/PayPalPlus/AbstractAdapter.php';
require_once 'Customweb/Core/Http/Client/Factory.php';
require_once 'Customweb/Core/Http/Authorization/Basic.php';
require_once 'Customweb/Core/Http/Request.php';


/**
 *
 * @author Nico Eigenmann
 * @Bean
 */
class Customweb_PayPalPlus_AuthTokenAdapter extends Customweb_PayPalPlus_AbstractAdapter {

	const AUTH_SPACE = 'paypalplus-auth';
	const AUTH_KEY = 'key';

	public function getToken(){
		$storage = $this->getContainer()->getStorage();
		$authKey = unserialize(base64_decode($storage->read(self::AUTH_SPACE, self::AUTH_KEY)));

		if ($this->isNewTokenRequired($authKey)) {
			$storage->lock(self::AUTH_SPACE, self::AUTH_KEY, Customweb_Storage_IBackend::EXCLUSIVE_LOCK);
			$authKey = unserialize(base64_decode($storage->read(self::AUTH_SPACE, self::AUTH_KEY)));
			if ($this->isNewTokenRequired($authKey)) {
				$this->createNewAuthenticationKey();
				$authKey = unserialize(base64_decode($storage->read(self::AUTH_SPACE, self::AUTH_KEY)));
			}
			$storage->unlock(self::AUTH_SPACE, self::AUTH_KEY);
		}

		return $authKey['accessToken'];
	}

	private function isNewTokenRequired($authKey){
		return (empty($authKey) || !isset($authKey['hash']) || !isset($authKey['timeout']) || !isset($authKey['accessToken'])) ||
				 (time() >= $authKey['timeout']) || ($authKey['hash'] != $this->getAuthenticationKeyHash());
	}

	private function createNewAuthenticationKey(){

		$request = new Customweb_Core_Http_Request($this->getConfiguration()->getRestApiUrl().'/v1/oauth2/token');

		$request->setMethod('POST');
		$request->setBody('grant_type=client_credentials');
		$request->appendHeader('Content-Type:application/x-www-form-urlencoded');
		$request->appendHeader('Accept:application/json');
		$request->setAuthorization(new Customweb_Core_Http_Authorization_Basic($this->getConfiguration()->getRestAPIClientId(), $this->getConfiguration()->getRestAPIClientSecret()));

		$client = Customweb_Core_Http_Client_Factory::createClient();
		$response = $client->send($request);

		$responseArray = json_decode($response->getBody(), true);
		if ($responseArray === false) {
			throw new Exception(Customweb_I18n_Translation::__("Invalid response received."));
		}
		if(!isset($responseArray['access_token']) || !isset($responseArray['token_type']) || !isset($responseArray['expires_in']) ) {
			throw new Exception(Customweb_I18n_Translation::__('Error retrieving acces token'));
		}
		$authKey = array(
			'hash' => $this->getAuthenticationKeyHash(),
			'timeout' => time() + $responseArray['expires_in'] - 30,
			'tokenType' => $responseArray['token_type'],
			'accessToken' => $responseArray['access_token']
		);
		$this->getContainer()->getStorage()->write(self::AUTH_SPACE, self::AUTH_KEY, base64_encode(serialize($authKey)));
	}

	/**
	 * Creates a hash to validate if the auth key can still be used (changed settings, new version etc.)
	 *
	 * @return string
	 */
	private function getAuthenticationKeyHash(){
		return hash("sha256",
				$this->getConfiguration()->getRestAPIClientId() . $this->getConfiguration()->getRestAPIClientSecret(). $this->getConfiguration()->isTestMode());
	}
}