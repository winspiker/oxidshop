[{block name="dd_checkout_inc_basketcontents_table_item_desc"}]
    [{if $editable}]<a rel="nofllow" href="[{$basketitem->getLink()}]">[{/if}]
<b>[{$basketitem->getTitle()}]</b>
[{if $editable}]</a>[{/if}]
    [{if $basketitem->isSkipDiscount()}] <sup><a href="#SkipDiscounts_link" >**</a></sup>[{/if}]
    <div class="smallFont">
        [{oxmultilang ident="PRODUCT_NO"}] [{$basketproduct->oxarticles__oxartnum->value}]
    </div>
    <style>
        #basketItemShippingCost
        {
            float: right;
        }
    </style>
    <div class="smallFont" id="basketItemShippingCost">
        [{assign var="deliveryCost" value=$oArticle->getDeliveryCostForArticle($basketitem->getAmount())}] [{if $deliveryCost->getPrice() > 0}]<p>&nbsp; ([{oxprice price=$deliveryCost->getPrice() currency=$currency}]) </p>[{/if}]
    </div>
    <div class="smallFont">
        [{assign var=sep value=", "}]
        [{assign var=result value=""}]
        [{foreach key=oArtAttributes from=$oAttributes->getArray() item=oAttr name=attributeContents}]
        [{assign var=temp value=$oAttr->oxattribute__oxvalue->value}]
        [{assign var=result value=$result$temp$sep}]
        [{/foreach}]
        [{$result|trim:$sep}]
    </div>

    [{if !$basketitem->isBundle() || !$basketitem->isDiscountArticle()}]
    <span class="basketTotalForm--item-remove" onclick="document.getElementById( 'aproducts_[{$basketindex}]_remove_main' ).value = '1';">

                                        <i class="fa fa-trash-o" aria-hidden="true"></i><span>[{ oxmultilang ident="REMOVE" }]</span>
                                    </span>

<input type="hidden" class="remove_main_all" name="aproducts[[{$basketindex}]][remove]" id="aproducts_[{$basketindex}]_remove_main" value="0">
    [{/if}]

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
        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
        [{if !$smarty.foreach.persparams.first}]<br />[{/if}]
        <strong>
            [{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}]
            [{oxmultilang ident="LABEL"}]
            [{else}]
            [{$sVar}] :
            [{/if}]
        </strong> [{$aParam}]
        [{/foreach}]
    </p>
    [{else}]
    [{if $basketproduct->oxarticles__oxisconfigurable->value}]
    [{if $basketitem->getPersParams()}]
<br />
    [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=persparams}]
    <p>
        <label class="persParamLabel">
            [{if $smarty.foreach.persparams.first && $smarty.foreach.persparams.last}]
            [{oxmultilang ident="LABEL"}]
            [{else}]
            [{$sVar}]:
            [{/if}]
        </label>
        <input class="textbox persParam" type="text" name="aproducts[[{$basketindex}]][persparam][[{$sVar}]]" value="[{$aParam}]">
    </p>
    [{/foreach}]
    [{else}]
    <p>[{oxmultilang ident="LABEL"}] <input class="textbox persParam" type="text" name="aproducts[[{$basketindex}]][persparam][details]" value=""></p>
    [{/if}]
    [{/if}]
    [{/if}]
    [{/block}]