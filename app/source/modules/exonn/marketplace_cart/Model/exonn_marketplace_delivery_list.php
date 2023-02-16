<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 07.09.2020
 * Time: 13:58
 */

class exonn_marketplace_delivery_list extends exonn_marketplace_delivery_list_parent
{
	/**
	 * * EXONN: Klasse um Funktionalität erweitert ->
	 *      Wenn der Benutzer nicht eingeloggt ist, wird ein Fakebenutzer erstellt und dem
	 *      Warenkorb zugewiesen. Dieser bekommt lediglich das Land über die IP Adresse ermittelt
	 *      zugewiesen und ist kein vollwertiges Userobjekt.
	 *
	 *      Wenn später die Login-Abfrage gestellt wird, ist der Fake Benutzer bereits wieder
	 *      irrelevant. Die SQL-Query wird um die Benutzerverknüpfungen verkürzt, solange der
	 *      Benutzer noch nicht eingeloggt ist. Somit bekommt ein nicht eingeloggter Benutzer
	 *      Zugriff auf die Versandkostenregeln.
	 *
	 * Returns active delivery list
	 *
	 * Loads all active delivery in list. Additionally
	 * checks if set has user customized parameters like
	 * assigned users, countries or user groups. Performs
	 * additional filtering according to these parameters
	 *
	 * @param \OxidEsales\Eshop\Application\Model\User $oUser      session user object
	 * @param string                                   $sCountryId user country id
	 * @param string                                   $sDelSet    user chosen delivery set
	 *
	 * @return exonn_marketplace_delivery_list
	 * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
	 */
	protected function _getList($oUser = null, $sCountryId = null, $sDelSet = null)
	{

		// checking for current session user which gives additional restrictions for user itself, users group and country
		if ($oUser === null)
		{
			$oUser = $this->getUser();
		}
		else
		{
			//set user
			$this->setUser($oUser);
		}

		/**
		 * EXONN Anpassung:
		 *
		 * Hier muss auf $oUser->getId() gefragt werden, da das $oUser Objekt
		 * ggf. gefaked werden musste. Eine Id hat das gefakete Objekt aber nicht.
	    */
		$sUserId = (is_object($oUser) && $oUser->getId()) ? $oUser->getId() : '';

		//	    if($_SERVER['REMOTE_ADDR'] == "87.166.113.119")
		//	    {
		//		    echo __FILE__ . " : " . __LINE__ ."\n";
		//		    echo "<pre>";
		//		    print_r($oUser->getActiveCountry());
		//		    echo "</pre>";
		////		    die();
		//	    }

		// choosing delivery country if it is not set yet
		if (!$sCountryId)
		{
			if ($oUser)
			{
				$sCountryId = $oUser->getActiveCountry();
				/**
				 * EXONN Anpassung:
				 *
				 * Weil das Benutzerobjekt gefaked sein könnte, muss hier nochmal
				 * separat geprüft werden, ob die ID gesetzt wurde...
				 * Falls nicht wird das über die IP ermittelte Land als oxid ID
				 * zugewiesen.
				 */
				if(!($sCountryId))
				{
					$sCountryId = $oUser->oxuser__oxcountryid->value;
				}

			}
			else
			{
				$sCountryId = $this->_sHomeCountry;
			}
		}


		if (($sUserId . $sCountryId . $sDelSet) !== $this->_sUserId)
		{
			/**
			 * EXONN Anpassung:
			 *
			 * die Methode _getFilterSelect() wurde angepasst, siehe unten...
			 */
			$this->selectString($this->_getFilterSelect($oUser, $sCountryId, $sDelSet));
			$this->_sUserId = $sUserId . $sCountryId . $sDelSet;
		}


		//	    if($_SERVER['REMOTE_ADDR'] == "87.166.113.119")
		//	    {
		//		    echo __FILE__ . " : " . __LINE__ ."\n";
		//		    echo "<pre>";
		//		    print_r($this->_getFilterSelect($oUser, $sCountryId, $sDelSet));
		//		    echo "</pre>";
		//		    die();
		//	    }

		$this->rewind();

		return $this;
	}

	/**
	 * EXONN Anpassungen:
	 *
	 *      Es wird nun je nachdem, ob eine BenutzerId vorhanden ist (Echter eingeloggter Benutzer)
	 *      oder der Benutzer gefaked wurde die SQL-Query um die Benutzerverknüpfungen verkürzt.
	 *
	 * Creates delivery list filter SQL to load current state delivery list
	 *
	 * @param \OxidEsales\Eshop\Application\Model\User $oUser      session user object
	 * @param string                                   $sCountryId user country id
	 * @param string                                   $sDelSet    user chosen delivery set
	 *
	 * @return string
	 * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
	 */
	protected function _getFilterSelect($oUser, $sCountryId, $sDelSet)
	{
		$oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();

		$sTable = getViewName('oxdelivery');
		$sQ = "select $sTable.* from ( select distinct $sTable.* from $sTable left join oxdel2delset on oxdel2delset.oxdelid=$sTable.oxid ";
		$sQ .= "where " . $this->getBaseObject()->getSqlActiveSnippet() . " and oxdel2delset.oxdelsetid = " . $oDb->quote($sDelSet) . " ";

		// defining initial filter parameters
		$sUserId = null;
		$aGroupIds = [];

		// checking for current session user which gives additional restrictions for user itself, users group and country
		if ($oUser)
		{
			// user ID
			$sUserId = $oUser->getId();
			// user groups ( maybe would be better to fetch by function \OxidEsales\Eshop\Application\Model\User::getUserGroups() ? )
			$aGroupIds = $oUser->getUserGroups();
		}

		$aIds = [];
		if (count($aGroupIds))
		{
			foreach ($aGroupIds as $oGroup)
			{
				$aIds[] = $oGroup->getId();
			}
		}

		$sUserTable = getViewName('oxuser');
		$sGroupTable = getViewName('oxgroups');
		$sCountryTable = getViewName('oxcountry');

		$sCountrySql = $sCountryId ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxcountry' and oxobject2delivery.OXOBJECTID=" . $oDb->quote($sCountryId) . ")" : '0';
		$sUserSql = $sUserId ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxuser' and oxobject2delivery.OXOBJECTID=" . $oDb->quote($sUserId) . ")" : '0';
		$sGroupSql = count($aIds) ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxgroups' and oxobject2delivery.OXOBJECTID in (" . implode(', ', \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quoteArray($aIds)) . ") )" : '0';

		$sQ .= " order by $sTable.oxsort asc ) as $sTable where (
            select
                if(EXISTS(select 1 from oxobject2delivery, $sCountryTable where $sCountryTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxcountry' LIMIT 1),
                    $sCountrySql,
                    1)";
		/**
		 * EXONN Anpassung:
		 *
		 * Je nachdem, ob Benutzer echt oder wegen Landesermittlung gefaked wird hier
		 * die Query um die Benutzerverknüpfungen verkürzt.
		 */
	if($sUserId !== null)
		{
			$sQ .= "&&
                if(EXISTS(select 1 from oxobject2delivery, $sUserTable where $sUserTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxuser' LIMIT 1),
                    $sUserSql,
                    1) &&
                if(EXISTS(select 1 from oxobject2delivery, $sGroupTable where $sGroupTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxgroups' LIMIT 1),
                    $sGroupSql,
                    1)";
		}

		$sQ .= ")";

		$sQ .= " order by $sTable.oxsort asc ";

		return $sQ;
	}
}