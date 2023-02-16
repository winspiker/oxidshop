[{include file="popups/headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign}]

<script type="text/javascript">
    initAoc = function()
    {

        YAHOO.oxid.container1 = new YAHOO.oxid.aoc( 'container1',
                                                    [ [{ foreach from=$oxajax.container1 item=aItem key=iKey }]
                                                       [{$sSep}][{strip}]{ key:'_[{ $iKey }]', ident: [{if $aItem.4 }]true[{else}]false[{/if}]
                                                       [{if !$aItem.4 }],
                                                       label: '[{ oxmultilang ident="GENERAL_AJAX_SORT_"|cat:$aItem.0|oxupper }]',
                                                       visible: [{if $aItem.2 }]true[{else}]false[{/if}]
                                                       [{/if}]}
                                                      [{/strip}]
                                                      [{assign var="sSep" value=","}]
                                                      [{ /foreach }] ],
                                                    '[{ $oViewConf->getAjaxLink() }]cmpid=container1&container=dgidealodeliveryart&synchoxid=[{ $oxid }]'
                                                    );

        [{assign var="sSep" value=""}]

        YAHOO.oxid.container1.modRequest = function( sRequest )
        {
            oSelect = $('artcat');
            if ( oSelect.selectedIndex ) {
                sRequest += '&oxid='+oSelect.options[oSelect.selectedIndex].value+'&synchoxid=[{ $oxid }]';
            }
            return sRequest;
        }
        YAHOO.oxid.container1.filterCat = function( e, OObj )
        {
            YAHOO.oxid.container1.getPage( 0 );
        }



        YAHOO.oxid.container1.subscribe( "rowClickEvent", function( oParam )
        {
            var aSelRows= YAHOO.oxid.container1.getSelectedRows();
            if ( aSelRows.length ) {
                oParam = YAHOO.oxid.container1.getRecord(aSelRows[0]);
                $('_attrname').innerHTML = oParam._oData._0;
                $('oxamount_value').value    = oParam._oData._3;
                
                $('oxtype_oxid').value     = oParam._oData._4;
                $D.setStyle( $('arrt_conf'), 'visibility', '' );
            } else {
                $D.setStyle( $('arrt_conf'), 'visibility', 'hidden' );
            }
        })
        YAHOO.oxid.container1.subscribe( "dataReturnEvent", function()
        {
            $D.setStyle( $('arrt_conf'), 'visibility', 'hidden' );
        })
        YAHOO.oxid.container1.onSave = function()
        {
            YAHOO.oxid.container1.getDataSource().flushCache();
            YAHOO.oxid.container1.getPage( 0 );
        }
        YAHOO.oxid.container1.onFailure = function() { /* currently does nothing */ }
        YAHOO.oxid.container1.saveAttribute = function()
        {
            var callback = {
                success: YAHOO.oxid.container1.onSave,
                failure: YAHOO.oxid.container1.onFailure,
                scope:   YAHOO.oxid.container1
            };
            YAHOO.util.Connect.asyncRequest( 'GET', '[{ $oViewConf->getAjaxLink() }]&cmpid=container1&container=dgidealodeliveryart&fnc=dgSaveAmountValue&oxid=[{ $oxid }]&oxamount_value=' + encodeURIComponent( $('oxamount_value').value ) 
             + '&oxtype_oxid=' + encodeURIComponent( $('oxtype_oxid').value ), callback );

        }
        // subscribint event listeners on buttons
        $E.addListener( $('saveBtn'), "click", YAHOO.oxid.container1.saveAttribute, $('saveBtn') );

        $E.addListener( $('artcat'), "change", YAHOO.oxid.container1.filterCat, $('artcat') );
    }
    $E.onDOMReady( initAoc );
</script>

    <table width="100%">
        <colgroup>
            <col span="2" width="40%" />
            <col width="20%" />
        </colgroup>
        <tr class="edittext">
            <td colspan="3">[{ oxmultilang ident="GENERAL_AJAX_DESCRIPTION" }]<br>[{ oxmultilang ident="GENERAL_FILTERING" }]<br /><br /></td>
        </tr>
        <tr class="edittext">
            <td align="center"><b>alle verf&uuml;gbaren Artikel</b></td>
            <td></td>
        </tr>
        <tr>
            <td class="oxid-aoc-category">
                <select name="artcat" id="artcat">
                [{foreach from=$artcattree item=pcat}]
                <option value="[{ $pcat->oxcategories__oxid->value }]">[{ $pcat->oxcategories__oxtitle->value }]</option>
                [{/foreach}]
                </select>
            </td>
            <td></td>
        </tr>
        <tr>
            <td valign="top" id="container1"></td>
            <td valign="top" align="center" class="edittext" id="arrt_conf" style="visibility:hidden">
            
              <b>Artikel <span id="_attrname">[{ $attr_name }]</span></b><br><br>
              <input id="oxtype_oxid" type="hidden" />
              <select id="oxamount_value" class="editinput" type="text">
              <option value=""> - </option>
                <option value="Download">Wert Download &uuml;bertragen</option>
                <option value="Paketdienst">Wert Paketdienst &uuml;bertragen</option>
                <option value="Spedition">Wert Spedition &uuml;bertragen</option>
                <option value="Briefversand">Wert Briefversand &uuml;bertragen</option>
              </select>
              <br />
              <small>wird kein Preis hinterlegt,<br /> wird der Preis vom Pfandartikel genutzt</small>
              <br /><br />
              <input id="saveBtn" type="button" class="edittext" value="[{ oxmultilang ident="ARTICLE_ATTRIBUTE_SAVE" }]" />
            </td>
        </tr>
       
    </table>
</body>
</html>