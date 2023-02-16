[{* |article_list.tpl|admin_article_list_item|dgidealo_article_list_items.tpl|21| *}]

[{assign var="oIdealo" value=$oView->getIdealo() }]
[{assign var="oIdealoHook" value=false }]
[{ if ( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower != "oxactive" ) }]
   [{assign var="oIdealoHook" value=$oIdealo->getIdealoParam('dgIdealoActive')|lower }]
[{/if}]

[{ if ( $oIdealoHook || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList')}]
  [{assign var="aField" value="oxarticles__"|cat:$oIdealoHook }]
  [{if $listitem->oxarticle__oxstorno->value == 1 }]
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
  [{if $oIdealoHook }]
  <td valign="top" height="15" class="[{ $listclass}]" style="white-space: nowrap;">
    <div class="listitemfloating" style="text-align: center;">
        [{if $listitem->$aField->value == 1 }]<a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxarticles__oxid->value}]');" class="[{ $listclass}][{if $listitem->$aField->value == 1 }] idico[{/if}]"><span class="aicoablock"> &nbsp; &nbsp; </span></a>[{else}]&nbsp;[{/if}]
    </div>
  </td>
  [{assign var="colspan" value=$colspan+1}]
  [{/if}]
  [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" }]
  <td valign="top" height="15" class="[{ $listclass}]" style="white-space: nowrap;">
    <div class="listitemfloating" style="text-align: center;">
        [{if $listitem->oxarticles__dgidealodirectpurchaserelease->value == 1 }]<a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxarticles__oxid->value}]');" class="[{ $listclass}][{if $listitem->oxarticles__dgidealodirectpurchaserelease->value == 1 }] didico[{/if}]"><span class="aicoablock"> &nbsp; &nbsp; </span></a>[{else}]&nbsp;[{/if}]
    </div>
  </td>
  [{assign var="colspan" value=$colspan+1}]
  [{/if}]
[{/if}]
[{$smarty.block.parent}]