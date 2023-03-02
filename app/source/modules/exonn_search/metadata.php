<?php

use OxidEsales\Eshop\Application\Controller\SearchController;
use OxidEsales\Eshop\Application\Model\Search;

$sMetadataVersion = '1.0';

/**
 * Module information
 */
$aModule = [
    'id'           => 'exonn_search',
    'title'        => 'EXONN Search engine',
    'description'  => '',
    'thumbnail'    => 'exonn_search_logo.svg',
    'version'      => '1.1',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'extend'       => [
        'search' => 'exonn_search/Controller/exonn_search_controller',
        'oxsearch' => 'exonn_search/Model/exonn_search',
    ],

    'files'       => [
        'exonn_search_livecontroller' => 'exonn_search/Controller/exonn_search_livecontroller.php',
    ],

    'events'       => [
    ],

    'templates'    => [
    ],

    'blocks'       => [
        [
            'template' => 'widget/header/search.tpl',
            'block'    => 'widget_header_search_form',
            'file'     => 'widget_header_search_form.tpl',
        ],
    ],
];