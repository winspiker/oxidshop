[{php}]

    /*
    * HTML-минимизация
    */
    //ob_start();

    [{/php}]
[{* Important ! render page head and body to collect scripts and styles *}]
[{capture append="oxidBlock_pageHead"}]
    [{strip}]
    <!--script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script-->

    <!--script>
        $( document ).ready(function() {
            $( "#slider-range-container" ).slider();
        } );
    </script-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" id="Viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=[{$oView->getCharSet()}]">

    [{assign var="_sMetaTitlePrefix" value=$oView->getTitlePrefix()}]
    [{assign var="_sMetaTitleSuffix" value=$oView->getTitleSuffix()}]
    [{assign var="_sMetaTitlePageSuffix" value=$oView->getTitlePageSuffix()}]
    [{assign var="_sMetaTitle" value=$oView->getTitle()}]
    [{capture assign="sPageTitle"}][{$_sMetaTitlePrefix}][{if $_sMetaTitlePrefix && $_sMetaTitle}] | [{/if}][{$_sMetaTitle|strip_tags}][{if $_sMetaTitleSuffix && ($_sMetaTitlePrefix || $_sMetaTitle)}] | [{/if}][{$_sMetaTitleSuffix}] [{if $_sMetaTitlePageSuffix}] | [{$_sMetaTitlePageSuffix}][{/if}][{/capture}]

    <title>[{block name="head_title"}][{$sPageTitle}][{/block}]</title>

    [{block name="head_meta_robots"}]
    [{if $oView->noIndex() == 1}]
<meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
    [{elseif $oView->noIndex() == 2}]
<meta name="ROBOTS" content="NOINDEX, FOLLOW">
    [{/if}]



    [{/block}]

    [{block name="head_meta_description"}]
    [{if $oView->getMetaDescription()}]
        <meta name="description" content="[{$oView->getMetaDescription()}][{if $isSubcategorieOfErsatzteile}] | Großes Sortiment an Ersatzteilen und Zubehörteilen für Elektroscooter[{/if}]">
    [{/if}]
    [{/block}]




    [{block name="head_meta_keywords"}]
    [{if $oView->getMetaKeywords()}]
<meta name="keywords" content="[{$oView->getMetaKeywords()}]">
    [{/if}]
    [{/block}]

    [{block name="head_meta_open_graph"}]
    [{if $oViewConf->getFbAppId()}]
<meta property="fb:app_id" content="[{$oViewConf->getFbAppId()}]">
    [{/if}]
<meta property="og:site_name" content="[{$oViewConf->getBaseDir()}]">
<meta property="og:title" content="[{$sPageTitle}]">
<meta property="og:description" content="[{$oView->getMetaDescription()}]">
    [{if $oViewConf->getActiveClassName() == 'details'}]
<meta property="og:type" content="product">
<meta property="og:image" content="[{$oView->getActPicture()}]">
<meta property="og:url" content="[{$oView->getCanonicalUrl()}]">
    [{else}]
<meta property="og:type" content="website">
<meta property="og:image" content="[{$oViewConf->getImageUrl('basket.png')}]">
<meta property="og:url" content="[{$oViewConf->getCurrentHomeDir()}]">
    [{/if}]
    [{/block}]

    [{assign var="canonical_url" value=$oView->getCanonicalUrl()}]
    [{block name="head_link_canonical"}]
    [{if $canonical_url}]
<link rel="canonical" href="[{$canonical_url}]">
    [{/if}]
    [{/block}]

    [{block name="head_link_hreflang"}]
    [{if $oView->isLanguageLoaded()}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]
    [{foreach from=$oxcmp_lang item=_lng}]
    [{if $_lng->id == $oConfig->getConfigParam('sDefaultLang')}]
<link rel="alternate" hreflang="x-default" href="[{$_lng->link}]"/>
    [{/if}]
<link rel="alternate" hreflang="[{$_lng->abbr}]" href="[{$_lng->link|oxaddparams:$oView->getDynUrlParams()}]"/>
    [{/foreach}]
    [{/if}]
    [{/block}]

    [{assign var="oPageNavigation" value=$oView->getPageNavigation()}]
    [{if $oPageNavigation}]
    [{if $oPageNavigation->previousPage}]
<link rel="prev" href="[{$oPageNavigation->previousPage}]">
    [{/if}]
    [{if $oPageNavigation->nextPage}]
<link rel="next" href="[{$oPageNavigation->nextPage}]">
    [{/if}]
    [{/if}]

    [{block name="head_link_favicon"}]
    [{assign var="sFavicon512File" value=$oViewConf->getViewThemeParam('sFavicon512File')}]
    [{if $sFavicon512File}]
<!-- iOS Homescreen Icon (version < 4.2)-->
<link rel="apple-touch-icon-precomposed" media="screen and (resolution: 163dpi)" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />
<!-- iOS Homescreen Icon -->
<link rel="apple-touch-icon-precomposed" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />

<!-- iPad Homescreen Icon (version < 4.2) -->
<link rel="apple-touch-icon-precomposed" media="screen and (resolution: 132dpi)" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />
<!-- iPad Homescreen Icon -->
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />

<!-- iPhone 4 Homescreen Icon (version < 4.2) -->
<link rel="apple-touch-icon-precomposed" media="screen and (resolution: 326dpi)" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />
<!-- iPhone 4 Homescreen Icon -->
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />

<!-- new iPad Homescreen Icon and iOS Version > 4.2 -->
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" />

<!-- Windows 8 -->
    [{assign var="sFaviconMSTileColor" value=$oViewConf->getViewThemeParam('sFaviconMSTileColor')}]
    [{if $sFaviconMSTileColor}]
<meta name="msapplication-TileColor" content="[{$sFaviconMSTileColor}]"> <!-- Kachel-Farbe -->
    [{/if}]
<meta name="msapplication-TileImage" content="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]">

<!-- Fluid -->
<link rel="fluid-icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon512File`")}]" title="[{$sPageTitle}]" />
    [{/if}]

<!-- Shortcut Icons -->
    [{assign var="sFaviconFile"    value=$oViewConf->getViewThemeParam('sFaviconFile')}]
    [{assign var="sFavicon16File"  value=$oViewConf->getViewThemeParam('sFavicon16File')}]
    [{assign var="sFavicon32File"  value=$oViewConf->getViewThemeParam('sFavicon32File')}]
    [{assign var="sFavicon48File"  value=$oViewConf->getViewThemeParam('sFavicon48File')}]
    [{assign var="sFavicon64File"  value=$oViewConf->getViewThemeParam('sFavicon64File')}]
    [{assign var="sFavicon128File" value=$oViewConf->getViewThemeParam('sFavicon128File')}]

    [{if $sFaviconFile}]
<link rel="shortcut icon" href="[{$oViewConf->getImageUrl("favicons/`$sFaviconFile`")}]?rand=1" type="image/x-icon" />
    [{/if}]
    [{if $sFavicon16File}]
<link rel="icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon16File`")}]" sizes="16x16" />
    [{/if}]
    [{if $sFavicon32File}]
<link rel="icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon32File`")}]" sizes="32x32" />
    [{/if}]
    [{if $sFavicon48File}]
<link rel="icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon48File`")}]" sizes="48x48" />
    [{/if}]
    [{if $sFavicon64File}]
<link rel="icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon64File`")}]" sizes="64x64" />
    [{/if}]
    [{if $sFavicon128File}]
<link rel="icon" href="[{$oViewConf->getImageUrl("favicons/`$sFavicon128File`")}]" sizes="128x128" />
    [{/if}]
    [{/block}]

    [{block name="base_style"}]
    [{oxstyle include="css/styles.min.css?dgyuigahf"}]
    [{oxstyle include="css/bootstrap-xxs-tn.css"}]
    [{oxstyle include="css/cookie.css"}]
    [{/block}]

    [{block name="base_fonts"}]
<link href='https://fonts.googleapis.com/css?family=Raleway:200,400,700,600' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Lato:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    [{/block}]

    [{assign var='rsslinks' value=$oView->getRssLinks()}]
    [{block name="head_link_rss"}]
    [{if $rsslinks}]
    [{foreach from=$rsslinks item='rssentry'}]
<link rel="alternate" type="application/rss+xml" title="[{$rssentry.title|strip_tags}]" href="[{$rssentry.link}]">
    [{/foreach}]
    [{/if}]
    [{/block}]



    [{block name="head_css"}]
    [{foreach from=$oxidBlock_head item="_block"}]
    [{$_block}]
    [{/foreach}]

    [{oxstyle include="fontawesome-pro-5.6.3-web/css/all.min.css"}]
    [{oxstyle include="fancybox/jquery.fancybox.css"}]
    [{oxstyle include="css/sxt.css?xzczkxjcysduysiw"}]
    [{/block}]
    [{/strip}]
    [{/capture}]

[{assign var="blIsCheckout"     value=$oView->getIsOrderStep()}]
[{assign var="blFullwidth"      value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
[{assign var="sBackgroundColor" value=$oViewConf->getViewThemeParam('sBackgroundColor')}]

[{* Fullpage Background *}]
[{if $oViewConf->getViewThemeParam('blUseBackground')}]
    [{assign var="sBackgroundPath"          value=$oViewConf->getViewThemeParam('sBackgroundPath')}]
    [{assign var="sBackgroundUrl"           value=$oViewConf->getImageUrl("backgrounds/`$sBackgroundPath`")}]
    [{assign var="sBackgroundRepeat"        value=$oViewConf->getViewThemeParam('sBackgroundRepeat')}]
    [{assign var="sBackgroundPosHorizontal" value=$oViewConf->getViewThemeParam('sBackgroundPosHorizontal')}]
    [{assign var="sBackgroundPosVertical"   value=$oViewConf->getViewThemeParam('sBackgroundPosVertical')}]
    [{assign var="sBackgroundSize"          value=$oViewConf->getViewThemeParam('sBackgroundSize')}]
    [{assign var="blBackgroundAttachment"   value=$oViewConf->getViewThemeParam('blBackgroundAttachment')}]

    [{if $sBackgroundUrl}]
    [{assign var="sStyle" value="background:`$sBackgroundColor` url(`$sBackgroundUrl`) `$sBackgroundRepeat` `$sBackgroundPosHorizontal` `$sBackgroundPosVertical`;"}]

    [{if $sBackgroundSize}]
    [{assign var="sStyle" value=$sStyle|cat:"background-size:`$sBackgroundSize`;"}]
    [{/if}]

    [{if $blBackgroundAttachment}]
    [{assign var="sStyle" value=$sStyle|cat:"background-attachment:fixed;"}]
    [{/if}]
    [{else}]
    [{assign var="sStyle" value="background:`$sBackgroundColor`;"}]
    [{/if}]
    [{elseif $sBackgroundColor}]
    [{assign var="sStyle" value="background:`$sBackgroundColor`;"}]
    [{/if}]

<!DOCTYPE html>
<html lang="[{$oView->getActiveLangAbbr()}]" [{if $oViewConf->getShowFbConnect()}]xmlns:fb="http://www.facebook.com/2008/fbml"[{/if}]>
<head>
    [{foreach from=$oxidBlock_pageHead item="_block"}]
    [{$_block}]
    [{/foreach}]
    [{oxstyle}]

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    [{if $oView->getClassName() == "thankyou"}]
    [{assign var="order" value=$oView->getOrder()}]
    [{assign var="basket" value=$oView->getBasket()}]
    [{assign var="mwst" value=$order->getTotalOrderSum() }]
    [{assign var="delSet" value=$order->getDelSet() }]

    <script>
        window.dataLayer = window.dataLayer || [];
        window.dataLayer.push({
            'transactionId':'[{ $order->getId() }]',
            'transactionAffiliation':'SXT Scooters',
            'transactionTotal':[{ $order->getTotalOrderSum() }],
        'transactionTax':[{$mwst[0]}],
            'transactionShipping':'[{if $delSet}][{$delSet->oxdeliveryset__oxtitle->value}][{/if}]',
            'transactionProducts':[

            [{foreach key=basketindex from=$basket->getContents() item=basketitem name=basketContents}]


                [{assign var="basketproduct" value=$basketitemlist.$basketindex }]
                [{assign var="oArticle" value=$basketitem->getArticle()}]
                [{assign var="oAttributes" value=$oArticle->getAttributesDisplayableInBasket()}]
                [{assign var="oCategory" value=$oArticle->getCategory()}]
                [{assign var="price" value=$basketitem->getPrice()}]
            {
                'sku':'[{ $oArticle->oxarticles__oxartnum->value }]',
                'name':'[{$basketitem->getTitle()}]',
                'category':'[{if $oCategory}][{$oCategory->oxcategories__oxtitle->value}][{/if}]',
                'price':[{$price->getPrice()}],
                'quantity':[{ $basketitem->getAmount() }]
        },

        [{/foreach}]

        ]
        });
    </script>
    [{/if}]

    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-28055456-1', 'auto');
        ga('send', 'pageview');

    </script>

    <script>
        // Verwenden Sie Ihre Tracking-ID, wie oben beschrieben.
        var gaProperty = 'UA-28055456-1';

        // Deaktiviere das Tracking, wenn das Opt-out cookie vorhanden ist.
        var disableStr = 'ga-disable-' + gaProperty;
        if (document.cookie.indexOf(disableStr + '=true') > -1) {
            window[disableStr] = true;
        }

        // Die eigentliche Opt-out Funktion.
        function gaOptout(){
            document.cookie = disableStr + '=true; expires=Thu, 31 Dec 2099 23:59:59 UTC; path=/';
            window[disableStr] = true;
            alert("Die Erfassung durch Google Analytics auf dieser Website wird zukünftig verhindert.");
        }
    </script>

    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                })(window,document,'script','dataLayer','GTM-N34GZ5Z');</script>
    <!-- End Google Tag Manager -->

</head>
<body class="cl-[{$oView->getClassName()}][{if $smarty.get.plain == '1'}] popup[{/if}][{if $blIsCheckout}] is-checkout[{/if}][{if $oxcmp_user && $oxcmp_user->oxuser__oxpassword->value}] is-logged-in[{/if}]"[{if $sStyle}] style="[{$sStyle}]"[{/if}]>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-N34GZ5Z"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

[{* Theme SVG icons *}]
[{block name="theme_svg_icons"}]
    <div style="display: none;">
        [{include file="layout/svg/shoppingbag.svg" count=$oxcmp_basket->getItemsCount()}]
    </div>
    [{/block}]


[{foreach from=$oxidBlock_pageBody item="_block"}]
    [{$_block}]
    [{/foreach}]
</div>
</div>

[{foreach from=$oxidBlock_pagePopup item="_block"}]
    [{$_block}]
    [{/foreach}]

[{if $oViewConf->getTopActiveClassName() == 'details' && $oView->showZoomPics()}]
    [{include file="page/details/inc/photoswipe.tpl"}]
    [{/if}]

[{block name="base_js"}]
    <!-- Test -->
    [{include file="i18n/js_vars.tpl"}]

    [{oxscript include="js/libs/jquery.min.js" priority=1}]

    [{oxscript include="js/libs/jquery.mCustomScrollbar.concat.min.js" priority=1}]
    [{oxscript include="js/libs/jquery-ui.min.js" priority=1}]
    [{oxscript include="js/libs/jquery.ui.touch-punch.min.js" priority=1}]
    [{oxscript include="fancybox/jquery.fancybox.js" priority=1}]
    [{oxscript include="js/scripts.min.js?xcvousfodiufwoisdfu" priority=1}]
    [{/block}]

[{if $oViewConf->isTplBlocksDebugMode()}]
    [{oxscript include="js/widgets/oxblockdebug.min.js"}]
    [{oxscript add="$( 'hr.debugBlocksStart' ).oxBlockDebug();"}]
    [{/if}]

<!--[if gte IE 9]><style type="text/css">.gradient {filter:none;}</style><![endif]-->
[{oxscript}]

[{if !$oView->isDemoShop()}]
    [{oxid_include_dynamic file="widget/dynscript.tpl"}]
    [{/if}]

[{foreach from=$oxidBlock_pageScript item="_block"}]
    [{$_block}]
    [{/foreach}]

<div id="overlay"[{if $oxcmp_basket->isNewItemAdded() && $oView->getNewBasketItemMsgType() == 2}] class="show"[{/if}]></div>
</body>
</html>
[{php}]

    /*
    * HTML-минимизация
    */
    //$out = ob_get_clean();
    //$out = preg_replace('/(?![^<]*<\/pre>)[\n\r\t]+/', "\n", $out);
    //$out = preg_replace('/ {2,}/', ' ', $out);
    //$out = preg_replace('/>[\n]+/', '>', $out);
    //echo $out;

    [{/php}]