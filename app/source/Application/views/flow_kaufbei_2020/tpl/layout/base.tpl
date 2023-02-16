[{* Important ! render page head and body to collect scripts and styles *}]
[{capture append="oxidBlock_pageHead"}]
    [{strip}]
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" id="Viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" content="text/html; charset=[{$oView->getCharSet()}]">


        [{assign var="_sMetaTitlePrefix" value=$oView->getTitlePrefix()}]
        [{assign var="_sMetaTitleSuffix" value=$oView->getTitleSuffix()}]
        [{assign var="_sMetaTitlePageSuffix" value=$oView->getTitlePageSuffix()}]
        [{assign var="_sMetaTitle" value=$oView->getTitle()}]
        [{assign var="_sMetaCategoryId" value=$oView->getCategoryId()}]
        [{assign var="_sMetaLanguageId" value=$oView->getActiveLangAbbr()}]

        [{* Page Title neu selber zusammensetzen *}]

    [{if $oViewConf->getActiveClassName() == 'details'}]

        [{if $_sMetaLanguageId == "de"}]
            [{capture assign="sMetaDescription"}][{if $_sMetaTitle}][{$_sMetaTitle|strip_tags}] kaufen bei Kaufbei.TV ✔ Schnelle Lieferung ✔ Attraktive Preise ✔ Top Service ✔ Jetzt online kaufen![{/if}][{/capture}]
        [{/if}]

        [{if $_sMetaLanguageId == "ru"}]
            [{capture assign="sMetaDescription"}][{if $_sMetaTitle}][{$_sMetaTitle|strip_tags}] купить в Германии ✔ Kaufbei.TV ✔ Быстрая доставка ✔ Приятные цены ✔ Покупайте онлайн прямо сейчас![{/if}][{/capture}]
        [{/if}]

    [{/if}]




    [{assign var=sPageTitle value=$oView->getPageTitle()}]


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
                <meta name="description" content="[{if !$sMetaDescription}][{$oView->getMetaDescription()}][{else}][{$sMetaDescription}][{/if}]">
            [{/if}]
        [{/block}]

        [{block name="head_meta_keywords"}]
            [{if $oView->getMetaKeywords()}]
                <meta name="keywords" content="[{$oView->getMetaKeywords()}]">
            [{/if}]
        [{/block}]

        [{block name="head_meta_open_graph"}]
            <meta property="og:site_name" content="[{$oViewConf->getBaseDir()}]">
            <meta property="og:title" content="[{$sPageTitle}]">
            <meta property="og:description" content="[{$oView->getMetaDescription()}]">
            [{if $oViewConf->getActiveClassName() == 'details'}]
                <meta property="og:type" content="product">
                <meta property="og:image" content="[{$oView->getActPicture()}]">
                <meta property="og:url" content="[{$oView->getCanonicalUrl()}]">
            [{else}]
                <meta property="og:type" content="website">
                <meta property="og:image" content="[{$oViewConf->getImageUrl('logo-kaufbei.png')}]">
                <meta property="og:url" content="[{$oViewConf->getCurrentHomeDir()}]">
            [{/if}]
        [{/block}]

        <meta name="p:domain_verify" content="5fe5d33872f6746e9af500b378ad01ee"/>

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
           	[{oxstyle include="plugins/fancybox/jquery.fancybox.css"}]
            <link rel="preload" as="style" href="[{$oViewConf->getCurrentHomeDir()}]out/flow_kaufbei_2020/src/fonts/icomoon/style.css" onload="this.rel='stylesheet'" />
            <link rel="preload" as="style" href="[{$oViewConf->getCurrentHomeDir()}]out/flow_kaufbei_2020/src/fonts/CeraPro/stylesheet.css" onload="this.rel='stylesheet'"/>
			[{* oxstyle include="fonts/icomoon/style.css" *}]
            [{* oxstyle include="fonts/CeraPro/stylesheet.css" *}]
			[{oxstyle include="player-html/controls.css"}]
           
           	[{oxstyle include="css/badges.css?qqwewe"}]
			[{oxstyle include="css/exonn.css"}] 
           
            [{oxstyle include="css/cookies.css"}]
            <link rel="preload" as="style" href="[{$oViewConf->getCurrentHomeDir()}]out/flow_kaufbei_2020/src/css/fa.css" onload="this.rel='stylesheet'" />
            [{* oxstyle include="css/fa.css" *}]
            [{oxstyle include="css/styles.min.css?xcoiufodsfuygdvfgdjfgsdjfhgsdf"}]
        [{/block}]

        [{block name="base_fonts"}]

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
        [{/block}]
    [{/strip}]
[{/capture}]

[{assign var="blIsCheckout"     value=$oView->getIsOrderStep()}]
[{assign var="blFullwidth"      value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
[{assign var="stickyHeader"     value=$oViewConf->getViewThemeParam('stickyHeader')}]
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
<html lang="[{$oView->getActiveLangAbbr()}]" [{block name="head_html_namespace"}][{/block}]>
    <head>
        <!-- Google tag (gtag.js) -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-ZPJ399BJV2"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'G-ZPJ399BJV2');
        </script>

        <script>
            (function soluteLandingTracking(){
                if (location.href.indexOf("soluteclid") < 0) return;
                localStorage.setItem("soluteclid", (new Date()).getTime()+" "+location.href);
                var url = "https://cmodul.solutenetwork.com/landing";
                url += "?url=" + encodeURIComponent(location.href);
                var req = new XMLHttpRequest();
                req.open("GET", url);
                req.send();
            })();
        </script>

        [{foreach from=$oxidBlock_pageHead item="_block"}]
            [{$_block}]
        [{/foreach}]



    [{if (method_exists($oView, 'getBadgeList'))}]
    <style>
        [{foreach from=$oView->getBadgeList() item=oBadge}]
            [{$oBadge->oxactions__badge_css->value}]
        [{/foreach}]
    </style>
    [{/if}]

    [{if $oContent->oxcontents__oxloadid->value == "tvshoppage" || $oView->getClassName() == "start"}]
	<script type="text/plain" data-cmp-vendor="s1442" data-cmp-src="https://cdn.jsdelivr.net/npm/clappr@latest/dist/clappr.min.js"></script>
   	<script type="text/plain" data-cmp-vendor="s1442"  defer data-cmp-src="https://cdn.jsdelivr.net/gh/clappr/clappr-level-selector-plugin@latest/dist/level-selector.min.js"></script>

    [{/if}]
        <script type="text/plain" data-cmp-vendor="c22226" encoding="utf-8">
            var _tbEmbedArgs = _tbEmbedArgs || [];
            (function () {
                var u =  "https://widget.textback.io/widget";
                _tbEmbedArgs.push(["widgetId", "5205b193-215d-422c-ab02-3733481bed5e"]);
                _tbEmbedArgs.push(["baseUrl", u]);

                var d = document, g = d.createElement("script"), s = d.getElementsByTagName("script")[0];
                g.type = "text/javascript";
                g.charset = "utf-8";
                g.defer = true;
                g.async = true;
                g.src = u + "/widget.js";
                s.parentNode.insertBefore(g, s);
            })();

        </script>

    </head>
    [{assign var="blHolidaySelect" value=$oViewConf->getViewThemeParam('blHolidaySelect')}]
    
    <body style="opacity: 0; overflow: hidden;" class="[{if $blHolidaySelect == 'spring'}]spring[{/if}] [{if $blHolidaySelect == 'newyear'}]new-year [{/if}][{if $blHolidaySelect == 'winter'}]winter [{/if}][{if $blHolidaySelect == 'blackfriday'}]blackfriday [{/if}] cl-[{$oView->getClassName()}][{if $smarty.get.plain == '1'}] popup[{/if}][{if $blIsCheckout}] is-checkout[{/if}][{if $oxcmp_user && $oxcmp_user->oxuser__oxpassword->value}] is-logged-in[{/if}][{if !$stickyHeader}] static-header[{/if}]">
    <script>window.gdprAppliesGlobally=true;if(!("cmp_id" in window)){window.cmp_id=39052}if(!("cmp_params" in window)){window.cmp_params=""}if(!("cmp_host" in window)){window.cmp_host="a.delivery.consentmanager.net"}if(!("cmp_cdn" in window)){window.cmp_cdn="cdn.consentmanager.net"}if(!("cmp_proto" in window)){window.cmp_proto="https:"}window.cmp_getsupportedLangs=function(){var b=["DE","EN","FR","IT","NO","DA","FI","ES","PT","RO","BG","ET","EL","GA","HR","LV","LT","MT","NL","PL","SV","SK","SL","CS","HU","RU","SR","ZH","TR","UK","AR","BS"];if("cmp_customlanguages" in window){for(var a=0;a<window.cmp_customlanguages.length;a++){b.push(window.cmp_customlanguages[a].l.toUpperCase())}}return b};window.cmp_getRTLLangs=function(){return["AR"]};window.cmp_getlang=function(j){if(typeof(j)!="boolean"){j=true}if(j&&typeof(cmp_getlang.usedlang)=="string"&&cmp_getlang.usedlang!==""){return cmp_getlang.usedlang}var g=window.cmp_getsupportedLangs();var c=[];var f=location.hash;var e=location.search;var a="languages" in navigator?navigator.languages:[];if(f.indexOf("cmplang=")!=-1){c.push(f.substr(f.indexOf("cmplang=")+8,2).toUpperCase())}else{if(e.indexOf("cmplang=")!=-1){c.push(e.substr(e.indexOf("cmplang=")+8,2).toUpperCase())}else{if("cmp_setlang" in window&&window.cmp_setlang!=""){c.push(window.cmp_setlang.toUpperCase())}else{if(a.length>0){for(var d=0;d<a.length;d++){c.push(a[d])}}}}}if("language" in navigator){c.push(navigator.language)}if("userLanguage" in navigator){c.push(navigator.userLanguage)}var h="";for(var d=0;d<c.length;d++){var b=c[d].toUpperCase();if(g.indexOf(b)!=-1){h=b;break}if(b.indexOf("-")!=-1){b=b.substr(0,2)}if(g.indexOf(b)!=-1){h=b;break}}if(h==""&&typeof(cmp_getlang.defaultlang)=="string"&&cmp_getlang.defaultlang!==""){return cmp_getlang.defaultlang}else{if(h==""){h="EN"}}h=h.toUpperCase();return h};(function(){var n=document;var p=window;var f="";var b="_en";if("cmp_getlang" in p){f=p.cmp_getlang().toLowerCase();if("cmp_customlanguages" in p){for(var h=0;h<p.cmp_customlanguages.length;h++){if(p.cmp_customlanguages[h].l.toUpperCase()==f.toUpperCase()){f="en";break}}}b="_"+f}function g(e,d){var l="";e+="=";var i=e.length;if(location.hash.indexOf(e)!=-1){l=location.hash.substr(location.hash.indexOf(e)+i,9999)}else{if(location.search.indexOf(e)!=-1){l=location.search.substr(location.search.indexOf(e)+i,9999)}else{return d}}if(l.indexOf("&")!=-1){l=l.substr(0,l.indexOf("&"))}return l}var j=("cmp_proto" in p)?p.cmp_proto:"https:";var o=["cmp_id","cmp_params","cmp_host","cmp_cdn","cmp_proto"];for(var h=0;h<o.length;h++){if(g(o[h],"%%%")!="%%%"){window[o[h]]=g(o[h],"")}}var k=("cmp_ref" in p)?p.cmp_ref:location.href;var q=n.createElement("script");q.setAttribute("data-cmp-ab","1");var c=g("cmpdesign","");var a=g("cmpregulationkey","");q.src=j+"//"+p.cmp_host+"/delivery/cmp.php?id="+p.cmp_id+"&h="+encodeURIComponent(k)+(c!=""?"&cmpdesign="+encodeURIComponent(c):"")+(a!=""?"&cmpregulationkey="+encodeURIComponent(a):"")+("cmp_params" in p?"&"+p.cmp_params:"")+(n.cookie.length>0?"&__cmpfcc=1":"")+"&l="+f.toLowerCase()+"&o="+(new Date()).getTime();q.type="text/javascript";q.async=true;if(n.currentScript){n.currentScript.parentElement.appendChild(q)}else{if(n.body){n.body.appendChild(q)}else{var m=n.getElementsByTagName("body");if(m.length==0){m=n.getElementsByTagName("div")}if(m.length==0){m=n.getElementsByTagName("span")}if(m.length==0){m=n.getElementsByTagName("ins")}if(m.length==0){m=n.getElementsByTagName("script")}if(m.length==0){m=n.getElementsByTagName("head")}if(m.length>0){m[0].appendChild(q)}}}var q=n.createElement("script");q.src=j+"//"+p.cmp_cdn+"/delivery/js/cmp"+b+".min.js";q.type="text/javascript";q.setAttribute("data-cmp-ab","1");q.async=true;if(n.currentScript){n.currentScript.parentElement.appendChild(q)}else{if(n.body){n.body.appendChild(q)}else{var m=n.getElementsByTagName("body");if(m.length==0){m=n.getElementsByTagName("div")}if(m.length==0){m=n.getElementsByTagName("span")}if(m.length==0){m=n.getElementsByTagName("ins")}if(m.length==0){m=n.getElementsByTagName("script")}if(m.length==0){m=n.getElementsByTagName("head")}if(m.length>0){m[0].appendChild(q)}}}})();window.cmp_addFrame=function(b){if(!window.frames[b]){if(document.body){var a=document.createElement("iframe");a.style.cssText="display:none";a.name=b;document.body.appendChild(a)}else{window.setTimeout(window.cmp_addFrame,10,b)}}};window.cmp_rc=function(h){var b=document.cookie;var f="";var d=0;while(b!=""&&d<100){d++;while(b.substr(0,1)==" "){b=b.substr(1,b.length)}var g=b.substring(0,b.indexOf("="));if(b.indexOf(";")!=-1){var c=b.substring(b.indexOf("=")+1,b.indexOf(";"))}else{var c=b.substr(b.indexOf("=")+1,b.length)}if(h==g){f=c}var e=b.indexOf(";")+1;if(e==0){e=b.length}b=b.substring(e,b.length)}return(f)};window.cmp_stub=function(){var a=arguments;__cmapi.a=__cmapi.a||[];if(!a.length){return __cmapi.a}else{if(a[0]==="ping"){if(a[1]===2){a[2]({gdprApplies:gdprAppliesGlobally,cmpLoaded:false,cmpStatus:"stub",displayStatus:"hidden",apiVersion:"2.0",cmpId:31},true)}else{a[2]({gdprAppliesGlobally:gdprAppliesGlobally,cmpLoaded:false},true)}}else{if(a[0]==="getUSPData"){a[2]({version:1,uspString:window.cmp_rc("")},true)}else{if(a[0]==="getTCData"){__cmapi.a.push([].slice.apply(a))}else{if(a[0]==="addEventListener"||a[0]==="removeEventListener"){__cmapi.a.push([].slice.apply(a))}else{if(a.length==4&&a[3]===false){a[2]({},false)}else{__cmapi.a.push([].slice.apply(a))}}}}}}};window.cmp_msghandler=function(d){var a=typeof d.data==="string";try{var c=a?JSON.parse(d.data):d.data}catch(f){var c=null}if(typeof(c)==="object"&&c!==null&&"__cmpCall" in c){var b=c.__cmpCall;window.__cmp(b.command,b.parameter,function(h,g){var e={__cmpReturn:{returnValue:h,success:g,callId:b.callId}};d.source.postMessage(a?JSON.stringify(e):e,"*")})}if(typeof(c)==="object"&&c!==null&&"__cmapiCall" in c){var b=c.__cmapiCall;window.__cmapi(b.command,b.parameter,function(h,g){var e={__cmapiReturn:{returnValue:h,success:g,callId:b.callId}};d.source.postMessage(a?JSON.stringify(e):e,"*")})}if(typeof(c)==="object"&&c!==null&&"__uspapiCall" in c){var b=c.__uspapiCall;window.__uspapi(b.command,b.version,function(h,g){var e={__uspapiReturn:{returnValue:h,success:g,callId:b.callId}};d.source.postMessage(a?JSON.stringify(e):e,"*")})}if(typeof(c)==="object"&&c!==null&&"__tcfapiCall" in c){var b=c.__tcfapiCall;window.__tcfapi(b.command,b.version,function(h,g){var e={__tcfapiReturn:{returnValue:h,success:g,callId:b.callId}};d.source.postMessage(a?JSON.stringify(e):e,"*")},b.parameter)}};window.cmp_setStub=function(a){if(!(a in window)||(typeof(window[a])!=="function"&&typeof(window[a])!=="object"&&(typeof(window[a])==="undefined"||window[a]!==null))){window[a]=window.cmp_stub;window[a].msgHandler=window.cmp_msghandler;window.addEventListener("message",window.cmp_msghandler,false)}};window.cmp_addFrame("__cmapiLocator");window.cmp_addFrame("__cmpLocator");window.cmp_addFrame("__uspapiLocator");window.cmp_addFrame("__tcfapiLocator");window.cmp_setStub("__cmapi");window.cmp_setStub("__cmp");window.cmp_setStub("__tcfapi");window.cmp_setStub("__uspapi");</script>







    [{block name="theme_svg_icons"}]
        <div style="display: none;">
            [{include file="layout/svg/shoppingbag.svg" count=$oxcmp_basket->getItemsCount()}]
        </div>
    [{/block}]

                [{foreach from=$oxidBlock_pageBody item="_block"}]
                    [{$_block}]
                [{/foreach}]


        [{foreach from=$oxidBlock_pagePopup item="_block"}]
            [{$_block}]
        [{/foreach}]

        [{if $oViewConf->getTopActiveClassName() == 'details' && $oView->showZoomPics()}]
            [{include file="page/details/inc/photoswipe.tpl"}]
        [{/if}]

        [{block name="base_style"}]
			[{oxstyle include="plugins/owl-carousel/assets/owl.carousel.css"}]
			[{oxstyle include="plugins/owl-carousel/assets/owl.theme.default.css"}]

		[{/block}]

        [{block name="base_js"}]
            [{include file="i18n/js_vars.tpl"}]

            [{if $oContent->oxcontents__oxloadid->value == "tvshoppage" || $oView->getClassName() == "start"}]
            [{oxscript include="js/libs/clappr.min.js" priority=1}]
            [{oxscript include="js/libs/level-selector.min.js" priority=1}]
            [{/if}]



            [{oxscript include="js/libs/jquery.min.js" priority=1}]
            [{oxscript include="js/libs/jquery-ui.min.js" priority=1}]
            [{oxscript include="js/libs/jquery.cookie.min.js" priority=1}]

            [{oxscript include="js/libs/jquery.mb-comingsoon.min.js" priority=1}]

            [{oxscript include="plugins/fancybox/jquery.fancybox.js" priority=1}]
			[{oxscript include="plugins/owl-carousel/owl.carousel.min.js" priority=1}]
			[{oxscript include="plugins/sly/sly.min.js" priority=1}]
			[{oxscript include="plugins/thdoan-magnify/js/jquery.magnify.js" priority=1}]
            [{oxscript include="plugins/sharebuttons/dist/share-buttons.js" priority=1}]


        	[{oxscript include="js/scripts.min.js?zcvouixygiuydfiugthekghkhrekherkhrek" priority=1}]
        [{/block}]

        [{if $oViewConf->isTplBlocksDebugMode()}]
            [{oxscript include="js/widgets/oxblockdebug.min.js"}]
            [{oxscript add="$( 'body' ).oxBlockDebug();"}]
        [{/if}]


    <div id="share-popup" style="display: none;">
        <div class="share-popup">
            <div class="share-popup--title">[{oxmultilang ident="SHARE"}]</div>
            <div class="share-btn"[{if $canonical_url}] data-url="[{$canonical_url}]"[{/if}]>
                <a class="btn-vk" data-id="vk"><i class="fab fa-vk"></i></a>
                <a class="btn-facebook" data-id="fb"><i class="fab fa-facebook-square"></i></a>
                <a class="btn-twitter" data-id="tw"><i class="fab fa-twitter"></i></a>
                <a class="btn-telegram" data-id="tg"><i class="fab fa-telegram"></i></a>
                <a class="btn-skype" data-id="sk"><i class="fab fa-skype"></i></a>
                <a class="btn-whatsapp" data-id="wa"><i class="fab fa-whatsapp"></i></a>
                <a class="btn-ok" data-id="ok"><i class="fab fa-odnoklassniki"></i></a>
                <a class="btn-mail" data-id="mail"><i class="fas fa-at"></i></a>
            </div>
            [{if $canonical_url}]
            <div class="share-popup--copy-url">
                <div class="share-popup--copy-url--input">
                    <input type="text" readonly value="[{$canonical_url}]">
                </div>
                <button class="share-popup--copy-url--button" type="button">
                    <i class="far fa-copy"></i>
                    <i class="far fa-check"></i>
                </button>
            </div>
            [{/if}]
        </div>
    </div>

        <!--[if gte IE 9]><style type="text/css">.gradient {filter:none;}</style><![endif]-->
        [{oxscript}]

        [{if !$oView->isDemoShop()}]
            [{oxid_include_dynamic file="widget/dynscript.tpl"}]
        [{/if}]

        [{foreach from=$oxidBlock_pageScript item="_block"}]
            [{$_block}]
        [{/foreach}]





     [{oxstyle}]

    <noscript id="deferred-styles2">

    </noscript>
    <script>
        var loadDeferredStyles2 = function () {
            var addStylesNode2 = document.getElementById("deferred-styles2");
            var replacement2 = document.createElement("div");
            replacement2.innerHTML = addStylesNode2.textContent;
            document.body.appendChild(replacement2)
            addStylesNode2.parentElement.removeChild(addStylesNode2);
        };
        var raf = requestAnimationFrame || mozRequestAnimationFrame ||
            webkitRequestAnimationFrame || msRequestAnimationFrame;
        if (raf) raf(function () {
            window.setTimeout(loadDeferredStyles2, 0);
        });
        else window.addEventListener('load', loadDeferredStyles2);
    </script>
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "Organization",
            "name": "Kaufbei.TV",
            "url": "https://www.kaufbei.tv",
            "sameAs": [
                "https://www.facebook.com/kaufebei.tv"
            ]
        }
    </script>
    [{* exonn Start PayPal Ratenzahlung *}]
    <script
        [{assign var="sPayPalSandboxId" value="AZhYa7dhaKv25PYQGZJMnueBEQ_nfhfsXL_lLf6EgzTljcnLokggLYk64tokwJGaszXfMjHsJ5yeNGrd"}]
        [{assign var="sPayPalId" value="Aai5-14y2MJuReyu21kUEsFOLX6sFS_c_RG5_p0bTj86l3rgXvLU89FQW7qgZ2gQCVPcJITia_68GIP0"}]
        src="https://www.paypal.com/sdk/js?client-id=[{$sPayPalSandboxId}]&currency=EUR&components=messages"
        data-namespace="PayPalSDK"
    ></script>
    [{* exonn Ende PayPal Ratenzahlung *}]

    [{oxscript}]
    <div class="nav_overlay" style="display: none;"></div>
    <div class="livesearch_overlay" style="display: none;"></div>

    <button type="button" class="close-sort"><i class="far fa-times"></i></button>
    </body>
</html>
