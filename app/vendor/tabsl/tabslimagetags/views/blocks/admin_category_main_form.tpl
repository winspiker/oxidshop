[{$smarty.block.parent}]
<tr>
    <td class="edittext">
        [{ oxmultilang ident="TABSL_IMAGETAGS_TAG_THUMB" }]
    </td>
    <td class="edittext">
        <input type="text" class="editinput" size="50" maxlength="[{$edit->oxcategories__tabsl_imagetag_thumb->fldmax_length}]" name="editval[oxcategories__tabsl_imagetag_thumb]" value="[{$edit->oxcategories__tabsl_imagetag_thumb->value}]">&nbsp;
        [{ oxinputhelp ident="TABSL_IMAGETAGS_TAG_THUMB_HELP" }]
    </td>
</tr>
<tr>
    <td class="edittext">
        [{ oxmultilang ident="TABSL_IMAGETAGS_TAG_ICON" }]
    </td>
    <td class="edittext">
        <input type="text" class="editinput" size="50" maxlength="[{$edit->oxcategories__tabsl_imagetag_icon->fldmax_length}]" name="editval[oxcategories__tabsl_imagetag_icon]" value="[{$edit->oxcategories__tabsl_imagetag_icon->value}]">&nbsp;
        [{ oxinputhelp ident="TABSL_IMAGETAGS_TAG_ICON_HELP" }]
    </td>
</tr>
