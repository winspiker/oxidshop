<?php

/**
 *
 * @package   tabslImageTags
 * @version   3.0.1
 * @license   kaufbei.tv
 * @link      https://oxid-module.eu
 * @author    Tobias Merkl <support@oxid-module.eu>
 * @copyright Tobias Merkl | 2021-09-23
 *
 * This Software is the property of Tobias Merkl
 * and is protected by copyright law, it is not freeware.
 *
 * Any unauthorized use of this software without a valid license
 * is a violation of the license agreement and will be
 * prosecuted by civil and criminal law.
 *
 * 58fdc7af16ec0fe83c4774f81b336f31
 *
 **/

/**
 * Metadata version
 */
$sMetadataVersion = '2.0';

// tabsl module id
$psModuleId = 'tabslImageTags';
$psModuleName = 'tabslImageTags';
$psModuleVersion = '3.0.1';

// tabsl module description
$psModuleDesc = '
    Das OXID Set-Modul tabsl|Sets bietet die M&ouml;glichkeit f&uuml;r alle Artikel- und Kategoriebilder individuelle Alt- und Titel-Attribute festzulegen.<br>
    <hr style="margin-bottom: 15px;">
    <img src="https://www.proudcommerce.com/module/img/icon_txt.png" border="0" style="width: 10px; height: 11px;">&nbsp; <a href="https://www.proudcommerce.com/module/docs/' . $psModuleId . '/changelog.txt" target="_blank">Changelog</a> &nbsp;|&nbsp;
    <img src="https://www.proudcommerce.com/module/img/icon_mail.png" border="0" style="width: 10px; height: 11px;">&nbsp; <a href="mailto:support@oxid-module.eu?subject=' . $psModuleId . ' '. $psModuleVersion .' // ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getEdition() . ' ' . \OxidEsales\Eshop\Core\Registry::getConfig()->getVersion() . ' // PHP ' . phpversion() . ' // ' . preg_replace("(^https?://)", "", trim(\OxidEsales\Eshop\Core\Registry::getConfig()->getShopUrl(), "/")) . '">Support-Anfrage</a> &nbsp;|&nbsp;
    <img src="https://www.proudcommerce.com/module/img/icon_link.png" border="0" style="width: 10px; height: 11px;">&nbsp; <a href="http://www.oxid-module.eu/module/tabsl-imagetags/" target="_blank">Modul-Info</a><br>
    <hr style="margin-top: 15px;">
    Aktuellste Modulversion: &nbsp; <img src="https://www.proudcommerce.com/module/version/' . $psModuleId . '.png" border="0">
';

/**
 * Module information
 */
$aModule = [
    'id'          => $psModuleId,
    'title'       => [
        'de' => $psModuleName.' | Bilder SEO Modul',
        'en' => $psModuleName.' | Picture seo module',
    ],
    'description' => [
        'de' => $psModuleDesc,
        'en' => $psModuleDesc
    ],
    'thumbnail'   => '',
    'version'     => $psModuleVersion,
    'author'      => 'Tobias Merkl',
    'url'         => 'https://oxid-module.eu',
    'email'       => 'support@oxid-module.eu',
    'extend'      => [
        \OxidEsales\Eshop\Application\Model\Article::class  => \Tabsl\ImageTags\Model\Article::class,
        \OxidEsales\Eshop\Application\Model\Category::class => \Tabsl\ImageTags\Model\Category::class,
    ],
    'controllers'       => [
    ],
    'templates'   => [
    ],
    'blocks'      => [
        ['template' => 'article_pictures.tpl', 'block' => 'admin_article_pictures_main', 'file' => 'views/blocks/admin_article_pictures_main.tpl'],
        ['template' => 'include/category_main_form.tpl', 'block' => 'admin_category_main_form', 'file' => 'views/blocks/admin_category_main_form.tpl'],
    ],
    'settings'    => [
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_status', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_shortdesc', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_imagename', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_cat', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_brand', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_art', 'name' => 'tabsl_imagetags_art_title', 'type' => 'bool', 'value' => 'true'],
        ['group' => 'tabslimagetags_cat', 'name' => 'tabsl_imagetags_cat_status', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_cat', 'name' => 'tabsl_imagetags_cat_shortdesc', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_cat', 'name' => 'tabsl_imagetags_cat_imagename', 'type' => 'bool', 'value' => 'false'],
        ['group' => 'tabslimagetags_cat', 'name' => 'tabsl_imagetags_cat_title', 'type' => 'bool', 'value' => 'true'],
    ],
    'events'      => [
        'onActivate'   => '\Tabsl\ImageTags\Core\Setup::onActivate',
        'onDeactivate' => '\Tabsl\ImageTags\Core\Setup::onDeactivate',
    ],
];
