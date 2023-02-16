[{if (!$oView->isWawi) }]
    [{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]
[{/if}]

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
[{if $reload}]
window.onload = function(){
  document.forms['transfer'].submit();
}
[{/if}]

function openDialog(text) {
    jQuery("#verMessage").html(text);

    var dlg = jQuery( "#dialog" ).dialog({
      modal: true,
      width: 700,
      buttons: {
             "Schliessen": function() {
                jQuery( this ).dialog( "close" );
             },
      }
    });
    return false;
}

function confirmAction(msg) {
    if(confirm(msg)) {
        jQuery("#div-overlay").show();
        return true;
    } return false;
}
//-->
</script>
<div id="div-overlay" style="display: none;"></div>
[{if $reload}]
<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="cl" value="exonn_connector_main">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
    <div class="topinfo">[{ oxmultilang ident="EXONN_CONNECTOR_SELF_AKTUALISIEREN" }]</div>
</form>
[{else}]

[{cycle assign="_clear_" values=",2" }]
<h2>Module verwalten<span style="color: #999;font-size: 12px; display: inline-block;float: right;" >EXONN Connector ([{$selfversion}])</span></h2>

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
    <input type="hidden" name="cl" value="exonn_connector_main">
    <input type="hidden" name="fnc" value="updateModules">
    <input type="hidden" name="oxid" value="[{ $oxid }]">
    <input type="hidden" name="editval[oxshops__oxid]" value="[{ $oxid }]">

    <div class="tabs" style="position: inherit; width: 100%; border-bottom: 1px solid #999;">
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="tab active first">
                  <div class="r1"><div class="b1">
                     <a href="[{ $oViewConf->getSelfLink()}]&cl=exonn_connector_main">[{ oxmultilang ident="EXONN_CONNECTOR_ERHALTENE_MODULE" }]</a>
                  </div></div>
                </td>
                <td class="tab inactive last">
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

    [{if $rights.modules != "ok"}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULES_ERR" }]</label><br>
    [{/if}]
    [{if $rights.tmp != "ok"}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_TMP_ERR" }]</label><br>
    [{/if}]
    [{if $rights_updaterr}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULE_ERR" }] [{$rights_updaterr}]</label><br>
    [{/if}]
    [{if $lasterr == "cant_self_update"}]
        <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULE_ERR" }] [{$lasterr_info}]</label><br>
    [{/if}]

    [{if $updateres}]
        [{if $updateres == 'err'}]

            [{if $lasterr == "cant_self_update"}]
                    <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULE_ERR" }] [{$lasterr_info}]</label>
            [{elseif $lasterr == "cant_extract_update"}]
                    <label class="err">[{ oxmultilang ident="EXONN_CONNECTOR_777_MODULES_ERR" }]</label>
            [{else}]
                    [{include file="ec_error_msg.tpl" msg="EXONN_CONNECTOR_BEI_DER_VERARBEITUNG"|oxmultilangassign param=$lasterr}]
            [{/if}]

        [{elseif $updateres == 'ok' && $lastaction == 'update'}]<label class="succ">[{ oxmultilang ident="EXONN_CONNECTOR_DIE_AKTUALISIERUNG_DES" }] [{$modTitle}] [{ oxmultilang ident="EXONN_CONNECTOR_WURDE_ERFOLGREICH_DURCHGEFUHRT" }] [{ oxmultilang ident="EXONN_CONNECTOR_CHECK_ACTIVE" args=$installedModInfo.title}]</label>
        [{elseif $updateres == 'ok' && $lastaction == 'request'}]<label class="succ">[{ oxmultilang ident="EXONN_CONNECTOR_DIE_UPDATE_ANFRAGE" }]</label>
        [{elseif $updateres == 'ok' && $lastaction == 'install'}]<label class="succ">[{ oxmultilang ident="EXONN_CONNECTOR_DIE_INSTALLATION" }] [{$modTitle}] [{ oxmultilang ident="EXONN_CONNECTOR_ERFOLGREICH_DURCHGEFUHRT" }] [{ oxmultilang ident="EXONN_CONNECTOR_CHECK_ACTIVE" args=$installedModInfo.title}]</label>
        [{elseif $updateres == 'ok' && $lastaction == 'restore'}]<label class="succ">[{ oxmultilang ident="EXONN_CONNECTOR_DAS_UPDATE" }] [{$modTitle}] [{$modTitle}] [{ oxmultilang ident="EXONN_CONNECTOR_RUCKGENGIG_GEMACHT" }]</label>
        [{/if}]
        [{*if $updateres == 'ok' && $lastaction == 'update' && !$installedModInfo.active}]
            [{include file="installed_msg.tpl" updateaction=1}]
        [{/if*}]

        [{if $updateres == 'ok' && $lastaction == 'install'}]
            [{include file="installed_msg.tpl"}]
        [{/if}]
        <br>
    [{else}]
        [{if $lasterr }]
            [{include file="ec_error_msg.tpl" msg="EXONN_CONNECTOR_BEI_DER_VERARBEITUNG"|oxmultilangassign param=$lasterr}]
        [{/if}]
    [{/if}]

    <input type="hidden" name="update_module" id="update_module" value="">
    <script type="application/javascript">
        function updateModule(id) {
            if(confirmAction('[{ oxmultilang ident="EXONN_CONNECTOR_UPDATE_STARTEN"}]?')) {
                document.getElementById("update_module").value = id;
                document.getElementById("connector").submit();
            }
        }
    </script>
        <br>
    <div class="topinfo"><strong>[{ oxmultilang ident="EXONN_CONNECTOR_BITTE_LESEN" }]</strong> [{ oxmultilang ident="EXONN_CONNECTOR_AUFLISTUNG_DER_MODULE" }] <span class="update"></span>, [{ oxmultilang ident="EXONN_CONNECTOR_MODUL_AKTUALISIEREN" }]<span class="restore"></span> [{ oxmultilang ident="EXONN_CONNECTOR_KLICKEN" }].</div>
    <table class="moduleslist" width="100%">
        <tr style="background: #eee;">
            <th width="20%">[{ oxmultilang ident="EXONN_CONNECTOR_MODULE_TITLE" }]</th>
            <th width="7%">[{ oxmultilang ident="EXONN_CONNECTOR_CURRENT_VERSION" }]</th>
            <th width="7%">[{ oxmultilang ident="EXONN_CONNECTOR_NEW_VERSION" }]</th>
            <th width="50%">[{ oxmultilang ident="EXONN_CONNECTOR_INFO" }]</th>
            <th width="120">[{ oxmultilang ident="EXONN_CONNECTOR_ACTION" }]</th>
            <th title="[{ oxmultilang ident="EXONN_CONNECTOR_VERSION_ZURUCKSETZEN" }]">[{ oxmultilang ident="EXONN_CONNECTOR_ZURUCK" }]</th>
            <th width="120">[{ oxmultilang ident="EXONN_CONNECTOR_MODUL_DOKUMENTATION" }]</th>
        </tr>
        [{if $installed|@count == 0}]
        [{/if}]
    [{foreach from=$installed item="module"}]
        <tr class="[{if $module.nowver == $module.newver}]modok[{elseif !$module.valid}][{if $module.requested}]modwait[{else}]moderr[{/if}][{else}]modup[{/if}]">
            <td class="modtitle [{if $module.active}]active[{elseif $module.installed}]inactive[{/if}]" style="font-size: 14px;">[{$module.title}]</td>
            <td align="center">[{if $module.nowver}][{ $module.nowver}][{else}][{ oxmultilang ident="EXONN_CONNECTOR_NOTINSTALLED" }][{/if}]</td>
            <td align="center">
            [{if $module.brief}]
                <a href="javascript:;" title="[{ oxmultilang ident="EXONN_CONNECTOR_WAS_GIBT_ES_NEUES" }]" onclick="openDialog('[{$module.brief}]');"><label class="status_btn version">[{$module.newver}]</label></a>
            [{else}]
                <label [{if  $module.nowver != $module.newver}]style="color: #2d79da;font-weight: bold;"[{/if}]>[{$module.newver}]</label>
            [{/if}]
            </td>

             <td>[{if !$module.valid}][{if $module.requested}][{ oxmultilang ident="EXONN_CONNECTOR_ANFRAGE_WEGEN_MODUL"}]
                                     [{else}][{ oxmultilang ident="EXONN_CONNECTOR_ANFRAGE_VERSENDEN"}][{/if}]
                [{elseif $module.trial && $module.daysLeft <= 0}][{ oxmultilang ident="EXONN_CONNECTOR_DAUERLIZENZ_ERWERBEN"}] <span class="inlinebasket"></span> [{ oxmultilang ident="EXONN_CONNECTOR_WEITERGELEITET"}]
                [{elseif $module.installed && ($module.nowver == $module.newver || !$module.newver)}][{ oxmultilang ident="EXONN_CONNECTOR_SIE_VERWENDEN_EINE_AKTUELLE_VERSION"}]
                [{elseif $module.brief|count && !$module.mustpaid}][{ oxmultilang ident="EXONN_CONNECTOR_STEHT_ZUR_VERFUGUNG"}]
                [{elseif $module.mustpaid}][{ oxmultilang ident="EXONN_CONNECTOR_KEIN_KOSTENLOSES_UPDATE"}]
                [{elseif $module.notpaid}][{ oxmultilang ident="EXONN_CONNECTOR_EINGANG_DER_BESTELLUNG"}]
                [{else}][{ oxmultilang ident="EXONN_CONNECTOR_MODUL_IST_INSTALLATIONSBEREIT"}][{/if}]
            </td>
            <td align="center">
                [{if $module.notpaid}]<label class="status_btn extend">[{ oxmultilang ident="EXONN_CONNECTOR_NICHT_BEZAHLT"}]</label>
                [{elseif !$module.valid}][{if $module.requested}]<label class="status_btn wait">[{ oxmultilang ident="EXONN_CONNECTOR_WARTEN_AUF_ANTWORT"}]</label>
                [{else}]<button class="status_btn request" name="update_request" value="[{$module.id}]">[{ oxmultilang ident="EXONN_CONNECTOR_ANFRAGE_SENDEN"}]</button>[{/if}]
                [{elseif $module.mustpaid && !$module.trial}]<a target="_blank" href="[{$module.paylink}]?key=[{$module.artid}]" class="status_btn extend">[{ oxmultilang ident="EXONN_CONNECTOR_UPDATE_SERVICE"}]</a>
                [{else}]
                    [{if $module.installed}]
                        [{if $module.nowver != $module.newver && $module.newver}]
                            [{if $module.trial}]
                            <label class="status_btn demo">Demo</label>
                            [{else}]
                            <button class="status_btn update" name="update_module" value="[{$module.artid}]-[{$module.id}]" onclick="return confirmAction('[{ oxmultilang ident="EXONN_CONNECTOR_UPDATE_STARTEN"}]?');">[{ oxmultilang ident="EXONN_CONNECTOR_AKTUALISIEREN"}]</button>
                            [{/if}]
                        [{else}]<label class="status_btn [{if $module.trial}]demo[{else}]ok[{/if}]" ondblclick="updateModule('[{$module.artid}]-[{$module.id}]');">[{if $module.trial}][{ oxmultilang ident="EXONN_CONNECTOR_DEMO"}][{else}][{ oxmultilang ident="EXONN_CONNECTOR_OK"}][{/if}]</label>[{/if}]
                    [{else}]
                        [{if $module.trialdownloaded && $module.daysLeft <= 0}]
                            <a class="status_btn basket" href="[{$module.link}]" target="_blank">[{ oxmultilang ident="EXONN_CONNECTOR_JETZT_KAUFEN"}]</a>
                        [{else}]
                            <button class="status_btn install" name="install_module" value="[{$module.artid}]-[{$module.id}]" onclick="return confirmAction('Jetzt installieren?');">[{ oxmultilang ident="EXONN_CONNECTOR_INSTALLIEREN"}]</button>
                        [{/if}]
                    [{/if}]
                [{/if}]
            </td>
            <td align="center"><button title="[{ oxmultilang ident="EXONN_CONNECTOR_ZURUCKSETZEN"}]"  class="status_btn restore [{if !$module.prevver }]notactive[{/if}]" [{if !$module.prevver }]disabled[{/if}] value="[{$module.id}]" [{if $module.prevver }] name="restore_module" onclick="return confirmAction('[{ oxmultilang ident="EXONN_CONNECTOR_MOCHTEN_SIE_ZURUCKSETZEN"}]');"[{/if}]> </button></td>
            <td align="center">
               <a class="status_btn docs [{if !$module.docs && !$module.readme}]notactive[{/if}]" href="[{if $module.docs}][{$module.docs}][{else}]#[{/if}]"  onclick="[{if !$module.docs && $module.readme}]window.open('[{$module.readme}]', 'mywin','left=100,top=100,width=768,height=300,scrollbars=1,resizable=0'); return false;[{else}][{/if}]"  target="_blank">[{ oxmultilang ident="EXONN_CONNECTOR_JETZT_LESEN"}]</a>
            </td>
                [{*if $updateres && $updateres[$module.id] == "ok"}][{$updateres[$module.id]}][{else}][{$updateres[$module.id]}][{/if*}]</td>
        </tr>
    [{/foreach}]
    </table>
    <div id="dialog" style="display: none;" title="[{ oxmultilang ident="EXONN_CONNECTOR_WAS_GIBT_ES_NEUES"}]?">
        <div id="verMessage"></div>
    </div>
</form>
[{/if}]

[{include file="bottomnaviitem.tpl"}]
[{include file="bottomitem.tpl"}]
