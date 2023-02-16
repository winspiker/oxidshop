[{* |order_overview.tpl|admin_order_overview_status|dgidealo_admin_order_overview_status.tpl|1| *}]

[{ $smarty.block.parent }]              
[{assign var="dgIdealoLabel" value='dgidealo_order'|oxmultilangassign}]
[{ if $oView->dgIdealoOrderNumber() }]
[{$dgIdealoLabel}]: [{ $oView->dgIdealoOrderNumber() }]<br />
[{/if}]