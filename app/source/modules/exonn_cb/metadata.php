<?php


/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_cb',
    'title'        => 'EXONN Content Builder',
    'description'  => 'Content Builder.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'lang'         => 'de',

    'events'       => array(
    	'onActivate' 	=> 'exonn_cb_event::onActivate',
		'onDeactivate' 	=> 'exonn_cb_event::onDeactivate',
        ),

    'extend'       => array(
        'content' => 'exonn_cb/core/cb_content',
        'oxarticle' => 'exonn_cb/core/cb_oxarticle',
        'details' => 'exonn_cb/core/cb_details',
        'start' => 'exonn_cb/core/cb_start',
        'contact' => 'exonn_cb/core/cb_contact',
        'alist' => 'exonn_cb/core/cb_alist',
    ),

    'files'        => array(
        'exonn_cb_main' => 'exonn_cb/core/exonn_cb_main.php',
        'exonn_cb_content' => 'exonn_cb/core/exonn_cb_content.php',
        'exonn_cb_event' => 'exonn_cb/core/exonn_cb_event.php',

        ),

    'templates'    => array(
        "snippets.tpl" => "exonn_cb/out/front/snippets.tpl",
        ),

    'blocks' => array(
        array('template' => 'layout/base.tpl',    'block' => 'base_style',  	'file' => 'base_style.tpl'),
        array('template' => 'layout/base.tpl',    'block' => 'base_js',  	'file' => 'base_js.tpl'),
        array('template' => 'page/list/list.tpl',    'block' => 'page_list_listbody',  	'file' => 'page_list_listbody.tpl'),
	),
    'settings' => array(
    )
);