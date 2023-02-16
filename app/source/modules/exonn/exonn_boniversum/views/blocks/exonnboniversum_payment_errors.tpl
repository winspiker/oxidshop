[{$smarty.block.parent}]

[{assign var="iPayError" value=$oView->getPaymentError()}]

[{if $iPayError == 152141}]
<div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_BONIVERSUM_CONFIRM"}]</div>
[{elseif $iPayError == 152142}]
    <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_BONIVERSUM_BIRTDATE_ERROR"}]</div>
[{elseif $iPayError == 152145}]
    <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_BONIVERSUM_FEHLERMAIN"}]</div>
[{elseif $iPayError == 152147}]
    <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_BONIVERSUM_NOTBONITAT"}]</div>
[{/if}]