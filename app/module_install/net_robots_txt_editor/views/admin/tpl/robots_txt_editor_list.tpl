[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box="list"}]

<script type="text/javascript">
    if (parent.parent)
    {   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
        parent.parent.sMenuItem    = "[{ oxmultilang ident="NET_ROBOTS_TXT_EDITOR_LIST_MENUITEM" }]";
        parent.parent.sMenuSubItem = "[{ oxmultilang ident="NET_ROBOTS_TXT_EDITOR_LIST_MENUSUBITEM" }]";
        parent.parent.sWorkArea    = "[{$_act}]";
        parent.parent.setTitle();
    }
</script>

<script type="text/javascript">
<!--
window.onload = function ()
{
    top.reloadEditFrame();
    [{ if $updatelist == 1}]
        top.oxid.admin.updateList('[{$oxid}]');
    [{ /if}]
}
//-->
</script>

<div id="liste">

</div>

[{include file="pagetabsnippet.tpl"}]

</body>
</html>