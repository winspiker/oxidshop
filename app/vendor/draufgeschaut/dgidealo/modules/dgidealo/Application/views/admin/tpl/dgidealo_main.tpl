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

<form name="config" id="config" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="" />
<input type="hidden" name="aStep" value="config" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "config" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Grundeinstellung zu [{$dgIdealoLabel}] [{$oIdealo->getLocationName()}]</b></a>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoActiv]" value="false" />
               <input id="dgIdealoActiv" type="checkbox" name="confbools[dgIdealoActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoActiv') }]checked[{/if}] />
                [{ oxinputhelp ident="DGIDEALO_ACTIV_HELP" }]
            </dt>
            <dd>
               <label for="dgIdealoActiv">Schnittstelle aktivieren?</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               [{$dgIdealoLabel}]
               <select size="1" name="param[dgIdealoLocation]" onchange="showPleaseWait();this.form.fnc.value='savelocation';this.form.submit();">
                [{ foreach from=$oIdealo->getLocationArray() key=name item=plattform }]
	      		  <option value="[{$plattform}]" [{ if $oIdealo->getLocation() == $plattform }] selected[{/if}]>[{$name}]</option>
                [{/foreach}]
               </select> bearbeiten
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoLang]">
                [{ foreach from=$language key=name item=plattform }]
	      	     <option value="[{$plattform->id }]" [{ if $oIdealo->getIdealoParam('dgIdealoLang') == $plattform->id }] selected[{/if}]>[{$plattform->name}]</option>
               [{/foreach}]
               </select>
            </dt>
            <dd>
              [{ oxmultilang ident="DGIDEALO_LANG" }]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgIdealoCur]" size="1">
        		  [{foreach from=$currency item=cur}]
        		   <option value="[{ $cur->name }]" [{ if $cur->name ==  $oIdealo->getIdealoParam('dgIdealoCur') }]SELECTED[{/if}]>[{ $cur->name }] ( [{$cur->rate}] )</option>
                  [{/foreach}]
        		 </select>  
            </dt>
            <dd>
              Welche W&auml;hrung soll f&uuml;r den Import / Export genutzt werden? 
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoArtCronjobActiv]" value="false" />
               <input id="dgIdealoArtCronjobActiv" type="checkbox" name="confbools[dgIdealoArtCronjobActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoArtCronjobActiv') }]checked[{/if}] />
            </dt>
            <dd>
              <label for="dgIdealoArtCronjobActiv"> Artikelexport automatisiert durch Modulcronjob an [{$dgIdealoLabel}] erstellen</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getLocation() == "de"}]
          <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoOrderCronjobActiv]" value="false" />
               <input id="dgIdealoOrderCronjobActiv" type="checkbox" name="confbools[dgIdealoOrderCronjobActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoOrderCronjobActiv') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoOrderCronjobActiv">Bestellungen von [{$dgIdealoLabel}] automatisiert durch Modulcronjob einlesen</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         [{ if $oIdealo->getIdealoParam( 'dgIdealoOrderApi' ) == "2" }]
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoOrderCatchSystem]">
                 <option value="">- bitte w&auml;hlen -</option>
                 <option value="time" [{ if $oIdealo->getIdealoParam('dgIdealoOrderCatchSystem') == "time" }] selected[{/if}]>Bestellungen abholen nach Zeitraum</option>
                 <option value="new"  [{ if $oIdealo->getIdealoParam('dgIdealoOrderCatchSystem') == "new"  }] selected[{/if}]> nur neue Bestellungen abholen</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoTrackingCronjobActiv]" value="false" />
               <input id="dgIdealoTrackingCronjobActiv" type="checkbox" name="confbools[dgIdealoTrackingCronjobActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingCronjobActiv') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoTrackingCronjobActiv">Versandmeldungen automatisiert durch Modulcronjob an [{$dgIdealoLabel}] senden</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoStornoCronjobActiv]" value="false" />
               <input id="dgIdealoStornoCronjobActiv" type="checkbox" name="confbools[dgIdealoStornoCronjobActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoStornoCronjobActiv') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoStornoCronjobActiv">Stornierungen automatisiert durch Modulcronjob an [{$dgIdealoLabel}] senden</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoPriceByTime]" value="false" />
               <input id="dgIdealoPriceByTime" type="checkbox" name="confbools[dgIdealoPriceByTime]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoPriceByTime') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoPriceByTime">Preise nach Uhrzeit an [{$dgIdealoLabel}] senden</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getLocation() == "de"}]
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoDontShowOrderList]" value="false" />
               <input id="dgIdealoDontShowOrderList" type="checkbox" name="confbools[dgIdealoDontShowOrderList]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoDontShowOrderList') }]checked[{/if}] />
            </dt>
            <dd>
               <label for="dgIdealoDontShowOrderList">Bestell&uuml;bersicht Spalte Bestellherkunft nicht anzeigen</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoDontShowArticleList]" value="false" />
               <input id="dgIdealoDontShowArticleList" type="checkbox" name="confbools[dgIdealoDontShowArticleList]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoDontShowArticleList') }]checked[{/if}] />
               [{ oxinputhelp ident="dgIdealoDontShowArticleList" }]
            </dt>
            <dd>
               <label for="dgIdealoDontShowArticleList">[{$dgIdealoLabel}] Spalte nicht in Artikelliste anzeigen</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoDontArtAttrList]" value="false" />
               <input id="dgIdealoDontArtAttrList" type="checkbox" name="confbools[dgIdealoDontArtAttrList]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList') }]checked[{/if}] />
               [{ oxinputhelp ident="dgIdealoDontArtAttrList" }]
            </dt>
            <dd>
               <label for="dgIdealoDontArtAttrList">Artikelattribute als Liste bearbeiten</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
         <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoCronKey]" value="[{ if !$oIdealo->getIdealoParam('dgIdealoDisableCronKey') }][{ $oIdealo->getCronjobKey() }][{/if}]"[{ if $oIdealo->getIdealoParam('dgIdealoDisableCronKey') }] readonly="readonly" disabled[{/if}] />
                [{ oxinputhelp ident="dgIdealoCronKey" }]
            </dt>
            <dd>
              Cronjob Passwort
            </dd>
            <div class="spacer"></div>
         </dl>  
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoDisableCronKey]" value="false" />
               <input id="dgIdealoDisableCronKey" type="checkbox" name="confbools[dgIdealoDisableCronKey]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoDisableCronKey') }]checked[{/if}] />
                [{ oxinputhelp ident="dgIdealoDisableCronKey" }]
            </dt>
            <dd>
               <label for="dgIdealoDisableCronKey">Cronjob Passwort deaktivieren?</label>
            </dd>
            <div class="spacer"></div>
         </dl>     
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='save';">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>


[{ if $oIdealo->getLocation() == "de"}]  


<form name="dgIdealoApi" id="dgIdealoApi" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoApi" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoApi" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Api Einstellungen</b></a>
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoOrderApi]" onchange="showPleaseWait();this.form.submit();">               
	      	     <option value="1" [{ if $oIdealo->getIdealoParam('dgIdealoOrderApi') == "1" }] selected[{/if}]>Merchant Order API v1 nutzen (Weiterentwicklung einestellt)</option>
                 <option value="2" [{ if $oIdealo->getIdealoParam('dgIdealoOrderApi') == "2" }] selected[{/if}]>Merchant Order API v2 nutzen</option>
               </select>
            </dt>
            <dd> <br /> </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getIdealoParam('dgIdealoOrderApi') == "1" || !$oIdealo->getIdealoParam('dgIdealoOrderApi') }]
         <dl>
            [{ if $oIdealo->getIdealoParam('dgIdealoMode') }]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoToken]" value="[{ $oIdealo->getIdealoParam('dgIdealoToken') }]" />
                [{ oxinputhelp ident="dgIdealoToken" }]
            </dt>
            [{else}]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoSandBoxToken]" value="[{ $oIdealo->getIdealoParam('dgIdealoSandBoxToken') }]" />
                [{ oxinputhelp ident="dgIdealoToken" }]
            </dt>
            [{/if}]
            <dd>
              [{$dgIdealoLabel}] Api Token-Hash
              [{ if $dgIdealoIsTokenCorrect }] <span style="color:green">&#10004;</span> [{ elseif !$dgIdealoIsTokenCorrect }] <span style="color:red">&#10007;</span> [{/if}]
              
               <a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=dgidealo_test&oxid=[{$oViewConf->getActiveShopId()}]&debug=1" target="_blank">&nbsp;&nbsp;</a>

            </dd>
            <div class="spacer"></div>
         </dl> 
         [{ elseif $oIdealo->getIdealoParam('dgIdealoOrderApi') == "2" }]
         <dl>
            [{ if $oIdealo->getIdealoParam('dgIdealoMode') }]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoClientID]" value="[{ $oIdealo->getIdealoParam('dgIdealoClientID') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            [{else}]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoSandBoxClientID]" value="[{ $oIdealo->getIdealoParam('dgIdealoSandBoxClientID') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            [{/if}]
            <dd>
              [{$dgIdealoLabel}] Client-ID
              [{ if $dgIdealoIsTokenCorrect }] <span style="color:green">&#10004;</span> [{ elseif !$dgIdealoIsTokenCorrect }] <span style="color:red">&#10007;</span> [{/if}]
              <a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=dgidealo_test&oxid=[{$oViewConf->getActiveShopId()}]&debug=1" target="_blank">&nbsp;&nbsp;</a>
            </dd>
            <div class="spacer"></div>
         </dl> 
          <dl>
            [{ if $oIdealo->getIdealoParam('dgIdealoMode') }]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoClientPw]" value="[{ $oIdealo->getIdealoParam('dgIdealoClientPw') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            [{else}]
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoSandBoxClientPw]" value="[{ $oIdealo->getIdealoParam('dgIdealoSandBoxClientPw') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            [{/if}]
            <dd>
              [{$dgIdealoLabel}] Client-Passwort
              [{ if $dgIdealoIsTokenCorrect }] <span style="color:green">&#10004;</span> [{ elseif !$dgIdealoIsTokenCorrect }] <span style="color:red">&#10007;</span> [{/if}]
            </dd>
            <div class="spacer"></div>
         </dl> 
         [{/if}]     
         <dl>
            <dt>
                <input id="dgIdealoModeTrue"  name="confbools[dgIdealoMode]" type="radio" value="true"  [{ if $oIdealo->getIdealoParam('dgIdealoMode') }]checked="checked"[{/if}] onchange="showPleaseWait();this.form.submit();" /> <label for="dgIdealoModeTrue">Live Betrieb</label>
                <input id="dgIdealoModeFalse" name="confbools[dgIdealoMode]" type="radio" value="false" [{ if !$oIdealo->getIdealoParam('dgIdealoMode') }]checked="checked"[{/if}] onchange="showPleaseWait();this.form.submit();" /> <label for="dgIdealoModeFalse">Sandbox Modus</label>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>        
          <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoShopId]" value="[{ $oIdealo->getIdealoParam('dgIdealoShopId') }]">
                [{ oxinputhelp ident="dgIdealoShopId" }]
            </dt>
            <dd>
              [{$dgIdealoLabel}] Shop-ID 
            </dd>
            <div class="spacer"></div>
         </dl>      
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>

<form name="dgIdealoOrder" id="dgIdealoOrder" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoOrder" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoOrder" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Einstellungen Bestellimport </b></a>
      <dl>
         <dt>
               <input type="hidden" name="confbools[dgIdealoUseIdealoCounter]" value="false" />
               <input id="dgIdealoUseIdealoCounter" type="checkbox" name="confbools[dgIdealoUseIdealoCounter]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoUseIdealoCounter') }]checked[{/if}] />
               [{ oxinputhelp ident="dgIdealoUseIdealoCounter" }]
            </dt>
            <dd>
               <label for="dgIdealoUseIdealoCounter">[{$dgIdealoLabel}] Bestellnummer als OXID Bestellnummer nutzen <small>( funktioniert nur wenn Ihre Bestenummerspalte varchar ist)</small></label>
            </dd>
            <div class="spacer"></div>
         </dl>
      <dl>
         <dt>
            Kunden der Kundengruppe 
            <select name="confstrs[dgIdealoUserGroup]" size="1">
              <option value="" style="color: #000000;">keine</option>
	          [{foreach from=$oView->getGroupList() item=groups}]
	          <option value="[{ $groups->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoUserGroup') == $groups->oxid }]SELECTED[{/if}]>[{ $groups->name }]</option>
	          [{/foreach}]
	        </select> zuordnen.
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl>  
      <dl>
         <dt>
            nach dem Import Bestellungen in Order 
            <select name="confstrs[dgIdealoOrderFolder]" size="1">
              <option value="" style="color: #000000;">alle</option>
              [{foreach from=$afolder key=field item=color}]
              <option value="[{ $field }]" [{ if $oIdealo->getIdealoParam('dgIdealoOrderFolder') == $field }]SELECTED[{/if}]>[{ oxmultilang ident=$field noerror=true }]</option>
              [{/foreach}]
	        </select> verschieben.
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <table>
          [{assign var="dgIdealoProviders" value=$oIdealo->getIdealoParam('dgIdealoProviders') }]
          [{foreach from=$oIdealoValues->getIdealoProviders() key=iIdealoId item=iIdealoName}]
          [{assign var="dgIdealoOrderCarrier" value="dgIdealoCarrier"|cat:$iIdealoId}]
          <tr>
            <td>Logistikdienstleister f&uuml;r [{$dgIdealoLabel}] [{$iIdealoName}] </td>
            <td>
              <select name="confstrs[[{$dgIdealoOrderCarrier}]]" size="1">
                <option value="">- bitte w&auml;hlen -</option>
                [{foreach from=$oIdealoValues->getIdealoCarriers() key=field item=color}]
                  <option value="[{ $field }]" [{ if $oIdealo->getIdealoParam($dgIdealoOrderCarrier) == $field || ( !$oIdealo->getIdealoParam($dgIdealoOrderCarrier) && $oIdealo->getIdealoParam('dgIdealoOrderCarrier') == $field ) }]SELECTED[{/if}]>[{ $color }]</option>
                [{/foreach}]
	          </select> verwenden
            </td>
          </tr>
          [{/foreach}]
          </table>
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            Bestellbemerkung ([{$dgIdealoLabel}] Bestellnummer)
            <select name="confstrs[dgIdealoRemark]" size="1">
              <option value="1" [{ if $oIdealo->getIdealoParam('dgIdealoRemark') == "1" || !$oIdealo->getIdealoParam('dgIdealoRemark') }]SELECTED[{/if}]>nicht eintragen</option>
              <option value="2" [{ if $oIdealo->getIdealoParam('dgIdealoRemark') == "2" }]SELECTED[{/if}]>eintragen</option>
	        </select>     
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            [{$dgIdealoLabel}] Bestellnummer eintragen
            <select name="confstrs[dgIdealoSaveOrderIdIn]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorder') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper }]
              [{ if ( !preg_match( "/id/", $desc|lower  ) && !preg_match( "/price/", $desc|lower ) && !preg_match( "/vat/", $desc|lower ) && !preg_match( "/cost/", $desc|lower ) && !preg_match( "/sum/", $desc|lower ) ) || $desc|lower == "idealo_order_number" }]
                 <option value="[{ $desc|oxlower }]" [{ if $oIdealo->getIdealoParam('dgIdealoSaveOrderIdIn')|oxlower == $desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower }]</option>
              [{/if}]
              [{/foreach}]
             </select>      
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      [{ if $oIdealo->getIdealoParam( 'dgIdealoOrderApi' ) == "2" }]
         <dl>
            <dt>
               <select size="1" name="confstrs[dgIdealoOrderCatchSystem]">
                 <option value="">- bitte w&auml;hlen -</option>
                 <option value="time" [{ if $oIdealo->getIdealoParam('dgIdealoOrderCatchSystem') == "time" }] selected[{/if}]>Bestellungen abholen nach Zeitraum</option>
                 <option value="new"  [{ if $oIdealo->getIdealoParam('dgIdealoOrderCatchSystem') == "new"  }] selected[{/if}]> nur neue Bestellungen abholen (standard)</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         [{ if $oIdealo->getIdealoParam('dgIdealoOrderCatchSystem') == "time" }]
         <dl>
            <dt>
               <input type="text" size="5" name="confstrs[dgIdealoSoapMaxSize]" value="[{$oIdealo->getIdealoParam('dgIdealoSoapMaxSize')}]" /> 
            </dt>
            <dd> Anzahl der abzuholenden Bestellungen ( max. 1000 )</dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoAcknowledged]" value="false" />
               <input id="dgIdealoAcknowledged" type="checkbox" name="confbools[dgIdealoAcknowledged]" value="true" [{if $oIdealo->getIdealoParam('dgIdealoAcknowledged') }]checked[{/if}]>
            </dt>
            <dd> <label for="dgIdealoAcknowledged">bereits abgeholte Bestellungen erneut abholen </label></dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>              
               <input type="text" size="22" name="confstrs[dgIdealoLastReportDate]" value="[{$oIdealo->getIdealoParam('dgIdealoLastReportDate')}]" /> 
            </dt>
            <dd>( yyyy-mm-dd hh:mm:ss ) letztes Bestellberichtdatum</dd>
            <div class="spacer"></div>
         </dl>
          <dl>
            <dt>              
               <select name="confstrs[dgIdealoReportAddTime]">
               [{section loop=49 name="desc"}]
               [{ if $smarty.section.desc.index > 2}]
                  [{assign var="time" value=$smarty.section.desc.index*3600 }]
				  <option value="[{ $time }]" [{ if $oIdealo->getIdealoParam('dgIdealoReportAddTime') == $time }]SELECTED[{/if}]>[{ $smarty.section.desc.index  }] Std.</option>
                  [{/if}]
                [{/section}]
               </select> Zeitspanne f&uuml;r die Abholung der Bestellungen
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>              
               <select name="confstrs[dgIdealoReportType]">           
				  <option value="all" [{ if $oIdealo->getIdealoParam('dgIdealoReportType') == 'all' }]SELECTED[{/if}]>alle Bestellungen abholen</option>
                  <option value="PROCESSING" [{ if $oIdealo->getIdealoParam('dgIdealoReportType') == 'PROCESSING' }]SELECTED[{/if}]>alle Bestellungen mit dem Status - Neu/in Bearbeitung - abholen</option>
                  <option value="COMPLETED" [{ if $oIdealo->getIdealoParam('dgIdealoReportType') == 'COMPLETED' }]SELECTED[{/if}]>alle Bestellungen mit dem Status - Erledigt - abholen</option>
                  <option value="REVOKED" [{ if $oIdealo->getIdealoParam('dgIdealoReportType') == 'REVOKED' }]SELECTED[{/if}]>alle Bestellungen mit dem Status - widerrufen - abholen</option>
                  <option value="PARTIALLY_REVOKED" [{ if $oIdealo->getIdealoParam('dgIdealoReportType') == 'PARTIALLY_REVOKED' }]SELECTED[{/if}]>alle Bestellungen mit dem Status - Teilweise widerrufen - abholen</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         [{/if}]
      [{/if}]
      <dl>
            <dt>              
               <select name="confstrs[dgIdealoAdressLine2]">           
				  <option value="ADDINFO" [{ if $oIdealo->getIdealoParam('dgIdealoAdressLine2') == 'ADDINFO' }]SELECTED[{/if}]>Idealo Adresszeile 2 als zus&auml;tzliche Adressinfo speicherm</option>
                  <option value="COMPANY" [{ if $oIdealo->getIdealoParam('dgIdealoAdressLine2') == 'COMPANY' }]SELECTED[{/if}]>Idealo Adresszeile 2 als Firma speichern</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
      <dl>
        <dt>
          <br/>
          <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>



<form name="dgIdealoProviders" id="dgIdealoProviders" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoProviders" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoProviders" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Bestellungen Versandkostensets </b></a>
       [{assign var="dgIdealoProviders" value=$oIdealo->getIdealoParam('dgIdealoProviders') }]
       [{foreach from=$oIdealoValues->getIdealoProviders() key=iIdealoId item=iIdealoPayArt}]
       <dl>
        <dt>         
            [{$dgIdealoLabel}] [{$iIdealoPayArt}] in OXID als <select name="confarrs[dgIdealoProviders][[{ $iIdealoId }]]" size="1">
            [{foreach from=$oView->getDeliveryList() item=iPayArt}]
            <option value="[{ $iPayArt->oxid }]" [{ if $dgIdealoProviders.$iIdealoId == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
            [{/foreach}]
	      </select> nutzen
        </dt>
        <dd>  </dd>
        <div class="spacer"></div>
      </dl>
      [{/foreach}]
      <dl>
        <dt>
          <br/>
          <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>

<form name="dgIdealoPayment" id="dgIdealoPayment" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoPayment" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]">
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoPayment" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Bestellungen Zahlungsarten </b></a>
       [{assign var="dgIdealoPayment" value=$oIdealo->getIdealoParam('dgIdealoPayment') }]
       [{foreach from=$oIdealoValues->getIdealoPayments() key=iIdealoId item=iIdealoPayArt}]
       <dl>
        <dt>         
            [{$dgIdealoLabel}] [{$iIdealoPayArt}] in OXID als <select name="confarrs[dgIdealoPayment][[{ $iIdealoId }]]" size="1">
            [{foreach from=$oView->getPaymentList() item=iPayArt}]
            <option value="[{ $iPayArt->oxid }]" [{ if $dgIdealoPayment.$iIdealoId == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
            [{/foreach}]
	      </select> nutzen
        </dt>
        <dd>  </dd>
        <div class="spacer"></div>
      </dl>
      [{/foreach}]
      <dl>
        <dt>
          <br/>
          <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>
[{/if}]

<form name="dgIdealoTracking" id="dgIdealoTracking" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoTracking" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoTracking" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Einstellungen Versandmeldungen </b></a>
        <dl>
            <dt>              
               <select name="confstrs[dgIdealoTrackingSystem]">           
				  <option value="order" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingSystem') == 'order' }]SELECTED[{/if}]>Versandmeldung pro Bestellung</option>
                  <option value="article" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingSystem') == 'article' }]SELECTED[{/if}]>Versandmeldung &uuml;ber Artikel</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
        </dl>
        [{ if $oIdealo->getIdealoParam('dgIdealoTrackingSystem') == 'order' }]
        <dl>
           <dt>  </dt>
           <dd>
             <small>bitte Komma - Trennung, bei mehr als einer Trackingnummer</small>
           </dd>
           <div class="spacer"></div>
        </dl> 
        [{/if}]
        [{ if $oIdealo->getIdealoParam('dgIdealoTrackingSystem') == 'article' }]
      <dl>
         <dt>
            <select name="confstrs[dgIdealoTrackingCodeField]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|oxlower }]" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingCodeField')|oxlower == $desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower }]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgIdealoLabel}] <b>Trackingnummer</b> genutzt werden ?
         </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <select name="confstrs[dgIdealoTrackingSendDate]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|oxlower }]" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingSendDate')|oxlower == $desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower }]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgIdealoLabel}] <b>Versanddatum</b> genutzt werden ? ( 0000-00-00 00:00:00 )
         </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <select name="confstrs[dgIdealoTrackingProvider]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper }]
                 <option value="[{ $desc|oxlower }]" [{ if $oIdealo->getIdealoParam('dgIdealoTrackingProvider')|oxlower == $desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower }]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgIdealoLabel}] <b>Logistikdienstleister </b> genutzt werden ?
         </dd>
         <div class="spacer"></div>
      </dl>
      
      [{/if}]
      <dl>
        <dt>
          <br/>
          <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>

<form name="dgIdealoControlling" id="dgIdealoControlling" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgIdealoControlling" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div class="groupExp">
   <div[{ if $aStep == "dgIdealoControlling" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Controlling Einstellungen</b></a>
         <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoTracking]" value="[{$oIdealo->getIdealoParam('dgIdealoTracking')}]" [{ $readonly}]>
                [{ oxinputhelp ident="dgIdealoTracking" }]
            </dt>
            <dd>
              Tracking Parameter
            </dd>
            <div class="spacer"></div>
         </dl> 
         [{ if !$oView->is2Allow() }]  
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoPerformaceTracking]" value="false" />
               <input id="dgIdealoPerformaceTracking" type="checkbox" name="confbools[dgIdealoPerformaceTracking]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoPerformaceTracking') }]checked[{/if}] />
               [{ oxinputhelp ident="dgIdealoPerformaceTracking" }]
            </dt>
            <dd>
               <label for="dgIdealoPerformaceTracking">[{$dgIdealoLabel}] Performance Tracking aktivieren</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input class="editinput" size="12" type="text" name="confstrs[dgIdealoPerformaceTrackingId]" value="[{$oIdealo->getIdealoParam('dgIdealoPerformaceTrackingId')}]" [{ $readonly}]>
               [{ oxinputhelp ident="dgIdealoPerformaceTracking" }]
            </dt>
            <dd>
               <label for="dgIdealoPerformaceTrackingId">[{$dgIdealoLabel}] Performance Tracking-ID</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         [{/if}]    
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>

<div class="groupExp">
   <div [{ if $aStep == "automaticstatus" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Automatisierung Artikelexport [{ if $oIdealo->getLocation() == "de"}]&amp; Bestellungen[{/if}]</b></a>
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
            [{ if $oIdealo->getLocation() == "de"}]
            <tr>
              <td valign="top">
                Conjoburl [{ if $oIdealo->getLocation() == "de"}]Bestellung &amp;[{/if}] Artikelexport:<br />
                <small>alle 10 Minuten</small>
                </td>
              <td>
                 <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;location=[{$oIdealo->getLocation()}]" target="_blank">[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $editlanguage }]&amp;location=[{$oIdealo->getLocation()}]</a><br />
              </td>
            </tr>
            [{/if}]
            <tr>
              <td valign="top">
                Conjoburl f&uuml;r den Artikelexport:<br />
                [{ if $oIdealo->getLocation() == "de"}]<small>nur f&uuml;r Testzwecke</small>[{/if}]
              </td>
              <td valign="top">
                  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=article&amp;location=[{$oIdealo->getLocation()}]" target="_blank">[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $editlanguage }]&amp;action=article&amp;location=[{$oIdealo->getLocation()}]</a><br />
                </td>
            </tr>
            <tr>
              <td colspan="2">
                <br /><br />
                <small>Sollten Sie selbst keine Cronjobs einrichten k&ouml;nnen, verwenden Sie Dienste wie z.B.: cronjob.de</small>
              </td>
            </tr>
          </table>
           </dt>
           <dd> </dd>
           <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
                 <form action="[{ $oViewConf->getSelfLink() }]" method="post" onsubmit="showPleaseWait()">
                  <input type="hidden" name="fnc" value="" />
                  <input type="hidden" name="aStep" value="automaticstatus" />
                  <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
                  <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                  <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
                  [{ $oViewConf->getHiddenSid() }]
                  <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Zeitstempel der Cronjobs</b></legend>
				  <ul>
				     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronArticlesHtml') }][{$oIdealo->getIdealoParam('dgIdealoCronArticlesHtml')}][{else}]0000.00.00 00:00:00[{/if}] -  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=article&amp;location=[{$oIdealo->getLocation()}]" target="_blank">Artikel erstellen</a></li>
                     [{ if $oIdealo->getLocation() == "de"}]
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronOrderHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronOrderHtml')}][{else}]0000.00.00 00:00:00[{/if}] -  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=order&amp;location=[{$oIdealo->getLocation()}]" target="_blank">Bestellungen</a></li>
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronTrackingHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronTrackingHtml')}][{else}]0000.00.00 00:00:00[{/if}] -  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=tracking&amp;location=[{$oIdealo->getLocation()}]" target="_blank">Versandmeldungen</a></li>
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronOrderNrHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronOrderNrHtml')}][{else}]0000.00.00 00:00:00[{/if}] -  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=ordernr&amp;location=[{$oIdealo->getLocation()}]" target="_blank">Bestellnummer &uuml;bertragen</a></li>
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronStornoNrHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronStornoNrHtml')}][{else}]0000.00.00 00:00:00[{/if}] -  <a href="[{$cronurl}]index.php?cl=dgidealo_cronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;action=storno&amp;location=[{$oIdealo->getLocation()}]" target="_blank">Stornierungen</a></li>
                     [{/if}]
				  </ul>
				  <br />
				  <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">aktualisieren</button>
                  </fieldset>
                  </form>
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

<div class="groupExp">
  <div [{ if $aStep == "dgsetup" }] class="exp"[{/if}]>
    <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Datenbank Kontrolle</b></a>
      <dl>
        <dd>
           <form action="[{ $oViewConf->getSelfLink() }]" method="post" enctype="multipart/form-data">
           <input type="hidden" name="fnc" value="inserttable" />
      	   <input type="hidden" name="aStep" value="dgsetup" />
      	   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      	   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId()}]" />
           <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
           [{ $oViewConf->getHiddenSid() }] 
		    <button type="submit" name="save" onclick="showPleaseWait();">Daten Kontrolle</button>
		   </form>
          [{$answer}]
		</dd>
        <div class="spacer"></div>
      </dl>
  </div>
</div>


    

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
