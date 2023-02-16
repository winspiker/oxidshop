[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--

[{if $updatelist == 1}]
    UpdateList('[{$oxid}]');
[{/if}]



//-->
</script>
[{include file="dgotto/dgotto_head.tpl"}]
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
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
</form>

<div onclick="hidePleaseWait()" id="pleasewaiting" ></div>

<form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgOttoApi" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="confstrs[dgOttoCronUrl]" value="[{ $oViewConf->getBaseDir()}]" />

   <div class="groupExp">
        <div[{if $aStep == "dgOttoApi"}] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Einstellungen</b></a> 
            <dl>
                <dt>
                    <input type="hidden" name="confbools[dgOttoActiv]" value="false" />
                    <input id="dgOttoActiv" type="checkbox" name="confbools[dgOttoActiv]" value="true" [{if $oOtto->getOttoParam('dgOttoActiv')}]checked[{/if}] [{$readonly}]>
                  </dt>
                <dd>
                    <label for="dgOttoActiv">Modul aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input size="35" type="text" name="confstrs[dgOttoUsername]" value="[{$oOtto->getOttoParam('dgOttoUsername')}]" />
                </dt>
                <dd>
                   <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Market Username [{if $dgOttoIsTokenCorrect}] <span style="color:green">&#10004;</span> [{elseif !$dgOttoIsTokenCorrect}] <span style="color:red">&#10007;</span> [{/if}]
                </dd>
                <div class="spacer"></div>
            </dl>            
            <dl>
                <dt>
                   <input size="35" type="text" name="confstrs[dgOttoPassword]" value="[{$oOtto->getOttoParam('dgOttoPassword')}]" disabled="disabled" style="display:none" /><input size="35" type="password" name="confstrs[dgOttoPassword]" value="[{$oOtto->getOttoParam('dgOttoPassword')}]" />
                   <br /><input type="checkbox" id="sDbPassCheckbox" onClick="JavaScript:changeField('confstrs[dgOttoPassword]');" /> <label style="font-size:10px;" for="sDbPassCheckbox">anzeigen</label>
                   
                </dt>
                <dd>
                   <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Market Passwort [{if $dgOttoIsTokenCorrect}] <span style="color:green">&#10004;</span> [{elseif !$dgOttoIsTokenCorrect}] <span style="color:red">&#10007;</span> [{/if}]
                </dd>
                <div class="spacer"></div>
            </dl>  
            <dl>
                <dt>
                   <input size="35" type="text" name="confstrs[dgOttoClientId]" value="[{$oOtto->getOttoParam('dgOttoClientId')}]" readonly="true" />
                </dt>
                <dd>
                   <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Market ClientId
                </dd>
                <div class="spacer"></div>
            </dl> 
            <dl>
            <dt style="font-weight:normal;">
                <input id="dgOttoModeTrue"  name="confbools[dgOttoMode]" type="radio" value="true"  [{if $oOtto->getOttoParam('dgOttoMode')}]checked="checked"[{/if}] onchange="showPleaseWait();this.form.submit();" /> <label for="dgOttoModeTrue">Live Betrieb</label>
                <input id="dgOttoModeFalse" name="confbools[dgOttoMode]" type="radio" value="false" [{if !$oOtto->getOttoParam('dgOttoMode')}]checked="checked"[{/if}] onchange="showPleaseWait();this.form.submit();" /> <label for="dgOttoModeFalse">Sandbox Modus</label>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>  
         <dl>
                <dt>
                    <input type="hidden" name="confbools[dgOttoDebugApi]" value="false" />
                    <input id="dgOttoDebugApi" type="checkbox" name="confbools[dgOttoDebugApi]" value="true" [{if $oOtto->getOttoParam('dgOttoDebugApi')}]checked[{/if}] [{$readonly}]>
                  </dt>
                <dd>
                    <label for="dgOttoDebugApi">Debug Api aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
               <dt>
                <input size="35" type="text" name="confstrs[dgOttoCronKey]" value="[{$oOtto->getCronjobKey()}]" [{$readonly}]>
               </dt>
            <dd>
              Cronjob Passwort
            </dd>
            <div class="spacer"></div>
         </dl>                                       
            <dl>
                <dt></dt>
                <dd><button type="submit" onclick="showPleaseWait();">speichern</button></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
</form>

<form name="myedit3" id="myedit3" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="3" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
<input type="hidden" name="dgfield" value="" />
    <input type="hidden" name="dgotto" value="" />
<div class="groupExp">
   <div[{if $aStep == "3"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>[{oxmultilang ident="DGOTTO_ASTEP3"}]</b></a>
         <dl>
            <dt>
               <select size="1" name="confstrs[dgOttoLang]">
                [{foreach from=$language key=name item=plattform}]
	      	     <option value="[{$plattform->id}]" [{if $oOtto->getOttoParam('dgOttoLang') == $plattform->id}] selected[{/if}]>[{$plattform->name}]</option>
               [{/foreach}]
               </select>
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_LANG"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoCur]" size="1">
        		  [{foreach from=$currency item=cur}]
        		   <option value="[{$cur->name}]" [{if $cur->name ==  $oOtto->getOttoParam('dgOttoCur')}]SELECTED[{/if}]>[{$cur->name}] ( [{$cur->rate}] )</option>
        		  [{/foreach}]
        		 </select>  
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_CUR"}]
            </dd>
            <div class="spacer"></div>
         </dl>   
         <dl>
			   <dt>	
                  <select name="confstrs[dgOttoSqlHook]">
                  <option value="" style="color: #000000;"> - keine Verwendung - </option>
                  [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                  [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                  [{assign var="ident" value=$ident|upper}]
                  <option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoSqlHook') == $desc|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident alternative=$desc|lower alternative=$desc|lower noerror=true}]</option>
                  [{/foreach}]
                  </select> 
              </dt>
				<dd>[{if !$oOtto->getOttoParam('dgOttoSqlHook')}]
                     <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createEnumField';this.form.dgfield.value='dgotto[{$oOtto->getLocation()}]';this.form.dgotto.value='dgOttoSqlHook';showPleaseWait();">Feld f&uuml;r die <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Artikel Beschr&auml;nkung erstellen</button>
                    [{else}] welches Feld soll die <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Artikel beschr&auml;nken ? ( Inhalt 1/0 )[{/if}]
		       </dd>
               <div class="spacer"></div>
             </dl>
    <dl>
			   <dt>	
                  <select name="confstrs[dgOttoMoin]">
                  <option value="" style="color: #000000;"> - keine Verwendung - </option>
                  [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                  [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                  [{assign var="ident" value=$ident|upper}]
                  <option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoMoin') == $desc|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident alternative=$desc|lower alternative=$desc|lower noerror=true}]</option>
                  [{/foreach}]
                  </select> 
              </dt>
				<dd>[{if !$oOtto->getOttoParam('dgOttoMoin')}]
                     <button type="submit" class="edittext" name="save" onclick="this.form.fnc.value='createNewField';this.form.dgfield.value='dgottomoin';this.form.dgotto.value='dgOttoMoin';showPleaseWait();">Feld f&uuml;r die <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Artikel ID erstellen</button>
                    [{else}] welches Feld soll die <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Artikel ID[{/if}]
		       </dd>
               <div class="spacer"></div>
             </dl>
    
         <dl>
            <dt>
                <select name="confstrs[dgOttoSkuField]" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoId')|oxupper == $desc|oxupper || ( !$oOtto->getOttoParam('dgOttoId') && $desc|oxupper == "OXARTNUM" )}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_ID_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_ID"}]
            </dd>
            <div class="spacer"></div>
         </dl>  
         <dl>
            <dt>
                <select name="confstrs[dgOttoManufacturer]" style="width:200px;">
                 [{assign var="ident" value="GENERAL_ARTICLE_OXMANUFACTURERID"}]
                 <option value="oxmanufacturerid" [{if $oOtto->getOttoParam('dgOttoManufacturer')|oxupper == 'oxmanufacturerid' || !$oOtto->getOttoParam('dgOttoManufacturer')}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                 [{assign var="ident" value="GENERAL_ARTICLE_OXVENDORID"}]
                 <option value="oxvendorid" [{if $oOtto->getOttoParam('dgOttoManufacturer')|oxupper == 'oxvendorid' || !$oOtto->getOttoParam('dgOttoManufacturer')}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_MANUFACTURER_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_MANUFACTURER"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoTitle]" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoTitle')|oxupper == $desc|oxupper || ( !$oOtto->getOttoParam('dgOttoTitle') && $desc|oxupper == "OXTITLE" )}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_NAME_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_NAME"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoDescription]" style="width:200px;">
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoDescription')|oxupper == $desc|oxupper || ( !$oOtto->getOttoParam('dgOttoDescription') && $desc|oxupper == "OXSHORTDESC" )}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_DESCRIPTION_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_DESCRIPTION"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoMpnr]" style="width:200px;">
                 <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower }]" [{if $oOtto->getOttoParam('dgOttoMpnr')|oxupper == $desc|oxupper || ( !$oOtto->getOttoParam('dgOttoMpnr') && $desc|oxupper == "OXMPN" )}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_MPNR_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_MPNR"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoEanField]" style="width:200px;">
                <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower }]" [{if $oOtto->getOttoParam('dgOttoEanField')|oxupper == $desc|oxupper || ( !$oOtto->getOttoParam('dgOttoEanField') && $desc|oxupper == "OXEAN" )}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_EAN_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_EAN"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
                <select name="confstrs[dgOttoPnz]" style="width:200px;">
                <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower }]" [{if $oOtto->getOttoParam('dgOttoPnz')|oxupper == $desc|oxupper}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
                 </select> [{oxinputhelp ident="DGOTTO_FIELD_PNZ_HELP"}]
            </dt>
            <dd>
              [{oxmultilang ident="DGOTTO_FIELD_PNZ"}]
            </dd>
            <div class="spacer"></div>
         </dl>
         [{section loop=5 name="bilder"}]
             [{assign var="dgOttoBulletPoint" value="dgOttoBulletPoint"|cat:$smarty.section.bilder.index+1}]
			 <dl>
			   <dt>	
        		<select name="confstrs[[{$dgOttoBulletPoint}]]" size="1" style="width:200px;">
                 <option value="" selected>---</option>
                 [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                 [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|lower }]" [{if $oOtto->getOttoParam($dgOttoBulletPoint)|oxupper == $desc|oxupper}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
                [{/foreach}]
        		</select>
              </dt>
				<dd>Welches Feld soll f&uuml;r Bulletpoint [{$smarty.section.bilder.index+1}] genutzt werden ? </dd>
                <div class="spacer"></div>
             </dl>
             [{/section}]
         <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoUseLongDesc]" value="false" />
                  <input id="dgOttoUseLongDesc" type="checkbox" name="confbools[dgOttoUseLongDesc]" value="true"  [{if $oOtto->getOttoParam('dgOttoUseLongDesc')}]checked[{/if}] />
                </dt>
                <dd>
                  <label for="dgOttoUseLongDesc"> Langbeschreibung extra editieren </label>
                </dd>
                <div class="spacer"></div>
         </dl>
         </dl>
              <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoUseTitleAsProductLine]" value="false" />
                  <input id="dgOttoUseTitleAsProductLine" type="checkbox" name="confbools[dgOttoUseTitleAsProductLine]" value="true"  [{if $oOtto->getOttoParam('dgOttoUseTitleAsProductLine')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoUseTitleAsProductLine"> Feld ProduktLine mit Artikelnamen vorbelegen </label></dd>
                <div class="spacer"></div>
         </dl>
         </dl>
              <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoUseProductReference]" value="false" />
                  <input id="dgOttoUseProductReference" type="checkbox" name="confbools[dgOttoUseProductReference]" value="true"  [{if $oOtto->getOttoParam('dgOttoUseProductReference')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoUseProductReference"> Feld Product Reference nicht automatisch f&uuml;llen </label>
                [{if $oOtto->getOttoParam('dgOttoUseProductReference')}]<br /> &nbsp; 
                  <input type="hidden" name="confbools[dgOttoUseTitleAsReference]" value="false" />
                  <input id="dgOttoUseTitleAsReference" type="checkbox" name="confbools[dgOttoUseTitleAsReference]" value="true"  [{if $oOtto->getOttoParam('dgOttoUseTitleAsReference')}]checked[{/if}] />
                  <label for="dgOttoUseTitleAsReference"> Feld Product Reference mit Artikelnamen vorbelegen </label>
                [{/if}]
                </dd>
                <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <select size="1" name="confstrs[dgOttoBrandClass]">
	      	     <option value="oxManufacturer" [{if $oOtto->getOttoParam('dgOttoBrandClass') == 'oxManufacturer'}] selected[{/if}]>[{oxmultilang ident="mxmanufacturer"}]</option>
                 <option value="oxVendor"       [{if $oOtto->getOttoParam('dgOttoBrandClass') == 'oxVendor'      }] selected[{/if}]>[{oxmultilang ident="mxvendor"}]</option>
               </select>
            </dt>
            <dd>
              Welches Feld soll f&uuml;r die <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> <b>Marke/Brand</b> genutzt werden ?
            </dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>
               <br/>
               <button type="submit" name="save" onclick="showPleaseWait();" [{$readonly}]>[{oxmultilang ident="GENERAL_SAVE"}]</button>
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
       </dl>  
   </div>
</div>
</form>

   
      <form action="[{$oViewConf->getSelfLink()}]" method="post">
    <input type="hidden" name="fnc" value="save" />
    <input type="hidden" name="aStep" value="articleprice" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
    <input type="hidden" name="dgfield" value="" />
    <input type="hidden" name="dgotto" value="" />
    [{$oViewConf->getHiddenSid()}]        
	  <div class="groupExp">
        <div [{if $aStep == "articleprice"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Preisgestaltung </b></a>
			 <dl>
			   <dt>	
                 <select name="confstrs[dgOttoUsePrice]" size="1" onchange="Javascript:showPleaseWait();this.form.submit();">
         		   <option value=""> - Standardpreis - </option>
                   <option value="brutprice" [{if $oOtto->getOttoParam('dgOttoUsePrice') == 'brutprice'}]SELECTED[{/if}]>Standardpreis mit Berechnung </option>
                   [{foreach from=$oView->getPriceList() item=oPrice}]
                   [{assign var="ident" value="GENERAL_ARTICLE_"|cat:$oPrice->Field}]
                   [{assign var="ident" value=$ident|upper}]
				   <option value="[{$oPrice->Field}]" [{if $oOtto->getOttoParam('dgOttoUsePrice') == $oPrice->Field}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident noerror=true }] ( [{$oPrice->Field}] )</option>
                   [{/foreach}]
                 </select> <br />                
                 <input type="hidden" name="confbools[dgOttoUsePriceIsNet]" value="false" />
                 <input id="dgOttoUsePriceIsNet" type="checkbox" name="confbools[dgOttoUsePriceIsNet]" value="true" [{if $oOtto->getOttoParam('dgOttoUsePriceIsNet')}]checked[{/if}] /> 
                 <label for="dgOttoUsePriceIsNet" style="font-weight:100;">dies ist eine Netto Preisangabe </label>

              </dt>
				<dd>
				    Welches Feld soll f&uuml;r den Preis genutzt werden ?
				</dd>
                <div class="spacer"></div>
             </dl>
             [{if $oOtto->getOttoParam('dgOttoUsePrice') != ""}]
             <dl>
			   <dt>	
                 <select name="confstrs[dgOttoUseBasePrice]" size="1" onchange="Javascript:showPleaseWait();this.form.submit();">
         		   <option value="brutprice" [{if $oOtto->getOttoParam('dgOttoUseBasePrice') == 'brutprice'}]SELECTED[{/if}]>Standardpreis mit Berechnung </option>
                   <option value="oxprice"   [{if $oOtto->getOttoParam('dgOttoUseBasePrice') == 'oxprice'  }]SELECTED[{/if}]>Preis ohne Berechnung  ( nur Datenbankfeld oxprice verwenden ) </option>
                 </select> <br />
                 <input type="hidden" name="confbools[dgOttoUseBasePriceIsNet]" value="false" />
                 <input id="dgOttoUseBasePriceIsNet" type="checkbox" name="confbools[dgOttoUseBasePriceIsNet]" value="true" [{if $oOtto->getOttoParam('dgOttoUseBasePriceIsNet')}]checked[{/if}] /> 
                 <label for="dgOttoUseBasePriceIsNet" style="font-weight:100;">dies ist eine Netto Preisangabe</label>
              </dt>
				<dd>
                  [{assign var="ident" value="GENERAL_ARTICLE_"|cat:$oOtto->getOttoParam('dgOttoUsePrice')}]
                     [{assign var="ident" value=$ident|upper}]
				     Wenn <u>[{oxmultilang|truncate:20:"..":true ident=$ident noerror=true }] nicht gef&uuml;llt</u> ist soll welcher Preis genutzt werden?   
				</dd>
                <div class="spacer"></div>
             </dl>
             [{/if}]
             <dl>
			   <dt>	
                 <select name="confstrs[dgOttoUseTPrice]" size="1">
         		   <option value=""> - Standardpreis - </option>
                   [{foreach from=$oView->getPriceList() item=oPrice}]
                   [{assign var="ident" value="GENERAL_ARTICLE_"|cat:$oPrice->Field}]
                   [{assign var="ident" value=$ident|upper}]
				   <option value="[{$oPrice->Field}]" [{if $oOtto->getOttoParam('dgOttoUseTPrice') == $oPrice->Field}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true }] ( [{$oPrice->Field}] )</option>
                   [{/foreach}]
                 </select> <br />
                 <input type="hidden" name="confbools[dgOttoUseTPriceIsNet]" value="false" />
                 <input id="dgOttoUseTPriceIsNet" type="checkbox" name="confbools[dgOttoUseTPriceIsNet]" value="true" [{if $oOtto->getOttoParam('dgOttoUseTPriceIsNet')}]checked[{/if}] /> 
                 <label for="dgOttoUseTPriceIsNet"  style="font-weight:100;">dies ist eine Netto Preisangabe </label>
              </dt>
				<dd> Welches Feld soll f&uuml;r den UVP genutzt werden ?</dd>
                <div class="spacer"></div>
             </dl>            
             <dl>
			   <dt>	
        		 <input type="text" name="confstrs[dgOttoAddPrice]" value="[{$oOtto->getOttoParam('dgOttoAddPrice')}]" size="5" /> [{oxinputhelp ident="dgOttoAddPrice"}]
              </dt>
				<dd> Soll ein globaler prozentualer Preis auf bzw Abschlag genutzt werden? </dd>
                <div class="spacer"></div>
             </dl>
             
             <dl>
			   <dt>	
        		 <input type="text" name="confstrs[dgOttoAddFixPrice]" value="[{$oOtto->getOttoParam('dgOttoAddFixPrice')}]" size="5" /> [{oxinputhelp ident="dgOttoAddFixPrice"}]
              </dt>
				<dd> Soll ein starrer Preis auf bzw Abschlag genutzt werden? </dd>  
                <div class="spacer"></div>          
             </dl>
			 <dl>
			   <dt>	
        		 <select name="confstrs[dgOttoRoundPrice]" size="1" onchange="Javascript:showPleaseWait();this.form.submit();">
         		   <option value=""> - nicht - </option>
                   <option value="niceround"   [{if $oOtto->getOttoParam('dgOttoRoundPrice') == 'niceround'  }]SELECTED[{/if}]>runden auf 0 und 5</option>
                   <option value="niceroundup" [{if $oOtto->getOttoParam('dgOttoRoundPrice') == 'niceroundup'}]SELECTED[{/if}]>immer aufrunden</option>
                   <option value="hardround"   [{if $oOtto->getOttoParam('dgOttoRoundPrice') == 'hardround'  }]SELECTED[{/if}]>hartes runden</option>
                 </select>
                 Preise auf bzw. abrunden ?
                 [{if $oOtto->getOttoParam('dgOttoRoundPrice') == 'hardround'}]
			
        		 <input type="text" name="confstrs[dgOttoRoundPriceFormat]" value="[{$oOtto->getOttoParam('dgOttoRoundPriceFormat')}]" size="5" />
                 auf wieviel Nachkommenstellen soll gerundet werden ? [{/if}]
              </dt>
				<dd> </dd>
                <div class="spacer"></div>
             </dl>
             <dl>
			   <dt>	
        		 <input type="text" name="confstrs[dgOttoLastRound]" value="[{$oOtto->getOttoParam('dgOttoLastRound')}]" size="5" />
              </dt>
				<dd> zum Abschluss der Preisgestaltung soll auf x? Nachkommenstellen gerundet werden. ( nur bei Berechnungen nutzen Standard ist 2 ) </dd>
                <div class="spacer"></div>
             </dl>
             
             <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoUseMsrpPrice]" value="false" />
                  <input id="dgOttoUseMsrpPrice" type="checkbox" name="confbools[dgOttoUseMsrpPrice]" value="true" [{if $oOtto->getOttoParam('dgOttoUseMsrpPrice')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoUseMsrpPrice"> UVP &uuml;bermitteln </label></dd>
                <div class="spacer"></div>
            </dl>

             
             
             <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoDontUseSalesPrice]" value="false" />
                  <input id="dgOttoDontUseSalesPrice" type="checkbox" name="confbools[dgOttoDontUseSalesPrice]" value="true" [{if $oOtto->getOttoParam('dgOttoDontUseSalesPrice')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoDontUseSalesPrice"> keine Sonderpreisedarstellung &uuml;bermitteln die auf Basis der Rabattberechnung entstehen. ( Datenbankfeld Preisfeld ist gr&ouml;&szlig;er als der Bruttopreis ) </label></dd>
                <div class="spacer"></div>
            </dl>

             <dl>
			    <dt> <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">speichern</button> </dt>
				<dd> &nbsp; </dd>
                <div class="spacer"></div>
             </dl>
         </div>
    </div>
    </form>
    
    <form action="[{$oViewConf->getSelfLink()}]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="articlestock" />
      <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
      <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
      <input type="hidden" name="dgfield" value="" />
      <input type="hidden" name="dgotto" value="" />
      [{$oViewConf->getHiddenSid()}]    
      <div class="groupExp">
        <div [{if $aStep == "articlestock"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Lagerverwaltung und Lieferzeit</b></a>
            <dl>
			   <dt>	
        		<select style="width: 250px;" name="confstrs[dgOttoStockField]" size="1">
        		[{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
        		[{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                [{assign var="ident" value=$ident|upper}]
				<option value="[{$desc|lower}]" [{if $oOtto->getOttoParam('dgOttoStockField') == $desc|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident alternative=$desc|lower noerror=true}]</option>
        		[{/foreach}]
        		</select>
              </dt>
				<dd>Welches Datenbankfeld soll f&uuml;r den Lagerbestand genutzt werden ? </dd>
                <div class="spacer"></div>
             </dl>
            <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoSentNullStock]" value="false" />
                  <input id="dgOttoSentNullStock" type="checkbox" name="confbools[dgOttoSentNullStock]" value="true"  [{if $oOtto->getOttoParam('dgOttoSentNullStock')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoSentNullStock">Lager mit null &uuml;bermitteln, Urlaubseinstellung.</label></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <input type="hidden" name="confbools[blAllowNegativeStock]" value="false" />
                  <input id="blAllowNegativeStock" type="checkbox" name="confbools[blAllowNegativeStock]" value="true"  [{if $oOtto->getOttoParam('blAllowNegativeStock')}]checked[{/if}] />
                </dt>
                <dd><label for="blAllowNegativeStock">Negative Lagerbest&auml;nde erlauben.</label></dd>
                <div class="spacer"></div>
            </dl>
            
            <dl>
			   <dt>	
                  <input type="text" name="confstrs[dgOttoNegativeStock]" value="[{$oOtto->getOttoParam('dgOttoNegativeStock')}]" size="5" />
                </dt>
                <dd>[{oxinputhelp ident="dgOttoStockshuffle"}] bei Negative Lagerbest&auml;nde erlauben, diesen Lagerbestand nutzen. </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoDontUseoxdelivery]" value="false" />
                  <input id="dgOttoDontUseoxdelivery" type="checkbox" name="confbools[dgOttoDontUseoxdelivery]" value="true"  [{if $oOtto->getOttoParam('dgOttoDontUseoxdelivery')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoDontUseoxdelivery">Datenbank Feld oxdelivery nicht ber&uuml;cksichtigen.</label></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <input type="text" name="confstrs[dgOttoDefaultStock]" value="[{$oOtto->getOttoParam('dgOttoDefaultStock')}]" size="5" />
                </dt>
                <dd>[{oxinputhelp ident="dgOttoStockshuffle"}] bei nicht aktiver Lagerverwaltung diesen Lagerbestand nutzen. </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;">	
                  ab einem Lagerbestand 
		          <input class="edittext" type="text" name="confstrs[dgOttoFromStock]" value="[{$oOtto->getOttoParam('dgOttoFromStock')}]" size="5" />
	              nur noch 
	              <input class="edittext" type="text" name="confstrs[dgOttoMaxStock]" value="[{$oOtto->getOttoParam('dgOttoMaxStock')}]" size="5" />
	              [{oxinputhelp ident="dgOttoStockshuffle"}] an <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> &uuml;bermitteln
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
	              Lagerbestand nicht gr&ouml;&szlig;er als <input class="edittext" type="text" name="confstrs[dgOttoSendMaxStock]" value="[{$oOtto->getOttoParam('dgOttoSendMaxStock')}]" size="5" /> [{oxinputhelp ident="dgOttoStockshuffle"}] an <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> &uuml;bermitteln.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
	              <input class="edittext" type="text" name="confstrs[dgOttoGlobalStockBuffer]" value="[{$oOtto->getOttoParam('dgOttoGlobalStockBuffer')|default:"0"}]" size="5" /> [{oxinputhelp ident="dgOttoGlobalStockBuffer"}] St&uuml;ck immer vom Lagerbestand herunter rechnen.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
	              bei einem Lagerbestand von null, aber einem g&uuml;ltigen Lieferdatum ( Lieferbar am ) <input class="edittext" type="text" name="confstrs[NoStockWithDeliveryDate]" value="[{$oOtto->getOttoParam('NoStockWithDeliveryDate')}]" size="5" /> St&uuml;ck an <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> &uuml;bermitteln.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
                 ab <input class="edittext" type="text" name="confstrs[dgOttoGlobalOverridefromStock]" value="[{$oOtto->getOttoParam('dgOttoGlobalOverridefromStock')|default:"0"}]" size="5" /> Lagerbestand
	              <input class="edittext" type="text" name="confstrs[dgOttoGlobalOverrideStock]" value="[{$oOtto->getOttoParam('dgOttoGlobalOverrideStock')|default:"0"}]" size="5" /> [{oxinputhelp ident="dgOttoGlobalOverrideStock"}] St&uuml;ck immer zum Lagerbestand hinzurechnen rechnen.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
	              Standard Lagerbestand f&uuml;r Fremdlager <input class="edittext" type="text" name="confstrs[oxStockflag4Stock]" value="[{$oOtto->getOttoParam('oxStockflag4Stock')}]" size="5" /> [{oxinputhelp ident="dgOttoStockshuffle"}] St&uuml;ck an <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> &uuml;bermitteln.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt style="font-weight:normal;"> 
	              Bei negativen Lagerbestand und Lieferzeitangabe von 1-30 Tagen einen Lagerbestand von <input class="edittext" type="text" name="confstrs[dgOttoUseoxDeliveryStock]" value="[{$oOtto->getOttoParam('dgOttoUseoxDeliveryStock')}]" size="5" /> [{oxinputhelp ident="dgOttoStockshuffle"}] an <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> &uuml;bermitteln.
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <input type="text" name="confstrs[dgOttoOffStockDeliveryDays]" value="[{$oOtto->getOttoParam('dgOttoOffStockDeliveryDays')}]" size="5" />
                </dt>
                <dd>Tage Lieferzeit, dann Lagerbestand auf null setzen.</dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <input type="text" name="confstrs[dgOttoDefaultDeliveryDays]" value="[{$oOtto->getOttoParam('dgOttoDefaultDeliveryDays')}]" size="5" /> [{oxinputhelp ident="dgOttoDefaultDeliveryDays"}]
                </dt>
                <dd>Standardlieferzeit in Tagen </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                  <select name="confstrs[dgOttoUseArticleDeliverTime]">
                  <option value="" style="color: #000000;"> - keine Verwendung - </option>
                  <option value="oxmindeltime" [{if $oOtto->getOttoParam('dgOttoUseArticleDeliverTime') == 'oxmindeltime'}]SELECTED[{/if}]>Mindest Lieferzeit nutzen</option>
                  <option value="oxmaxdeltime" [{if $oOtto->getOttoParam('dgOttoUseArticleDeliverTime') == 'oxmaxdeltime'}]SELECTED[{/if}]>Maximale Lieferzeit nutzen</option>
                  </select>
                </dt>
                <dd></dd>
                <div class="spacer"></div>
            </dl>
             <dl>
			    <dt> <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">speichern</button> <br /><br /></dt>
				<dd> &nbsp; </dd>
                <div class="spacer"></div>
             </dl>
         </div>
      </div>
      </form>

<form action="[{$oViewConf->getSelfLink()}]" method="post">
      <input type="hidden" name="fnc" value="save" />
      <input type="hidden" name="aStep" value="articlespictures" />
      <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
      <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
      [{$oViewConf->getHiddenSid()}]   
           
	  <div class="groupExp">
        <div [{if $aStep == "articlespictures"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel Bilder </b></a>
             [{section loop=12 name="bilder"}]
             [{assign var="dgOttoPic" value="dgOttoPic"|cat:$smarty.section.bilder.index+1}]
			 <dl>
			   <dt>	
        		<select name="confstrs[[{$dgOttoPic}]]" size="1">
        		<option value="" style="color: red">- nicht benutzen - </option>
                [{section loop=$oOtto->getOttoParam('iPicCount') name="desc"}]
                  [{assign var="id" value="OXPIC"|cat:$smarty.section.desc.index+1}]
                  [{assign var="ident" value=GENERAL_ARTICLE_$id}]
                  [{assign var="ident" value=$ident|upper}]
				  <option value="[{$id|lower}]" [{if $oOtto->getOttoParam( $dgOttoPic ) == $id|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident noerror=true }]</option>
                [{/section}]
                [{section loop=$oOtto->getOttoParam('iZoomPicCount') name="desc"}]
                  [{assign var="id" value="OXZOOM"|cat:$smarty.section.desc.index+1}]
                  [{assign var="ident" value=GENERAL_ARTICLE_$id}]
                  [{assign var="ident" value=$ident|upper}]
				  <option value="[{$id|lower}]" [{if $oOtto->getOttoParam( $dgOttoPic ) == $id|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident noerror=true }]</option>
                [{/section}]
                [{if $isMasterImage}]
                [{section loop=$oOtto->getOttoParam('iZoomPicCount') name="desc"}]
                  [{assign var="id" value="OXZOOM"|cat:$smarty.section.desc.index+1}]
                  [{assign var="check" value="MOXZOOM"|cat:$smarty.section.desc.index+1}]
                  [{assign var="ident" value=GENERAL_ARTICLE_$id}]
                  [{assign var="ident" value=$ident|upper}]
				  <option value="m[{$id|lower}]" [{if $oOtto->getOttoParam($dgOttoPic) == $check|lower}]SELECTED[{/if}]>[{oxmultilang|truncate:20:"..":true ident=$ident noerror=true }] ( Master )</option>
                [{/section}]
                [{/if}]
        		</select>
                
                [{assign var="dgOttoPicLabel" value="dgOttoPicLabel"|cat:$smarty.section.bilder.index+1}]
                
                <label for="[{$dgOttoPicLabel}]">Type</label>
                <select id="[{$dgOttoPicLabel}]" name="confstrs[[{$dgOttoPicLabel}]]" size="1">
                  <option value="" style="color: red">- nicht benutzen - </option>
                  <option value="IMAGE"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "IMAGE"}] SELECTED[{/if}]>Bild</option>
                  <option value="DIMENSIONAL_DRAWING"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "DIMENSIONAL_DRAWING"}] SELECTED[{/if}]>Gr&ouml;&szlig;enbild</option>
                  <option value="COLOR_VARIANT"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "COLOR_VARIANT"}] SELECTED[{/if}]>Farbbeispiel</option>
                  <option value="ENERGY_EFFICIENCY_LABEL"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "ENERGY_EFFICIENCY_LABEL"}] SELECTED[{/if}]>Energylabel</option>
                  <option value="MATERIAL_SAMPLE"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "MATERIAL_SAMPLE"}] SELECTED[{/if}]>Musterbeispiel</option>
                  <option value="PRODUCT_DATASHEET"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "PRODUCT_DATASHEET"}] SELECTED[{/if}]>Aufbauanleitung</option>
                  <option value="USER_MANUAL"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "USER_MANUAL"}] SELECTED[{/if}]>Bedienungsanleitung</option>
                  <option value="MANUFACTURER_WARRANTY"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "MANUFACTURER_WARRANTY"}] SELECTED[{/if}]>Herstellergarantie</option>
                  <option value="SAFETY_DATASHEET"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "SAFETY_DATASHEET"}] SELECTED[{/if}]>Sicherheitsdatenblatt</option>
                  <option value="ASSEMBLY_INSTRUCTIONS"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "ASSEMBLY_INSTRUCTIONS"}] SELECTED[{/if}]>Pflegehinweis</option>
                  <option value="WARNING_LABEL"[{if $oOtto->getOttoParam( $dgOttoPicLabel ) == "WARNING_LABEL"}] SELECTED[{/if}]>Sicherheitslabel</option>
                </select>
              </dt>
				<dd>Welches Feld soll f&uuml;r das Bild [{$smarty.section.bilder.index+1}] genutzt werden ? </dd>
                <div class="spacer"></div>
             </dl>
             [{/section}]
             <dl>
			   <dt>	
                  <input type="hidden" name="confbools[dgOttoUseZoomPics]" value="false" />
                  <input id="dgOttoUseZoomPics" type="checkbox" name="confbools[dgOttoUseZoomPics]" value="true"  [{if $oOtto->getOttoParam('dgOttoUseZoomPics')}]checked[{/if}] />
                </dt>
                <dd><label for="dgOttoUseZoomPics">Wenn m&ouml;glich Zoombilder nutzen.</label></dd>
                <div class="spacer"></div>
            </dl>
             <dl>
			    <dt> <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">speichern</button> </dt>
				<dd> &nbsp; </dd>
                <div class="spacer"></div>
             </dl>
         </div>
       </div>
      </form>
      
      <form name="dgOttoOrder" id="dgOttoOrder" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgOttoOrder" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "dgOttoOrder"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Einstellungen Bestellimport </b></a>
      <dl>
         <dt>
               <input type="hidden" name="confbools[dgOttoUseOttoCounter]" value="false" />
               <input id="dgOttoUseOttoCounter" type="checkbox" name="confbools[dgOttoUseOttoCounter]" value="true" [{if $oOtto->getOttoParam('dgOttoUseOttoCounter')}]checked[{/if}] />
               [{oxinputhelp ident="dgOttoUseOttoCounter"}]
            </dt>
            <dd>
               <label for="dgOttoUseOttoCounter">[{$dgOttoLabel}] Bestellnummer als OXID Bestellnummer nutzen <small>( funktioniert nur wenn Ihre Bestenummerspalte varchar ist)</small></label>
            </dd>
            <div class="spacer"></div>
         </dl>
      <dl>
         <dt>
            Kunden der Kundengruppe 
            <select name="confstrs[dgOttoUserGroup]" size="1">
              <option value="" style="color: #000000;">keine</option>
	          [{foreach from=$oView->getGroupList() item=groups}]
	          <option value="[{$groups->oxid}]" [{if $oOtto->getOttoParam('dgOttoUserGroup') == $groups->oxid}]SELECTED[{/if}]>[{$groups->name}]</option>
	          [{/foreach}]
	        </select> zuordnen.
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl>  
      <dl>
         <dt style="font-weight:normal">
            nach dem Import Bestellungen in Order 
            <select name="confstrs[dgOttoOrderFolder]" size="1">
              <option value="" style="color: #000000;">alle</option>
              [{foreach from=$afolder key=field item=color}]
              <option value="[{$field}]" [{if $oOtto->getOttoParam('dgOttoOrderFolder') == $field}]SELECTED[{/if}]>[{oxmultilang ident=$field noerror=true}]</option>
              [{/foreach}]
	        </select> verschieben.
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <table>
          <tr>
            <td>Versandkostenset </td>
            <td>
              <select name="confstrs[dgOttoDeliveryset]" size="1">
                <option value="">- bitte w&auml;hlen -</option>
                [{foreach from=$oView->getDeliveryList() item=field}]
                  <option value="[{$field->oxid}]" [{if $oOtto->getOttoParam('dgOttoDeliveryset') == $field->oxid }]SELECTED[{/if}]>[{$field->name}]</option>
                [{/foreach}]
	          </select> verwenden
            </td>
          </tr>
          </table>
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <table>
          <tr>
            <td>Zahlungsart </td>
            <td>
              <select name="confstrs[dgOttoPayment]" size="1">
                <option value="">- bitte w&auml;hlen -</option>
                [{foreach from=$oView->getPaymentList() item=field}]
                  <option value="[{$field->oxid}]" [{if $oOtto->getOttoParam('dgOttoPayment') == $field->oxid }]SELECTED[{/if}]>[{$field->name}]</option>
                [{/foreach}]
	          </select> verwenden
            </td>
          </tr>
          </table>
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            Bestellbemerkung ([{$dgOttoLabel}] Bestellnummer)
            <select name="confstrs[dgOttoRemark]" size="1">
              <option value="1" [{if $oOtto->getOttoParam('dgOttoRemark') == "1" || !$oOtto->getOttoParam('dgOttoRemark')}]SELECTED[{/if}]>nicht eintragen</option>
              <option value="2" [{if $oOtto->getOttoParam('dgOttoRemark') == "2"}]SELECTED[{/if}]>eintragen</option>
	        </select>     
         </dt>
         <dd> </dd>
         <div class="spacer"></div>
      </dl> 
         <dl>
            <dt>
               <input type="text" size="5" name="confstrs[dgOttoSoapMaxSize]" value="[{$oOtto->getOttoParam('dgOttoSoapMaxSize')}]" /> 
            </dt>
            <dd> Anzahl der abzuholenden Bestellungen ( max. 100 )</dd>
            <div class="spacer"></div>
         </dl>
         <dl>
            <dt>              
               <input type="text" size="22" name="confstrs[dgOttoLastReportDate]" value="[{$oOtto->getOttoParam('dgOttoLastReportDate')}]" /> 
            </dt>
            <dd>( yyyy-mm-dd hh:mm:ss ) letztes Bestellberichtdatum</dd>
            <div class="spacer"></div>
         </dl>
          <dl>
            <dt>              
               <select name="confstrs[dgOttoReportAddTime]">
               [{section loop=49 name="desc"}]
               [{if $smarty.section.desc.index > 2}]
                  [{assign var="time" value=$smarty.section.desc.index*3600}]
				  <option value="[{$time}]" [{if $oOtto->getOttoParam('dgOttoReportAddTime') == $time}]SELECTED[{/if}]>[{$smarty.section.desc.index }] Std.</option>
                  [{/if}]
                [{/section}]
               </select> Zeitspanne f&uuml;r die Abholung der Bestellungen
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
         </dl>
      <dl>
      <dl>
        <dt>
          
          <button type="submit" name="save" onclick="showPleaseWait();">[{oxmultilang ident="GENERAL_SAVE"}]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>

<form name="dgOttoProviders" id="dgOttoProviders" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgOttoProviders" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "dgOttoProviders"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Bestellungen Versandkostensets </b></a>
       [{assign var="dgOttoProviders" value=$oOtto->getOttoParam('dgOttoProviders')}]
       [{foreach from=$oView->getDeliveryList() item=iOttoPayArt}]
       <dl>
        <dt>
            [{assign var="id" value=$iOttoPayArt->oxid}]       
            [{$iOttoPayArt->name}] in OXID als <select name="confarrs[dgOttoProviders][[{$id}]]" size="1">
            [{foreach from=$oOttoValues->getCarrier() item=iCarrier}]
            <option value="[{$iCarrier}]" [{if $iCarrier == $dgOttoProviders.$id}]SELECTED[{/if}]>[{$iCarrier }]</option>
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
          <button type="submit" name="save" onclick="showPleaseWait();">[{oxmultilang ident="GENERAL_SAVE"}]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>


<form name="dgOttoTracking" id="dgOttoTracking" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="dgOttoTracking" />
<input type="hidden" name="oxid" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editval[oxshops__oxid]" value="[{$oViewConf->getActiveShopId()}]" />
<input type="hidden" name="editlanguage" value="[{$editlanguage}]" />

<div class="groupExp">
   <div[{if $aStep == "dgOttoTracking"}] class="exp"[{/if}]>
      <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Einstellungen Versandmeldungen </b></a>
        <dl>
            <dt>              
               <select name="confstrs[dgOttoTrackingSystem]">           
				  <option value="order" [{if $oOtto->getOttoParam('dgOttoTrackingSystem') == 'order'}]SELECTED[{/if}]>Versandmeldung pro Bestellung</option>
                  <option value="article" [{if $oOtto->getOttoParam('dgOttoTrackingSystem') == 'article'}]SELECTED[{/if}]>Versandmeldung &uuml;ber Artikel</option>
               </select> 
            </dt>
            <dd> </dd>
            <div class="spacer"></div>
        </dl>
        <dl>
            <dt>
                <select name="confstrs[dgOttoTrackingRetourenId]" style="width:200px;">
                <option value="">nicht nutzen</option>
                 [{foreach from=$oView->getTable('oxorder') key=field item=desc}]
                 [{assign var="ident" value=$desc}]
                 [{assign var="ident" value=$ident|oxupper}]
                   <option value="[{$desc|lower }]" [{if $oOtto->getOttoParam('dgOttoTrackingRetourenId')|oxupper == $desc|oxupper}]SELECTED[{/if}]>[{$ident}]</option>
                 [{/foreach}]
                  </select> 
                  [{if !$oOtto->getOttoParam('dgOttoTrackingRetourenId')}]
            <button type="submit" name="save" onclick="this.form.fnc.value='createNewOrderField';showPleaseWait();">Datenbankfelder erstellen</button>
             [{/if}]
            </dt>
            <dd>
              Welches OXID (oxorder) Datenbankfeld soll f&uuml;r das <span style="color:#D4021D;font-weight: 800;font-size: 11px;">OTTO</span> Retouren Label genutzt werden ? 
            </dd>
            <div class="spacer"></div>
         </dl>
        [{if $oOtto->getOttoParam('dgOttoTrackingSystem') == 'order'}]
        <dl>
           <dt>  </dt>
           <dd>
             <small>bitte Komma - Trennung, bei mehr als einer Trackingnummer</small>
           </dd>
           <div class="spacer"></div>
        </dl> 
        [{/if}]
        [{if $oOtto->getOttoParam('dgOttoTrackingSystem') == 'article'}]
      <dl>
         <dt>
            <select name="confstrs[dgOttoTrackingCodeField]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|oxlower}]" [{if $oOtto->getOttoParam('dgOttoTrackingCodeField')|oxlower == $desc|oxlower}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower}]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgOttoLabel}] <b>Trackingnummer</b> genutzt werden ?
         </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <select name="confstrs[dgOttoTrackingSendDate]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|oxlower}]" [{if $oOtto->getOttoParam('dgOttoTrackingSendDate')|oxlower == $desc|oxlower}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower}]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgOttoLabel}] <b>Versanddatum</b> genutzt werden ? ( 0000-00-00 00:00:00 )
         </dd>
         <div class="spacer"></div>
      </dl> 
      <dl>
         <dt>
            <select name="confstrs[dgOttoTrackingProvider]" class="editinput" style="width:200px;">
              <option value="">nicht nutzen</option>
              [{foreach from=$oView->getTable('oxorderarticles') key=field item=desc}]
              [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
              [{assign var="ident" value=$ident|oxupper}]
                 <option value="[{$desc|oxlower}]" [{if $oOtto->getOttoParam('dgOttoTrackingProvider')|oxlower == $desc|oxlower}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:30:"..":true ident=$ident noerror=true alternative=$desc|oxlower}]</option>
              [{/foreach}]
             </select> 
         </dt>
         <dd>
            Welches OXID Datenbankfeld aus der bestellten Artikel Datenbank soll f&uuml;r die [{$dgOttoLabel}] <b>Logistikdienstleister </b> genutzt werden ?
         </dd>
         <div class="spacer"></div>
      </dl>
      
      [{/if}]
      <dl>
        <dt>
          <br/>
          <button type="submit" name="save" onclick="showPleaseWait();">[{oxmultilang ident="GENERAL_SAVE"}]</button>
        </dt>
        <dd> </dd>
        <div class="spacer"></div>
       </dl>   
   </div>
</div>
</form>

<div class="groupExp">
        <div [{if $aStep == "adminconfig"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Admin Einstellungen</b></a>
             <dl>
                <dt>
                   <form action="[{$oViewConf->getSelfLink()}]" method="post">
                   <input type="hidden" name="fnc" value="save" />
                   <input type="hidden" name="aStep" value="adminconfig" />
                   <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
                   <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
                   [{$oViewConf->getHiddenSid()}]
                   
                   Artikelfelder welche im Artikelreiter angezeigt werden sollen ( zb. oxstock, oxstockflag ):<br />
                   <textarea wrap="off" rows="4" cols="50" name="confstrs[dgOttoShowArticleFields]">[{$oOtto->getOttoParam('dgOttoShowArticleFields')|lower}]</textarea>
                   <br /><br />
                   
                   Ottoattribute welche im Artikelreiter inder Artikelliste angezeigt werden sollen: <br />

                   [{foreach from=$oOtto->getOttoParam('dgMoveAttribute2Toplist') key=aCatId item=aAttribute}]
                   [{foreach from=$aAttribute item=aAttr}]
                   - Kategorie [{$oView->getAttributeName($aCatId)}]: <a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&theme=[{$aCatId}]&attr=[{$aAttr}]&fnc=deleteAdminAttributefromArticleList&oxid=[{$oOtto->getShopId()}]&aStep=adminconfig" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'>[{$aAttr}]</a> wieder entfernen<br />
                   [{/foreach}]
                   [{/foreach}]
                   <br /><br />
                   
                   Ottoattribute wieder freischalten<br />
                   [{foreach from=$oOtto->getOttoParam('dgRemoveFromAttribute') key=aCatId item=aAttribute}]
                   [{foreach from=$aAttribute item=aAttr}]
                   - Kategorie [{$oView->getAttributeName($aCatId)}]: <a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&theme=[{$aCatId}]&attr=[{$aAttr}]&fnc=deleteAdminAttribute&oxid=[{$oOtto->getShopId()}]&aStep=adminconfig" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'>[{$aAttr}]</a> wieder freischalten<br />
                   [{/foreach}]
                   [{/foreach}]
                   <br /><br />
                   
                   Anzahl der anzuzeigenen Varianten:<br />
                   <input size="5" type="text" name="confstrs[dgOttoVariantListAmount]" value="[{$oOtto->getOttoParam('dgOttoVariantListAmount')}]" />
                   <br />
                   <br />
                   <input type="hidden" name="confbools[dgOttoDontShowArticleList]" value="false" />
                   <input  id="dgOttoDontShowArticleList" type="checkbox" name="confbools[dgOttoDontShowArticleList]" value="true"  [{if $oOtto->getOttoParam('dgOttoDontShowArticleList')}]checked[{/if}] /> <label for="dgOttoDontShowArticleList">Feld Export nicht in der Artikel&uuml;besicht anzeigen.</label>
                   
                    <br /><br />
                    
                    <input type="hidden" name="confbools[dgOttoDontShowOrderList]" value="false" />
                   <input id="dgOttoDontShowOrderList" type="checkbox" name="confbools[dgOttoDontShowOrderList]" value="true"  [{if $oOtto->getOttoParam('dgOttoDontShowOrderList')}]checked[{/if}] /> <label for="dgOttoDontShowOrderList">Feld Bestellherkunft nicht in der Bestell&uuml;bersicht Anzeigen</label>
                   
                    <br /><br />
                    
                   <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">speichern</button>
                   </form>
                </dt>
                
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
            [{if $oView->getAdminTemplateList()}]
            <dl>
                <dt>
                  <table>
                    [{foreach from=$oView->getAdminTemplateList() item=aTemplate}] 
                    [{assign var="theme" value= "AdminTheme"|cat:$aTemplate}]
                    [{if $oOtto->getOttoParam($theme)}]    
                     <tr>             
                     <td>Admin Attribute f&uuml;r Bereich &quot;[{$aTemplate}]&quot; zur&uuml;cksetzen. <br />
                     [{assign var="sUnits" value="\n"|explode:$oOtto->getOttoParam($theme)}]
                     <table>
                     [{foreach from=$oOtto->getOttoParam($theme) item=sUnit}]
                    <tr>
                      <td>[{$sUnit}]</td>
                      <td><a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&theme=[{$aTemplate}]&item=[{$sUnit}]&fnc=deleteAdminTemplateItem&oxid=[{$oOtto->getShopId()}]&aStep=adminconfig" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgotto','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                    </tr>
                     [{/foreach}]
                     </table>
                     </td>
                     <td valign="top"><a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&theme=[{$aTemplate}]&fnc=deleteAdminTemplate&oxid=[{$oOtto->getShopId()}]&aStep=adminconfig" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img src="[{$oViewConf->getModuleUrl('dgotto','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" border=0></a></td>
                     </tr>
                     [{/if}]
                    [{/foreach}]
                  </table>
                </dt>          
                <dd> &nbsp; </dd>
                <div class="spacer"></div>
            </dl>
            [{/if}]
            
         </div>
    </div>  
    
    <div class="groupExp">
        <div [{if $aStep == "automatic"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Automatisierung</b></a>
            <dl>
                <dt style="font-weight: normal;">
                  <form action="[{$oViewConf->getSelfLink()}]" method="post">
                  <input type="hidden" name="fnc" value="save" />
                  <input type="hidden" name="aStep" value="automatic" />
                  <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
                  <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
                  [{$oViewConf->getHiddenSid()}]

                  <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Admin Einstellungen</b></legend>
				  Exportiere pro Refresh <input size="3" type="text" name="confstrs[dgOttoRefresh]" value="[{$oOtto->getOttoParam('dgOttoRefresh')}]" /> Artikel
                  </fieldset>
                  <br />
                  <fieldset style="padding: 10px; width: 600px;">
                  <legend><b>Performace Einstellungen</b></legend>
				  Pro Cornjob werden Artikelpakete zu je <input size="3" type="text" name="confstrs[dgOttoCronMax]" value="[{$oOtto->getOttoParam('dgOttoCronMax')}]" /> Artikel erstellt.
                  <br />( im Augenblick befinden sich [{$warteschleife}] Artikel in der Warteschleife zum erstellen<br />
				  der Artikeldaten, und [{$sendewarteschleife}] Artikel k&ouml;nnten &uuml;bertragen werden. )<br />
                  <br />
                  <br />
       
                  jeder Cronjob hat <input size="3" type="text" name="confstrs[CronjobAddTimebasic]" value="[{$oOtto->getCronjobTime()}]" /> Sekunden Laufzeit zur Verf&uuml;gung.<br />
                  <hr />
                  <input type="hidden" name="confbools[dgOttoHoldLimitMail]" value="false" />
                  <input type="checkbox" name="confbools[dgOttoHoldLimitMail]" value="true"  [{if $oOtto->getOttoParam('dgOttoHoldLimitMail')}]checked[{/if}] />
                  Warnmail st&uuml;ndlich versenden wenn die wartende Artikelanzahl &uuml;ber <input size="3" type="text" name="confstrs[dgOttoHoldLimit]" value="[{$oOtto->getOttoParam('dgOttoHoldLimit')}]" /> Artikel ist.
                  
                  <hr />
                                    
                  <input size="20" type="text" name="confstrs[dgOttoExportDate]" value="[{$oOtto->getOttoParam('dgOttoExportDate')}]" /> letztes Datenbank Kontrolldatum.<br />
                  <hr />
                  
                  <br />
                  <input type="hidden" name="confbools[dgOttoNotSendProduct]" value="false" />
                  <input id="dgOttoNotSendProduct" type="checkbox" name="confbools[dgOttoNotSendProduct]" value="true"  [{if $oOtto->getOttoParam('dgOttoNotSendProduct')}]checked[{/if}] />
                  <label for="dgOttoNotSendProduct">keine Artikel Grunddaten exportieren.</label>
                  <br />
                   
                  <input type="hidden" name="confbools[dgOttoNotSendInventory]" value="false" />
                  <input id="dgOttoNotSendInventory" type="checkbox" name="confbools[dgOttoNotSendInventory]" value="true"  [{if $oOtto->getOttoParam('dgOttoNotSendInventory')}]checked[{/if}] />
                  <label for="dgOttoNotSendInventory">keinen Artikel Lagerbestand exportieren.</label>
                  <br />
                                                     
                  <input type="hidden" name="confbools[dgOttoNotSendTracking]" value="false" />
                  <input id="dgOttoNotSendTracking" type="checkbox" name="confbools[dgOttoNotSendTracking]" value="true"  [{if $oOtto->getOttoParam('dgOttoNotSendTracking')}]checked[{/if}] />
                  <label for="dgOttoNotSendTracking">keine Versandbest&auml;tigungen senden.</label>
                  <br />
                  
                  <input type="hidden" name="confbools[dgOttoNotImportOrder]" value="false" />
                  <input id="dgOttoNotImportOrder" type="checkbox" name="confbools[dgOttoNotImportOrder]" value="true"  [{if $oOtto->getOttoParam('dgOttoNotImportOrder')}]checked[{/if}] />
                  <label for="dgOttoNotImportOrder">keine Bestellungen Importieren.</label>
                  <br />
                  <br />
                  
				  <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">speichern</button>
                  </fieldset>
                  </form>
                </dt>
                <div class="spacer"></div>
            </dl>
             <dl>
                <dt>
                  <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Cronjob Url </b></legend>
                   [{if $oOtto->getOttoParam('dgOttoAltServerUrl') != ""}]
                      [{assign var="getSelfLink" value=$oOtto->getOttoParam('dgOttoAltServerUrl')}]
                   [{else}]
                     [{assign var="getSelfLink" value=".."}]
                   [{/if}]
                   <ul>
                   <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]" target="dynexport_do">[{$oOtto->getOttoParam('dgOttoAltServerUrl')}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]</a>
</ul>
                  </fieldset>
                </dt>
                <div class="spacer"></div>
            </dl>
            <dl>
			   <dt>	
                             
                 <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Cronjob Status</b></legend>
                   <iframe name="dynexport_do" marginwidth="0" marginheight="0" height="50" width="590" style="border: 1px solid #FFFFFF"
                       src="[{$oViewConf->getSelfLink()}]&cl=dgotto_do&sid=[{$oViewConf->getSessionId()}]"></iframe>
                 </fieldset>
			   </dt>
			   <dd> &nbsp; </dd>
			   <div class="spacer"></div>
            </dl>
            

         </div> 
    </div>
    
    <div class="groupExp">
        <div [{if $aStep == "automaticstatus"}] class="exp"[{/if}]>
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Automatisierung Status</b></a>
            <dl>
                <dt>
                  <form action="[{$oViewConf->getSelfLink()}]" method="post" onsubmit="showPleaseWait()">
                  <input type="hidden" name="fnc" value="" />
                  <input type="hidden" name="aStep" value="automaticstatus" />
                  <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
                  <input type="hidden" name="oxid" value="[{$oOtto->getShopId()}]" />
                  [{$oViewConf->getHiddenSid()}]
                  <fieldset style="padding: 10px; width: 600px;">
                   <legend><b>Zeitstempel der Cronjobs</b></legend>
				  <ul>
				     <li>[{if $oOtto->getOttoParam('dgOttoCronMysql')}][{$oOtto->getOttoParam('dgOttoCronMysql')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=mysql" target="_blank">Datenbank Kontrolle</a></li>
                     <li>[{if $oOtto->getOttoParam('dgOttoCronContoll')}][{$oOtto->getOttoParam('dgOttoCronContoll')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=controll" target="_blank">Status Pr&uuml;fung Artikel</a></li>
				     <li>[{if $oOtto->getOttoParam('dgOttoCronArticle')}][{$oOtto->getOttoParam('dgOttoCronArticle')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=article" target="_blank">Artikel erstellen</a></li>
				     <li>[{if $oOtto->getOttoParam('dgOttoCronSendArticle')}][{$oOtto->getOttoParam('dgOttoCronSendArticle')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=sendarticle" target="_blank">Artikel senden</a></li>
                     <li>[{if $oOtto->getOttoParam('dgOttoCronOrder')}][{$oOtto->getOttoParam('dgOttoCronOrder')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=order" target="_blank">Bestellungen verarbeiten</a></li>
                     <li>[{if $oOtto->getOttoParam('dgOttoCronTracking')}][{$oOtto->getOttoParam('dgOttoCronTracking')}][{else}]0000.00.00 00:00:00[{/if}] - <a href="[{$getSelfLink}]/index.php?cl=dgotto_cronjob&pass=[{$oOtto->getCronjobKey()}]&iPlace=[{$oOtto->getLocation()}]&shp=[{$oOtto->getShopId()}]&action=tracking" target="_blank">Versandbest&auml;tigungen</a></li>

                     [{if $oOtto->getOttoParam('dgOttoAutoStorno')}]
                       <li>[{if $oOtto->getOttoParam('dgOttoCronStorno')}][{$oOtto->getOttoParam('dgOttoCronStorno')}][{else}]0000.00.00 00:00:00[{/if}] - Stornos</li>
                     [{/if}]
                     [{if $oOtto->getOttoParam('dgOttoAutoRefund')}]
                       <li>[{if $oOtto->getOttoParam('dgOttoCronRefund')}][{$oOtto->getOttoParam('dgOttoCronRefund')}][{else}]0000.00.00 00:00:00[{/if}] - Retouren</li>
                     [{/if}]
				  </ul>
				  <br />
                  <button type="submit" class="edittext" name="save" onclick="showPleaseWait();">aktualisieren</button>
                  </fieldset>
                  </form>
                </dt>
            </dl>
            <dl>
			   <dt>	                                       
			   </dt>
			   <dd> &nbsp; </dd>
			   <div class="spacer"></div>
            </dl>
         </div>
    </div>


[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
