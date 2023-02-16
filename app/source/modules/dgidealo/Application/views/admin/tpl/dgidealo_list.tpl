[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box="list"}]

[{ if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<script type="text/javascript">
<!--
[{ if $updatemain }]
    var oTransfer = parent.edit.document.getElementById("transfer");
    oTransfer.oxid.value=sID;
    oTransfer.cl.value='[{ $oViewConf->getTopActiveClassName() }]';

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();
[{ /if}]
window.onload = function ()
{
    top.reloadEditFrame();
    [{ if $updatelist == 1}]
        top.oxid.admin.updateList('[{ $oViewConf->getActiveShopId() }]');
    [{ /if}]
}
//-->
</script>
<style>

#dgLizenzSreen{ line-height: 34px; line-height: 34px; color: #888888;  position: absolute; right: 54px; bottom: 30px; font-weight:normal;}
#dgLanguageSreen{color: #888888;  position: absolute; right: 54px; bottom: 5px; font-weight:normal;}
</style>
<form name="search" id="search" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="lstrt" value="[{ $lstrt }]" />
<input type="hidden" name="sort" value="[{ $sort }]" />
<input type="hidden" name="actedit" value="[{ $actedit }]" />
<input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId()}]" />
<input type="hidden" name="delshopid" value="" />
<input type="hidden" name="fnc" value="" />
<input type="hidden" name="updatenav" value="" />

[{include file="pagetabsnippet.tpl"}]
<script type="text/javascript">
if (parent.parent != null && parent.parent.setTitle )
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->value}]";
    parent.parent.sMenuItem    = "draufgeschaut®";
    parent.parent.sMenuSubItem = "OXID eShop to Idealo";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
[{assign var="oIdealo" value=$oView->getIdealo()}]
[{assign var="dgIdealoLabel" value='dgidealo_order'|oxmultilangassign}]

<div id="dgLanguageSreen"> <a target="blank" href="https://www.volker-doerk.de/oxid-idealo-artikelexport-und-direktkauf-anbindung.html">Modul bewerten</a>
&nbsp; | &nbsp; Sie verwalten [{$dgIdealoLabel}] [{$oIdealo->getLocationName()}] 
[{if $oIdealo->getIdealoParam('dgIdealoPerformaceTracking')}]&nbsp; | &nbsp; <a href="https://partner.idealo.com/de/performance-tracking/" target="_blank">[{$dgIdealoLabel}] Performance Tracking </a>
[{else}]&nbsp; | &nbsp; <a href="https://partner.idealo.com/de/haendler/" target="_blank">[{$dgIdealoLabel}] Partnerbereich </a>[{/if}]
&nbsp; | &nbsp; <a href="https://business.idealo.com/de/login/" target="_blank">[{$dgIdealoLabel}] Business </a>

</div>
[{if $sLizenzNumber }]
<div id="dgLizenzSreen">Lizenz: [{ $sLizenzNumber }]</div>
[{/if}]

</body>
</html>