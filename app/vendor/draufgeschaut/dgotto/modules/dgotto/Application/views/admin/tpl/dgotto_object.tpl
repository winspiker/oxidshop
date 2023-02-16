[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{include file="dgotto/dgotto_head.tpl"}]

<form name="dgRemoveFromMoveTopList" id="dgRemoveFromMoveTopList" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" id="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
    <input type="hidden" name="fnc" value="dgRemoveFromMoveTopList" />
    <input type="hidden" name="theme" value="[{$oView->getOttoCategoryId($edit)}]" />
    <input type="hidden" name="atr" value="" />
    <input type="hidden" name="aStep" value="1" />
</form>

<form name="dgMoveAttribute2Toplist" id="dgMoveAttribute2Toplist" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" id="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
    <input type="hidden" name="fnc" value="dgMoveAttribute2Toplist" />
    <input type="hidden" name="theme" value="[{$oView->getOttoCategoryId($edit)}]" />
    <input type="hidden" name="atr" value="" />
    <input type="hidden" name="aStep" value="1" />
</form>

<form name="dgMoveAttributeTransfer" id="dgMoveAttributeTransfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" id="oxid" value="[{$oxid}]" />
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
    <input type="hidden" name="fnc" value="deleteArtFromList" />
    <input type="hidden" name="theme" value="[{$oView->getOttoCategoryId($edit)}]" />
    <input type="hidden" name="atr" value="" />
    <input type="hidden" name="catid" value="[{$dgottocategorysaveid}]" />
    <input type="hidden" name="aStep" value="1" />
</form>

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]" />
</form>

<div onclick="hidePleaseWait()" id="pleasewaiting"></div>

<form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]" />
<input type="hidden" name="fnc" value="" />
<input type="hidden" name="aStep" value="" />
<input type="hidden" name="oxid" value="[{$oxid}]" />
<input type="hidden" name="workid" value="" />
<input type="hidden" name="pgNr" value="[{$oView->getActPage()}]" />
       
<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
  <tr>
    <td valign="top" class="edittext" style="padding-left:10px;width:50%">
      [{if $oViewConf->getTopActiveClassName() == "dgotto_article"}]
        [{include file="dgotto/dgotto_articleerrorbox.tpl"}]
        [{if $oCategory}]
        [{include file="dgotto/dgotto_object2category.tpl" type="Artikel" title=$edit->oxarticles__oxtitle->value|truncate:30}]
        [{/if}]
        [{include file="dgotto/dgotto_product.tpl"}]
        [{include file="dgotto/dgotto_customfields.tpl" type="Artikel" title=$edit->oxarticles__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto2attribute.tpl" type="Artikel" title=$edit->oxarticles__oxtitle->value|truncate:30}] 
      [{elseif $oViewConf->getTopActiveClassName() == "dgotto_category"}]
        [{include file="dgotto/dgotto_object2category.tpl" type="Kategorie" title=$edit->oxcategories__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto_customfields.tpl" type="Kategorie" title=$edit->oxcategories__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto2attribute.tpl" type="Kategorie" title=$edit->oxcategories__oxtitle->value|truncate:30}] 
      [{elseif $oViewConf->getTopActiveClassName() == "dgotto_manufacturer"}]
        [{if $oOtto->getOttoParam('dgOttoBrandClass') == "oxManufacturer"}] 
          [{include file="dgotto/dgotto_object2brand.tpl" type="Hersteller" title=$edit->oxmanufacturers__oxtitle->value|truncate:30}]
        [{/if}]
        [{include file="dgotto/dgotto_object2category.tpl" type="Hersteller" title=$edit->oxmanufacturers__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto_customfields.tpl" type="Hersteller" title=$edit->oxmanufacturers__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto2attribute.tpl" type="Hersteller" title=$edit->oxmanufacturers__oxtitle->value|truncate:30}] 
      [{elseif $oViewConf->getTopActiveClassName() == "dgotto_vendor"}]
        [{if $oOtto->getOttoParam('dgOttoBrandClass') == "oxVendor"}] 
          [{include file="dgotto/dgotto_object2brand.tpl" type="Lieferant" title=$edit->oxvendor__oxtitle->value|truncate:30}]
        [{/if}]
        [{include file="dgotto/dgotto_object2category.tpl" type="Lieferant" title=$edit->oxvendor__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto_customfields.tpl" type="Lieferant" title=$edit->oxvendor__oxtitle->value|truncate:30}]
        [{include file="dgotto/dgotto2attribute.tpl" type="Lieferant" title=$edit->oxvendor__oxtitle->value|truncate:30}] 
      [{/if}]
    </td>
  </tr>
</table>
</form>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
