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
    [{ if $updatelist == 1}]
        top.oxid.admin.updateList('[{ $oxid }]');
    [{ /if}]
}
//-->
</script>

<div id="liste">


<form name="search" id="search" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{include file="_formparams.tpl" cl="dgconnector_tplblocks_list" lstrt=$lstrt actedit=$actedit oxid=$oxid fnc="" language=$actlang editlanguage=$actlang}]

<table cellspacing="0" cellpadding="0" border="0" width="100%">
<colgroup><col width="3%"><col width="5%"><col width="33%"><col width="38%"><col width="38%"><col width="2%"></colgroup>
<tr class="listitem">
<td valign="top" class="listfilter first" align="right">
                <div class="r1"><div class="b1">&nbsp;</div></div>
            </td>
            <td valign="top" class="listfilter " height="20">
        <div class="r1"><div class="b1">
        
        &nbsp;&nbsp;<input class="listedit" type="text" size="5" maxlength="128" name="where[oxtplblocks][oxpos]" value="[{ $where.oxtplblocks.oxpos }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter " height="20">
        <div class="r1"><div class="b1">
        
        &nbsp;&nbsp;<input class="listedit" type="text" size="30" maxlength="128" name="where[oxtplblocks][oxblockname]" value="[{ $where.oxtplblocks.oxblockname }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter " height="20">
        <div class="r1"><div class="b1">
        
        &nbsp;&nbsp;<input class="listedit" type="text" size="30" maxlength="128" name="where[oxtplblocks][oxtemplate]" value="[{ $where.oxtplblocks.oxtemplate }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter" height="20" colspan="2">
        <div class="r1"><div class="b1">
        <div class="find">
            
            <input class="listedit" type="submit" name="submitit" value="[{ oxmultilang ident="GENERAL_SEARCH" }]">
        </div>
        <input class="listedit" type="text" size="32" maxlength="32" name="where[oxtplblocks][oxmodule]" value="[{ $where.oxtplblocks.oxmodule }]">
        </div></div>
    </td>

</tr>
<tr>
    <td class="listheader first" height="15" width="30" align="center"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxtplblocks', 'oxactive', 'asc');document.search.submit();" class="listheader">[{ oxmultilang ident="GENERAL_ACTIVTITLE" }]</a></td>
    <td class="listheader" height="15" width="30"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxtplblocks', 'oxpos', 'asc');document.search.submit();" class="listheader">Sortierung</a></td>
    <td class="listheader" height="15">&nbsp;<a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxtplblocks', 'oxblockname', 'asc');document.search.submit();" class="listheader">Block</a></td>
    <td class="listheader  height="15" width="30"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxtplblocks', 'oxtemplate', 'asc');document.search.submit();" class="listheader">Template</a></td>
    <td class="listheader" colspan="2">&nbsp;<a href="Javascript:top.oxid.admin.setSorting( document.search, 'oxtplblocks', 'oxmodule', 'asc');document.search.submit();" class="listheader">Modul</a></td>
</tr>

[{assign var="blWhite" value=""}]
[{assign var="_cnt" value=0}]
[{foreach from=$mylist item=listitem}]
    [{assign var="_cnt" value=$_cnt+1}]
    <tr id="row.[{$_cnt}]">

    [{ if $listitem->blacklist == 1}]
        [{assign var="listclass" value=listitem3 }]
    [{ else}]
        [{assign var="listclass" value=listitem$blWhite }]
    [{ /if}]
    [{ if $listitem->getId() == $oxid }]
        [{assign var="listclass" value=listitem4 }]
    [{ /if}]
    <td valign="top" class="[{ $listclass}][{ if $listitem->oxtplblocks__oxactive->value == 1}] active[{/if}]" height="15"><div class="listitemfloating">&nbsp</a></div></td>
    <td valign="top" class="[{ $listclass}]" height="15"><a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxtplblocks__oxid->value}]');" class="[{ $listclass}]">[{ $listitem->oxtplblocks__oxpos->value }]</a></td>
    <td valign="top" class="[{ $listclass}]" height="15"><a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxtplblocks__oxid->value}]');" class="[{ $listclass}]">[{ $listitem->oxtplblocks__oxblockname->value }]</a></td>
    <td valign="top" class="[{ $listclass}]" height="15"><a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxtplblocks__oxid->value}]');" class="[{ $listclass}]">[{ $listitem->oxtplblocks__oxtemplate->value|truncate:30 }]</a></td>
   <td valign="top" class="[{ $listclass}]"><a href="Javascript:top.oxid.admin.editThis('[{ $listitem->oxtplblocks__oxid->value}]');" class="[{ $listclass}]">[{ $listitem->oxtplblocks__oxmodule->value|truncate:40 }]</a></td>
    <td class="[{ $listclass}]">
    [{ if !$listitem->isOx() && !$readonly }]
    <a href="Javascript:top.oxid.admin.deleteThis('[{ $listitem->oxtplblocks__oxid->value }]');" class="delete" id="del.[{$_cnt}]" alt="" [{include file="help.tpl" helpid=item_delete}]></a>
    [{/if}]
    </td>
</tr>
[{if $blWhite == "2"}]
[{assign var="blWhite" value=""}]
[{else}]
[{assign var="blWhite" value="2"}]
[{/if}]
[{/foreach}]
[{include file="pagenavisnippet.tpl" colspan="6"}]
</table>
</form>
</div>

[{include file="pagetabsnippet.tpl"}]


<script type="text/javascript">
if (parent.parent)
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem    = "[{ oxmultilang ident="CONTENT_LIST_MENUITEM" }]";
    parent.parent.sMenuSubItem = "[{ oxmultilang ident="CONTENT_LIST_MENUSUBITEM" }]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
</body>
</html>