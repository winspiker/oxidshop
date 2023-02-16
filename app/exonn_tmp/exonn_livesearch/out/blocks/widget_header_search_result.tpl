[{$smarty.block.parent}]

[{if $oView->getSearchArticleList()}]
    [{foreach from=$oView->getSearchArticleList() name=search item=product}]
        [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="searchList" products=$oView->getSearchArticleList() showMainLink=true}]
    [{/foreach}]
[{/if}]