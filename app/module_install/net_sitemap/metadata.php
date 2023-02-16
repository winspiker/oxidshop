<?php

/**
 * Metadata version
 */
$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = array(
    'id' => 'net_sitemap',
    'title' => 'Netensio: Google XML Sitemap',
    'description' => array(
        'de' => 'Diese Erweiterung ermöglicht die Konfiguration und den Abruf der Google XML Sitemap.',
        'en' => 'This extension adds the possibility to configure and request the Google XML sitemap.',
    ),
    'thumbnail' => 'netensio.jpg',
    'version' => '1.0.0',
    'author' => 'Netensio',
    'url' => 'https://www.netensio.de',
    'email' => 'info@netensio.de',
    'extend' => array(
    ),
    'controllers' => array(
        'net_sitemap_article'           => \Netensio\Sitemap\Controller\Admin\SitemapArticleController::class,
        'net_sitemap_category'          => \Netensio\Sitemap\Controller\Admin\SitemapCategoryController::class,
        'net_sitemap_content'           => \Netensio\Sitemap\Controller\Admin\SitemapContentController::class,
        'net_sitemap_manufacturer'      => \Netensio\Sitemap\Controller\Admin\SitemapManufacturerController::class,
    ),
    'events' => array(
        'onActivate'   => '\Netensio\Sitemap\Core\Events::onActivate',
    ),
    'templates' => array(
        'net_sitemap_article.tpl'       => 'netensio/net_sitemap/views/admin/tpl/net_sitemap_article.tpl',
        'net_sitemap_category.tpl'      => 'netensio/net_sitemap/views/admin/tpl/net_sitemap_category.tpl',
        'net_sitemap_content.tpl'       => 'netensio/net_sitemap/views/admin/tpl/net_sitemap_content.tpl',
        'net_sitemap_manufacturer.tpl'  => 'netensio/net_sitemap/views/admin/tpl/net_sitemap_manufacturer.tpl',
    ),
    'blocks' => array(
    ),
    'settings' => array(
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolArticle', 'type' => 'bool',  'value' => true),
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolCategory', 'type' => 'bool',  'value' => true),
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolContent', 'type' => 'bool',  'value' => true),
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolManufact', 'type' => 'bool',  'value' => true),

        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolVariants', 'type' => 'bool',  'value' => false),
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolPagination', 'type' => 'bool',  'value' => false),
        array('group' => 'NETSITEMAPGCFG', 'name' => 'blNetSitemapBoolHiddenCats', 'type' => 'bool',  'value' => false),

        array('group' => 'NETSITEMAPICFG', 'name' => 'sNetSmpStaticCF', 'type' => 'select', 'constraints' => 'always|hourly|daily|weekly|monthly|yearly|never', 'value' => 'daily' ),
        array('group' => 'NETSITEMAPICFG', 'name' => 'sNetSmpArticleCF', 'type' => 'select', 'constraints' => 'always|hourly|daily|weekly|monthly|yearly|never', 'value' => 'daily' ),
        array('group' => 'NETSITEMAPICFG', 'name' => 'sNetSmpCategoryCF', 'type' => 'select', 'constraints' => 'always|hourly|daily|weekly|monthly|yearly|never', 'value' => 'daily' ),
        array('group' => 'NETSITEMAPICFG', 'name' => 'sNetSmpContentCF', 'type' => 'select', 'constraints' => 'always|hourly|daily|weekly|monthly|yearly|never', 'value' => 'daily' ),
        array('group' => 'NETSITEMAPICFG', 'name' => 'sNetSmpManufactCF', 'type' => 'select', 'constraints' => 'always|hourly|daily|weekly|monthly|yearly|never', 'value' => 'daily' ),

        array('group' => 'NETSITEMAPPCFG', 'name' => 'sNetSmpStaticPrio', 'type' => 'select', 'constraints' => '0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1.0', 'value' => '' ),
        array('group' => 'NETSITEMAPPCFG', 'name' => 'sNetSmpArticlePrio', 'type' => 'select', 'constraints' => '0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1.0', 'value' => '' ),
        array('group' => 'NETSITEMAPPCFG', 'name' => 'sNetSmpCategoryPrio', 'type' => 'select', 'constraints' => '0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1.0', 'value' => '' ),
        array('group' => 'NETSITEMAPPCFG', 'name' => 'sNetSmpContentPrio', 'type' => 'select', 'constraints' => '0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1.0', 'value' => '' ),
        array('group' => 'NETSITEMAPPCFG', 'name' => 'sNetSmpManufactPrio', 'type' => 'select', 'constraints' => '0.1|0.2|0.3|0.4|0.5|0.6|0.7|0.8|0.9|1.0', 'value' => '' ),

        array('group' => 'NETSITEMAPEXCLUDECFG', 'name' => 'aNetSitemapExlude', 'type' => 'arr',  'value' => ''),

        array('group' => 'NETSITEMAPEXPORTCFG', 'name' => 'sNetSitemapTicksize', 'type' => 'str',  'value' => '100'),

        array('group' => 'NETSITEMAPEXTCFG', 'name' => 'sNetExternalSitemap', 'type' => 'arr',  'value' => ''),


    )
);