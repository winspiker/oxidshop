[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]

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

    if (_cur.className == "exp") _cur.className = "exp";
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

function _save( oModulId )
{
    var oFrom = document.getElementById('myedit_' + oModulId )
    oFrom.fnc.value='save';
    oFrom.dghost.value   = document.getElementById('dghost' + oModulId ).value;
    oFrom.dgserial.value = document.getElementById('dgserial' + oModulId ).value;
    oFrom.submit();
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
.groupExp {background: #f0f0f0; border: 1px solid #bbb; float: left; margin-bottom: 7px; margin-right: 7px; padding: 3px 7px 1px 5px;}
.groupExp .exp {padding-left: 0;}
.groupExp a.rc b{background:none;}
.dgimgage{vertical-align: top;padding:0px 4px 3px 1px;}
.dgimgage img{width:87px;}
.dgtitel{width: 250px;height:30px; vertical-align: top;font-weight:bolder;}
.dgtext{width: 250px!important;height:78px; vertical-align: top;overflow:hidden;overflow-y:scroll;}
.dgstatus{color: green; height: 20px; text-align: right; vertical-align: bottom;}
.dgprice{text-align: right; vertical-align: bottom;}
.dgbutton{text-align: right;}
.dgbutton button{}
.dgtest{color:#880c02;}
.dgupdate{float:left;color:orange;}
dd>form{float:left;width:auto;margin-left:10px;}
.box { background-image: url('https://update.draufgeschaut.de/img/dg.gif?[{$smarty.now}]'); background-repeat: no-repeat; background-position: right bottom;} 
.dg { width: 24px; height: 24px; border: 1px solid #363431; padding: 1px 1px 1px 1px; background-color: #D1D2D2}
.borderleft{border-left: 1px solid #bbb;padding-left:4px;}
input.uppercase { text-transform: uppercase; text-align:center;}
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
div.box div.groupExp div a.rc b table{border-bottom:3px solid #f0f0f0;min-height: 150px;display: inline-block;max-width:350px;}

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
    <input type="hidden" name="cl" value="dgconnector_module" />
    <input type="hidden" name="actshop" value="[{ $oViewConf->getActiveShopId() }]" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>


    
    <div onclick="hidePleaseWait()" id="pleasewaiting"></div>
      [{foreach from=$oView->getModulList() item=oModul }]
      [{assign var="dgModul" value=$oModul->oxmodul }]
      [{assign var="dgInstallModul" value=$oView->hasModul($dgModul) }]
      
      
      [{if $dgInstallModul }] 
      [{assign var="dgHost" value=$oView->getSerialHostName($oModul) }]
      [{assign var="dgSerial" value=$oView->getSerial($oModul) }]
      <form name="myedit_[{ $dgModul }]" id="myedit_[{ $dgModul }]" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="dgconnector_module" />
        <input type="hidden" name="fnc" value="" />
        <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]" />
        <input type="hidden" name="dgmodul" value="[{ $dgModul }]" />
        <input type="hidden" name="dghost" value="[{ $dgHost }]" />
        <input type="hidden" name="dgserial" value="[{ $dgSerial }]" />
        <input type="hidden" name="aStep" value="[{ $dgModul }]" />    
      </form>
       
      <div class="groupExp">
        <div class="exp">
           <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>[{ $oModul->oxtitle }]</b></a>
            <dl>
             <dt> </dt>
             <dd>
                <table cellspacing="0" cellpadding="0" border="0">
                 <tbody>
                  <tr>
                    <td class="dgimgage" rowspan="6"><img src="[{ $oModul->oxicon }]" title="[{ $oModul->oxlable }]"></td>
                    <td class="dgtitel" colspan="2"></td>
                  </tr>                
                 <tr>
                    <td rowspan="5" class="dgtext">[{ $oModul->oxshortdesc }]</td>
                    <td class="borderleft" >&nbsp;</td>
                  </tr>
                 <tr>
                    <td class="borderleft">&nbsp;</td>
                  </tr>
                 <tr>
                    <td class="borderleft">Lizenz Domain:</td>
                  </tr>
                 <tr>
                    <td class="borderleft"><input id="dghost[{ $dgModul }]" name="dghost" type="text" size="40" value="[{ $dgHost }]" /></td>
                  </tr>
                 <tr>
                    <td class="borderleft">Lizenz Nummer:</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="borderleft"><input id="dgserial[{ $dgModul }]" name="dgserial" type="text" class="uppercase" size="40" value="[{ $dgSerial }]" /></td>
                  </tr>
                  <tr>
                    <td>
                       <form name="info" action="[{ $oModul->oxseourl }]" method="get" target="_blank">
                          <button>mehr info</button>
                       </form>
                    </td>
                    <td class="">
                      [{ if !$dgSerial }]
                         <button onclick="showPleaseWait();myedit_[{ $dgModul }].fnc.value='getSerialNumber';myedit_[{ $dgModul }].submit();">Seriennummer abfragen</button>     
                      [{/if}]               
                    </td>
                    <td class="dgbutton borderleft">
                      <button onclick="showPleaseWait();_save('[{ $dgModul }]');">speichern</button>
                    </td>
                  </tr>
                 </tbody>
               </table>                    
             </dt>
          </dl>
       </div>
     </div> 
    [{/if}]
    [{/foreach}]  




[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
