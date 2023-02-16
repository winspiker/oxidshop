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
     F&uuml;r den [{$dgIdealoLabel}] Partner Web Service ben&ouml;tigen Sie zus&auml;tzliche Zugangsdaten.<br />
     Beantragen k&ouml;nnen Sie den Zugang bei <a href="mailto:tam@idealo.de?subject=[{$oView->getMailContentSubject()}]&body=[{$oView->getMailContentBody()}]">tam@idealo.de</a>.
 </p>
</div>

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
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Grundeinstellung zu [{$dgIdealoLabel}] Partner Web Service</b></a>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoPwsActiv]" value="false" />
               <input id="dgIdealoPwsActiv" type="checkbox" name="confbools[dgIdealoPwsActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoPwsActiv') }]checked[{/if}] />
                [{ oxinputhelp ident="DGIDEALO_ACTIV_HELP" }]
            </dt>
            <dd>
               <label for="dgIdealoPwsActiv">Partner Web Service Schnittstelle aktivieren?</label>
            </dd>
            <div class="spacer"></div>
         </dl> 
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoPwsCronjobActiv]" value="false" />
               <input id="dgIdealoPwsCronjobActiv" type="checkbox" name="confbools[dgIdealoPwsCronjobActiv]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoPwsCronjobActiv') }]checked[{/if}] />
            </dt>
            <dd>
              <label for="dgIdealoPwsCronjobActiv"> Artikelexport automatisiert durch Modulcronjob an [{$dgIdealoLabel}] erstellen</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <input type="hidden" name="confbools[dgIdealoPwsShowArticle]" value="false" />
               <input id="dgIdealoPwsShowArticle" type="checkbox" name="confbools[dgIdealoPwsShowArticle]" value="true" [{ if $oIdealo->getIdealoParam('dgIdealoPwsShowArticle') }]checked[{/if}] />
               [{ oxinputhelp ident="dgIdealoPwsShowArticle" }]
            </dt>
            <dd>
               <label for="dgIdealoPwsShowArticle">[{$dgIdealoLabel}] Partner Web Service auf dem Idealo Artikelreiter anzeigen</label>
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoCronKey]" value="[{ $oIdealo->getCronjobKey() }]">
                [{ oxinputhelp ident="dgIdealoCronKey" }]
            </dt>
            <dd>
              Cronjob Passwort
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
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Api Einstellungen [{$dgIdealoLabel}] Partner Web Service</b></a>
         <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoPwsClientID]" value="[{ $oIdealo->getIdealoParam('dgIdealoPwsClientID') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            <dd>
              [{$dgIdealoLabel}] Partner Web Service Client-ID
              [{ if $dgIdealoIsPwsTokenCorrect }] <span style="color:green">&#10004;</span> [{ elseif !$dgIdealoIsPwsTokenCorrect }] <span style="color:red">&#10007;</span> [{/if}]
            </dd>
            <div class="spacer"></div>
         </dl> 
          <dl>
            <dt>
                <input class="editinput" size="50" type="text" name="confstrs[dgIdealoPwsClientPw]" value="[{ $oIdealo->getIdealoParam('dgIdealoPwsClientPw') }]">
                [{ oxinputhelp ident="dgIdealoToken2" }]
            </dt>
            <dd>
              [{$dgIdealoLabel}] Partner Web Service Client-Passwort
              [{ if $dgIdealoIsPwsTokenCorrect }] <span style="color:green">&#10004;</span> [{ elseif !$dgIdealoIsPwsTokenCorrect }] <span style="color:red">&#10007;</span> [{/if}]
            </dd>
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

[{if $oIdealo->getIdealoParam('dgIdealoPwsActiv') && $oIdealo->getIdealoParam( "dgIdealoIsPwsTokenCorrect" ) }]
<div class="groupExp">
   <div[{ if $aStep == 1 || !$aStep }] class="exp"[{/if}]>
       <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Export manuell durchf&uuml;hren</b></a>
          <dl>
             <dd>
                <fieldset style="padding: 10px; width: 600px;">
                 <legend><b>Export durchf&uuml;hren</b></legend>
                 <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" target="dynexport_do" method="post">
                 [{ $oViewConf->getHiddenSid() }]
                 <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
                 <input type="hidden" name="fnc" value="dgstart" />
                 <input type="hidden" name="shp" value="[{ $oIdealo->getShopId() }]" />
                 <input type="hidden" name="iPlace" value="[{ $oIdealo->getLocation() }]" />
                 <input type="hidden" name="pass" value="[{$oIdealo->getCronjobKey()}]" />
                 Bitte Kategorien w&auml;hlen oder keine<br />
                 <select name="acat[]" size="10" class="editinput" style="width: 210px;" multiple="multiple">
                  [{foreach from=$cattree item=oCat}]
                  <option value="[{ $oCat->getId() }]">[{ $oCat->oxcategories__oxtitle->value }]</option>
                  [{/foreach}]
                </select>
                <br /><br />
                <input type="hidden" name="useWaiting" value="0" />
                <input type="checkbox" name="useWaiting" value="1" /> nur die Warteschleife exportieren
                
                <br />
                <br />
                <button onclick="this.form.target='dynexport_do'" type="submit" class="edittext" style="width: 210px;" name="save">[{ oxmultilang ident="GENERAL_ESTART" }]</button>
                <br />
                <button onclick="this.form.target='_blank'" type="submit" class="edittext" style="width: 210px;" name="save">neues Fenster</button>
                </form>
                </fieldset>
                <br />
                <fieldset style="padding: 10px; width: 600px;">
                <legend><b>Exportstatus</b></legend>
                <iframe name="dynexport_do" marginwidth="0" marginheight="0" height="30" width="590" style="border: 1px solid #FFFFFF" src="[{ $oViewConf->getSelfLink() }]&cl=dgidealo_pwsdo&sid=[{$oViewConf->getSessionId()}]" scrolling="no"></iframe>
                </fieldset>
			 </dd>
            <div class="spacer"></div>
        </dl>
    </div>
</div>

<div class="groupExp">
   <div [{ if $aStep == "automaticstatus" }] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Automatisierung Artikelexport </b></a>
        <dl>
          <dt>
          <table>
            <tr>
              <td valign="top">
                Conjoburl :            
                </td>
              <td>
                 <a href="[{$cronurl}]index.php?cl=dgidealo_pwscronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $oIdealo->getIdealoParam('dgIdealoLang') }]&amp;location=[{$oIdealo->getLocation()}]" target="_blank">[{$cronurl}]index.php?cl=dgidealo_pwscronjob&amp;pass=[{$oIdealo->getCronjobKey()}]&amp;shp=[{ $oViewConf->getActiveShopId() }]&amp;lang=[{ $editlanguage }]&amp;location=[{$oIdealo->getLocation()}]</a><br />
              </td>
            </tr>
                     <tr>
              <td colspan="2">
                <br /><br />
                <small>( alle 1 - 3 Minuten )</small><br />
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
				     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronControllHtml') }][{$oIdealo->getIdealoParam('dgIdealoCronControllHtml')}][{else}]0000.00.00 00:00:00[{/if}] - Artikelkontrolle</li>
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronSendArticleHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronSendArticleHtml')}][{else}]0000.00.00 00:00:00[{/if}] - Artikel senden</li>
                     <li>[{if $oIdealo->getIdealoParam('dgIdealoCronDeleteArticleHtml')}][{$oIdealo->getIdealoParam('dgIdealoCronDeleteArticleHtml')}][{else}]0000.00.00 00:00:00[{/if}] - Artikel l&ouml;schen</li>
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

[{/if}]


[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
