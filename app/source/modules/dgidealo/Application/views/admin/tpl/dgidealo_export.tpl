[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--
function _groupExp(el) {
    var _cur = el.parentNode;

    if (_cur.className == "exp") _cur.className = "";
      else _cur.className = "exp";
}

function showPleaseWait()
{
     var mask = document.getElementById("pleasewaiting");
     
     for (i=0;i<document.getElementsByTagName("div").length; i++) { 
        if ( document.getElementsByTagName("div").item(i).className == "box") 
        {  
        	winW = document.getElementsByTagName("div").item(i).offsetWidth;
            winH = document.getElementsByTagName("div").item(i).offsetHeight;
        } 
     } 

     if(mask )
     {
         mask.style.height = winH - 2;
         mask.style.width = winW - 20;
         mask.style.left = 30;
         mask.style.visibility = 'visible';
     }
}

function hidePleaseWait()
{
    var mask = document.getElementById("pleasewaiting");
    if(mask) mask.style.visibility = 'hidden';
}

function changeField(sName)
{
        var oField = document.getElementsByName( sName );
        doChange( oField[0], oField[1] );
        doChange( oField[1], oField[0] )
    }
function doChange( oField1, oField2 )
    {
        if ( oField1.disabled ) {
            oField1.disabled = '';
            oField1.style.display = '';
            oField1.value = oField2.value;
        } else {
            oField1.disabled = 'disabled';
            oField1.style.display = 'none';
            oField2.value = oField1.value;
        }
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

.groupExp a.rc:hover b, .groupExp .exp a.rc b {
    color: #30528F;
}

.groupExp .exp dt,.groupExp .exp dl{
    font-weight:normal;
}
.errorbox{
    border-color:#f2f2ab;
font-weight:normal;
    color: #535353;
}
.errorbox a{color:#535353}
</style>

[{assign var="dgIdealoLabel" value='dgidealo_order'|oxmultilangassign}]

[{ if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2" }]

<div onclick="hidePleaseWait()" id="pleasewaiting" ></div>

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="fnc" value="" />
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="updatenav" value="" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>

<div class="errorbox">
   <p>
     Benachrichtigen Sie [{$dgIdealoLabel}] unbedingt bei &Auml;nderungen an der Exportdatei via E-Mail (<a href="mailto:tam@idealo.de?subject=[{$oView->getMailContentSubject()}]&body=[{$oView->getMailContentBody()}]">tam@idealo.de</a>).<br />
     Achten Sie darauf das Sie &Auml;nderungen, zu [{$dgIdealoLabel}] Supportzeiten machen, so das Idealo genug Zeit hat um Aktualisierungen druchzuf&uuml;hren.
 </p>
</div>



<form name="fileformat" id="fileformat" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="fileformat" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
<input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "fileformat" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Dateiformat Artikelexport</b></a>
        <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoFileName]" value="[{$oIdealo->getIdealoParam('dgIdealoFileName')}]" [{ $readonly}]>
            </dt>
            <dd>
              Dateiname
            </dd>
            <div class="spacer"></div>
         </dl>  
         <dl>
            <dt>
               welches Zeichen soll einzelnen Felder trennen?<br />
               <table>
                  <tr>
                    <td><input name="confstrs[dgIdealoFieldSeparator]" type="radio" [{ if $oIdealo->getIdealoParam('dgIdealoFieldSeparator') == "PIPE" }]checked[{/if}] value="PIPE">Pipe</td>
                    <td>&nbsp;</td>
                    <td><input name="confstrs[dgIdealoFieldSeparator]" type="radio" [{ if $oIdealo->getIdealoParam('dgIdealoFieldSeparator') == "SEMICOLON" }]checked[{/if}] value="SEMICOLON">Semikolon</td>
                    <td>&nbsp;</td>
                    <td><input name="confstrs[dgIdealoFieldSeparator]" type="radio" [{ if $oIdealo->getIdealoParam('dgIdealoFieldSeparator') == "COMMA" }]checked[{/if}] value="COMMA">Komma</td>
                    <td>&nbsp;</td>
                    <td><input name="confstrs[dgIdealoFieldSeparator]" type="radio" [{ if $oIdealo->getIdealoParam('dgIdealoFieldSeparator') == "TABULATOR"}]checked[{/if}] value="TABULATOR">Tabulator</td>           
                    <td>&nbsp;</td>
                    <td><input name="confstrs[dgIdealoFieldSeparator]" type="radio" [{ if $oIdealo->getIdealoParam('dgIdealoFieldSeparator') == "OTHER"}]checked[{/if}] value="OTHER">Andere</td>
                    <td>&nbsp;</td>
                    <td><input name="confstrs[dgIdealoFieldSeparatorValue]" type="text" maxlength="1" size="3" value="[{$oIdealo->getIdealoParam('dgIdealoFieldSeparatorValue') }]"></td>
                  </tr>
               </table>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
              Welches Zeichen soll den Text umschliessen?<br />
               <select name="confstrs[dgIdealoValueSeparator]" style="width: 50px;">
                 <option value=""  [{ if $oIdealo->getIdealoParam('dgIdealoValueSeparator') == ""  }]selected[{/if}]>&nbsp;</option>
                 <option value='"' [{ if $oIdealo->getIdealoParam('dgIdealoValueSeparator') == '"' }]selected[{/if}]>"</option>
                 <option value="'" [{ if $oIdealo->getIdealoParam('dgIdealoValueSeparator') == "'" }]selected[{/if}]>'</option>
               </select>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
              Mit welchem Zeichen sollen die Preise formatiert werden?<br />
               <select name="confstrs[dgIdealoDezimalSeparator]">
                 <option value="," [{ if $oIdealo->getIdealoParam('dgIdealoDezimalSeparator') == "," }]selected[{/if}]>#,## ( 0,00 ) Komma</option>
                 <option value="." [{ if $oIdealo->getIdealoParam('dgIdealoDezimalSeparator') == "." }]selected[{/if}]>#.## ( 0.00 ) Punkt</option>
               </select>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
          <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
       
   </div>
</div>
</form>

<form name="fileformat" id="fileformat" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="artoptionen" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
<input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "artoptionen" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Sortiment &amp; Optionen Artikelexport</b></a>
        <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseContactLenses]" value="false" />
               <input id="dgIdealoUseContactLenses" type="checkbox" name="confbools[dgIdealoUseContactLenses]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseContactLenses') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseContactLenses">Kontaktlinsen werden mit exportiert</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseDrugs]" value="false" />
               <input id="dgIdealoUseDrugs" type="checkbox" name="confbools[dgIdealoUseDrugs]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseDrugs') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseDrugs">Arzneimitteln werden mit exportiert</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealUseCarTiresAndRim]" value="false" />
               <input id="dgIdealUseCarTiresAndRim" type="checkbox" name="confbools[dgIdealUseCarTiresAndRim]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealUseCarTiresAndRim') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealUseCarTiresAndRim">Autoreifen und Felgen werden mit exportiert</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealUseEnergyEfficiencyClass]" value="false" />
               <input id="dgIdealUseEnergyEfficiencyClass" type="checkbox" name="confbools[dgIdealUseEnergyEfficiencyClass]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealUseEnergyEfficiencyClass') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealUseEnergyEfficiencyClass">Elektroger&auml;te werden mit exportiert</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealUseDeposit]" value="false" />
               <input id="dgIdealUseDeposit" type="checkbox" name="confbools[dgIdealUseDeposit]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealUseDeposit') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealUseDeposit">Pfandartikel werden mit exportiert</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealUseLocalStock]" value="false" />
               <input id="dgIdealUseLocalStock" type="checkbox" name="confbools[dgIdealUseLocalStock]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealUseLocalStock">Lokales Inventar nutzen</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseExpert]" value="false" />
               <input id="dgIdealoUseExpert" type="checkbox" name="confbools[dgIdealoUseExpert]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseExpert">Expertenoption f&uuml;r weitere Datenbankfelder</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
          <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
       
   </div>
</div>
</form>

<form name="myedit3" id="myedit3" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="3" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
<input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "3" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Feeddaten Artikelexport</b></a>        
         <dl>
            <dt>
                <select name="confstrs[dgIdealoActive]" class="editinput" style="width:200px;">
                  <option value="">nicht nutzen</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc }]" [{ if $oIdealo->getIdealoParam('dgIdealoActive')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> 
            </dt>
            <dd>
            [{ if !$oIdealo->getIdealoParam('dgIdealoActive') }]
                     <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createEnumField';this.form.dgfield.value='dgidealo';this.form.dgparam.value='dgIdealoActive';showPleaseWait();">Feld erstellen</button>
                    [{/if}]
                   [{ if $oIdealo->getIdealoParam('dgIdealoActive')|lower == "dgidealo" }] <button type="button" class="edittext" onclick="JavaScript:showDialog('&cl=dgidealo_main&aoc=dgidealoactiv');">Artikel zuordnen</button>[{/if}]
               Welches OXID Datenbankfeld soll f&uuml;r die [{$dgIdealoLabel}] Artikel Einsch&auml;nkung/Auswahl genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>          
         <dl>
            <dt>
                <select name="confstrs[dgIdealoArtnum]" class="editinput" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc }]" [{ if $oIdealo->getIdealoParam('dgIdealoArtnum')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_ID_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Artikel-Id</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>       
         <dl>
            <dt>
                <select name="confstrs[dgIdealoTitle]" class="editinput" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc }]" [{ if $oIdealo->getIdealoParam('dgIdealoTitle')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_NAME_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Artikelbezeichnung </b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>  
         [{ if $oIdealo->getIdealoParam('dgIdealoUseDrugs') }]     
         <dl>
            <dt>
                <select name="confstrs[dgIdealoPnz]" class="editinput" style="width:200px;">
                <option value="" SELECTED>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoPnz')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_PNZ_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Pharmazentralnummer  </b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
         <dl>
            <dt>
                <select name="confstrs[dgIdealoManufacturer]" class="editinput" style="width:200px;">
                 [{assign var="ident" value="GENERAL_ARTICLE_OXMANUFACTURERID"}]
                 <option value="OXMANUFACTURERID" [{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|oxupper == 'OXMANUFACTURERID' }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{assign var="ident" value="GENERAL_ARTICLE_OXVENDORID"}]
                 <option value="OXVENDORID" [{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|oxupper == 'OXVENDORID' }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=""}]</option>
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_MANUFACTURER_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Herstellerbezeichnung</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoDescription]" class="editinput" style="width:200px;">
                <option value="nodesc" [{ if $oIdealo->getIdealoParam('dgIdealoDescription') == "nodesc" }]SELECTED[{/if}]>keine Beschreibung &uuml;bertragen</option>
                <option value="oxlongdesc" [{ if $oIdealo->getIdealoParam('dgIdealoDescription') == "oxlongdesc" }]SELECTED[{/if}]>Langbeschreibung</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc }]" [{ if $oIdealo->getIdealoParam('dgIdealoDescription')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_DESCRIPTION_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Artikelbeschreibung</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoMpnr]" class="editinput" style="width:200px;">
                 <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoMpnr')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_MPNR_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Hersteller-Artikelnummer</b> genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoEan]" class="editinput" style="width:200px;">
                <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoEan')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                [{/foreach}]
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_EAN_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>European Article Number</b> genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>
          <dl>
            <dt>
                <select name="confstrs[dgIdealoImage]" class="editinput" style="width:200px;">
                <option value="nopictures" [{ if $oIdealo->getIdealoParam('dgIdealoDeiveryArt') == "nopictures" }]SELECTED[{/if}]>kein Bild &uuml;bertragen</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 [{ if preg_match( "/oxpic/", $desc|lower  ) }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoImage')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/if}]
                 [{/foreach}]
                 </select> 
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Bild</b> genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoDirectPurchaseRelease]" class="editinput" style="width:200px;">
                <option value="1" [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "1"     }]SELECTED[{/if}]>fester Wert 1 &uuml;bertragen</option>
                <option value="0" [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "0"     }]SELECTED[{/if}]>fester Wert 0 &uuml;bertragen</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "0" || $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "1" }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease')|upper == "DGIDEALODIRECTPURCHASERELEASE"}]
                 <button type="button" class="edittext" onclick="JavaScript:showDialog('&cl=dgidealo_main&aoc=dgidealodirectpurchaserelease');">Artikel zuordnen</button>
                 [{/if}]
            </dt>
            <dd>
             Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Direktkauf: Direktkauffreigabe</b> genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>    
         <dl>
            <dt>
                <select name="confstrs[dgIdealoDeliveryArt]" class="editinput" style="width:200px;">
                <option value="Download"     [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Download"     }]SELECTED[{/if}]>fester Wert Download &uuml;bertragen</option>
                <option value="Paketdienst"  [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Paketdienst"  }]SELECTED[{/if}]>fester Wert Paketdienst &uuml;bertragen</option>
                <option value="Spedition"    [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Spedition"    }]SELECTED[{/if}]>fester Wert Spedition &uuml;bertragen</option>
                <option value="Briefversand" [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Briefversand" }]SELECTED[{/if}]>fester Wert Briefversand &uuml;bertragen</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoDeliveryArt') || $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Download" || $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Paketdienst" || $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Spedition" || $oIdealo->getIdealoParam('dgIdealoDeliveryArt') == "Briefversand" }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> 
                 [{ if $oIdealo->getIdealoParam('dgIdealoDeliveryArt')|upper == "DGIDEALODELIVERYART"}]
                 <button type="button" class="edittext" onclick="JavaScript:showDialog('&cl=dgidealo_main&aoc=dgidealodeliveryart');">Artikel zuordnen</button>
                 [{/if}]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>Direktkauf: Versandart</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') }]
         <dl>
            <dt>
                <select name="confstrs[dgIdealoArt2Local]" class="editinput" style="width:200px;">
                <option value="all" [{ if $oIdealo->getIdealoParam('dgIdealoArt2Local') == "all" }]SELECTED[{/if}]>fester Wert alle Artikel nutzen</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoArt2Local') || $oIdealo->getIdealoParam('dgIdealoArt2Local') == "all" }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoArt2Local')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> 
                 [{ if $oIdealo->getIdealoParam('dgIdealoArt2Local')|upper == "DGIDEALOART2LOCAL"}]
                 <button type="button" class="edittext" onclick="JavaScript:showDialog('&cl=dgidealo_main&aoc=dgidealoart2local');">Artikel zuordnen</button>
                 [{/if}]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Lokales Inventar: Artikelauswahl</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoBranchId]" class="editinput" style="width:200px;">
                <option value="Download"     [{ if $oIdealo->getIdealoParam('dgIdealoBranchId') == "Download"     }]SELECTED[{/if}]>fester Wert Download &uuml;bertragen</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoBranchId') || $oIdealo->getIdealoParam('dgIdealoBranchId') == "Download"  }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoBranchId')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> 
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Lokales Inventar: branchId</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]         
         [{assign var="isUseOxvarselect" value=false}]
         [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
           [{assign var="aField" value="dgIdealo"|cat:$oName}]
           <dl>
            <dt>
                <select name="confstrs[[{$aField}]]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 <option value="oxvarselect" [{ if $oIdealo->getIdealoParam($aField) == "oxvarselect" }]SELECTED[{assign var="isUseOxvarselect" value=true}][{/if}]>Artikelfeld Variantenauswahl</option>
                 [{foreach from=$oView->getAttributeList() item=desc}]
                     <option value="[{ $desc->oxid  }]" [{ if $oIdealo->getIdealoParam($aField) == $desc->oxid }]SELECTED[{/if}]>[{ $desc->oxtitle }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident=$oIdealo->getFineName($aField) }]
            </dt>
            <dd>
              Welches OXID Attribut soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>[{$oName}]</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>  
         [{/foreach}]   
         
         [{foreach from=$oIdealoValues->getIdealoTextFields() item=oName }]
         [{assign var="aField" value="dgIdealo"|cat:$oName}]
         <dl>
            <dt>
                <select name="confstrs[[{$aField}]]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam($aField) }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam($aField)|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident=$aField }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam($aField) }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createVacharField';this.form.dgfield.value='[{$aField|replace:"-":""}]';this.form.dgparam.value='[{$aField}]';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] Attribut <b>[{$oName}]</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
        [{/foreach}]    
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
       
   </div>
</div>
</form>

[{ if $isUseOxvarselect }]
<form name="oxvarselect" id="oxvarselect" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="oxvarselect" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
<input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "oxvarselect" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Attribute &uuml;ber Variantenauswahl nuzen</b></a>   
        [{section name=customer loop=4 name="time"}]
        <dl>
            <dt>
              [{assign var="aField" value="dgIdealoVarSelect"|cat:$smarty.section.time.rownum}]
              <select name="confstrs[[{$aField}]]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                   <option value="[{ $oName  }]" [{ if $oIdealo->getIdealoParam($aField) == $oName }]SELECTED[{/if}]>[{ $oName }]</option>
                 [{/foreach}]
              </select>  
            </dt>
            <dd> Varianten Auswahl [{$smarty.section.time.rownum }] </dd>
            <div class="spacer"></div>
         </dl>
         [{/section}]  
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>
[{/if}]

<form name="textfields" id="textfields" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="textfields" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
<input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "textfields" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Preise</b></a>   
        <dl>
            <dt>
                <select name="confstrs[dgIdealoPrice]" class="editinput" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 [{ if preg_match( "/price/", $desc|lower ) }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoPrice')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/if}]
                 [{/foreach}]
                 <option value="brutprice" [{ if $oIdealo->getIdealoParam('dgIdealoPrice') == 'brutprice' }]SELECTED[{/if}]>Standardpreis mit Berechnung </option>
                 </select> [{ oxinputhelp ident="DGIDEALO_FIELD_PRICE_HELP" }]
            </dt>
            <dd>
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Preis</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoMinPrice]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoMinPrice') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 [{ if preg_match( "/price/", $desc|lower ) }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoMinPrice')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/if}]
                 [{/foreach}]
                 <option value="brutprice" [{ if $oIdealo->getIdealoParam('dgIdealoMinPrice') == 'brutprice' }]SELECTED[{/if}]>Standardpreis mit Berechnung </option>
                 </select> [{ oxinputhelp ident="dgIdealoMinPrice" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoMinPrice') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createDoubleField';this.form.dgfield.value='dgidealominprice';this.form.dgparam.value='dgIdealoMinPrice';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Direktkauf: Preisspanne / Mindestpreis</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         
         <dl>
            <dt>
                <select name="confstrs[dgIdealoEquipmentEntrainment]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoEquipmentEntrainment" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createDoubleField';this.form.dgfield.value='dgIdealoEquipmentEntrainment';this.form.dgparam.value='dgIdealoEquipmentEntrainment';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Direktkauf: Kosten Altger&auml;temitnahme</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoCostUpToPlace]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoCostUpToPlace') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoCostUpToPlace')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoCostUpToPlace" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoCostUpToPlace') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createDoubleField';this.form.dgfield.value='dgIdealoCostUpToPlace';this.form.dgparam.value='dgIdealoCostUpToPlace';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Direktkauf: Lieferkosten bis zum Aufstellort</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getIdealoParam('dgIdealUseDeposit') }]
         <dl>
            <dt>
                <select name="confstrs[dgIdealoDepositValue]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoDepositValue') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoDepositValue')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoDepositValue" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoDepositValue') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createDoubleField';this.form.dgfield.value='dgIdealoDepositValue';this.form.dgparam.value='dgIdealoDepositValue';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Pfandwert</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
         <dl>
            <dt>
                <select name="confstrs[dgIdealoUseVpe]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoUseVpe') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoUseVpe')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoUseVpe" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoUseVpe') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createIntField';this.form.dgfield.value='oxvpe';this.form.dgparam.value='dgIdealoUseVpe';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Verpackungseinheit</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoUseVpeUnit]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoUseVpeUnit') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoUseVpeUnit')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoUseVpeUnit" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoUseVpeUnit') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createVacharField';this.form.dgfield.value='DGIDEALOVPEUNIT';this.form.dgparam.value='dgIdealoUseVpeUnit';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Verpackungseinheit Unitname</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
        <dl>
			<dt> 
            <table>
             [{foreach from=$oIdealoValues->getIdealoPaymentsPriceFields() item=oPayName }]
             [{assign var="aField" value="dgIdealo"|cat:$oPayName|cat:"Price"}]
             [{assign var="aFieldUse" value="dgIdealo"|cat:$oPayName|cat:"PriceUse"}]
             <tr>
               <td>
               [{ if !$oIdealo->getIdealoParam($aFieldUse) }]
                <input type="hidden" name="confbools[[{$aFieldUse}]]" value="false" />
                <input type="checkbox" id="[{$aFieldUse}]" name="confbools[[{$aFieldUse}]]" value="true" [{ if $oIdealo->getIdealoParam($aFieldUse) }]checked[{/if}] />
               [{else}]
	             <input class="edittext" type="text" name="confstrs[[{$aField}]]" value="[{ $oIdealo->getIdealoParam($aField)|default:"0.00" }]" size="5" style="text-align:right;"/> 
               [{/if}]
               </td>
               [{ if !$oIdealo->getIdealoParam($aFieldUse) }]
               <td>
                  <label for="[{$aFieldUse}]">Preisaufschlag f&uuml;r die Zahlart <b>[{$oPayName|htmlentities}]</b> an [{$dgIdealoLabel}] &uuml;bermittelt werden ?</label>
               </td> 
             </tr>
             [{else}] 
             </tr> 
               <td>
                  Welcher Preisaufschlag soll f&uuml;r die Zahlart <b>[{$oPayName|htmlentities}]</b> an [{$dgIdealoLabel}] &uuml;bermittelt werden ?
               </td>
               <tr>
                 <td colspan="2">
                  <input type="hidden" name="confbools[[{$aFieldUse}]]" value="false" />
                  <input type="checkbox" id="[{$aFieldUse}]" name="confbools[[{$aFieldUse}]]" value="true" [{ if $oIdealo->getIdealoParam($aFieldUse) }]checked[{/if}] />
                  <label for="[{$aFieldUse}]">Preisaufschlag f&uuml;r die Zahlart <b>[{$oPayName|htmlentities}]</b> an [{$dgIdealoLabel}] senden.</label>
                  </td>
             </tr>
             [{/if}]
             <tr>
              <td colspan="2"><hr /></td>
             </tr>
             [{/foreach}]
             </table>
         </dt>
         <dd></dd>
         <div class="spacer"></div>
         </dl>    
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
       
   </div>
</div>
</form>

[{ if $oIdealo->getIdealoParam('dgIdealoPriceByTime') }]
<form action="[{ $oViewConf->getSelfLink() }]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="timeprice" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="fnc" value="save" />
      [{ $oViewConf->getHiddenSid() }]    
      <div class="groupExp">
        <div [{ if $aStep == "articlestock" }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Preis nach Uhrzeit </b></a>
            [{foreach from=$oView->getTime() name="timeid" item=dTime }]
            [{assign var="dgIdealoPrice" value="dgIdealo"|cat:$dTime|cat:"Price"|replace:":00:00":""}]
            <dl>
			   <dt style="font-weight:normal;"> 
	              <select name="confstrs[[{$dgIdealoPrice}]]" class="editinput" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                 [{ if preg_match( "/price/", $desc|lower ) }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam($dgIdealoPrice)|oxupper == $desc|oxupper || ( !$oIdealo->getIdealoParam($dgIdealoPrice) && $desc|oxupper == "OXPRICE" ) }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/if}]
                 [{/foreach}]
                 <option value="brutprice" [{ if $oIdealo->getIdealoParam($dgIdealoPrice) == 'brutprice' }]SELECTED[{/if}]>Standardpreis mit Berechnung </option>
                 </select>
                </dt>
                <dd> [{$dTime }] Uhr </dd>
                <div class="spacer"></div>
            </dl>
            [{/foreach}]

            <dl>
			    <dt> <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button> <br /><br /></dt>
				<dd> &nbsp; </dd>
             </dl>
         </div>
      </div>
      </form> 
[{/if}]

      <form action="[{ $oViewConf->getSelfLink() }]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="articlestock" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="fnc" value="save" />
      [{ $oViewConf->getHiddenSid() }]    
      <div class="groupExp">
        <div [{ if $aStep == "articlestock" }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Lagerverwaltung </b></a>
            <dl>
            <dt>
                <select name="confstrs[dgIdealoStock]" class="editinput" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoStock')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> 
            </dt>
            <dd>
             Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Lagerbestand</b> genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoDirektStock]" class="editinput" style="width:200px;">
                 <option value="">- nicht nutzen -</option>
                 [{ if !$oIdealo->getIdealoParam('dgIdealoDirektStock') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper }]
                   <option value="[{ $desc|lower  }]" [{ if $oIdealo->getIdealoParam('dgIdealoDirektStock')|oxupper == $desc|oxupper }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                 [{/foreach}]
                 </select> [{ oxinputhelp ident="dgIdealoDirektStock" }]
            </dt>
            <dd>
              [{ if !$oIdealo->getIdealoParam('dgIdealoDirektStock') }]
                <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createDoubleField';this.form.dgfield.value='dgidealostock';this.form.dgparam.value='dgIdealoDirektStock';showPleaseWait();">Feld erstellen</button>
              [{/if}]
              Welches OXID Datenbankfeld soll f&uuml;r das [{$dgIdealoLabel}] <b>Direktkauf: Freigegebene St&uuml;ckzahl</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
			<dt style="font-weight:normal;"> 
	           Standard Lagerbestand f&uuml;r Fremdlager <input class="edittext" type="text" name="confstrs[dgIdealo4Stock]" value="[{ $oIdealo->getIdealoParam('dgIdealo4Stock') }]" size="5" /> St&uuml;ck an [{$dgIdealoLabel}] &uuml;bermitteln.
            </dt>
            <dd></dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
			   <dt style="font-weight:normal;"> 
	              <input class="edittext" type="text" name="confstrs[dgIdealoStockBuffer]" value="[{ $oIdealo->getIdealoParam('dgIdealoStockBuffer') }]" size="5" /> St&uuml;ck immer vom Lagerbestand herunter rechnen als Bestandspuffer.
                </dt>
                <dd> </dd>
                <div class="spacer"></div>
            </dl>
         
            <dl>
			    <dt> <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button> <br /><br /></dt>
				<dd> &nbsp; </dd>
                <div class="spacer"></div>
             </dl>
         </div>
      </div>
      </form>  
      
      <form action="[{ $oViewConf->getSelfLink() }]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="deliverytime" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="fnc" value="save" />
      [{ $oViewConf->getHiddenSid() }]    
      <div class="groupExp">
        <div [{ if $aStep == "deliverytime" }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Lieferzeit </b></a>
         <dl>
            <dt>
                <input class="editinput" size="32" type="text" name="confstrs[dgIdealoDivTime]" value="[{ $oIdealo->getIdealoParam('dgIdealoDivTime') }]" [{ $readonly}]>
                [{ oxinputhelp ident="dgIdealoDivTime" }]
            </dt>
            <dd>
              Welche <b>Lieferzeit</b> Angabe m&ouml;chten Sie an [{$dgIdealoLabel}] &uuml;bermitteln              
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
              Lagermeldung f&uuml;r [{$dgIdealoLabel}] bei &quot;Sofort Lieferbar&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoOnStock]" value="[{$oIdealo->getIdealoParam('dgIdealoOnStock') }]" /> [{ oxinputhelp ident="dgIdealoDivTime" }]
              <br /><br />
              Lagermeldung f&uuml;r [{$dgIdealoLabel}] bei &quot;wenige Artikel auf Lager&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoLowStock]" value="[{$oIdealo->getIdealoParam('dgIdealoLowStock') }]" /> [{ oxinputhelp ident="dgIdealoDivTime" }]
              <br /><br />
              Lagermeldung f&uuml;r [{$dgIdealoLabel}] bei &quot;Ausverkauft&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoNotOnStock]" value="[{$oIdealo->getIdealoParam('dgIdealoNotOnStock') }]" /> [{ oxinputhelp ident="dgIdealoDivTime" }]
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseOxNoStockText]" value="false" />
               <input type="checkbox" id="dgIdealoUseOxNoStockText" name="confbools[dgIdealoUseOxNoStockText]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseOxNoStockText') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseOxNoStockText">Artikel &quot;Info falls Artikel nicht auf Lager&quot; nutzen</label> 
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseOxStockText]" value="false" />
               <input type="checkbox" id="dgIdealoUseOxStockText" name="confbools[dgIdealoUseOxStockText]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseOxStockText') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseOxStockText">Artikel &quot;Info falls Artikel auf Lager&quot; nutzen</label> 
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoUseArticleDeliverTime]" value="false" />
               <input type="checkbox" id="dgIdealoUseArticleDeliverTime" name="confbools[dgIdealoUseArticleDeliverTime]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseArticleDeliverTime') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoUseArticleDeliverTime">Artikel Mindest und Maximale Lieferzeit nutzen</label> 
            </dd>
            <div class="spacer"></div>
         </dl>       
         <dl>
		    <dt> <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button> <br /><br /></dt>
			<dd> &nbsp; </dd>
            <div class="spacer"></div>
         </dl>
       </div>
      </div>
      </form>  

      <form action="[{ $oViewConf->getSelfLink() }]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="articlesbrandsblock" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="type" value="dgIdealoBlockList" />
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
      [{ $oViewConf->getHiddenSid() }]        
	  <div class="groupExp">
        <div [{ if $aStep == "articlesbrandsblock" }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Hersteller &amp; Marke blockieren</b></a>
             <dl>
               <dt>
               <table cellspacing="0" cellpadding="0" border="0" width="600">
                 <tr>
                    <td colspan="6">                       
                    Hier k&ouml;nnen Sie [{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|lower == "oxmanufacturerid" }]Hersteller[{else}]Lieferanten[{/if}] ausschliessen die nicht in [{$dgIdealoLabel}] angezeigt werden d&uuml;rfen.
                    <br />W&auml;hlen Sie den [{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|lower == "oxmanufacturerid" }]Hersteller[{else}]Lieferanten[{/if}] und dr&uuml;cken auf das Plus Zeichen zum hinzuf&uuml;gen.<br />
                    Mit dem rotem Kreuz k&ouml;nnen Sie die Hersteller auch wieder frei geben.<br /><br />
                    </td>
                 </tr>
                 [{ if $oIdealo->getIdealoParam("dgIdealoBlockList")  }]
                 [{foreach from=$oIdealo->getIdealoParam("dgIdealoBlockList") key=ab item=sets }]
                 <tr>
                   <td colspan="5">[{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|lower == "oxmanufacturerid" }]Hersteller[{else}]Lieferant[{/if}] &quot;[{ foreach from=$oView->getManufacturerBlockList() item=oObj}][{if $oObj->oxid == $sets }][{$oObj->oxtitle}]&quot; ([{$oObj->oxid}])[{/if}][{/foreach}]
                   
                  wird in [{$dgIdealoLabel}] ausgeblendet.
                   <td width="12"><a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&type=dgIdealoBlockList&value=[{$sets}]&fnc=deleteValue&oxid=[{$oViewConf->getActiveShopId()}]&aStep=articlesbrands" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                 </tr>
                 [{/foreach}]
                 [{/if}]
                 <tr>
                   <td nowarp> [{ if $oIdealo->getIdealoParam('dgIdealoManufacturer')|lower == "oxmanufacturerid" }]Hersteller[{else}]Lieferant[{/if}]</td>
                   <td>
                      <select class="select" size="1" name="para" [{ $readonly}]>
                       [{ foreach from=$oView->getManufacturerBlockList() item=oObj}]
                        <option value="[{$oObj->oxid}]">[{$oObj->oxtitle}]</option>
                       [{/foreach}]
                     </select>&nbsp;in [{$dgIdealoLabel}] ausblenden&nbsp;
                   </td>
                   <td nowarp></td>
                   <td>
                     <input type="hidden" class="editinput" name="value" value="block" />
                   </td>
                   <td>&nbsp;</td>
                   <td><input type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" onclick="this.form.fnc.value='addvalue';this.form.value.value=this.form.para.value;showPleaseWait();" class="confinput" name="save" value="+"></td>                  
                 </tr>
                </table>
               </dt>
               <dd>&nbsp;</dd>
               <div class="spacer"></div>
             </dl>
         </div>
    </div>
    </form>
    
    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="articlecategoryblock" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="type" value="dgIdealoCategoryBlockList" />
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
      [{ $oViewConf->getHiddenSid() }]        
	  <div class="groupExp">
        <div [{ if $aStep == "articlecategoryblock" }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Kategorie blockieren</b></a>
             <dl>
               <dt>
               <table cellspacing="0" cellpadding="0" border="0" width="600">
                 <tr>
                    <td colspan="6">                       
                    Hier k&ouml;nnen Sie Kategorien ausschliessen die nicht in [{$dgIdealoLabel}] angezeigt werden d&uuml;rfen.
                    <br />W&auml;hlen Sie eine Kategorie und dr&uuml;cken auf das Plus Zeichen zum hinzuf&uuml;gen.<br />
                    Mit dem rotem Kreuz k&ouml;nnen Sie die Kategorie auch wieder frei geben.<br /><br />
                    </td>
                 </tr>
                 [{ if $oIdealo->getIdealoParam("dgIdealoCategoryBlockList")  }]
                 [{foreach from=$oIdealo->getIdealoParam("dgIdealoCategoryBlockList") key=ab item=sets }]
                 <tr>
                   <td colspan="5">Kategorie &quot;[{ foreach from=$oView->getCategoryList() item=pcat}][{if $pcat->oxcategories__oxid->value == $sets }][{ $pcat->oxcategories__oxtitle->value|oxtruncate:40:"..":true }]&quot;[{/if}][{/foreach}]
                   
                  wird in [{$dgIdealoLabel}] ausgeblendet.
                   <td width="12"><a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&type=dgIdealoCategoryBlockList&value=[{$sets}]&fnc=deleteValue&oxid=[{$oViewConf->getActiveShopId()}]&aStep=articlecategoryblock" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                 </tr>
                 [{/foreach}]
                 [{/if}]
                 <tr>
                   <td nowarp> Kategorie</td>
                   <td>
                      <select class="select" size="1" name="para" [{ $readonly}]>
                       [{foreach from=$oView->getCategoryList() item=pcat}]
                         <option value="[{ $pcat->oxcategories__oxid->value }]">[{ $pcat->oxcategories__oxtitle->value|oxtruncate:40:"..":true }]</option>
                       [{/foreach}]
                     </select>&nbsp;in [{$dgIdealoLabel}] ausblenden&nbsp;
                   </td>
                   <td nowarp></td>
                   <td>
                     <input type="hidden" class="editinput" name="value" value="block" />
                   </td>
                   <td>&nbsp;</td>
                   <td><input type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" onclick="this.form.fnc.value='addvalue';this.form.value.value=this.form.para.value;showPleaseWait();" class="confinput" name="save" value="+"></td>                  
                 </tr>
                </table>
               </dt>
               <dd>&nbsp;</dd>
               <div class="spacer"></div>
             </dl>
         </div>
    </div>
    </form>

   <form action="[{ $oViewConf->getSelfLink() }]" method="post">
    <input type="hidden" name="fnc" value="addvalue" />
    <input type="hidden" name="type" value="dgIdealoDeliveryCostDe" />
    <input type="hidden" name="aStep" value="delivery" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
    [{ $oViewConf->getHiddenSid() }]        
	  <div class="groupExp">
        <div [{ if $aStep == "delivery" }] class="exp"[{/if}]>
          <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Versandkosten [{$oIdealo->getLocationName()}]</b></a>
		  <dl>
			   <dt>	
               Versandkosten  
        		<select name="confstrs[dgIdealoCostArt]" size="1">
                  <option value="oxprice"  [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxprice"  }]SELECTED[{/if}]>nach Preis</option>
        		  <option value="oxweight" [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxweight" }]SELECTED[{/if}]>nach Gewicht</option>
                  <option value="oxreal"   [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxreal"   }]SELECTED[{/if}]>berechnet, hoher Performance Bedarf</option>    		
        		</select> berechnen
              </dt>
		      <dd></dd>
              <div class="spacer"></div>
          </dl>
          [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') != "oxreal" }]
          <dl>
            <dt>
               [{assign var="del" value=$oIdealo->getIdealoParam('dgIdealoDelivery_De') }]
               <table cellspacing="0" cellpadding="0" border="0" width="600">
                 <tr>
                   <td>Download</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][Download]" value="[{$del.Download}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  </td>
                 </tr>
                 <tr>
                   <td>Paketdienst</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][Paketdienst]" value="[{$del.Paketdienst}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  </td>
                 </tr>
                 <tr>
                   <td>Spedition</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][Spedition]" value="[{$del.Spedition}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  </td>
                 </tr>
                 <tr>
                   <td>Briefversand</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][Briefversand]" value="[{$del.Briefversand}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  </td>
                 </tr>
                 [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') }]
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][PICKUP]" value="[{$del.PICKUP}]" />    
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][LOCAL]" value="[{$del.LOCAL}]" /> 
                 [{/if}]
                </table><br />
                <button type="submit" onclick="this.form.fnc.value='save';showPleaseWait();">speichern</button>
                <br /><br />
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt> </dt>
            <dd> und bzw. oder Versandkosten nach [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxweight"}]Gewicht[{else}]Preis[{/if}] </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
			<dd>	
              <table cellspacing="0" cellpadding="0" border="0" width="600">
               [{foreach from=$oIdealo->getIdealoParam('dgIdealoDeliveryCostDe') item=price  key=ab}]
                 <tr>
                   <td>ab <input size="4" type="text" class="editinput" value="[{ $ab|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;"/> [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}]</td>
                   <td>&nbsp;</td>
                   <td> <input size="4" type="text" class="editinput" value="[{ $price|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten </td>
                   <td width="12"><a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&type=dgIdealoDeliveryCostDe&value=[{$ab}]&fnc=deleteValue&oxid=[{$oxid}]&aStep=delivery" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                 </tr>
                 [{/foreach}]
                 <tr>
                   <td> ab <input size="4" type="text" class="editinput" name="para" value="" style="text-align: right;" /> [{ if $oIdealo->getIdealoParam('dgIdealoCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}] </td>
                   <td>&nbsp;</td>
                   <td><input size="5" type="text" class="editinput" name="value" value="" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  
                   <td><input onclick="this.form.fnc.value='addvalue';this.form.type.value='dgIdealoDeliveryCostDe';showPleaseWait();" type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" class="confinput" name="save" value="+" /></td>
                 </tr>
               </table>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{else}]
         <dl>
            <dt>         
            [{$dgIdealoLabel}] Versandkosten mit der Versandart
               <select name="confstrs[dgIdealoCostArtDelSet]" size="1">
                [{foreach from=$oView->getDeliveryList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoCostArtDelSet') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
                [{/foreach}]
	           </select> berechnen
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>         
            [{$dgIdealoLabel}] Versandkosten mit der Zahlart
               <select name="confstrs[dgIdealoCostArtPayment]" size="1">
                [{foreach from=$oView->getPaymentList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoCostArtPayment') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
                [{/foreach}]
	           </select> berechnen
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt> </dt>
            <dd> <button type="submit" onclick="this.form.fnc.value='save';showPleaseWait();">speichern</button> </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]         
      </div>
    </div>
    </form>
    
<form name="exportoption" id="exportoption" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="exportoption" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
<input type="hidden" name="dgfield" value="" />
    <input type="hidden" name="dgparam" value="" />
<div class="groupExp">
   <div[{ if $aStep == "exportoption" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Export Bedingungen/ Einstellungen</b></a>
          <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoMergeTiitle]" value="false" />
               <input type="checkbox" id="dgIdealoMergeTiitle" name="confbools[dgIdealoMergeTiitle]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoMergeTiitle') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoMergeTiitle">Artikelname mit OXID Auswahlfeld kombinieren</label> 
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoExportWithStock]" value="false" />
               <input type="checkbox" id="dgIdealoExportWithStock" name="confbools[dgIdealoExportWithStock]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoExportWithStock') }]checked[{/if}] />
            </dt>
            <dd>
              <label for="dgIdealoExportWithStock">nur Artikel exportieren mit positiven Lager</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoGroupById]" value="false" />
               <input type="checkbox" id="dgIdealoGroupById" name="confbools[dgIdealoGroupById]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoGroupById') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoGroupById">nach Artikelnummer gruppieren beim Export. (verhindert Doppelte Artikelnummern, aber h&ouml;hrer Performance)</label> 
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoAttrLoad]" [{ $readonly}]>
                 <option value="child"  [{ if $oIdealo->getIdealoParam('dgIdealoAttrLoad') == "child"  }]SELECTED[{/if}]>Attibute vom Artikel auslesen</option>
                 <option value="parent" [{ if $oIdealo->getIdealoParam('dgIdealoAttrLoad') == "parent" }]SELECTED[{/if}]>Attibute vom Vater Artikel auslesen</option>
                 <option value="both"   [{ if $oIdealo->getIdealoParam('dgIdealoAttrLoad') == "both"   }]SELECTED[{/if}]>Attibute vom Artikel und Vater Artikel auslesen</option>
               </select>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input size="4" type="text" name="confstrs[dgIdealoFromExportPrice]" value="[{ $oIdealo->getIdealoParam('dgIdealoFromExportPrice')}]" />
            </dt>
            <dd>
               Artikel erst ab hinterlegten Preis exportieren.
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoArtHours]" [{ $readonly}]>
                 [{section name=customer loop=24 name="time"}]
                   [{ if $smarty.section.time.rownum == 1 }]
                     <option value="[{$smarty.section.time.rownum }] " [{ if $oIdealo->getIdealoParam('dgIdealoArtHours') == $smarty.section.time.rownum }]SELECTED[{/if}]>einmal in der Stunde</option>
                   [{else}]
                     <option value="[{$smarty.section.time.rownum }] " [{ if $oIdealo->getIdealoParam('dgIdealoArtHours') == $smarty.section.time.rownum }]SELECTED[{/if}]>alle [{$smarty.section.time.rownum }] Stunden</option>
                   [{/if}]
                 [{/section}]  
               </select>
            </dt>
            <dd> soll der Artikelexport durchgef&uuml;hrt werden</dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{ $readonly}]>[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>    
[{if $oIdealo->getIdealoParam('dgIdealoUseExpert')}]
    <form name="dgIdealoDbAddFields" id="dgIdealoDbAddFields" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="fnc" value="addvalue" />
    <input type="hidden" name="aStep" value="dgIdealoDbAddFields" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
    <input type="hidden" name="type" value="dgIdealoDbAddFields" />
    [{ $oViewConf->getHiddenSid() }] 
    
    <div class="groupExp">
        <div [{ if $aStep == "dgIdealoDbAddFields" }] class="exp"[{/if}]>
           <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Experten Modus f&uuml;r weitere Exportfelder</b></a>
            <dl>
               <dt>W&auml;hlen Sie hier weitere Felder </dt>
               <dd> &nbsp; </dd>
            </dl> 
            <dl>
               <dt> 
                 <select name="value">
                   <option value="attribut">Attribut hinzuf&uuml;gen</option>
                   <option value="articles">Datenbankfeld aus der Artikeldatenbank hinzuf&uuml;gen</option>
                 </select> 
                 <input name="para" type="hidden" value="[{$smarty.now}]"/>
                 <input type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" onclick="this.form.type.value='dgIdealoDbAddFields';showPleaseWait();" name="save" value="+" />
               </dt>
               <dd> &nbsp; </dd>
               <div class="spacer"></div>
            </dl> 
            [{ if $oIdealo->getIdealoParam('dgIdealoDbAddFields') }]
            <dl>
               <dt> 
               <table>
               <tr>
                 <td class="listheader first">Kopfzeile</td>
                 <td class="listheader">Feld</td>
                 <td class="listheader">anh&auml;ngen</td>
                 <td class="listheader"colspan="2">Sortierung</td>
               </tr>
               [{assign var="aExpert" value=$oView->getExpertFields('dgIdealoDbAddFieldsValue')}]
               [{assign var="blWhite" value=""}]
               [{foreach from=$oIdealo->getIdealoParam('dgIdealoDbAddFields') key=id item=aField }]
               [{assign var="listclass" value=listitem$blWhite }]
               <tr>
                 <td class="[{ $listclass}]">
                   <input name="aExpert[[{$id}]][oxheader]" value="[{ $aExpert.$id.oxheader }]" />
                 </td>
                 <td class="[{ $listclass}]">
                   [{ if $aField == "attribut"}]
                     <select name="aExpert[[{$id}]][oxattribute]">
                       <option value="" style="color: #C23410;"> - nicht gew&auml;hlt - </option>
                        [{foreach from=$oView->getAttributeList() item=oAtr}]
	                      <option value="[{ $oAtr->oxid }]" [{ if $aExpert.$id.oxattribute == $oAtr->oxid }]SELECTED[{/if}]>[{$oAtr->oxtitle}]</option>
                        [{/foreach}]
                      </select>              
                   [{ elseif $aField == "articles"}]
                     <select name="aExpert[[{$id}]][oxarticles]">
                       [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                           [{assign var="ident" value="GENERAL_ARTICLE_"|cat:$desc}]
                           <option value="[{ $desc|lower }]" [{ if $aExpert.$id.oxarticles == $desc|lower }]SELECTED[{/if}]>[{ oxmultilang|truncate:20:"..":true ident=$ident noerror=true alternative=$desc|lower }]</option>
                       [{/foreach}]
                     </select>
                  [{/if}]
               </td>
               <td class="[{ $listclass}]">
                 <input name="aExpert[[{$id}]][oxadd]" value="[{ $aExpert.$id.oxadd }]" />
               </td>
               <td class="[{ $listclass}]">
                 <select name="aExpert[[{$id}]][oxsort]" >
                    [{section name=Inherit loop=$oIdealo->getIdealoParam('dgIdealoDbAddFields')|count step=+1}]
                    <option value="[{$smarty.section.Inherit.index}]" [{ if $aExpert.$id.oxsort  == $smarty.section.Inherit.index }]SELECTED[{/if}]>[{$smarty.section.Inherit.index}]</option>
                    [{/section}]
                  </select> 
                 </td>
                 <td class="[{ $listclass}]" width="12"><a href="[{ $oViewConf->getSelfLink() }][{$dgUrlSeparator}]cl=[{ $oViewConf->getTopActiveClassName() }]&aStep=dgIdealoDbAddFields&type=dgIdealoDbAddFields&value=[{$id}]&fnc=deleteValue&oxid=[{$oViewConf->getActiveShopId()}]" onclick="return confirm('Wollen Sie diesen Eintrag wirklich l&ouml;schen ?');showPleaseWait();"><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border="0"></a></td>
                 </tr>
                 [{if $blWhite == "2"}][{assign var="blWhite" value=""}][{else}][{assign var="blWhite" value="2"}][{/if}]
               [{/foreach}]
               </table>
               </dt>
               <dd> &nbsp; </dd>
               <div class="spacer"></div>
            </dl> 
            <dl>
			    <dt> <button type="submit" onclick="showPleaseWait();this.form.fnc.value='saveExpertFields';this.form.type.value='dgIdealoDbAddFieldsValue';">speichern</button> <br /><br /></dt>
				<dd> &nbsp; </dd>
                <div class="spacer"></div>
             </dl>
             [{/if}]
         </div> 
    </div>
  </form>
[{/if}]   
   
<div class="groupExp">
   <div>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Test Artikelexport</b></a>
        <dl>
          <dt>Ihre Exportdatei: </dt>
           <dd> </dd>
           <div class="spacer"></div>
         </dl>  
         <dl>
            <dt>
              <table border="0" cellPadding="0" cellSpacing="0">
	            <tr>
		          <td><label for="url">Export URL</label></td>
		          <td>
		            <div>
			          <input size="90" type="text" value="[{ $oViewConf->getBaseDir() }]export/[{$oIdealo->getIdealoParam('dgIdealoFileName')|default:"dgidealoexport.csv" }]" />
                    </div>
		          </td>
	            </tr>   
              </table>
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>  
        <dl>
          <dt>
          <table>
            <tr>
              <td valign="top">
                Conjoburl :
                </td>
              <td>
                 <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;location=[{$oIdealo->getLocation()}]&amp;action=article" target="_blank">[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $editlanguage }]&amp;location=[{$oIdealo->getLocation()}]&amp;action=article</a><br />
              </td>
            </tr>
                     <tr>
              <td colspan="2">
              </td>
            </tr>
          </table>
           </dt>
           <dd> </dd>
           <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
                  <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Zeitstempel der Cronjob</b></legend>
				  <ul>
				     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronArticlesHtml') }][{$oIdealo->getIdealoParam('dgIdealoCronArticlesHtml')}][{else}]0000.00.00 00:00:00[{/if}] - Artikel erstellen</li>
				  </ul>
                  </fieldset>
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>    
         <dl>
            <dt>

            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>           
   </div>
</div>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
