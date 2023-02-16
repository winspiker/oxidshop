[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

[{if $readonly }]
    [{assign var="readonly" value="readonly disabled"}]
[{else}]
    [{assign var="readonly" value=""}]
[{/if}]



<form name="transfer" id="transfer" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="oxid" value="">
    <input type="hidden" name="cl" value="robots_txt_editor_main">
</form>


<h1>[{oxmultilang ident="NET_ROBOTS_TXT_EDITOR_HEADLINE"}]</h1>
<p>[{oxmultilang ident="NET_ROBOTS_TXT_EDITOR_SUBHEAD"}]</p>
<hr>

<form name="myedit" enctype="multipart/form-data" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="robots_txt_editor_main">
    <input type="hidden" name="fnc" value="">

    [{assign var="sFileContent" value=$oView->getRobotsTxtContent()}]
    [{if $sFileContent !== false}]
        <textarea style="width:50%;height:500px;"; name="robots_txt">[{$sFileContent}]</textarea>
        <div class="clearfix"></div>
        <br />
        <button type="submit" onClick="Javascript:document.myedit.fnc.value='save'">[{oxmultilang ident="GENERAL_SAVE"}]</button>
    [{else}]
        <div class="error">
            [{oxmultilang ident="NET_ROBOTS_TXT_EDITOR_FILE_NOT_READABLE"}]
        </div>
    [{/if}]


</form>


</div>

[{include file="bottomitem.tpl"}]