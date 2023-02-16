[{ if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]

[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]


<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="article_userdef">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<table cellspacing="0" cellpadding="0" border="0" width="99%" height="100%">
<tr>
<td valign="top" background="[{$oViewConf->getImageUrl()}]/edit_back.gif" width="100%">
    [{assign var="onsubmit" value=""}]
    [{assign var="highestEditedTabNum" value=$edit->getHighestEditedTabNum()}]
    [{foreach from=$edit->getPossibeTabNums() item=num}]
        [{assign var="onsubmit" value=$onsubmit|cat:"copyLongDesc('mstabs__tab"|cat:$num|cat:"_desc'); "}]
    [{/foreach}]

    <form name="myedit" id="myedit" action="[{ $oViewConf->getSelfLink() }]" method="post" style="padding: 0px;margin: 0px;height:0px;" onSubmit="[{$onsubmit}] return true;">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="article_moretabs">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="voxid" value="[{ $oxid }]">
    <input type="hidden" name="oxparentid" value="[{ $oxparentid }]">
    <input type="hidden" name="editval[oxarticles__oxid]" value="[{ $oxid }]">

    <p style="font-size: 14px;">[{oxmultilang ident="ARTICLE_TAB_EXPLAINATION"}]</p>
    <div class="messagebox">[{oxmultilang ident="ARTICLE_TAB_EMPTY_TITLE_WARNING"}]</div>

    [{foreach from=$edit->getPossibeTabNums() item=num name=tabs}]
        <table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" id="article-moretabs-tab-[{$num}]" [{if $num > $highestEditedTabNum}]style="display: none;[{/if}]">
            <tr>
                <th colspan="2" style="font-size:16px;text-align:left;padding-top:25px;">
                    <input type="hidden" name="editval[mstabs__tab[{$num}]_desc]" value="">
                    [{ oxmultilang ident="ARTICLE_TAB_NUMBER" }] [{$num}]
                </th>
            </tr>

            <tr>
              <td class="edittext">
                [{ oxmultilang ident="ARTICLE_TAB_TITLE" }]&nbsp;
              </td>
              <td class="edittext">
                <input type="text" class="editinput" size="60" id="oLockTarget" name="editval[mstabs__tab[{$num}]_title]" value="[{$edit->getTabTitle($num)|escape}]">
                [{ oxinputhelp ident="HELP_ARTICLE_TAB_TITLE" }]
              </td>
            </tr>

            <tr>
              <td class="edittext">
                [{ oxmultilang ident="ARTICLE_TAB_POSITION" }]&nbsp;
              </td>
              <td class="edittext">
                <select name="editval[mstabs__tab[{$num}]_pos]">
                    <option value="description" [{if $edit->getTabPos($num)=="description"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_TAB_POSITION_DESCRIPTION" }]</option>
                    <option value="attributes" [{if $edit->getTabPos($num)=="attributes"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_TAB_POSITION_ATTRIBUTES" }]</option>
                    <option value="pricealarm" [{if $edit->getTabPos($num)=="pricealarm"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_TAB_POSITION_PRICEALARM" }]</option>
                    <option value="tags" [{if $edit->getTabPos($num)=="tags"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_TAB_POSITION_TAGS" }]</option>
                    <option value="media" [{if $edit->getTabPos($num)=="media"}]selected[{/if}]>[{ oxmultilang ident="ARTICLE_TAB_POSITION_MEDIA" }]</option>
                </select>
                [{ oxinputhelp ident="HELP_ARTICLE_TAB_POSITION" }]
              </td>
            </tr>

            <tr>
                <td class="edittext">
                  [{ oxmultilang ident="ARTICLE_TAB_DESC" }]&nbsp;
                </td>
                <td class="edittext">
                    [{if $num==1}][{ $editor1 }][{/if}]
                    [{if $num==2}][{ $editor2 }][{/if}]
                    [{if $num==3}][{ $editor3 }][{/if}]
                    [{if $num==4}][{ $editor4 }][{/if}]
                    [{if $num==5}][{ $editor5 }][{/if}]
                </td>
            </tr>
            [{if $num == $highestEditedTabNum && !$smarty.foreach.tabs.last}]
                <tr>
                    <td colspan="2" style="padding-top: 15px;">
                        <input type="button" value="[{oxmultilang ident="ARTICLE_TAB_NEW_TAB"}]" onclick="document.getElementById('article-moretabs-tab-[{math equation='x+1' x=$num}]').style.display = 'table'; this.style.display='none';">
                    </td>
                </tr>
            [{/if}]
        </table>
    [{/foreach}]
    <table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" style="margin-top:30px;">
        <tr><td>
            <input type="submit" class="edittext" id="oLockButton" name="saveArticle" value="[{ oxmultilang ident="ARTICLE_MAIN_SAVE" }]" onClick="Javascript:document.myedit.fnc.value='save'" [{* if !$edit->oxarticles__oxtitle->value && !$oxparentid }]disabled[{/if*}] [{ $readonly }]>
        </td></tr>
        <tr>
            <td class="edittext" colspan="2">
                <br>
                [{include file="language_edit.tpl"}]<br>
            </td>
        </tr>
    </table>
    </form>

</td>
</tr>
</table>
[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
