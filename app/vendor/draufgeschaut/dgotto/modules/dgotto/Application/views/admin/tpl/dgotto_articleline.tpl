[{assign var="blactiv" value=false}]
[{if $product->oxarticles__oxvarcount->value <= 0}]
  [{assign var="blactiv" value=true}]
[{/if}]
[{oxscript add="$('.oxtitle').bind( 'keyup change', function(e){ 
    if( $(this).val().length == 0 ) { 
        $(this).closest('td').next('td').find('span.lenght').html( '(' + $(this).attr('placeholder').length + '/50)'); 
        if( $(this).attr('placeholder').length > 50 ) 
        { 
            $(this).css('background-color', '#eed4d4'); 
        }
        else
        {
            $(this).css('background-color', '#fff'); 
        }
    }
    else
    { 
        $(this).closest('td').next('td').find('span.lenght').html( '(' + $(this).val().length + '/50)'); 
        if( $(this).val().length > 50 ) 
        { 
            $(this).css('background-color', '#eed4d4'); 
        }
        else
        {
            $(this).css('background-color', '#fff'); 
        }
    }
     });" priority=10}]

<tr>
   <td class="listitem[{$oddclass}]"><a onclick="showPleaseWait();" href="[{$oViewConf->getSelfLink()}]oxid=[{$product->oxarticles__oxid->value}]&cl=dgotto_article&aStep=hook&pgNr=[{$oView->getActPage()}]" class="[{$listclass}]" [{include file="help.tpl" helpid=editvariant}] ><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
         
   <td class="listitem[{$oddclass}][{if $oOtto->getOttoParam('dgOttoSqlHook') != "oxactive" && $oOtto->getOttoParam('dgOttoSqlHook') != ""}] aiotto[{/if}]" nowrap>[{if $oOtto->getOttoParam('dgOttoSqlHook') != ""}][{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoSqlHook')|lower}]<input type="hidden" name="variants[[{$product->getId()}]][[{$aField}]]" value="0" /><input type="checkbox" name="variants[[{$product->getId()}]][[{$aField}]]" value="1" title="[{oxmultilang ident="GENERAL_ARTICLE_"|cat:$oOtto->getOttoParam('dgOttoSqlHook')|upper}] markieren" [{if $product->oxarticles__checked->value == 1 || $product->oxarticles__checked->rawValue == 1 || $product->$aField->value == 1}]checked[{/if}]>[{/if}]</td>
   
   [{if $oOtto->getOttoParam('dgOttoSqlHook') != "oxactive"}]
   <td class="listitem[{$oddclass}]" nowrap="true"><input type="hidden" name="variants[[{$product->getId()}]][oxarticles__oxactive]" value="0" /><input type="checkbox" name="variants[[{$product->getId()}]][oxarticles__oxactive]" value="[{$product->oxarticles__oxactive->value ]}]" value="1" [{if $product->oxarticles__oxactive->value == 1 }]checked[{/if}] title="im Shop aktiv" /></td>
   [{/if}]
  
   [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoSkuField')|lower}]
   <td class="listitem[{$oddclass}]" nowrap="true"><input class="editinput" size="15" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{$product->$aField->value ]}]" /></td>
   
   [{assign var="aField" value="oxarticles__oxtitle"}]
   [{if $product->oxarticles__oxparentid->value && $product->getId() != $edit->getId()}]
     <td class="listitem[{$oddclass}]" nowrap="true"><input class="editinput oxtitle" maxlength="75" size="50" name="multiattr[[{$product->getId()}]][oxtitle]" value="[{$edit->oxtitle ]}]" placeholder="[{$edit->$aField->value ]}][{if $edit->oxarticles__oxparentid->value}][{foreach from=$oView->getSelects($product) item=varsel}], [{$varsel->orgtype}] [{$varsel->orgvalue}][{/foreach}][{/if}]" readonly="true" disabled="true" /></td>
     <td class="listitem[{$oddclass}]" nowrap="true"><span class="lenght">([{if $edit->oxtitle}][{$edit->oxtitle|strlen}][{else}][{$edit->$aField->value|strlen}][{/if}]/50)</span></td>
   [{else}]
     <td class="listitem[{$oddclass}]" nowrap="true"><input class="editinput oxtitle" maxlength="75" size="50" name="multiattr[[{$product->getId()}]][oxtitle]" value="[{$product->oxtitle ]}]" placeholder="[{$product->$aField->value ]}][{if $product->oxarticles__oxparentid->value}][{foreach from=$oView->getSelects($product) item=varsel}], [{$varsel->orgtype}] [{$varsel->orgvalue}][{/foreach}][{/if}]" style="background-color: [{if $product->oxtitle|strlen > 50}]#eed4d4[{else}]#fff[{/if}];" /></td>
     <td class="listitem[{$oddclass}]" nowrap="true"><span class="lenght">([{if $product->oxtitle}][{$product->oxtitle|strlen}][{else}][{$product->$aField->value|strlen}][{/if}]/50)</span></td>
   [{/if}]
   [{if $product->oxarticles__oxparentid->value}]
     [{foreach from=$oView->getSelects($product) item=varsel}]
       [{assign var="aField" value=$varsel->type}]
       <td class="listitem[{$oddclass}]" nowrap="true"><input class="editinput" size="20" name="multiattr[[{$product->getId()}]][oxvarselect][]" placeholder="[{$varsel->orgvalue}]" value="[{$varsel->value}]"/></td>
     [{/foreach}]
   [{else}]
     [{assign var="aField" value="oxarticles__oxvarselect"}]
     [{assign var="addCols" value=0}][{foreach from=$oView->getSelects($product) item=varsel}][{assign var="addCols" value=$addCols+1}][{/foreach}]
     <td class="listitem[{$oddclass}]" [{if $addCols > 1}]colspan="[{$addCols}]" [{/if}] nowrap="true"><input class="editinput" size="[{if $addCols > 1}][{$addCols*22}][{else}]20[{/if}]" value="[{$product->$aField->value}]" disabled="true"  /></td>
   [{/if}]
   
   [{if $oOtto->getOttoParam('dgOttoUsePrice') != "" }]
   [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoUsePrice')|replace:"brutprice":"oxprice"}]
   <td class="listitem" nowrap="true"><input class="editinput" size="4" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{if $blactiv}][{$product->$aField->value ]}][{/if}]" [{if $product->oxarticles__oxvarcount->value > 0}]disabled="true"[{/if}]  />&nbsp;[{$currency->sign}]</td>
   [{/if}]
   
   [{if $oOtto->getOttoParam('dgOttoUseTPrice') != "" }]
   [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoUseTPrice')}]
   <td class="listitem[{$oddclass}]" nowrap><input class="editinput" size="4" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{if $blactiv}][{$product->$aField->value ]}][{/if}]" [{if $product->oxarticles__oxvarcount->value > 0}]disabled="true"[{/if}]  />&nbsp;[{$currency->sign}]</td> 
   [{/if}]
   
   <td class="listitem[{$oddclass}]" nowrap align="right"><em>[{if $blactiv}][{if $product->ftprice}][{$product->ftprice}]&nbsp;[{$edit->fsign}][{/if}][{/if}]</em> &nbsp;</td>
   <td class="listitem[{$oddclass}]" nowrap align="right"><em>[{if $blactiv}][{$product->fprice}]&nbsp;[{$edit->fsign}][{/if}]</em> &nbsp;</td>
   <td class="listitem[{$oddclass}]" nowrap align="right"><em>[{if $blactiv}][{$product->fstock}] St. / [{$product->fdays}] Tg.[{/if}]</em> &nbsp;</td>
   [{if $oOtto->getOttoParam('dgOttoMoin') != ""}]
   [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoMoin')|lower}]
   <td class="listitem[{$oddclass}]" nowrap><input class="editinput" size="15" [{if $blactiv}]name="variants[[{$product->getId()}]][[{$aField}]]"[{else}]disabled="true"[{/if}] value="[{if $blactiv}][{$product->$aField->value ]}][{/if}]" /></td>                 
   [{/if}]    
   [{if $oOtto->getOttoParam('dgOttoEanField') != ""}]
   [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoEanField')|lower}]
   <td class="listitem[{$oddclass}]" nowrap><input class="editinput" size="15" [{if $blactiv}]name="variants[[{$product->getId()}]][[{$aField}]]"[{else}]disabled="true"[{/if}] value="[{if $blactiv}][{$product->$aField->value ]}][{/if}]" /></td>                 
   [{/if}] 
   

     
   <td class="listitem[{$oddclass}]"><input size="15" name="variants[[{$product->getId()}]][oxarticles__oxdelivery]" value="[{if $blactiv}][{$product->oxarticles__oxdelivery->value ]}][{/if}]" [{if $product->oxarticles__oxvarcount->value > 0}]disabled="true"[{/if}] /></td>
   
   [{if $dgOttoShowArticleFields}]
    [{foreach from=$dgOttoShowArticleFields item=name}]
   [{if $name|lower|trim|rtrim|strip_tags != ""}]
    <td class="listitem">[{*$product->$aField->fldtype *}]
      [{assign var="aField" value="oxarticles__"|cat:$name|lower|trim|rtrim|strip_tags}]
      [{if $aField == "oxarticles__oxstockflag"}]
      <select class="editinput" name="variants[[{$product->getId()}]][oxarticles__oxstockflag]" class="editinput" [{if $product->oxarticles__oxvarcount->value > 0 && !$blVariantParentBuyable}]disabled="true"[{/if}]>
        <option value="1" [{if $product->oxarticles__oxstockflag->value == 1}]SELECTED[{/if}]>[{oxmultilang ident="GENERAL_STANDARD"}]</option>
        <option value="4" [{if $product->oxarticles__oxstockflag->value == 4}]SELECTED[{/if}]>[{oxmultilang ident="GENERAL_EXTERNALSTOCK"}]</option>
        <option value="2" [{if $product->oxarticles__oxstockflag->value == 2}]SELECTED[{/if}]>[{oxmultilang ident="GENERAL_OFFLINE"}]</option>
        <option value="3" [{if $product->oxarticles__oxstockflag->value == 3}]SELECTED[{/if}]>[{oxmultilang ident="GENERAL_NONORDER"}]</option>
      </select>
      [{elseif $aField == "oxarticles__oxstock"}]
        <input class="editinput" size="10" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{$product->$aField->value ]}]" [{if $product->oxarticles__oxvarcount->value > 0 && !$blVariantParentBuyable}]disabled="true"[{/if}]/>
      [{elseif $aField == "oxarticles__oxdeltimeunit"}]
         <select class="editinput" name="variants[[{$product->getId()}]][[{$aField}]]" class="editinput">
           <option value="" [{if $product->$aField->value == ""}]SELECTED[{/if}]> - </option>
           <option value="DAY" [{if $product->$aField->value == "DAY"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_DAYS"}]</option>
           <option value="WEEK" [{if $product->$aField->value == "WEEK"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_WEEKS"}]</option>
           <option value="MONTH" [{if $product->$aField->value == "MONTH"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_MONTHS"}]</option>
         </select>  
      [{elseif $aField == "oxarticles__oxmaxdeltime"}]
        <input class="editinput" size="2" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{$product->$aField->value ]}]" [{if $product->oxarticles__oxvarcount->value > 0 && !$blVariantParentBuyable}]disabled="true"[{/if}]/>

         <select class="editinput" name="variants[[{$product->getId()}]][oxarticles__oxdeltimeunit]" class="editinput">
           <option value="" [{if $product->oxarticles__oxdeltimeunit->value == ""}]SELECTED[{/if}]> - </option>
           <option value="DAY" [{if $product->oxarticles__oxdeltimeunit->value == "DAY"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_DAYS"}]</option>
           <option value="WEEK" [{if $product->oxarticles__oxdeltimeunit->value == "WEEK"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_WEEKS"}]</option>
           <option value="MONTH" [{if $product->oxarticles__oxdeltimeunit->value == "MONTH"}]SELECTED[{/if}]>[{oxmultilang ident="ARTICLE_STOCK_MONTHS"}]</option>
         </select>  
      [{else}]
         [{if $product->$aField->fldtype == "double" || $product->$aField->fldtype == "int"}]
            <input class="editinput" size="5" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{$product->$aField->value ]}]" [{if $product->oxarticles__oxvarcount->value > 0 && !$blVariantParentBuyable}]disabled="true"[{/if}]/>
         [{elseif $product->$aField->fldtype == "tinyint"}]
            <input class="editinput" type="hidden" name="variants[[{$product->getId()}]][[{$aField}]]" value="0" />
            <input class="editinput" type="checkbox" name="variants[[{$product->getId()}]][[{$aField}]]" value="1" [{if $product->$aField->value == 1}]checked[{/if}]/>
         [{else}]
           
           <input class="editinput" maxlength="[{$product->$aField->fldmax_length}]" size="[{if $product->$aField->fldmax_length > 10}]20[{else}]5[{/if}]" name="variants[[{$product->getId()}]][[{$aField}]]" value="[{$product->$aField->value ]}]" />
         [{/if}]
      [{/if}]
    </td>
    [{/if}]
   [{/foreach}]
   
   
   [{/if}]
   
   [{if $dgMoveAttribute2Toplist}]
     [{foreach from=$dgMoveAttribute2Toplist item=oTopList}]
       [{foreach from=$dgOttoCategorySpecifics item=oSpecifics}]
         [{if $oSpecifics->dgottoattributes__oxname->value == $oTopList && !$oView->isRemoveFromAttribute($product,$oTopList)}]
            [{assign var="colspan" value=$colspan+1}]<td class="listitem[{$oddclass}]" nowrap>[{$oSpecifics->getHtml($product,true,'editattr',true)}]</td>
         [{/if}]
       [{/foreach}]   
     [{/foreach}]
   [{/if}]
   
   [{assign var="blactiv" value=false}]
      [{if $product->dgottohistory__oxactive->value == 1}]
      [{assign var="blactiv" value=true}]
   [{/if}]
   
   [{if $product->oxarticles__oxvarcount->value > 0}]
     <td class="listitem[{$oddclass}]"> &nbsp; </td>
   [{elseif $blactiv}]
     <td class="listitem[{$oddclass}]">
       <button title="Artikel anlegen" 
        onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendUpdate';this.form.workid.value='[{$product->getId()}]';return confirm('Wollen Sie Artikel anlegen wirklich ausf&uuml;hren ?');" 
        class="[{if $product->dgottohistory__oxproducttime->value != "0000-00-00 00:00:00"}]greenbutton[{else}][{/if}]">
          A
       </button>
     </td>
   [{else}]
   <td class="listitem[{$oddclass}]"><button title="Artikel anlegen" disabled="true">A</button></td>
   [{/if}]
   
   [{if $product->oxarticles__oxvarcount->value > 0}]
     <td class="listitem[{$oddclass}]"> &nbsp; </td>
   [{elseif $blactiv}]
     <td class="listitem[{$oddclass}]">
       <button type="submit" title="Lager updaten" 
        onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendStock';this.form.workid.value='[{$product->getId()}]';return confirm('Wollen Sie Lager updaten wirklich ausf&uuml;hren ?');" 
        class="[{if $product->dgottohistory__oxstocktime->value != "0000-00-00 00:00:00"}]greenbutton[{else}][{/if}]">L</button>
     </td>
   [{else}]
     <td class="listitem[{$oddclass}]"><button title="Lager updaten" disabled="true">L</button></td>
   [{/if}]
   
   [{if $product->oxarticles__oxvarcount->value > 0}]
     <td class="listitem[{$oddclass}]"> &nbsp; </td>
   [{elseif $blactiv}]
     <td class="listitem[{$oddclass}]">
       <button type="submit" title="Preise updaten" 
        onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendPrice';this.form.workid.value='[{$product->getId()}]';return confirm('Wollen Sie Preise updaten wirklich ausf&uuml;hren ?');" 
        class="[{if $product->dgottohistory__oxpricetime->value != "0000-00-00 00:00:00"}]greenbutton[{else}][{/if}]">P</button>
     </td>
   [{else}]
     <td class="listitem[{$oddclass}]"><button title="Preise updaten" disabled="true">P</button></td>
   [{/if}]   
   
   [{if $product->oxarticles__oxvarcount->value > 0}]
     <td class="listitem[{$oddclass}]"> &nbsp; </td>
   [{elseif $blactiv}]
     <td class="listitem[{$oddclass}]">
       <button type="submit" title="aktiv updaten" 
        onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendActiv';this.form.workid.value='[{$product->getId()}]';return confirm('Wollen Sie aktiv updaten wirklich ausf&uuml;hren ?');" 
        class="[{if $product->dgottohistory__oxactivtime->value != "0000-00-00 00:00:00"}]greenbutton[{else}]redbutton[{/if}]"><span style="color: green">O</span></button></td>
   [{else}]
     <td class="listitem[{$oddclass}]"><button title="aktiv updaten" disabled="true">O</button></td>
   [{/if}]
   
   [{if $product->oxarticles__oxvarcount->value > 0}]
     <td class="listitem[{$oddclass}]"> &nbsp; </td>
   [{elseif $blactiv}]
     <td class="listitem[{$oddclass}]">
       <button type="submit" title="inaktiv updaten" 
        onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendInActiv';this.form.workid.value='[{$product->getId()}]';return confirm('Wollen Sie inaktiv updaten wirklich ausf&uuml;hren ?');" 
        class="[{if $product->dgottohistory__oxactivtime->value != "0000-00-00 00:00:00"}]greenbutton[{else}]redbutton[{/if}]"><span style="color: red">O</span></button></td>
   [{else}]
     <td class="listitem[{$oddclass}]"><button title="inaktiv updaten" disabled="true">O</button></td>
   [{/if}]
   
   
   <td>[{if $product->dgottohistory__OXPRODUCT->value}]<a href="https://portal.otto.market/products/productMaintenance/[{$product->dgottohistory__oxottoid->value}]" target="_blank">&#10150;</a>[{/if}]</td>
   
</tr>
































