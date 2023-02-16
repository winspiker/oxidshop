[{* if you increasae loop to 12 pictures, please add database fields (see setup/sql/install.sql) *}]
[{$smarty.block.parent}]
[{section name=tabslImageTags start=1 loop=$iPicCount+1 step=1}]
    [{assign var="iIndex" value=$smarty.section.tabslImageTags.index}]
    [{assign var="sImage" value="oxarticles__tabsl_imagetag"|cat:$iIndex}]
    <tr>
        <td class="edittext">
            [{ oxmultilang ident="TABSL_IMAGETAGS_TAG" }] #[{$iIndex}]
        </td>
        <td class="edittext" colspan="5">
            <input type="text" class="editinput" size="50" maxlength="[{$edit->$sImage->fldmax_length}]" id="oLockTarget" name="editval[oxarticles__tabsl_imagetag[{$iIndex}]]" value="[{$edit->$sImage->value}]">&nbsp;
            [{ oxinputhelp ident="TABSL_IMAGETAGS_TAG_HELP" }]
        </td>
    </tr>
 [{/section}]
