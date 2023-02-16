<?php
function smarty_modifier_oxmultilangassign( $sIdent, $langArray = array() ) {
	
	$translated = $sIdent;
	if ( array_key_exists($sIdent, $langArray) ) {
		$translated = $langArray[$sIdent];
	}
    
    return $translated;
}
