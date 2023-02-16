<?php

/**
 * exonn Livesearch module metadata
 *
 * @package exonn/livesearch
 */

use Exonn\LiveSearch\Application\Controller\LiveSearchController;
use Exonn\LiveSearch\Application\Model\LiveSearch;
use Exonn\LiveSearch\Core\Events;
use OxidEsales\Eshop\Application\Model\Search;

/**
 * Metadata version
 */
$sMetadataVersion = '2.1';

/**
 * Module information
 */
$aModule = array(
    'id'           => 'exonn_livesearch',
    'title'        => array(
        'de' => 'exonn Echtzeitsuche Modul',
        'en' => 'exonn Livesearch Module',
    ),
    'description'  => array(
        'de' => 'Das Echtzeitsuche Modul erleichtert die Suche nach dem gewünschten Produkt.',
        'en' => 'The livesearch module makes it easier for you customers to find the desired product',
    ),
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '2.0.2',
    'author'       => 'exonn',
    'email'        => 'info@exonn.de',
    'url'          => 'https://www.oxidmodule24.de/',
    'events'       => array(
        'onActivate'   => Events::class . '::onActivate',
        'onDeactivate' => Events::class . '::onDeactivate',
    ),
    'extend'       => array(
        Search::class => LiveSearch::class,
    ),
    'controllers'  => [
        'exonn_livesearch_controller' => LiveSearchController::class,
    ],
    'blocks'       => array(
        array(
            'template' => 'widget/header/search.tpl',
            'block'    => 'widget_header_search_form',
            'file'     => '/views/blocks/widget_header_search_form.tpl',
        ),
        array(
            'template' => 'page/search/search.tpl',
            'block'    => 'search_header',
            'file'     => '/views/blocks/page_search_search_header.tpl',
        ),
    ),
    'settings'     => array(
        array(
            'group' => 'EXONN_LIVESEARCH_CONFIG',
            'name'  => 'EXONN_LIVESEARCH_STATSAVE',
            'type'  => 'bool',
            'value' => false,
        ),
        array(
            'group' => 'EXONN_LIVESEARCH_CONFIG',
            'name'  => 'EXONN_LIVESEARCH_SEARCH_ICON_CLASSES',
            'type'  => 'str',
            'value' => 'fa fa-search',
        ),
    )
);
