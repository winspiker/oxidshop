[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]
<style>
fieldset {
  margin-top: 15px;
  margin-bottom: 20px;
  padding: 10px;
  background: #eee;
  padding: 5px 5px 5px 5px;
}
fieldset > span{
  margin-left: 2px;
  padding: 5px 5px 5px 5px;
  display: block;
}
legend{
  font-weight: bolder;  
  margin-bottom: 6px;
}
</style>
<script>
function dgOttoDisable( sValue, sButtoId )
{
  if(document.getElementById(sButtoId).disabled == false){
      if( sValue == '')
      document.getElementById(sButtoId).disabled = true;
  }
  else{
      if( sValue != '')
      document.getElementById(sButtoId).disabled = false;
  }
}

function toggleRefundType(oElem)
{
   var quantityDisplay = oElem.value === 'quantity' ? '' : 'none';
   var amountDisplay = oElem.value === 'amount' ? '' : 'none';

   setDisplayStyleForClassName('refundQuantity', quantityDisplay);
   setDisplayStyleForClassName('refundAmount', amountDisplay);
}

function setDisplayStyleForClassName(className, displayStyle)
{
   var aElements = document.getElementsByClassName(className);
   for (i = 0; i < aElements.length; i++) {
     aElements[i].style.display = displayStyle;
   }
}
</script>
<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
</form>
[{if $oView->dgOttoOrder()}]
[{assign var="oOtto" value=$oView->dgOttoOrder()}]

<form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="" />
<input type="hidden" name="oxid" value="[{$oxid}]" />
<input type="hidden" name="editval[oxorder_oxid]" value="[{$oxid}]" />
<input type="hidden" name="workid" value="" />

<table cellspacing="0" cellpadding="0" border="0" width="98%">
<tr>
    <td valign="top" class="edittext">
      <fieldset>
        <legend>Information</legend>
          <table cellspacing="4" cellpadding="0" border="0">
            <tr>
              <td class="edittext">Bestellnummer:</td>
              <td class="edittext"><a href="https://portal.otto.market/orders#/details/[{$oOtto->dgottoordermarge__oxottoordernr->value}]/articles" target="_blank">[{$oOtto->dgottoordermarge__oxottoordernr->value}]</a></td>
            </tr>
            <tr>
              <td class="edittext">angelegt am:</td>
              <td class="edittext">[{$oOtto->dgottoordermarge__oxtimestamp->value}]</td>
            </tr>
        </table>
      </fieldset>
      
      <fieldset>
        <legend>Versandmeldung</legend>
        [{if $oOtto->dgottoordermarge__oxtrackingcodesent->value == "0000-00-00 00:00:00"}]
          <table>
            <tr>
              <td>Tracking Code:</td>
              <td><input name="TrackingCode" size="20" value="[{$edit->oxorder__oxtrackcode->value}]" /></td>
            </tr>
            [{if $oOttoValues->getOttoParam('dgOttoTrackingRetourenId')}]
            <tr>
              <td>Retouren Code:</td>
              [{assign var="aField" value="oxorder__"|cat:$oOttoValues->getOttoParam('dgOttoTrackingRetourenId')}]
              <td><input name="ReturnCode" size="20" value="[{$edit->$aField->value}]" /></td>
            </tr>
            [{/if}]
            <tr>
              <td>Logistikdienstleister:</td>
              <td>
                <select name="Carrier" size="1">
                  <option value="">- bitte w&auml;hlen -</option>
                  [{foreach from=$oOttoValues->getCarrier() item=iOttoName}]
                    <option value="[{$iOttoName}]" [{if $oOtto->dgottoordermarge__oxdeliverycarrier->value == $iOttoName}]selected[{/if}]>[{$iOttoName}]</option>
                  [{/foreach}]
                </select>
              </td>
            </tr>
          </table>
          <br /><br />
          <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgOttoDisable(this.checked ,'tracking');" />
          <button id="tracking" type="submit" onclick="this.form.fnc.value='sendFulfillmentStatus';" disabled="true">Versandmeldung durchf&uuml;hren</button> 
        [{else}]
          <table>
            <tr>
              <td colspan="2">Versand gemeldet am: [{$oOtto->dgottoordermarge__oxtrackingcodesent|oxformdate}]</td>
            </tr>
            <tr>
              <td>Tracking Code:</td>
              <td>[{$edit->oxorder__oxtrackcode->value|default:"-"}]</td>
            </tr>
            [{if $oOttoValues->getOttoParam('dgOttoTrackingRetourenId')}]
            <tr>
              <td>Retouren Code:</td>
              [{assign var="aField" value="oxorder__"|cat:$oOttoValues->getOttoParam('dgOttoTrackingRetourenId')}]
              <td>[{$edit->$aField->value|default:"-"}]</td>
            </tr>
            [{/if}]
            <tr>
              <td>Ship Code:</td>
              <td>[{$oOtto->dgottoordermarge__oxottoshipmentid->value|default:"-"}]</td>
            </tr>
            <tr>
              <td>Logistikdienstleister:</td>
              <td>[{$oOtto->dgottoordermarge__oxdeliverycarrier->value|default:"-"}]</td>
            </tr>
          </table>
        [{/if}]         
      </fieldset>      
      
      [{assign var="oDocuments" value=$oView->getDokuments()}]
      [{if $oDocuments}]
      <fieldset>
        <legend>Dokumente</legend>
          <table width="100%" cellspacing="5" cellpadding="5" border="0">
            <colgroup>
              <col width="20%" />
              <col width="20%" />
              <col width="60%" />
            </colgroup>
            <thead>
              <tr>
                <th class="listheader" height="15">Datum</th>
                <th class="listheader">Type</th>
                <th class="listheader">Name</th>
              </tr>
            </thead>
            [{assign var="blWhite" value=""}]
            [{foreach from=$oDocuments item=oDocument name=orderDocuments}]
            <tr>
              <td class="listitem[{$blWhite}]">[{$oDocument->dgottoreceipts__oxtimestamp|oxformdate}]</td>
              <td class="listitem[{$blWhite}]">[{oxmultilang ident="DGOTTO_"|cat:$oDocument->dgottoreceipts__oxtype->value noerror=true alternate=$oDocument->dgottoreceipts__oxtype->value}]</td>
              <td class="listitem[{$blWhite}]"><a href="[{$oDocument->getUrl()}]" target="_blank">[{$oDocument->dgottoreceipts__oxfile->value}]</a></td>
            </tr>
            [{if $blWhite == "2"}]
              [{assign var="blWhite" value=""}]
            [{else}]
              [{assign var="blWhite" value="2"}]
            [{/if}]
            [{/foreach}]
          </table>
      </fieldset>
      [{/if}]
    </td>
    <td valign="top" class="edittext" align="left" width="60%">
      <fieldset>
        <legend>Teilerstattung/Teilstornierung</legend>
         [{* <div class="typeSelect">
            <label for="refundType">Erstattung durchf&uuml;hren &uuml;ber:</label>
            <select id="refundType" name="refundType" onchange="toggleRefundType(this);">
              <option value="amount"   [{if $refundType == "amount"  }]selected[{/if}]>Betrag</option>
              <option value="quantity" [{if $refundType == "quantity"}]selected[{/if}]>Menge</option>
            </select>
          </div>
          <br />
          *}]
          <table cellspacing="0" cellpadding="0" border="0" width="98%">
            <tr>
              <td class="listheader first">
                <span class="refundAmount" style="display:[{if $refundType == "amount"}]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">Betrag</span>
                <span class="refundQuantity" style="display:[{if $refundType == "amount"}]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">Menge</span>
              </td>
              <td class="listheader" height="15">&nbsp;&nbsp;&nbsp;[{oxmultilang ident="GENERAL_ITEMNR"}]</td>
              <td class="listheader">&nbsp;&nbsp;&nbsp;[{oxmultilang ident="GENERAL_TITLE"}]</td>
              <td class="listheader">[{oxmultilang ident="ORDER_ARTICLE_EBRUTTO"}]</td>
              <td class="listheader">[{oxmultilang ident="GENERAL_ATALL"}]</td>
              <td class="listheader" colspan="3">&nbsp;</td>
            </tr>
            [{assign var="blWhite" value=""}]
            [{foreach from=$edit->getOrderArticles() item=listitem name=orderArticles}]
            <tr id="art.[{$smarty.foreach.orderArticles.iteration}]">
            [{if $listitem->oxorderarticles__oxstorno->value == 1}]
              [{assign var="listclass" value=listitem3}]
            [{else}]
              [{assign var="listclass" value=listitem$blWhite}]
            [{/if}]
              <td class="[{$listclass}]">
                <span class="refundAmount" style="display:[{if $refundType == "amount"}]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">[{if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle()}]<input size="5" type="text" name="aOrderArticles[[{$listitem->getId()}]][oxamount]" value="[{$listitem->getBrutPriceFormated()}]" class="listedit">[{else}][{$listitem->getBrutPriceFormated()}][{/if}] <small>[{$edit->oxorder__oxcurrency->value}]</small></span>
                <span class="refundQuantity" style="display:[{if $refundType == "amount"}]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">[{if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle()}]<input size="5" type="text" name="aOrderArticles[[{$listitem->getId()}]][oxquantity]" value="[{$listitem->oxorderarticles__oxamount->value}]" class="listedit">[{else}][{$listitem->oxorderarticles__oxamount->value}][{/if}]</span>
              </td>
              <td class="[{$listclass}]" height="15">[{$listitem->oxorderarticles__oxartnum->value}]</td>
              <td class="[{$listclass}]">[{$listitem->oxorderarticles__oxtitle->value|oxtruncate:20:""|strip_tags}]</td>
              <td class="[{$listclass}]">[{$listitem->getBrutPriceFormated()}] <small>[{$edit->oxorder__oxcurrency->value}]</small></td>
              <td class="[{$listclass}]">[{$listitem->getTotalBrutPriceFormated()}] <small>[{$edit->oxorder__oxcurrency->value}]</small></td>
              <td class="[{$listclass}]" colspan="3">
                 [{if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle()}]
                   <span class="refundAmount" style="display:[{if $refundType == "amount"}]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">
                      [{if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle()}]
                      <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgOttoDisable(this.checked ,'partieRefund[{$smarty.foreach.orderArticles.iteration}]');" />
                      <button id="partieRefund[{$smarty.foreach.orderArticles.iteration}]" disabled=" true" onclick="this.form.fnc.value='partieRefund';this.form.workid.value='[{$listitem->getId()}]';">Teilerstattung</button>
                      [{/if}]
                   </span>
                   <span class="refundQuantity" style="display:[{if $refundType == "amount"}]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">
                     [{if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle()}]
                       <select name="aOrderArticles[[{$listitem->getId()}]][storno]" size="1" onchange="Javascript:dgOttoDisable(this.options[this.selectedIndex].value, 'partieStorno[{$smarty.foreach.orderArticles.iteration}]');">
                         <option value="" selected="true"> - bitte w&auml;hlen -</option>
                         <option value="RETURNED">Retoure</option>
                         <option value="CANCELLED_BY_CUSTOMER">Kunde hat widerrufen</option>
                         <option value="CANCELLED_BY_PARTNER">H&auml;ndler hat storniert</option>
                         <option value="CANCELLED_BY_MARKETPLACE">Otto hat storniert</option>
                       </select>
                       <button id="partieStorno[{$smarty.foreach.orderArticles.iteration}]" disabled="true" onclick="this.form.fnc.value='partieStorno';this.form.workid.value='[{$listitem->getId()}]';">Stornierung</button>
                     [{/if}]
                   </span>
                 [{/if}]
              </td>
            </tr>
            [{if $oView->dgOttoOrderArticle($listitem->getId(),'refund') || $oView->dgOttoOrderArticle($listitem->getId(),'storno')}]
            <tr>
              <td class="[{$listclass}]" colspan="8">
                [{if $oView->dgOttoOrderArticle($listitem->getId(),'refund')}]
                   [{assign var="oOttoArticle" value=$oView->dgOttoOrderArticle($listitem->getId(),'refund')}]
                   <span class="refundAmount" style="line-height: 24px;display:[{if $refundType == "amount"}]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">Erstattung durchgef&uuml;hrt am [{$oOttoArticle->dgottoorderarticle__oxrefundsent|oxformdate}] &uuml;ber [{$oOttoArticle->dgottoorderarticle__oxrefundamount->value}] <small>[{$edit->oxorder__oxcurrency->value}]</small></span>
                [{/if}]
                [{if $oView->dgOttoOrderArticle($listitem->getId(),'storno')}]
                  [{assign var="oOttoArticle" value=$oView->dgOttoOrderArticle($listitem->getId(),'storno')}]
                  <span class="refundQuantity" style="line-height: 24px;display:[{if $refundType == "amount"}]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">[{$oOttoArticle->dgottoorderarticle__oxrevocationamount->value}] Artikel storniert am [{$oOttoArticle->dgottoorderarticle__oxrevocationsent|oxformdate}], Grund: [{if $oOttoArticle->dgottoorderarticle__oxrevocationreason->value == "MERCHANT_DECLINE"}]H&auml;ndler hat storniert[{elseif $oOttoArticle->dgottoorderarticle__oxrevocationreason->value == "CUSTOMER_REVOKE"}]Kunde hat widerrufen[{elseif $oOttoArticle->dgottoorderarticle__oxrevocationreason->value == "RETOUR"}]Retoure[{else}]-[{/if}] </span>
                [{/if}]
              </td>
            </tr>
            [{/if}]
            [{if $blWhite == "2"}]
              [{assign var="blWhite" value=""}]
            [{else}]
              [{assign var="blWhite" value="2"}]
            [{/if}]
            [{/foreach}]
            [{if $edit->oxorder__oxdelcost->value}]
            <tr id="art.99">
              <td class="listitem[{$listclass}]">
                <span class="refundAmount" style="display:[{if $refundType == "amount"}]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];"><input size="5" type="text" name="aOrderArticles[oxdelcost][oxamount]" value="[{$edit->getFormattedeliveryCost()}]" class="listedit" disabled="true" /> <small>[{$edit->oxorder__oxcurrency->value}]</small></span>
                <span class="refundQuantity" style="display:[{if $refundType == "amount"}]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];"><input size="5" type="text" name="aOrderArticles[oxamount][oxquantity]" value="1" class="listedit" disabled="true" /></span>
              </td>
              <td class="listitem[{$listclass}]" height="15">-</td>
              <td class="listitem[{$listclass}]">Versandkosten</td>
              <td class="listitem[{$listclass}]">[{$oOtto->getFormattedeliveryCost()}] <small>[{$edit->oxorder__oxcurrency->value}]</small></td>
              <td class="listitem[{$listclass}]">[{$oOtto->getFormattedeliveryCost()}] <small>[{$edit->oxorder__oxcurrency->value}]</small></td>
              <td class="listitem[{$listclass}]" colspan="3"></td>
            </tr>
            [{/if}]
          </table>
      </fieldset>
      
      <fieldset>
        <legend>Vollst&auml;ndige Stornierung</legend>
           [{if $oOtto->dgottoordermarge__oxrevocationsent->value == "0000-00-00 00:00:00"}]
             <span>
                <select name="storno" size="1" onchange="Javascript:dgOttoDisable(this.options[this.selectedIndex].value, 'FullStorno');">
                   <option value="" selected="true"> - bitte w&auml;hlen -</option>
                   <option value="MERCHANT_DECLINE">H&auml;ndler hat storniert</option>
                   <option value="CUSTOMER_REVOKE">Kunde hat widerrufen</option>
                   <option value="RETOUR">Retoure</option>
                </select>
             </span>
             <button id="FullStorno" type="submit" onclick="this.form.fnc.value='FullStorno';" disabled="true">Stornierung durchf&uuml;hren</button>
           [{else}]
           <span>Storniert am [{$oOtto->dgottoordermarge__oxrevocationsent|oxformdate}], Grund: [{if $oOtto->dgottoordermarge__oxrevocationreason->value == "MERCHANT_DECLINE"}]H&auml;ndler hat storniert[{elseif $oOtto->dgottoordermarge__oxrevocationreason->value == "CUSTOMER_REVOKE"}]Kunde hat widerrufen[{elseif $oOtto->dgottoordermarge__oxrevocationreason->value == "RETOUR"}]Retoure[{else}]-[{/if}]</span>
           [{/if}]
      </fieldset>
      
      [{if $oView->getRefunds()|count}]
      <fieldset>
        <legend>&Uuml;bersicht R&uuml;ckerstattungen</legend>
           <table cellspacing="0" cellpadding="4" border="0" width="98%">
            <tr>
              <td class="listheader first">erstellt </td>
              <td class="listheader">aktualisiert</td>
              <td class="listheader">Betrag</td>
              <td class="listheader">Begr&uuml;ndungstext</td>
              <td class="listheader">Otto R&uuml;ckerstattungsid</td>
              <td class="listheader">Status</td>
            </tr>
            [{assign var="blWhite" value="2"}]
            [{foreach from=$oView->getRefunds() item=oRefund}]
             [{if $blWhite == "2"}]
              [{assign var="blWhite" value=""}]
            [{else}]
              [{assign var="blWhite" value="2"}]
            [{/if}]
            <tr>
              <td class="listitem[{$blWhite}]">[{$oView->dgOttoTime($oRefund.created)|oxformdate}]</td>
              <td class="listitem[{$blWhite}]">[{$oView->dgOttoTime($oRefund.updated)|oxformdate}]</td>
              <td class="listitem[{$blWhite}]" style="text-align:right;">[{ $oView->getFormattedSum($oRefund.refundAmount)}] [{$oRefund.currency}]</td>
              <td class="listitem[{$blWhite}]">[{$oRefund.failureReason}]</td>
              <td class="listitem[{$blWhite}]">[{$oRefund.refundId}]</td>
              <td class="listitem[{$blWhite}]">[{$oRefund.status}]</td>
            </tr>
            [{/foreach}]
            </table>
      </fieldset>
      
      

      <fieldset>
        <legend>Vollst&auml;ndige R&uuml;ckerstattung</legend>
           [{if $oOtto->dgottoordermarge__oxrefundsent->value == "0000-00-00 00:00:00"}]
             <span>Erstattung durchf&uuml;hren &uuml;ber Betrag von: [{$oOtto->getFormattedTotalRefundSum()}] <small>[{if $edit->oxorder__oxcurrency->value}] [{$edit->oxorder__oxcurrency->value}] [{else}] &euro; [{/if}]</small></span><br /><br />
             <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgOttoDisable(this.checked ,'FullRefund');" />
             <button id="FullRefund" type="submit" onclick="this.form.fnc.value='FullRefund';" disabled="true">Erstattung durchf&uuml;hren</button>
           [{else}]
             <span>Erstattung am [{$oOtto->dgottoordermarge__oxrefundsent|oxformdate}]</span>
           [{/if}]
      </fieldset>[{/if}]
   </td>
 </tr>
</table>

</form>
[{/if}]
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
