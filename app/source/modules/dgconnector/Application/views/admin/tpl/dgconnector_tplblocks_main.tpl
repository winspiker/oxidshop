[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{ if $readonly }]
[{assign var="readonly" value="readonly disabled"}]
[{else}]
[{assign var="readonly" value=""}]
[{/if}]

<style>
.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif');
  background-repeat: no-repeat;
  background-position: right bottom;
} 
 
</style>

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="dgconnector_tplblocks_main">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>


<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="cl" value="dgconnector_tplblocks_main" />
    <input type="hidden" name="fnc" value="save" />
    <input type="hidden" name="oxid" value="[{ $oxid }]" />
    <input type="hidden" name="editval[oxtplblocks__oxid]" value="[{ $oxid }]" />
<table cellspacing="0" cellpadding="0" border="0" width="98%">
  <tr>
  <td valign="top" class="edittext">
    <table cellspacing="0" cellpadding="0" border="0" width="98%">
        <tr>
            <td class="edittext">Aktiv</td>
            <td class="edittext">
              <input type="hidden" name="editval[oxtplblocks__oxactive]" value="0" />
              <input type="checkbox" name="editval[oxtplblocks__oxactive]" value="1"[{ if $edit->oxtplblocks__oxactive->value ==1}] checked[{/if}] />
            </td>
        </tr>
        <tr>
            <td class="edittext">Template</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxtemplate]" value="[{ $edit->oxtplblocks__oxtemplate->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">Block</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxblockname]" value="[{ $edit->oxtplblocks__oxblockname->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">Sortierung</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxpos]" value="[{ $edit->oxtplblocks__oxpos->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">Datei</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxfile]" value="[{ $edit->oxtplblocks__oxfile->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">Modul</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxmodule]" value="[{ $edit->oxtplblocks__oxmodule->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">Theme</td>
            <td class="edittext"><input type="text" class="editinput" size="50" name="editval[oxtplblocks__oxtheme]" value="[{ $edit->oxtplblocks__oxtheme->value }]" /></td>
        </tr>
        <tr>
            <td class="edittext">
            </td>
            <td class="edittext"><br />
                <button type="submit" class="edittext" name="save" id="saveFormButton">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </td>
        </tr>
    </table>
    <td>&nbsp;</td>
            <!-- Anfang rechte Seite -->
     <td valign="top" class="edittext" align="left">
       [{ if $oView->getBlockModulList()|@count > 0}]
       <fieldset>
        <legend>Modul Templates des Modul </legend>
       <table cellspacing="0" cellpadding="0" border="0" width="98%">
        
        <tr>
            <td class="edittext">Modul</td>
            <td class="edittext">
              <select name="dgblock" size="1" style="width: 250px;">
                <option value=""> - </option>
                [{foreach from=$oView->getBlockModulList() item=oBlock}]
                   [{ if $oView->hasTitle($oBlock)}]
                   <option value="[{$oBlock}]"[{if $dgblock == $oBlock }] selected[{/if}]>[{ $oView->hasTitle($oBlock)}] ([{$oBlock}])</option>
                   [{else}]
                   <option value="[{$oBlock}]"[{if $dgblock == $oBlock }] selected[{/if}]>[{$oBlock}]</option>
                   [{/if}]
                [{/foreach}]
              </select>
            </td>
        </tr>
        <tr>
            <td class="edittext">
            </td>
            <td class="edittext"><br />
                <button style="width:250px;" onclick="this.form.fnc.value='deleteBlock';" type="submit" class="edittext" name="save"> Templates komplett entfernen</button>
            </td>
        </tr>
        <tr>
            <td class="edittext">
            </td>
            <td class="edittext"><br />
                <button style="width:250px;" onclick="this.form.fnc.value='aktivierenBlock';" type="submit" class="edittext" name="save"> Templates aktivieren</button>
            </td>
        </tr>
        <tr>
            <td class="edittext">
            </td>
            <td class="edittext"><br />
                <button style="width:250px;" onclick="this.form.fnc.value='deaktivierenBlock';" type="submit" class="edittext" name="save"> Templates deaktivieren</button>
            </td>
        </tr>
        <tr>
            <td class="edittext">
            </td>
            <td class="edittext"><br />
                <button style="width:250px;" onclick="this.form.fnc.value='removeDuplikates';" type="submit" class="edittext" name="save"> Duplikate entfernen</button>
            </td>
        </tr>
    </table>
    </fieldset>
    [{/if}]
     </td>
     </tr>

 </table>
 </form>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]