[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]

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

//-->
</script>
<style>
<!--

.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
} 
 
.dg { width: 24px;
      height: 24px;
      border: 1px solid #363431;
      padding: 1px 1px 1px 1px;
      background-color: #D1D2D2
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

div dt {
    font-weight:normal;
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
    <input type="hidden" name="oxid" value="[{ $oxid }]" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="actshop" value="[{ $oxid }]" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>

<h1>Die Testlizenz ist abgelaufen</h1>
<p class="desc">

    Die Fehlermeldung &quot;die Lizenz ist abgelaufen&quot; weist darauf hin, dass die Testlizenz f&uuml;r das +modulname+ von draufgeschaut.de bereits in Ihrem Shop aktiviert wurde. <br /><br />
    Aber die Testlizenz, die in der Regel 30 Tage gilt, ist abgelaufen. <br /><br />
    Da die Testlizenz nur einmal aktiviert werden kann, kaufen Sie die Lizenz, um das Modul weiterhin zu verwenden:<br />
    <a href="https://www.volker-doerk.de" target="_blank" class="warning">Lizenz erwerben</a>
</p>
<hr />

<div class="messagebox">
 <p>
   Das Modul ist weiterhin aktiv. Wenn Sie das Modul nicht mehr nutzen m&ouml;chten, deaktivieren Sie es bitte unter:<br /><br />  
   Erweiterungen > Module > +modulname+ <br /><br />
   Vergessen Sie nicht eventuelle Cronjobs ebenfalls zu deaktivieren.<br />
   <br />
   Danke f&uuml;r Ihr Interresse an unseren Modul +modulname+.
 </p>
</div>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]