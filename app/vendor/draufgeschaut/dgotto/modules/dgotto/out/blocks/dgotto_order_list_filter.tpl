[{assign var="oOtto" value=$oView->getOtto()}]
[{if ( !$dgadmin_order_list_filter || $dgadmin_order_list_filter == "dgotto" ) && !$oOtto->getOttoParam( 'dgOttoDontShowOrderList' )}]
  <td valign="top" class="listfilter first" height="20">
    <div class="r1">
        <div class="b1">
           <input class="listedit" type="text" size="7" maxlength="128" name="where[oxorder][oxip]" value="[{$where.oxorder.oxip}]">
        </div>
    </div>
  </td>
[{assign var="dgadmin_order_list_filter" value="dgotto"}]
[{/if}]
[{$smarty.block.parent}]