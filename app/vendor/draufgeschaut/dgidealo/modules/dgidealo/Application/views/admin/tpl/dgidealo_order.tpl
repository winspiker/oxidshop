[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{ if $readonly }]
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
function dgIdealoDisable( sValue, sButtoId )
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
<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]" />
    <input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
</form>
[{if $oView->dgIdealoOrder()}]
[{assign var="oIdealo" value=$oView->dgIdealoOrder() }]

<form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post">
[{ $oViewConf->getHiddenSid() }]
<input type="hidden" name="cl" value="[{ $oViewConf->getTopActiveClassName() }]" />
<input type="hidden" name="fnc" value="" />
<input type="hidden" name="oxid" value="[{ $oxid }]" />
<input type="hidden" name="editval[oxorder_oxid]" value="[{ $oxid }]" />
<input type="hidden" name="workid" value="" />

<table cellspacing="0" cellpadding="0" border="0" width="98%">
<tr>
    <td valign="top" class="edittext">
      <fieldset>
        <legend>Information</legend>
          <table cellspacing="4" cellpadding="0" border="0">
            <tr>
              <td class="edittext">Bestellnummer:</td>
              <td class="edittext">[{ $oIdealo->dgidealoordermarge__oxidealoordernr->value }]</td>
            </tr>
            <tr>
              <td class="edittext">angelegt am:</td>
              <td class="edittext">[{ $oIdealo->dgidealoordermarge__oxinsert->value }]</td>
            </tr>
        </table>
      </fieldset>
      
      
      <fieldset>
        <legend>Bestellnummer melden</legend>
          [{ if $oIdealo->dgidealoordermarge__oxordernrsent->value == "0000-00-00 00:00:00" }]
          <span>Bestellnummer: <input name="OrderNr" size="20" value="[{ $edit->oxorder__oxordernr->value}]" /> </span><br /><br />
          <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgIdealoDisable(this.checked ,'ordernr');" />
          <button id="ordernr" type="submit" onclick="this.form.fnc.value='sendOrderNr';" disabled="true">Bestellnummer &uuml;bertragen</button>
          [{else}]
          <span>Bestellnummer [{ $edit->oxorder__oxordernr->value}] &uuml;bertragen am: [{ $oIdealo->dgidealoordermarge__oxordernrsent|oxformdate }]</span>
          [{/if}]          
      </fieldset>
      
      <fieldset>
        <legend>Versandmeldung</legend>
        [{ if $oIdealo->dgidealoordermarge__oxtrackingcodesent->value == "0000-00-00 00:00:00" }]
          <table>
            <tr>
              <td>Tracking Code:</td>
              <td><input name="TrackingCode" size="20" value="[{ $edit->oxorder__oxtrackcode->value}]" /></td>
            </tr>
            <tr>
              <td>Logistikdienstleister:</td>
              <td>
                <select name="Carrier" size="1">
                  <option value="">- bitte w&auml;hlen -</option>
                  [{foreach from=$oIdealoValues->getIdealoCarriers() item=iIdealoName}]
                    <option value="[{$iIdealoName}]" [{ if $oIdealo->dgidealoordermarge__oxdeliverycarrier->value == $iIdealoName }]selected[{/if}]>[{$iIdealoName}]</option>
                  [{/foreach}]
                </select>
              </td>
            </tr>
          </table>
          <br /><br />
          <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgIdealoDisable(this.checked ,'tracking');" />
          <button id="tracking" type="submit" onclick="this.form.fnc.value='sendFulfillmentStatus';" disabled="true">Versandmeldung durchf&uuml;hren</button> 
        [{else}]
          <table>
            <tr>
              <td colspan="2">Versand gemeldet am: [{ $oIdealo->dgidealoordermarge__oxtrackingcodesent|oxformdate }]</td>
            </tr>
            <tr>
              <td>Tracking Code:</td>
              <td>[{ $edit->oxorder__oxtrackcode->value|default:"-"}]</td>
            </tr>
            <tr>
              <td>Logistikdienstleister:</td>
              <td>[{ $oIdealo->dgidealoordermarge__oxdeliverycarrier->value|default:"-" }]</td>
            </tr>
          </table>
        [{/if}]         
      </fieldset>      
    </td>
    <td valign="top" class="edittext" align="left" width="60%">
     [{ if $oIdealoValues->getIdealoParam( 'dgIdealoOrderApi' ) == "2" }]
      <fieldset>
      [{ if $oIdealo->dgidealoordermarge__oxpayment->value == "PAYPAL" || $oIdealo->dgidealoordermarge__oxpayment->value == "SOFORT" }]
        <legend>Teilstornierung</legend>
      [{else}]
        <legend>Teilerstattung/Teilstornierung</legend>
      [{/if}]
          <div class="typeSelect">
            [{ if $oIdealo->dgidealoordermarge__oxpayment->value != "PAYPAL" && $oIdealo->dgidealoordermarge__oxpayment->value != "SOFORT" }]
            <label for="refundType">Erstattung durchf&uuml;hren &uuml;ber:</label>
            <select id="refundType" name="refundType" onchange="toggleRefundType(this);">
              <option value="amount"   [{ if $refundType == "amount"   }]selected[{/if}]>Betrag</option>
              <option value="quantity" [{ if $refundType == "quantity" }]selected[{/if}]>Menge</option>
            </select>
           [{/if}]
          </div>
          <br />
          <table cellspacing="0" cellpadding="0" border="0" width="98%">
            <tr>
              <td class="listheader first">
                <span class="refundAmount" style="display:[{ if $refundType == "amount" }]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">Betrag</span>
                <span class="refundQuantity" style="display:[{ if $refundType == "amount" }]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">Menge</span>
              </td>
              <td class="listheader" height="15">&nbsp;&nbsp;&nbsp;[{ oxmultilang ident="GENERAL_ITEMNR" }]</td>
              <td class="listheader">&nbsp;&nbsp;&nbsp;[{ oxmultilang ident="GENERAL_TITLE" }]</td>
              <td class="listheader">[{ oxmultilang ident="ORDER_ARTICLE_EBRUTTO" }]</td>
              <td class="listheader">[{ oxmultilang ident="GENERAL_ATALL" }]</td>
              <td class="listheader" colspan="3">&nbsp;</td>
            </tr>
            [{assign var="blWhite" value=""}]
            [{foreach from=$edit->getOrderArticles() item=listitem name=orderArticles}]
            <tr id="art.[{$smarty.foreach.orderArticles.iteration}]">
            [{ if $listitem->oxorderarticles__oxstorno->value == 1 }]
              [{assign var="listclass" value=listitem3 }]
            [{else}]
              [{assign var="listclass" value=listitem$blWhite }]
            [{/if}]
              <td class="[{ $listclass}]">
                <span class="refundAmount" style="display:[{ if $refundType == "amount" }]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">[{ if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle() }]<input size="5" type="text" name="aOrderArticles[[{$listitem->getId()}]][oxamount]" value="[{ $listitem->getBrutPriceFormated() }]" class="listedit">[{else}][{ $listitem->getBrutPriceFormated() }][{/if}] <small>[{ $edit->oxorder__oxcurrency->value }]</small></span>
                <span class="refundQuantity" style="display:[{ if $refundType == "amount" }]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">[{ if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle() }]<input size="5" type="text" name="aOrderArticles[[{$listitem->getId()}]][oxquantity]" value="[{ $listitem->oxorderarticles__oxamount->value }]" class="listedit">[{else}][{ $listitem->oxorderarticles__oxamount->value }][{/if}]</span>
              </td>
              <td class="[{ $listclass}]" height="15">[{ $listitem->oxorderarticles__oxartnum->value }]</td>
              <td class="[{ $listclass}]">[{ $listitem->oxorderarticles__oxtitle->value|oxtruncate:20:""|strip_tags }]</td>
              <td class="[{ $listclass}]">[{ $listitem->getBrutPriceFormated() }] <small>[{ $edit->oxorder__oxcurrency->value }]</small></td>
              <td class="[{ $listclass}]">[{ $listitem->getTotalBrutPriceFormated() }] <small>[{ $edit->oxorder__oxcurrency->value }]</small></td>
              <td class="[{ $listclass}]" colspan="3">
                 [{ if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle() }]
                   <span class="refundAmount" style="display:[{ if $refundType == "amount" }]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">
                      [{ if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle() }]
                      <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgIdealoDisable(this.checked ,'partieRefund[{$smarty.foreach.orderArticles.iteration}]');" />
                      <button id="partieRefund[{$smarty.foreach.orderArticles.iteration}]" disabled=" true" onclick="this.form.fnc.value='partieRefund';this.form.workid.value='[{$listitem->getId()}]';">Teilerstattung</button>
                      [{/if}]
                   </span>
                   <span class="refundQuantity" style="display:[{ if $refundType == "amount" }]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">
                     [{ if $listitem->oxorderarticles__oxstorno->value != 1 && !$listitem->isBundle() }]
                       <select name="aOrderArticles[[{$listitem->getId()}]][storno]" size="1" onchange="Javascript:dgIdealoDisable(this.options[this.selectedIndex].value, 'partieStorno[{$smarty.foreach.orderArticles.iteration}]');">
                         <option value="" selected="true"> - bitte w&auml;hlen -</option>
                         <option value="MERCHANT_DECLINE">H&auml;ndler hat storniert</option>
                         <option value="CUSTOMER_REVOKE">Kunde hat widerrufen</option>
                         <option value="RETOUR">Retoure</option>
                       </select>
                       <button id="partieStorno[{$smarty.foreach.orderArticles.iteration}]" disabled="true" onclick="this.form.fnc.value='partieStorno';this.form.workid.value='[{$listitem->getId()}]';">Stornierung</button>
                     [{/if}]
                   </span>
                 [{/if}]
              </td>
            </tr>
            [{ if $oView->dgIdealoOrderArticle($listitem->getId(),'refund') || $oView->dgIdealoOrderArticle($listitem->getId(),'storno') }]
            <tr>
              <td class="[{ $listclass}]" colspan="8">
                [{ if $oView->dgIdealoOrderArticle($listitem->getId(),'refund') }]
                   [{assign var="oIdealoArticle" value=$oView->dgIdealoOrderArticle($listitem->getId(),'refund') }]
                   <span class="refundAmount" style="line-height: 24px;display:[{ if $refundType == "amount" }]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];">Erstattung durchgef&uuml;hrt am [{$oIdealoArticle->dgidealoorderarticle__oxrefundsent|oxformdate }] &uuml;ber [{$oIdealoArticle->dgidealoorderarticle__oxrefundamount->value }] <small>[{ $edit->oxorder__oxcurrency->value }]</small></span>
                [{/if}]
                [{ if $oView->dgIdealoOrderArticle($listitem->getId(),'storno')}]
                  [{assign var="oIdealoArticle" value=$oView->dgIdealoOrderArticle($listitem->getId(),'storno') }]
                  <span class="refundQuantity" style="line-height: 24px;display:[{ if $refundType == "amount" }]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];">[{$oIdealoArticle->dgidealoorderarticle__oxrevocationamount->value }] Artikel storniert am [{$oIdealoArticle->dgidealoorderarticle__oxrevocationsent|oxformdate }], Grund: [{ if $oIdealoArticle->dgidealoorderarticle__oxrevocationreason->value == "MERCHANT_DECLINE"}]H&auml;ndler hat storniert[{ elseif $oIdealoArticle->dgidealoorderarticle__oxrevocationreason->value == "CUSTOMER_REVOKE"}]Kunde hat widerrufen[{ elseif $oIdealoArticle->dgidealoorderarticle__oxrevocationreason->value == "RETOUR"}]Retoure[{else}]-[{/if}] </span>
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
            [{ if $edit->oxorder__oxdelcost->value}]
            <tr id="art.99">
              <td class="listitem[{ $listclass}]">
                <span class="refundAmount" style="display:[{ if $refundType == "amount" }]block[{elseif $refundType == "quantity"}]none[{else}]block[{/if}];"><input size="5" type="text" name="aOrderArticles[oxdelcost][oxamount]" value="[{ $edit->getFormattedeliveryCost() }]" class="listedit" disabled="true" /> <small>[{ $edit->oxorder__oxcurrency->value }]</small></span>
                <span class="refundQuantity" style="display:[{ if $refundType == "amount" }]none[{elseif $refundType == "quantity"}]block[{else}]none[{/if}];"><input size="5" type="text" name="aOrderArticles[oxamount][oxquantity]" value="1" class="listedit" disabled="true" /></span>
              </td>
              <td class="listitem[{ $listclass}]" height="15">-</td>
              <td class="listitem[{ $listclass}]">Versandkosten</td>
              <td class="listitem[{ $listclass}]">[{ $oIdealo->getFormattedeliveryCost() }] <small>[{ $edit->oxorder__oxcurrency->value }]</small></td>
              <td class="listitem[{ $listclass}]">[{ $oIdealo->getFormattedeliveryCost() }] <small>[{ $edit->oxorder__oxcurrency->value }]</small></td>
              <td class="listitem[{ $listclass}]" colspan="3"></td>
            </tr>
            [{/if}]
          </table>
      </fieldset>
      
      <fieldset>
        <legend>Vollst&auml;ndige Stornierung</legend>
           [{ if $oIdealo->dgidealoordermarge__oxrevocationsent->value == "0000-00-00 00:00:00" }]
             <span>
                <select name="storno" size="1" onchange="Javascript:dgIdealoDisable(this.options[this.selectedIndex].value, 'FullStorno');">
                   <option value="" selected="true"> - bitte w&auml;hlen -</option>
                   <option value="MERCHANT_DECLINE">H&auml;ndler hat storniert</option>
                   <option value="CUSTOMER_REVOKE">Kunde hat widerrufen</option>
                   <option value="RETOUR">Retoure</option>
                </select>
             </span>
             <button id="FullStorno" type="submit" onclick="this.form.fnc.value='FullStorno';" disabled="true">Stornierung durchf&uuml;hren</button>
           [{else}]
           <span>Storniert am [{ $oIdealo->dgidealoordermarge__oxrevocationsent|oxformdate }], Grund: [{ if $oIdealo->dgidealoordermarge__oxrevocationreason->value == "MERCHANT_DECLINE"}]H&auml;ndler hat storniert[{ elseif $oIdealo->dgidealoordermarge__oxrevocationreason->value == "CUSTOMER_REVOKE"}]Kunde hat widerrufen[{ elseif $oIdealo->dgidealoordermarge__oxrevocationreason->value == "RETOUR"}]Retoure[{else}]-[{/if}]</span>
           [{/if}]
      </fieldset>
      
      [{ if $oView->getRefunds()|count}]
      <fieldset>
        <legend>&Uuml;bersicht R&uuml;ckerstattungen</legend>
           <table cellspacing="0" cellpadding="4" border="0" width="98%">
            <tr>
              <td class="listheader first">erstellt </td>
              <td class="listheader">aktualisiert</td>
              <td class="listheader">Betrag</td>
              <td class="listheader">Begr&uuml;ndungstext</td>
              <td class="listheader">Idealo R&uuml;ckerstattungsid</td>
              <td class="listheader">Status</td>
            </tr>
            [{assign var="blWhite" value="2"}]
            [{foreach from=$oView->getRefunds() item=oRefund }]
             [{if $blWhite == "2"}]
              [{assign var="blWhite" value=""}]
            [{else}]
              [{assign var="blWhite" value="2"}]
            [{/if}]
            <tr>
              <td class="listitem[{ $blWhite}]">[{$oView->dgIdealoTime($oRefund.created)|oxformdate}]</td>
              <td class="listitem[{ $blWhite}]">[{$oView->dgIdealoTime($oRefund.updated)|oxformdate}]</td>
              <td class="listitem[{ $blWhite}]" style="text-align:right;">[{  $oView->getFormattedSum($oRefund.refundAmount)}] [{$oRefund.currency}]</td>
              <td class="listitem[{ $blWhite}]">[{$oRefund.failureReason}]</td>
              <td class="listitem[{ $blWhite}]">[{$oRefund.refundId}]</td>
              <td class="listitem[{ $blWhite}]">[{$oRefund.status}]</td>
            </tr>
            [{/foreach}]
            </table>
      </fieldset>
      [{/if}]
      

      <fieldset>
        <legend>Vollst&auml;ndige R&uuml;ckerstattung</legend>
         [{ if $oIdealo->dgidealoordermarge__oxpayment->value == "PAYPAL" }]
            <span>
              Bezahlung &uuml;ber PayPal, bitte die R&uuml;ckerstattung &uuml;ber PayPal direkt ausf&uuml;hren.<br /><br />
              id: [{ $edit->oxorder__oxtransid->value }] / Betrag:  [{$oIdealo->getFormattedTotalRefundSum()}] <small>[{if $edit->oxorder__oxcurrency->value}] [{$edit->oxorder__oxcurrency->value}] [{else}] &euro; [{/if}]</small> &nbsp; 
              <a href="https://www.paypal.com/activity/payment/[{ $edit->oxorder__oxtransid->value }]" target="_blank"><b><em>Paypal &ouml;ffnen</em></b></a>
            </span>
         [{elseif $oIdealo->dgidealoordermarge__oxpayment->value == "SOFORT" }]
            <span>
              Bezahlung &uuml;ber SOFORT, bitte die R&uuml;ckerstattung &uuml;ber Sofort&uuml;berweisung direkt ausf&uuml;hren.<br /><br />
              id: [{ $edit->oxorder__oxtransid->value }] / Betrag:  [{$oIdealo->getFormattedTotalRefundSum()}] <small>[{if $edit->oxorder__oxcurrency->value}] [{$edit->oxorder__oxcurrency->value}] [{else}] &euro; [{/if}]</small> &nbsp; 
              <a href="https://www.sofort.com/payment/transactions?data[Transaction][transaction]=[{ $edit->oxorder__oxtransid->value }]" target="_blank"><b><em>SOFORT &ouml;ffnen</em></b></a>
            </span>
         [{else}]
           [{ if $oIdealo->dgidealoordermarge__oxrefundsent->value == "0000-00-00 00:00:00" }]
             <span>Erstattung durchf&uuml;hren &uuml;ber Betrag von: [{$oIdealo->getFormattedTotalRefundSum()}] <small>[{if $edit->oxorder__oxcurrency->value}] [{$edit->oxorder__oxcurrency->value}] [{else}] &euro; [{/if}]</small></span><br /><br />
             <input type="checkbox" name="ok" value="import" class="edittext" onclick="Javascript:dgIdealoDisable(this.checked ,'FullRefund');" />
             <button id="FullRefund" type="submit" onclick="this.form.fnc.value='FullRefund';" disabled="true">Erstattung durchf&uuml;hren</button>
           [{else}]
             <span>Erstattung am [{ $oIdealo->dgidealoordermarge__oxrefundsent|oxformdate }]</span>
           [{/if}]
         [{/if}]
      </fieldset>
      
      
      
    [{/if}]
   </td>
 </tr>
</table>

</form>
[{/if}]
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
