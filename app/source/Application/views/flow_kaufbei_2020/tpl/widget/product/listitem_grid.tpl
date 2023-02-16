[{block name="widget_product_listitem_grid"}]
    [{assign var="product"         value=$oView->getProduct()}]
    [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
    [{assign var="iIndex"          value=$oView->getIndex()}]
    [{assign var="showMainLink"    value=$oView->getShowMainL}]

    [{assign var="currency" value=$oView->getActCurrency()}]
    [{if $showMainLink}]
    [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
    [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]
    [{assign var="aVariantSelections" value=$product->getVariantSelections(null,null,1)}]
    [{assign var="blShowToBasket" value=true}] [{* tobasket or more info ? *}]
    [{if $blDisableToCart || $product->isNotBuyable() || ($aVariantSelections&&$aVariantSelections.selections) || $product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants()}]
    [{assign var="blShowToBasket" value=false}]
    [{/if}]


    <form name="tobasket[{$testid}]" id="tobasket[{$testid}]" [{if $blShowToBasket}]action="[{$oViewConf->getSelfActionLink()}]" method="post"[{else}]action="[{$_productLink}]" method="get"[{/if}]>

        [{assign var="cross" value='_'|explode:$testid}]


        [{if $cross[0] != 'cross' && $cross[0] != 'accessories'}]
        <div class="hidden">
            [{$oViewConf->getNavFormParams()}]
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]">
            [{if $recommid}]
        <input type="hidden" name="recommid" value="[{$recommid}]">
            [{/if}]
            [{if $blShowToBasket}]
            [{oxhasrights ident="TOBASKET"}]
        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
            [{if $owishid}]
        <input type="hidden" name="owishid" value="[{$owishid}]">
            [{/if}]
            [{if $toBasketFunction}]
        <input type="hidden" name="fnc" value="[{$toBasketFunction}]">
            [{else}]
        <input type="hidden" name="fnc" value="tobasket">
            [{/if}]
        <input type="hidden" name="aid" value="[{$product->oxarticles__oxid->value}]">
            [{if $altproduct}]
        <input type="hidden" name="anid" value="[{$altproduct}]">
            [{else}]
        <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
            [{/if}]
        <input type="hidden" name="am" value="1">
            [{/oxhasrights}]
            [{else}]
        <input type="hidden" name="cl" value="details">
        <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
            [{/if}]
        </div>
        [{/if}]


        [{if $product->getFTPrice()}]

        <div class="top-line-sale">
            <!-- <div class="label-best-seller">BESTELLER</div> -->
            <div class="label-discount">%</div>
        </div>
        [{/if}]

        [{block name="widget_product_listitem_infogrid_gridpicture"}]
        [{if $product->oxarticles__exonn_cool_shipping->value == 'cool_transport' }]
        <div class="cool-shipping-icons">
            <i class="fas fa-snowflake"></i>
        </div>
        [{elseif $product->oxarticles__exonn_cool_shipping->value == 'frozen_transport'}]
        <div class="cool-shipping-icons">
            <i class="fas fa-snowflake"></i>
            <i class="fas fa-snowflake"></i>
        </div>
        [{/if}]
        <div class="picture text-center">

            <a href="[{$_productLink}]" class="img-loader" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">

                [{$badge}]

                <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                    <rect class="cls-1" width="364" height="364"/>
                </svg>
                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->getTabslImageTag($product->oxarticles__tabsl_imagetag1->value) }]" title="[{$product->getTabslImageTag($product->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">
            </a>
        </div>
        [{/block}]

        <div class="listDetails">
            [{block name="widget_product_listitem_infogrid_titlebox"}]

            <a id="[{$testid}]" href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                <span>[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
            </a>

            [{if false}]
            [{block name="details_productmain_artnumber"}]
            <span class="small text-muted" style="display:none">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$product->oxarticles__oxartnum->value}]</span>
            [{/block}]
            [{/if}]

            [{/block}]




            [{assign var="oUnitQuantity" value=$product->oxarticles__oxunitquantity->value}]
            [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
            [{block name="details_productmain_priceperunit"}]

            [{if $oUnitPrice}]

            <span class="pricePerUnit">
                    [{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}]
                </span>
            [{/if}]
            [{/block}]
            [{* $category->oxcategories__oxtitle->value == 'Honig Sets' *}]



            <div class="price">
                <div class="content">
                    [{if false}]
                    [{* article number *}]
                    [{block name="details_productmain_artnumber"}]
                    <div class="text-art">Art.: [{$product->oxarticles__oxartnum->value}]</div>
                    [{/block}]
                    [{/if}]

                    [{block name="widget_product_listitem_grid_price"}]
                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                    [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
                    [{assign var="tprice"     value=$product->getTPrice()}]
                    [{assign var="price"      value=$product->getPrice()}]

                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                    <span class="oldPrice text-muted">
                                    <del>[{$product->getFTPrice()}] [{$currency->sign}] UVP</del>
                                </span>
                    [{/if}]

                    [{block name="widget_product_listitem_line_price_value"}]
                    <span id="productPrice_[{$testid}]" class="lead text-nowrap">
                                    <span class="finalSum">[{if $product->isRangePrice()}]<span class="sup-ab">[{oxmultilang ident="PRICE_FROM"}]</span>[{if !$product->isParentNotBuyable()}][{assign var="finalSum" value=$product->getFMinPrice() }][{else}][{assign var="finalSum" value=$product->getFVarMinPrice() }][{/if}][{else}][{if !$product->isParentNotBuyable()}][{assign var="finalSum" value=$product->getFPrice() }][{else}][{assign var="finalSum" value=$product->getFVarMinPrice() }][{/if}][{/if}][{assign var="finalSumParts" value=','|explode:$finalSum }][{$finalSumParts.0}]<span class="sup-price">[{$finalSumParts.1}]</span></span>
                                    <span class="currency">[{$currency->sign}]</span>
                                    [{if $oView->isVatIncluded()}]
                                        [{if !($product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants())}][{/if}]
                                    [{/if}]
                                </span>
                    [{/block}]





                    <span class="priceDefault" style="display:none" >
                               [{if $product->isRangePrice()}]
                                        [{oxmultilang ident="PRICE_FROM"}]
                                        [{if !$product->isParentNotBuyable()}]
                                            [{$product->getFMinPrice()}]
                                        [{else}]
                                            [{$product->getFVarMinPrice()}]
                                        [{/if}]
                                    [{else}]
                                        [{if !$product->isParentNotBuyable()}]
                                            [{$product->getFPrice()}]
                                        [{else}]
                                            [{$product->getFVarMinPrice()}]
                                        [{/if}]
                                    [{/if}]

                                    [{if $oView->isVatIncluded()}]
                                        [{if !($product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants())}][{/if}]
                                    [{/if}]
                            </span>

                    [{/oxhasrights}]
                    [{/block}]
                </div>
            </div>

            [{if false}]
            [{block name="widget_product_listitem_grid_tobasket"}]
            <div class="actions wishlistBlock">

                [{if $blShowToBasket}]
                [{oxhasrights ident="TOBASKET"}]
                <div class="cart-ajax btn btn-primary">[{oxmultilang ident="TO_CART"}]</div>

                [{/oxhasrights}]

                [{else}]
                <a class="btn btn-primary" href="[{$_productLink}]">[{oxmultilang ident="MORE_INFO"}]</a>
                [{/if}]

                [{if $oxcmp_user}]
                [{if $product->isArticleInNoticeList()}]
                <a class="btn actions--add-wishlist wishlist-is hasTooltip wishlist-ajax" href="#" data-placement="bottom" title="[{oxmultilang ident="DD_DELETE_ARTICLE"}]"><i class="fa fa-heart" aria-hidden="true"></i></a>

                [{else}]
                <a class="btn actions--add-wishlist wishlist-not hasTooltip wishlist-ajax" href="#" data-placement="bottom" title="[{oxmultilang ident="ADD_TO_WISH_LIST"}]"><i class="fa fa-heart" aria-hidden="true"></i></a>
                [{/if}]

                [{else}]

                <a class="btn actions--add-wishlist" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]" data-placement="bottom" title="[{oxmultilang ident="ADD_TO_WISH_LIST"}]"><span>[{oxmultilang ident="ADD_TO_WISH_LIST"}]</span> <i class="fa fa-heart" aria-hidden="true"></i></a>
                [{/if}]




            </div>
            [{/block}]
            [{/if}]

            [{if $product->getFTPrice()}]
            [{assign var="oldPrice"    value=$product->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
            [{assign var="newPrice"    value=$finalSum|replace:'.':''|replace:',':'.'|floatval }]

            [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)"
            nprice=$newPrice
            hundred=100
            oprice=$oldPrice
            }]

            <div class="size-discount">[{oxmultilang ident="SIE_SPAREN"}] [{$discount|round:0}]%</div>

            [{/if}]
            <div class="text-art">Art.: [{$product->oxarticles__oxartnum->value}]</div>
            <div class="product-list-versandkosten">

                [{oxmultilang ident="PAGE_PRICE_INFO"}], <a href="[{ oxgetseourl ident="oxdeliveryinfo" type="oxcontent" }]" target="_blank">[{oxmultilang ident="PAGE_PRICE_INFO_VERSAND"}]</a>
            </div>
            [{if $cross[0] != 'cross'}]
            <div class="actions wishlistBlock text-center">
                [{if $blShowToBasket && $product->oxarticles__oxstockflag->value != 3}]
                [{oxhasrights ident="TOBASKET"}]
                <div class="cart-ajax btn btn-primary">[{oxmultilang ident="TO_CART"}]</div>

                [{/oxhasrights}]

                [{else}]
                <a class="btn btn-primary" href="[{$_productLink}]">[{oxmultilang ident="MORE_INFO"}]</a>
                [{/if}]

                [{if $oxcmp_user}]
                [{if $product->isArticleInNoticeList()}]
                <a class="btn actions--add-wishlist wishlist-is hasTooltip wishlist-ajax" href="#" data-placement="bottom" title="[{oxmultilang ident="DD_DELETE_ARTICLE"}]"><i class="fa fa-heart" aria-hidden="true"></i></a>

                [{else}]
                <a class="btn actions--add-wishlist wishlist-not hasTooltip wishlist-ajax" href="#" data-placement="bottom" title="[{oxmultilang ident="ADD_TO_WISH_LIST"}]"><i class="fa fa-heart" aria-hidden="true"></i></a>
                [{/if}]

                [{else}]

                <a class="btn actions--add-wishlist" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]" data-placement="bottom" title="[{oxmultilang ident="ADD_TO_WISH_LIST"}]"><span>[{oxmultilang ident="ADD_TO_WISH_LIST"}]</span> <i class="fa fa-heart" aria-hidden="true"></i></a>
                [{/if}]




            </div>
            [{/if}]
        </div>
    </form>
    [{/block}]