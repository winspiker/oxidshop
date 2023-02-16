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
[{include file="_formparams.tpl" cl="dgottomatching_list" lstrt=$lstrt actedit=$actedit oxid=$oxid fnc="" language=$actlang editlanguage=$actlang}]
<table cellspacing="0" cellpadding="0" border="0" width="100%">
   <colgroup>
   <col width="3%">
        <col width="45%">
        <col width="45%">
        <col width="7%">
    </colgroup>
<tr class="listitem">
<td valign="top" class="listfilter first" align="center">
   <div class="r1">
     <div class="b1">
       <input class="listedit" type="text" size="2" maxlength="1" name="where[dgottomatching][oxuseforall]" value="[{$where.dgottomatching.oxuseforall}]" />
     </div>
   </div>
 </td>
 <td valign="top" class="listfilter" align="left">
   <div class="r1">
     <div class="b1">
       <input class="listedit" type="text" size="60" maxlength="128" name="where[dgottomatching][oxtheme]" value="[{$where.dgottomatching.oxtheme}]" />
     </div>
   </div>
 </td>
 <td valign="top" class="listfilter" height="20" colspan="2">
   <div class="r1">
     <div class="b1">
       <div class="find">
         <button class="listedit" type="submit" name="submitit">[{oxmultilang ident="GENERAL_SEARCH"}]</button>
       </div>
       <select class="editinput" name="where[dgottomatching][oxcategory]" size="1" onchange="Javascript:document.search.lstrt.value=0;document.search.submit();">
         <option value=""> - alle - </option>
         [{foreach from=$oView->getUseCategory() item=oCategory}]
         <option[{if  $where.dgottomatching.oxcategory == $oCategory}] selected[{/if}]>[{$oCategory}]</option>
         [{/foreach}]
       </select>
     </div>
   </div>
 </td>
</tr>
<tr>
    <td class="listheader first" height="15"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgottomatching', 'oxuseforall', 'asc');document.search.submit();" class="listheader">alle</a></td>
    <td class="listheader" height="15"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgottomatching', 'oxtheme', 'asc');document.search.submit();" class="listheader">Attribut</a></td>
    <td class="listheader" height="15"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgottomatching', 'oxcategory', 'asc');document.search.submit();" class="listheader">Kategorie</a></td>
    <td class="listheader"></td>
</tr>

[{assign var="blWhite" value=""}]
[{assign var="_cnt" value=0}]
[{foreach from=$mylist item=listitem}]
    [{assign var="_cnt" value=$_cnt+1}]
    <tr id="row.[{$_cnt}]">

    [{if $listitem->blacklist == 1}]
        [{assign var="listclass" value=listitem3}]
    [{else}]
        [{assign var="listclass" value=listitem$blWhite}]
    [{/if}]
    [{if $listitem->getId() == $oxid}]
        [{assign var="listclass" value=listitem4}]
    [{/if}]
    <td valign="top" class="[{$listclass}][{if $listitem->dgottomatching__oxuseforall->value == 1}] active[{/if}]" height="15"><div class="listitemfloating">&nbsp;</div></td>
    <td valign="top" class="[{$listclass}]" height="15"><div class="listitemfloating"><a href="Javascript:top.oxid.admin.editThis('[{$listitem->dgottomatching__oxid->value}]');" class="[{$listclass}]">[{$listitem->dgottomatching__oxtheme->value}]</a></div></td>
    <td valign="top" class="[{$listclass}]" height="15"><div class="listitemfloating"><a href="Javascript:top.oxid.admin.editThis('[{$listitem->dgottomatching__oxid->value}]');" class="[{$listclass}]">[{$listitem->dgottomatching__oxcategory->value}]</a></div></td>
    <td class="[{$listclass}]">
      [{if !$readonly}]
         <a href="Javascript:top.oxid.admin.deleteThis('[{$listitem->dgottomatching__oxid->value}]');" class="delete" id="del.[{$_cnt}]" [{include file="help.tpl" helpid=item_delete}]></a>
      [{/if}]
    </td>
</tr>
[{if $blWhite == "2"}]
[{assign var="blWhite" value=""}]
[{else}]
[{assign var="blWhite" value="2"}]
[{/if}]
[{/foreach}]
[{include file="pagenavisnippet.tpl" colspan="4"}]
</table>
</form>
</div>

[{include file="pagetabsnippet.tpl"}]


<script type="text/javascript">
if (parent.parent)
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->getRawValue()|oxaddslashes}]";
    parent.parent.sMenuItem    = "[{oxmultilang ident="ACTIONS_LIST_MENUITEM"}]";
    parent.parent.sMenuSubItem = "[{oxmultilang ident="ACTIONS_LIST_MENUSUBITEM"}]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
</body>
</html>

