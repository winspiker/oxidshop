[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]





<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="dgottomatching_main">
</form>

<form name="myedit" enctype="multipart/form-data" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
  <input type="hidden" name="cl" value="dgottomatching_main" />
 [{$oViewConf->getHiddenSid()}]
 <input type="hidden" name="fnc" value="" />
 <input type="hidden" name="oxid" value="[{$oxid}]" />
 <input type="hidden" name="editval[dgottomatching__oxid]" value="[{$oxid}]" />

<table cellspacing="0" cellpadding="0" border="0" width="98%">

<tr>
    <td valign="top" class="edittext" style="padding-right: 20px;">
    [{if $edit}]
        <table cellspacing="0" cellpadding="0" border="0">
        [{block name="dgottomatching_main_form"}]
        <tr>
           <td class="edittext" width="120">
              <input type="hidden" name="editval[dgottomatching__oxuseforall]" value="0" />
              <input id="dgottomatching__oxuseforall" class="edittext" type="checkbox" name="editval[dgottomatching__oxuseforall]" value='1' [{if $edit->dgottomatching__oxuseforall->value == 1}]checked[{/if}] />
           </td>
           <td class="edittext">
              <label for="dgottomatching__oxuseforall">f&uuml;r alle Attribute &quot;[{$edit->dgottomatching__oxtheme->value}]&quot; verwenden</label>
           </td>
         </tr>
         
         <tr>
           <td class="edittext" colspan="2">
              <hr />
           </td>
         </tr>
         <tr>
           <td class="edittext">
              <input type="hidden" name="editval[dgottomatching__oxmultivalue]" value="0" />
              <input id="dgottomatching__oxmultivalue" class="edittext" type="checkbox" name="editval[dgottomatching__oxmultivalue]" value='1' [{if $edit->dgottomatching__oxmultivalue->value == 1}]checked[{/if}] />
           </td>
           <td class="edittext">
              <label for="dgottomatching__oxmultivalue">als multiples Feld nutzen</label>
           </td>
         </tr>
         <tr>
           <td class="edittext">
              <input type="hidden" name="editval[dgottomatching__oxdbvalue]" value="0" />
              <input id="dgottomatching__oxdbvalue" class="edittext" type="checkbox" name="editval[dgottomatching__oxdbvalue]" value='1' [{if $edit->dgottomatching__oxdbvalue->value == 1}]checked[{/if}] />
           </td>
           <td class="edittext">
              <label for="dgottomatching__oxdbvalue">immmer vom Datenbankfeld ohne Umwandlung starten</label>
           </td>
         </tr>
         <tr>
           <td class="edittext">
              Attribut
           </td>
           <td class="edittext">
              <input name="editval[dgottomatching__oxtheme]" size="32" maxlength="[{$edit->dgottomatching__oxtheme->fldmax_length}]" value="[{$edit->dgottomatching__oxtheme->value}]" disabled="true" readonly="true" />
           </td>
         </tr>
         <tr>
           <td class="edittext">
              Kategorie
           </td>
           <td class="edittext">
              <input name="editval[dgottomatching__oxcategory]" size="32" maxlength="[{$edit->dgottomatching__oxcategory->fldmax_length}]" value="[{$edit->dgottomatching__oxcategory->value}]" disabled="true" readonly="true" />
           </td>
         </tr>
         <tr>
           <td class="edittext" colspan="2">
              <hr />
           </td>
         </tr>
         <tr>
           <td class="edittext" colspan="2">
              ausf&uuml;llen mit:
           </td>
         </tr>
         <tr>
           <td class="edittext" colspan="2">
              <hr />
           </td>
         </tr>
         <tr>
           <td class="edittext">
                Artikel Datenbankfeld
           </td>
           <td class="edittext">
             <select name="editval[dgottomatching__oxarticle]" class="editinput" style="width: 206px;">
                <option value="">- nicht nutzen -</option>
               [{foreach from=$pwrsearchfields key=field item=desc}]
               [{assign var="ident" value=GENERAL_ARTICLE_$desc}]
               [{assign var="ident" value=$ident|oxupper}]
                 <option value="oxarticles__[{$desc}]" [{if "oxarticles__"|cat:$desc == $edit->dgottomatching__oxarticle->value}]SELECTED[{/if}]>[{oxmultilang|oxtruncate:20:"..":true noerror=true alternative=$desc ident=$ident}]</option>
               [{/foreach}]
             </select>
           </td>
         </tr>
         <tr>
           <td class="edittext">
                OXID Attribut
           </td>
           <td class="edittext">
              <select name="editval[dgottomatching__oxattribute]" class="editinput" style="width: 206px;">
                <option value="">- nicht nutzen -</option>
                [{foreach from=$oView->getAttributeList() key=field item=desc}]
                 <option value="[{$desc->oxid}]" [{if $desc->oxid == $edit->dgottomatching__oxattribute->value}]SELECTED[{/if}]>[{$desc->oxtitle}]</option>
               [{/foreach}] 
              </select>          
           </td>
         </tr>
         <tr>
           <td class="edittext">
                Standardwert
                [{if $edit->dgottomatching__oxmultivalue->value}]
                <br />
                <small>Werte zeilenweise einf&uuml;gen</small>
                [{/if}]
           </td>
           <td class="edittext">
                 [{if $edit->dgottomatching__oxmultivalue->value}]
             <textarea cols="29" rows="4" class="editinput" list="loxexamplevalues" name="editval[dgottomatching__oxdefaultvalue]">[{$edit->dgottomatching__oxdefaultvalue->value}]</textarea>
                 [{else}]
                   <input type="text" autocomplete="off" class="editinput" size="32" maxlength="[{$edit->dgottomatching__oxdefaultvalue->fldmax_length}]" list="loxexamplevalues" name="editval[dgottomatching__oxdefaultvalue]" value="[{$edit->dgottomatching__oxdefaultvalue->value}]" />
                 [{/if}]
                 [{if $edit->dgottomatching__oxexamplevalues->value}]
                    [{assign var="example" value='|'|explode:$edit->dgottomatching__oxexamplevalues->value}]
                    <datalist id="loxexamplevalues">
                    [{foreach from=$example item=desc}]
                    <option value="[{$desc}]">
                    [{/foreach}]
                    </datalist>
                 [{elseif $getBaseValue}]
                    [{assign var="example" value=$getBaseValue}]
                    <datalist id="loxexamplevalues">
                    [{foreach from=$example item=desc}]
                    <option value="[{$desc}]">
                    [{/foreach}]
                    </datalist>
                 [{/if}]

           
           </td>
         </tr>
        [{/block}]
        
        <tr>
            <td class="edittext"></td>
            <td class="edittext"><br />
              <button type="submit" class="edittext" name="save" onClick="Javascript:document.myedit.fnc.value='save'" [{$readonly}] [{$disableSharedEdit}]>[{oxmultilang ident="GENERAL_SAVE"}]</button><br><br>
            </td>
        </tr>
    
        [{if $edit->dgottomatching__oxexamplevalues->value || $getBaseValue}]
         <tr>
           <td class="edittext" colspan="2">
              <hr />
           </td>
         </tr>
         <tr>
           <td class="edittext" colspan="2">
              Beispielwerte:
           </td>
         </tr>
         <tr>
           <td class="edittext" colspan="2">
              <hr />
           </td>
         </tr>
        
        <tr>
           <td class="edittext" colspan="2">
           [{if $edit->dgottomatching__oxexamplevalues->value}]
                    [{assign var="example" value='|'|explode:$edit->dgottomatching__oxexamplevalues->value}]
                    <ul>
                    [{foreach from=$example item=desc}]
                    <li>[{$desc|wordwrap:75:"<br>\n"}]</li>
                    [{/foreach}]
                    </ul>
                 [{elseif $getBaseValue}]
                    [{assign var="example" value=$getBaseValue}]
                    <ul>
                    [{foreach from=$example item=desc}]
                    <li>[{$desc|wordwrap:75:"<br>\n"}]</li>
                    [{/foreach}]
                    </ul>
                 [{/if}]
                 </td>
         </tr>
        [{/if}]
        </table>
     </form>   
     [{/if}]
    </td>
    <td valign="top" class="edittext" style="padding-top:10px;padding-left:10px;width:50%">
       [{if $edit}]
            <fieldset title="&Uuml;bersetzungen" style="padding-left: 5px; padding-right: 5px;">
            <legend>&Uuml;bersetzungen</legend><br />
            <table cellspacing="0" cellpadding="1" border="0" >
            [{assign var=oddclass value="2"}]
            [{assign var=i value=0}]
            [{section name=trans loop=$translate.oxfrom}]
              <tr>
              [{if $oddclass == 2}]
                [{assign var=oddclass value=""}]
              [{else}]
                [{assign var=oddclass value="2"}]
              [{/if}]
                <td class="listitem[{$oddclass}]" nowrap>
                    aus Wert
                    <input type="text" class="edittext" size="15" name="trans[oxfrom][]" value="[{$translate.oxfrom.$i}]" />
                </td>
                <td class="listitem[{$oddclass}]" nowrap>
                   wird
                    <input type="text" class="edittext" size="15" name="trans[oxto][]" value="[{$translate.oxto.$i}]" />
                </td>
                <td class="listitem[{$oddclass}]">
                  <a href="[{$oViewConf->getSelfLink()}]&cl=dgottomatching_main&id=[{$i}]&fnc=deleteReplace&oxid=[{$oxid}]" onClick='return confirm("[{oxmultilang ident="GENERAL_YOUWANTTODELETE"}]")' class="delete"></a>
                </td>
              </tr>
              [{assign var=i value=$i+1}]
            [{/section}]
            [{if count( $amountprices ) > 0 }]
            <tr>
              <td colspan="3"><br />
                <input type="submit" class="edittext" name="saveAll" value="[{oxmultilang ident="GENERAL_SAVE"}]" onClick="Javascript:document.myedit.fnc.value='updateReplace';" /><br /><br />
              </td>
            </tr>
            <tr>
              <td colspan="3"> <hr /> </td>
            </tr>
            [{/if}]
            [{assign var=i value=$i+1}]
            <tr>
              <td class="listitem[{$oddclass}]">
                 aus Wert <input class="edittext" size="15" type="text" name="trans[oxfrom][]" />
              </td>
              <td class="listitem[{$oddclass}]" colspan="2">
                 wird <input class="edittext" size="15" type="text" name="trans[oxto][]" />
              </td>
            </tr>
           
              <tr>
                <td colspan="3"><br />
                  <button type="submit" class="edittext" name="save" onClick="Javascript:document.myedit.fnc.value='updateReplace';">[{oxmultilang ident="ARTICLE_STOCK_SAVE"}]</button><br /><br />
                </td>
              </tr>
             
            </table>
            </fieldset>
    [{/if}]

 </td>


    </tr>
</table>

[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]