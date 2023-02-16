[{* |order_list.tpl|admin_order_list_sorting|dgidealo_list_sorting_actions.tpl|21| *}]
[{assign var="oIdealo" value=$oView->getIdealo() }]
[{ if ( !$dgadmin_order_list_sorting || $dgadmin_order_list_sorting == "dgidealo" ) && !$oIdealo->getIdealoParam('dgIdealoDontShowOrderList') }]
  <td class="listheader first" height="15">
    <a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxorder', 'oxip', 'asc');document.search.submit();" class="listheader">
        Bestellherkunft
    </a>
  </td>
[{assign var="dgadmin_order_list_sorting" value="dgidealo"}]
[{/if}]
[{$smarty.block.parent}]
