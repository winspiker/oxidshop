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
    oTransfer.cl.value='dggoogleanalytics_main';
    top.forceReloadingEditFrame();
[{ /if}]
window.onload = function ()
{
    top.reloadEditFrame();
    [{ if $updatelist == 1}]
        top.oxid.admin.updateList('[{ $oxid }]');
    [{ /if}]
}
//-->
</script>
<style>
#dgLizenzSreen{ line-height: 34px; line-height: 34px; line-height: 34px; color: #888888;  position: absolute; right: 54px; bottom: 30px; font-weight:normal;}
#dgLanguageSreen{color: #888888;  position: absolute; right: 54px; bottom: 5px; font-weight:normal;}
</style>
<form name="search" id="search" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{include file="_formparams.tpl" cl="dggoogleanalytics_list" lstrt=$lstrt actedit=$actedit oxid=$oxid fnc="" language=$actlang editlanguage=$actlang delshopid="" updatenav=""}]
[{include file="pagetabsnippet.tpl"}]

<script type="text/javascript">
if (parent.parent != null && parent.parent.setTitle )
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->value}]";
    parent.parent.sMenuItem    = "draufgeschaut®";
    parent.parent.sMenuSubItem = "OXID eShop Sitemap";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
[{assign var="google" value='<b><font face="Arial"><font color="#0033CC">G</font><font color="#CC0000">o</font><font color="#FFCC00">o</font><font color="#0033CC">g</font><font color="#006600">l</font><font color="#CC0000">e</font></font></b>'}]
<div id="dgLanguageSreen"><a target="blank" href="http://www.volker-doerk.de/oxid-shop-module-fuer-google/oxid-eshop-modul-google-analytics.html">Modul bewerten</a> &nbsp; | &nbsp; <a href="https://analytics.google.com/analytics/web/?hl=de" target="_blank">[{$google}] Analytics </a></div>
[{if $sLizenzNumber }]
<div id="dgLizenzSreen">Lizenz: [{ $sLizenzNumber }]</div>
[{/if}]
</body>
</html>