 <div class="groupExp">
      <div [{if $aStep == "hook" || !$aStep}] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Artikel</b></a>
          <dl>
            <dd> 
              <table cellspacing="2" cellpadding="2" border="0" class="articlelist" bordercolor="red">
              [{assign var="colspan" value=1}]
              <tr>
                [{assign var="colspan" value=1}]<td class="listheader first"><a href="[{$oViewConf->getSelfLink()}]oxid=[{if $edit->oxarticles__oxparentid->value != ""}][{$edit->oxarticles__oxparentid->value}][{else}][{$edit->oxarticles__oxid->value}][{/if}]&cl=dgotto_article&aStep=hook&pgNr=[{$oView->getActPage()}]" class="[{$listclass}]"><img src="[{$oViewConf->getImageUrl()}]/editvariant.gif" width="15" height="15" alt="" border="0" align="absmiddle"></a></td>
                [{assign var="colspan" value=$colspan+1}]<td class="listheader"  nowrap="true" align="right">
                [{if $edit->oxarticles__oxvarcount->value > 0 && $oOtto->getOttoParam('dgOttoSqlHook') != ""}]<input type="checkbox" name="checkAll" onclick="_checkAll(this, 'oxarticles__[{$oOtto->getOttoParam('dgOttoSqlHook')}]]')" title="alle [{oxmultilang ident="GENERAL_ARTICLE_"|cat:$oOtto->getOttoParam('dgOttoSqlHook')|upper}] markieren"/>[{else}]&nbsp;[{/if}]</td>
                
                [{if $oOtto->getOttoParam('dgOttoSqlHook') != "oxactive" && $oOtto->getOttoParam('dgOttoSqlHook') != ""}]
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader " nowrap="true" title="Aktiv">A</td>
                [{/if}]
                [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true">Art.Nr. / SKU</td>
                
                [{assign var="colspan" value=$colspan+2}]<td class="listheader" nowrap="true" colspan="2">Name</td>
                
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                  [{foreach from=$oView->getSelects($edit) item=varsel}]
                    [{assign var="aField" value=$varsel->type}]
                    [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true">
                      <select size="1" id="[{$varsel->orgtype|md5}]"  name="editattr[[{$edit->getId()}]][oxvarname][]" onchange="showPleaseWait();this.form.fnc.value='saveSelects';this.form.submit();">
                      <option value="[{$varsel->orgtype}]"[{if $varsel->orgtype|lower == $demosel|lower}] selected[{/if}][{if $dgOttoCategories}][{if !$dgOttoCategories->isInVariationen($varsel->orgtype)}] disabled="true"[{/if}][{/if}]>[{$varsel->orgtype}]</option>
                     [{if $dgOttoCategories->dgottocategories__oxvariationthemes->value}] 
						[{foreach from=$dgOttoCategories->getVariationen() item=demosel}]
                          <option value="[{$demosel}]"[{if $varsel->orgtype|lower == $demosel|lower || $varsel->type|lower == $demosel|lower}] selected[{/if}]>[{$demosel}]</option>
						[{/foreach}]
                     [{/if}]
                  </td>
                  [{/foreach}]
                [{else}]
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true">Auswahl</td>
                [{/if}]
                
                [{if $oOtto->getOttoParam('dgOttoUsePrice') != "" }]
                [{assign var="colspan" value=$colspan+1}]<td class="listheader first" nowrap="true">Preis</td>
                [{/if}]
                
                [{if $oOtto->getOttoParam('dgOttoUseTPrice') != ""}]
                  [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true">UVP</td>
                [{/if}]
                  
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true" title="wird gesendet"> UVP </td>
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true" title="wird gesendet"> Preis </td>                
                

                 [{assign var="colspan" value=$colspan+1}]<td class="listheader" nowrap="true" title="wird gesendet"> Lager </td>
                [{if $oOtto->getOttoParam('dgOttoMoin') != ""}]
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader">Otto ID <em><small>(moin)</small></em></td>                 
                [{/if}]
                [{if $oOtto->getOttoParam('dgOttoEanField') != ""}]
                   [{assign var="colspan" value=$colspan+1}]<td class="listheader">EAN</td>                 
                [{/if}]
                

                
                [{assign var="colspan" value=$colspan+1}]<td class="listheader">wieder lieferbar</td>
                
                [{if $dgOttoShowArticleFields}]
                  [{foreach from=$dgOttoShowArticleFields item=name}]
                    [{if $name|lower|trim|rtrim|strip_tags != ""}]
                      [{assign var="ident" value=GENERAL_ARTICLE_$name}]
                      [{assign var="ident" value=$ident|upper|trim|rtrim|strip_tags}]
                      [{assign var="colspan" value=$colspan+1}]<td class="listheader">[{oxmultilang|oxtruncate:20:"..":true ident=$ident noerror=true alternative=$name}]</td> 
                    [{/if}]
                  [{/foreach}]
                [{/if}]
                
                [{if $dgMoveAttribute2Toplist}]
                   [{foreach from=$dgMoveAttribute2Toplist item=oTopList}]
                      [{foreach from=$dgOttoCategorySpecifics item=oSpecifics}]
                        [{if $oSpecifics->dgottoattributes__oxname->value == $oTopList && !$oView->isRemoveFromAttribute($edit,$oTopList)}]
                           [{assign var="colspan" value=$colspan+1}]<td class="listheader">[{$oTopList}]</td>
                        [{/if}]
                      [{/foreach}] 
                   [{/foreach}]
                [{/if}]
                                
                [{assign var="colspan" value=$colspan+1}]
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                   <td class="listheader headerbutton" style="text-align:center;padding:0;" title="alle Artikel anlegen & updaten">
                     <button onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendUpdate';this.form.workid.value='[{$edit->getId()}]';return confirm('Wollen Sie Artikel alle anlegen & updaten wirklich ausf&uuml;hren ?');">A</button>
                   </td>
                [{else}]
                   <td class="listheader" style="text-align:center;padding:0;" title="Artikel updaten & anlegen">
                       A
                   </td>
                [{/if}]
                
                [{assign var="colspan" value=$colspan+1}]
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                   <td class="listheader headerbutton" style="text-align:center;padding:0;" title="alle Lager updaten">
                     <button onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendStock';this.form.workid.value='[{$edit->getId()}]';return confirm('Wollen Sie Artikel alle Lager updaten wirklich ausf&uuml;hren ?');">L</button>
                   </td>
                [{else}]
                   <td class="listheader" style="text-align:center;padding:0;" title="Artikel Lager updaten">
                       L
                   </td>
                [{/if}]
                
                [{assign var="colspan" value=$colspan+1}]
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                   <td class="listheader headerbutton" style="text-align:center;padding:0;" title="alle Preise updaten">
                     <button onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendPrice';this.form.workid.value='[{$edit->getId()}]';return confirm('Wollen Sie Artikel alle Preis updaten wirklich ausf&uuml;hren ?');">P</button>
                   </td>
                [{else}]
                   <td class="listheader" style="text-align:center;padding:0;" title="alle Preise updaten">
                       P
                   </td>
                [{/if}]
                
                [{assign var="colspan" value=$colspan+1}]
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                   <td class="listheader headerbutton" style="text-align:center;padding:0;" title="alle aktiv">
                     <button onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendActiv';this.form.workid.value='[{$edit->getId()}]';return confirm('Wollen Sie Artikel alle aktiv wirklich ausf&uuml;hren ?');"><span style="color: green">O</span></button>
                   </td>
                [{else}]
                   <td class="listheader" style="text-align:center;padding:0;" title="Artikel aktiv">
                       <span style="color: green">O</span>
                   </td>
                [{/if}]
                
                [{assign var="colspan" value=$colspan+1}]
                [{if $edit->oxarticles__oxvarcount->value > 0}]
                   <td class="listheader headerbutton" style="text-align:center;padding:0;" title="alle inaktiv">
                     <button onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='sendInActiv';this.form.workid.value='[{$edit->getId()}]';return confirm('Wollen Sie Artikel alle inaktiv wirklich ausf&uuml;hren ?');"><span style="color: red">O</span></button>
                   </td>
                [{else}]
                   <td class="listheader" style="text-align:center;padding:0;" title="Artikel inaktiv">
                      <span style="color: red">O</span> 
                   </td>
                [{/if}]
                
                <td class="listheader" style="text-align:center;padding:0;">&nbsp;</td>
                [{assign var="colspan" value=$colspan+1}]
              </tr>
              [{include file="dgotto/dgotto_articleline.tpl" product=$edit oddclass=$oddclass}]                
              [{if $oxid!=-1 && $thisvariantlist}]
              [{assign var=oddclass value=""}]
              [{foreach from=$edit->aVariantList item=variant}]
                [{if $oddclass == 2}]
                  [{assign var=oddclass value=""}]
                [{else}]
                  [{assign var=oddclass value="2"}]
                [{/if}]
                [{include file="dgotto/dgotto_articleline.tpl" product=$variant oddclass=$oddclass}]
              [{/foreach}]
              [{assign var="pageNavigation" value=$oView->generatePageNavigation()}]
              [{if $pageNavigation->NrOfPages > 1}]
                    <tr>
                      <td colspan="[{$colspan}]" align="right">
                         <table width="100%">
                            <tr>
                              <td align="left" class="edittext">Seite [{$pageNavigation->actPage }] / [{$pageNavigation->NrOfPages }] ( [{$pageNavigation->iArtCnt}] Eintr&auml;ge )</td>
                              <td  align="right">[{if $pageNavigation->previousPage}]<a class="edittext" href="[{$oViewConf->getSelfLink()}]&cl=[{$oViewConf->getTopActiveClassName()}][{$pageNavigation->previousPage}]" >Seite zur&uuml;ck</a>[{/if}]
                                [{foreach key=iPage from=$pageNavigation->changePage item=page}]
                                [{if $iPage > ($pageNavigation->actPage - 10) && $iPage < ($pageNavigation->actPage + 10)}]
                                <a href="[{$oViewConf->getSelfLink()}]&cl=[{$oViewConf->getTopActiveClassName()}][{$page->url}]" class="[{if $iPage == $pageNavigation->actPage}]conftext2[{else}]edittext[{/if}]">[{$iPage}]</a>
                                [{/if}]
                                [{/foreach}]
                                [{if $pageNavigation->nextPage && $pageNavigation->nextPage != $pageNavigation->lastpage}] <a class="edittext" href="[{$oViewConf->getSelfLink()}]&cl=[{$oViewConf->getTopActiveClassName()}][{$pageNavigation->nextPage}]" >n&auml;chste Seite</a>[{/if}]
                                [{if $pageNavigation->lastpage}] <a class="edittext" href="[{$oViewConf->getSelfLink()}]&cl=[{$oViewConf->getTopActiveClassName()}][{$pageNavigation->lastpage}]" >letzte Seite</a>[{/if}]
                              </td>
                            </tr>
                         </table>
                      </td>
                    </tr>
                  [{/if}]                
              [{/if}]
              </table>
              <br />
              <button type="submit" onclick="showPleaseWait();this.form.aStep.value='hook';this.form.fnc.value='save';">Liste speichern</button>          
              &nbsp; &nbsp;
              [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoSkuField')|lower}]
               <a href="https://portal.otto.market/products/?searchTerm=[{$edit->$aField->value ]}]" target="_blank">Artikel in Otto ansehen</a>
           </dd>
         </dl>
        <div class="spacer"></div>
      </div>
    </div> 
    <script>
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
</script>