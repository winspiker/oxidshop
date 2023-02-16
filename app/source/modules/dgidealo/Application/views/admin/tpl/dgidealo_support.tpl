[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--
[{ if $updatelist == 1}]
    UpdateList('[{ $oxid }]');
[{ /if}]

function UpdateList( sID)
{
    var oSearch = parent.list.document.getElementById("search");
    oSearch.oxid.value=sID;
    oSearch.submit();
}

function _groupExp(el) {
    var _cur = el.parentNode;

    if (_cur.className == "exp") _cur.className = "";
      else _cur.className = "exp";
}
//-->
</script>
<style>
<!--
.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
}
-->
</style>
[{ if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2" }]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $editshop->oxshops__oxid->value }]">
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]">
    <input type="hidden" name="actshop" value="[{ $editshop->oxshops__oxid->value }]">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

    <div class="groupExp">
        <div class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Kontakformular [{ $send }]</b></a>
            <dl>
          [{ if !$send }]
          <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
        <input type="hidden" name="fnc" value="debugmail" />
        <input type="hidden" name="aStep" value="1" />
        <input type="hidden" name="oxid" value="[{ $editshop->oxshops__oxid->value }]" />
        <table width="100%" class="form">
        <tr>
          <td><label>Vorname&nbsp;&nbsp;</label></td>
          <td><input type="text" name="editval[oxfname]" size="70" maxlength="40" value="[{$editshop->oxshops__oxfname->value }]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Nachname&nbsp;&nbsp;</label></td>
          <td><input type="text" name="editval[oxlname]" size="70" maxlength="40" value="[{$editshop->oxshops__oxlname->value }]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Email&nbsp;&nbsp;</label></td>
          <td><input id="test_contactEmail" type="text" name="editval[oxusername]"  size="70" maxlength="40" value="[{$editshop->oxshops__oxinfoemail->value}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Telefon&nbsp;&nbsp;</label></td>
          <td><input id="test_contactEmail" type="text" name="editval[oxfon]"  size="70" maxlength="40" value="[{$editshop->oxshops__oxfon->value}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Subject&nbsp;&nbsp;</label></td>
          <td><input type="text" name="c_subject" size="70" maxlength="280" value="Supportanfrage zum Modul [{ $oUpdate->getModulName() }], [{$oUpdate->getModulVersion() }]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Nachricht&nbsp;&nbsp;</label></td>
          <td><textarea rows="12" cols="90" name="c_message">Modul: [{ $oUpdate->getModulName() }] 
Version: [{$oUpdate->getModulVersion() }]
Domain: [{ $oUpdate->getSerialHostName() }]

Im Rahmen der Bearbeitung Ihrer Fragen ben&ouml;tigen wir m&ouml;glichst genaue Informationen, um Ihnen schnellstm&ouml;glich helfen zu k&ouml;nnen:

- Welche Schritte haben Sie durchgef&uuml;hrt? 

- Was h&auml;tte passieren sollen? 

- Was ist stattdessen passiert?

- Wie lautet die exakte Fehlermeldung?

- Gibt es konkrete Kunden-, Bestell- oder Artikelnummern, die von dem Problem betroffen sind?  

Ihre Nachricht:        
</textarea></td>
        </tr>
        <tr>
          <td></td>
          <td><br />
            <span class="btn"><button type="submit" class="btn">senden</button></span>
          </td>
        </tr>
      </table>
      </form>
      [{else}]
      <table width="100%" class="form">
      <tr>
          <td> [{$send}] </td>
        </tr>
      </table>
      [{/if}]  
      </dd>

                <div class="spacer"></div>
             </dl>
         </div>
    </div>



[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]