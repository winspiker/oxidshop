[{assign var="oOtto" value=$oView->getOtto()}]
[{if ( !$dgadmin_order_list_colgroup || $dgadmin_order_list_colgroup == "dgotto" ) && !$oOtto->getOttoParam( 'dgOttoDontShowOrderList' )}]
  <col width="10%">
[{assign var="dgadmin_order_list_colgroup" value="dgotto"}]
[{/if}]
[{$smarty.block.parent}]