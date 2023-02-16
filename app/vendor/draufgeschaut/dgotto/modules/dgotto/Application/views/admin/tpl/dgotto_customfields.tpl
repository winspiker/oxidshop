[{assign var="maxBulletpointsLength" value="180"}]
[{oxscript add="$('.customfield').bind( 'keyup change', function(e){ 
    $(this).closest('td').next('td').find('span.length').html( '(' + $(this).val().length + '/`$maxBulletpointsLength`)'); 
    if( $(this).val().length > `$maxBulletpointsLength` ) 
     { $(this).css('background-color', '#eed4d4'); } 
    else 
    { $(this).css('background-color', 'white'); } });" priority=10}]
[{oxscript add="$('.productline').bind( 'keyup change', function(e){ $(this).closest('td').next('td').find('span.length').html( '(' + $(this).val().length + '/50)'); if( $(this).val().length > 50 ) { $(this).css('background-color', '#eed4d4'); } else { $(this).css('background-color', 'white'); } });" priority=10}]
[{if $oOtto->getOttoParam('dgOttoUseProductReference')}]    
[{oxscript add="$('.productReference').bind( 'keyup change', function(e){ $(this).closest('td').next('td').find('span.length').html( '(' + $(this).val().length + '/50)'); if( $(this).val().length > 50 ) { $(this).css('background-color', '#eed4d4'); } else { $(this).css('background-color', 'white'); } });" priority=10}]
[{/if}]
<div class="groupExp">
  <div [{if $aStep == "customfields"}] class="exp"[{/if}]>
    <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Bulletpoints[{if $oOtto->getOttoParam('dgOttoUseLongDesc')}] und Langbeschreibung[{/if}]</b></a>
      <dl>
         <dd>
           <table cellspacing="0" cellpadding="1" border="0" width="100%">   
           <colgroup>
             <col width="30%"/>
             <col width="1%"/>
             <col width="69%"/>
           </colgroup>          
            <tr>
              <td valign="top">
              <table cellspacing="0" cellpadding="1" border="0" width="100%">  
              <colgroup>
                <col width="70%" />
                <col width="30%" />
              </colgroup>
              [{assign var="sField" value=$edit->productLine}]
              [{if $oOtto->getOttoParam('dgOttoUseTitleAsProductLine') && $sField|strlen <= 0}]
                [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoTitle')}]
                [{assign var="sField" value=$edit->$aField->value}]
              [{/if}]
               <tr>
                  <td>
                    <label for="productLine">Productline </label><br />
                    <input class="productline" maxlength="75" id="productLine" type="text" name="multiattr[[{$edit->getId()}]][productLine]" size="75" value="[{$sField}]" style="background-color: [{if $sField|strlen > 50}]#eed4d4[{else}]#fff[{/if}];" />
                  </td>
                  <td style="text-align: right;vertical-align: bottom;">
                    <span class="length">([{$sField|strlen}]/50)</span>
                  </td>
                </tr>
                <tr>
                  <td colspan="2"> &nbsp;<br />
                  </td>
                </tr>
                [{if $oOtto->getOttoParam('dgOttoUseProductReference')}]
                [{assign var="sField" value=$edit->productReference}]
                  [{if $oOtto->getOttoParam('dgOttoUseTitleAsReference') && $sField|strlen <= 0}]
                    [{assign var="aField" value="oxarticles__"|cat:$oOtto->getOttoParam('dgOttoTitle')}]
                    [{assign var="sField" value=$edit->$aField->value}]
                  [{/if}]
                <tr>
                  <td>
                    <label for="productReference">Product Reference </label><br />
                    <input class="productReference" maxlength="75" id="productReference" type="text" name="multiattr[[{$edit->getId()}]][productReference]" size="75" value="[{$sField}]" style="background-color: [{if $sField|strlen > 50}]#eed4d4[{else}]#fff[{/if}];" />
                  </td>
                  <td style="text-align: right;vertical-align: bottom;">
                    <span class="length">([{$sField|strlen}]/50)</span>
                  </td>
                </tr>
                <tr>
                  <td colspan="2"> &nbsp;<br />
                  </td>
                </tr>
                [{/if}]
              [{section name=Inherit loop=5 step=+1}]
              [{assign var="aStep" value=$smarty.section.Inherit.index+1}] 
              [{assign var="aField" value="oxbulletpoint"|cat:$aStep}]      
                <tr>
                  <td>
                    <label for="oxb[{$aStep}]">Bulletpoint [{$aStep}] </label><br />
                    [{assign var="adgOttoBulletPoint" value="dgOttoBulletPoint"|cat:$aStep}] 
                    [{if $oOtto->getOttoParam($adgOttoBulletPoint) != ''}]
                    [{assign var="sField" value="oxarticles__"|cat:$oOtto->getOttoParam($adgOttoBulletPoint)}]  
                    <input class="customfield" maxlength="[{$maxBulletpointsLength+10}]" id="oxb[{$aStep}]" type="text" name="multiattr[[{$edit->getId()}]][[{$aField}]]" size="75" value="[{$edit->$aField|default:$edit->$sField->value}]" style="background-color: [{if $edit->$aField|strlen > $maxBulletpointsLength}]#eed4d4[{else}]#fff[{/if}];" />
                    [{else}]
                    <input class="customfield" maxlength="[{$maxBulletpointsLength+10}]" id="oxb[{$aStep}]" type="text" name="multiattr[[{$edit->getId()}]][[{$aField}]]" size="75" value="[{$edit->$aField}]" style="background-color: [{if $edit->$aField|strlen > $maxBulletpointsLength}]#eed4d4[{else}]#fff[{/if}];" />
                    [{/if}]
                  </td>
                  <td style="text-align: right;vertical-align: bottom;">
                    <span class="length">([{$edit->$aField|strlen}]/[{$maxBulletpointsLength}])</span>
                  </td>
                </tr>
               [{/section}] 
              </table>  
                
                
                [{if $oOtto->getOttoParam('dgOttoUseLongDesc')}]<input id="longdesc" type="hidden" name="multiattr[[{$edit->getId()}]][oxlongdesc]" value="" />[{/if}]
              </td>
              <td>&nbsp;</td>
              <td valign="top">[{if $oOtto->getOttoParam('dgOttoUseLongDesc')}][{$editor}][{/if}]</td>
            </tr>
            <tr>
               <td colspan="3">            
                  <button type="submit" name="save" onclick="[{if $oOtto->getOttoParam('dgOttoUseLongDesc')}]copydgLongDesc( 'oxlongdesc' );[{/if}]this.form.aStep.value='customfields';this.form.fnc.value='save';hidePleaseWait();">speichern</button>
               </td>          
            </tr>
         </table>
       </dd>
      </dl>
     <div class="spacer"></div>
  </div>
</div>
[{if $oOtto->getOttoParam('dgOttoUseLongDesc')}]
<script type="text/javascript">
function copydgLongDesc( sIdent )
{
   var textVal = null;
   try {
      if ( WPro.editors[sIdent] != null ) {
                   WPro.editors[sIdent].prepareSubmission();
                   textVal = cleanupLongDesc( WPro.editors[sIdent].getValue() );
                }
   } catch(err) {
                    var varEl = document.getElementById(sIdent);
                    if (varEl != null) {
                        textVal = cleanupLongDesc( varEl.value );
                    }
            }

            if (textVal == null) {
                var varName = 'editor_'+sIdent;
                var varEl = document.getElementById(varName);
                if (varEl != null) {
                    textVal = cleanupLongDesc( varEl.value );
                }
            }

            if (textVal != null) {
                var oTarget = document.getElementsByName( 'multiattr[[{$edit->getId()}]]['+ sIdent + ']' );
                if ( oTarget != null && ( oField = oTarget.item( 0 ) ) != null ) {
                    oField.value = textVal;
                }
            }
}
</script>
[{/if}]