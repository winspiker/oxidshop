<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>                            
  <title>draufgeschaut.de, Update Tool</title>
  <meta http-equiv="Content-Type" content="text/html; charset=[{$charset}]">
  [{if isset($meta_refresh_sec,$meta_refresh_url)}]    
  <meta http-equiv="Refresh" content="[{$meta_refresh_sec}];URL=[{$oViewConf->getSelfLink()}][{$dgUrlSeparator}]cl=[{$oViewConf->getTopActiveClassName()}]&sid=[{$oViewConf->getSessionId()}][{$meta_refresh_url}]">
  [{/if}]
  <link rel="shortcut icon" href="[{$oViewConf->getBaseDir()}]favicon.ico">
  <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]main.css">
  <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]colors.css">
  [{include file="tooltips.tpl"}]

  <link rel="stylesheet" type="text/css" href="[{$oViewConf->getResourceUrl()}]yui/build/assets/skins/sam/container.css">
  <script type="text/javascript" src="[{$oViewConf->getResourceUrl()}]yui/build/utilities/utilities.js"></script>
  <script type="text/javascript" src="[{$oViewConf->getResourceUrl()}]yui/build/container/container-min.js"></script>
  <script type="text/javascript" src="[{$oViewConf->getResourceUrl()}]yui/oxid-help.js"></script>
</head>
<body>
<div id="oxajax_data"></div>

<div class="[{$box|default:'box'}]">
[{include file="inc_error.tpl" Errorlist=$Errors.default}]

<!-- Input help popup -->
<div id="helpTextContainer" class="yui-skin-sam">
    <div id="helpPanel"></div>
</div>

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

[{if isset($meta_refresh_sec,$meta_refresh_url)}]
window.onbeforeunload = function(){ showPleaseWait(); }
[{/if}] 

 
function Ticker()
{
    oldText = document.getElementById('count');
    
    if(oldText)
    {
       document.getElementById('count').innerHTML = oldText.innerHTML + '.';
       window.setTimeout ( 'Ticker()' ,150);
    } 
}
      
window.setTimeout ( 'Ticker()' ,100);  

function sendMessage()
{
    document.myedit1.fnc.value='';
    document.myedit1.aStep.value='3';
    document.myedit1.submit();
    showPleaseWait();
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

.dg { width: 24px;
      height: 24px;
      border: 1px solid #363431;
      padding: 1px 1px 1px 1px;
      background-color: #D1D2D2
}

.greenbox{
    width: 6px;
    height: 6px;
    border: 1px solid #808080;
    background-color: #008000;
    float: left;
    margin: 4px 8px 4px 0px;
}

.redbox{
    width: 6px;
    height: 6px;
    border: 1px solid #808080;
    background-color: #C23410;
    float: left;
    margin: 4px 8px 4px 0px;
}

div#pleasewaiting{
   background: url('[{$oViewConf->getModuleUrl('dgotto','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
   z-index: 50;
   position: absolute;
   top: 0px;
   left: 0px;
   width: 100%;
   height: 100%;
   background-color: rgb(255, 255, 255);
   opacity: 0.5;
   visibility: hidden; 
}

.dglight { 
    color: #C23410; 
    border: 1px solid #888888; 
    padding: 2px 2px 2px 2px; 
    background-color: #FFFFFF;
    text-indent: 4px; 
}

.groupExp div{margin-bottom:10px;}
.groupExp dt{font-weight:normal}

-->
</style>
[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{cycle assign="_clear_" values=",2"}]

    <form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
      [{$oViewConf->getHiddenSid()}]
      <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
      <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]" />
      <input type="hidden" name="updatenav" value="" />
      <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
    </form>
    
	<div onclick="hidePleaseWait()" id="pleasewaiting"></div>

    [{if $aStep == 1 || !$aStep}]
     <div class="groupExp">
        <div class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Versionsdaten</b></a>
             <dl>
                <dt>
                   <form id="myedit1" name="myedit1" action="[{$oViewConf->getSelfLink()}]" method="post">
                   [{$oViewConf->getHiddenSid()}]
                   <input type="hidden" name="fnc" value="[{$sUpdateStep}]" />
                   <input type="hidden" name="aStep" value="2" />
                   <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
                   <input type="hidden" name="oxid" value="[{$oxid}]" />
                   [{$oViewConf->getHiddenSid()}]
                   
                   Ihr Modul &quot;[{$oUpdate->getModulName()}]&quot; hat die Version [{$oObject->getVersion()}], die aktuellste Version ist <span class="dglight">&nbsp;[{$oUpdate->sVersion}]&nbsp;</span>
                   [{if $oObject->getVersion() == $oUpdate->sVersion}]
                   <br />Es ist kein Update erfolderlich, Ihre Version ist die aktuellste Modulversion.
                   [{else}]
                    <br />Es ist Update erfolderlich, Ihre Version ist die nicht aktuellste Modulversion.
                   [{/if}]
                   <br /><br /><b>[{$oUpdate->getServiceTime()}]</b>
                   
                   <br /><br />
                   [{if $oUpdate->hasUpdate && $oUpdate->getUpdateAllow()}]
                   <div>
                     Bitte beachten Sie das die Update Version sich nur vollst&auml;ndig installieren l&auml;&szlig;t wenn die Grundinstallation OXID konform ist.<br />
                     Problemquellen sind hierbei:<br />
                   </div>
                   <div>
                     <ol>
                       <li>Verzeichnissrechte</li>
                       <li>Schreibrechte</li>
                       <li>Benutzerrechte</li>
                       <li>Anpassungen am Modul</li>
                     </ol>
                   </div>
                   <br />
                   <a href="#" onclick="sendMessage();"><u>Wenn Sie sich nicht sicher sind k&ouml;nnen auch das Update hier beauftragen</u></a>  
                   
                   <br /><br />
                   [{if $oUpdate->isComposerVersion()}]
                      <h4>Zur Update Installation &uuml;ber den Composer f&uuml;hren Sie folgenden Befehl aus:
                      <br /><br/>composer clearcache<br />
                      php composer require draufgeschaut/[{$oUpdate->getModul()}]<br /></h4><br />
                      <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">Installation Dateien aktualisieren</button>
                      
                      
                      [{if $oUpdate->getOxVersion()|replace:".":"" >= 622}]
                      <br />
                      <h4>Nach der Installation f&uuml;hren Sie &uuml;ber den Composer Sie folgenden Befehle aus:
                      <br /><br />composer clearcache<br />
                      [{$oUpdate->getComposerPhpPath()}]vendor/bin/oe-console oe:module:install-configuration source/modules/[{$oUpdate->getModul()}]<br />
                      <br />
                      [{/if}]
                      
                   [{else}]
                      <button  onclick="showPleaseWait();">Update ausf&uuml;hren</button>
                      
                   [{/if}]
                  [{/if}]

                    <br /><br /> <br /><br />
                    <br />
                   <br />Sie m&ouml;chten die PHP Version wechseln? 
                   <br />Dann laden Sie unseren Modul Connector von <a href="https://www.volker-doerk.de/modul-connector-fuer-oxid-eshop-ce-pe-ee.html" target="blank"><u>volker-doerk.de</u></a>, dieser unterst&uuml;tzt Sie dann bei der Neuinstallation.
                   [{if $oUpdate->hasUpdate && $oUpdate->getUpdateAllow()}]
                   <br /><br />Alternativ k&ouml;nnen Sie zur Installation die <a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&fnc=getRemoteFile2Download&oxid=[{$oObject->getShopId()}]"><u>&quot;Datei [{$oUpdate->getModulName()}] Version [{$oUpdate->sVersion}]&quot;</u></a> in der PHP Version [{$oUpdate->getPHPVersion()}] f&uuml;r die OXID Version [{$oUpdate->getOxVersion()}] auch downloaden.
                   [{/if}]
                   </form>
                </dt>
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
        </div>
    </div>
    [{/if}]
    
    [{if $aStep == 3 }]
    <div class="groupExp">   
        <div class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Dienstleistungsauftrag [{$send}]</b></a>
            <dl>
          [{if !$send}]
          <form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
        <input type="hidden" name="fnc" value="debugmail" />
        <input type="hidden" name="aStep" value="3" />
        <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
           <table width="100%" class="form">
        <tr>
          <td><label>Vorname&nbsp;&nbsp;</label></td>
          <td><input type="text" name="editval[oxfname]" size="70" maxlength="40" value="[{$actshopobj->oxshops__oxfname->value}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Nachname&nbsp;&nbsp;</label></td>
          <td><input type="text" name="editval[oxlname]" size="70" maxlength="40" value="[{$actshopobj->oxshops__oxlname->value}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Email&nbsp;&nbsp;</label></td>
          <td><input id="test_contactEmail" type="text" name="editval[oxusername]"  size="70" maxlength="40" value="[{$actshopobj->oxshops__oxinfoemail->value}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Subject&nbsp;&nbsp;</label></td>
          <td><input type="text" name="c_subject" size="70" maxlength="280" value="[{$oViewConf->getBaseDir()|basename}], Update [{$oObject->getVersion()}] zu [{$oUpdate->getModulName()}] Modul [{$oUpdate->sVersion}]" />&nbsp;<span class="req">*</span></td>
        </tr>
        <tr>
          <td><label>Nachricht&nbsp;&nbsp;</label></td>
          <td><textarea rows="8" cols="70" name="c_message">Ihre Nachricht:</textarea></td>
        </tr>
        <tr>
          <td></td>
          <td><br />
            <span class="btn"><button type="submit" class="btn">senden</button></span>
          </td>
        </tr>
      </table>
      </form>
      [{else}][{$send}][{/if}]  
      </dd>

                <div class="spacer"></div>
             </dl>
         </div>
    </div>
    [{/if}]
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]