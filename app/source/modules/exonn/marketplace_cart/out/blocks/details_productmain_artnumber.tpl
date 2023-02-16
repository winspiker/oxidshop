[{block name="details_productmain_artnumber"}]
<p class="art">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</p>
<div class="line-sub-info">
	<p>[{oxmultilang ident="PAGE_PRICE_INFO"}] <a href="[{ oxgetseourl ident="oxdeliveryinfo" type="oxcontent" }]" target="_blank">[{oxmultilang ident="PAGE_PRICE_INFO_VERSAND"}]</a></p>
	[{assign var="deliveryCost" value=$oDetailsProduct->getDeliveryCostForArticle(1)}] [{if $deliveryCost->getPrice() > 0}]<p>&nbsp; ([{oxprice price=$deliveryCost->getPrice() currency=$currency}]) </p>[{/if}]
</div>
[{/block}]