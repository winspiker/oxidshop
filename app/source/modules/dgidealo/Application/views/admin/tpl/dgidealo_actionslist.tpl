[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]
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

<style>
<!--

.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]?[{$smarty.now}]?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
}

div#pleasewaiting{
    background: red url('[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
    z-index: 50;
    position: absolute; 
    top: 0px; 
    left: 0px; 
    width: 100%; 
    height: 100%; 
    background-color: rgb(255, 255, 255); 
    opacity: 0.8; 
    visibility: hidden;
}

-->
</style>

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<div id="liste">


<form name="search" id="search" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]">
<input type="hidden" name="lstrt" value="[{$lstrt}]">
<input type="hidden" name="actedit" value="[{$actedit}]">
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]">
<input type="hidden" name="fnc" value="[{$fnc}]">
<input type="hidden" name="language" value="[{$actlang}]">
<input type="hidden" name="editlanguage" value="[{$editlanguage}]">
<input type="hidden" name="delshopid" value="[{$delshopid}]">
<input type="hidden" name="updatenav" value="[{$updatenav}]">
<input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
[{* sorting *}]
[{foreach from=$oView->getListSorting() item=aField key=sTable}]
    [{foreach from=$aField item=sSorting key=sField}]
    <input type="hidden" name="sort[[{$sTable}]][[{$sField}]]" value="[{$sSorting}]">
  [{/foreach}]
[{/foreach}]
<table cellspacing="0" cellpadding="0" border="0" width="100%">
<colgroup>
    <col width="10%">
    <col width="20%">
    <col width="10%">
    <col width="10%">
    <col width="60%">
    <col width="1%">
<colgroup>
<tr class="listitem">
   <td valign="top" class="listfilter first" height="20">
        <div class="r1"><div class="b1">
        <input class="listedit" type="text" size="20" maxlength="128" name="where[dgidealoaction][oxtimestamp]" value="[{ $where.dgidealoaction.oxtimestamp }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter" height="20">
        <div class="r1"><div class="b1">
        <input class="listedit" type="text" size="20" maxlength="128" name="where[dgidealoaction][oxusername]" value="[{ $where.dgidealoaction.oxusername }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter">
        <div class="r1"><div class="b1">
        <input class="listedit" type="text" size="20" maxlength="128" name="where[dgidealoaction][oxart]" value="[{ $where.dgidealoaction.oxart }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter">
        <div class="r1"><div class="b1">
        <input class="listedit" type="text" size="10" maxlength="128" name="where[dgidealoaction][oxtype]" value="[{ $where.dgidealoaction.oxtype }]">
        </div></div>
    </td>
    <td valign="top" class="listfilter" colspan="2" nowrap>
        <div class="r1"><div class="b1">
        <div class="find"><input class="listedit" type="submit" name="submitit" value="[{ oxmultilang ident="GENERAL_SEARCH" }]"></div>
        <input class="listedit" type="text" size="20" maxlength="128" name="where[dgidealoaction][oxmessage]" value="[{ $where.dgidealoaction.oxmessage }]">
        </div>
        </div></div>
    </td>
</tr>
<tr>
    <td class="listheader first" height="15">&nbsp;<a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgidealoaction', 'oxtimestamp', 'asc');document.search.submit();" class="listheader">Datum</a></td>
    <td class="listheader first" height="15">&nbsp;<a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgidealoaction', 'oxusername', 'asc');document.search.submit();" class="listheader">E-Mail</a></td>
    <td class="listheader"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgidealoaction', 'oxart', 'asc');document.search.submit();" class="listheader">Art</a></td>
    <td class="listheader"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgidealoaction', 'oxtype', 'asc');document.search.submit();" class="listheader">Type</a></td>
    <td class="listheader" colspan="2"><a href="Javascript:top.oxid.admin.setSorting( document.search, 'dgidealoaction', 'oxmessage', 'asc');document.search.submit();" class="listheader">Meldung</a></td>
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
    <td valign="top" class="[{ $listclass}]" height="15"><div class="listitemfloating">&nbsp;[{ $listitem->dgidealoaction__oxtimestamp->value }]</div></td>
    <td valign="top" class="[{ $listclass}]" height="15"><div class="listitemfloating">&nbsp;<a href="Javascript:top.oxid.admin.editThis('[{ $listitem->dgidealoaction__oxid->value}]');" class="[{ $listclass}]">[{ $listitem->dgidealoaction__oxusername->value }]</a></div></td>
    <td valign="top" class="[{ $listclass}]"><div class="listitemfloating">[{ $listitem->dgidealoaction__oxart->value|oxtruncate:30:"...":true }]</div></td>
    <td valign="top" class="[{ $listclass}]"><div class="listitemfloating">[{ $listitem->dgidealoaction__oxtype->value }]</div></td>
    <td valign="top" class="[{ $listclass}]"><div class="listitemfloating">[{ $listitem->dgidealoaction__oxmessage->value }]</div></td>

    <td class="[{ $listclass}]">
        [{ if !$listitem->isOx() && !$readonly  && !$listitem->blPreventDelete}]
        <a href="Javascript:top.oxid.admin.deleteThis('[{ $listitem->dgidealoaction__oxid->value }]');" class="delete" id="del.[{$_cnt}]" [{include file="help.tpl" helpid=item_delete}]></a>
        [{ /if }]
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
    parent.parent.sMenuItem    = "[{ oxmultilang ident="USER_LIST_MENNUITEM" }]";
    parent.parent.sMenuSubItem = "[{ oxmultilang ident="USER_LIST_MENNUSUBITEM" }]";
    parent.parent.sWorkArea    = "[{$_act}]";
    parent.parent.setTitle();
}
</script>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
