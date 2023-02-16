<?php

spl_autoload_register( function ( $sClass )
{

	$sPrefix = 'idealo\\Direktkauf\\'; 
    $sBaseDir = __DIR__ . '/idealo/Direktkauf/'; 
	$iLength = strlen( $sPrefix ); 
    
    if ( strncmp( $sPrefix, $sClass, $iLength ) !== 0 )	{ return; }

	$sRelativeClass = substr( $sClass, $iLength ); 

	$sFile = $sBaseDir . str_replace( '\\', '/', $sRelativeClass ) . '.php'; 
	if ( file_exists( $sFile ) )
	{
		require $sFile; 
    }
}
);
