[{* |order_list.tpl|admin_order_list_item|dgidealo_list_items_actions.tpl|21| *}]
[{assign var="oIdealo" value=$oView->getIdealo() }]
[{ if ( !$dgadmin_order_list_item || $dgadmin_order_list_item == "dgidealo" ) && !$oIdealo->getIdealoParam( 'dgIdealoDontShowOrderList' ) }]
  [{if $listitem->oxorder__oxstorno->value == 1 }]
    [{assign var="listclass" value=listitem3 }]
  [{else}]
    [{if $listitem->blacklist == 1}]
    [{assign var="listclass" value=listitem3 }]
    [{ else}]
    [{assign var="listclass" value=listitem$blWhite }]
    [{/if}]
  [{/if}]
  [{if $listitem->getId() == $oxid }]
    [{assign var="listclass" value=listitem4 }]
  [{/if}]
  <td valign="top" height="15" class="[{ $listclass}]">
    <div class="listitemfloating">
        <a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxorder__oxid->value}]');" class="[{ $listclass}]">[{ oxmultilang ident=oxmultilang ident=$listitem->oxorder__oxip->value alternative=$listitem->oxorder__oxip->value noerror=true alternative=oxmultilang ident=$listitem->oxorder__oxip->value alternative=$listitem->oxorder__oxip->value noerror=true noerror=true }]</a>
    </div>
  </td>
[{assign var="colspan" value=$colspan+1}]
[{assign var="dgadmin_order_list_item" value="dgidealo"}]
[{/if}]
[{$smarty.block.parent}]