[{if $oxcmp_basket->getProductsCount() gte 5}]
    [{assign var="blScrollable" value=true}]
[{/if}]
[{block name="widget_minibasket"}]
    [{if $oxcmp_basket->getProductsCount()}]
        [{oxhasrights ident="TOBASKET"}]
            [{assign var="currency" value=$oView->getActCurrency()}]
            <div class="basketFlyout" id="basketModal" >
                <div class="popup-button-container">
                    <button type="button" class="btn btn-default cart-box--toggle" ><i class="fa fa-chevron-left" aria-hidden="true"></i><span>[{oxmultilang ident="DD_MINIBASKET_CONTINUE_SHOPPING"}]</span></button>
                    <div class="popup-button-container-group">

                        [{*
                                <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" class="btn btn-default" onclick="ga('send', 'event', 'Warenkorb zeigen', 'To cart');"><span class="kiconk-icon-cart"></span><span>[{oxmultilang ident="DISPLAY_BASKET"}]</span></a>
                                [{if $oxcmp_user}]
                                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=payment"}]" class="btn btn-primary" onclick="ga('send', 'event', 'Zur Kasse', 'To payment');">[{oxmultilang ident="CHECKOUT"}]</a>
                                [{else}]
                                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]" class="btn btn-primary" onclick="ga('send', 'event', 'Zur Kasse', 'To payment');">[{oxmultilang ident="CHECKOUT"}]</a>
                                [{/if}]
                                *}]
                    </div>
                </div>
                <div class="popup-form-title">
                    [{$oxcmp_basket->getItemsCount()}] [{oxmultilang ident="ITEMS_IN_BASKET"}]
                </div>
                            <div class="cart-body">
                                [{if $oxcmp_basket->getProductsCount()}]
                                    [{oxhasrights ident="TOBASKET"}]
                                        <form name="basket[{$basketindex}]" id="basket_form" action="[{$oViewConf->getSelfActionLink()}]" method="post">
                                        [{$oViewConf->getHiddenSid()}]
                                        <input type="hidden" name="cl" value="basket">
                                        <input type="hidden" name="fnc" value="changebasket">
                                        <input type="hidden" name="CustomError" value="basket">
                                        <div id="[{$_prefix}]basketFlyout" class="basketFlyout">
                                            <div class="cart-list">

                                                <div class="cart-list--content">
                                                    <ul>
                                                        [{foreach key=basketindex from=$oxcmp_basket->getContents() name=miniBasketList item=_product}]
                                                        <li class="cart-list--item">
                                                            [{block name="widget_minibasket_product"}]
                                                                [{assign var="minibasketItemTitle" value=$_product->getTitle()}]
                                                                <span class="cart-list--item-thumb">
                                                                    <a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]"><img src="[{$_product->getIconUrl()}]" alt="[{$minibasketItemTitle}]">
                                                                    [{if $_product->isBundle() || $_product->isDiscountArticle()}]
                                                                    	<span class="gift--triangle"><i class="fa fa-gift" aria-hidden="true"></i></span>
                                                                    [{/if}]
                                                                    </a>
                                                            	</span>
                                                            <span class="cart-list--item-info">
                                                                                <span class="cart-list--item-info-left">
                                                                                    <span class="cart-list--item-info-title">
                                                                                    	<a href="[{$_product->getLink()}]" title="[{$minibasketItemTitle|strip_tags}]">[{$minibasketItemTitle|strip_tags}]</a>
                                                                                    </span>

                                                                                    <span class="cart-list--item-info-right">
                                                                                        <span class="cart-list--item-price">
                                                                                              [{oxprice price=$_product->getPrice() currency=$currency}]
                                                                                         </span>
                                                                                        [{if !$_product->isBundle() || !$_product->isDiscountArticle()}]
                                                                                        <div class="number-icon">
                                                                                            <button type="button" class="number down"><span></span></button>
                                                                                            <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$_product->getProductId()}]">
                                                                                            <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                                                                                            <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                                                                                            [{if $_product->isBundle()}]
                                                                                                <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                                                                                            [{/if}]

                                                                                            [{if $_product->isBundle()}]
                                                                                                <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                                                                                            [{/if}]
                                                                                            [{if !$_product->isBundle() || !$_product->isDiscountArticle()}]
                                                                                                <input id="am_[{$smarty.foreach.basketContents.iteration}]" type="text" class="textbox" name="aproducts[[{$basketindex}]][am]" value="[{$_product->getAmount()}]" size="3" min="1">
                                                                                            [{/if}]
                                                                                            <button type="button" class="number up"><span></span><span></span></button>
                                                                                        </div>
                                                                                        [{/if}]

                                                                                        [{if $_product->getdBundledAmount() > 0 && ($_product->isBundle() || $_product->isDiscountArticle())}]
                                                                                            <span class="gift--product">+[{$_product->getdBundledAmount()}]</span>
                                                                                        [{/if}]

                                                                                        </span>
                                                                                     </span>



                                                                                </span>



                                                            [{if !$_product->isBundle() || !$_product->isDiscountArticle()}]
                                                            <span class="cart-list--item-info-remove" onclick="document.getElementById( 'aproducts_[{$basketindex}]_remove' ).value = '1';">
                                                                                    <i class="far fa-trash-alt"></i>
                                                                                    </span>
                                                            <input type="hidden" name="aproducts[[{$basketindex}]][remove]" id="aproducts_[{$basketindex}]_remove" value="0">
                                                            [{/if}]
                                                            [{/block}]
                                                        </li>
                                                        [{/foreach}]
                                                    </ul>
                                                </div>
                                                <div class="cart-list--total">
                                                    <ul>
                                                        <li class="cart-list--total-title">[{oxmultilang ident="TOTAL"}]:</li>
                                                        <li class="cart-list--total-price">
                                                            [{if $oxcmp_basket->isPriceViewModeNetto()}]
                                                                                [{$oxcmp_basket->getProductsNetPrice()}]
                                                                            [{else}]
                                                                                [{$oxcmp_basket->getFProductsPrice()}]
                                                                            [{/if}]
                                                                            [{$currency->sign}]
                                                        </li>
                                                    </ul>
                                                    <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=basket"}]" class="btn btn-primary" onclick="ga('send', 'event', 'Zur Kasse New', 'To payment new');"><span>[{oxmultilang ident="CHECKOUT"}]</span></a>
                                                </div>
                                            </div>
                                            [{include file="widget/minibasket/countdown.tpl"}]
                                        </div>
                                        </form>
                                    [{/oxhasrights}]
                                [{/if}]
                            </div>

                </div>
        [{/oxhasrights}]
    [{else}]
        [{block name="dd_layout_page_header_icon_menu_minibasket_alert_empty"}]
        <div class="basketFlyout" id="basketModal" >
            <div class="cart-empty">[{oxmultilang ident="BASKET_EMPTY"}]</div>
        </div>
        [{/block}]
    [{/if}]
[{/block}]