[{assign var="oOtto" value=$oView->getOtto()}]
[{assign var="oOttoHook" value=false}]
[{if $oOtto->getOttoParam( 'dgOttoSqlHook' ) != ""}]
   [{assign var="oOttoHook" value=$oOtto->getExportHookField()}]
[{/if}]

[{if $oOttoHook != "oxactive" && !$oOtto->getOttoParam( 'dgOttoDontShowArticleList' )}]
  <col width="1%">
[{/if}]

[{$smarty.block.parent}]