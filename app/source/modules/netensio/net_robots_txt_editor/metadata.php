<?php

/**
 * Metadata version
 */
$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = array(
    'id' => 'net_robots_txt_editor',
    'title' => 'Netensio: Robots.txt Editor',
    'description' => array(
        'de' => 'Ermöglicht es Ihnen Anpassungen an der OXID eShop robots.txt Datei, innerhalb der OXID eShop Administration vorzunehmen.',
        'en' => 'Adds the possibility to edit the OXID eShop robots.txt file within the OXID eShop Administration.',
    ),
    'thumbnail' => 'netensio.jpg',
    'version' => '1.0.1',
    'author' => 'Netensio',
    'url' => 'https://www.netensio.de',
    'email' => 'info@netensio.de',
    'extend' => array(),
    'controllers' => array(
        'robots_txt_editor'                  => \Netensio\RobotsTxtEditor\Controller\Admin\RobotsTxtEditorController::class,
        'robots_txt_editor_list'             => \Netensio\RobotsTxtEditor\Controller\Admin\RobotsTxtEditorListController::class,
        'robots_txt_editor_main'             => \Netensio\RobotsTxtEditor\Controller\Admin\RobotsTxtEditorMain::class,
    ),
    'events' => array(),
    'templates' => array(
        'robots_txt_editor.tpl'                     => 'netensio/net_robots_txt_editor/views/admin/tpl/robots_txt_editor.tpl',
        'robots_txt_editor_list.tpl'                => 'netensio/net_robots_txt_editor/views/admin/tpl/robots_txt_editor_list.tpl',
        'robots_txt_editor_main.tpl'                => 'netensio/net_robots_txt_editor/views/admin/tpl/robots_txt_editor_main.tpl',
    ),
    'blocks' => array(),
    'settings' => array()
);