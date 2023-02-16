<?php

$sMetadataVersion = '2.0';

$aModule = [
	'id' => 'dgconnector',
	'title' => '<b style="-moz-border-radius: 2px;-webkit-border-radius: 2px;-khtml-border-radius: 2px;border-radius: 2px;background:#d1d2d2;font-size: 10px;border:1px solid #282828;padding:2px;font-weight:900;font-family:Verdana;"><span style="color: #282828;">d</span><span style="color: #880c02;">g</span></b> Modul Connector, Installations und Update Assistent',
	'description' => [
		'de' => 'Automatisierte Modulupdates und Neuinstallation von draufgeschaut.de ModulenUnterst&uuml;tzen Sie unsere Gratis Module <a href="https://paypal.me/draufgeschaut">https://paypal.me/draufgeschaut</a><br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dgconnector</li></ul>',
		'en' => 'Automatisierte Modulupdates und Neuinstallation von draufgeschaut.de ModulenUnterst&uuml;tzen Sie unsere Gratis Module <a href="https://paypal.me/draufgeschaut">https://paypal.me/draufgeschaut</a><br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dgconnector</li></ul>',
        'fr' => 'Automatisierte Modulupdates und Neuinstallation von draufgeschaut.de ModulenUnterst&uuml;tzen Sie unsere Gratis Module <a href="https://paypal.me/draufgeschaut">https://paypal.me/draufgeschaut</a><br /><br />F&uuml;r die Installation &uuml;ber den Composer f&uuml;hren Sie folgende Befehle aus:<br /><ul><li>php composer config repositories.draufgeschaut composer https://update.draufgeschaut.de</li><li>php composer require draufgeschaut/dgconnector</li></ul>' ],
	'thumbnail' => 'picture.png',
	'version' => '1.20',
	'author' => 'Volker D&ouml;rk, draufgeschaut.de',
	'email' => 'support@draufgeschaut.de',
	'url' => 'http://www.volker-doerk.de',
	'settings' => [], 
    'templates' => [ 
		'dgconnector/dgconnector_admin.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_admin.tpl',
		'dgconnector/dgconnector_exception.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_exception.tpl',
		'dgconnector/dgconnector_install.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_install.tpl',
		'dgconnector/dgconnector_list.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_list.tpl',
		'dgconnector/dgconnector_main.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_main.tpl',
		'dgconnector/dgconnector_maintenance_admin.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_maintenance_admin.tpl',
		'dgconnector/dgconnector_maintenance_list.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_maintenance_list.tpl',
		'dgconnector/dgconnector_maintenance_main.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_maintenance_main.tpl',
		'dgconnector/dgconnector_module.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_module.tpl',
		'dgconnector/dgconnector_setup.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_setup.tpl',
		'dgconnector/dgconnector_support.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_support.tpl',
		'dgconnector/dgconnector_tplblocks_admin.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_tplblocks_admin.tpl',
		'dgconnector/dgconnector_tplblocks_list.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_tplblocks_list.tpl',
		'dgconnector/dgconnector_tplblocks_main.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnector_tplblocks_main.tpl',
		'dgconnector/dgconnectorsetup.tpl' => 'dgconnector/Application/views/admin/tpl/dgconnectorsetup.tpl' ], 
    'blocks' => [ 
		array( 'template' => 'header.tpl', 'block' => 'admin_header_links', 'file' => 'dgconnector_admin_header_links.tpl', 'position' => '9' ) ], 
	'controllers' => [ 
		'dgconnector_admin' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Admin::class,
		'dgconnector_install' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Install::class,
		'dgconnector_list' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_List::class,
		'dgconnector_main' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Main::class,
		'dgconnector_maintenance_admin' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Maintenance_Admin::class,
		'dgconnector_maintenance_list' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Maintenance_List::class,
		'dgconnector_maintenance_main' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Maintenance_Main::class,
		'dgconnector_module' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Module::class,
		'dgconnector_setup' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Setup::class,
		'dgconnector_support' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Support::class,
		'dgconnector_tplblocks_admin' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_TplBlocks_Admin::class,
		'dgconnector_tplblocks_list' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_TplBlocks_List::class,
		'dgconnector_tplblocks_main' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_TplBlocks_Main::class,
		'dgconnector_update' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnector_Update::class,
		'dgconnectorconfig' => \dgModule\dgConnectorModul\Application\Model\dgConnectorConfig::class,
		'dgconnectorevents' => \dgModule\dgConnectorModul\Application\Model\dgConnectorEvents::class,
		'dgconnectorinstall' => \dgModule\dgConnectorModul\Application\Model\dgConnectorInstall::class,
		'dgconnectormaintenance' => \dgModule\dgConnectorModul\Application\Model\dgConnectorMaintenance::class,
		'dgconnectorsetup' => \dgModule\dgConnectorModul\Application\Controller\Admin\dgConnectorSetup::class,
		'dgconnectortplblocks' => \dgModule\dgConnectorModul\Application\Model\dgConnectorTplBlocks::class,
		'dgconnectorupdate' => \dgModule\dgConnectorModul\Application\Model\dgConnectorUpdate::class ], 
	'extend' => [ 
		\OxidEsales\Eshop\Application\Controller\Admin\NavigationController::class => \dgModule\dgConnectorModul\Modul\dgConnector_Navigation::class ], 
    'events'  => [
        'onActivate'   => '\dgModule\dgConnectorModul\Application\Model\dgConnectorEvents::onActivate',
        'onDeactivate' => '\dgModule\dgConnectorModul\Application\Model\dgConnectorEvents::onDeactivate'  ]
    ];
      
?>