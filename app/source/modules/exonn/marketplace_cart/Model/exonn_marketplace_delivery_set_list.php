<?php
/**
 * Created by PhpStorm.
 * User: Ben
 * Date: 07.09.2020
 * Time: 14:13
 */

class exonn_marketplace_delivery_set_list extends exonn_marketplace_delivery_set_list_parent
{
	/**
	 * EXONN Anpassungen:
	 *
	 * Je nachdem ob der Benutzer echt oder gefaked ist, wird hier die Query um die
	 * Benutzerverknüpfungen verkürzt.
	 *
	 * Creates delivery set list filter SQL to load current state delivery set list
	 *
	 * @param \OxidEsales\Eshop\Application\Model\User $oUser      user object
	 * @param string                                   $sCountryId user country id
	 *
	 * @return string
	 * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
	 */
	protected function _getFilterSelect($oUser, $sCountryId)
	{
		$sTable = getViewName('oxdeliveryset');
		$sQ = "select $sTable.* from $sTable ";
		$sQ .= "where " . $this->getBaseObject()->getSqlActiveSnippet() . ' ';

		// defining initial filter parameters
		$sUserId = null;
		$aGroupIds = [];

		// checking for current session user which gives additional restrictions for user itself, users group and country
		if ($oUser) {
			// user ID
			$sUserId = $oUser->getId();

			// user groups ( maybe would be better to fetch by function \OxidEsales\Eshop\Application\Model\User::getUserGroups() ? )
			$aGroupIds = $oUser->getUserGroups();
		}

		$aIds = [];
		if (count($aGroupIds)) {
			foreach ($aGroupIds as $oGroup) {
				$aIds[] = $oGroup->getId();
			}
		}

		$sUserTable = getViewName('oxuser');
		$sGroupTable = getViewName('oxgroups');
		$sCountryTable = getViewName('oxcountry');

		$oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();

		$sCountrySql = $sCountryId ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelset' and oxobject2delivery.OXOBJECTID=" . $oDb->quote($sCountryId) . ")" : '0';
		$sUserSql = $sUserId ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelsetu' and oxobject2delivery.OXOBJECTID=" . $oDb->quote($sUserId) . ")" : '0';
		$sGroupSql = count($aIds) ? "EXISTS(select oxobject2delivery.oxid from oxobject2delivery where oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelsetg' and oxobject2delivery.OXOBJECTID in (" . implode(', ', \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quoteArray($aIds)) . ") )" : '0';

		$sQ .= "and (
            select
                if(EXISTS(select 1 from oxobject2delivery, $sCountryTable where $sCountryTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelset' LIMIT 1),
                    $sCountrySql,
                    1)";
		/**
		 * EXONN Anpassung:
		 *
		 * falls der Benutzer nicht eingeloggt ist, wird die Query um die Benutzerverknüpfungen verkürzt.
		 */
		if($sUserId !== null)
		{
			$sQ .= " &&
                if(EXISTS(select 1 from oxobject2delivery, $sUserTable where $sUserTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelsetu' LIMIT 1),
                    $sUserSql,
                    1) &&
                if(EXISTS(select 1 from oxobject2delivery, $sGroupTable where $sGroupTable.oxid=oxobject2delivery.oxobjectid and oxobject2delivery.oxdeliveryid=$sTable.OXID and oxobject2delivery.oxtype='oxdelsetg' LIMIT 1),
                    $sGroupSql,
                    1)";

		}
		$sQ .= ")";

		//order by
		$sQ .= " order by $sTable.oxpos";

//	    if($_SERVER['REMOTE_ADDR'] == "79.213.57.123")
//	    {
//	        echo __FILE__ . " : " . __LINE__ ."\n";
//	        echo "<pre>";
//	        var_dump($sUserId);
//	        print_r($sQ);
//
//	        echo "</pre>";
//	        die();
//	    }


		return $sQ;
	}
}