[{block name="details_relatedproducts_also_bought"}]
    [{if $oView->getAlsoBoughtTheseProducts()}]
        [{include file="widget/product/list.tpl" type="grid" listId="alsoBought" head="CUSTOMERS_ALSO_BOUGHT"|oxmultilangassign subhead="PAGE_DETAILS_CUSTOMERS_ALSO_BOUGHT_SUBHEADER"|oxmultilangassign products=$oView->getAlsoBoughtTheseProducts()}]
    [{/if}]
[{/block}]



[{block name="details_relatedproducts_similarproducts"}]
    [{if $oView->getSimilarProducts()}]
        [{include file="widget/product/list.tpl" type="grid" listId="similar"  products=$oView->getSimilarProducts() head="SIMILAR_PRODUCTS"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_SIMILAR_SUBHEADER"|oxmultilangassign}]
    [{/if}]
[{/block}]

[{block name="details_relatedproducts_crossselling"}]
    [{if $oView->getCrossSelling()}]
        [{capture append="oxidBlock_productbar"}]
            [{include file="widget/product/list.tpl" type="grid" listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
        [{/capture}]
    [{/if}]
[{/block}]

[{if $oxidBlock_productbar && false}]
    <div id="relProducts" class="relatedProducts">
        [{foreach from=$oxidBlock_productbar item="_block"}]
            [{$_block}]
        [{/foreach}]
    </div>
[{/if}]