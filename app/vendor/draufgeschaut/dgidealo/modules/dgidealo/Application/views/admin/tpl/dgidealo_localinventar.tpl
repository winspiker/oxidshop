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
     F&uuml;r [{$dgIdealoLabel}] Lokales Inventar ben&ouml;tigen Sie zus&auml;tzliche Freischaltung.<br />
     Beantragen k&ouml;nnen Sie den Zugang bei <a href="mailto:tam@idealo.de?subject=[{$oView->getMailContentSubject()}]&body=[{$oView->getMailContentBody()}]">tam@idealo.de</a>.
 </p>
</div>

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
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Grundeinstellung [{$dgIdealoLabel}] Lokales Inventar</b></a>
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
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
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
                 <button type="button" class="edittext" onclick="JavaScript:showDialog('&cl=[{ $oViewConf->getTopActiveClassName() }]&aoc=dgidealoart2local');">Artikel zuordnen</button>
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
                <option value="" [{ if $oIdealo->getIdealoParam('dgIdealoBranchId') == "" }]SELECTED[{/if}]>- w&auml;hlen -</option>
                [{foreach from=$oView->dgIdealoBranchList() item=branch}]
                <option value="all|[{$branch->dgidealobranch__oxbranchid->value}]"     [{ if $oIdealo->getIdealoParam('dgIdealoBranchId') == "all|"|cat:$branch->dgidealobranch__oxbranchid->value     }]SELECTED[{/if}]>fester Wert [{$branch->dgidealobranch__oxbranchid->value}] &uuml;bertragen</option>
                [{/foreach}]
                 [{ if !$oIdealo->getIdealoParam('dgIdealoBranchId') }]<option value="create">Datenbankfeld erstellen</option>[{/if}]
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

     
    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
    <input type="hidden" name="fnc" value="save" />
    <input type="hidden" name="aStep" value="deliverytime_local" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="fnc" value="save" />
    [{ $oViewConf->getHiddenSid() }]    
    <div class="groupExp">
        <div [{ if $aStep == "deliverytime_local" }] class="exp"[{/if}]>
         <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Lieferzeit Meldung f&uuml;r Lokale Lieferung</b></a>
          <dl>
            <dt>
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;Sofort Lieferbar&quot;<br />
              <input type="text" placeholder="Lieferung am n&auml;chsten Arbeitstao" size="60" name="confstrs[dgIdealoLOCALOnStock]" value="[{$oIdealo->getIdealoParam('dgIdealoLOCALOnStock') }]" /> 
              <br /><br />
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;wenige Artikel auf Lager&quot;<br />
              <input type="text" placeholder="Lieferung am n&auml;chsten Arbeitstag" size="60" name="confstrs[dgIdealoLOCALLowStock]" value="[{$oIdealo->getIdealoParam('dgIdealoLOCALLowStock') }]" /> 
              <br /><br />
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;Ausverkauft&quot;<br />
              <input type="text" placeholder="Lieferung nach Absprache" size="60" name="confstrs[dgIdealoLOCALNotOnStock]" value="[{$oIdealo->getIdealoParam('dgIdealoLOCALNotOnStock') }]" /> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>     
         <dl>
		    <dt> <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button> <br /><br /></dt>
			<dd> &nbsp; </dd>
            <div class="spacer"></div>
         </dl>
       </div>
      </div>
    </form>  
    
    
    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
    <input type="hidden" name="fnc" value="save" />
    <input type="hidden" name="aStep" value="deliverytime_pickup" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="fnc" value="save" />
    [{ $oViewConf->getHiddenSid() }]    
    <div class="groupExp">
        <div [{ if $aStep == "deliverytime_pickup" }] class="exp"[{/if}]>
         <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Meldung f&uuml;r Abholung</b></a>
          <dl>
            <dt>
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;Sofort Lieferbar&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoPICKUPOnStock]" placeholder="Abholung in der Filiale sofort m&ouml;glich" value="[{$oIdealo->getIdealoParam('dgIdealoPICKUPOnStock') }]" /> 
              <br /><br />
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;wenige Artikel auf Lager&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoPICKUPLowStock]" placeholder="Abholung in der Filiale sofort m&ouml;glich" value="[{$oIdealo->getIdealoParam('dgIdealoPICKUPLowStock') }]" /> 
              <br /><br />
              Lieferzeit f&uuml;r [{$dgIdealoLabel}] bei &quot;Ausverkauft&quot;<br />
              <input type="text" size="60" name="confstrs[dgIdealoPICKUPNotOnStock]" placeholder="Abholung am n&auml;chsten Werktag Filiale sofort m&ouml;glich" value="[{$oIdealo->getIdealoParam('dgIdealoPICKUPNotOnStock') }]" /> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>     
         <dl>
		    <dt> <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button> <br /><br /></dt>
			<dd> &nbsp; </dd>
            <div class="spacer"></div>
         </dl>
       </div>
      </div>
    </form>  
    
    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
    <input type="hidden" name="fnc" value="addvalue" />
    <input type="hidden" name="type" value="dgIdealoDeliveryCostDe" />
    <input type="hidden" name="aStep" value="deliveryPICKUP" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
    [{ $oViewConf->getHiddenSid() }]        
	  <div class="groupExp">
        <div [{ if $aStep == "deliveryPICKUP" }] class="exp"[{/if}]>
          <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Abholkosten </b></a>
          <dl>
			 <dt>	
               Versandkosten f&uuml;r Abholung   
        		<select name="confstrs[dgIdealoPICKUPCostArt]" size="1">
                  <option value="oxprice"  [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxprice"  }]SELECTED[{/if}]>nach Preis</option>
        		  <option value="oxweight" [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxweight" }]SELECTED[{/if}]>nach Gewicht</option>
                  <option value="oxreal"   [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxreal"   }]SELECTED[{/if}]>berechnet, hoher Performance Bedarf</option>    		
        		</select> berechnen
             </dt>
		     <dd></dd>
             <div class="spacer"></div>
          </dl>
          [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') != "oxreal" }]
          <dl>
            <dt>
               [{assign var="del" value=$oIdealo->getIdealoParam('dgIdealoDelivery_De') }]
               <table cellspacing="0" cellpadding="0" border="0" width="600">
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Download]" value="[{$del.Download}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Paketdienst]" value="[{$del.Paketdienst}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Spedition]" value="[{$del.Spedition}]" /> 
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Briefversand]" value="[{$del.Briefversand}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][LOCAL]" value="[{$del.LOCAL}]" />
                 <tr>
                   <td>Abholung</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][PICKUP]" value="[{$del.PICKUP}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Abholkosten  </td>
                 </tr>
                </table><br />
                <button type="submit" onclick="this.form.fnc.value='save';showPleaseWait();">speichern</button>
                <br /><br />
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt> </dt>
            <dd> und bzw. oder Abholung nach [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxweight"}]Gewicht[{else}]Preis[{/if}] </dd>
            <div class="spacer"></div>
         </dl>
         <input size="4" type="hidden" name="para" value="" />
         <input size="5" type="hidden" name="value" value="" />
         <dl>
			<dd>	
              <table cellspacing="0" cellpadding="0" border="0" width="600">
               [{foreach from=$oIdealo->getIdealoParam('dgIdealoDeliveryCostPICKUP') item=price  key=ab}]
                 <tr>
                   <td>ab <input size="4" type="text" class="editinput" value="[{ $ab|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;"/> [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}]</td>
                   <td>&nbsp;</td>
                   <td> <input size="4" type="text" class="editinput" value="[{ $price|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten </td>
                   <td width="12"><a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&type=dgIdealoDeliveryCostPICKUP&value=[{$ab}]&fnc=deleteValue&oxid=[{$oxid}]&aStep=deliveryPICKUP" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                 </tr>
                 [{/foreach}]
                 <tr>
                   <td> ab <input size="4" type="text" class="editinput" name="aPara" value="" style="text-align: right;" /> [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}] </td>
                   <td>&nbsp;</td>
                   <td><input size="5" type="text" class="editinput" name="aValue" value="" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  
                   <td><input onclick="this.form.value.value=this.form.aValue.value;this.form.para.value=this.form.aPara.value;this.form.fnc.value='addvalue';this.form.type.value='dgIdealoDeliveryCostPICKUP';showPleaseWait();" type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" class="confinput" name="save" value="+" /></td>
                 </tr>
               </table>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{else}]
         <dl>
            <dt>         
            [{$dgIdealoLabel}] Versandkosten mit der Versandart
               <select name="confstrs[dgIdealoPICKUPCostArtDelSet]" size="1">
                [{foreach from=$oView->getDeliveryList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArtDelSet') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
                [{/foreach}]
	           </select> berechnen
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>         
            [{$dgIdealoLabel}] Versandkosten mit der Zahlart
               <select name="confstrs[dgIdealoPICKUPCostArtPayment]" size="1">
                [{foreach from=$oView->getPaymentList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoPICKUPCostArtPayment') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
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
    
    <form action="[{ $oViewConf->getSelfLink() }]" method="post">
    <input type="hidden" name="fnc" value="addvalue" />
    <input type="hidden" name="type" value="dgIdealoDeliveryCostDe" />
    <input type="hidden" name="aStep" value="delivery_LOCAL" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
    [{ $oViewConf->getHiddenSid() }]        
	  <div class="groupExp">
        <div [{ if $aStep == "delivery_LOCAL" }] class="exp"[{/if}]>
          <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>lokale Lieferkosten </b></a>
          <dl>
			 <dt>	
               lokale Lieferkosten   
        		<select name="confstrs[dgIdealoLOCALCostArt]" size="1">
                  <option value="oxprice"  [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxprice"  }]SELECTED[{/if}]>nach Preis</option>
        		  <option value="oxweight" [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxweight" }]SELECTED[{/if}]>nach Gewicht</option>
                  <option value="oxreal"   [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxreal"   }]SELECTED[{/if}]>berechnet, hoher Performance Bedarf</option>    		
        		</select> berechnen
             </dt>
		     <dd></dd>
             <div class="spacer"></div>
          </dl>
          [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') != "oxreal" }]
          <dl>
            <dt>
               [{assign var="del" value=$oIdealo->getIdealoParam('dgIdealoDelivery_De') }]
               <table cellspacing="0" cellpadding="0" border="0" width="600">
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Download]" value="[{$del.Download}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Paketdienst]" value="[{$del.Paketdienst}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Spedition]" value="[{$del.Spedition}]" /> 
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][Briefversand]" value="[{$del.Briefversand}]" />
                 <input type="hidden" name="dgParam[dgIdealoDelivery_De][PICKUP]" value="[{$del.PICKUP}]" />
                 <tr>
                   <td>lokale Lieferkosten</td>
                   <td><input size="5" type="text" class="editinput" name="dgParam[dgIdealoDelivery_De][LOCAL]" value="[{$del.LOCAL}]" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Abholkosten  </td>
                 </tr>
                </table><br />
                <button type="submit" onclick="this.form.fnc.value='save';showPleaseWait();">speichern</button>
                <br /><br />
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt> </dt>
            <dd> und bzw. oder Abholung nach [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxweight"}]Gewicht[{else}]Preis[{/if}] </dd>
            <div class="spacer"></div>
         </dl>
         <input size="4" type="hidden" name="para" value="" />
         <input size="5" type="hidden" name="value" value="" />
         <dl>
			<dd>	
              <table cellspacing="0" cellpadding="0" border="0" width="600">
               [{foreach from=$oIdealo->getIdealoParam('dgIdealoDeliveryCostLOCAL') item=price  key=ab}]
                 <tr>
                   <td>ab <input size="4" type="text" class="editinput" value="[{ $ab|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;"/> [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}]</td>
                   <td>&nbsp;</td>
                   <td> <input size="4" type="text" class="editinput" value="[{ $price|string_format:"%.2f" }]" readonly="true" disabled="true" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten </td>
                   <td width="12"><a href="[{ $oViewConf->getSelfLink() }]?sid=[{ $oViewConf->getSessionId() }]&cl=[{ $oViewConf->getTopActiveClassName() }]&type=dgIdealoDeliveryCostLOCAL&value=[{$ab}]&fnc=deleteValue&oxid=[{$oxid}]&aStep=deliveryLOCAL" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                 </tr>
                 [{/foreach}]
                 <tr>
                   <td> ab <input size="4" type="text" class="editinput" name="aPara" value="" style="text-align: right;" /> [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArt') == "oxweight"}]KG[{else}][{$oIdealo->getIdealoParam('dgIdealoCur')}][{/if}] </td>
                   <td>&nbsp;</td>
                   <td><input size="5" type="text" class="editinput" name="aValue" value="" style="text-align: right;" /> [{$oIdealo->getIdealoParam('dgIdealoCur')}] Versandkosten  
                   <td><input onclick="this.form.value.value=this.form.aValue.value;this.form.para.value=this.form.aPara.value;this.form.fnc.value='addvalue';this.form.type.value='dgIdealoDeliveryCostLOCAL';showPleaseWait();" type="image" src="[{$oViewConf->getModuleUrl('dgidealo','out/admin/img/dgadd.gif') }]" class="confinput" name="save" value="+" /></td>
                 </tr>
               </table>
            </dd>
            <div class="spacer"></div>
         </dl>
         [{else}]
         <dl>
            <dt>         
            [{$dgIdealoLabel}] lokale Lieferkosten mit der Versandart
               <select name="confstrs[dgIdealoLOCALCostArtDelSet]" size="1">
                [{foreach from=$oView->getDeliveryList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArtDelSet') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
                [{/foreach}]
	           </select> berechnen
            </dt>
            <dd>  </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>         
            [{$dgIdealoLabel}] lokale Lieferkosten mit der Zahlart
               <select name="confstrs[dgIdealoLOCALCostArtPayment]" size="1">
                [{foreach from=$oView->getPaymentList() item=iPayArt}]
                  <option value="[{ $iPayArt->oxid }]" [{ if $oIdealo->getIdealoParam('dgIdealoLOCALCostArtPayment') == $iPayArt->oxid }]SELECTED[{/if}]>[{ $iPayArt->name  }]</option>
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
    
	<div class="groupExp">
      <div [{ if $aStep == "branch" }] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Filialen anlegen &amp; bearbeiten</b></a>      
         [{foreach from=$oView->dgIdealoBranchList() item=branch}]
           <dl>
            <dt> </dt>
            <dd> 
              <form action="[{ $oViewConf->getSelfLink() }]" method="post">
              <input type="hidden" name="fnc" value="saveBranch" />
              <input type="hidden" name="type" value="branch" />
              <input type="hidden" name="aStep" value="branch" />
              <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
              <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
              <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
              <input type="hidden" name="editbranch[dgidealobranch__oxid]" value="[{$branch->dgidealobranch__oxid->value}]" />
              <input type="hidden" name="editbranch[dgidealobranch__oxshopid]" value="[{$oViewConf->getActiveShopId()}]" />
              [{ $oViewConf->getHiddenSid() }]        
                <input style="width:200px" type="text" placeholder="branchId" class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxbranchid->fldmax_length}]" name="editbranch[dgidealobranch__oxbranchid]" value="[{$branch->dgidealobranch__oxbranchid->value}]" /><br />
                <input style="width:200px" type="text" placeholder="Name" class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxbranchname->fldmax_length}]" name="editbranch[dgidealobranch__oxbranchname]" value="[{$branch->dgidealobranch__oxbranchname->value}]" /><br />
                <input style="width:160px"type="text" placeholder="Stra&szlig;e" class="editinput" size="23" maxlength="[{$branch->dgidealobranch__oxaddressstreet->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressstreet]" value="[{$branch->dgidealobranch__oxaddressstreet->value}]" />
                <input style="width:31px" type="text" placeholder="Nr." class="editinput" size="5" maxlength="[{$branch->dgidealobranch__oxaddressstreetnumber->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressstreetnumber]" value="[{$branch->dgidealobranch__oxaddressstreetnumber->value}]" /><br />
                <input style="width:200px" type="text" placeholder="AdditionalInfo"class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxaddressadditionalinfo->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressadditionalinfo]" value="[{$branch->dgidealobranch__oxaddressadditionalinfo->value}]" /><br />
                <input style="width:41px" type="text" placeholder="Plz" class="editinput" size="5" maxlength="[{$branch->dgidealobranch__oxaddresszip->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresszip]" value="[{$branch->dgidealobranch__oxaddresszip->value}]" />
                <input style="width:150px" type="text" placeholder="Stadt"class="editinput" size="23" maxlength="[{$branch->dgidealobranch__oxaddresscity->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresscity]" value="[{$branch->dgidealobranch__oxaddresscity->value}]" /><br />
                <input placeholder="DE" type="text" class="editinput" size="3" maxlength="[{$branch->dgidealobranch__oxaddresscountry->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresscountry]" value="[{$branch->dgidealobranch__oxaddresscountry->value}]" /><br />
                <input type="text" placeholder="Breitengrad" class="editinput" size="14" maxlength="[{$branch->dgidealobranch__oxaddresslatitude->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresslatitude]" value="[{$branch->dgidealobranch__oxaddresslatitude->value}]" />
                <input type="text" placeholder="L&auml;ngengrad" class="editinput" size="14" maxlength="[{$branch->dgidealobranch__oxaddresslongitude->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresslongitude]" value="[{$branch->dgidealobranch__oxaddresslongitude->value}]" /><br />
                <a href="https://www.gps-coordinates.net/" target="_blank"><small>Geodaten abfragen ?</small></a><br />
                
                <button type="submit" onclick="this.form.fnc.value='saveBranch';showPleaseWait();">speichern</button>
                <button type="submit" onclick="this.form.fnc.value='deleteBranch';showPleaseWait();">l&ouml;schen</button>
              </form>
            </dd>
            <div class="spacer"></div>
         </dl>    
         [{/foreach}]
         <dl>
            <dt> </dt>
            <dd> 
              <form action="[{ $oViewConf->getSelfLink() }]" method="post">
              <input type="hidden" name="fnc" value="addBranch" />
              <input type="hidden" name="type" value="branch" />
              <input type="hidden" name="aStep" value="branch" />
              <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
              <input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
              <input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
              <input type="hidden" name="editbranch[dgidealobranch__oxid]" value="" />
              <input type="hidden" name="editbranch[dgidealobranch__oxshopid]" value="[{$oViewConf->getActiveShopId()}]" />
              [{ $oViewConf->getHiddenSid() }]        
                <input style="width:200px" type="text" placeholder="branchId" class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxbranchid->fldmax_length}]" name="editbranch[dgidealobranch__oxbranchid]" value="" />[{ oxinputhelp ident="DGIDEALO_OXBRANCHID_HELP" }]<br />
                <input style="width:200px" type="text" placeholder="Name" class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxbranchname->fldmax_length}]" name="editbranch[dgidealobranch__oxbranchname]" value="" />[{ oxinputhelp ident="DGIDEALO_OXBRANCHNAME_HELP" }]<br />
                <input style="width:160px"type="text" placeholder="Stra&szlig;e" class="editinput" size="23" maxlength="[{$branch->dgidealobranch__oxaddressstreet->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressstreet]" value="" />
                <input style="width:31px" type="text" placeholder="Nr." class="editinput" size="5" maxlength="[{$branch->dgidealobranch__oxaddressstreetnumber->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressstreetnumber]" value="" /><br />
                <input style="width:200px" type="text" placeholder="AdditionalInfo"class="editinput" size="32" maxlength="[{$branch->dgidealobranch__oxaddressadditionalinfo->fldmax_length}]" name="editbranch[dgidealobranch__oxaddressadditionalinfo]" value="" /><br />
                <input style="width:41px" type="text" placeholder="Plz" class="editinput" size="5" maxlength="[{$branch->dgidealobranch__oxaddresszip->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresszip]" value="" />
                <input style="width:150px" type="text" placeholder="Stadt"class="editinput" size="23" maxlength="[{$branch->dgidealobranch__oxaddresscity->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresscity]" value="" /><br />
                <input placeholder="DE" type="text" class="editinput" size="3" maxlength="[{$branch->dgidealobranch__oxaddresscountry->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresscountry]" value="" />[{ oxinputhelp ident="DGIDEALO_OXADDRESSCOUNTRY_HELP" }]<br />
                <input type="text" placeholder="Breitengrad" class="editinput" size="14" maxlength="[{$branch->dgidealobranch__oxaddresslatitude->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresslatitude]" value="" />
                <input type="text" placeholder="L&auml;ngengrad" class="editinput" size="14" maxlength="[{$branch->dgidealobranch__oxaddresslongitude->fldmax_length}]" name="editbranch[dgidealobranch__oxaddresslongitude]" value="" />[{ oxinputhelp ident="DGIDEALO_OXADDRESSLATITUDEY_HELP" }]<br />
                <a href="https://www.gps-coordinates.net/" target="_blank"><small>Geodaten abfragen ?</small></a><br />
                
                <button type="submit" onclick="this.form.fnc.value='addBranch';showPleaseWait();">anlegen</button>
              </form>
            </dd>
            <div class="spacer"></div>
         </dl>     
      </div>
    </div>
    
    
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
			          <input size="90" type="text" value="[{ $oViewConf->getBaseDir() }]export/[{$oIdealo->getIdealoParam('dgIdealoFileName') }]" />
                    </div>
		          </td>
	            </tr>   
                <tr>
		          <td><label for="url">Export URL Lokales Inventar</label></td>
		          <td>
		            <div>
			          <input size="90" type="text" value="[{ $oViewConf->getBaseDir() }]export/[{$oIdealo->getIdealoParam('dgIdealoFileName')|replace:".":"_localinventar." }]" />
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
