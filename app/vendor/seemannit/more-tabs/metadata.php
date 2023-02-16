<?php

$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = [
    'id' => 'article_moretabs',
    'title' => 'More Tabs',
    'author'       => 'Marten Seemann',
    'url'          => 'https://shop.oxid-responsive.com',
    'version'      => '4.0',
    'description'  => [
        'de' => 'mehrere Tabs auf der Artikel-Detailsseite anzeigen',
        'en' => 'show multiple tabs on the product detail page',
    ],
    'blocks'       => [
        [
            "template" => "page/details/inc/tabs.tpl",
            "block" => "details_tabs_longdescription",
            "file" => "/Application/views/blocks/tabs_description.tpl"
        ],
        [
            "template" => "page/details/inc/tabs.tpl",
            "block" => "details_tabs_attributes",
            "file" => "/Application/views/blocks/tabs_attributes.tpl"
        ],
        [
            "template" => "page/details/inc/tabs.tpl",
            "block" => "details_tabs_pricealarm",
            "file" => "/Application/views/blocks/tabs_pricealarm.tpl"
        ],
        [
            "template" => "page/details/inc/tabs.tpl",
            "block" => "details_tabs_tags",
            "file" => "/Application/views/blocks/tabs_tags.tpl"
        ],
        [
            "template" => "page/details/inc/tabs.tpl",
            "block" => "details_tabs_media",
            "file" => "/Application/views/blocks/tabs_media.tpl"
        ],
    ],
    'extend' => [
        \OxidEsales\Eshop\Application\Model\Article::class => \SeemannIT\MoreTabsModule\Application\Model\Article::class,
        \OxidEsales\Eshop\Core\Language::class => \SeemannIT\MoreTabsModule\Core\Language::class,
    ],
    'controllers' => [
        'article_moretabs' => \SeemannIT\MoreTabsModule\Application\Controller\Admin\AdminDetailsController::class,
    ],
    'templates' => [
        'article_moretabs.tpl' => 'seemannit/moretabs/Application/views/blocks/admin/article_moretabs.tpl',
    ],
    'events'      => [
        'onActivate'   => '\SeemannIT\MoreTabsModule\Core\Events::onActivate',
    ],
];
