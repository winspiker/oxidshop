<?php
/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_livesearch_v1',
    'title'        => 'EXONN Echtzeitsuche Modul v1',
    'description'  => 'Das Echtzeitsuche Modul erleichtert die Suche nach dem gewünschten Produkt.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0.5',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',
    'events'       => array(
    	'onActivate' 	=> 'livesearch_event::onActivate',
		'onDeactivate' 	=> 'livesearch_event::onDeactivate',
        ),
    'extend'       => array(

    ),
    'blocks' => array(
		array('template' => 'page/search/search.tpl',    'block' => 'search_results',  	'file' => 'widget_header_search_result.tpl'),
        array('template' => 'widget/header/search.tpl',    'block' => 'widget_header_search_form',  	'file' => 'widget_header_search_form.tpl'),
       	),

    'files'        => array(
        'livesearch_event' => 'exonn_livesearch/core/livesearch_event.php',
        'exonnsearch' => 'exonn_livesearch/core/exonnsearch.php',
    ),

    'settings' => array(
        array('group' => 'EXONN_LIVESEARCH_CONFIG', 'name' => 'EXONN_LIVESEARCH_STATSAVE', 'type' => 'bool',  'value' => false),
    )

);