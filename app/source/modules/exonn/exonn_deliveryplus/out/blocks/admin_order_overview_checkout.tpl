[{*Add to metadata.php: array('template' => 'order_overview', 'block'=>'admin_order_overview_checkout', 'file'=>'admin_order_overview_checkout.tpl'), *}]

[{$smarty.block.parent}]

[{if $edit }]
[{foreach from=$oView->getLabelsInformation() item=labelInfo}]
<tr>
    <td class="edittext" colspan="2"> +++++
    [{assign var="articles" value=""}]
    [{foreach from=$labelInfo.articles item=article}]
        [{assign var="articles" value=$articles|cat:","|cat:$article->oxarticles__oxtitle->value}]
    [{/foreach}]
    <label class="label_[{$labelInfo.delservice}]" title="[{$labelInfo.delservice}]: [{$articles}]">[{if $labelInfo.labelerr}]<span class="labelerr" title="[{$labelInfo.labelerr}]">[{$labelInfo.labelerr|truncate:30:"...":true}]</span>[{else}][{$labelInfo.trackcode}][{/if}]</label><br>
    </td>
</tr>
[{/foreach}]
[{/if}]]