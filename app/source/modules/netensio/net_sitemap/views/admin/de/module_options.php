<?php

$sLangName = 'Deutsch';

// -------------------------------
// RESOURCE IDENTIFIER = STRING
// -------------------------------
$aLang = array(
    'charset'                                                               => 'utf-8',
    'SHOP_MODULE_GROUP_NETSITEMAPGCFG'                                      => 'Grundeinstellungen',
    'SHOP_MODULE_GROUP_NETSITEMAPICFG'                                      => 'Interval Einstellungen',
    'SHOP_MODULE_GROUP_NETSITEMAPPCFG'                                      => 'Priorität Einstellungen',
    'SHOP_MODULE_GROUP_NETSITEMAPEXCLUDECFG'                                => 'Ausschluss Einstellungen',
    'SHOP_MODULE_GROUP_NETSITEMAPEXPORTCFG'                                 => 'Admin-Export Einstellungen',

    'SHOP_MODULE_sNetSitemapTicksize'                                       => 'Anzahl Sitemap Objekte, die pro Admin Export Aufruf verarbeitet werden. (Senken Sie diese Zahl ab oder heben Sie diese Zahl an je nach zur Verfügung stehender Serverleistung)',

    'SHOP_MODULE_blNetSitemapBoolArticle'                                   => 'Produkt URLs in Sitemap auflisten',
    'SHOP_MODULE_blNetSitemapBoolCategory'                                  => 'Kategorie URLs in Sitemap auflisten',
    'SHOP_MODULE_blNetSitemapBoolContent'                                   => 'CMS-Seiten URLs in Sitemap auflisten',
    'SHOP_MODULE_blNetSitemapBoolManufact'                                  => 'Hersteller-Seiten URLs in Sitemap auflisten',
    'SHOP_MODULE_blNetSitemapBoolVariants'                                  => 'Produkt-Varianten URLs in Sitemap auflisten',
    'SHOP_MODULE_blNetSitemapBoolPagination'                                => 'Kategorie und Hersteller Paginations-Seiten URLs in Sitemap aufnehmen (wenn deaktiviert wird nur die Haupt-URL der Kategorie oder des Herstellers in die Sitemap aufgenommen)',
    'SHOP_MODULE_blNetSitemapBoolHiddenCats'                                => 'Versteckte Kategorien in Sitemap aufnehmen ( Datenbankmerkmal: oxcategories__oxhidden = 1 )',

    'SHOP_MODULE_sNetSmpStaticCF'                                           => 'Änderungsinterval für Statische-Seiten URLs',
    'SHOP_MODULE_sNetSmpArticleCF'                                          => 'Änderungsinterval für Produkt-Seiten URLs',
    'SHOP_MODULE_sNetSmpCategoryCF'                                         => 'Änderungsinterval für Kategorie-Seiten URLs',
    'SHOP_MODULE_sNetSmpContentCF'                                          => 'Änderungsinterval für CMS-Seiten URLs',
    'SHOP_MODULE_sNetSmpManufactCF'                                         => 'Änderungsinterval für Hersteller-Seiten URLs',

    'SHOP_MODULE_sNetSmpStaticPrio'                                         => 'Statische-Seiten URL Priorität',
    'SHOP_MODULE_sNetSmpArticlePrio'                                        => 'Produkt-Seiten URL Priorität',
    'SHOP_MODULE_sNetSmpCategoryPrio'                                       => 'Kategorie-Seiten URL Priorität',
    'SHOP_MODULE_sNetSmpContentPrio'                                        => 'CMS-Seiten URL Priorität',
    'SHOP_MODULE_sNetSmpManufactPrio'                                       => 'Hersteller-Seiten URL Priorität',

    'SHOP_MODULE_aNetSitemapExlude'                                         => 'Ausschluss statischer URLs (bitte eine URL pro Zeile eintragen, die nicht in der Sitemap aufgeführt werden darf, z.B.: https://www.ihre-domain.de/Impressum)',

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

    'SHOP_MODULE_GROUP_NETSITEMAPEXTCFG'                                    => 'Aufnahme externer Sitemap Dateien',
    'SHOP_MODULE_sNetExternalSitemap'                                       => 'Sitemap URLs externer Applikationen zeilenweise eintragen',

    'net_sitemap_article'                                                   => 'Google XML Sitemap',
    'net_sitemap_category'                                                  => 'Google XML Sitemap',
    'net_sitemap_content'                                                   => 'Google XML Sitemap',
    'net_sitemap_manufacturer'                                              => 'Google XML Sitemap',

    'NET_SITEMAP_ARTICLE_EXCLUDE'                                           => 'URL aus Google XML Sitemap ausschließen',
    'NET_SITEMAP_ARTICLE_CHANGE_FREQ'                                       => 'Abweichendes Änderungsinterval',
    'NET_SITEMAP_ARTICLE_PRIORITY'                                          => 'Abweichende Priorität',
    'NET_SITEMAP_ARTICLE_SAVE'                                              => 'Speichern',

    'NET_SITEMAP_CATEGORY_EXCLUDE'                                          => 'URL aus Google XML Sitemap ausschließen',
    'NET_SITEMAP_CATEGORY_CHANGE_FREQ'                                      => 'Abweichendes Änderungsinterval',
    'NET_SITEMAP_CATEGORY_PRIORITY'                                         => 'Abweichende Priorität',
    'NET_SITEMAP_CATEGORY_SAVE'                                             => 'Speichern',

    'NET_SITEMAP_CONTENT_EXCLUDE'                                           => 'URL aus Google XML Sitemap ausschließen',
    'NET_SITEMAP_CONTENT_CHANGE_FREQ'                                       => 'Abweichendes Änderungsinterval',
    'NET_SITEMAP_CONTENT_PRIORITY'                                          => 'Abweichende Priorität',
    'NET_SITEMAP_CONTENT_SAVE'                                              => 'Speichern',

    'NET_SITEMAP_MANUFACTURER_EXCLUDE'                                      => 'URL aus Google XML Sitemap ausschließen',
    'NET_SITEMAP_MANUFACTURER_CHANGE_FREQ'                                  => 'Abweichendes Änderungsinterval',
    'NET_SITEMAP_MANUFACTURER_PRIORITY'                                     => 'Abweichende Priorität',
    'NET_SITEMAP_MANUFACTURER_SAVE'                                         => 'Speichern',

    'netsitemap'                                                            => 'Google XML Sitemap',
    'net_sitemap_export'                                                    => 'Sitemap erstellen',
    'net_sitemap_export_main'                                               => 'Google XML Sitemap erstellen',

    'NET_SITEMAP_EXPORT_HEAD'                                               => 'Google XML Sitemap Admin Export',
    'NET_SITEMAP_EXPORT_PARAGRAPH'                                          => 'Auf dieser Maske können Sie die Google XML Sitemaps für alle aktivierten Sprachen Ihres OXID eShops erstellen. Bitte schließen Sie die Ansicht nicht bis der Export Prozess abgeschlossen ist.',

    'NET_SITEMAP_EXPORT_GENERATE'                                           => 'Google XML Sitemaps erzeugen',

);