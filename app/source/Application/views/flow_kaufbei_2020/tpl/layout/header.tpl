[{if $oViewConf->getTopActionClassName() != 'clearcookies' && $oViewConf->getTopActionClassName() != 'mallstart'}]
    [{oxid_include_widget cl="oxwCookieNote" _parent=$oView->getClassName() nocookie=1}]
[{/if}]
[{block name="header_main"}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]

<div class="wrapp-site">
    <header id="header">
        <div class="container top-row--mobile">

                    <div class="top-row">
                        [{block name="layout_header_logo"}]
                        <div class="box-logo">
                            [{oxifcontent ident=tenyears }]
                            [{oxcontent ident=tenyears}]
                            [{/oxifcontent}]
                            [{assign var="blHolidaySelect" value=$oViewConf->getViewThemeParam('blHolidaySelect')}]
                            <a class="logo" href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                                <img src="[{$oViewConf->getImageUrl()}][{if $blHolidaySelect == 'blackfriday'}]logo-blackfriday.svg[{else}]logo.svg?2[{/if}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                            </a>
                        </div>
                        [{/block}]

                        <div class="top-row--lang">
                            [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                        </div>

                        <div class="top-row--user[{if $oxcmp_user}] top-row--user-loggedin[{/if}]">
                            [{if !$oxcmp_user}]
                            <button type="button" class="top-row--login"><i class="far fa-user" aria-hidden="true"></i><span>[{oxmultilang ident="ANMELDEN"}]</span></button>
                            [{else}]
                            <button type="button" class="top-row--profile"><i class="far fa-user" aria-hidden="true"></i><span class="my-cabinet">[{oxmultilang ident="MY_ACCOUNT"}]</span></button>
                            <span class="prifile--out">
                                <a class="btn btn-danger btn-sm" role="button" href="[{$oViewConf->getLogoutLink()}]" title="[{oxmultilang ident="LOGOUT"}]">
                                <i class="fa fa-power-off"></i> [{oxmultilang ident="LOGOUT"}]
                                </a>
                            <span>
                            [{/if}]
                        </div>
                    </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="header-box">
                        [{block name="layout_header_logo"}]
                        <div class="box-logo">
                            [{oxifcontent ident=tenyears }]
                            [{oxcontent ident=tenyears}]
                            [{/oxifcontent}]
                            [{assign var="blHolidaySelect" value=$oViewConf->getViewThemeParam('blHolidaySelect')}]
                            <a class="logo" href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                                <img src="[{$oViewConf->getImageUrl()}][{if $blHolidaySelect == 'blackfriday'}]logo-blackfriday.svg[{else}]logo.svg?2[{/if}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                            </a>
                        </div>
                        [{/block}]
                        [{if $oView->getClassName() != 'basket'}]
                        <button type="button" class="m-category-toggle">
                            <i class="far fa-bars"></i>
                            <span>[{oxmultilang ident="MENU"}]</span>
                        </button>
                        [{/if}]
                        <div class="m-search-container">
                            [{include file="widget/header/search.tpl"}]
                        </div>
                        <div class="phone-col">


                            <a class="phone-col--number" href="tel:057312451590">
                                <span class="kiconk-icon-phone"></span><span>05731-2451590</span>
                            </a>

                        </div>
                        <div class="top-row">
                            <div class="top-row--lang">
                                [{oxid_include_widget cl="oxwLanguageList" lang=$oViewConf->getActLanguageId() _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
                            </div>

                            <div class="top-row--user[{if $oxcmp_user}] top-row--user-loggedin[{/if}]">
                                [{if !$oxcmp_user}]
                                <button type="button" class="top-row--login"><i class="far fa-user" aria-hidden="true"></i><span>[{oxmultilang ident="ANMELDEN"}]</span></button>
                                <div class="top-row--tooltip">
                                    <button class="top-row--tooltip--close" type="button">
                                        <i class="fal fa-times"></i>
                                    </button>
                                    <div class="top-row--tooltip--inner">
                                        <button type="button" class="btn btn-primary">[{oxmultilang ident="LOGIN"}]</button>
                                        <a class="btn btn-default" role="button" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=register"}]" title="[{oxmultilang ident="NEW_TO_KAUFBEI_JOIN_NOW"}]">[{oxmultilang ident="NEW_TO_KAUFBEI_JOIN_NOW"}]</a>
                                    </div>
                                </div>
                                [{else}]
                                <button type="button" class="top-row--profile"><i class="far fa-user" aria-hidden="true"></i><span class="my-cabinet">[{oxmultilang ident="MY_ACCOUNT"}]</span></button>
                                <span class="prifile--out">
                                <a class="btn btn-danger btn-sm" role="button" href="[{$oViewConf->getLogoutLink()}]" title="[{oxmultilang ident="LOGOUT"}]">
                                <i class="fa fa-power-off"></i> [{oxmultilang ident="LOGOUT"}]
                                </a>
                            <span>
                            [{/if}]
                            </div>
                        </div>
                        <div class="cart-col">
                            <button type="button" class="m-menu">
                                <div class="m-menu--button"><i class="fal fa-user"></i></div>
                            </button>
                            [{block name="layout_header_top"}]
                            [{block name="dd_layout_page_header_icon_menu_minibasket"}]
                            [{* Minibasket Dropdown *}]
                            [{if $oxcmp_basket->getProductsCount()}]
                            [{assign var="blAnon" value=0}]
                            [{assign var="force_sid" value=$oViewConf->getSessionId()}]
                            [{else}]
                            [{assign var="blAnon" value=1}]
                            [{/if}]
                            [{oxid_include_widget cl="oxwMiniBasket" nocookie=$blAnon force_sid=$force_sid}]
                            [{/block}]
                            [{/block}]
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </header>
    [{block name="layout_header_bottom"}]
    [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() sWidgetType="header" _parent=$oView->getClassName() nocookie=1}]
    [{/block}]
[{/block}]
[{insert name="oxid_newbasketitem" tpl="widget/minibasket/newbasketitemmsg.tpl" type="message"}]