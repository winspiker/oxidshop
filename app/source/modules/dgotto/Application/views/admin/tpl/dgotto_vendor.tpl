<script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="  crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
<script src="[{$oViewConf->getBaseDir()}]modules/dgotto/out/admin/src/js/dgottocategory.js" type="text/javascript"></script>
<div class="groupExp">
   <div [{if $aStep == "save2Category" || !$oView->getOttoCategoryId()}] class="exp"[{/if}]>
        <a href="#" onclick="_groupExp(this);return false;" class="rc"><b>Lieferant &quot;[{$edit->oxvendor__oxtitle->value|truncate:30}]&quot; zu Otto Kategorie zuordnen ?</b></a>
          <dl>
            <dd>
              <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td class="edittext">
                    <span style="color:#D4021D;font-weight: 800;font-size: 12px;">OTTO</span> Kategorie
                  </td>
                  <td class="edittext">
                    <input id="dgOttoCategorySearch" name="editval[dgottocategory]" value="[{$oView->getOttoCategory()}]" type="text" size="40" />
                    <input id="dgOttoCategorySearchId" name="editval[dgottocategoryid]" value="[{$oView->getOttoCategoryId()}]" type="hidden" />
                  </td>
                  <td class="edittext">
                    [{if $oView->getOttoCategoryId()}]
                      <a href="[{$oViewConf->getSelfLink()}]?sid=[{$oViewConf->getSessionId()}]&cl=[{$oViewConf->getTopActiveClassName()}]&fnc=deleteOttoCategory&oxid=[{$oxid}]&aStep=save2Category" onClick='return confirm("Wollen Sie diesen Eintrag wirklich l&ouml;schen ?")'><img width="18" src="[{$oViewConf->getModuleUrl('dgotto','out/admin/img/dgdelete.gif') }]" alt="l&ouml;schen?" title="l&ouml;schen?" border="0" /></a>
                    [{/if}]
                  </td>
                </tr>
                [{if $dgOttoCategories}]
                <tr>
                  <td class="edittext">
                    gew&auml;hlt:
                  </td>
                  <td class="edittext" colspan="2">
                    [{$dgOttoCategories->dgottocategories__oxgroup->value}] / [{$dgOttoCategories->dgottocategories__oxcategory->value}] 
                  </td>
                </tr>
                [{/if}]
                <tr>
                  <td class="edittext" colspan="3"><br /><br />
                     <button type="submit" class="edittext" name="save" onclick="showPleaseWait();this.form.aStep.value='save2Category';this.form.fnc.value='save2Category'">[{oxmultilang ident="GENERAL_SAVE"}]</button><br>
                  </td>
                </tr>
              </table>
            </dd>
          </dl>
         <div class="spacer"></div>
   </div>
</div> 
[{oxscript add="$( document ).ready(function() { $('#dgOttoCategorySearch').dgOttoCategory(); });" priority=10}]