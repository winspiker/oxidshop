<?php


/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_sengines',
    'title'        => 'EXONN Google Merchant Modul',
    'description'  => 'Das Modul versorgt Google Shopping täglich mit aktuellen Informationen über Ihre Produkte.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '2.1.5932',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'extend'       => array(
        'oxarticle' => 'exonn_sengines/core/exonn_google_oxarticle',
    ),
    'files'        => array(
        'exonn_sengines_export' => 'exonn_sengines/controllers/exonn_sengines_export.php',
        'article_sengines' => 'exonn_sengines/controllers/admin/article_sengines.php',
        'category_sengines' => 'exonn_sengines/controllers/admin/category_sengines.php',
        'exonn_googlem' => 'exonn_sengines/core/exonn_googlem.php',
        'exonn_sengines_event' => 'exonn_sengines/core/exonn_sengines_event.php',
        ),

    'events'       => array(
    	'onActivate' 	=> 'exonn_sengines_event::onActivate',
		'onDeactivate' 	=> 'exonn_sengines_event::onDeactivate',
        ),
    'templates'    => array(
        "article_sengines.tpl" => "exonn_sengines/views/admin/tpl/article_sengines.tpl",
        "category_sengines.tpl" => "exonn_sengines/views/admin/tpl/category_sengines.tpl",
        ),
    'blocks'       => array(
        array('template' => 'deliveryset_main.tpl', 'block'=>'admin_deliveryset_main_form', 'file'=>'/views/blocks/admin_deliveryset_main_form.tpl'),
        array('template' => 'country_main.tpl', 'block'=>'admin_country_main_form', 'file'=>'/views/blocks/country_main_block.tpl'),
    ),
    'settings' => array(
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_NETTOPRICE', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_PICDIR', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_ALTITLE', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_VARTITLE', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_ADDPARAM', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_USE_AMOUNT_PRICE', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_OFF_SHIPPING', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_METATAGS_DESCRIPTION', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_MAIN', 'name' => 'EXONN_SENGINES_ONE_IMAGE_ONLY', 'type' => 'bool',  'value' => 'false'),
        array('group' => 'EXONN_SENGINES_VARIANTEN', 'name' => 'EXONN_SENGINES_VARCOLOR', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_VARIANTEN', 'name' => 'EXONN_SENGINES_VARSIZE', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_VARIANTEN', 'name' => 'EXONN_SENGINES_VARPATTERN', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_VARIANTEN', 'name' => 'EXONN_SENGINES_VARMATERIAL', 'type' => 'str',  'value' => ''),
        array('group' => 'EXONN_SENGINES_AVAILABLE', 'name' => 'EXONN_SENGINES_IN_STOCK', 'type' => 'num',  'value' => '1'),
        array('group' => 'EXONN_SENGINES_AVAILABLE', 'name' => 'EXONN_SENGINES_OUT_OF_STOCK', 'type' => 'num',  'value' => '0'),
    ),
    'settings'    => [
	    [
		    'group' => 'exonn_sengines_settings',
		    'name' => 'iGoogleMerchantFeedProductTitleLength',
		    'type' => 'num',
		    'value' => '255'
	    ]]
);