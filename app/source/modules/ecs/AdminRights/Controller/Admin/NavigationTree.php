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

class NavigationTree extends NavigationTree_parent {

	protected function onGettingDomXml() {
		parent::onGettingDomXml();
		$oConfig = Registry::getConfig();
		$oUser = $this->getUser();
		$sUserID = $oUser->getID();
		$sUserArID = 'ar_' . $sUserID;
		if ($sUserID && $oConfig->getConfigParam($sUserArID))
			$this->_checkRightsDenials($this->_oDom, $sUserArID);
	}

	protected function _checkRightsDenials($dom, $sUserArID) {
		$oConfig = Registry::getConfig();
		$oXPath = new \DomXPath($dom);
		$nodeList = $oXPath->query("//MAINMENU | //SUBMENU | //SUBMENU/TAB");
		$aUserRightsConfig = $oConfig->getConfigParam($sUserArID);
		foreach ($nodeList as $oNode) {
			$checkforid = $oNode->getAttribute('id');
			if ($checkforid && in_array($checkforid, $aUserRightsConfig))
				$oNode->parentNode->removeChild($oNode);
		}
	}

}