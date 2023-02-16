[{* |article_main.tpl|admin_article_main_form|dgidealo_admin_article_main_form.tpl|3| *}]
[{ $smarty.block.parent }]
[{assign var="oIdealo" value=$oView->getIdealo()}]
[{assign var="dgIdealoLabel" value='dgidealo_order'|oxmultilangassign}]
[{if $oIdealo->getIdealoParam('dgIdealoActiv') && $oIdealo->getIdealoParam('dgIdealoActive')|lower == "dgidealo" }]
<tr>
    <td class="edittext">
      <label for="dgidealo">[{$dgIdealoLabel}] Export</label>
    </td>
    <td class="edittext">
       <input type="hidden" name="editval[oxarticles__dgidealo]" value="0" />
       <input id="dgidealo" type="checkbox" name="editval[oxarticles__dgidealo]" value="1" [{if $edit->oxarticles__dgidealo->value == 1}]checked[{/if}] [{ $readonly }]>
    </td>
</tr>
[{/if}]

[{if $oIdealo->getIdealoParam('dgIdealoActiv') && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') != "0" && $oIdealo->getIdealoParam('dgIdealoDirectPurchaseRelease') != "1" }]
<tr>
    <td class="edittext">
      <label for="dgidealodirectpurchaserelease">[{$dgIdealoLabel}] Direktkauf</label>
    </td>
    <td class="edittext">
       <input type="hidden" name="editval[oxarticles__dgidealodirectpurchaserelease]" value="0" />
       <input id="dgidealodirectpurchaserelease" type="checkbox" name="editval[oxarticles__dgidealodirectpurchaserelease]" value="1" [{if $edit->oxarticles__dgidealodirectpurchaserelease->value == 1}]checked[{/if}] [{ $readonly }]>
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
         <option value="Paketdienst" [{if $edit->oxarticles__dgidealodeliveryart->value == "Paketdienst"}]selected[{/if}]>Paketdienst </option>
         <option value="Spedition"    [{if $edit->oxarticles__dgidealodeliveryart->value == "Spedition"   }]selected[{/if}]>Spedition </option>
         <option value="Briefversand" [{if $edit->oxarticles__dgidealodeliveryart->value == "Briefversand"}]selected[{/if}]>Briefversand </option>
       </select>
    </td>
</tr>
[{/if}]
