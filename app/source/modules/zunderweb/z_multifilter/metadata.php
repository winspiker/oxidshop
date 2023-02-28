<?php
$sMetadataVersion = '1.2';
$aModule = array(
    'id'          => 'z_multifilter',
    'title'       => 'Zunderweb Ajax Multifilter XL',
    'description' =>  array(
        'de'=>'Erweiterter Attributfilter',
        'en'=>'Extended Attribute Filter',
    ),
    'version'     => '2.7.8',
    'url'         => 'http://zunderweb.de',
    'email'       => 'info@zunderweb.de',
    'author'      => 'Zunderweb',
    'extend'      => array(
        OxidEsales\Eshop\Application\Controller\ArticleListController::class => 'zunderweb/z_multifilter/controllers/z_multifilter_alist',
        OxidEsales\Eshop\Application\Model\ArticleList::class => 'zunderweb/z_multifilter/models/z_multifilter_oxarticlelist',
        OxidEsales\Eshop\Application\Model\AttributeList::class => 'zunderweb/z_multifilter/models/z_multifilter_oxattributelist',
        OxidEsales\Eshop\Core\Config::class => 'zunderweb/z_multifilter/core/z_multifilter_oxconfig',
        OxidEsales\Eshop\Core\Utils::class => 'zunderweb/z_multifilter/core/z_multifilter_oxutils',
        OxidEsales\Eshop\Core\UtilsCount::class => 'zunderweb/z_multifilter/core/inheritcats_oxutilscount',
        OxidEsales\Eshop\Application\Model\Article::class => 'zunderweb/z_multifilter/models/inheritcats_oxarticle',
        OxidEsales\Eshop\Application\Model\Category::class => 'zunderweb/z_multifilter/models/inheritcats_oxcategory',
        OxidEsales\Eshop\Application\Model\Attribute::class => 'zunderweb/z_multifilter/models/z_multifilter_oxattribute',
    ),
    'files'      => array(
       'updatefilters' => 'zunderweb/z_multifilter/controllers/updatefilters.php',
        'z_multifilter_events' => 'zunderweb/z_multifilter/events/z_multifilter_events.php',
    ),
    'blocks' => array(
        array('template' => 'layout/sidebar.tpl', 'block' => 'sidebar_categoriestree', 'file' => 'views/blocks/sidebar_categoriestree.tpl'),
        array('template' => 'page/list/list.tpl', 'block' => 'page_list_listhead', 'file' => 'views/blocks/page_list_listhead.tpl'),
        array('template' => 'page/list/list.tpl', 'block' => 'page_list_listbody', 'file' => 'views/blocks/page_list_listbody.tpl'),
        array('template' => 'widget/locator/attributes.tpl', 'block' => 'widget_locator_attributes', 'file' => 'views/blocks/widget_locator_attributes.tpl'),
        array('template' => 'layout/page.tpl', 'block' => 'layout_header', 'file' => 'views/blocks/page_layout_header.tpl'),
    ),
    'templates' => array(
        'ajaxlist.tpl' => 'zunderweb/z_multifilter/views/tpl/page/list/ajaxlist.tpl',
        'ajaxlist_mobile.tpl' => 'zunderweb/z_multifilter/views/tpl/page/list/ajaxlist_mobile.tpl',
    ),
    'settings' => array(
        array('group' => 'mf_settings', 'name' => 'iMfDisplayPriceAs', 'type' => 'bool',  'value' => '1'),
        array('group' => 'mf_settings', 'name' => 'aMfPriceRangeLimits', 'type' => 'arr',  'value' => array('10','50','100','200','500','750','1000')),
        array('group' => 'mf_settings', 'name' => 'blMfHideSidebarNavigation', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_settings', 'name' => 'sMfAttributeValueSeparator', 'type' => 'str',  'value' => ', '),
        array('group' => 'mf_settings', 'name' => 'blMfShowCategoryFilter', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_settings', 'name' => 'blInheritCategories', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_caching', 'name' => 'blMfEnableCaching', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_caching', 'name' => 'iMfCachingMaxAge', 'type' => 'str',  'value' => '3600'),
        array('group' => 'mf_order', 'name' => 'blMfDisplayTop', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_order', 'name' => 'blMfHideHead', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_order', 'name' => 'blMfOrderByName', 'type' => 'bool',  'value' => '1'),
        array('group' => 'mf_order', 'name' => 'blMfOrderCategoriesByName', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_order', 'name' => 'blMfOrderByCount', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_order', 'name' => 'blMfOrderBySelected', 'type' => 'bool',  'value' => '1'),
        array('group' => 'mf_order', 'name' => 'blMfHideDisabled', 'type' => 'bool',  'value' => '0'),
        array('group' => 'mf_order', 'name' => 'blMfShowArticleCount', 'type' => 'bool',  'value' => '1'),
        array('group' => 'mf_order', 'name' => 'blMfShowMoreFrom', 'type' => 'str',  'value' => '8'),
        array('group' => 'mf_order', 'name' => 'blMfShowMoreAfterSelected', 'type' => 'bool',  'value' => '0'),
    ),
    'events'       => array(
        'onActivate'   => 'z_multifilter_events::onactivate',
        'onDeactivate' => 'z_multifilter_events::ondeactivate'
    ),
);
