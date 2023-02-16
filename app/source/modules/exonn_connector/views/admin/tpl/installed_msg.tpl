<div id="ok_msg" style="display: none;">
    <p>[{ oxmultilang ident="EXONN_CONNECTOR_DIE_INSTALLATION_DONE" args=$installedModInfo.title}]</p>
    <hr>

    <p>[{ oxmultilang ident="EXONN_CONNECTOR_EINSTELLUNGEN_VORNEHMEN" }]</p>
    <p>[{ oxmultilang ident="EXONN_CONNECTOR_MODUL_DOKUMENTATION_TEXT" }]</p>
</div>
<script type="text/javascript">
    var dlg = jQuery( "#ok_msg" ).dialog({
          modal: true,
          width: 600,
          buttons: {
             "[{ oxmultilang ident="EXONN_CONNECTOR_JETZT_LESEN" }]": function() {
                jQuery( this ).dialog( "close" );
                [{if $installedModInfo.docs}]window.open('[{$installedModInfo.docs}]','mywindow','width=1000,height=600');
                [{else}]window.open('[{$oViewConf->getBaseDir()}]/modules/[{$installedModInfo.id}]/readme.txt','mywindow','width=1000,height=600');[{/if}]
             },
             "[{ oxmultilang ident="EXONN_CONNECTOR_SPATER_LESEN" }]": function() {
                jQuery( this ).dialog( "close" );
             },
          }
    });
</script>