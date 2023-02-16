<?php
/**
 * Module information
 */
$aModule = array(
	'id'           => 'sit_module_framework',
    'title'        => 'SIT-Module-Framework',
    'description'  => 'Framework für SIT-Module',
    'thumbnail'    => '',
    'version'      => '1.1.2',
    'email'		   => 'bestellung@shopmodul24.de',
    'url'		   => 'http://www.shopmodul24.de/',
    'author'       => 'Schwinkendorf IT Systeme',
    'extend'       => array(),
    'blocks' 	   => array(),			
	'files' => array(
        'sit_module_framework' 		=> 'sit_module_framework/controllers/admin/sit_module_framework.php',
        'sit_module_framework_shop' => 'sit_module_framework/controllers/admin/sit_module_framework_shop.php'
    ),
    'templates'		=> array (
		'sit_module_framework.tpl' 		=> 'sit_module_framework/views/admin/tpl/sit_module_framework.tpl',
		'sit_module_framework_shop.tpl' => 'sit_module_framework/views/admin/tpl/sit_module_framework_shop.tpl'
	),
);
?>