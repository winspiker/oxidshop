<?php

/**
 * Metadata version
 */
$sMetadataVersion = '2.1';

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_livesearch',
    'title'        => 'exonn Echtzeitsuche Modul',
    'description'  => 'Das Echtzeitsuche Modul erleichtert die Suche nach dem gewünschten Produkt.',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '2.0.2',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'https://www.oxidmodule24.de/',
    'events'       => array(
        'onActivate'   => \Exonn\LiveSearch\Core\LiveSearchEvents::class . '::onActivate',
        'onDeactivate' => \Exonn\LiveSearch\Core\LiveSearchEvents::class . '::onDeactivate',
    ),
    'controllers'  => [
        'exonn_livesearch_controller' => \Exonn\LiveSearch\Application\Controller\LiveSearchController::class,
    ],
    'blocks'       => array(
        array(
            'template' => 'widget/header/search.tpl',
            'block'    => 'widget_header_search_form',
            'file'     => 'widget_header_search_form.tpl',
        ),
    ),
    'settings'     => array(
        array(
            'group' => 'EXONN_LIVESEARCH_CONFIG',
            'name'  => 'EXONN_LIVESEARCH_STATSAVE',
            'type'  => 'bool',
            'value' => false,
        ),
    )
);
