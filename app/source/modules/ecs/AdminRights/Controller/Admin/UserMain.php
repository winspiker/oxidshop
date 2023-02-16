<?php

/*
*   *********************************************************************************************
*      Please retain this copyright header in all versions of the software.
*      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
*
*      Copyright (C) Josef A. Puckl | eComStyle.de
*      All rights reserved - Alle Rechte vorbehalten
*
*      This commercial product must be properly licensed before being used!
*      Please contact info@ecomstyle.de for more information.
*
*      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
*      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
*   *********************************************************************************************
*/
namespace Ecs\AdminRights\Controller\Admin;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Application\Model\User;

class UserMain extends UserMain_parent {

	public function save() {
		$oConfig = Registry::getConfig();
		$oUser = $this->getUser();
		$sUserID = $oUser->getID();
		$sUserArID = 'ar_' . $sUserID;
		$aParamsAr = $oConfig->getConfigParam($sUserArID);
		$sParamsAr = $aParamsAr['ecs_adminrights_menu'];
		if ($sParamsAr) {
			$aEditParams = $oConfig->getRequestParameter("editval");
			$sEditUsersoxId = $this->getEditObjectId();
			$oEditUser = oxNew(User::class);
			if ($oEditUser != "-1")
				$oEditUser->load($sEditUsersoxId);
			if ($oEditUser->oxuser__oxrights->value == 'malladmin' or $aEditParams['oxuser__oxrights'] == 'malladmin')
				return false;
		}
		return parent::save();
	}

}
