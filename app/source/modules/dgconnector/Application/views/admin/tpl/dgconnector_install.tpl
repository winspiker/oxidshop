<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>                            
  <title>draufgeschat, Update Tool</title>
  <meta http-equiv="Content-Type" content="text/html; charset=[{$charset}]">
  [{if isset($meta_refresh_sec,$meta_refresh_url) }]    
  <meta http-equiv="Refresh" content="[{$meta_refresh_sec}];URL=[{ $oViewConf->getSelfLink() }][{$dgUrlSeparator}]cl=[{ $oViewConf->getTopActiveClassName() }]&dgmodul=[{$oUpdate->getModul()}]&sid=[{ $oViewConf->getSessionId() }][{$meta_refresh_url}]&dgmodulname=">
  [{/if}]
  <link rel="shortcut icon" href="[{ $oViewConf->getBaseDir() }]favicon.ico">
  <link rel="stylesheet" href="[{ $oViewConf->getResourceUrl() }]main.css">
  <link rel="stylesheet" href="[{ $oViewConf->getResourceUrl() }]colors.css">
  [{include file="tooltips.tpl"}]
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

[{if isset($meta_refresh_sec,$meta_refresh_url) }]
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
   background: url('[{ $oViewConf->getModuleUrl('dgconnector','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
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
      <input type="hidden" name="oxid" value="[{ $shopid }]" />
      <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
      <input type="hidden" name="actshop" value="[{ $shopid }]" />
      <input type="hidden" name="updatenav" value="" />
      <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
    </form>
    
	<div onclick="hidePleaseWait()" id="pleasewaiting"></div>
    
    [{if !isset($meta_refresh_sec,$meta_refresh_url) && !$sUpdateStep }]
    <div class="groupExp">
        <div class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Installation erfolgreich</b></a>
             <dl>
                <dt>
                  <h2>Installation erfolgreich, Sie k&ouml;nnen das Modul nun nutzen</h2><br />
                  <form id="myedit1" name="myedit1" action="[{ $oViewConf->getSelfLink() }]" method="post">
                   [{ $oViewConf->getHiddenSid() }]
                   <input type="hidden" name="fnc" value="" />
                   <input type="hidden" name="aStep" value="2" />
                   <input type="hidden" name="cl" value="dgconnector_main" />
                   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                   [{ $oViewConf->getHiddenSid() }]
                       <button type="submit" class="edittext" name="save">zur&uuml;ck zur &Uuml;bersicht</button>
                   </form>
                </dt>
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
        </div>
    </div>
    [{else}]
    
      [{ if $oUpdate->isComposerVersion() }]
        <div class="groupExp">
          <div class="exp">
              <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Installation ausf&uuml;hren</b></a>
               <dl>
                  <dt>
                    [{if isset($meta_refresh_sec,$meta_refresh_url)}]
                      <h2>[{ if $meta_refresh_message }][{$meta_refresh_message}][{else}]... Installation wird ausgef&uuml;hrt![{/if}]</h2>
                    [{else}]
                     <form id="myedit1" name="myedit1" action="[{ $oViewConf->getSelfLink() }]" method="post">
                     [{ $oViewConf->getHiddenSid() }]
                     <input type="hidden" name="fnc" value="[{ $sUpdateStep }]" />
                     <input type="hidden" name="aStep" value="3" />
                     <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
                     <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                     <input type="hidden" name="dgmodul" value="[{ $oUpdate->getModul() }]" />
                     <input type="hidden" name="dgmodulname" value="[{ $oUpdate->getModulName() }]" />
                     [{ $oViewConf->getHiddenSid() }]
 
                    <h2>[{$oUpdate->getModulName()}]</h2>
                    <h4>Zur Installation &uuml;ber den Composer f&uuml;hren Sie folgenden Befehl aus:
                    <br /><br/>composer clearcache<br />
                      composer require draufgeschaut/[{ $oUpdate->getModul() }]</h4><br />

                    <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">Installation Dateien aktualisieren</button>
                   </form>
                  [{/if}]
                </dt>
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
          </div>
        </div>
      [{else}]
     <div class="groupExp">
        <div class="exp">
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Installation ausf&uuml;hren</b></a>
             <dl>
                <dt>
                  [{if isset($meta_refresh_sec,$meta_refresh_url)}]
                    <h2>[{ if $meta_refresh_message }][{$meta_refresh_message}][{else}]... Installation wird ausgef&uuml;hrt![{/if}]</h2>
                  [{else}]
                   <form id="myedit1" name="myedit1" action="[{ $oViewConf->getSelfLink() }]" method="post">
                   [{ $oViewConf->getHiddenSid() }]
                   <input type="hidden" name="fnc" value="[{ $sUpdateStep }]" />
                   <input type="hidden" name="aStep" value="3" />
                   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
                   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                   <input type="hidden" name="dgmodul" value="[{ $oUpdate->getModul() }]" />
                   <input type="hidden" name="dgmodulname" value="[{ $oUpdate->getModulName() }]" />
                   [{ $oViewConf->getHiddenSid() }]

                  <h2>[{$oUpdate->getModulName()}]</h2><br />

                    <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">Installation ausf&uuml;hren</button>
                   </form>
                  [{/if}]
                </dt>
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
        </div>
    </div>
      [{/if}]
    [{/if}]

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]