<?php
/**
 * @TODO LICENCE HERE
 */

/**
 * Metadata version
 */
$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = array(
	'id' => 'seooptimization',
	'title' => array(
		'de' => 'EXONN SEO-Anpassungen',
		'en' => 'EXONN SEO-Adaptations',
	),
	'description' => array(
		'de' => '<h2>SEO-Anpassungen für Ihren Online-Shop</h2>',
		'en' => '<h2>SEO-Adaptations for your Online-Store</h2>',
	),
	'thumbnail' => 'out/pictures/exonn.png',
	'version' => '1.0.6',
	'author' => 'Benjamin Brunner',
	'url' => 'https://exonn.de/',
	'email' => 'b.brunner@exonn.de',
	'extend' => array(
		\OxidEsales\Eshop\Application\Controller\ArticleListController::class => \exonn\seoAdaptations\Controller\ExSeoArticleListController::class,
	),

	'controllers' => array(

	),
	'templates' => array(
//		'listseo.tpl' => 'exonn/seoadaptations/views/listseo.tpl',
//		'baseseo.tpl' => 'exonn/seoadaptations/views/baseseo.tpl'
	),
	'settings' => array(),
	'events' => array(
//		'onActivate' => '\exonn\groupControl\Core\Events::onActivate',
//		'onDeactivate' => '\exonn\groupControl\Core\Events::onDeactivate'
	),
);
