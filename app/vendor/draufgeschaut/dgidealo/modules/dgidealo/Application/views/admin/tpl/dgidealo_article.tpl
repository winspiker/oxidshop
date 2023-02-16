[{include file="headitem.tpl" title="draufgeschaut? MyPackage Modul Kategorienvervwaltung"}]
<script type="text/javascript">
<!--
if (parent.parent != null && parent.parent.setTitle )
{   parent.parent.sShopTitle   = "[{$actshopobj->oxshops__oxname->value}]";
    parent.parent.sMenuItem    = "draufgeschaut?";
    parent.parent.sMenuSubItem = "OXID eShop to Rakuten";
    parent.parent.sWorkArea    = "Kategorienvervwaltung";
    parent.parent.setTitle();
}

[{ if $updatelist == 1}]
    UpdateList('[{ $oxid }]');
[{ /if}]   

function editThis( sID )
{
    var oTransfer = top.basefrm.edit.document.getElementById( "transfer" );
    oTransfer.oxid.value = sID;
    oTransfer.cl.value = top.basefrm.list.sDefClass;

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();

    var oSearch = top.basefrm.list.document.getElementById( "search" );
    [{if !$oxparentid}]oSearch.oxid.value = sID;[{else}]oSearch.oxid.value = '[{ $oxparentid }]';[{/if}]
    oSearch.actedit.value = 0;
    oSearch.submit();
}

function editVariant( sID )
{
    var oTransfer = top.basefrm.edit.document.getElementById( "transfer" );
    oTransfer.oxid.value = sID;
    oTransfer.cl.value = 'article_variant';

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();

    var oSearch = top.basefrm.list.document.getElementById( "search" );
    [{if !$oxparentid}]oSearch.oxid.value = sID;[{else}]oSearch.oxid.value = '[{ $oxparentid }]';[{/if}]
    oSearch.submit();
}

function editIdealo( sID )
{
    var oTransfer = top.basefrm.edit.document.getElementById( "transfer" );
    oTransfer.oxid.value = sID;
    oTransfer.cl.value = 'dgidealo_article';

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();

    var oSearch = top.basefrm.list.document.getElementById( "search" );
    [{if !$oxparentid}]oSearch.oxid.value = sID;[{else}]oSearch.oxid.value = '[{ $oxparentid }]';[{/if}]
    oSearch.submit();
}

[{if !$oxparentid}]
window.onload = function ()
{
    [{ if $updatelist == 1}]
        top.oxid.admin.updateList('[{ $oxid }]');
    [{ /if}]
}
[{/if}]                                   

function UpdateList( sID)
{
    var oSearch = parent.list.document.getElementById("search");
    oSearch.oxid.value=sID;
    oSearch.submit();
}
function SetSticker( sStickerId, oObject)
{
    if ( oObject.selectedIndex != -1)
    {   oSticker = document.getElementById(sStickerId);
        oSticker.style.display = "";
        oSticker.style.backgroundColor = "#FFFFCC";
        oSticker.style.borderWidth = "1px";
        oSticker.style.borderColor = "#000000";
        oSticker.style.borderStyle = "solid";
        oSticker.innerHTML         = oObject.item(oObject.selectedIndex).innerHTML;
    }
    else
        oSticker.style.display = "none";
}

function _groupExp(el) {
    var _cur = el.parentNode;

    if (_cur.className == "exp") _cur.className = "";
      else _cur.className = "exp";
}                                   

function showPleaseWait()
{
     var mask = document.getElementById("pleasewaiting");
     var winW = document.getElementById("pleasewaiting").offsetWidth;
     var winH = document.getElementById("pleasewaiting").offsetHeight
     
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

function _checkAll( obj, pref ) 
{
   var inputs = document.getElementsByTagName("input");
   for (var i=0;i<inputs.length; i=i+1) 
   {
      if(inputs[i].type == 'checkbox' && inputs[i].checked != obj.checked && pref == inputs[i].name.split('[')[2] )
      {
         inputs[i].checked = obj.checked;
      }
   }
}
//-->
</script>
<style>
<!--

.box {
  background-image: url('https://www.draufgeschaut.de/img/dg.gif?[{$smarty.now}]');
  background-repeat: no-repeat;
  background-position: right bottom;
}

div#pleasewaiting{
   background: url('[{ $oViewConf->getModuleUrl('dgidealo','out/admin/img/loading-bar.gif') }]') no-repeat 50% 50%;
   z-index: 50;
   position: absolute;
   top: 0px;
   left: 0px;
   width: 100%;
   height: 100%;
   background-color: rgb(255, 255, 255);
   opacity: 0.3;
   visibility: hidden; 
}

.big         { width: 200px;  }
.medium      { width: 100px;  }
.small       { width: 50px;  }
.attribute   { float: left; width: 49%; vertical-align: bottom; height: inherit;}
.left        { float: left; width: 50%; height: 100%;vertical-align: bottom;}
.right       { float: right; width: 50%; height: 100%; vertical-align: bottom;}

.direktkaufpic, .dgIdealoLokalesInventarPicture { width: 1.2em; height: 1.2em; padding: 0px 2px 0px 2px;}
.direktkaufcart { fill: #0771d0;}
.direktkaufspeed { fill: #f60;}

-->
</style>

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" id="oxid" value="[{ $oxid }]" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />
</form>

[{ if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{ if $readonly_fields }]
    [{assign var="readonly_fields" value="readonly disabled"}]
[{else}]
    [{assign var="readonly_fields" value=""}]
[{/if}]

[{assign var="dgIdealoLabel" value='dgidealo_order'|oxmultilangassign}]
[{capture name="dgIdealoFirektKaufPicture"}]
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" class="direktkaufpic">
  <path class="direktkaufcart" d="M 26.2 23 c -1.3 0 -2.7 1.1 -3.1 2.5 c -0.4 1.4 0.4 2.5 1.7 2.5 c 1.3 0 2.7 -1.1 3.1 -2.5 c 0.4 -1.4 -0.4 -2.5 -1.7 -2.5 Z M 15.2 23 c -1.3 0 -2.7 1.1 -3.1 2.5 c -0.4 1.4 0.4 2.5 1.7 2.5 s 2.7 -1.1 3.1 -2.5 c 0.4 -1.4 -0.4 -2.5 -1.7 -2.5 Z M 30.1 7 h -12 c -0.4 0 -0.6 -0.5 -0.5 -0.9 l 0.2 -1.4 c 0.1 -0.3 -0.3 -0.7 -0.6 -0.7 h -3.9 c -0.3 0 -0.6 0.2 -0.6 0.5 l -0.2 1.2 c 0 0.4 0.2 0.7 0.6 0.7 h 1 c 0.4 0 0.7 0.3 0.6 0.7 l -1.6 12.3 c -0.3 1.5 0.4 2.6 1.8 2.6 h 13.7 c 0.3 0 0.6 -0.3 0.6 -0.6 l 0.2 -1.6 c 0.1 -0.4 -0.2 -0.7 -0.6 -0.7 H 16.4 c -0.3 0 -0.5 -0.3 -0.5 -0.6 c 0.1 -0.5 0.1 -0.7 0.1 -1 c 0 -0.3 0.3 -0.5 0.6 -0.5 h 10.3 c 1.6 0 2.7 -0.2 2.9 -1.3 c 0 0 0.9 -6.5 1.1 -7.5 c 0.2 -0.8 0 -1.2 -0.8 -1.2 Z M 16.2 14.6 v 0 Z" />
  <path class="direktkaufspeed" d="M 12 10.5 c 0 0.8 -0.7 1.5 -1.5 1.5 h -3 c -0.8 0 -1.5 -0.7 -1.5 -1.5 S 6.7 9 7.5 9 h 3 c 0.8 0 1.5 0.7 1.5 1.5 Z M 11 15.5 c 0 0.8 -0.7 1.5 -1.5 1.5 h -7 c -0.8 0 -1.5 -0.7 -1.5 -1.5 S 1.7 14 2.5 14 h 7 c 0.8 0 1.5 0.7 1.5 1.5 Z" />
</svg>
[{/capture}]
[{capture name="dgIdealoLokalesInventarPicture"}]iVBORw0KGgoAAAANSUhEUgAAAH0AAABxCAYAAAD4QqxeAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyxpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDIxIDc5LjE1NDkxMSwgMjAxMy8xMC8yOS0xMTo0NzoxNiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIEVsZW1lbnRzIDEzLjAgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjFFNkM4MzA0MTk2RjExRUI5MjQ0QTkwNDRDNTQxNzNFIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjFFNkM4MzA1MTk2RjExRUI5MjQ0QTkwNDRDNTQxNzNFIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MUU2QzgzMDIxOTZGMTFFQjkyNDRBOTA0NEM1NDE3M0UiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MUU2QzgzMDMxOTZGMTFFQjkyNDRBOTA0NEM1NDE3M0UiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7JgqVpAAAa4klE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[{/capture}]

<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="save" />
<input type="hidden" name="aStep" value="" />
<input type="hidden" name="oxid" value="[{ $oxid }]" />
<input type="hidden" name="voxid" value="[{ $oxid }]" />
<input type="hidden" name="oxparentid" value="[{ $oxparentid }]" />
<input type="hidden" name="editval[oxarticles__oxid]" value="[{ $oxid }]" />
<input type="hidden" name="editlanguage" value="[{ $editlanguage }]" />

<div onclick="hidePleaseWait()" id="pleasewaiting"></div>

<table cellspacing="0" cellpadding="0" border="0" width="98%">
<tr>
    <td valign="top" class="edittext">
        [{assign var="isHook" value=false}][{assign var="isDirect" value=false}][{assign var="isLocal" value=false}]
        [{ if ( $oIdealo->getIdealoParam('dgIdealoActive') != "" && $oIdealo->getIdealoParam('dgIdealoActive')|lower == "dgidealo" )}][{assign var="isHook" value=true}][{/if}]
        [{assign var="aHookField" value='oxarticles__'|cat:$oIdealo->getIdealoParam('dgIdealoActive')|lower}]
        [{ if $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') == "dgidealodirectpurchaserelease" }][{assign var="isDirect" value=true}][{/if}]
        [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoArt2Local') == "dgidealoart2local" }][{assign var="isLocal" value=true}][{/if}]
        [{assign var="dgIdealoEanField" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoEan')|lower }]
        <table cellspacing="0" cellpadding="0" border="0">
        [{ if $oxparentid }]
        <tr>
           <td class="edittext">
              <b>[{ oxmultilang ident="ARTICLE_MAIN_VARIANTE" }]</b>
           </td>
           <td class="edittext">
              <a href="Javascript:editThis('[{ $parentarticle->getId()}]');" class="edittext"><b>[{ $parentarticle->oxarticles__oxartnum->value }] [{ $parentarticle->oxarticles__oxtitle->value|truncate:40}] [{if !$parentarticle->oxarticles__oxtitle->value }][{ $parentarticle->oxarticles__oxvarselect->value }][{/if}]</b></a>
           </td>
        </tr>
        <tr>
           <td class="edittext"> </td>
           <td class="edittext">
              <a href="Javascript:editVariant('[{ $parentarticle->getId()}]');" class="edittext">Varianten &Uuml;bersicht</a>
           </td>
        </tr>
        <tr>
          <td class="edittext" colspan="2"> &nbsp; </td>
        </tr>
        [{ /if}]
        <tr>
          <td class="edittext" colspan="2">
          <div  id="liste">
            <table cellspacing="0" cellpadding="4" border="0" width="100%">
             <colgroup>
              <col width="3%"/>
              <col width="3%"/>
              [{ if $isDirect}]<col width="3%"/>[{/if}]
              [{ if $isLocal}]<col width="3%"/>[{/if}]
              <col width="*"/>
              <col width="*"/>
              <col width="*"/>
              [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
              [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  <col width="*"/>
                [{/if}]
                [{/foreach}]
              [{/if}]
             </colgroup>
             <tr>
                <td class="listheader first" height="25"> &nbsp; </td>
                <td class="listheader">[{ if $isHook }]<input type="checkbox" id="checkAll" onclick="_checkAll(this, '[{$aHookField}]]')" title="alle f&uuml;r Idealo markieren" />[{else}]A[{/if}]</td>
                [{ if $isDirect}]<td class="listheader"><input type="checkbox" id="checkAll" onclick="_checkAll(this, 'oxarticles__dgidealodirectpurchaserelease]')" title="alle f&uuml;r Direktkauf markieren" />[{$smarty.capture.dgIdealoFirektKaufPicture}]</td>[{/if}]
                [{ if $isLocal }]<td class="listheader"><input type="checkbox" id="checkAll" onclick="_checkAll(this, 'oxarticles__dgidealoart2local]')" title="alle f&uuml;r Lokales Inventar markieren" /><img title="alle f&uuml;r Lokales Inventar markieren" class="dgIdealoLokalesInventarPicture" src="data:image/png;base64,[{$smarty.capture.dgIdealoLokalesInventarPicture}]"/></td>[{/if}]
                <td class="listheader">[{ oxmultilang ident="ARTICLE_VARIANT_ARTNUM" }] </td>
                <td class="listheader">[{ oxmultilang ident="ARTICLE_VARIANT_CHOICE" }] </td> 
                <td class="listheader">[{ oxmultilang ident="GENERAL_ARTICLE_OXEAN" }] </td>
                [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
                [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  [{assign var="aField" value="dgIdealo"|cat:$oName}]
                  <td class="listheader">[{$dgIdealoLabel}][{ oxinputhelp ident=$oIdealo->getFineName($aField) }] [{$oName}]</td>
                [{/if}]
                [{/foreach}]
                [{/if}] 
                
                [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]
                [{assign var="aExpert" value=$oIdealo->getExpertFields('dgIdealoDbAddFieldsValue',true)}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($edit->getId()) }]
                [{foreach from=$aExpert key=id item=aField }]
                   [{ if $aField.oxattribute != ""}]
                      [{assign var="aAttrid" value=$aField.oxattribute }]
                       [{foreach from=$oIdealo->getAttribute() item=oAtr}][{ if $aAttrid == $oAtr->oxid }]<td class="listheader">[{$oAtr->oxtitle}]</td> [{/if}][{/foreach}]       
                   [{ elseif $aField.oxarticles != ""}]                    
                      <td class="listheader">[{ oxmultilang|truncate:20:"..":true ident="GENERAL_ARTICLE_"|cat:$aField.oxarticles|upper noerror=true alternative=$aField.oxarticles|lower}]</td>
                   [{/if}]
               [{/foreach}]
               [{/if}]   
               
               [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoBranchId')|upper == "DGIDEALOBRANCHID"}]
                  <td class="listheader">Lokales Inventar BranchId [{ oxinputhelp ident="DGIDEALO_DGIDEALOBRANCHID_HELP" }]</td>
               [{/if}]
                    
             </tr>
             [{assign var="listclass" value=listitem2 }]
             [{ if $parentarticle }]
             <tr>
                <td class="listitem2" align="center"><a href="Javascript:editIdealo('[{ $parentarticle->getId()}]');" class="listitem2"><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
                <td class="listitem2">[{ if $isHook }]<input type="hidden" name="hook[[{ $parentarticle->getId() }]][[{$aHookField}]]" value="0" /><input type="checkbox" name="hook[[{ $parentarticle->getId() }]][[{$aHookField}]]" value="1" [{ if $parentarticle->$aHookField->value == 1 }]checked[{/if}] />[{else}][{if $parentarticle->oxarticles__oxactive->value == 1 }]&#10003;[{else}]&#10008;[{/if}][{/if}]</td>
                [{ if $isDirect}]<td class="listitem2"><input type="hidden" name="direct[[{ $parentarticle->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="0" /><input id="direct[{ $parentarticle->getId() }]" title="f&uuml;r Direktkauf markieren" type="checkbox" name="direct[[{ $parentarticle->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="1" [{ if $parentarticle->oxarticles__dgidealodirectpurchaserelease->value == 1 }]checked[{/if}] /><label for="">[{$smarty.capture.dgIdealoFirektKaufPicture}]</td>[{/if}]
                [{ if $isLocal}]<td class="listitem2"><input type="hidden" name="local[[{ $parentarticle->getId() }]][oxarticles__dgidealoart2local]" value="0" /><input id="local[{ $parentarticle->getId() }]" title="f&uuml;r Lokales Inventar markieren" type="checkbox" name="local[[{ $parentarticle->getId() }]][oxarticles__dgidealoart2local]" value="1" [{ if $parentarticle->oxarticles__dgidealoart2local->value == 1 }]checked[{/if}] /><label for=""><img title="alle f&uuml;r Lokales Inventar markieren" class="dgIdealoLokalesInventarPicture" src="data:image/png;base64,[{$smarty.capture.dgIdealoLokalesInventarPicture}]"/></td>[{/if}]
                <td class="listitem2"><a href="Javascript:editIdealo('[{ $parentarticle->getId()}]');" class="listitem2">[{$parentarticle->oxarticles__oxartnum->value}]</td>
                <td class="listitem2">[{$parentarticle->oxarticles__oxtitle->value|truncate:40}]</a></td>
                <td class="listitem2"><input class="editinput" size="15" [{if $parentarticle->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $parentarticle->getId() }]][[{$dgIdealoEanField}]]"[{else}]disabled="true"[{/if}] value="[{ $parentarticle->$dgIdealoEanField->value ]}]" /></td>
                [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($parentarticle->getId()) }]
                [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  [{assign var="aAttrid" value=$oIdealo->getIdealoParam($aField) }]
                  <td class="listitem2"><input name="editattrlist[[{ $parentarticle->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>
                [{/if}]
                [{/foreach}]
                [{/if}] 
                
                [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]
                [{assign var="aExpert" value=$oIdealo->getExpertFields('dgIdealoDbAddFieldsValue')}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($listitem->getId()) }]
                [{foreach from=$oIdealo->getIdealoParam('dgIdealoDbAddFields') key=id item=aField }]
                [{assign var="listclass" value=listitem$blWhite }]
                   [{ if $aField == "attribut"}]
                        [{foreach from=$oView->getAttributeList() item=oAtr}]
	                      [{ if $aExpert.$id.oxattribute == $oAtr->oxid }]
                          <td class="[{ $listclass}]"><input name="editattrlist[[{ $listitem->getId()}]][[{$oAtr->oxid}]]" value="[{$aAttrlist.$aAttrid}]" />
                          [{/if}]
                        [{/foreach}]         
                   [{ elseif $aField == "articles"}]
                     <select name="aExpert[[{$id}]][oxarticles]">
                       [{foreach from=$oView->getTable('oxarticles') key=field item=desc}]
                           [{assign var="ident" value="GENERAL_ARTICLE_"|cat:$desc}]
                           <option value="[{ $desc|lower }]" [{ if $aExpert.$id.oxarticles == $desc|lower }]SELECTED[{/if}]>[{ oxmultilang|truncate:20:"..":true ident=$ident noerror=true alternative=$desc|lower }]</option>
                       [{/foreach}]
                     </select>
                  [{/if}]
                [{/foreach}]
                
                [{/if}]
                [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoBranchId')|upper == "DGIDEALOBRANCHID"}]
                  <td class="listitem2"><input name="variants[[{ $parentarticle->getId()}]][oxarticles__dgidealobranchid]" value="[{$parentarticle->oxarticles__dgidealobranchid->value}]" /></td>
                [{/if}]
             </tr>
             <tr>
                <td class="listitem4" align="center"><a href="Javascript:editIdealo('[{ $edit->getId()}]');" class="listitem4"><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
                <td class="listitem4">[{ if $isHook }]<input type="hidden" name="hook[[{ $edit->getId() }]][[{$aHookField}]]" value="0" /><input title="f&uuml;r Idealo markieren" type="checkbox" name="hook[[{ $edit->getId() }]][[{$aHookField}]]" value="1" [{ if $edit->$aHookField->value == 1 }]checked[{/if}] />[{else}][{if $edit->oxarticles__oxactive->value == 1 }]&#10003;[{else}]&#10008;[{/if}][{/if}]</td>
                [{ if $isDirect}]<td class="listitem4"><input type="hidden" name="direct[[{ $edit->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="0" /><input id="direct[{ $edit->getId() }]" title="f&uuml;r Direktkauf markieren" type="checkbox" name="direct[[{ $edit->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="1" [{ if $edit->oxarticles__dgidealodirectpurchaserelease->value == 1 }]checked[{/if}] /><label for="direct[{ $edit->getId() }]">[{$smarty.capture.dgIdealoFirektKaufPicture}]</label></td>[{/if}]
                [{ if $isLocal}]<td class="listitem4"><input type="hidden" name="local[[{ $edit->getId() }]][oxarticles__dgidealoart2local]" value="0" /><input id="local[{ $edit->getId() }]" title="f&uuml;r Lokales Inventar markieren" type="checkbox" name="local[[{ $edit->getId() }]][oxarticles__dgidealoart2local]" value="1" [{ if $edit->oxarticles__dgidealoart2local->value == 1 }]checked[{/if}] /><label for="local[{ $edit->getId() }]"><img title="alle f&uuml;r Lokales Inventar markieren" class="dgIdealoLokalesInventarPicture" src="data:image/png;base64,[{$smarty.capture.dgIdealoLokalesInventarPicture}]"/></td>[{/if}]
                <td class="listitem4"><a href="Javascript:editIdealo('[{ $edit->getId()}]');" class="listitem4">[{$edit->oxarticles__oxartnum->value}]</a></td>
                <td class="listitem4">[{$parentarticle->oxarticles__oxtitle->value|truncate:40}], [{$edit->oxarticles__oxvarselect->value}]</td>
                <td class="listitem4"><input class="editinput" size="15" [{if $edit->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $edit->getId() }]][[{$dgIdealoEanField}]]"[{else}]disabled="true"[{/if}] value="[{ $edit->$dgIdealoEanField->value ]}]" /></td>
                [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($edit->getId()) }]
                [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  [{assign var="aAttrid" value=$oIdealo->getIdealoParam($aField) }]
                  <td class="listitem4"><input name="editattrlist[[{ $edit->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>
                [{/if}]
                [{/foreach}]
                [{/if}] 
                
                [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]
                [{assign var="aExpert" value=$oIdealo->getExpertFields('dgIdealoDbAddFieldsValue',true)}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($edit->getId()) }]
                [{foreach from=$aExpert key=id item=aField }]
                   [{ if $aField.oxattribute != ""}]
                      [{assign var="aAttrid" value=$aField.oxattribute }]
                      <td class="[{ $listclass}]"><input name="editattrlist[[{ $edit->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>        
                   [{ elseif $aField.oxarticles != ""}]                    
                      [{assign var="dgIdealoField" value="oxarticles__"|cat:$aField.oxarticles }]
                      <td class="[{ $listclass}]"><input class="editinput" size="15" [{if $edit->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $edit->getId() }]][[{$dgIdealoField}]]"[{else}]disabled="true"[{/if}] value="[{ $edit->$dgIdealoField->value ]}]" /></td>
                   [{/if}]
               [{/foreach}]
               [{/if}]
                
               [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoBranchId')|upper == "DGIDEALOBRANCHID"}]
                  <td class="[{ $listclass}]"><input name="variants[[{ $edit->getId()}]][oxarticles__dgidealobranchid]" value="[{$edit->oxarticles__dgidealobranchid->value}]" /></td>
               [{/if}] 
             </tr>
             [{else}]
             <tr>
                <td class="[{ $listclass}]" align="center"><a href="Javascript:editIdealo('[{ $edit->getId()}]');" class="[{ $listclass}]"><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
                <td class="[{ $listclass}]">[{ if $isHook }]<input type="hidden" name="hook[[{ $edit->getId() }]][[{$aHookField}]]" value="0" /><input title="f&uuml;r Idealo markieren" type="checkbox" name="hook[[{ $edit->getId() }]][[{$aHookField}]]" value="1" [{ if $edit->$aHookField->value == 1 }]checked[{/if}] />[{else}][{if $edit->oxarticles__oxactive->value == 1 }]&#10003;[{else}]&#10008;[{/if}][{/if}]</td>
                [{ if $isDirect}]<td class="listitem2"><input type="hidden" name="direct[[{ $edit->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="0" /><input id="direct[{ $edit->getId() }]" title="f&uuml;r Direktkauf markieren" type="checkbox" name="direct[[{ $edit->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="1" [{ if $edit->oxarticles__dgidealodirectpurchaserelease->value == 1 }]checked[{/if}] /><label for="direct[{ $edit->getId() }]">[{$smarty.capture.dgIdealoFirektKaufPicture}]</label></td>[{/if}]
                [{ if $isLocal}]<td class="listitem2"><input type="hidden" name="local[[{ $edit->getId() }]][oxarticles__dgidealoart2local]" value="0" /><input id="local[{ $edit->getId() }]" title="f&uuml;r Lokales Inventar markieren" type="checkbox" name="local[[{ $edit->getId() }]][oxarticles__dgidealoart2local]" value="1" [{ if $edit->oxarticles__dgidealoart2local->value == 1 }]checked[{/if}] /><label for="local[{ $edit->getId() }]"><img title="alle f&uuml;r Lokales Inventar markieren" class="dgIdealoLokalesInventarPicture" src="data:image/png;base64,[{$smarty.capture.dgIdealoLokalesInventarPicture}]"/></label></td>[{/if}]
                <td class="[{ $listclass}]"><a href="Javascript:editIdealo('[{ $edit->getId()}]');" class="[{ $listclass}]">[{$edit->oxarticles__oxartnum->value}]</a></td>
                <td class="[{ $listclass}]">[{$edit->oxarticles__oxtitle->value|truncate:40}]</td>
                <td class="[{ $listclass}]"><input class="editinput" size="15" [{if $edit->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $edit->getId() }]][[{$dgIdealoEanField}]]"[{else}]disabled="true"[{/if}] value="[{ $edit->$dgIdealoEanField->value ]}]" /></td>
                [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($edit->getId()) }]
                [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  [{assign var="aAttrid" value=$oIdealo->getIdealoParam($aField) }]
                  <td class="[{ $listclass}]"><input name="editattrlist[[{ $edit->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>
                [{/if}]
                [{/foreach}] 
                [{/if}]
                
                [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]
                [{assign var="aExpert" value=$oIdealo->getExpertFields('dgIdealoDbAddFieldsValue',true)}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($edit->getId()) }]
                [{foreach from=$aExpert key=id item=aField }]
                   [{ if $aField.oxattribute != ""}]
                      [{assign var="aAttrid" value=$aField.oxattribute }]
                      <td class="[{ $listclass}]"><input name="editattrlist[[{ $edit->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>        
                   [{ elseif $aField.oxarticles != ""}]                    
                      [{assign var="dgIdealoField" value="oxarticles__"|cat:$aField.oxarticles }]
                      <td class="[{ $listclass}]"><input class="editinput" size="15" [{if $edit->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $edit->getId() }]][[{$dgIdealoField}]]"[{else}]disabled="true"[{/if}] value="[{ $edit->$dgIdealoField->value ]}]" /></td>
                   [{/if}]
               [{/foreach}]
               [{/if}]
               
               [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoBranchId')|upper == "DGIDEALOBRANCHID"}]
                  <td class="[{ $listclass}]"><input name="variants[[{ $edit->getId()}]][oxarticles__dgidealobranchid]" value="[{$edit->oxarticles__dgidealobranchid->value}]" /></td>
               [{/if}] 
               
             </tr>
             [{/if}]
             [{foreach from=$mylist item=listitem}]
             [{assign var="_cnt1" value=$_cnt1+1}]
             <tr id="test_variant.[{$_cnt1}]">
               [{assign var="listclass" value=listitem$blWhite }]
               [{assign var="hasvariants" value=true }]
               <td class="[{ $listclass}]" align="center"><a href="Javascript:editIdealo('[{ $listitem->getId()}]');" class="[{ $listclass}]"><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
               <td class="[{ $listclass}]">[{ if $isHook }]<input type="hidden" name="hook[[{ $listitem->getId() }]][[{$aHookField}]]" value="0" /><input title="f&uuml;r Idealo markieren" type="checkbox" name="hook[[{ $listitem->getId() }]][[{$aHookField}]]" value="1" [{ if $listitem->$aHookField->value == 1 }]checked[{/if}] />[{else}][{if $listitem->oxarticles__oxactive->value == 1 }]&#10003;[{else}]&#10008;[{/if}][{/if}]</td>
               [{ if $isDirect}]<td class="[{ $listclass}]"><input type="hidden" name="direct[[{ $listitem->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="0" /><input id="direct[{ $listitem->getId() }]" title="f&uuml;r Direktkauf markieren" type="checkbox" name="direct[[{ $listitem->getId() }]][oxarticles__dgidealodirectpurchaserelease]" value="1" [{ if $listitem->oxarticles__dgidealodirectpurchaserelease->value == 1 }]checked[{/if}] /><label for="direct[{ $listitem->getId() }]">[{$smarty.capture.dgIdealoFirektKaufPicture}]</label></td>[{/if}]
               [{ if $isLocal}]<td class="[{ $listclass}]"><input type="hidden" name="local[[{ $listitem->getId() }]][oxarticles__dgidealoart2local]" value="0" /><input id="local[{ $listitem->getId() }]" title="f&uuml;r Lokales Inventar markieren" type="checkbox" name="local[[{ $listitem->getId() }]][oxarticles__dgidealoart2local]" value="1" [{ if $listitem->oxarticles__dgidealoart2local->value == 1 }]checked[{/if}] /><label for="local[{ $listitem->getId() }]"><img title="alle f&uuml;r Lokales Inventar markieren" class="dgIdealoLokalesInventarPicture" src="data:image/png;base64,[{$smarty.capture.dgIdealoLokalesInventarPicture}]"/></label></td>[{/if}]
               <td class="[{ $listclass}]"><a href="Javascript:editIdealo('[{ $listitem->getId()}]');" class="[{ $listclass}]">[{$listitem->oxarticles__oxartnum->value}]</a></td>
               <td class="[{ $listclass}]">[{$edit->oxarticles__oxtitle->value|truncate:40}], [{$listitem->oxarticles__oxvarselect->value}]</td>
               <td class="[{ $listclass}]"><input class="editinput" size="15" [{if $listitem->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $listitem->getId() }]][[{$dgIdealoEanField}]]"[{else}]disabled="true"[{/if}] value="[{ $listitem->$dgIdealoEanField->value ]}]" /></td>
               [{ if $oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
               [{assign var="aAttrlist" value=$oView->getAttributeArtList($listitem->getId()) }]
               [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
                [{assign var="aField" value="dgIdealo"|cat:$oName}]
                [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
                  [{assign var="aAttrid" value=$oIdealo->getIdealoParam($aField) }]
                  <td class="[{ $listclass}]"><input name="editattrlist[[{ $listitem->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>
                [{/if}]
                [{/foreach}]
                [{/if}] 
                [{ if $oIdealo->getIdealoParam('dgIdealoUseExpert') }]
                [{assign var="aExpert" value=$oIdealo->getExpertFields('dgIdealoDbAddFieldsValue',true)}]
                [{assign var="aAttrlist" value=$oView->getAttributeArtList($listitem->getId()) }]
                [{foreach from=$aExpert key=id item=aField }]
                   [{ if $aField.oxattribute != ""}]
                      [{assign var="aAttrid" value=$aField.oxattribute }]
                      <td class="[{ $listclass}]"><input name="editattrlist[[{ $edit->getId()}]][[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" /></td>        
                   [{ elseif $aField.oxarticles != ""}]                    
                      [{assign var="dgIdealoField" value="oxarticles__"|cat:$aField.oxarticles }]
                      <td class="[{ $listclass}]"><input class="editinput" size="15" [{if $listitem->oxarticles__oxvarcount->value <= 0 || $blVariantParentBuyable }]name="variants[[{ $listitem->getId() }]][[{$dgIdealoField}]]"[{else}]disabled="true"[{/if}] value="[{ $listitem->$dgIdealoField->value ]}]" /></td>
                   [{/if}]
               [{/foreach}]
               [{/if}]
               [{ if $oIdealo->getIdealoParam('dgIdealUseLocalStock') && $oIdealo->getIdealoParam('dgIdealoBranchId')|upper == "DGIDEALOBRANCHID"}]
                  <td class="[{ $listclass}]"><input name="variants[[{ $listitem->getId()}]][oxarticles__dgidealobranchid]" value="[{$listitem->oxarticles__dgidealobranchid->value}]" /></td>
               [{/if}] 
             </tr>
             [{if $blWhite == "2"}][{assign var="blWhite" value=""}][{else}][{assign var="blWhite" value="2"}][{/if}]
             [{/foreach}]
            </table>
            </div>  <br />
          </td>
        </tr>
        [{if $oIdealo->getIdealoParam('dgIdealoActiv') && $oIdealo->getIdealoParam('dgIdealoActive')|lower == "dgidealo" && !$oIdealo->getIdealoParam('dgIdealoDontArtAttrList') }]
         <tr>
           <td class="edittext">
             <label for="dgidealo">[{$dgIdealoLabel}] Export</label>
           </td>
           <td class="edittext">
             <input type="hidden" name="editval[oxarticles__dgidealo]" value="0" />
             <input id="dgidealo" type="checkbox" name="editval[oxarticles__dgidealo]" value="1" [{if $edit->oxarticles__dgidealo->value == 1}]checked[{/if}] />
           </td>
         </tr>
         [{/if}]

         [{if $oIdealo->getIdealoParam('dgIdealoActiv') && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') != "0" && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') != "1" && !$oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
         <tr>
           <td class="edittext">
             <label for="dgidealodirectpurchaserelease">[{$dgIdealoLabel}] Direktkauf</label>
           </td>
           <td class="edittext">
             <input type="hidden" name="editval[oxarticles__dgidealodirectpurchaserelease]" value="0" />
             <input id="dgidealodirectpurchaserelease" type="checkbox" name="editval[oxarticles__dgidealodirectpurchaserelease]" value="1" [{if $edit->oxarticles__dgidealodirectpurchaserelease->value == 1}]checked[{/if}] />
           </td>
         </tr>
         [{/if}]

         [{if $oIdealo->getIdealoParam('dgIdealoActiv') && $oIdealo->getIdealoParam( 'dgIdealoDeliveryArt' ) != "Download" && $oIdealo->getIdealoParam( 'dgIdealoDeliveryArt' ) != "Paketdienst" && $oIdealo->getIdealoParam( 'dgIdealoDeliveryArt' ) != "Spedition" && $oIdealo->getIdealoParam( 'dgIdealoDeliveryArt' ) != "Briefversand" }]
         <tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Versandart
           </td>
           <td class="edittext">
             <select name="editval[oxarticles__dgidealodeliveryart]" class="editinput">
               <option value=""> - </option>
               <option value="Download"     [{if $edit->oxarticles__dgidealodeliveryart->value == "Download"    }]selected[{/if}]>Download </option>
               <option value="Paketdienst"  [{if $edit->oxarticles__dgidealodeliveryart->value == "Paketdienst" }]selected[{/if}]>Paketdienst </option>
               <option value="Spedition"    [{if $edit->oxarticles__dgidealodeliveryart->value == "Spedition"   }]selected[{/if}]>Spedition </option>
               <option value="Briefversand" [{if $edit->oxarticles__dgidealodeliveryart->value == "Briefversand"}]selected[{/if}]>Briefversand </option>
             </select>
           </td>
        </tr>
        [{/if}]
        
        [{if $oIdealo->getIdealoParam('dgIdealoMinPrice')|upper == 'DGIDEALOMINPRICE' }]
        [{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoMinPrice') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoMinPrice')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Preisspanne
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="5" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]

		[{if $oIdealo->getIdealoParam('dgIdealoStock4Idealo')|upper == 'DGIDEALOSTOCK' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoStock4Idealo') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoStock4Idealo')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Direktkauf: Freigegebene St&uuml;ckzahl
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="5" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
		[{if $oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment')|upper == 'DGIDEALOEQUIPMENTENTRAINMENT' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoEquipmentEntrainment')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Direktkauf: Kosten Altger&auml;temitnahme
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="5" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
		[{if $oIdealo->getIdealoParam('dgIdealoCostUpToPlace')|upper == 'DGIDEALOCOSTUPTOPLACE' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoCostUpToPlace') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoCostUpToPlace')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Direktkauf: Lieferkosten bis zum Aufstellort
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="32" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
		[{if $oIdealo->getIdealoParam('dgIdealoDepositValue')|upper == 'DGIDEALODEPOSITVALUE' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoDepositValue') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoDepositValue')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Pfand
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="5" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
		[{if $oIdealo->getIdealoParam('dgIdealoVersand-Kommentar')|upper == 'DGIDEALOVERSANDKOMMENTAR' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoVersand-Kommentar') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoVersand-Kommentar')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Versand-Kommentar
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="32" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
		[{if $oIdealo->getIdealoParam('dgIdealoGutschein')|upper == 'DGIDEALOGUTSCHEIN' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoGutschein') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoGutschein')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Gutschein
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="32" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
        [{if $oIdealo->getIdealoParam('dgIdealoUseVpe')|upper == 'OXVPE' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoUseVpe') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoUseVpe')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Verpackungseinheit
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="5" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        
        [{if $oIdealo->getIdealoParam('dgIdealoUseVpeUnit') != '' }]
		[{assign var="aField" value=$oIdealo->getIdealoParam('dgIdealoUseVpeUnit') }]
        [{assign var="aFieldName" value="oxarticles__"|cat:$oIdealo->getIdealoParam('dgIdealoUseVpeUnit')|lower }]
		<tr>
           <td class="edittext">
             [{$dgIdealoLabel}] Verpackungseinheit Mengeneinheit
           </td>
           <td class="edittext">
             <input type="text" class="editinput" size="20" maxlength="[{$edit->$aFieldName->fldmax_length}]" name="editval[[{$aFieldName}]]" value="[{$edit->$aFieldName->value}]" />
             [{ oxinputhelp ident=$aField }]
           </td>
        </tr>
        [{/if}]
        <tr>
            <td class="edittext"> </td>
            <td class="edittext"><br />
              <button type="submit" name="save" onclick="showPleaseWait();">[{ oxmultilang ident="GENERAL_SAVE" }]</button>
              <br /><br /><br />
            </td>
        </tr>
        [{if $oIdealo->getIdealoParam('dgIdealoPwsActiv') && $oIdealo->getIdealoParam( "dgIdealoIsPwsTokenCorrect" ) && $oIdealo->getIdealoParam('dgIdealoPwsShowArticle') }]
        <tr>
            <td class="edittext"> [{$dgIdealoLabel}] Partner Web Service</td>
            <td class="edittext">
              <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='sendOffer';this.form.submit();">Artikel an Idealo senden</button>
              
              <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='patchOffer';this.form.submit();">Update an Idealo senden</button>
              
              <button type="submit" name="save" onclick="showPleaseWait();this.form.fnc.value='deleteOffer';this.form.submit();">Artikel in Idealo l&ouml;schen</button>
              <br /><br />
            </td>
        </tr>
        [{/if}]
        <tr>
            <td class="edittext" colspan="2">
             [{$dgIdealoLabel}]
               <select size="1" name="param[dgIdealoLocation]" onchange="showPleaseWait();this.form.fnc.value='savelocation';this.form.submit();" size="1">
                [{ foreach from=$oIdealo->getLocationArray() key=name item=plattform }]
	      		  <option value="[{$plattform}]" [{ if $oIdealo->getLocation() == $plattform }] selected[{/if}]>[{$name}]</option>
                [{/foreach}]
               </select> bearbeiten<br /><br />
            </td>
        </tr>
        </table>
        
    </td>
    <!-- Anfang rechte Seite -->
    <td valign="top" class="edittext" align="left"[{ if !$oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}] width="40%"[{/if}]>
          [{ if !$oIdealo->getIdealoParam('dgIdealoDontArtAttrList')}]
          <table cellspacing="0" cellpadding="0" border="0"> 
           [{assign var="aAttrlist" value=$oView->getAttributeList() }]
           [{foreach from=$oIdealoValues->getIdealoAttributeFields() item=oName }]
           [{assign var="aField" value="dgIdealo"|cat:$oName}]
           [{if $oIdealo->getIdealoParam($aField) != "" && $oIdealo->getIdealoParam($aField) != "oxvarselect" }]
           [{assign var="aAttrid" value=$oIdealo->getIdealoParam($aField) }]
           <tr>
            <td class="edittext">
              [{$dgIdealoLabel}] Attribut <b>[{$oName}]</b>
            </td>
            <td class="edittext">
             <input type="text" class="editinput" size="32" name="editattr[[{$aAttrid}]]" value="[{$aAttrlist.$aAttrid}]" />
             [{ oxinputhelp ident=$aField }]
            </td>
         </tr>  
         [{/if}]
         [{/foreach}]   
       </table>
       [{/if}]
    </td>

    </tr>
</table>

</form>




[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]