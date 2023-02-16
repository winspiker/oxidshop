<?php
function smarty_function_oxmultilang( $params, &$smarty ) {

	//$array = get_class_methods($smarty);
	
	$langArray = $smarty->getTemplateVars('oLang');
	if ( ! is_array($langArray) ) {
		$langArray = array();
	}
    
	$sIdent  = isset( $params['ident'] ) ? $params['ident'] : 'IDENT MISSING';
	$translated = $sIdent;
	if ( array_key_exists($params['ident'], $langArray) ) {
		$translated = $langArray[$sIdent];
	}
    
    return $translated;
}
?>