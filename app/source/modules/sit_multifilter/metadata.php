<?php
/**
 * Module information
 */
$aModule = array(
	'id'           => 'sit_multifilter',
	'title'        => 'SIT-Multifilter',
	'description'  => 'Erweiterter Filter auf Artikellisten, Suchergebnisse und Hersteller',
	'thumbnail'    => '',
	'version'      => '4.6.12',
	'email'		   => 'bestellung@shopmodul24.de',
	'url'		   => 'https://www.shopmodul24.de/',
	'author'       => 'Schwinkendorf IT Systeme',
    'extend'       => array(
		'oxseodecoder' 		=> 'sit_multifilter/sit_multifilter_oxseodecoder',
		'oxviewconfig' 		=> 'sit_multifilter/sit_multifilter_oxviewconfig',
		'oxsearch' 	   		=> 'sit_multifilter/sit_multifilter_oxsearch',
		'manufacturerlist' 	=> 'sit_multifilter/sit_multifilter_manufacturerlist',
		'alist' 			=> 'sit_multifilter/sit_multifilter_alist',
    ),
    'blocks' => array(
		array('template' => 'layout/sidebar.tpl', 'block'=>'sidebar_categoriestree', 	'file'=>'views/blocks/sit_filter_sidebar.tpl'),
    	array('template' => 'page/list/list.tpl', 'block'=>'page_list_listbody', 		'file'=>'views/blocks/sit_filter_sidebar.tpl'),
    	array('template' => 'layout/base.tpl',    'block'=>'head_meta_robots', 			'file'=>'views/blocks/sit_filter_meta_robots.tpl'),
    	array('template' => 'layout/base.tpl',    'block'=>'head_link_canonical', 		'file'=>'views/blocks/sit_filter_meta_canonical.tpl'),
    ),
    'files' => array(			
        'sit_multifilter_loader' 	   	=> 'sit_multifilter/controllers/sit_multifilter_loader.php',
    ),
    'templates'		=> array (
    	'sit_multifilter_loader.tpl' 	=> 'sit_multifilter/views/tpl/sit_multifilter_loader.tpl',
	),
);
