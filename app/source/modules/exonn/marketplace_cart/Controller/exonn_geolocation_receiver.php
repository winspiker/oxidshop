<?php

/**
 * Class exonn_geolocation_receiver
 */
class exonn_geolocation_receiver extends exonn_geolocation_receiver_parent
{

	const IP_SERVICE_REQUEST_URI = "http://api.ipstack.com/";

	const IP_SERVICE_API_KEY = "c5d72b1673a5868346f68d8e33c5cafc";

	// die ip, die geprüft werden soll
	private $ipv4;

	// die sprache, in der die rückgabe des API Dienstes erfolgen soll
	private $language = "de";

	/**
	 * exonn_geolocation_receiver constructor.
	 *
	 * @param $ipv4 string  die Ip die geprüft werden soll
	 */
	public function __construct ($ipv4 = null)
	{
		$this->ipv4 = $ipv4;

	}

	/**
	 * @param $ipv4 string  die ip...
	 *
	 * @return false|string
	 * @throws Exception
	 */
	public function getOxidCountryCodeByIp($ipv4 = null)
	{
		// wenn sessionwert bereits gesetzt, gebe session wert zurück
		if($this->checkIfSessionIsSet())
		{
			return $this->getSessionCountryCode();
		}

		// wenn ip übergeben wurde, in objekt speichern
		if(isset($ipv4))
		{
			$this->ipv4 = $ipv4;
		}

		// prüfen, ob ip im objekt hinterliegt
		$this->checkIfIpIsSet();

		// request bauen und abschicken
		$requestUri = $this->getBaseRequestUri();


		$ipDataJson = file_get_contents($requestUri);


//		if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//		{
//
//
//
//		echo __FILE__ . " : " . __LINE__ ."\n";
//		echo "<pre>";
//		print_r($ipDataJson);
//		echo "</pre>";
//		die();
//
//		}

		// json dekodieren und den alpha2 ländercode herausnehmen
		$location = json_decode($ipDataJson);
		$country = $location->country_code;

		// oxid eigenen ländercode ermitteln
		$oxidCountryCode = $this->getOxidCountryCode($country);


		// land in session schreiben
		$this->setSessionCountryCode($oxidCountryCode);

		return $oxidCountryCode;
	}

	/**
	 * @param $countryId
	 *
	 * @return false|string
	 * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
	 */
	private function getOxidCountryCode($countryId)
	{
		$oxidCountryCode = oxdb::getDb()->getOne("select oxid from oxcountry where oxisoalpha2 = ?", [$countryId]);

		return $oxidCountryCode;
	}


	/**
	 * @throws Exception
	 */
	public function checkIfIpIsSet()
	{
		if(!isset($this->ipv4))
		{
			throw new Exception("Fehler: Es wurde keine IP Adresse übergeben!");
		}
	}

	/**
	 * @return bool
	 */
	public function checkIfSessionIsSet()
	{
		// session prüfen, ob land bereits ermittelt wurde
		$ipCountry = $this->getSessionCountryCode();

		if($ipCountry === null)
		{
			return false;
		}

		return true;
	}

	/**
	 * @return mixed
	 */
	public function getSessionCountryCode()
	{
		return oxRegistry::getSession()->getVariable('sIpCountry');
	}

	/**
	 * @param $countryName
	 */
	public function setSessionCountryCode($countryName)
	{
		oxRegistry::getSession()->setVariable('sIpCountry', $countryName);
	}

	/**
	 * @return string
	 */
	public function getBaseRequestUri()
	{
		return self::IP_SERVICE_REQUEST_URI.$this->ipv4."?access_key=".self::IP_SERVICE_API_KEY."&language=".$this->getLanguageForResults();
	}

	/**
	 * @param string $language
	 */
	public function setLanguageForResults($language = "de")
	{
		$this->language = $language;
	}

	/**
	 * @return string
	 */
	public function getLanguageForResults()
	{
		return $this->language;
	}

}