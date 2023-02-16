[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box="list"}]

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<script type="text/javascript">
<!--
[{if $updatemain}]
    var oTransfer = parent.edit.document.getElementById("transfer");
    oTransfer.oxid.value=sID;
    oTransfer.cl.value='[{$default_edit}]';

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();
[{/if}]
window.onload = function ()
{
    top.reloadEditFrame();
    [{if $updatelist == 1}]
        top.oxid.admin.updateList('[{$oViewConf->getActiveShopId()}]');
    [{/if}]
}
//-->
</script>
<style>

#dgLizenzSreen{ line-height: 34px; line-height: 34px; color: #888888;  position: absolute; right: 54px; bottom: 30px; font-weight:normal;}
#dgLanguageSreen{color: #888888;  position: absolute; right: 54px; bottom: 5px; font-weight:normal;}
.otto{color:#D4021D;font-weight: 800;font-size: 14px;}
</style>
<form name="search" id="search" action="[{$oViewConf->getSelfLink()}]" method="post">
[{include file="_formparams.tpl" cl="dgotto_list" lstrt=$lstrt actedit=$actedit oxid=$oViewConf->getActiveShopId() fnc="" language=$actlang editlanguage=$actlang delshopid="" updatenav=""}]

[{include file="pagetabsnippet.tpl"}]

<script type="text/javascript">
if (parent.parent != null && parent.parent.setTitle )
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->value}]";
    parent.parent.sMenuItem    = "[{oxmultilang ident="SHOP_LIST_MENUITEM"}]";
    parent.parent.sMenuSubItem = "[{oxmultilang ident="SHOP_LIST_MENUSUBITEM"}]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
<div id="dgLanguageSreen"> <a target="blank" href="http://www.volker-doerk.de/">Modul bewerten</a> &nbsp; | &nbsp;  <a href="https://account.otto.market/" target="_blank" class="otto">OTTO</a> </div>
[{if $sLizenzNumber}]

<div id="dgLizenzSreen">Lizenz: [{$sLizenzNumber}]</div>
[{/if}]
</body>
</html>