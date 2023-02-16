[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]


<script type="text/javascript">
    <!--
    window.onload = function ()
    {
        //top.reloadEditFrame();
        [{if $updatelist == 1}]
        top.oxid.admin.updateList('[{$oxid}]');
        [{/if}]
    }
    //-->
</script>


<script type="text/javascript">
<!--

function DeletePic( sField )
{
    var oForm = document.getElementById("myedit");
    document.getElementById(sField).value="";
    oForm.fnc.value='save';
    oForm.submit();
}

//-->
</script>

<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="[{$oxid}]">
    <input type="hidden" name="cl" value="redirectmanager_main">
</form>


<form name="myedit" enctype="multipart/form-data" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
[{$oViewConf->getHiddenSid()}]
<input type="hidden" name="cl" value="redirectmanager_main">
<input type="hidden" name="fnc" value="">
<input type="hidden" name="oxid" value="[{$oxid}]">
<input type="hidden" name="editval[netredirectmanager__oxid]" value="[{$oxid}]">
<input type="hidden" name="sorting" value="">
<input type="hidden" name="stable" value="">
<input type="hidden" name="starget" value="">


<table>
    <tr>
        <td class="edittext">[{oxmultilang ident="NET_REDIRECT_MANAGER_MAIN_OXACTIVE"}]</td>
        <td>
            <input class="edittext" type="checkbox" name="editval[netredirectmanager__oxactive]" value='1' [{if $edit->netredirectmanager__oxactive->value == 1}]checked[{/if}] [{ $readonly }]>
        </td>
    </tr>

    <tr>
        <td class="edittext">[{oxmultilang ident="NET_REDIRECT_MANAGER_MAIN_OXSOURCE"}]</td>
        <td>
            <input type="text" class="editinput" size="32" maxlength="128" name="editval[netredirectmanager__oxsource]" value="[{$edit->netredirectmanager__oxsource->value}]" [{ $readonly }] [{ $disableSharedEdit }]>
        </td>
    </tr>
    <tr>
        <td class="edittext">[{oxmultilang ident="NET_REDIRECT_MANAGER_MAIN_OXTARGET"}]</td>
        <td>
            <input type="text" class="editinput" size="32" maxlength="128" name="editval[netredirectmanager__oxtarget]" value="[{$edit->netredirectmanager__oxtarget->value}]" [{ $readonly }] [{ $disableSharedEdit }]>
        </td>
    </tr>
    <tr>
        <td class="edittext">[{oxmultilang ident="NET_REDIRECT_MANAGER_MAIN_OXHTTPCODE"}]</td>
        <td>
            <select name="editval[netredirectmanager__oxhttpcode]">
                <option value="301" [{if $edit->netredirectmanager__oxhttpcode->value == "301"}]selected[{/if}]>301 Moved Permanently</option>
                <option value="302" [{if $edit->netredirectmanager__oxhttpcode->value == "302"}]selected[{/if}]>302 Found</option>
                <option value="307" [{if $edit->netredirectmanager__oxhttpcode->value == "307"}]selected[{/if}]>307 Temporary Redirect</option>
                <option value="404" [{if $edit->netredirectmanager__oxhttpcode->value == "404"}]selected[{/if}]>404 Not found</option>
                <option value="410" [{if $edit->netredirectmanager__oxhttpcode->value == "410"}]selected[{/if}]>410 Gone</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="edittext">
        </td>
        <td class="edittext"><br>
            [{include file="language_edit.tpl"}]
        </td>
    </tr>
    <tr>
        <td class="edittext">&nbsp;</td>
        <td>
            <input type="submit" class="edittext" name="save" value="[{ oxmultilang ident="GENERAL_SAVE" }]" onClick="Javascript:document.myedit.fnc.value='save'" [{ $readonly }] [{ $disableSharedEdit }]><br><br>
        </td>
    </tr>



</table>

</form>


</div>


<div class="actions">
[{strip}]
  <ul>
    <li><a [{if !$firstitem}]class="firstitem"[{assign var="firstitem" value="1"}][{/if}] id="btn.new" href="#" onClick="Javascript:top.oxid.admin.editThis( -1 );return false" target="edit">[{ oxmultilang ident="NET_REDIRECT_MANAGER_NEW_REDIRECT" }]</a></li>
  </ul>
[{/strip}]
</div>



[{include file="bottomitem.tpl"}]