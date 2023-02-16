[{$smarty.block.parent}]

[{ if !$IsOXDemoShop }]
<tr>
    <td class="edittext" >
        Lagerbestandmeldungen an:
    </td>
    <td class="edittext">
        <input type="text" class="editinput" size="35" maxlength="[{$edit->oxshops__oxstockemail->fldmax_length}]" name="editval[oxshops__oxstockemail]" value="[{$edit->oxshops__oxstockemail->value}]" [{ $readonly}]>

    </td>
</tr>
[{/if}]
