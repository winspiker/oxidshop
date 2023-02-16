<?php

/**
 * Metadata version
 */
$sMetadataVersion = '2.1';

/**
 * Module information
 */
$aModule = [
    'id'          => 'exonn_mlsearch',
    'title'       => 'exonn Multilangual Search',
    'description' => 'Allows a search query to query all activated languages',
    'thumbnail'   => 'exonn_logo.png',
    'version'     => '1.0.2',
    'author'      => 'EXONN',
    'email'       => 'info@exonn.de',
    'url'         => 'http://www.oxidmodule24.de/',
    'extend'      => [
        \OxidEsales\Eshop\Application\Model\Search::class => \Exonn\MultilangualSearch\Application\Model\Search::class,
    ],
    'settings'    => [
        [
            'group' => 'main',
            'name'  => 'bExonnSearchInVariants',
            'type'  => 'bool',
            'value' => false,
        ],
    ],
];
