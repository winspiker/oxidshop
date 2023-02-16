[{* |article_list.tpl|admin_article_list_filter|dgidealo_article_list_filter.tpl|21| *}]

[{assign var="oIdealo" value=$oView->getIdealo() }]
[{assign var="oIdealoHook" value=false }]
[{ if ( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower != "oxactive" ) }]
   [{assign var="oIdealoHook" value=$oIdealo->getIdealoParam('dgIdealoActive')|lower }]
[{/if}]

[{ if ( $oIdealoHook || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList')}]
  <td valign="top" class="listfilter first" height="20"[{ if ( $oIdealoHook && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) }] colspan="2"[{/if}]>
    <div class="r1">
        [{ if $oIdealoHook }]
         <div class="b1"[{ if ( $oIdealoHook && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) }] style="width: 50%;float: left;text-align: center;"[{/if}]>
          <select class="listedit" type="text" size="1" maxlength="1" name="where[oxarticles][[{$oIdealoHook}]]">
            <option value=""[{if $where.oxarticles.$oIdealoHook == ""}] selected[{/if}]>-</option>
            <option value="1"[{if $where.oxarticles.$oIdealoHook == "1"}] selected[{/if}]>1</option>
            <option value="0"[{if $where.oxarticles.$oIdealoHook == "0"}] selected[{/if}]>0</option>
          </select>
        </div>
        [{/if}]
        [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" }]
        <div class="b1"[{ if ( $oIdealoHook && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) }] style="width: 50%;float: left;text-align: center;"[{/if}]>
           <select class="listedit" type="text" size="1" maxlength="1" name="where[oxarticles][dgidealodirectpurchaserelease]">
            <option value="" [{if $where.oxarticles.dgidealodirectpurchaserelease == "" }] selected[{/if}]>-</option>
            <option value="1"[{if $where.oxarticles.dgidealodirectpurchaserelease == "1"}] selected[{/if}]>1</option>
            <option value="0"[{if $where.oxarticles.dgidealodirectpurchaserelease == "0"}] selected[{/if}]>0</option>
          </select>
        </div>
        [{/if}]
    </div>
  </td>
[{/if}]
[{$smarty.block.parent}]