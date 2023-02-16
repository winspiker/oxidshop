<?php

$sMetadataVersion = '2.0';

$aModule = [
	'id' => 'dggoogleanalytics',
	'title' => '<b style="-moz-border-radius: 2px;-webkit-border-radius: 2px;-khtml-border-radius: 2px;border-radius: 2px;background:#d1d2d2;font-size: 10px;border:1px solid #282828;padding:2px;font-weight:900;font-family:Verdana;"><span style="color: #282828;">d</span><span style="color: #880c02;">g</span></b> Google Analytics Schnittstelle',
	'description' => [
		'de' => 'Javascript Anbingung an Google Analytics<br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dggoogleanalytics</li></ul>',
		'en' => 'Javascript Anbingung an Google Analytics<br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dggoogleanalytics</li></ul>',
        'fr' => 'Javascript Anbingung an Google Analytics<br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dggoogleanalytics</li></ul>' ],
	'thumbnail' => 'picture.png',
	'version' => '5.20',
	'author' => 'Volker D&ouml;rk, draufgeschaut.de',
	'email' => 'support@draufgeschaut.de',
	'url' => 'http://www.volker-doerk.de',
	'settings' => [], 
    'templates' => [ 
		'dggoogleanalytics/dggoogleanalytics_admin.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_admin.tpl',
		'dggoogleanalytics/dggoogleanalytics_exception.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_exception.tpl',
		'dggoogleanalytics/dggoogleanalytics_list.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_list.tpl',
		'dggoogleanalytics/dggoogleanalytics_main.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_main.tpl',
		'dggoogleanalytics/dggoogleanalytics_setup.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_setup.tpl',
		'dggoogleanalytics/dggoogleanalytics_support.tpl' => 'dggoogleanalytics/Application/views/admin/tpl/dggoogleanalytics_support.tpl' ], 
    'blocks' => [ 
		[ 'template' => 'layout/base.tpl', 'block' => 'base_js', 'file' => 'dggoogleanalytics_base_js.tpl', 'position' => '7' ],
		[ 'template' => 'layout/base.tpl', 'block' => 'base_style', 'file' => 'dggoogleanalytics_base_style.tpl', 'position' => '1' ] ], 
	'controllers' => [ 
		'dggoogleanalytics' => \dgModule\dgGoogleAnalyticsModul\Application\Model\dgGoogleAnalytics::class,
		'dggoogleanalytics_admin' => \dgModule\dgGoogleAnalyticsModul\Application\Controller\Admin\dgGoogleAnalytics_Admin::class,
		'dggoogleanalytics_list' => \dgModule\dgGoogleAnalyticsModul\Application\Controller\Admin\dgGoogleAnalytics_List::class,
		'dggoogleanalytics_main' => \dgModule\dgGoogleAnalyticsModul\Application\Controller\Admin\dgGoogleAnalytics_Main::class,
		'dggoogleanalytics_setup' => \dgModule\dgGoogleAnalyticsModul\Application\Controller\Admin\dgGoogleAnalytics_Setup::class,
		'dggoogleanalytics_support' => \dgModule\dgGoogleAnalyticsModul\Application\Controller\Admin\dgGoogleAnalytics_Support::class,
		'dggoogleanalyticsevents' => \dgModule\dgGoogleAnalyticsModul\Application\Model\dgGoogleAnalyticsEvents::class,
		'dggoogleanalyticsupdate' => \dgModule\dgGoogleAnalyticsModul\Application\Model\dgGoogleAnalyticsUpdate::class ], 
	'extend' => [ 
		\OxidEsales\Eshop\Application\Controller\Admin\NavigationController::class => \dgModule\dgGoogleAnalyticsModul\Modul\dgGoogleAnalytics_Navigation::class,
		\OxidEsales\Eshop\Application\Component\BasketComponent::class => \dgModule\dgGoogleAnalyticsModul\Modul\dgGoogleAnalytics_oxCmp_Basket::class,
		\OxidEsales\Eshop\Core\UtilsView::class => \dgModule\dgGoogleAnalyticsModul\Modul\dgGoogleAnalytics_oxUtilsView::class ], 
    'events'  => [
        'onActivate'   => '\dgModule\dgGoogleAnalyticsModul\Application\Model\dgGoogleAnalyticsEvents::onActivate',
        'onDeactivate' => '\dgModule\dgGoogleAnalyticsModul\Application\Model\dgGoogleAnalyticsEvents::onDeactivate'  ]
    ];
      
?>