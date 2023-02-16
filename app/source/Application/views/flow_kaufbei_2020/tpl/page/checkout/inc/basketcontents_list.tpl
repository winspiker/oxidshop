<div id="basket_list" class="list-unstyled[{if $oViewConf->getActiveClassName() == 'order'}] orderBasketItems[{/if}] gridView--basket basketTotalForm--container">
    [{* basket items *}]
    [{assign var="basketitemlist" value=$oView->getBasketArticles()}]
    [{foreach key=basketindex from=$oxcmp_basket->getContents() item=basketitem name=basketContents}]
        [{block name="checkout_basketcontents_basketitem"}]
            [{assign var="basketproduct" value=$basketitemlist.$basketindex}]
            [{assign var="oArticle" value=$basketitem->getArticle()}]
            [{assign var="oAttributes" value=$oArticle->getAttributesDisplayableInBasket()}]

            [{assign var="deliveryCost" value=$oxcmp_basket->getDeliveryCost()}]

            <div class="productData col-xs-12 col-sm-6 col-md-3 productBox" id="list_cartItem_[{$smarty.foreach.basketContents.iteration}]">

                <div class="form basketTotalForm--item">
                    
                    <div class="picture text-center">
                        [{block name="checkout_basketcontents_basketitem_image"}]
                            [{* product image *}]
                            [{if $editable}]<a href="[{$basketitem->getLink()}]">[{/if}]
                            <img src="[{$basketitem->getIconUrl()}]" data-src="[{$basketitem->getIconUrl()}]" class="img-responsive" alt="[{$basketitem->getTitle()|strip_tags}]">
                            [{if $editable}]</a>[{/if}]
                        [{/block}]
                        [{if $basketitem->isBundle() || $basketitem->isDiscountArticle()}]
                            <span class="gift--triangle"><i class="fa fa-gift" aria-hidden="true"></i></span>
                        [{/if}]
                    </div>

                    <div class="listDetails">





                    <div class="productData--content">

                        [{block name="checkout_basketcontents_basketitem_titlenumber"}]
                            [{if $editable}]<a rel="nofllow" href="[{$basketitem->getLink()}]" class="title">[{/if}]
                            <span class="title">[{$basketitem->getTitle()}]</span>
                            [{if $editable}]</a>[{/if}]
                            [{if $basketitem->isSkipDiscount()}] <sup><a href="#SkipDiscounts_link" >**</a></sup>[{/if}]

                            <div class="small text-muted">
                                [{oxmultilang ident="PRODUCT_NO"}] [{$basketproduct->oxarticles__oxartnum->value}]
                            </div>

                            <div class="small text-muted">
                                [{assign var=sep value=", "}]
                                [{assign var=result value=""}]
                                [{foreach key="oArtAttributes" from=$oAttributes->getArray() item="oAttr" name="attributeContents"}]
                                    [{assign var=temp value=$oAttr->oxattribute__oxvalue->value}]
                                    [{assign var=result value=$result|cat:$temp|cat:$sep}]
                                [{/foreach}]
                                <small>[{$result|trim:$sep}]</small>
                            </div>

                            [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                                [{assign var="oSelections" value=$basketproduct->getSelections(null,$basketitem->getSelList())}]
                                [{if $oSelections}]
                                    <div class="selectorsBox clear" id="cartItemSelections_[{$smarty.foreach.basketContents.iteration}]">
                                        [{foreach from=$oSelections item=oList name=selections}]
                                            [{if $oViewConf->showSelectListsInList()}]
                                                [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="aproducts[`$basketindex`][sel]" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                            [{else}]
                                                [{assign var="oActiveSelection" value=$oList->getActiveSelection()}]
                                                [{if $oActiveSelection}]
                                                    <input type="hidden" name="aproducts[[{$basketindex}]][sel][[{$smarty.foreach.selections.index}]]" value="[{if $oActiveSelection }][{$oActiveSelection->getValue()}][{/if}]">
                                                    <div>[{$oList->getLabel()}]: [{$oActiveSelection->getName()}]</div>
                                                [{/if}]
                                            [{/if}]
                                        [{/foreach}]
                                    </div>
                                [{/if}]
                            [{/if}]

                            [{if !$editable}]
                                <p class="persparamBox">
                                    <small>
                                        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                            [{if !$smarty.foreach.persparams.first}]<br />[{/if}]
                                            [{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}]
                                                [{oxmultilang ident="LABEL"}]
                                            [{else}]
                                                [{$sVar}] :
                                            [{/if}]
                                            [{$aParam}]
                                        [{/foreach}]
                                    </small>
                                </p>
                            [{else}]
                                [{if $basketproduct->oxarticles__oxisconfigurable->value}]
                                    [{if $basketitem->getPersParams()}]
                                        <br />
                                        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
                                            <p>
                                                <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][[{$sVar}]]" value="[{$aParam}]" placeholder="[{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}][{oxmultilang ident="LABEL"}][{else}][{$sVar}][{/if}]">
                                            </p>
                                        [{/foreach}]
                                    [{else}]
                                        <p>
                                            <input class="textbox persParam form-control" type="text" name="aproducts[[{$basketindex}]][persparam][details]" value="" placeholder="[{oxmultilang ident="LABEL"}]">
                                        </p>
                                    [{/if}]
                                [{/if}]
                            [{/if}]
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_wrapping"}]
                            [{* product wrapping *}]
                            [{if $oView->isWrapping()}]
                                <div class="wrapping">
                                    [{if !$basketitem->getWrappingId()}]
                                        [{if $editable}]
                                            <a href="#" class="btn btn-default btn-xs" title="[{oxmultilang ident="ADD"}]" data-toggle="modal" data-target="#giftoptions">[{oxmultilang ident="WRAPPING"}] [{oxmultilang ident="ADD"}]</a>
                                        [{else}]
                                            <small>[{oxmultilang ident="WRAPPING"}]: [{oxmultilang ident="NONE"}]</small>
                                        [{/if}]
                                    [{else}]
                                        [{assign var="oWrap" value=$basketitem->getWrapping()}]
                                        [{if $editable}]
                                            <small>[{oxmultilang ident="WRAPPING"}]:</small> <a class="btn btn-default btn-xs" href="#" title="[{oxmultilang ident="ADD"}]" data-toggle="modal" data-target="#giftoptions"><i class="fa fa-pencil"></i> [{$oWrap->oxwrapping__oxname->value}]</a>
                                        [{else}]
                                            <small>[{oxmultilang ident="WRAPPING"}]: [{$oWrap->oxwrapping__oxname->value}]</small>
                                        [{/if}]
                                    [{/if}]
                                </div>
                            [{/if}]
                        [{/block}]
                    

                        [{block name="checkout_basketcontents_basketitem_totalprice"}]
                            [{* product quantity * price *}]
                            <div class="price text-center">
                                <span class="lead">
                            [{block name="checkout_basketcontents_basketitem_unitprice"}]
                            [{* product price *}]
                            <span class="unitPrice">
                                [{if $basketitem->getFUnitPrice()}]
                                    <small>[{oxmultilang ident="UNIT_PRICE"}]: </small> [{$basketitem->getFUnitPrice()}]&nbsp;[{$currency->sign}]
                                [{/if}]
                            </span>
                        [{/block}]
                                    <span class="basketTotalForm--item-price">[{$basketitem->getFTotalPrice()}]  
                            [{$currency->sign}]</span>
                                </span>
 
                            </div>
 
                            <span class="priceDefault" style="display:none;">
                                [{$basketitem->getFTotalPrice()}]
                            </span>
                        [{/block}]

                        [{block name="checkout_basketcontents_basketitem_quantity"}]
                            [{* product quantity manager *}]
                            <div class="quantity">
                                [{if $editable}]

                                <input type="hidden" name="aproducts[[{$basketindex}]][aid]" value="[{$basketitem->getProductId()}]">
                                <input type="hidden" name="aproducts[[{$basketindex}]][basketitemid]" value="[{$basketindex}]">
                                <input type="hidden" name="aproducts[[{$basketindex}]][override]" value="1">
                                [{if $basketitem->isBundle()}]
                                    <input type="hidden" name="aproducts[[{$basketindex}]][bundle]" value="1">
                                [{/if}]

                                

                                [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                                    <div class="number-icon">  
                              
                                           <button type="button" class="number down mobile-sign">
                                               <span></span>
                                           </button> 
                                       

                                         <input  type="text" class="textbox mobile-sign-am" name="aproducts[[{$basketindex}]][am]" value="[{$basketitem->getAmount()}]" size="3" min="0">
                                                                 
                                           <button type="button" class="number up mobile-sign">
                                               <span></span><span></span>
                                           </button>
                                                   
                                       </div>
                                [{/if}]
                            [{else}]
                                [{$basketitem->getAmount()}]
                            [{/if}]
                            [{if $basketitem->getdBundledAmount() > 0 && ($basketitem->isBundle() || $basketitem->isDiscountArticle())}]
                                <span class="gift--product">+[{$basketitem->getdBundledAmount()}]</span>
                            [{/if}]
                            </div>
                        [{/block}]

                        </div>

						[{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
                        <div class="delete">

                            <span class="basketTotalForm--item-remove btn btn-sm btn-danger" onclick="document.getElementById( 'aproducts_[{$basketindex}]_remove_main' ).value = '1';"> 

                                        <i class="fa fa-trash-o" aria-hidden="true"></i> <span>[{ oxmultilang ident="REMOVE" }]</span>
                                    </span>
                                    
                                    <input type="hidden" class="remove_main_all" name="aproducts[[{$basketindex}]][remove]" id="aproducts_[{$basketindex}]_remove_main_2" value="0">
                        </div>
                        [{/if}]
                </div>

            </div>
            </div>
        [{/block}]

        [{* packing unit *}]

        [{block name="checkout_basketcontents_itemerror"}]
            [{foreach from=$Errors.basket item=oEr key=key}]
                [{if $oEr->getErrorClassType() == 'oxOutOfStockException'}]
                    [{* display only the exceptions for the current article *}]
                    [{if $basketindex == $oEr->getValue('basketIndex')}]
                        <tr class="basketError">
                            [{if $editable}]<td></td>[{/if}]
                                <td colspan="5">
                                    <span class="inlineError">[{$oEr->getOxMessage()}] <strong>[{$oEr->getValue('remainingAmount')}]</strong></span>
                                </td>
                            [{if $oView->isWrapping()}]<td></td>[{/if}]
                            <td></td>
                        </tr>
                    [{/if}]
                [{/if}]
                [{if $oEr->getErrorClassType() == 'oxArticleInputException'}]
                    [{if $basketitem->getProductId() == $oEr->getValue('productId')}]
                        <tr class="basketError">
                            [{if $editable}]<td></td>[{/if}]
                            <td colspan="5">
                                <span class="inlineError">[{$oEr->getOxMessage()}]</span>
                            </td>
                            [{if $oView->isWrapping()}]<td></td>[{/if}]
                            <td></td>
                        </tr>
                    [{/if}]
                [{/if}]
            [{/foreach}]
        [{/block}]
        [{*  basket items end  *}]
    [{/foreach}]

    [{block name="checkout_basketcontents_giftwrapping"}]
        [{if $oViewConf->getShowGiftWrapping()}]
            [{assign var="oCard" value=$oxcmp_basket->getCard()}]
            [{if $oCard}]
                <tr>
                    [{if $editable}]<td></td>[{/if}]
                    <td id="orderCardTitle" colspan="3">[{oxmultilang ident="GREETING_CARD"}] "[{$oCard->oxwrapping__oxname->value}]"
                        <br>
                        <b>[{oxmultilang ident="YOUR_MESSAGE"}]</b>
                        <br>
                        <div id="orderCardText">[{$oxcmp_basket->getCardMessage()|nl2br}]</div>
                    </td>
                    <td id="orderCardPrice">[{$oCard->getFPrice()}]&nbsp;[{$currency->sign}]</td>
                    <td>
                        [{if $oxcmp_basket->isProportionalCalculationOn()}]
                            [{oxmultilang ident="PROPORTIONALLY_CALCULATED"}]
                        [{else}]
                            [{if $oxcmp_basket->getGiftCardCostVat()}][{$oxcmp_basket->getGiftCardCostVatPercent()}]%[{/if}]
                        [{/if}]
                    </td>
                    <td id="orderCardTotalPrice" align="right">[{$oCard->getFPrice()}]&nbsp;[{$currency->sign}]</td>
                </tr>
            [{/if}]
        [{/if}]
    [{/block}]

    [{block name="checkout_basketcontents_basketfunctions"}]
        [{if $editable}]
            <span class="btn btn-sm btn-danger removeAllProducts">
                <i class="fa fa-trash-o" aria-hidden="true"></i> [{oxmultilang ident="DD_CLEAR_ALL"}]
            </span>
        [{/if}]
    [{/block}]

</div>












