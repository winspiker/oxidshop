[{* |order_list.tpl|admin_order_list_filter|dgidealo_list_filter_actions.tpl|21| *}]
[{assign var="oIdealo" value=$oView->getIdealo() }]
[{ if ( !$dgadmin_order_list_filter || $dgadmin_order_list_filter == "dgidealo" ) && !$oIdealo->getIdealoParam( 'dgIdealoDontShowOrderList' ) }]
  <td valign="top" class="listfilter first" height="20">
    <div class="r1">
        <div class="b1">
           <input class="listedit" type="text" size="7" maxlength="128" name="where[oxorder][oxip]" value="[{ $where.oxorder.oxip }]">
        </div>
    </div>
  </td>
[{assign var="dgadmin_order_list_filter" value="dgidealo"}]
[{/if}]
[{$smarty.block.parent}]