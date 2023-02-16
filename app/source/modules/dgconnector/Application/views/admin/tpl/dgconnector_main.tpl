[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
<script type="text/javascript">
<!--

function editThis( _tab )
{
    var oTransfer = document.getElementById("transfer");
    oTransfer.cl.value= _tab;
    oTransfer.submit();
}

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

function _install( oModulId )
{
    var oFrom = document.getElementById('myinstall_' + oModulId )
    oFrom.submit();
}


//-->
</script>
<script>
function searchAttribute() {
  var input, filter, table, tr, td, i;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("dgModulList");
  tr = table.getElementsByClassName("groupExp");
  for (i = 0; i < tr.length; i++) {
    label = tr[i].getElementsByClassName("dgtitel")[0];
    if (label) {
      if (label.innerHTML.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>
<style>
<!--
.groupExp {float:left;margin-right: 7px;border:1px solid #bbb;}
.groupExp .exp { padding-bottom: 3px; padding-left: 0;}
.groupExp a.rc b{background:none;}
.dgimgage{vertical-align: top;padding:0px 4px 3px 1px;}
.dgimgage img{width:87px;}
.dgtitel{width: 250px;height:48px; vertical-align: top;font-weight:bolder;border-bottom: 1px solid #bbb;overflow-y:scroll;}
.dgtext{width: 250px!important;height:82px; vertical-align: top;overflow-y:scroll;}
.dgstatus{color: green; height: 20px; text-align: right; vertical-align: bottom;}
.dgprice{text-align: right; vertical-align: bottom;}
.dgtest{color:#880c02;}
.dgupdate{float:left;color:orange;}
dd>form{float:left;width:auto;margin-left:10px;}
.box { background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]'); background-repeat: no-repeat; background-position: right bottom;} 
.dg { width: 24px; height: 24px; border: 1px solid #363431; padding: 1px 1px 1px 1px; background-color: #D1D2D2}

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

div dt { font-weight:normal;}
div.box div.groupExp div a.rc b table{border-bottom:3px solid #f0f0f0;min-height: 150px;display: inline-block;}

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
    <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
    <input type="hidden" name="cl" value="dgconnector_main" />
    <input type="hidden" name="actshop" value="[{ $oViewConf->getActiveShopId() }]" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>


    
    <div onclick="hidePleaseWait()" id="pleasewaiting"></div>
    
    Module durchsuchen <input type="text" id="myInput" onkeyup="searchAttribute()" placeholder="suche .." title="Type in a name">
    <hr />
    <div id="dgModulList">
    [{foreach from=$oView->getModulList() item=oModul }]
    [{assign var="dgModul" value=$oModul->oxmodul}]
    [{assign var="dgVersion" value=$oModul->oxversion }]
    [{assign var="dgInstallModul" value=$oView->hasModul($dgModul) }]
    [{assign var="dgInstallUpdate" value=$oView->hasUpdate($dgModul,$dgVersion) }]
    <div class="groupExp">
        <div[{ if $aStep == $oModul->oxmodul }] class="exp"[{/if}]>
           <a href="#" onclick="_groupExp(this);return false;" class="rc">
             <b>
                 <table style="border-bottom:3px solid [{if $dgInstallModul }]green[{else}]#880c02[{/if}];">
                  <tr>
                    <td class="dgimgage" rowspan="2"><img src="[{ $oModul->oxicon }]" title="[{ $oModul->oxlable }]"></td>
                    <td class="dgtitel">[{ $oModul->oxtitle }]</td>
                  </tr>
                  <tr>
                    <td><div  class="dgtext">[{ $oModul->oxshortdesc }]</div></td>
                  </tr>
                  <tr>
                  <td class="dgprice">[{if $dgInstallModul }]&nbsp;[{elseif $oModul->oxprice == "0,00"}]kostenlos[{else}][{$oModul->oxprice}] &euro;[{/if}]</td>
                    <td class="dgstatus">[{if $dgInstallUpdate }]update verf&uuml;gbar[{elseif $dgInstallModul }]bereits installiert[{else}]<span class="dgtest">testen</span>[{/if}]</td>
                  </tr>
                 </table>
             </b>
           </a>
           <dl>
             <dt> </dt>
             <dd>
               [{if $dgInstallUpdate }]
               <form name="myedit_[{$oModul->oxmodul}]" id="myedit_[{$oModul->oxmodul}]" action="[{ $oViewConf->getSelfLink() }]" method="post">
                 [{ $oViewConf->getHiddenSid() }]
                 <input type="hidden" name="cl" value="dgconnector_install" />
                 <input type="hidden" name="fnc" value="" />
                 <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                 <input type="hidden" name="dgmodul" value="[{$oModul->oxmodul}]" />
                 <input type="hidden" name="dgmodulname" value="[{$oModul->oxtitle}]" />
                 <input type="hidden" name="aStep" value="[{$oModul->oxmodul}]" />
                   <button onclick="showPleaseWait();">update ausf&uuml;hren</button>
               </form>
               [{/if}]
               [{if !$dgInstallModul }]
                 <form name="myinstall_[{$oModul->oxmodul}]" id="myinstall_[{$oModul->oxmodul}]" action="[{ $oViewConf->getSelfLink() }]" method="post">
                 [{ $oViewConf->getHiddenSid() }]
                 <input type="hidden" name="cl" value="dgconnector_install" />
                 <input type="hidden" name="fnc" value="" />
                 <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                 <input type="hidden" name="dgmodul" value="[{$oModul->oxmodul}]" />
                 <input type="hidden" name="dgmodulname" value="[{$oModul->oxtitle}]" />
                 <input type="hidden" name="aStep" value="[{$oModul->oxmodul}]" />
                   <button onclick="showPleaseWait();">testen</button>
                 </form>
               [{/if}]
               
               [{if !$dgInstallModul }]
                 <form name="myinstall_[{$oModul->oxmodul}]" id="myinstall_[{$oModul->oxmodul}]" action="[{ $oViewConf->getSelfLink() }]" method="post">
                 [{ $oViewConf->getHiddenSid() }]
                 <input type="hidden" name="cl" value="dgconnector_main" />
                 <input type="hidden" name="fnc" value="download" />
                 <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                 <input type="hidden" name="dgmodul" value="[{$oModul->oxmodul}]" />
                 <input type="hidden" name="dgmodulname" value="[{$oModul->oxtitle}]" />
                 <input type="hidden" name="aStep" value="[{$oModul->oxmodul}]" />
                   <button>download</button>
                 </form>
               [{/if}]
               
               [{if $dgInstallUpdate }][{elseif $dgInstallModul }]
               <form name="myedit_[{$oModul->oxmodul}]" id="myedit_[{$oModul->oxmodul}]" action="[{ $oViewConf->getSelfLink() }]" method="post">
                 [{ $oViewConf->getHiddenSid() }]
                 <input type="hidden" name="cl" value="dgconnector_install" />
                 <input type="hidden" name="fnc" value="" />
                 <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
                 <input type="hidden" name="dgmodul" value="[{$oModul->oxmodul}]" />
                 <input type="hidden" name="dgmodulname" value="[{$oModul->oxtitle}]" />
                 <input type="hidden" name="aStep" value="[{$oModul->oxmodul}]" />
                   <button>neu installieren</button>
                 </form>
               [{else}][{/if}]
               <form action="[{ $oModul->oxseourl }]" method="get" target="_blank">
                 <button onclick="showPleaseWait();">mehr info</button>
               </form>
             </dd>
             <div class="spacer"></div>
       </dl>
       </div>
     </div> 
     
    [{/foreach}] 
    </div>



[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
