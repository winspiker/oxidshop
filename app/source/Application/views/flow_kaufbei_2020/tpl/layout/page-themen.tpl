[{capture append="oxidBlock_pageBody"}]
    [{if $oView->showRDFa()}]
        [{include file="rdfa/rdfa.tpl"}]
    [{/if}]
    [{block name="layout_header"}]
        [{include file="layout/header.tpl"}]
    [{/block}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
    <div id="wrapper" [{if $sidebar}]class="sidebar[{$sidebar}]"[{/if}]>
        <div class="container">
            <div class="underdog">
                <div class="content-box">
                    <div class="row">
                           <div class="col-sm-12">
                            [{$smarty.capture.loginErrors}]
                            [{if $oView->getClassName() != "start" && !$blHideBreadcrumb}]
                                [{block name="layout_breadcrumb"}]
                                    [{include file="widget/breadcrumb.tpl"}]
                                [{/block}]
                            [{/if}]
                           </div>

                            

                            [{if $oView->getClassName()  == "alist" }]
                                [{if false}]
                                    <div class="hidden-xs hidden-sm col-md-3 [{$oView->getClassName()}]">
                                        <div id="sidebar">
                                            [{if false}]
                                                [{if $oView->getClassName()  == "start"}]
                                                <div class="home-menu-buffer"></div>
                                                    [{/if}]
                                            [{include file="layout/sidebar.tpl"}]
                                            [{/if}]

                                            <button type="button" class="close-sort">Sortieren <i class="far fa-times"></i></button>
                                            <div class="box-filter">
                                                <div class="title-filter">
                                                    <p>KATEGORIEN</p>
                                                    <button type="button" class="btn-hide-filter"><i class="far fa-chevron-down"></i></button>
                                                </div>
                                                <ul class="list-item-filter list-cat">
                                                    <li>
                                                        <a href="#"><i class="far fa-angle-right"></i>Kaffeemaschinen</a>
                                                        <ul>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Kaffeevollautomaten</a></li>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Kaffeepadmaschinen</a></li>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Siebträger-/Espressomaschinen</a></li>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Kaffeepadmaschinen</a></li>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Filterkaffeemaschinen</a></li>
                                                            <li><a href="#"><i class="far fa-angle-right"></i>Espressokocher</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="box-filter">
                                                <div class="title-filter">
                                                    <p>SALE</p>
                                                </div>
                                                <ul class="list-item-filter">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Reduzierte Artikel <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="box-filter">
                                                <div class="title-filter">
                                                    <p>Preis</p>
                                                </div>
                                                <div class="box-filter-prise">
                                                    <div class="line-box">
                                                        <div class="box">0 €</div>
                                                        <div class="box">5166 €</div>
                                                    </div>
                                                    <div class="line-filter">
                                                        <div class="line"></div>
                                                        <span class="dot dot-first"></span>
                                                        <span class="dot dot-second"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="box-filter">
                                                <div class="title-filter">
                                                    <p>FARBE</p>
                                                    <button type="button" class="btn-hide-filter"><i class="far fa-chevron-down"></i></button>
                                                </div>
                                                <ul class="list-item-filter">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Schwarz <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Silber <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Braun <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Grau<span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Weiß <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="box-filter">
                                                <div class="title-filter">
                                                    <p>HERSTELLER</p>
                                                    <button type="button" class="btn-hide-filter"><i class="far fa-chevron-down"></i></button>
                                                </div>
                                                <ul class="list-item-filter">
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Schwarz <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Silber <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Braun <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Grau<span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                    <li>
                                                        <label>
                                                            <input type="checkbox" name="" id="">
                                                            <span class="custom-label">Weiß <span>(43)</span></span>
                                                        </label>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>


                                    </div>
                                [{/if}]
                            [{/if}]
                           
                        
                            [{if $oView->getClassName() != "details"}]
                            <div class="mainpart col-xs-12 [{if $oView->getClassName()  == "alist"}]col-md-12[{else}]col-lg-12[{/if}] [{$oView->getClassName()}]">
                            [{else}]
                            <div class="mainpart col-xs-12 col-lg-12">
                            [{/if}] 
                            <div id="content">
                            [{if $oView->getClassName() == "start"}]
                            <section class="startpage-container">

                                [{block name="dd_widget_promoslider"}]
                                    [{assign var="oBanners" value=$oView->getBanners()}]
                                    [{assign var="currency" value=$oView->getActCurrency()}]
                                    [{if $oBanners|@count}]
                                    <div class="slider-container swiper-container">
                                        <div class="banner-slider swiper-wrapper">   
                                            
                                            [{block name="dd_widget_promoslider_list"}]
                                                [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
                                                    [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
                                                    [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]
                                                    [{if $sBannerPictureUrl}]
                                                    [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                                                        <a href="[{$sBannerLink}]" class="item swiper-slide">

                                                            
                                                            
                                                            <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                                            
                                                            
                                                        </a>
                                                    [{/if}]
                                                [{/foreach}]
                                            [{/block}]
                                        </div>
                                        <button type="button" class="swiper-button-prev"><i class="fal fa-arrow-circle-left"></i></button>
                                        <button type="button" class="swiper-button-next"><i class="fal fa-arrow-circle-right"></i></button>
                                    </div>
                                    [{/if}]
                                [{/block}]
                                
                                <div class="sidebar-teaser">
                                    
                                    <div class="player-box">
                                        <div id="player"></div>
                                    </div>

                                    <div class="daily-offer">
                                        
                                        [{if (method_exists($oView, 'getArticleTimer'))}] 

                                        [{assign var=oArticleTimer value=$oView->getArticleTimer()}]
                                        [{assign var=sArticleTimerTo value=$oView->getArticleTimerTo()}] 
                                        [{assign var="currency" value=$oView->getActCurrency()}]
                                    
                                       
                                        [{assign var="blShowToBasket" value=true}] [{* tobasket or more info ? *}]
                                        [{if $oArticleTimer->isNotBuyable() || $oArticleTimer->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oArticleTimer->getSelections(1)) || $oArticleTimer->getVariants()}]
                                            [{assign var="blShowToBasket" value=false}]
                                        [{/if}]
                                    
                                        [{assign var="showMainLink" value=$oView->getShowMainL}] 
                                        [{if $showMainLink}]
                                            [{assign var='_productLink' value=$oArticleTimer->getMainLink()}] 
                                        [{else}]
                                            [{assign var='_productLink' value=$oArticleTimer->getLink()}]
                                        [{/if}] [{* tobasket or more info ? *}]
                                    
                                        <div data-date='[{$sArticleTimerTo}]' id="article-timer-container" class="wrapp-stock-item productData productBox">
                                            
                                            <div class="daily-offer-title-box">
                                                <div class="title-timer">Tagesangebot</div> 
                                                <div id="article-timer"></div>
                                            </div>
                                            
                                            <form name="tobaskettobaskettopBox_9999" id="tobaskettobaskettopBox_9999" [{if $blShowToBasket}]action="[{$oViewConf->getSelfActionLink()}]"
                                                method="post" [{else}]action="[{$_productLink}]" method="get" [{/if}] class="js-oxProductForm">

                                                <div class="hidden">
                                                    [{$oViewConf->getNavFormParams()}] [{$oViewConf->getHiddenSid()}]
                                                    <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]"> [{if $recommid}]
                                                    <input type="hidden" name="recommid" value="[{$recommid}]"> [{/if}] [{if $blShowToBasket}] [{oxhasrights ident="TOBASKET"}]
                                                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]"> [{if $owishid}]
                                                    <input type="hidden" name="owishid" value="[{$owishid}]"> [{/if}] [{if $toBasketFunction}]
                                                    <input type="hidden" name="fnc" value="[{$toBasketFunction}]"> [{else}]
                                                    <input type="hidden" name="fnc" value="tobasket"> [{/if}]
                                                    <input type="hidden" name="aid" value="[{$oArticleTimer->oxarticles__oxid->value}]"> [{if $altproduct}]
                                                    <input type="hidden" name="anid" value="[{$altproduct}]"> [{else}]
                                                    <input type="hidden" name="anid" value="[{$oArticleTimer->oxarticles__oxnid->value}]"> [{/if}]
                                                    <input type="hidden" name="am" value="1"> [{/oxhasrights}] [{else}]
                                                    <input type="hidden" name="cl" value="details">
                                                    <input type="hidden" name="anid" value="[{$oArticleTimer->oxarticles__oxnid->value}]"> [{/if}]
                                                </div>

                                                

                                                [{block name="widget_product_listitem_infogrid_gridpicture"}]
                                                <div class="picture text-center">
                                    
                                                    <a href="[{$_productLink}]" title="[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]">
                                                    [{$badge}]
                                    
                                                [{if $oArticleTimer->getFTPrice()}]
                                                    [{assign var="oldPrice"    value=$oArticleTimer->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                                                    [{assign var="newPrice"    value=$oArticleTimer->getFMinPrice()|replace:'.':''|replace:',':'.'|floatval }]
                                                                      
                                                    [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)"
                                                            nprice=$newPrice
                                                            hundred=100
                                                            oprice=$oldPrice
                                                    }] 
                                                [{/if}]
                                                        <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                                            <rect class="cls-1" width="364" height="364"/>
                                                        </svg>
                                                        <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oArticleTimer->getThumbnailUrl()}]" alt="[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]"
                                                            class="img-responsive">
                                                    </a>
                                                </div>
                                                [{/block}]
                                    
                                                <div class="listDetails ">
                                                    [{block name="widget_product_listitem_infogrid_titlebox"}]
                                                    <div class="title">
                                                        <a id="[{$testid}]" href="[{$_productLink}]" title="[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]">
                                                            <span>[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]</span>
                                                        </a>
                                                        [{if false}]
                                                        [{block name="details_productmain_artnumber"}]
                                                        <span class="small text-muted" style="display:none">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oArticleTimer->oxarticles__oxartnum->value}]</span>
                                                        [{/block}]
                                                        [{/if}]
                                                    </div>
                                                    [{/block}]
                                    
                                                    [{assign var="oUnitQuantity" value=$oArticleTimer->oxarticles__oxunitquantity->value}]
                                                    [{assign var="oUnitPrice" value=$oArticleTimer->getUnitPrice()}]
                                                    [{block name="details_productmain_priceperunit"}]
                                               
                                                        [{if $oUnitPrice}]
                                                       
                                                        <span class="pricePerUnit">
                                                            [{oxprice price=$oUnitPrice currency=$currency}]/[{$oArticleTimer->getUnitName()}]
                                                        </span>
                                                        [{/if}]
                                                    [{/block}]


                                                    <div class="price">
                                                        <div class="content">
                                                            [{block name="widget_product_listitem_grid_price"}] 
                                                            [{oxhasrights ident="SHOWARTICLEPRICE"}] 
                                                            [{assign var="oUnitPrice" value=$oArticleTimer->getUnitPrice()}]
                                                            [{assign var="tprice" value=$oArticleTimer->getTPrice()}] 
                                                            [{assign var="price" value=$oArticleTimer->getPrice()}]

                                                            [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                                            <span class="oldPrice text-muted">
                                                                <del>[{$oArticleTimer->getFTPrice()}] [{$currency->sign}] UPV</del>
                                                            </span>
                                                            [{/if}] 
                                                            [{block name="widget_product_listitem_line_price_value"}]
                                                            <span id="productPrice_[{$testid}]" class="lead text-nowrap">
                                                                <span class="finalSum">
                                                                    [{if $oArticleTimer->isRangePrice()}] 
                                                                        [{oxmultilang ident="PRICE_FROM"}] 
                                                                        [{if !$oArticleTimer->isParentNotBuyable()}] 
                                                                            [{$oArticleTimer->getFMinPrice()}]
                                                                        [{else}] 
                                                                            [{$oArticleTimer->getFVarMinPrice()}] 
                                                                        [{/if}] 
                                                                    [{else}] 
                                                                        [{if !$oArticleTimer->isParentNotBuyable()}]
                                                                            [{$oArticleTimer->getFPrice()}] 
                                                                        [{else}] 
                                                                            [{$oArticleTimer->getFVarMinPrice()}] 
                                                                        [{/if}] 
                                                                    [{/if}]
                                                                </span>
                                                                <span class="currency">[{$currency->sign}]</span>
                                                                [{if $oView->isVatIncluded()}] [{if !($oArticleTimer->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oArticleTimer->getSelections(1))
                                                                || $oArticleTimer->getVariants())}][{/if}] [{/if}]
                                                            </span>
                                                            [{/block}]
                                    
                                    
                                    
                                    
                                                            <span class="priceDefault" style="display:none">
                                                                [{if $oArticleTimer->isRangePrice()}] [{oxmultilang ident="PRICE_FROM"}] [{if !$oArticleTimer->isParentNotBuyable()}] [{$oArticleTimer->getFMinPrice()}]
                                                                [{else}] [{$oArticleTimer->getFVarMinPrice()}] [{/if}] [{else}] [{if !$oArticleTimer->isParentNotBuyable()}]
                                                                [{$oArticleTimer->getFPrice()}] [{else}] [{$oArticleTimer->getFVarMinPrice()}] [{/if}] [{/if}]
                                                                [{if $oView->isVatIncluded()}] [{if !($oArticleTimer->hasMdVariants() || ($oViewConf->showSelectListsInList()
                                                                && $oArticleTimer->getSelections(1)) || $oArticleTimer->getVariants())}][{/if}] [{/if}]
                                                            </span>
                                    
                                                            [{/oxhasrights}] [{/block}]
                                                        </div>
                                                    </div>


                                                    [{if false}]
                                                    [{block name="widget_product_listitem_grid_tobasket"}]
                                                    <div class="actions wishlistBlock text-center">                                      
                                                        [{if $blShowToBasket}]
                                                            [{oxhasrights ident="TOBASKET"}]
                                                                <div class="cart-ajax btn btn-primary">[{oxmultilang ident="TO_CART"}]</div>
                                                             
                                                            [{/oxhasrights}]
                                                            
                                                        [{else}]
                                                            <a class="btn btn-primary" href="[{$_productLink}]">[{oxmultilang ident="MORE_INFO"}]</a>
                                                        [{/if}]
                                    
                                                    </div>
                                                    [{/block}]
                                                    [{/if}]

                                                    [{if $oArticleTimer->getFTPrice()}]
                                                        [{assign var="oldPrice"    value=$oArticleTimer->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                                                        [{assign var="newPrice"    value=$oArticleTimer->getFMinPrice()|replace:'.':''|replace:',':'.'|floatval }]
                                                                        
                                                        [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)"
                                                                nprice=$newPrice
                                                                hundred=100
                                                                oprice=$oldPrice
                                                        }] 
                                                            
                                                            <div class="size-discount">[{oxmultilang ident="SIE_SPAREN"}] [{$discount|round:0}]%</div>
                                                            
                                                    [{/if}]
                                                </div>
                                            </form>
                                        </div>
                                        [{/if}] 
                                    </div>    
                                    
                                        

                                </div>
                            </section>


                           
  
                            <section class="top-cat">
                                <div class="title-section">
                                    Top-Kategorien
                                </div>
                                <div class="list-top-cat swiper-wrapper">
                                    [{foreach from=$oView->getStartCategories() item=oStartCategory}]
                                        [{assign var="iconUrl" value=$oStartCategory->getIconUrl()}]


                                        <div class="item-cat swiper-slide">

                                            [{if $iconUrl}]
                                                    <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$iconUrl}]" alt="[{$oStartCategory->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">

                                            [{else}]
                                                <div class="box-btn">
                                                    <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                                                </div>
                                               
                                            [{/if}]

                                            <div class="box-description">
                                                <a href="[{$oStartCategory->getLink()}]" class="title">[{$oStartCategory->oxcategories__oxtitle->value}]</a>
                                                <div class="description">[{$oStartCategory->oxcategories__oxdesc->value}]</div>
                                            </div>
                                        </div>

                                    [{/foreach}]    
                                </div>
                            </section>
                            <section class="top-themes">
                                <div class="title-section">
                                    Top-Themen
                                </div>
                                <div class="list-top-themes swiper-wrapper">
<!--
                                    <a href="#" class="item-them swiper-slide">
                                        <img src="[{$oViewConf->getImageUrl()}]top-them-1.jpg" alt="">
                                    </a>
-->
									[{if $oView->getClassName() == "start"}]
										[{ oxcontent ident=topthemen }]
									[{/if}]
                                    
                                </div>
                            </section>
                            [{/if}]
                            [{if $oView->getClassName()=='start' && $oView->getBanners()|@count > 0 && false}]
                                [{include file="widget/promoslider.tpl"}]
                            [{/if}]
                            
                                [{block name="content_main"}]
                                    [{include file="message/errors.tpl"}]
                                    [{foreach from=$oxidBlock_content item="_block"}]
                                        [{$_block}]
                                    [{/foreach}]
                                [{/block}]
                            [{if $oView->getClassName() == "start" && false}]
                                [{ oxcontent ident=homepagedesc }]
                            [{/if}]

                            [{if $oView->getClassName() == "start"}]
                                <section class="section-wrapper--about">
                                    [{ oxcontent ident=homepagedesc }]
                                </section>
                            [{/if}]

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    [{include file="layout/footer.tpl"}]
    <i class="fa fa-angle-up" id="jumptotop"></i>
[{/capture}]
[{include file="layout/base.tpl"}]