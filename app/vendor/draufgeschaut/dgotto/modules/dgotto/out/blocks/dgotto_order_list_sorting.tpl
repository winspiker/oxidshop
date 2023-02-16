[{assign var="oOtto" value=$oView->getOtto()}]
[{if ( !$dgadmin_order_list_sorting || $dgadmin_order_list_sorting == "dgotto" ) && !$oOtto->getOttoParam( 'dgOttoDontShowOrderList' )}]
  <td class="listheader first" height="15">
    <a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxorder', 'oxip', 'asc');document.search.submit();" class="listheader">
        Bestellherkunft
    </a>
  </td>
[{assign var="dgadmin_order_list_sorting" value="dgotto"}]
[{/if}]

[{$smarty.block.parent}]