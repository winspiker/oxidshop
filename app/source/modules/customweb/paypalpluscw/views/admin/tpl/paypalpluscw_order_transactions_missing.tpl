[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="cur" value="[{ $oCurr->id }]">
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="order_main">
</form>

<div class="messagebox">
	<p class="message">[{oxmultilang ident='The corresponding PayPal Plus transaction can not be found.' noerror=true}]</p>
</div>
    
[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]