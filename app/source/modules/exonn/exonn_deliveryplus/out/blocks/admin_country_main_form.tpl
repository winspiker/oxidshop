[{*Add to metadata.php: array('template' => 'country_main.tpl', 'block'=>'admin_country_main_form', 'file'=>'admin_country_main_form.tpl'), *}]

[{$smarty.block.parent}]

    <tr>
        <td class="edittext" width="120">
            Europäische Union
        </td>
        <td class="edittext">
            <input  type="hidden" name="editval[oxcountry__oxeuropunion]" value='0' >
            <input class="edittext" type="checkbox" name="editval[oxcountry__oxeuropunion]" value='1' [{if $edit->oxcountry__oxeuropunion->value == 1}]checked[{/if}] [{ $readonly }]>
        </td>
    </tr>