[{$smarty.block.parent}]

<tr>
    <td class="edittext" width="120">
        [{oxmultilang ident="EXONN_GOOGLE_MERCHANT_FEED_ACTIVE"}]
    </td>
    <td class="edittext">
        <input type="hidden" name="editval[oxcountry__google_feed_active]" value='0'>
        <input class="edittext" type="checkbox" name="editval[oxcountry__google_feed_active]" value='1' [{if $edit->oxcountry__google_feed_active->value == 1}]checked[{/if}] [{$readonly}]>

        [{oxinputhelp ident="HELP_EXONN_GOOGLE_MERCHANT_FEED_ACTIVE"}]
    </td>
</tr>