[{*
  *   *********************************************************************************************
  *      Please retain this copyright header in all versions of the software.
  *      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
  *
  *      Copyright (C) Josef A. Puckl | eComStyle.de
  *      All rights reserved - Alle Rechte vorbehalten
  *
  *      This commercial product must be properly licensed before being used!
  *      Please contact info@ecomstyle.de for more information.
  *
  *      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
  *      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
  *   *********************************************************************************************
  *}]
[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]
[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]
<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="ar_settings">
</form>
<script>
function toggle(source) {
  checkboxes = document.getElementsByClassName('edittextcheckbox');
  for(var i=0, n=checkboxes.length;i<n;i++) {
    checkboxes[i].checked = source.checked;
  }
}
</script>
[{if $edit->oxuser__oxrights->value == 'malladmin'}]
<form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="ar_settings">
<input type="hidden" name="fnc" value="">
<input type="hidden" name="oxid" value="[{$oxid}]">
<input type="hidden" name="editval[oxuser__oxid]" value="[{$oxid}]">
<style type="text/css">
.ebene1{margin-left:20px; }
.ebene2{margin-left:40px;}
.ebene3{margin-left:70px;}
.ardivgreen{color:green;}
.ardivred{color:red;}
input[type="checkbox" i] {
    -webkit-appearance: initial;
    box-sizing: border-box;
    border:none;
    padding:7px;
    background-image:url('data:image/gif;base64,R0lGODlhEAAQAMQfAFjMHGrmQ2c4AFGuG2XnPknTJKf1i4joZ9f1zZzyfcn1uVLZLHbhV03UKUzYJEfUIFLXLjKDH1bfJFnYMmrfS5boe2DaP+n94lDaJzB/HV/nM1GSG7F2RVk2Gf///////yH5BAEAAB8ALAAAAAAQABAAAAVy4CeOZCl6aKqqZ3UcDBUQmtbd3nlcCKIoBkNiwunkPh4GYgKBLDDQQfHooSggjazDgYlMTxZDtkB+OLzG0yTRIBcecDR1kXDD4ZkvEnMIzAiABAJ6HhIAAAOJiRsdhCsqjWkmJB6RR5MnlpgjlTibJywhADs=')
}
input[type="checkbox" i]:checked {
    -webkit-appearance: inherit;
    box-sizing: border-box;
    border:none;
    padding:7px;
    background-image:url('data:image/gif;base64,R0lGODlhEAAQAMQfAO/v79GdFee+Su/TbvPdgMXFxevJXeO0OPrhkfz10v354v3328SCDti0If377dSlF+vr68mMEcfHx/rwucySEvvzx9XV1ditGvnsqNy2HMN/Dffnkvnadq2trf///////yH5BAEAAB8ALAAAAAAQABAAAAV24CeKXmmOKNmtrJeqniVLReeing2wq2TjnZ0pV7uphKZOceTJdCCdRibTUHYut6bHoVgkEpUJBhHIZhSYzYYwMAgOiIgZrWa74QzzIr1uvzkaZgl8dn+BJBmDdX4HgFkXCBySk5OHHx4PARQRDBqen5ZDoqIfIQA7')
}
</style>
<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%">
    <tr>
        <td valign="top" class="edittext">
            <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="edittext">
                        <label>
                            <input type="checkbox" onClick="toggle(this)" />[{oxmultilang ident="ecs_selectall"}]
                        </label>
                    </td>
                    <td class="edittext">
                    </td>
                </tr>
                [{if $activeuserid != $oxid}]
                    <tr class="[{if !$oView->hasherights('ecs_adminrights_menu')}]ardivgreen[{else}]ardivred[{/if}]">
                        <td class="edittext">
                            <label>
                                <input class="edittextcheckbox edittext" type="checkbox" name="editval[ecs_adminrights_menu]" value="ecs_adminrights_menu"  [{if $oView->hasherights('ecs_adminrights_menu')}]checked[{/if}] [{$readonly}]>
                                <b>[{'ecs_adminrights_menu'|oxmultilangassign|replace:"ERROR: Translation for ":""|replace:" not found!":""}] - [{oxmultilang ident="ecs_selectadminrights"}]</b>
                            </label>
                        </td>
                    </tr>
                [{/if}]
                <tr>
                    <td class="edittext">
                        [{foreach from=$menustructure item=menuholder}]
                            [{if $menuholder->nodeType == XML_ELEMENT_NODE && $menuholder->childNodes->length}]
                                [{$menuholder->getAttribute('id')|oxmultilangassign|replace:"ERROR: Translation for ":""|replace:" not found!":""}]
                                <hr>
                                [{foreach from=$menuholder->childNodes item=menuitem name=menuloop}]
                                    [{if $menuitem->nodeType == XML_ELEMENT_NODE}]
                                        <label class="ebene_1">
                                            <input class="ebene1 edittextcheckbox edittext" type="checkbox" name="editval[[{$menuitem->getAttribute('id')}]]" value="[{$menuitem->getAttribute('id')}]"  [{if $oView->hasherights($menuitem->getAttribute('id'))}]checked[{/if}] [{$readonly}]>
                                            <span class="[{if !$oView->hasherights($menuitem->getAttribute('id'))}]ardivgreen[{else}]ardivred[{/if}]">[{$menuitem->getAttribute('id')|oxmultilangassign|replace:"ERROR: Translation for ":""|replace:" not found!":""}]<br></span>
                                        </label>
                                     [{foreach from=$menuitem->childNodes item=submenuitem}]
                                            [{if $submenuitem->nodeType == XML_ELEMENT_NODE}]
                                                <label class="ebene_2">
                                                    <input class="ebene2 edittextcheckbox edittext" type="checkbox" name="editval[[{$submenuitem->getAttribute('id')}]]" value="[{$submenuitem->getAttribute('id')}]"  [{if $oView->hasherights($submenuitem->getAttribute('id'))}]checked[{/if}] [{$readonly}]>
                                                    <span class="[{if !$oView->hasherights($submenuitem->getAttribute('id'))}]ardivgreen[{else}]ardivred[{/if}]">[{$submenuitem->getAttribute('id')|oxmultilangassign|replace:"ERROR: Translation for ":""|replace:" not found!":""}]<br></span>
                                                </label>
                                             [{foreach from=$submenuitem->childNodes item=register}]
                                                    [{if $register->nodeType == XML_ELEMENT_NODE && ($register->getAttribute('id') != 'ecs_adminrights_menu')}]
                                                        [{if strpos(($register->getAttribute('id')|oxmultilangassign), "_new") !== false or strpos(($register->getAttribute('id')|oxmultilangassign), "_refresh") !== false or strpos(($register->getAttribute('id')|oxmultilangassign), "_reset") !== false or strpos(($register->getAttribute('id')|oxmultilangassign), "_preview") !== false}]
                                                        [{else}]
                                                            <label class="ebene_3">
                                                                <input class="ebene3 edittextcheckbox edittext" type="checkbox" name="editval[[{$register->getAttribute('id')}]]" value="[{$register->getAttribute('id')}]"  [{if $oView->hasherights($register->getAttribute('id'))}]checked[{/if}] [{$readonly}]>
                                                                <span class="[{if !$oView->hasherights($register->getAttribute('id'))}]ardivgreen[{else}]ardivred[{/if}]">[{$register->getAttribute('id')|oxmultilangassign|replace:"ERROR: Translation for ":""|replace:" not found!":""}]<br></span>
                                                            </label>
                                                     [{/if}]
                                                    [{/if}]
                                                [{/foreach}]
                                            [{/if}]
                                        [{/foreach}]
                                        <hr>
                                    [{/if}]
                                [{/foreach}]
                            [{/if}]
                        [{/foreach}]
                    </td>
                </tr>
            </table>
        </td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td valign="top" class="edittext">
            <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="copypastetext" id="ar_savebutton">
                        <input style="position: fixed;" type="submit" class="edittext" name="save" value="[{oxmultilang ident="GENERAL_SAVE"}]" onClick="Javascript:document.myedit.fnc.value='save'" [{$readonly}]>
                        <div style="position: fixed;top:60px;background-color:#f2f2f2;padding:10px;border-radius:4px;white-space:normal;max-width: 350px;">
                            [{oxmultilang ident="ecs_adminright_info"}]
                            <br><br>
                            <u>[{oxmultilang ident="ecs_adminright_more" suffix="COLON"}]</u>
                            <br><br>
                            [{foreach from=$oView->findadmins() item=admin name=admins}]
                                [{$admin}]<br>
                            [{/foreach}]
                        </div>
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top" class="edittext" align="left" width="50%">
        </td>
    </tr>
</table>
</form>
[{else}]
    [{oxmultilang ident="ecs_arlastinfo"}]
    <br><br>
    <u>[{oxmultilang ident="ecs_adminright_more" suffix="COLON"}]</u>
    <br><br>
    [{foreach from=$oView->findadmins() item=admin name=admins}]
        [{$admin}]<br>
    [{/foreach}]
[{/if}][{* [{if $edit->oxuser__oxrights->value == 'malladmin'}]  *}]
<br><br><br>
[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]