<?php

$sMetadataVersion = '2.0';

/**
 * Module information
 */
$aModule = [
    'id' => 'exonn_asum',
    'title' => 'EXONN Article SEO URL Manager (ASUM)',
    'description' => 'Spezialanpassung für Artikel, SEO-Url mit eigener Unique-ID wird automatisch beim Aufruf erzeugt, die ursprüngliche URL wird auf die neue URL umgeleitet.',
    'thumbnail' => 'exonn_logo.png',
    'version' => '1.2.3',
    'author' => 'EXONN',
    'email' => 'info@exonn.de',
    'url' => 'http://www.oxidmodule24.de/',
    'extend' => [
        OxidEsales\Eshop\Core\SeoEncoder::class => Exonn\Asum\Core\ExonnAsumSeoEncoder::class,
        OxidEsales\Eshop\Core\SeoDecoder::class => Exonn\Asum\Core\ExonnAsumSeoDecoder::class,
//		OxidEsales\Eshop\Application\Controller\FrontendController::class => Exonn\Asum\Controller\ExonnAsumFrontendController::class,
        OxidEsales\Eshop\Application\Model\SeoEncoderArticle::class => Exonn\Asum\Model\ExonnAsumSeoEncoderArticle::class,
    ],
    'controllers' => [
        'ExonnAsumAjaxController' => Exonn\Asum\Controller\ExonnAsumAjaxController::class
    ],
    'blocks' => [
        ['template' => 'object_seo.tpl', 'block' => 'admin_object_seo_form', 'file' => 'admin_seo_form_block.tpl'],
//        "object_seo.tpl" => "exonn/exonn_asum/out/admin/tpl/object_seo.tpl",
    ],
    'events' => [
        'onActivate' => '\Exonn\Asum\Core\ExonnAsumEvent::onActivate',
        'onDeactivate' => '\Exonn\Asum\Core\ExonnAsumEvent::onDeactivate',
    ],
];