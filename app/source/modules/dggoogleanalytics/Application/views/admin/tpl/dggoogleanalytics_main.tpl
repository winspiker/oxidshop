[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign }]

<script type="text/javascript">
<!--

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

.box {
  background-image: url('https://update.draufgeschaut.de/img/dg.gif');
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
   background: url('[{ $oViewConf->getModuleUrl('dggoogleanalytics','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
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

.dg { width: 24px;
      height: 24px;
      border: 1px solid #363431;
      padding: 1px 1px 1px 1px;
      background-color: #D1D2D2
}

.dgInput{
    width: 160px;
}

.dgInputColor{
    width: 150px;
}

div dt {
    font-weight:normal;
}

.groupExp a.rc:hover b, .groupExp .exp a.rc b {
    color: #CC0000;
}
-->
</style>
[{ if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]
[{assign var="google" value='<b><font face="Arial"><font color="#0033CC">G</font><font color="#CC0000">o</font><font color="#FFCC00">o</font><font color="#0033CC">g</font><font color="#006600">l</font><font color="#CC0000">e</font></font></b>'}]
[{cycle assign="_clear_" values=",2" }]


<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>

    
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="1" /> 
   
   <div onclick="hidePleaseWait()" id="pleasewaiting"></div>
   <div class="groupExp">
        <div[{if $iStep == 1 }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Google Analytics - Einstellungen</b></a>
             <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleAnalyticsActive]" value="false" />
                    <input id="dgGoogleAnalyticsActive" type="checkbox" name="confbools[dgGoogleAnalyticsActive]" value="true"  [{if ($confbools.dgGoogleAnalyticsActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleAnalyticsActive">[{$google}] Analytics aktivieren.</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                    <input id="dgGoogleEcommerceActive" type="radio" name="confstrs[dgGoogleEcommerceType]" value="1"  [{if $confstrs.dgGoogleEcommerceType == 1}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleEcommerceActive">[{$google}] eCommerce - Daten &uuml;bertragen.</label>
                    [{ oxinputhelp ident="dgGoogleEcommerceActive" }]
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                    <input id="dgGoogleEnhancedEcommerceActiv" type="radio" name="confstrs[dgGoogleEcommerceType]" value="2"  [{if $confstrs.dgGoogleEcommerceType == 2 || !$confstrs.dgGoogleEcommerceType }]checked[{/if}] >
                </dt>
                <dd>
                   <label for="dgGoogleEnhancedEcommerceActiv"> [{$google}] Erweiterte E-Commerce-Berichte &uuml;bertragen.</label>
                    [{ oxinputhelp ident="dgGoogleEnhancedEcommerceActiv" }]
                </dd>
                <div class="spacer"></div>
            </dl>
            [{if $confstrs.dgGoogleEcommerceType == 2 }]
            <dl>
                <dt>
                    <input type="hidden" name="confbools[dgGoogleAnalyticsJsLoad]" value="false" />
                    <input id="dgGoogleAnalyticsJsLoad" type="checkbox" name="confbools[dgGoogleAnalyticsJsLoad]" value="true"  [{if ($confbools.dgGoogleAnalyticsJsLoad)}]checked[{/if}] >
                </dt>
                <dd>
                   <label for="dgGoogleAnalyticsJsLoad"> Jquery Lib nicht extra einbinden.</label>
                    [{ oxinputhelp ident="dgGoogleAnalyticsJsLoad" }]
                </dd>
                <div class="spacer"></div>
            </dl>
            
            [{/if}]
            <dl>
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleAnalyticsGoogleId]" value="[{ $confstrs.dgGoogleAnalyticsGoogleId }]" />
                </dt>
                <dd>
                    [{$google}] Analytics Web-Property-ID ( z.B.: UA-XXXXXX-X ) 
                    [{ oxinputhelp ident="dgGoogleAnalyticsGoogleId" }]
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleAnalyticsDomain]" value="[{ $confstrs.dgGoogleAnalyticsDomain }]" />
                </dt>
                <dd>
                    [{$google}] Domain Name ( z.B. : ihredomain.de ) 
                    [{ oxinputhelp ident="dgGoogleAnalyticsDomain" }]
                </dd>
                <div class="spacer"></div>
            </dl>
            [{ if $confstrs.dgGoogleAnalyticsDomain }]
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleDomainAllways]" value="false" />
                   <input id="dgGoogleDomainAllways" type="checkbox" name="confbools[dgGoogleDomainAllways]" value="true"  [{if ($confbools.dgGoogleDomainAllways)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleDomainAllways">[{$google}] Domain Name auch au&szlig;erhalb des Bestellprozesses anwenden. </label>
                </dd>
                <div class="spacer"></div>
            </dl>
            [{/if}]
            <dl>
                <dt>
                  <input type="hidden" name="confbools[dgGoogleDisableButton]" value="false" />
                  <input id="dgGoogleDisableButton" type="checkbox" name="confbools[dgGoogleDisableButton]" value="true"  [{if ($confbools.dgGoogleDisableButton)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleDisableButton">[{$google}] Abmelden Script nutzen. </label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleDisableLink]" value="false" />
                   <input id="dgGoogleDisableLink" type="checkbox" name="confbools[dgGoogleDisableLink]" value="true"  [{if ($confbools.dgGoogleDisableLink)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleDisableLink">[{$google}] Abmelden Button anzeigen. </label>
                </dd>
                <div class="spacer"></div>
            </dl>
            [{if ($confbools.dgGoogleDisableLink)}]
            [{foreach from=$languages item=lang}]
            <dl>
                <dt> </dt>
                <dd>
                    Text [{$google}] Abmelden Button ([{ $lang->name }])<br />
                    [{assign var="aFieldName" value="dgGoogleDisableButtonText"|cat:$lang->abbr}]
				   <input size="50" type="text" name="confstrs[[{$aFieldName}]]" value="[{ $confstrs.$aFieldName|default:"Klicken Sie hier, um Google Analytics zu deaktivieren." }]" /> <br />
                   Erflogsmeldung [{$google}] Abmelden Button ([{ $lang->name }])<br />
                    [{assign var="aFieldName" value="dgGoogleDisableButtonSuccess"|cat:$lang->abbr}]
				   <input size="50" type="text" name="confstrs[[{$aFieldName}]]" value="[{ $confstrs.$aFieldName|default:"Google Analytics wurde deaktiviert." }]" /> <br />
                </dd>
                <div class="spacer"></div>
            </dl>
           [{/foreach}]  
           [{/if}] 
            [{*
            <dl>
                <dt><input type="hidden" name="confbools[dgGoogleTrackAllLinks]" value="false" /><input type="checkbox" name="confbools[dgGoogleTrackAllLinks]" value="true"  [{if ($confbools.dgGoogleTrackAllLinks)}]checked[{/if}] >
                </dt>
                <dd>
                    [{$google}] Tracking &uuml;ber jQuery auf Links anwenden. 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt><input type="hidden" name="confbools[dgGoogleTrackAllButton]" value="false" /><input type="checkbox" name="confbools[dgGoogleTrackAllButton]" value="true"  [{if ($confbools.dgGoogleTrackAllButton)}]checked[{/if}] >
                </dt>
                <dd>
                    [{$google}] Tracking &uuml;ber jQuery auf Buttons anwenden. 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt><input type="hidden" name="confbools[dgGoogleTrackAllForms]" value="false" /><input type="checkbox" name="confbools[dgGoogleTrackAllForms]" value="true"  [{if ($confbools.dgGoogleTrackAllForms)}]checked[{/if}] >
                </dt>
                <dd>
                    [{$google}] Tracking &uuml;ber jQuery auf Formulare anwenden. 
                </dd>
                <div class="spacer"></div>
            </dl>
            *}]
            <dl>
                <dt></dt>
                <dd><button type="submit"  onclick="showPleaseWait();">speichern</button></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form> 
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="2" /> 
    
   <div class="groupExp">
        <div[{if $iStep == 2 }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Google AdWords - Einstellungen</b></a>
			 <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleAddWordActive]" value="false" />
                   <input id="dgGoogleAddWordActive" type="checkbox" name="confbools[dgGoogleAddWordActive]" value="true"  [{if ($confbools.dgGoogleAddWordActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleAddWordActive"><font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleAddWordAllwayActive]" value="false" />
                   <input id="dgGoogleAddWordAllwayActive" type="checkbox" name="confbools[dgGoogleAddWordAllwayActive]" value="true"  [{if ($confbools.dgGoogleAddWordAllwayActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleAddWordAllwayActive"><font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> aktivieren aus jeder Seite einblenden, nicht nur im Bestellprozess</label>
                </dd>
                <div class="spacer"></div>
            </dl>
             <dl>
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleAdwordsConversionId]" value="[{ $confstrs.dgGoogleAdwordsConversionId }]" class="dgInput" />
                </dt>
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> Conversion ID ( z.B.: XXXXXXXXXXX ) 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleAdwordssConversionLabel]" value="[{ $confstrs.dgGoogleAdwordssConversionLabel }]" class="dgInput" />
                </dt>
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> Conversion Label. 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleAdwordsCoversationVal]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
					 <option [{ if $confstrs.dgGoogleAdwordsCoversationVal == "0" }]selected[{/if}] value="0">keine Werte</option>
				     <option [{ if $confstrs.dgGoogleAdwordsCoversationVal == "1" }]selected[{/if}] value="1">Warenkorb Summe</option>
                   </select>
                </dt>                
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> Conversion Value &uuml;bergeben.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleAdwordsLanguage]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
					 [{foreach from=$language key=iso item=lang}]
				     <option [{ if $confstrs.dgGoogleAdwordsLanguage == $iso }]selected[{/if}] value="[{$iso}]">[{$lang}]</option>
				     [{/foreach}]
                   </select>
                </dt>                
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> Sprache der Seite.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   #<input size="23" type="text" name="confstrs[dgGoogleAdwordsColor]" value="[{ if $confstrs.dgGoogleAdwordsColor }][{ $confstrs.dgGoogleAdwordsColor }][{else}]FFFFFF[{/if}]" class="dgInputColor" />
                </dt>
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">ADWORDS</font> Hintergrundfarbe der Webseite. 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="3" /> 
   
   <div class="groupExp">
        <div[{if $iStep == 3 }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Google ReMarketing Einstellungen</b></a>
			 <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleRemarketingActive]" value="false" />
                   <input id="dgGoogleRemarketingActive" type="checkbox" name="confbools[dgGoogleRemarketingActive]" value="true"  [{if ($confbools.dgGoogleRemarketingActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleRemarketingActive"><font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
             <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleReMarketingId]" value="[{ $confstrs.dgGoogleReMarketingId }]" class="dgInput" />
                </dt>
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> Conversion ID ( z.B.: XXXXXXXXXXX ) 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleReMarketingLabel]" value="[{ $confstrs.dgGoogleReMarketingLabel }]" class="dgInput" />
                </dt>
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> Conversion Label.  
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleReMarketValue]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
					 <option [{ if $confstrs.dgGoogleReMarketValue == "0" }]selected[{/if}] value="0">keine Werte</option>
				     <option [{ if $confstrs.dgGoogleReMarketValue == "1" }]selected[{/if}] value="1">Warenkorb Summe</option>
                   </select>
                </dt>                
                <dd>
                    <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> Conversion Value &uuml;bergeben.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleReMarketingLanguage]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
					 [{foreach from=$language key=iso item=lang}]
				     <option [{ if $confstrs.dgGoogleReMarketingLanguage == $iso }]selected[{/if}] value="[{$iso}]">[{$lang}]</option>
				     [{/foreach}]
                   </select>
                </dt>                
                <dd>
                     <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> Sprache der Seite.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   #<input size="23" type="text" name="confstrs[dgGoogleReMarketingColor]" value="[{ if $confstrs.dgGoogleReMarketingColor }][{ $confstrs.dgGoogleReMarketingColor }][{else}]FFFFFF[{/if}]" class="dgInputColor" />
                </dt>
                <dd>
                     <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> Hintergrundfarbe der Webseite. 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleReMarketingShow]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
				     <option [{ if $confstrs.dgGoogleReMarketingShow == "1" }]selected[{/if}] value="1">einmal pro Besucher</option>
                     <option [{ if $confstrs.dgGoogleReMarketingShow == "2" }]selected[{/if}] value="2">auf allen Seiten</option>
                     <option [{ if $confstrs.dgGoogleReMarketingShow == "3" }]selected[{/if}] value="3">alle Seiten, kein Bestellprozess</option>
                   </select>
                </dt>                
                <dd>
                     <font color="#838383" face="Arial Rounded MT Bold">REMARKETING</font> anwenden.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="gtm" /> 
   
   <div class="groupExp">
        <div[{if $iStep == "gtm" }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Google Tag Manager Einstellungen</b></a>
			 <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleTagManagerActive]" value="false" />
                   <input id="dgGoogleTagManagerActive" type="checkbox" name="confbools[dgGoogleTagManagerActive]" value="true"  [{if ($confbools.dgGoogleTagManagerActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleTagManagerActive">Google Tag Manager aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   
                </dt>
                <dd>
                  &nbsp; &nbsp; 
                   <input type="hidden" name="confbools[dgGoogleGTMRemarketingActive]" value="false" />
                   <input id="dgGoogleGTMRemarketingActive" type="checkbox" name="confbools[dgGoogleGTMRemarketingActive]" value="true"  [{if ($confbools.dgGoogleGTMRemarketingActive)}]checked[{/if}] >
                    <label for="dgGoogleGTMRemarketingActive">Remarketing Paramter im GTM &uuml;bergeben </label>
                </dd>
                <div class="spacer"></div>
            </dl>
             <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleTagManagerId]" value="[{ $confstrs.dgGoogleTagManagerId }]" class="dgInput" />
                </dt>
                <dd>
                     Container-ID ( z.B.: GTM-XXXXXX ) 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="GoogleOptimize" /> 
   
   <div class="groupExp">
        <div[{if $iStep == "GoogleOptimize" }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Google Optimize Einstellungen</b></a>
			 <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleOptimizeActive]" value="false" />
                   <input id="dgGoogleOptimizeActive" type="checkbox" name="confbools[dgGoogleOptimizeActive]" value="true"  [{if ($confbools.dgGoogleTagManagerActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleOptimizeActive">Google Optimize aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
             <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgGoogleAnalyticsTMGId]" value="[{ $confstrs.dgGoogleAnalyticsTMGId }]" class="dgInput" />
                </dt>
                <dd>
                     Container-ID zur Verbindung zu Analytics
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="facebook" /> 
   
   <div class="groupExp">
        <div[{if $iStep == "facebook" }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Facebook Pixel Einstellungen</b></a>
			 <dl>
                <dt>
                   <input type="hidden" name="confbools[dgFaceBookRemaketingActive]" value="false" />
                   <input id="dgFaceBookRemaketingActive" type="checkbox" name="confbools[dgFaceBookRemaketingActive]" value="true"  [{if ($confbools.dgFaceBookRemaketingActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgFaceBookRemaketingActive">Facebook PIXEL / REMARKETING aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgFaceBookRemaketingSmallActive]" value="false" />
                   <input id="dgFaceBookRemaketingSmallActive" type="checkbox" name="confbools[dgFaceBookRemaketingSmallActive]" value="true"  [{if ($confbools.dgFaceBookRemaketingSmallActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgFaceBookRemaketingSmallActive">Facebook PIXEL ViewContent nur auf der Detailseite und im Bestellprozess nutzen</label>
                </dd>
                <div class="spacer"></div>
            </dl>
             <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgFaceBookReMarketingId]" value="[{ $confstrs.dgFaceBookReMarketingId }]" class="dgInput" />
                </dt>
                <dd>
                     Facebook REMARKETING Nutzer ID ( z.B.: XXXXXXXXXXX ) 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select class="dgInput" name="confstrs[dgFaceBookLocale]" size="1">
                     [{foreach from=$oView->getTrankingLocale() key=iOut item=iLocale }]
                     <option value="[{$iLocale}]" [{if $confstrs.dgFaceBookLocale == $iLocale}] selected[{/if}]>[{$iLocale}] ( [{$iOut}] )</option>
                     [{/foreach}]
                   </select>
                </dt>
                <dd>
                    Lokale Position des Shops.
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="bing" /> 
   
   <div class="groupExp">
        <div[{if $iStep == "bing" }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>BING Tracking Einstellungen</b></a>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgBingOrderActive]" value="false" />
                   <input id="dgBingOrderActive" type="checkbox" name="confbools[dgBingOrderActive]" value="true"  [{if ($confbools.dgBingOrderActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgBingOrderActive">BING Bestelltracking aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>             
            <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgBingOrderId]" value="[{ $confstrs.dgBingOrderId }]" class="dgInput" />
                </dt>
                <dd>
                     BING TAG ID ( z.B.: XXXXXXXXXXX ) 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="criteo" /> 
   <div class="groupExp">
        <div[{if $iStep == "criteo" }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Criteo Tracking Einstellungen</b></a>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgCriteoActive]" value="false" />
                   <input id="dgCriteoActive" type="checkbox" name="confbools[dgCriteoActive]" value="true"  [{if ($confbools.dgCriteoActive)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgCriteoActive">Criteo Tracking aktivieren</label>
                </dd>
                <div class="spacer"></div>
            </dl>             
            <dl>                                                             
                <dt>
                   <input size="25" type="text" name="confstrs[dgCriteoAccountid]" value="[{ $confstrs.dgCriteoAccountid }]" class="dgInput" />
                </dt>
                <dd>
                     Criteo ACCOUNT ID 
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgCriteoProductId]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
				     [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                     [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                     [{assign var="ident" value=$ident|oxupper }]
                      <option value="oxarticles__[{ $desc|oxlower }]" [{ if $confstrs.dgCriteoProductId == "oxarticles__"|cat:$desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:20:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                     [{/foreach}]
                   </select>
                </dt>                
                <dd>
                    als Kenzeichner f&uuml;r die Artikel nutzen.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();" /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form>
   
   <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
   [{ $oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
   <input type="hidden" name="fnc" value="save" />
   <input type="hidden" name="oxid" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oViewConf->getActiveShopId() }]">
   <input type="hidden" name="updatenav" value="">
   <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
   <input type="hidden" name="iStep" value="4" /> 
    
   <div class="groupExp">
        <div[{if $iStep == 4 }] class="exp"[{/if}]> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Shop - Einstellungen</b></a>
            <dl>
                <dt>
                   <input type="hidden" name="confbools[dgGoogleAnalyticsShowTitle]" value="false" />
                   <input id="dgGoogleAnalyticsShowTitle" type="checkbox" name="confbools[dgGoogleAnalyticsShowTitle]" value="true"  [{if ($confbools.dgGoogleAnalyticsShowTitle)}]checked[{/if}] >
                </dt>
                <dd>
                    <label for="dgGoogleAnalyticsShowTitle">den Shop Seitentitel an Analytics &uuml;bermitteln.</label>
                </dd>
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleAnalyticsProductId]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
				     [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                     [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                     [{assign var="ident" value=$ident|oxupper }]
                      <option value="oxarticles__[{ $desc|oxlower }]" [{ if $confstrs.dgGoogleAnalyticsProductId == "oxarticles__"|cat:$desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:20:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                     [{/foreach}]
                   </select>
                </dt>                
                <dd>
                    als Id Kenzeichner f&uuml;r die Artikel nutzen.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleAnalyticsArtLabel]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
                     [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                     [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
                     [{assign var="ident" value=$ident|oxupper }]
                      <option value="oxarticles__[{ $desc|oxlower }]" [{ if $confstrs.dgGoogleAnalyticsArtLabel == "oxarticles__"|cat:$desc|oxlower }]SELECTED[{/if}]>[{ oxmultilang|oxtruncate:20:"..":true ident=$ident noerror=true alternative=$desc }]</option>
                     [{/foreach}]
                   </select>
                </dt>                
                <dd>
                    als Name Kenzeichner f&uuml;r die Artikel nutzen.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            <dl>
                <dt>
                   <select name="confstrs[dgGoogleAnalyticsCatId]" size="1" class="dgInput">
                     <option value=""> - bitte w&auml;hlen - </option>
				     <option [{ if $confstrs.dgGoogleAnalyticsCatId == "oxcategories__oxsort" }]selected[{/if}] value="oxcategories__oxsort">Kategorien Sortiernummer</option>
                     <option [{ if $confstrs.dgGoogleAnalyticsCatId == "oxcategories__oxtitle" }]selected[{/if}] value="oxcategories__oxtitle">Kategorien Bezeichnung</option>
                   </select>
                </dt>                
                <dd>
                    als Kenzeichner f&uuml;r die Kategorien nutzen.  
                </dd>                                                      
                <div class="spacer"></div>
            </dl>
            
            <dl>
                <dt></dt>
                <dd><input type="submit" value="speichern"  onclick="showPleaseWait();"  /></dd>
                <div class="spacer"></div>
            </dl>
         </div>
    </div>
   </form> 
   
   
   
    <div class="groupExp">
        <div> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Installation</b></a>                  
            <dl>
                <dt>
                   <br />
                   <u>Einbau des Moduls in die Templates, dies ist nur n&ouml;tig f&uuml;r Shop Versionen die kleiner als die Version 4.6.x sind</u><br />
                   <br />&ouml;ffnen Sie folgende Templates:<br>
                   <ol>
                     <li>[{$sTemplateUrl}]layout/base.tpl ( OXID Azure Templatesatz )</li>
                     <li>[{$sTemplateUrl}]_footer.tpl ( OXID Basic Templatesatz bis Version 4.4 )</li>
                   </ol>
                   <br />
                   suchen Sie folgenden Code:
                   <pre style="background: #ffffff; border: 1px inset; padding: 6px 6px 6px 6px; margin: 0px; width: 480px; height: 16px; overflow: auto; " dir="ltr"> &lt;/body&gt; </pre>
                   <br />
                   ersetzen den gefundenen Code mit folgenden Code:
                   <pre style="background: #ffffff; border: 1px inset; padding: 6px 6px 6px 6px; margin: 0px; width: 480px; height: 42px; overflow: auto; " dir="ltr"> &#91;&#123; insert name=&quot;google_analytics&quot; position=&quot;bottom&quot; &#125;&#93; <br />&lt;/body&gt; </pre>
                   
                   <ol>
                     <li>[{$sTemplateUrl}]layout/base.tpl ( OXID Azure Templatesatz )</li>
                     <li>[{$sTemplateUrl}]_header.tpl ( OXID Basic Templatesatz bis Version 4.4 )</li>
                   </ol>
                   <br />
                   suchen Sie folgenden Code:
                   <pre style="background: #ffffff; border: 1px inset; padding: 6px 6px 6px 6px; margin: 0px; width: 480px; height: 16px; overflow: auto; " dir="ltr"> &lt;/head&gt; </pre>
                   <br />
                   ersetzen den gefundenen Code mit folgenden Code:
                   <pre style="background: #ffffff; border: 1px inset; padding: 6px 6px 6px 6px; margin: 0px; width: 480px; height: 42px; overflow: auto; " dir="ltr"> &#91;&#123; insert name=&quot;google_analytics&quot; position=&quot;top&quot; &#125;&#93; <br />&lt;/head&gt; </pre>

                   
                </dt>
                <dd> </dd>
                <div class="spacer"></div>
            </dl>                     
         </div>
    </div>
    
   
    <div class="groupExp">
        <div> 
            <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Hilfe zu Zielen</b></a>                  
            <dl>
                <dt>Vorlage zur Erstellung eines Zieles f&amp;uuml;r den Bestellprozess:<br />
                hinterlegen Sie unter Google Analytics ein Ziel mit diesen Werten, f&uuml;llen Sie nur die Felder so aus wie sie hier angegeben sind.
                 <table>
	<tr>
		<td>Zielname: </td>
		<td colspan="2"><input value="Schritt 5 / Bestellung" maxlength="255" name="T1" size="60"></td>
	</tr>
	<tr>
		<td>Zieltyp: </td>
		<td colspan="2"><input checked type="radio"><label>URL-Ziel</label></td>
	</tr>

	<tr>
		<td>Keyword-Option: </td>
		<td colspan="2"><select><option selected value="head">&Uuml;bereinstimmung mit Head</option>	</option></select></td>
	</tr>
	<tr>
		<td>Ziel-URL: </td>
		<td colspan="2"><input value="/Bestaetigung" size="105"></td>
	</tr>
	<tr>
		<td>Schritt 1: </td>
		<td><input value="/Warenkorb" size="60"></td>
		<td><input value="Warenkorb" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 2: </td>
		<td><input value="/Benutzeranmeldung &Uuml;bersicht" size="60"></td>
		<td><input value="Benutzeranmeldung &Uuml;bersicht" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 3: </td>
		<td><input value="/Benutzeranmeldung - Einkaufen ohne Registrierung" size="60"></td>
		<td><input value="Benutzeranmeldung - Einkaufen ohne Registrierung" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 4: </td>
		<td><input value="/Benutzeranmeldung - Ich bin bereits Kunde" size="60"></td>
		<td><input value="Benutzeranmeldung - Ich bin bereits Kunde" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 5: </td>
		<td><input value="/Benutzeranmeldung - Pers&ouml;nliches Kunden-Konto er&ouml;ffnen" size="60"></td>
		<td><input value="Benutzeranmeldung - Pers&ouml;nliches Kunden-Konto er&ouml;ffnen" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 6: </td>
		<td><input value="/Zahlungsarten" size="60"></td>
		<td><input value="Zahlungsarten" size="60"></td>
	</tr>
	<tr>
		<td>Schritt 7: </td>
		<td><input value="/Bestelluebersicht" size="60"></td>
		<td><input value="Bestelluebersicht" size="60"></td>
	</tr>
</table>
<br /><br />

                   
                </dt>
                <dd> </dd>
                <div class="spacer"></div>
            </dl>                     
         </div>
    </div>

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]