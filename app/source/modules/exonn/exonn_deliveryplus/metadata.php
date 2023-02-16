<?php

$sMetadataVersion = '1.0';

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_deliveryplus',
    'title'        => 'EXONN Versand Erweiterung+',
    'description'  => '',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'extend'       => array(
        'oxorder' => 'exonn/exonn_deliveryplus/core/exonn_delext_oxorder',
        'oxdeliverylist' => 'exonn/exonn_deliveryplus/core/exonn_delext_oxdeliverylist',
        'oxdelivery' => 'exonn/exonn_deliveryplus/core/exonn_delext_oxdelivery',
        'oxarticle' => 'exonn/exonn_deliveryplus/core/exonn_delext_oxarticle',
        'article_extend' => 'exonn/exonn_deliveryplus/controllers/exonn_delext_article_extend',
        'order_overview' => 'exonn/exonn_deliveryplus/controllers/exonn_delext_order_overview',
    ),

    'files'        => array(
        'exonn_deliveryplus_event' => 'exonn/exonn_deliveryplus/core/exonn_deliveryplus_event.php',
        'exonn_delext_labels' => 'exonn/exonn_deliveryplus/core/exonn_delext_labels.php',
        'oxdeliverylabel' => 'exonn/exonn_deliveryplus/core/oxdeliverylabel.php',
        'exonn_delext_info' => 'exonn/exonn_deliveryplus/controllers/exonn_delext_info.php',
        'exonn_delext_configs' => 'exonn/exonn_deliveryplus/controllers/exonn_delext_configs.php',
    ),

    'events'       => array(
    	'onActivate' 	=> 'exonn_deliveryplus_event::onActivate',
		'onDeactivate' 	=> 'exonn_deliveryplus_event::onDeactivate',
    ),

    'templates'    => array(
        'exonn_delext_configs.tpl' => 'exonn/exonn_deliveryplus/views/admin/exonn_delext_configs.tpl',
    ),


    'blocks' => array(
        array('template' => 'order_overview.tpl', 'block'=>'admin_order_overview_send_form', 'file'=>'admin_order_overview_send_form.tpl'),
        array('template' => 'delivery_main.tpl', 'block'=>'admin_delivery_main_form', 'file'=>'admin_delivery_main_form.tpl'),
        array('template' => 'country_main.tpl', 'block'=>'admin_country_main_form', 'file'=>'admin_country_main_form.tpl'),
        array('template' => 'order_overview.tpl', 'block'=>'admin_order_processing_body', 'file'=>'admin_order_processing_body.tpl'),
    )
);