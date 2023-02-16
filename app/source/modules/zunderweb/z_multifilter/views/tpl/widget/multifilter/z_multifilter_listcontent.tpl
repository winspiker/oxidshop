[{*bottom line multifilter*}]
    [{if $showreset}]
    <div class="listRefine" style="padding: 5px 10px; margin: 0; position: static">
        [{include file=$oViewConf->getModulePath('z_multifilter',"views/tpl/inc/multifilter_bottom.tpl")}]            
    </div>
    [{/if}]

[{*products list*}]
[{if $oView->getArticleList()|@count == 0 && $actCategory->getId() == 'xlsearch'}]
    <div><br>[{ oxmultilang ident="SEARCHPR_NOTHING_FOUND" }]</div>
[{else}]
    [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="productList" products=$oView->getArticleList()}]
    [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedBottom() place="bottom"}]
[{/if}]
