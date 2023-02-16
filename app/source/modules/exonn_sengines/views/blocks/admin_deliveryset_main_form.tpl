[{*Add to metadata.php: array('template' => 'deliveryset_main.tpl', 'block'=>'admin_deliveryset_main_form', 'file'=>'admin_deliveryset_main_form.tpl'), *}]

[{$smarty.block.parent}]

<tr>
    <td class="edittext">
    [{ oxmultilang ident="EXONN_SENGINES_SKIP_SHIPPING" }]
    </td>
    <td class="edittext">
        <input class="edittext" type="hidden" name="editval[oxdeliveryset__skipgmerch]" value='0'>
        <input class="edittext" type="checkbox" name="editval[oxdeliveryset__skipgmerch]" value='1' [{if $edit->oxdeliveryset__skipgmerch->value == 1}]checked[{/if}] [{ $readonly }]>
    </td>
</tr>