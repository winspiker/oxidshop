[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="csv_export_main">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<fieldset>
    <legend>Haendlernetzwerk</legend>
    <form name="csv_export" id="csv_export" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="cl" value="csv_export_main">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oxid }]">

        <br>
        <h3>CSV Export</h3>
        <button name="fnc" value="do_export"> Export ausführen </button>
                <br><br>
        [{if $ok}]<a style="color: green;" target="_blank" href="[{$oViewConf->getBaseDir()}]/export/Haendlernetzwerk/CSV/articles.csv">articles.csv</a>[{/if}]<br>
        [{if $ok}]<a style="color: green;" target="_blank" href="[{$oViewConf->getBaseDir()}]/export/Haendlernetzwerk/CSV/stock.csv">stock.csv</a>[{/if}]<br>
        <br><hr><br>
        <button name="fnc" value="do_import"> Import ausführen </button>

    </form>
</fieldset>
<br>
<fieldset>
    <legend>OTTO Upload Datei</legend>
    <form name="csv_export" id="csv_export_otto" action="[{ $oViewConf->getSelfLink() }]" method="post">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="cl" value="csv_export_main">
        <input type="hidden" name="oxid" value="[{ $oxid }]">
        <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oxid }]">

        <br>
        <h3>CSV Export</h3>
        <button name="fnc" value="do_export_germes"> Export ausführen </button>
                <br><br>
        [{if $germes_ok}]<a style="color: green;" target="_blank" href="[{$oViewConf->getBaseDir()}]/export/UPLOAD_BESTAENDE.csv">UPLOAD_BESTAENDE.csv</a>[{/if}]<br>

    </form>
</fieldset>
[{include file="bottomnaviitem.tpl"}]

[{include file="bottomitem.tpl"}]
