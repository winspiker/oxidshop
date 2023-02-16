[{block name="dd_widget_promoslider"}]
    [{assign var="oBanners" value=$oView->getBanners()}]
    [{assign var="currency" value=$oView->getActCurrency()}]
    [{if $oBanners|@count}]


        <div id="promo-carousel" class="flexslider block-shadow">
           <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 848 387" style="display: block;"><defs><style>.cls-1{fill:#ededed;}</style></defs><title>sleleton-slider</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><rect class="cls-1" width="848" height="387"/></g></g></svg>
            <ul class="slides">
              
                [{block name="dd_widget_promoslider_list"}]
                    [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
                        [{assign var="oArticle" value=$oBanner->getBannerArticle()}]
                        [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]
                        [{if $sBannerPictureUrl}]
                            <li class="item">
                                [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                                [{if $sBannerLink}]
                                    <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                [{/if}]
                                <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                [{if $sBannerLink}]
                                    </a>
                                [{/if}]
                                [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $oArticle}]
                                    <p class="flex-caption">
                                        [{if $sBannerLink}]
                                            <a href="[{$sBannerLink}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                                        [{/if}]
                                        <span class="title">[{$oArticle->oxarticles__oxtitle->value}]</span>[{if $oArticle->oxarticles__oxshortdesc->value|trim}]<br/><span class="shortdesc">[{$oArticle->oxarticles__oxshortdesc->value|trim}]</span>[{/if}]
                                        [{if $sBannerLink}]
                                            </a>
                                        [{/if}]
                                    </p>
                                [{/if}]
                            </li>
                        [{/if}]
                    [{/foreach}]
                [{/block}]
            </ul>
        </div>

    [{/if}]
[{/block}]
[{if (method_exists($oView, 'getArticleTimer'))}] [{assign var=oArticleTimer value=$oView->getArticleTimer()}]
    [{assign var=sArticleTimerTo value=$oView->getArticleTimerTo()}] [{assign var="currency" value=$oView->getActCurrency()}]
   
    [{assign var="blShowToBasket" value=true}] [{* tobasket or more info ? *}]
    [{if $oArticleTimer->isNotBuyable() || $oArticleTimer->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oArticleTimer->getSelections(1)) || $oArticleTimer->getVariants()}]
        [{assign var="blShowToBasket" value=false}]
    [{/if}]
    
    [{assign var="showMainLink" value=$oView->getShowMainL}] [{if $showMainLink}]
    [{assign var='_productLink' value=$oArticleTimer->getMainLink()}] [{else}] [{assign var='_productLink' value=$oArticleTimer->getLink()}]
    [{/if}] [{* tobasket or more info ? *}]

    <div data-date='[{$sArticleTimerTo}]' id="article-timer-container" class="wrapp-stock-item productData productBox">
        <div class="title-timer">Tagesangebot</div> 
        <div id="article-timer"></div>
        <form name="tobaskettobaskettopBox_8888" id="tobaskettobaskettopBox_8888" [{if $blShowToBasket}]action="[{$oViewConf->getSelfActionLink()}]"
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
                    <div class="test--badge">
                        <div class="badge-default">-[{$discount|round:0}]%</div>
                    </div>
            [{/if}]
                    <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                        <rect class="cls-1" width="364" height="364"/>
                    </svg>
                    <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oArticleTimer->getThumbnailUrl()}]" alt="[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]"
                        class="img-responsive">
                </a>
            </div>
            [{/block}]

            <div class="listDetails text-center">
                [{block name="widget_product_listitem_infogrid_titlebox"}]
                <div class="title">
                    <a id="[{$testid}]" href="[{$_productLink}]" title="[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]">
                        <span>[{$oArticleTimer->oxarticles__oxtitle->value}] [{$oArticleTimer->oxarticles__oxvarselect->value}]</span>
                    </a>

                    [{block name="details_productmain_artnumber"}]
                    <span class="small text-muted" style="display:none">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oArticleTimer->oxarticles__oxartnum->value}]</span>
                    [{/block}]
                </div>
                [{/block}]

                <div class="price text-center">
                    <div class="content">
                        [{block name="widget_product_listitem_grid_price"}] [{oxhasrights ident="SHOWARTICLEPRICE"}] [{assign var="oUnitPrice" value=$oArticleTimer->getUnitPrice()}]
                        [{assign var="tprice" value=$oArticleTimer->getTPrice()}] [{assign var="price" value=$oArticleTimer->getPrice()}]
                        [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                        <span class="oldPrice text-muted">
                            <del>[{$oArticleTimer->getFTPrice()}] [{$currency->sign}]</del>
                        </span>
                        [{/if}] [{block name="widget_product_listitem_line_price_value"}]
                        <span id="productPrice_[{$testid}]" class="lead text-nowrap">
                            <span class="finalSum">
                                [{if $oArticleTimer->isRangePrice()}] [{oxmultilang ident="PRICE_FROM"}] [{if !$oArticleTimer->isParentNotBuyable()}] [{$oArticleTimer->getFMinPrice()}]
                                [{else}] [{$oArticleTimer->getFVarMinPrice()}] [{/if}] [{else}] [{if !$oArticleTimer->isParentNotBuyable()}]
                                [{$oArticleTimer->getFPrice()}] [{else}] [{$oArticleTimer->getFVarMinPrice()}] [{/if}] [{/if}]
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
            </div>
        </form>
    </div>
    [{/if}] 
                        