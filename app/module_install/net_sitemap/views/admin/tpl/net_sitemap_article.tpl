[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
<!--
function editThis( sID )
{
    var oTransfer = top.basefrm.edit.document.getElementById( "transfer" );
    oTransfer.oxid.value = sID;
    oTransfer.cl.value = top.basefrm.list.sDefClass;

    //forcing edit frame to reload after submit
    top.forceReloadingEditFrame();

    var oSearch = top.basefrm.list.document.getElementById( "search" );
    oSearch.oxid.value = sID;
    oSearch.actedit.value = 0;
    oSearch.submit();
}
//-->
</script>

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="net_sitemap_article">
    <input type="hidden" name="editlanguage" value="[{$editlanguage}]">
</form>

[{if $readonly}]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

<table cellspacing="0" cellpadding="0" border="0" style="width:98%;">
    <form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post" style="padding: 0px;margin: 0px;height:0px;">
        [{$oViewConf->getHiddenSid()}]
        <input type="hidden" name="cl" value="net_sitemap_article">
        <input type="hidden" name="fnc" value="">
        <input type="hidden" name="oxid" value="[{$oxid}]">
        <input type="hidden" name="voxid" value="[{$oxid}]">
        <input type="hidden" name="oxparentid" value="[{$oxparentid}]">
        <input type="hidden" name="editval[oxarticles__oxid]" value="[{$oxid}]">
        <tr>
            <td valign="top" class="edittext" style="padding-top:10px;padding-left:10px;">
                <table cellspacing="0" cellpadding="0" border="0">
                    [{block name="net_sitemap_article_form"}]

                    [{if $errorsavingatricle }]
                        <tr>
                            <td colspan="2">
                                [{if $errorsavingatricle eq 1 }]
                                <div class="errorbox">[{oxmultilang ident="ARTICLE_MAIN_ERRORSAVINGARTICLE"}]</div>
                                [{/if}]
                            </td>
                        </tr>
                    [{/if}]
                    [{if $invalid_tags }]
                        <tr>
                            <td colspan="2">
                                <div class="errorbox">[{oxmultilang ident="ARTICLE_MAIN_INVALIDTAGSFOUND"}]: [{$invalid_tags}]</div>
                            </td>
                        </tr>
                    [{/if}]
                    [{if $oxparentid }]
                        <tr>
                            <td class="edittext" width="120">
                                <b>[{oxmultilang ident="ARTICLE_MAIN_VARIANTE"}]</b>
                            </td>
                            <td class="edittext">
                                <a href="Javascript:editThis('[{$parentarticle->oxarticles__oxid->value}]');" class="edittext"><b>[{$parentarticle->oxarticles__oxartnum->value}] [{$parentarticle->oxarticles__oxtitle->value}] [{if !$parentarticle->oxarticles__oxtitle->value }][{$parentarticle->oxarticles__oxvarselect->value}][{/if}]</b></a>
                            </td>
                        </tr>
                    [{/if}]

                    <tr>
                        <td class="edittext" width="120">
                            [{oxmultilang ident="NET_SITEMAP_ARTICLE_EXCLUDE"}]
                        </td>
                        <td class="edittext">
                            <input type="hidden" name="editval[oxarticles__netsitemapexclude]" value="0">
                            <input class="edittext" type="checkbox" name="editval[oxarticles__netsitemapexclude]" value='1' [{if $edit->oxarticles__netsitemapexclude->value == 1}]checked[{/if}] [{$readonly}]>
                        </td>
                    </tr>

                    <tr>
                        <td class="edittext">
                            [{oxmultilang ident="NET_SITEMAP_ARTICLE_CHANGE_FREQ"}]
                        </td>
                        <td class="edittext">
                            <select name="editval[oxarticles__netsitemapchangefreq]">
                                <option value="" [{if $edit->oxarticles__netsitemapchangefreq->value == ""}]selected[{/if}]>---</option>
                                <option value="always" [{if $edit->oxarticles__netsitemapchangefreq->value == "always"}]selected[{/if}]>always</option>
                                <option value="hourly" [{if $edit->oxarticles__netsitemapchangefreq->value == "hourly"}]selected[{/if}]>hourly</option>
                                <option value="daily" [{if $edit->oxarticles__netsitemapchangefreq->value == "daily"}]selected[{/if}]>daily</option>
                                <option value="weekly" [{if $edit->oxarticles__netsitemapchangefreq->value == "weekly"}]selected[{/if}]>weekly</option>
                                <option value="monthly" [{if $edit->oxarticles__netsitemapchangefreq->value == "monthly"}]selected[{/if}]>monthly</option>
                                <option value="yearly" [{if $edit->oxarticles__netsitemapchangefreq->value == "yearly"}]selected[{/if}]>yearly</option>
                                <option value="never" [{if $edit->oxarticles__netsitemapchangefreq->value == "never"}]selected[{/if}]>never</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td class="edittext">
                            [{oxmultilang ident="NET_SITEMAP_ARTICLE_PRIORITY"}]
                        </td>
                        <td class="edittext">
                            <select name="editval[oxarticles__netsitemappriority]">
                                <option value="" [{if $edit->oxarticles__netsitemappriority->value == ""}]selected[{/if}]>---</option>
                                <option value="0.1" [{if $edit->oxarticles__netsitemappriority->value == "0.1"}]selected[{/if}]>0.1</option>
                                <option value="0.2" [{if $edit->oxarticles__netsitemappriority->value == "0.2"}]selected[{/if}]>0.2</option>
                                <option value="0.3" [{if $edit->oxarticles__netsitemappriority->value == "0.3"}]selected[{/if}]>0.3</option>
                                <option value="0.4" [{if $edit->oxarticles__netsitemappriority->value == "0.4"}]selected[{/if}]>0.4</option>
                                <option value="0.5" [{if $edit->oxarticles__netsitemappriority->value == "0.5"}]selected[{/if}]>0.5</option>
                                <option value="0.6" [{if $edit->oxarticles__netsitemappriority->value == "0.6"}]selected[{/if}]>0.6</option>
                                <option value="0.7" [{if $edit->oxarticles__netsitemappriority->value == "0.7"}]selected[{/if}]>0.7</option>
                                <option value="0.8" [{if $edit->oxarticles__netsitemappriority->value == "0.8"}]selected[{/if}]>0.8</option>
                                <option value="0.9" [{if $edit->oxarticles__netsitemappriority->value == "0.9"}]selected[{/if}]>0.9</option>
                                <option value="1.0" [{if $edit->oxarticles__netsitemappriority->value == "1.0"}]selected[{/if}]>1.0</option>
                            </select>
                        </td>
                    </tr>

                    [{/block}]

                    <tr>
                        <td class="edittext" colspan="2"><br><br>
                            <input type="submit" class="edittext" value="[{oxmultilang ident="NET_SITEMAP_ARTICLE_SAVE"}]" onClick="Javascript:document.myedit.fnc.value='save'" [{if !$edit->oxarticles__oxtitle->value && !$oxparentid }]disabled[{/if}] [{$readonly}]>
                        </td>
                    </tr>
                    [{if $oxid!=-1 && $thisvariantlist}]
                    <tr>
                        <td class="edittext">[{oxmultilang ident="ARTICLE_MAIN_GOTO"}]</td>
                        <td class="edittext">
                            [{include file="variantlist.tpl"}]
                        </td>
                    </tr>
                    [{/if}]
                </table>
            </td>
        </tr>
    </form>
</table>

[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
