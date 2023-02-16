[{* |article_list.tpl|admin_article_list_colgroup|dgidealo_article_list_colgroup.tpl|21| *}]

[{assign var="oIdealo" value=$oView->getIdealo() }]
[{assign var="oIdealoHook" value=false }]
[{ if ( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower != "oxactive" ) }]
   [{assign var="oIdealoHook" value=$oIdealo->getIdealoParam('dgIdealoActive')|lower }]
[{/if}]

[{ if ( $oIdealoHook || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) && !$oIdealo->getIdealoParam('dgIdealoDontShowArticleList')}]
  <col width="[{ if ( $oIdealoHook && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) }]3[{else}]1[{/if}]%" [{ if ( $oIdealoHook && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" ) }]span="2"[{/if}]>
[{assign var="dgadmin_article_list_colgroup" value="dgidealo"}]
[{/if}]
[{$smarty.block.parent}]