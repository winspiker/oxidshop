[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--
[{ if $updatelist == 1}]
    UpdateList('[{ $oxid }]');
[{ /if}]

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
fieldset{
    width: 40%;
    float:left;
    margin: 10px;
vertical-align: top;
}

div#pleasewaiting{
   background: url('[{$oViewConf->getModuleUrl('dgconnector','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
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

td{vertical-align: top;}
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

    <div onclick="hidePleaseWait()" id="pleasewaiting"></div>
    
    [{if $dgMessage }]
    <div class="messagebox">
        [{foreach from=$dgMessage item=sMessage }]
            <p class="info">[{ $sMessage }]</p>
        [{/foreach}]
    </div>
    <hr />
    [{/if}]

   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="doMaintenance" />
   <input type="hidden" name="aStep" value="1" />
   <input type="hidden" name="oxid" value="[{ $editshop->oxshops__oxid->value }]" />
    <div class="groupExp">
        <div[{ if $aStep == 1 || !$aStep }] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>verwaisten Eintr&auml;ge bereinigen</b></a>
            <dl>
               <table width="100%">
                 <tr>
                   <td>
                    [{foreach from=$oView->getMaintenanceList() key=oAtr item=oMaintenanceJobs }]
                     <fieldset>
                       <legend>[{$oAtr}]</legend>
                       <table>
                         <colgroup>
                           <col width="1%" />
                           <col width="40%" />
                           <col width="10%" />
                           <col width="1%" />
                           <col width="40%" />
                         </colgroup>
                         [{assign var="count" value=0}]
                         [{foreach from=$oMaintenanceJobs item=oJob }]
                         [{assign var="count" value=$count+1}]
                         [{ if $count == 1 }]
                         <tr>
                           <td><input id="[{$oJob->fnc|md5}]" name="job[[{$oJob->fnc}]]" type="checkbox" value="[{$oJob->fnc}]"/></td>
                           <td><label for="[{$oJob->fnc|md5}]">[{$oJob->name}]</label> </td>
                           <td>&nbsp;</td>
                         [{ elseif $count == 2 }]
                           <td><input id="[{$oJob->fnc|md5}]" name="job[[{$oJob->fnc}]]" type="checkbox" value="[{$oJob->fnc}]"/></td>
                           <td><label for="[{$oJob->fnc|md5}]">[{$oJob->name}]</label> </td>
                         </tr> 
                         [{assign var="count" value=0}]
                         [{/if}]
                         [{/foreach}]
                         [{if $count == 2 }]
                           <td colspan="2">&nbsp;</td>
                         </tr> 
                         [{assign var="count" value=0}]
                         [{/if}]
                        </table>
                     </fieldset>
                     [{/foreach}] 
                   </td>
                 </tr>
               </table>
               <button type="submit" onclick="return confirm('M&ouml;glicherweise werden Datenbankeintr&auml;ge gel&ouml;scht.\nLegen Sie bitte vorab zwingend eine Sicherung der Datenbank an.\n\nSoll die Bereinigung jetzt durchgef&uuml;hrt werden?');showPleaseWait();">ausf&uuml;hren</button>
             </dl>
              <dd></dd>
              <div class="spacer"></div>
         </div>
    </div>
    </form>



[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]