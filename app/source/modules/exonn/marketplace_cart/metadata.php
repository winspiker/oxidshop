<?php

$sMetadataVersion = '1.1';

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_marketplace_cart',
    'title'        => 'EXONN: Marktplatz Warenkorb Modul',
    'description'  => '',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN: Benjamin Brunner',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'extend'       => array(
	    'oxubase'               => 'exonn/marketplace_cart/Controller/exonn_geolocation_receiver',
	    'basket'                => 'exonn/marketplace_cart/Controller/exonn_marketplace_basket_controller',
	    'oxbasket'              => 'exonn/marketplace_cart/Model/exonn_marketplace_basket',
	    'oxarticle'             => 'exonn/marketplace_cart/Model/exonn_marketplace_article',
	    'oxdeliverylist'        => 'exonn/marketplace_cart/Model/exonn_marketplace_delivery_list',
	    'oxdeliverysetlist'     => 'exonn/marketplace_cart/Model/exonn_marketplace_delivery_set_list',
    ),
    'events'       => array(
    	'onActivate' 	=> 'exonn_marketplace_cart_event::onActivate',
		'onDeactivate' 	=> 'exonn_marketplace_cart_event::onDeactivate',
    ),
    'templates'    => array(
//        'exonn_delext_configs.tpl' => 'exonn/exonn_deliveryplus/views/admin/exonn_delext_configs.tpl',
    ),

	'files' => [

	],

    'blocks' => array(
        array('template' => 'productmain.tpl', 'block'=>'details_productmain_artnumber', 'file'=>'/views/blocks/details_productmain_artnumber.tpl'),
        array('template' => 'basketcontents_table.tpl', 'block'=>'dd_checkout_inc_basketcontents_table_item_desc', 'file'=>'/views/blocks/dd_checkout_inc_basketcontents_table_item_desc.tpl'),
    )
);