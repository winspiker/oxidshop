<?php
namespace SIT\SITMultifilter\Application\Model;

class sit_multifilter_manufacturerlist extends sit_multifilter_manufacturerlist_parent {
	
	/**
	 * 
	 */
	function getArticleList() {
		
		$oArtListParent = parent::getArticleList();
		
	// Select all manufacturer articles
		$oManufacturer = $this->getActManufacturer();
        if ( !$oManufacturer ) {
            return $oArtListParent;
        }

		$sManufacturerId = $oManufacturer->getId();

        $oArtList = oxNew( 'oxarticlelist' );
        $oArtList->loadManufacturerIDs($sManufacturerId);
		
		$articleArray = array();
		foreach ($oArtList as $oxid) {
			// Get all article ids
			$articleArray[] = $oxid;
		}
 
		if ( class_exists("oxRegistry") && method_exists(oxRegistry, "getSession") ) {
			$session = oxRegistry::getSession();
		}
		else {
			$session = oxSession::getInstance();
		}
		
		$sessionStarted = $session->isSessionStarted();
		if ( empty($sessionStarted) ) {
	
			session_name("mfsid");
			session_start();
			setcookie("mfsid", session_id(), time()+3600, "/");
		}
		else {
			setcookie("mfsid", "", time()-3600);
			unset($_COOKIE["mfsid"]);
		}
		
		$_SESSION["sit_multifilter_manufacturerarticles"] = $articleArray;
		$_SESSION["sit_multifilter_searcharticles"] = "";
		
		return $oArtListParent;
	}
}
?>