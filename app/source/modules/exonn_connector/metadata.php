<?php


/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_connector',
    'title'        => 'EXONN Connector Module',
    'description'  => 'Module for EXONN modules.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.2.6',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'extend'       => array(
       //'navigation'                 => 'exonn_connector/core/ec_navigation',
    ),
    'files'        => array(
        'exonn_connector_event' => 'exonn_connector/core/exonn_connector_event.php',
        'exonn_connector_main' => 'exonn_connector/controllers/admin/exonn_connector_main.php',
        'exonn_connector_shop' => 'exonn_connector/controllers/admin/exonn_connector_shop.php',
        'exonn_connector_utils' => 'exonn_connector/core/exonn_connector_utils.php',
        'exonn_connector_update' => 'exonn_connector/core/exonn_connector_update.php',
        'exonn_connector_action' => 'exonn_connector/views/exonn_connector_action.php',
        ),

    'events'       => array(
    	'onActivate' 	=> 'exonn_connector_event::onActivate',
		'onDeactivate' 	=> 'exonn_connector_event::onDeactivate',
        ),

    'templates'    => array(
        "exonn_connector_main.tpl" => "exonn_connector/views/admin/tpl/exonn_connector_main.tpl",
        "exonn_connector_shop.tpl" => "exonn_connector/views/admin/tpl/exonn_connector_shop.tpl",
        "installed_msg.tpl" => "exonn_connector/views/admin/tpl/installed_msg.tpl",
        "ec_error_msg.tpl" => "exonn_connector/views/admin/tpl/ec_error_msg.tpl",
        ),
    'settings'    => array(
    ),
);