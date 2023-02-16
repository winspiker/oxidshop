      [{if $dgOttoCategorySpecifics}] 
            <div class="groupExp">
              <div [{if $aStep == "Artikelmerkmale"}] class="exp"[{/if}]>
                <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Attribute</b></a>
                  <dl>
                    <dt>
                    <fieldset>
                      <legend>Standard Attribute</legend>
                         <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                           <input type="hidden" value="false" name="editattr[[{$edit->getId()}]][multiPack]" />
                           <input type="checkbox" id="multiPack" value="true" name="editattr[[{$edit->getId()}]][multiPack]" [{if $edit->multiPack == "true"}] checked[{/if}]/><label for="multiPack"> Multipack</label>
                         </div>
                          
                          <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                           <input type="hidden" value="false" name="editattr[[{$edit->getId()}]][fscCertified]" />
                           <input type="checkbox" id="fscCertified" value="true" name="editattr[[{$edit->getId()}]][fscCertified]" [{if $edit->fscCertified == "true"}] checked[{/if}]/><label for="fscCertified"> FSC Certified</label>
                          </div>
                          
                          <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                           <input type="hidden" value="false" name="editattr[[{$edit->getId()}]][bundle]" />
                           <input type="checkbox" id="bundle" value="true" name="editattr[[{$edit->getId()}]][bundle]" [{if $edit->bundle == "true"}] checked[{/if}]/><label for="bundle"> Bundle</label>
                          </div>
                          
                          <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                            <input type="hidden" value="false" name="editattr[[{$edit->getId()}]][disposal]" />
                           <input type="checkbox" id="disposal" value="true" name="editattr[[{$edit->getId()}]][disposal]" [{if $edit->disposal == "true"}] checked[{/if}]/><label for="disposal"> Entsorgungshinweis</label>
                          </div> 
                     </fieldset>
                     
                     <fieldset>
                      <legend>Verkauseinheit</legend>                         
                          <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                            <table>
                              <tr>
                                <td>
                                  <label for="salesAmount">Verkaufsmenge</label><br />
                                  <input id="salesAmount" name="editattr[[{$edit->getId()}]][salesAmount]" value="[{$edit->salesAmount}]" />
                                </td>
                                <td>
                                  <label for="salesUnit">Verkaufseinheit</label><br />
                                  <select id="salesUnit" name="editattr[[{$edit->getId()}]][salesUnit]">
			                        <option value="">Bitte ausw&auml;hlen</option>
			                        <option value="g"[{if $edit->salesUnit == "g"}] selected[{/if}]>Gramm</option>
			                        <option value="kg"[{if $edit->salesUnit == "kg"}] selected[{/if}]>Kilogramm</option>
			                        <option value="dm3"[{if $edit->salesUnit == "dm3"}] selected[{/if}]>Kubikdezimeter</option>
			                        <option value="l"[{if $edit->salesUnit == "l"}] selected[{/if}]>Liter</option>
			                        <option value="m"[{if $edit->salesUnit == "m"}] selected[{/if}]>Meter</option>
			                        <option value="ml"[{if $edit->salesUnit == "ml"}] selected[{/if}]>Milliliter</option>
			                        <option value="Paar"[{if $edit->salesUnit == "Paar"}] selected[{/if}]>Paar</option>
			                        <option value="qm"[{if $edit->salesUnit == "qm"}] selected[{/if}]>Quadratmeter</option>
			                        <option value="RM"[{if $edit->salesUnit == "RM"}] selected[{/if}]>Raummeter</option>
			                        <option value="Stk"[{if $edit->salesUnit == "Stk"}] selected[{/if}]>St&uuml;ck</option>
		                	      </select>
                                </td> 
                                <td>        
                                  <label for="normUnitAndAmount">Normmenge/Normeinheit</label><br />
                                  <select id="normUnitAndAmount" name="editattr[[{$edit->getId()}]][normUnitAndAmount]">
			                        <option value="">Bitte ausw&auml;hlen</option>
			                        <option value="g,1"[{if $edit->normUnitAndAmount == "g,1"}] selected[{/if}]>1 Gramm</option>
			                        <option value="g,100"[{if $edit->normUnitAndAmount == "g,100"}] selected[{/if}]>100 Gramm</option>
			                        <option value="g,1000"[{if $edit->normUnitAndAmount == "g,1000"}] selected[{/if}]>1000 Gramm</option>
			                        <option value="kg,1"[{if $edit->normUnitAndAmount == "kg,1"}] selected[{/if}]>1 Kilogramm</option>
			                        <option value="dm3,1"[{if $edit->normUnitAndAmount == "dm3,1"}] selected[{/if}]>1 Kubikdezimeter</option>
			                        <option value="l,1"[{if $edit->normUnitAndAmount == "l,1"}] selected[{/if}]>1 Liter</option>
			                        <option value="m,1"[{if $edit->normUnitAndAmount == "m,1"}] selected[{/if}]>1 Meter</option>
			                        <option value="ml,100"[{if $edit->normUnitAndAmount == "ml,100"}] selected[{/if}]>100 Milliliter</option>
			                        <option value="Paar,1"[{if $edit->normUnitAndAmount == "Paar,1g"}] selected[{/if}]>1 Paar</option>
			                        <option value="qm,1"[{if $edit->normUnitAndAmount == "qm,1"}] selected[{/if}]>1 Quadratmeter</option>
			                        <option value="RM,1"[{if $edit->normUnitAndAmount == "RM,1"}] selected[{/if}]>1 Raummeter</option>
			                        <option value="Stk,1"[{if $edit->normUnitAndAmount == "Stk,1"}] selected[{/if}]>1 St&uuml;ck</option>
			                      </select>
                                </td>
                                <td><br />
                                <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='Artikelmerkmale';this.form.fnc.value='saveAttribute'">Speichern</button>
                                </td>
                              </tr> 
                            </table>
                          </div>    
                     </fieldset>

                      [{assign var="ortgroup" value="empty"}]
                      [{foreach from=$dgOttoCategorySpecifics item=oSpecifics}]
                      [{if $ortgroup != $oSpecifics->dgottoattributes__oxattributegroup->value}]
                      [{if $ortgroupset}]
                      </fieldset>
                      [{/if}]
                      [{assign var="ortgroup" value=$oSpecifics->dgottoattributes__oxattributegroup->value}]
                      <fieldset>
                      <legend>[{$oSpecifics->dgottoattributes__oxattributegroup->value}]</legend>
                      [{assign var="ortgroupset" value=true}]
                      [{/if}]
                        <div style="min-height:46px; float:left;border: 1px solid #F0F0F0;padding:5px;">
                        [{$oSpecifics->getHtml($edit,false,'editattr',true)}]
                        [{if $oSpecifics->dgottocategoryspecifics__oxsource->value == 'oxid'}]
                        <a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&deleteid=[{$oSpecifics->getId()}]&fnc=deleteUserAttr&oxid=[{$oxid}]&aStep=Artikelmerkmale" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img width="18" src="[{$oViewConf->getModuleUrl('dgotto','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" title="[{$oSpecifics->dgottocategoryspecifics__oxname->value}] l&ouml;schen?" border=0></a>
                        [{/if}]
                       </div>
                      [{/foreach}]
                      [{if $ortgroupset}]
                      </fieldset>
                      [{/if}]
                      <div class="left">   
                        <ol style="list-style:none;width:300px;margin:0px;">
                          <li style="float:left;min-width:45%;display:block;margin:2px;"><span style="float:left;width: 13px; height: 13px;background: #FFD7CC; border: 1px solid grey;display:block;">&nbsp;</span> <span style="float:left;margin-left:5px;font-weight:100;">Plichtfeld</span></li>
                          <li style="float:left;min-width:45%;display:block;margin:2px;"><span style="float:left;width: 13px; height: 13px;background: #ECFFEE; border: 1px solid grey;display:block;">&nbsp;</span> <span style="float:left;margin-left:5px;font-weight:100;">erw&uuml;nscht</span></li>
                          <li style="float:left;min-width:45%;display:block;margin:2px;"><span style="float:left;width: 13px; height: 13px;background: #FAF8D7; border: 1px solid grey;display:block;">&nbsp;</span> <span style="float:left;margin-left:5px;font-weight:100;">eigenes</span></li>
                          <li style="float:left;min-width:45%;display:block;margin:2px;"><span style="float:left;width: 13px; height: 13px;background: #FFE6FF; border: 1px solid grey;display:block;">&nbsp;</span> <span style="float:left;margin-left:5px;font-weight:100;">Optional</span></li>
                        </ol>
                      </div>
                      <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
                        <tr>
                          <td class="edittext"><br /><br />
                           <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='Artikelmerkmale';this.form.fnc.value='saveAttribute'">[{oxmultilang ident="GENERAL_SAVE"}]</button><br />
                          </td>
                        </tr>
                      </table>
                    </dt>
                    <dd> </dd>
                    <div class="spacer"></div>
                  </dl>
              </div>
            </div>
      [{/if}]