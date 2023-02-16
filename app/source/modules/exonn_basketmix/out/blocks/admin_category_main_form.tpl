[{$smarty.block.parent}]

<tr>
    <td class="edittext" >
       <span title="Artikel dieser Kategorie dürfen nicht zusammen mit den anderen Artikeln in den Warenkorb gelegt werden.">Warenkorb mischen sperren</span>
    </td>
    <td class="edittext">
        <input class="edittext" type="checkbox" name="editval[oxcategories__oxonlysingle]" value='1' [{if $edit->oxcategories__oxonlysingle->value == 1}]checked[{/if}] [{$readonly}]>
        [{oxinputhelp ident="HELP_CATEGORY_ONLYSINGLE"}]
    </td>
</tr>