<?php

$sLangName = 'English';

// -------------------------------
// RESOURCE IDENTIFIER = STRING
// -------------------------------
$aLang = array(
    'charset'                                                               => 'utf-8',
    'SHOP_MODULE_GROUP_NETSITEMAPGCFG'                                      => 'Basic settings',
    'SHOP_MODULE_GROUP_NETSITEMAPICFG'                                      => 'Change frequency settings',
    'SHOP_MODULE_GROUP_NETSITEMAPPCFG'                                      => 'Priority settings',
    'SHOP_MODULE_GROUP_NETSITEMAPEXCLUDECFG'                                => 'Exclusion settings',
    'SHOP_MODULE_GROUP_NETSITEMAPEXPORTCFG'                                 => 'Admin export settings',

    'SHOP_MODULE_sNetSitemapTicksize'                                       => 'Amount of export datasets that will be processed by a single export request (Drop or raise the amount number according to your server performance)',

    'SHOP_MODULE_blNetSitemapBoolArticle'                                   => 'List product urls in sitemap',
    'SHOP_MODULE_blNetSitemapBoolCategory'                                  => 'List category urls in sitemap',
    'SHOP_MODULE_blNetSitemapBoolContent'                                   => 'List content urls in sitemap',
    'SHOP_MODULE_blNetSitemapBoolManufact'                                  => 'List manufacturer urls in sitemap',
    'SHOP_MODULE_blNetSitemapBoolVariants'                                  => 'List product variant urls in sitemap',
    'SHOP_MODULE_blNetSitemapBoolPagination'                                => 'List category and manufacturer pagination urls in sitemap (if deactivated, only the category or manufacturer main page gets listed in sitemap)',
    'SHOP_MODULE_blNetSitemapBoolHiddenCats'                                => 'List hidden categories within sitemap ( Database flag: oxcategories__oxhidden = 1 )',

    'SHOP_MODULE_sNetSmpStaticCF'                                           => 'Change frequency for static shop urls',
    'SHOP_MODULE_sNetSmpArticleCF'                                          => 'Change frequency for product urls',
    'SHOP_MODULE_sNetSmpCategoryCF'                                         => 'Change frequency for category urls',
    'SHOP_MODULE_sNetSmpContentCF'                                          => 'Change frequency for content urls',
    'SHOP_MODULE_sNetSmpManufactCF'                                         => 'Change frequency for manufacturer urls',

    'SHOP_MODULE_sNetSmpStaticPrio'                                         => 'Priority for static shop urls',
    'SHOP_MODULE_sNetSmpCategoryPrio'                                       => 'Priority for category urls',
    'SHOP_MODULE_sNetSmpContentPrio'                                        => 'Priority for content urls',
    'SHOP_MODULE_sNetSmpManufactPrio'                                       => 'Priority for manufacturer urls',

    'SHOP_MODULE_aNetSitemapExlude'                                         => 'Exclude static urls (please insert one url by line, example: https://www.ihre-domain.de/Impressum)',

    'SHOP_MODULE_sNetSmpStaticCF_always'                                    => 'always',
    'SHOP_MODULE_sNetSmpStaticCF_hourly'                                    => 'hourly',
    'SHOP_MODULE_sNetSmpStaticCF_daily'                                     => 'daily',
    'SHOP_MODULE_sNetSmpStaticCF_weekly'                                    => 'weekly',
    'SHOP_MODULE_sNetSmpStaticCF_monthly'                                   => 'monthly',
    'SHOP_MODULE_sNetSmpStaticCF_yearly'                                    => 'yearly',
    'SHOP_MODULE_sNetSmpStaticCF_never'                                     => 'never',

    'SHOP_MODULE_sNetSmpArticleCF_always'                                   => 'always',
    'SHOP_MODULE_sNetSmpArticleCF_hourly'                                   => 'hourly',
    'SHOP_MODULE_sNetSmpArticleCF_daily'                                    => 'daily',
    'SHOP_MODULE_sNetSmpArticleCF_weekly'                                   => 'weekly',
    'SHOP_MODULE_sNetSmpArticleCF_monthly'                                  => 'monthly',
    'SHOP_MODULE_sNetSmpArticleCF_yearly'                                   => 'yearly',
    'SHOP_MODULE_sNetSmpArticleCF_never'                                    => 'never',

    'SHOP_MODULE_sNetSmpCategoryCF_always'                                  => 'always',
    'SHOP_MODULE_sNetSmpCategoryCF_hourly'                                  => 'hourly',
    'SHOP_MODULE_sNetSmpCategoryCF_daily'                                   => 'daily',
    'SHOP_MODULE_sNetSmpCategoryCF_weekly'                                  => 'weekly',
    'SHOP_MODULE_sNetSmpCategoryCF_monthly'                                 => 'monthly',
    'SHOP_MODULE_sNetSmpCategoryCF_yearly'                                  => 'yearly',
    'SHOP_MODULE_sNetSmpCategoryCF_never'                                   => 'never',

    'SHOP_MODULE_sNetSmpContentCF_always'                                   => 'always',
    'SHOP_MODULE_sNetSmpContentCF_hourly'                                   => 'hourly',
    'SHOP_MODULE_sNetSmpContentCF_daily'                                    => 'daily',
    'SHOP_MODULE_sNetSmpContentCF_weekly'                                   => 'weekly',
    'SHOP_MODULE_sNetSmpContentCF_monthly'                                  => 'monthly',
    'SHOP_MODULE_sNetSmpContentCF_yearly'                                   => 'yearly',
    'SHOP_MODULE_sNetSmpContentCF_never'                                    => 'never',

    'SHOP_MODULE_sNetSmpManufactCF_always'                                  => 'always',
    'SHOP_MODULE_sNetSmpManufactCF_hourly'                                  => 'hourly',
    'SHOP_MODULE_sNetSmpManufactCF_daily'                                   => 'daily',
    'SHOP_MODULE_sNetSmpManufactCF_weekly'                                  => 'weekly',
    'SHOP_MODULE_sNetSmpManufactCF_monthly'                                 => 'monthly',
    'SHOP_MODULE_sNetSmpManufactCF_yearly'                                  => 'yearly',
    'SHOP_MODULE_sNetSmpManufactCF_never'                                   => 'never',

    'SHOP_MODULE_sNetSmpStaticPrio_0.1'                                     => '0.1',
    'SHOP_MODULE_sNetSmpStaticPrio_0.2'                                     => '0.2',
    'SHOP_MODULE_sNetSmpStaticPrio_0.3'                                     => '0.3',
    'SHOP_MODULE_sNetSmpStaticPrio_0.4'                                     => '0.4',
    'SHOP_MODULE_sNetSmpStaticPrio_0.5'                                     => '0.5',
    'SHOP_MODULE_sNetSmpStaticPrio_0.6'                                     => '0.6',
    'SHOP_MODULE_sNetSmpStaticPrio_0.7'                                     => '0.7',
    'SHOP_MODULE_sNetSmpStaticPrio_0.8'                                     => '0.8',
    'SHOP_MODULE_sNetSmpStaticPrio_0.9'                                     => '0.9',
    'SHOP_MODULE_sNetSmpStaticPrio_1.0'                                     => '1.0',

    'SHOP_MODULE_sNetSmpArticlePrio_0.1'                                    => '0.1',
    'SHOP_MODULE_sNetSmpArticlePrio_0.2'                                    => '0.2',
    'SHOP_MODULE_sNetSmpArticlePrio_0.3'                                    => '0.3',
    'SHOP_MODULE_sNetSmpArticlePrio_0.4'                                    => '0.4',
    'SHOP_MODULE_sNetSmpArticlePrio_0.5'                                    => '0.5',
    'SHOP_MODULE_sNetSmpArticlePrio_0.6'                                    => '0.6',
    'SHOP_MODULE_sNetSmpArticlePrio_0.7'                                    => '0.7',
    'SHOP_MODULE_sNetSmpArticlePrio_0.8'                                    => '0.8',
    'SHOP_MODULE_sNetSmpArticlePrio_0.9'                                    => '0.9',
    'SHOP_MODULE_sNetSmpArticlePrio_1.0'                                    => '1.0',

    'SHOP_MODULE_sNetSmpCategoryPrio_0.1'                                   => '0.1',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.2'                                   => '0.2',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.3'                                   => '0.3',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.4'                                   => '0.4',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.5'                                   => '0.5',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.6'                                   => '0.6',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.7'                                   => '0.7',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.8'                                   => '0.8',
    'SHOP_MODULE_sNetSmpCategoryPrio_0.9'                                   => '0.9',
    'SHOP_MODULE_sNetSmpCategoryPrio_1.0'                                   => '1.0',

    'SHOP_MODULE_sNetSmpContentPrio_0.1'                                    => '0.1',
    'SHOP_MODULE_sNetSmpContentPrio_0.2'                                    => '0.2',
    'SHOP_MODULE_sNetSmpContentPrio_0.3'                                    => '0.3',
    'SHOP_MODULE_sNetSmpContentPrio_0.4'                                    => '0.4',
    'SHOP_MODULE_sNetSmpContentPrio_0.5'                                    => '0.5',
    'SHOP_MODULE_sNetSmpContentPrio_0.6'                                    => '0.6',
    'SHOP_MODULE_sNetSmpContentPrio_0.7'                                    => '0.7',
    'SHOP_MODULE_sNetSmpContentPrio_0.8'                                    => '0.8',
    'SHOP_MODULE_sNetSmpContentPrio_0.9'                                    => '0.9',
    'SHOP_MODULE_sNetSmpContentPrio_1.0'                                    => '1.0',

    'SHOP_MODULE_sNetSmpManufactPrio_0.1'                                   => '0.1',
    'SHOP_MODULE_sNetSmpManufactPrio_0.2'                                   => '0.2',
    'SHOP_MODULE_sNetSmpManufactPrio_0.3'                                   => '0.3',
    'SHOP_MODULE_sNetSmpManufactPrio_0.4'                                   => '0.4',
    'SHOP_MODULE_sNetSmpManufactPrio_0.5'                                   => '0.5',
    'SHOP_MODULE_sNetSmpManufactPrio_0.6'                                   => '0.6',
    'SHOP_MODULE_sNetSmpManufactPrio_0.7'                                   => '0.7',
    'SHOP_MODULE_sNetSmpManufactPrio_0.8'                                   => '0.8',
    'SHOP_MODULE_sNetSmpManufactPrio_0.9'                                   => '0.9',
    'SHOP_MODULE_sNetSmpManufactPrio_1.0'                                   => '1.0',

    'SHOP_MODULE_GROUP_NETSITEMAPEXTCFG'                                    => 'Include external sitemaps into sitemap index',
    'SHOP_MODULE_sNetExternalSitemap'                                       => 'Please enter each external sitemap url line by line',

    'net_sitemap_article'                                                   => 'Google XML sitemap',
    'net_sitemap_category'                                                  => 'Google XML sitemap',
    'net_sitemap_content'                                                   => 'Google XML sitemap',
    'net_sitemap_manufacturer'                                              => 'Google XML sitemap',

    'NET_SITEMAP_ARTICLE_EXCLUDE'                                           => 'Exclude url from Google XML sitemap',
    'NET_SITEMAP_ARTICLE_CHANGE_FREQ'                                       => 'Deviant change frequency',
    'NET_SITEMAP_ARTICLE_PRIORITY'                                          => 'Deviant priority',
    'NET_SITEMAP_ARTICLE_SAVE'                                              => 'Save',

    'NET_SITEMAP_CATEGORY_EXCLUDE'                                          => 'Exclude url from Google XML sitemap',
    'NET_SITEMAP_CATEGORY_CHANGE_FREQ'                                      => 'Deviant change frequency',
    'NET_SITEMAP_CATEGORY_PRIORITY'                                         => 'Deviant priority',
    'NET_SITEMAP_CATEGORY_SAVE'                                             => 'Save',

    'NET_SITEMAP_CONTENT_EXCLUDE'                                           => 'Exclude url from Google XML sitemap',
    'NET_SITEMAP_CONTENT_CHANGE_FREQ'                                       => 'Deviant change frequency',
    'NET_SITEMAP_CONTENT_PRIORITY'                                          => 'Deviant priority',
    'NET_SITEMAP_CONTENT_SAVE'                                              => 'Save',

    'NET_SITEMAP_MANUFACTURER_EXCLUDE'                                      => 'Exclude url from Google XML sitemap',
    'NET_SITEMAP_MANUFACTURER_CHANGE_FREQ'                                  => 'Deviant change frequency',
    'NET_SITEMAP_MANUFACTURER_PRIORITY'                                     => 'Deviant priority',
    'NET_SITEMAP_MANUFACTURER_SAVE'                                         => 'Save',

    'netsitemap'                                                            => 'Google XML sitemap',
    'net_sitemap_export'                                                    => 'Generate sitemap',
    'net_sitemap_export_main'                                               => 'Generate Google XML sitemap',

    'NET_SITEMAP_EXPORT_HEAD'                                               => 'Google XML sitemap admin export',
    'NET_SITEMAP_EXPORT_PARAGRAPH'                                          => 'On this admin page you can generate and refresh your Google XML sitemap files for all activated OXID eShop languages. Please do not close or switch the page while exports are ongoing.',

    'NET_SITEMAP_EXPORT_GENERATE'                                           => 'Generate Google XML sitemaps',

);