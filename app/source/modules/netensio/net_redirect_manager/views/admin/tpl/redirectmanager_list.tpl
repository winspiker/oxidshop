[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box="list"}]
[{assign var="where" value=$oView->getListFilter()}]

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<script type="text/javascript">
<!--
window.onload = function ()
{
    top.reloadEditFrame();
    [{if $updatelist == 1}]
        top.oxid.admin.updateList('[{$oxid}]');
    [{/if}]
}
//-->
</script>


<div id="liste">

<form name="search" id="search" action="[{$oViewConf->getSelfLink()}]" method="post">
[{include file="_formparams.tpl" cl="redirectmanager_list" lstrt=$lstrt actedit=$actedit oxid=$oxid fnc="" language=$actlang editlanguage=$actlang}]
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <colgroup>
        [{block name="admin_redirectmanager_list_colgroup"}]
        <col width="2%">
        <col width="30%">
        <col width="30%">
        <col width="30%">
        <col width="5%">
        [{/block}]
    </colgroup>

<tr class="listitem">
    [{block name="admin_redirectmanager_list_filter"}]
    <td valign="top" class="listfilter first" height="20"  colspan="5">
        <div class="r1">
            <div class="b1">
                <input class="listedit" type="text" size="30" maxlength="128" name="where[netredirectmanager][oxsource]" value="[{$where.netredirectmanager.oxsource}]" placeholder="[{oxmultilang ident="NET_REDIRECT_MANAGER_FILTER_OXSOURCE"}]">
                <input class="listedit" type="text" size="30" maxlength="128" name="where[netredirectmanager][oxtarget]" value="[{$where.netredirectmanagerredirectmanager.oxtarget}]" placeholder="[{oxmultilang ident="NET_REDIRECT_MANAGER_FILTER_OXTARGET"}]">
                <input class="listedit" type="text" size="30" maxlength="128" name="where[netredirectmanager][oxhttpcode]" value="[{$where.netredirectmanagerredirectmanager.oxhttpcode}]" placeholder="[{oxmultilang ident="NET_REDIRECT_MANAGER_FILTER_OXHTTPCODE"}]">
                <div class="find">
                    <select name="changelang" class="editinput" onChange="Javascript:top.oxid.admin.changeLanguage();">
                        [{foreach from=$languages item=lang}]
                        <option value="[{ $lang->id }]" [{ if $lang->selected}]SELECTED[{/if}]>[{ $lang->name }]</option>
                        [{/foreach}]
                    </select>
                    <input class="listedit" type="submit" name="submitit" value="[{ oxmultilang ident="GENERAL_SEARCH" }]">
                </div>
            </div>
        </div>
    </td>
    [{/block}]
</tr>
<tr class="listitem">
    [{block name="admin_redirectmanager_list_sorting"}]
    <td class="listheader first"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'netredirectmanager', 'oxactive', 'asc');document.search.submit();" class="listheader">[{oxmultilang ident="NET_REDIRECT_MANAGER_SORT_OXACTIVE"}]</a></td>
    <td class="listheader first"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'netredirectmanager', 'oxsource', 'asc');document.search.submit();" class="listheader">[{oxmultilang ident="NET_REDIRECT_MANAGER_SORT_OXSOURCE"}]</a></td>
    <td class="listheader first"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'netredirectmanager', 'oxtarget', 'asc');document.search.submit();" class="listheader">[{oxmultilang ident="NET_REDIRECT_MANAGER_SORT_OXTARGET"}]</a></td>
    <td class="listheader" height="15"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'netredirectmanager', 'oxhttpcode', 'asc');document.search.submit();" class="listheader">[{oxmultilang ident="NET_REDIRECT_MANAGER_SORT_OXHTTPCODE"}]</a></td>
    <td class="listheader"></td>
    [{/block}]
</tr>

[{assign var="blWhite" value=""}]
[{assign var="_cnt" value=0}]
[{foreach from=$mylist item=listitem}]
    [{assign var="_cnt" value=$_cnt+1}]
    <tr id="row.[{$_cnt}]">
        [{if $listitem->blacklist == 1}]
            [{assign var="listclass" value=listitem3 }]
        [{else}]
            [{assign var="listclass" value=listitem$blWhite }]
        [{/if}]
        [{if $listitem->getId() == $oxid }]
            [{assign var="listclass" value=listitem4 }]
        [{/if}]
        [{block name="admin_redirectmanager_list_item"}]
            <td valign="top" class="[{$listclass}][{if $listitem->netredirectmanager__oxactive->value == 1}] active[{/if}]" height="15"><div class="listitemfloating">&nbsp;</a></div></td>
            <td valign="top" class="[{$listclass}]" height="15"><div class="listitemfloating"><a href="Javascript:top.oxid.admin.editThis('[{$listitem->netredirectmanager__oxid->value}]');" class="[{$listclass}]">[{ $listitem->netredirectmanager__oxsource->value }]</a></div></td>
            <td valign="top" class="[{$listclass}]" height="15"><div class="listitemfloating"><a href="Javascript:top.oxid.admin.editThis('[{$listitem->netredirectmanager__oxid->value}]');" class="[{$listclass}]">[{ $listitem->netredirectmanager__oxtarget->value }]</a></div></td>
            <td valign="top" class="[{$listclass}]" height="15"><div class="listitemfloating"><a href="Javascript:top.oxid.admin.editThis('[{$listitem->netredirectmanager__oxid->value}]');" class="[{$listclass}]">[{ $listitem->netredirectmanager__oxhttpcode->value }]</a></div></td>
            <td class="[{ $listclass}]"><a href="Javascript:top.oxid.admin.deleteThis('[{ $listitem->netredirectmanager__oxid->value }]');" class="delete" id="del.[{$_cnt}]" [{include file="help.tpl" helpid=item_delete}]></a></td>
        [{/block}]
    </tr>
    [{if $blWhite == "2"}]
        [{assign var="blWhite" value=""}]
    [{else}]
        [{assign var="blWhite" value="2"}]
    [{/if}]
[{/foreach}]
[{include file="pagenavisnippet.tpl" colspan="5"}]
</table>
</form>
</div>

[{include file="pagetabsnippet.tpl"}]


<script type="text/javascript">
if (parent.parent)
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem    = "[{oxmultilang ident="NET_REDIRECT_MANAGER_LIST_MENUITEM"}]";
    parent.parent.sMenuSubItem = "[{oxmultilang ident="NET_REDIRECT_MANAGER_LIST_MENUSUBITEM"}]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
</body>
</html>