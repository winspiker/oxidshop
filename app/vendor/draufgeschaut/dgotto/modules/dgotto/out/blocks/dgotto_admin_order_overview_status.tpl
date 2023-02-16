[{$smarty.block.parent}]              

[{if $edit->oxorder__oxip->value|replace:"otto":"" != $edit->oxorder__oxip->value}]
<span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span>: <a href="https://portal.otto.market/orders#/details/[{$edit->oxorder__oxtransid->value}]/articles" target="_blank">[{$edit->oxorder__oxtransid->value}]</a><br />
[{/if}]