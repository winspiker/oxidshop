[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]
[{if $updatenav }]
    [{oxscript add="top.oxid.admin.reloadNavigation('`$shopid`');" priority=10}]
[{/if}]
</div>
<style type="text/css">
    div.box {display: none;}
    div.box.next {display: block;}
    #div-overlay {
        background-color: #333;
        opacity: 0.8;
        position: fixed;
        left: 0px;
        top: 0px;
        z-index: 100;
        height: 100%;
        width: 100%;
        overflow: hidden;
        background-image: url('[{$oViewConf->getBaseDir()}]modules/exonn_connector/views/admin/img/ajax-loader.gif');
        background-position: center;
        background-repeat: no-repeat;

    }
</style>
<script type="text/javascript">
<!--
function _groupExp(el) {
    var _cur = el.parentNode;

    if (_cur.className == "exp") _cur.className = "";
      else _cur.className = "exp";
}

function openDialog(title, modId, shopVersions) {
    var mySelect = jQuery('#shopversel');
    mySelect.find('option').remove();

    jQuery("#modtitle").text(title);
    jQuery("#modid").val(modId);

    for(var propertyName in shopVersions) {
        mySelect.append(
            $('<option></option>').val(shopVersions[propertyName]['id']).html(shopVersions[propertyName]['ver'])
        );
    }

    var dlg = jQuery( "#dialog" ).dialog({
      modal: true,
      width: 600,
      buttons: {
        Installieren: function() {
            var agb = document.getElementById("checkAgbTop");

            if (agb.checked) {
              jQuery( this ).dialog( "close" );
              jQuery("#div-overlay").show();
              dlg.parent().appendTo(jQuery("#connector"));
              document.forms['connector'].submit();
            } else {
                alert("[{ oxmultilang ident="EXONN_CONNECTOR_AGB_BESTETIGUNG" }]")
            }

        }
      }
    });
}
//-->
</script>
<div id="div-overlay" style="display: none;"></div>
[{cycle assign="_clear_" values=",2" }]

<h2>[{ oxmultilang ident="EXONN_CONNECTOR_MODULEVERWALTEN" }]<span style="color: #999;font-size: 12px; display: inline-block;float: right;" >EXONN Connector ([{$selfversion}])</span></h2>

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="exonn_connector_main">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<link rel="stylesheet" href="[{$oViewConf->getBaseDir()}]modules/exonn_connector/views/admin/css/excon.css">
<link rel="stylesheet" href="[{$oViewConf->getBaseDir()}]modules/exonn_connector/views/admin/css/jquery-ui.css">
<script src="[{$oViewConf->getBaseDir()}]/out/admin/src/js/libs/jquery.min.js"></script>
<script src="[{$oViewConf->getBaseDir()}]/out/admin/src/js/libs/jquery-ui.min.js"></script>


<form name="connector" id="connector" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="exonn_connector_shop">
    <input type="hidden" name="fnc" value="orderDemo">
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="demoorder[oxid]" value="[{ $oxid }]">


    <div class="tabs" style="position: inherit; width: 100%; border-bottom: 1px solid #999;">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="tab inactive first">
                  <div class="r1"><div class="b1">
                     <a href="[{ $oViewConf->getSelfLink()}]&cl=exonn_connector_main">[{ oxmultilang ident="EXONN_CONNECTOR_ERHALTENE_MODULE" }]</a>
                  </div></div>
                </td>
                <td class="tab active last">
                  <div class="r1"><div class="b1">
                     <a href="[{ $oViewConf->getSelfLink()}]&cl=exonn_connector_shop">[{ oxmultilang ident="EXONN_CONNECTOR_VERFUGBARE_MODULE" }]</a>
                  </div></div>
                </td>
                <td class="line"></td>
            </tr>
        </table>
    </div>

        <div class="box next" style="margin-top:5%; height: 90%;">
  <br>

[{if $updateres == 'err'}]
    [{if $lasterr == "cant_copy_update"}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULES_ERR" }]</label>
    [{elseif $lasterr == "cant_extract_update"}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULES_ERR" }]</label>
    [{else}]
        [{include file="ec_error_msg.tpl" msg="EXONN_CONNECTOR_FEHLER_AUFGETRETEN"|oxmultilangassign param=$lasterr}]
[{/if}]<br>

[{elseif $updateres == 'ok'}]
        <label class="succ">[{ oxmultilang ident="EXONN_CONNECTOR_DIE_INSTALLATION_DES" }] [{$modTitle}] [{ oxmultilang ident="EXONN_CONNECTOR_30_TAGE_TESTVERSION" }]</label><br>
        [{include file="installed_msg.tpl"}]
[{else}]
        [{if $lasterr }]
            [{include file="ec_error_msg.tpl" msg="EXONN_CONNECTOR_BEI_DER_VERARBEITUNG"|oxmultilangassign param=$lasterr}]
        [{/if}]
[{/if}]

[{if $rights_updaterr}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULE_ERR" }] [{$rights_updaterr}]</label><br>
    [{/if}]
<br>
<div class="topinfo"><strong>[{ oxmultilang ident="EXONN_CONNECTOR_BITTE_LESEN" }]</strong> [{ oxmultilang ident="EXONN_CONNECTOR_EINE_AUFLISTUNG_DER_MODULE" }]<span class="basket"></span>[{ oxmultilang ident="EXONN_CONNECTOR_ZU_UNSEREM_SHOP_WEITERGELEITEN" }]<span class="demoinstall"></span> [{ oxmultilang ident="EXONN_CONNECTOR_BESTELLFORMULAR_AUSFULLEN" }].</div>

            <br>

    <table class="moduleslist" width="100%">
        <tr style="background: #eee;">
            <th>[{ oxmultilang ident="EXONN_CONNECTOR_MODULE_TITLE" }]</th>
            <th>[{ oxmultilang ident="EXONN_CONNECTOR_KURZBESCHREIBUNG" }]</th>
            <th width="130">[{ oxmultilang ident="EXONN_CONNECTOR_DAUERLIZENZ" }]</th><th width="130">[{ oxmultilang ident="EXONN_CONNECTOR_TESTVERSION" }]</th>
        </tr>
    [{foreach from=$modules item="module"}]
        <tr>
            <td style="font-size: 14px;">[{$module.title}]</td>
            <td>[{$module.desc}]</td>
            <td align="center"><a class="status_btn [{if $module.installed && !$module.trial}]installed ok[{elseif !$module.notpaid && !$module.trial}] ok installed[{else}]basket[{/if}]" href="[{$module.link}]" target="_blank">[{if $module.installed && !$module.trial}][{ oxmultilang ident="EXONN_CONNECTOR_BEREITS_INSTALLIERT" }][{elseif !$module.notpaid && !$module.trial}][{ oxmultilang ident="EXONN_CONNECTOR_BEREITS_GEKAUFT" }][{else}][{ oxmultilang ident="EXONN_CONNECTOR_JETZT_KAUFEN" }][{/if}]</a></td>
            <td align="center">[{if $module.trial}]<label class="status_btn [{if $module.installed}]installed[{else}] installdemo [{/if}] [{if $module.trialdownloaded}]demo[{/if}]" [{if !$module.installed }] onclick="openDialog('[{$module.title}]', '[{$module.id}]', [{$module.jsvers}])"[{/if}]>[{if $module.installed}][{ oxmultilang ident="EXONN_CONNECTOR_BEREITS_INSTALLIERT" }][{else}][{ oxmultilang ident="EXONN_CONNECTOR_JETZT_TESTEN" }][{/if}]</label>[{else}][{ oxmultilang ident="EXONN_CONNECTOR_NICHT_VERFUGBAR" }][{/if}]</td>
        </tr>
    [{/foreach}]
    </table>

</form>

    <div id="dialog" style="display: none;" title="[{ oxmultilang ident="EXONN_CONNECTOR_KOSTENLOSE_30_TAGE_TESTVERSION" }]">
    <br>
        <span style="font-weight: bold; font-size: 14px;" id="modtitle"></span>[{ oxmultilang ident="EXONN_CONNECTOR_KOSTENLOS_TESTEN"}]
        <br>
        <br>
        <input type="hidden" id="modid" name="demoorder[modid]">
        <table style="font-size: 12px;">
            <tr>
                <td class="edittext" >
                    [{ oxmultilang ident="EXONN_CONNECTOR_SHOP_VERSION"}]
                </td>
                <td class="edittext">
                <select id="shopversel" name="demoorder[artid]">

                </select>
                [{ oxinputhelp ident="HELP_SHOP_MAIN_COMPANY" }]
                </td>
            </tr>

            <tr>
                <td class="edittext" >
                   Email *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxinfoemail->fldmax_length}]" name="demoorder[oxinfoemail]" value="[{$shop->oxshops__oxinfoemail->value}]" [{ $readonly}]>
                </td>
            </tr>
         <tr>
                <td class="edittext" >
                   [{ oxmultilang ident="SHOP_MAIN_COMPANY" }]
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxcompany->fldmax_length}]" name="demoorder[oxcompany]" value="[{$shop->oxshops__oxcompany->value}]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_SHOP_MAIN_COMPANY" }]
                </td>
            </tr>
            <tr>
                <td class="edittext" width="100">
                            [{ oxmultilang ident="GENERAL_NAME" }] *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="10" maxlength="[{$shop->oxshops__oxfname->fldmax_length}]" name="demoorder[oxfname]" value="[{$shop->oxshops__oxfname->value }]" [{ $readonly}]>
                <input type="text" class="editinput" size="21" maxlength="[{$shop->oxshops__oxlname->fldmax_length}]" name="demoorder[oxlname]" value="[{$shop->oxshops__oxlname->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_ENERAL_NAME" }]
                </td>
            </tr>
            <tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_STREET" }] *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxstreet->fldmax_length}]" name="demoorder[oxstreet]" value="[{$shop->oxshops__oxstreet->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_STREET" }]
                </td>
            </tr>
            <tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_ZIPCITY" }] *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="5" maxlength="[{$shop->oxshops__oxzip->fldmax_length}]" name="demoorder[oxzip]" value="[{$shop->oxshops__oxzip->value }]" [{ $readonly}]>
                <input type="text" class="editinput" size="26" maxlength="[{$shop->oxshops__oxcity->fldmax_length}]" name="demoorder[oxcity]" value="[{$shop->oxshops__oxcity->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_ZIPCITY" }]
                </td>
            </tr>
            <!--tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_COUNTRY" }] *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxcountry->fldmax_length}]" name="demoorder[oxcountry]" value="[{$shop->oxshops__oxcountry->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_COUNTRY" }]
                </td>
            </tr-->
            <tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_TELEPHONE" }]
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxtelefon->fldmax_length}]" name="demoorder[oxtelefon]" value="[{$shop->oxshops__oxtelefon->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_TELEPHONE" }]
                </td>
            </tr>
            <tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_FAX" }]
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" maxlength="[{$shop->oxshops__oxtelefax->fldmax_length}]" name="demoorder[oxtelefax]" value="[{$shop->oxshops__oxtelefax->value }]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_FAX" }]
                </td>
            </tr>
            <tr>
                <td class="edittext">
                            [{ oxmultilang ident="GENERAL_URL" }] *
                </td>
                <td class="edittext">
                <input type="text" class="editinput" size="35" readonly="da" value="[{$shop_url}]" [{ $readonly}]>
                [{ oxinputhelp ident="HELP_GENERAL_URL" }]
                </td>
            </tr>
            </table>
            <br>
            <span style="font-size: 10px; color:#666;">[{ oxmultilang ident="EXONN_CONNECTOR_PFLICHTFELDER" }]</span>
            <br><br>
            <div class="agb">
              <strong style="font-size: 12px;"> [{ oxmultilang ident="EXONN_CONNECTOR_AGB_WIDERRUFSRECHT" }]</strong><br><br>
              <input id="checkAgbTop" class="checkbox" type="checkbox" name="ord_agb" value="1"> [{ oxmultilang ident="EXONN_CONNECTOR_ICH_HABE_DIE" }]
              <a style="color: #5e8ba7; text-decoration: underline;" id="test_OrderOpenAGBBottom" rel="nofollow" href="http://www.oxidmodule24.de/AGB/" onclick="window.open('http://www.oxidmodule24.de/AGB/?plain=1', 'agb_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=1050,height=400');return false;" class="fontunderline">[{ oxmultilang ident="EXONN_CONNECTOR_AGB" }]</a>
                [{ oxmultilang ident="EXONN_CONNECTOR_GELESEN_UND_EINVERSTANDEN" }] [{ oxmultilang ident="EXONN_CONNECTOR_ICH_WURDE_UBER_MEIN" }]
              <a style="color: #5e8ba7; text-decoration: underline;" id="test_OrderOpenWithdrawalBottom" rel="nofollow" href="http://www.oxidmodule24.de/Widerrufsrecht/" onclick="window.open('http://www.oxidmodule24.de/Widerrufsrecht/?plain=1', 'rightofwithdrawal_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=1050,height=400');return false;">[{ oxmultilang ident="EXONN_CONNECTOR_WIDERRUFSRECHT" }]</a>
                [{ oxmultilang ident="EXONN_CONNECTOR_INFORMIERT" }]

            </div>
    </div>




[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
