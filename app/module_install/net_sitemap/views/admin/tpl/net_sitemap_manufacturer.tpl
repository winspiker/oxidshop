[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]


[{if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid }]">
    <input type="hidden" name="oxidCopy" value="[{$oxid}]">
    <input type="hidden" name="cl" value="net_sitemap_manufacturer">
    <input type="hidden" name="language" value="[{$actlang}]">
</form>

<form name="myedit" id="myedit" enctype="multipart/form-data" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="net_sitemap_manufacturer">
<input type="hidden" name="fnc" value="save">
<input type="hidden" name="oxid" value="[{$oxid}]">
<input type="hidden" name="voxid" value="[{$oxid}]">
<input type="hidden" name="oxparentid" value="[{$oxparentid}]">
<input type="hidden" name="editval[oxmanufacturers__oxid]" value="[{$oxid}]">
<input type="hidden" name="language" value="[{$actlang}]">
    

<table border="0" width="98%">
    <tr>
        <td valign="top" class="edittext">
            <table cellspacing="0" cellpadding="0" border="0">
            [{block name="net_sitemap_manufacturer_form"}]
                <tr>
                    <td class="edittext" width="120">
                        [{oxmultilang ident="NET_SITEMAP_MANUFACTURER_EXCLUDE"}]
                    </td>
                    <td class="edittext">
                        <input type="hidden" name="editval[oxmanufacturers__netsitemapexclude]" value="0">
                        <input class="edittext" type="checkbox" name="editval[oxmanufacturers__netsitemapexclude]" value='1' [{if $edit->oxmanufacturers__netsitemapexclude->value == 1}]checked[{/if}] [{$readonly}]>
                    </td>
                </tr>

                <tr>
                    <td class="edittext">
                        [{oxmultilang ident="NET_SITEMAP_MANUFACTURER_CHANGE_FREQ"}]
                    </td>
                    <td class="edittext">
                        <select name="editval[oxmanufacturers__netsitemapchangefreq]">
                            <option value="" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == ""}]selected[{/if}]>---</option>
                            <option value="always" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "always"}]selected[{/if}]>always</option>
                            <option value="hourly" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "hourly"}]selected[{/if}]>hourly</option>
                            <option value="daily" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "daily"}]selected[{/if}]>daily</option>
                            <option value="weekly" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "weekly"}]selected[{/if}]>weekly</option>
                            <option value="monthly" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "monthly"}]selected[{/if}]>monthly</option>
                            <option value="yearly" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "yearly"}]selected[{/if}]>yearly</option>
                            <option value="never" [{if $edit->oxmanufacturers__netsitemapchangefreq->value == "never"}]selected[{/if}]>never</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="edittext">
                        [{oxmultilang ident="NET_SITEMAP_MANUFACTURER_PRIORITY"}]
                    </td>
                    <td class="edittext">
                        <select name="editval[oxmanufacturers__netsitemappriority]">
                            <option value="" [{if $edit->oxmanufacturers__netsitemappriority->value == ""}]selected[{/if}]>---</option>
                            <option value="0.1" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.1"}]selected[{/if}]>0.1</option>
                            <option value="0.2" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.2"}]selected[{/if}]>0.2</option>
                            <option value="0.3" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.3"}]selected[{/if}]>0.3</option>
                            <option value="0.4" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.4"}]selected[{/if}]>0.4</option>
                            <option value="0.5" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.5"}]selected[{/if}]>0.5</option>
                            <option value="0.6" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.6"}]selected[{/if}]>0.6</option>
                            <option value="0.7" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.7"}]selected[{/if}]>0.7</option>
                            <option value="0.8" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.8"}]selected[{/if}]>0.8</option>
                            <option value="0.9" [{if $edit->oxmanufacturers__netsitemappriority->value == "0.9"}]selected[{/if}]>0.9</option>
                            <option value="1.0" [{if $edit->oxmanufacturers__netsitemappriority->value == "1.0"}]selected[{/if}]>1.0</option>
                        </select>
                    </td>
                </tr>
            [{/block}]
                <tr>
                    <td class="edittext" colspan="2"><br><br>
                        <input type="submit" class="edittext" value="[{oxmultilang ident="NET_SITEMAP_MANUFACTURER_SAVE"}]" onClick="Javascript:document.myedit.fnc.value='save'" [{$readonly}]>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>

[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]