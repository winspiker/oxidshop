<?php
function smarty_function_oxgetseourl( $params, &$smarty )
{
    //$sOxid = isset( $params['oxid'] ) ? $params['oxid'] : null;
    //$sType = isset( $params['type'] ) ? $params['type'] : null;
    
    $sUrl  = $sIdent = isset( $params['ident'] ) ? $params['ident'] : null;
    $sParams  = $sIdent = isset( $params['params'] ) ? $params['params'] : null;

    return $sUrl . "&" . $sParams;  
}
