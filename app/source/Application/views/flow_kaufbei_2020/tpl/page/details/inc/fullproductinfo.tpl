<div id="detailsMain">
    [{include file="page/details/inc/productmain.tpl"}]
</div>

<div id="detailsRelated" class="detailsRelated clear">
    <div class="relatedInfo[{if !$oView->getSimilarProducts() && !$oView->getCrossSelling() && !$oView->getAccessoires()}] relatedInfoFull[{/if}]">
        <div class="row">
            <div class="col-xs-12">
                [{include file="page/details/inc/tabs.tpl"}]
            </div>
        </div>
    </div>



    [{block name="details_relatedproducts_accessoires"}]
        [{if $oView->getAccessoires()}]
            [{capture append="oxidBlock_productbar"}]
                [{include file="widget/product/list.tpl" type="grid" listId="accessories" products=$oView->getAccessoires() head="ACCESSORIES"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_ACCESSORIES_SUBHEADER"|oxmultilangassign}]
            [{/capture}]
        [{/if}]
    [{/block}]

    [{if $oxidBlock_productbar}]

        [{foreach from=$oxidBlock_productbar item="_block"}]
        [{$_block}]
        [{/foreach}]

    [{/if}]

[{include file="page/details/inc/related_products.tpl"}]




	
</div>
