[{* |article_list.tpl|admin_article_list_sorting|dgidealo_article_list_sorting.tpl|21| *}]


[{assign var="oIdealo" value=$oView->getIdealo() }]
[{assign var="oIdealoHook" value=false }]
[{ if ( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower != "oxactive" ) }]
   [{assign var="oIdealoHook" value=$oIdealo->getIdealoParam('dgIdealoActive')|lower }]
[{/if}]

[{ if $oIdealoHook && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList') }]
  <td class="listheader first" height="15" align="center">
    <a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxarticles', '[{$oIdealoHook}]', 'asc');document.search.submit();" class="listheader">
        I
    </a>
  </td>
[{/if}]
[{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList') }]
  <td class="listheader first" height="15" align="center">
    <a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxarticles', 'dgidealodirectpurchaserelease', 'asc');document.search.submit();" class="listheader">
        D
    </a>
  </td>
[{/if}]

[{$smarty.block.parent}]
