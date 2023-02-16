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
    oTransfer.cl.value='dgconnector_main';

    //forcing edit frame to reload after submit
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
#dgLanguageSreen{color: #888888;  position: absolute; right: 54px; bottom: 5px; font-weight:normal;}
</style>
<form name="search" id="search" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{include file="_formparams.tpl" cl="dgconnector_list" lstrt=$lstrt actedit=$actedit oxid=$oxid fnc="" language=$actlang editlanguage=$actlang delshopid="" updatenav=""}]
[{include file="pagetabsnippet.tpl"}]
<script type="text/javascript">
if (parent.parent != null && parent.parent.setTitle )
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->value}]";
    parent.parent.sMenuItem    = "[{ oxmultilang ident="SHOP_LIST_MENUITEM" }]";
    parent.parent.sMenuSubItem = "[{ oxmultilang ident="SHOP_LIST_MENUSUBITEM" }]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
<div id="dgLanguageSreen"> 
   <a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&oxid=[{$oViewConf->getActiveShopId()}]&fnc=dgUpdateViews">Views updaten[{ if $blViewSuccess }] &#10004;[{/if}]</a> | 
   <a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&oxid=[{$oViewConf->getActiveShopId()}]&fnc=dgClearTmp">TMP leeren[{ if $blTmpSuccess }] &#10004;[{/if}]</a> | 
   <a target="blank" href="http://www.volker-doerk.de/modul-connector-fuer-oxid-eshop-ce-pe-ee.html">Modul bewerten</a> </div>
</body>
</html>