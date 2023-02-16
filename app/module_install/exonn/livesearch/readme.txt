1. Kopieren Sie den Inhalt des Verzeichnisses copy_this in Ihr Shop Stammverzeichnis.
2. Klicken Sie unter Erweiterungen auf Module. W�hlen Sie aus der Liste das EXONN LiveSearch Modul und aktivieren Sie dieses.

In Ihrem Suchtemplate "search.tpl" nach

[{if $oView->getArticleList()}]
    [{foreach from=$oView->getArticleList() name=search item=product}]
        [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="searchList" products=$oView->getArticleList() showMainLink=true}]
    [{/foreach}]
[{/if}]

folgendes einfügen:

[{if $oView->getSearchArticleList()}]
    [{foreach from=$oView->getSearchArticleList() name=search item=product}]
        [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="searchList" products=$oView->getSearchArticleList() showMainLink=true}]
    [{/foreach}]
[{/if}]