<?php

$sMetadataVersion = '2.1';

$aModule = [
    'id' => 'net_redirect_manager',
    'title' => 'Netensio: Redirect Manager',
    'description' => [
        'de' => "Mit dieser Erweiterung ist es möglich, Weiterleitungen von URL's in Ihrem Shop einzurichten, ohne die .htaccess Datei zu bearbeiten.",
        'en' => 'Adds the possibility to manage URL redirections in OXID eShop administration without the need of modification of .htaccess file.',
    ],
    'thumbnail' => 'netensio.jpg',
    'version' => '1.0.4',
    'author' => 'Netensio',
    'url' => 'https://www.netensio.de',
    'email' => 'info@netensio.de',
    'extend' => [
        \OxidEsales\Eshop\Core\SeoDecoder::class => \Netensio\RedirectManager\Model\SeoDecoder::class,
        \OxidEsales\Eshop\Core\Language::class => \Netensio\RedirectManager\Model\Language::class,
        \OxidEsales\Eshop\Core\Utils::class => \Netensio\RedirectManager\Model\Utils::class,
    ],
    'controllers' => [
        'redirectmanager' => \Netensio\RedirectManager\Controller\Admin\RedirectManagerController::class,
        'redirectmanager_list' => \Netensio\RedirectManager\Controller\Admin\RedirectManagerListController::class,
        'redirectmanager_main' => \Netensio\RedirectManager\Controller\Admin\RedirectManagerMainController::class,
    ],
    'events' => [
        'onActivate' => '\Netensio\RedirectManager\Core\Events::onActivate',
    ],
    'templates' => [
        'redirectmanager.tpl' => 'netensio/net_redirect_manager/views/admin/tpl/redirectmanager.tpl',
        'redirectmanager_list.tpl' => 'netensio/net_redirect_manager/views/admin/tpl/redirectmanager_list.tpl',
        'redirectmanager_main.tpl' => 'netensio/net_redirect_manager/views/admin/tpl/redirectmanager_main.tpl',
        'message/err_410.tpl' => 'netensio/net_redirect_manager/views/tpl/message/err_410.tpl',
    ]
];