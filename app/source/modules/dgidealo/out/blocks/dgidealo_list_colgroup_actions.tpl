[{* |order_list.tpl|admin_order_list_colgroup|dgidealo_list_colgroup_actions.tpl|21| *}]
[{assign var="oIdealo" value=$oView->getIdealo() }]
[{ if ( !$dgadmin_order_list_colgroup || $dgadmin_order_list_colgroup == "dgidealo" ) && !$oIdealo->getIdealoParam( 'dgIdealoDontShowOrderList' ) }]
  <col width="10%">
[{assign var="dgadmin_order_list_colgroup" value="dgidealo"}]
[{/if}]
[{$smarty.block.parent}]