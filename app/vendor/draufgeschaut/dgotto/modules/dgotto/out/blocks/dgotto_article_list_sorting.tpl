[{assign var="oOtto" value=$oView->getOtto()}]
[{assign var="oOttoHook" value=false}]
[{if $oOtto->getOttoParam( 'dgOttoSqlHook' ) != ""}]
   [{assign var="oOttoHook" value=$oOtto->getExportHookField()}]
[{/if}]

[{if $oOttoHook != "oxactive" && !$oOtto->getOttoParam( 'dgOttoDontShowArticleList' )}]
  <td class="listheader first" height="15" align="center">
    <a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxarticles', '[{$oOttoHook}]', 'asc');document.search.submit();" class="listheader aiotto">
        <span style="color:transparent">A</span>
    </a>
  </td>
[{/if}]

[{$smarty.block.parent}]