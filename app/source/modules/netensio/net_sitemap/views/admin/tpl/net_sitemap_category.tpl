[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="net_sitemap_category">
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]">
</form>


<table cellspacing="0" cellpadding="0" border="0" style="width:98%;">
    <form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post" style="padding: 0px;margin: 0px;height:0px;">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="cl" value="net_sitemap_category">
        <input type="hidden" name="fnc" value="">
        <input type="hidden" name="oxid" value="[{$oxid}]">
        <input type="hidden" name="editval[oxcategories__oxid]" value="[{$oxid}]">
        <tr>
            <td valign="top" class="edittext" style="padding-top:10px;padding-left:10px;">
                <table cellspacing="0" cellpadding="0" border="0">
                    [{block name="net_sitemap_category_form"}]

                    <tr>
                        <td class="edittext" width="120">
                            [{oxmultilang ident="NET_SITEMAP_CATEGORY_EXCLUDE"}]
                        </td>
                        <td class="edittext">
                            <input type="hidden" name="editval[oxcategories__netsitemapexclude]" value="0">
                            <input class="edittext" type="checkbox" name="editval[oxcategories__netsitemapexclude]" value='1' [{if $edit->oxcategories__netsitemapexclude->value == 1}]checked[{/if}] [{$readonly}]>
                        </td>
                    </tr>

                    <tr>
                        <td class="edittext">
                            [{oxmultilang ident="NET_SITEMAP_CATEGORY_CHANGE_FREQ"}]
                        </td>
                        <td class="edittext">
                            <select name="editval[oxcategories__netsitemapchangefreq]">
                                <option value="" [{if $edit->oxcategories__netsitemapchangefreq->value == ""}]selected[{/if}]>---</option>
                                <option value="always" [{if $edit->oxcategories__netsitemapchangefreq->value == "always"}]selected[{/if}]>always</option>
                                <option value="hourly" [{if $edit->oxcategories__netsitemapchangefreq->value == "hourly"}]selected[{/if}]>hourly</option>
                                <option value="daily" [{if $edit->oxcategories__netsitemapchangefreq->value == "daily"}]selected[{/if}]>daily</option>
                                <option value="weekly" [{if $edit->oxcategories__netsitemapchangefreq->value == "weekly"}]selected[{/if}]>weekly</option>
                                <option value="monthly" [{if $edit->oxcategories__netsitemapchangefreq->value == "monthly"}]selected[{/if}]>monthly</option>
                                <option value="yearly" [{if $edit->oxcategories__netsitemapchangefreq->value == "yearly"}]selected[{/if}]>yearly</option>
                                <option value="never" [{if $edit->oxcategories__netsitemapchangefreq->value == "never"}]selected[{/if}]>never</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td class="edittext">
                            [{oxmultilang ident="NET_SITEMAP_CATEGORY_PRIORITY"}]
                        </td>
                        <td class="edittext">
                            <select name="editval[oxcategories__netsitemappriority]">
                                <option value="" [{if $edit->oxcategories__netsitemappriority->value == ""}]selected[{/if}]>---</option>
                                <option value="0.1" [{if $edit->oxcategories__netsitemappriority->value == "0.1"}]selected[{/if}]>0.1</option>
                                <option value="0.2" [{if $edit->oxcategories__netsitemappriority->value == "0.2"}]selected[{/if}]>0.2</option>
                                <option value="0.3" [{if $edit->oxcategories__netsitemappriority->value == "0.3"}]selected[{/if}]>0.3</option>
                                <option value="0.4" [{if $edit->oxcategories__netsitemappriority->value == "0.4"}]selected[{/if}]>0.4</option>
                                <option value="0.5" [{if $edit->oxcategories__netsitemappriority->value == "0.5"}]selected[{/if}]>0.5</option>
                                <option value="0.6" [{if $edit->oxcategories__netsitemappriority->value == "0.6"}]selected[{/if}]>0.6</option>
                                <option value="0.7" [{if $edit->oxcategories__netsitemappriority->value == "0.7"}]selected[{/if}]>0.7</option>
                                <option value="0.8" [{if $edit->oxcategories__netsitemappriority->value == "0.8"}]selected[{/if}]>0.8</option>
                                <option value="0.9" [{if $edit->oxcategories__netsitemappriority->value == "0.9"}]selected[{/if}]>0.9</option>
                                <option value="1.0" [{if $edit->oxcategories__netsitemappriority->value == "1.0"}]selected[{/if}]>1.0</option>
                            </select>
                        </td>
                    </tr>

                    [{/block}]

                    <tr>
                        <td class="edittext" colspan="2"><br><br>
                            <input type="submit" class="edittext" value="[{oxmultilang ident="NET_SITEMAP_CATEGORY_SAVE"}]" onClick="Javascript:document.myedit.fnc.value='save'" [{$readonly}]>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </form>
</table>

[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
