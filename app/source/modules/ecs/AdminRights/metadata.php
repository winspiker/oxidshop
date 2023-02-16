<?php
/*
 *   *********************************************************************************************
 *      Please retain this copyright header in all versions of the software.
 *      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
 *
 *      Copyright (C) Josef A. Puckl | eComStyle.de
 *      All rights reserved - Alle Rechte vorbehalten
 *
 *      This commercial product must be properly licensed before being used!
 *      Please contact info@ecomstyle.de for more information.
 *
 *      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
 *      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
 *   *********************************************************************************************
 */

$sMetadataVersion       = '2.0';
$aModule                = [
    'id'                => 'ecs_adminrights',
    'title'             => '<strong style="color:#04B431;">e</strong><strong>ComStyle.de</strong>:  <i>AdminRights</i>',
    'description'       => 'Admin Rechteverwaltung',
    'version'           => '2.0.5',
    'thumbnail'         => 'ecs.png',
    'author'            => '<strong style="font-size: 17px;color:#04B431;">e</strong><strong style="font-size: 16px;">ComStyle.de</strong>',
    'email'             => 'info@ecomstyle.de',
    'url'               => 'https://ecomstyle.de',
    'extend' => [
        \OxidEsales\Eshop\Application\Controller\Admin\NavigationTree::class    => Ecs\AdminRights\Controller\Admin\NavigationTree::class,
        \OxidEsales\Eshop\Application\Controller\Admin\UserMain::class          => Ecs\AdminRights\Controller\Admin\UserMain::class,
        \OxidEsales\Eshop\Application\Model\Order::class                        => Ecs\AdminRights\Model\Order::class,
        \OxidEsales\Eshop\Application\Model\User::class                         => Ecs\AdminRights\Model\User::class,
        \OxidEsales\Eshop\Application\Model\Article::class                      => Ecs\AdminRights\Model\Article::class,
    ],
    'controllers' => [
        'ar_settings' => \Ecs\AdminRights\Controller\Admin\AdminSettings::class,
    ],
    'templates' => [
        'ar_settings.tpl' => 'ecs/AdminRights/views/admin/tpl/ar_settings.tpl'
    ],
    'blocks' => [
        ['template' => 'order_overview.tpl', 'block' => 'admin_order_overview_folder_form', 'file' => '/views/blocks/adminright_block.tpl', 'position' => '999'],
        ['template' => 'order_overview.tpl', 'block' => 'admin_order_overview_general',     'file' => '/views/blocks/adminright_block.tpl', 'position' => '999'],
        ['template' => 'order_overview.tpl', 'block' => 'admin_order_overview_send_form',   'file' => '/views/blocks/adminright_block.tpl', 'position' => '999'],
        ['template' => 'order_overview.tpl', 'block' => 'admin_order_overview_reset_form',  'file' => '/views/blocks/adminright_block.tpl', 'position' => '999'],
        ['template' => 'order_overview.tpl', 'block' => 'admin_order_overview_export',      'file' => '/views/blocks/adminright_block.tpl', 'position' => '999'],
    ],
    'settings' => [
        ['group' => 'ecs_main', 'name' => 'bAdminRightsDelete',         'type' => 'bool', 'value' => false],
        ['group' => 'ecs_main', 'name' => 'bAdminRightsOrderOverview',  'type' => 'bool', 'value' => false],
    ],
    'events' => [
        'onActivate'    => '\Ecs\AdminRights\Core\Events::onActivate',
        'onDeactivate'   => '\Ecs\AdminRights\Core\Events::onDeactivate',
    ],
];
