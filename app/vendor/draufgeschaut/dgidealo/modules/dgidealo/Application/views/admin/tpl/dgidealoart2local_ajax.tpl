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
                                                    '[{ $oViewConf->getAjaxLink() }]cmpid=container1&container=dgidealoart2local&synchoxid=[{ $oxid }]'
                                                    );

        [{assign var="sSep" value=""}]

        YAHOO.oxid.container2 = new YAHOO.oxid.aoc( 'container2',
                                                    [ [{ foreach from=$oxajax.container2 item=aItem key=iKey }]
                                                       [{$sSep}][{strip}]{ key:'_[{ $iKey }]', ident: [{if $aItem.4 }]true[{else}]false[{/if}]
                                                       [{if !$aItem.4 }],
                                                       label: '[{ oxmultilang ident="GENERAL_AJAX_SORT_"|cat:$aItem.0|oxupper }]',
                                                       visible: [{if $aItem.2 }]true[{else}]false[{/if}],
                                                       formatter: YAHOO.oxid.aoc.custFormatter
                                                       [{/if}]}
                                                      [{/strip}]
                                                      [{assign var="sSep" value=","}]
                                                      [{ /foreach }] ],
                                                    '[{ $oViewConf->getAjaxLink() }]cmpid=container2&container=dgidealoart2local&oxid=[{ $oxid }]'
                                                    )
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
        YAHOO.oxid.container1.getDropAction = function()
        {
            return 'fnc=dgAddArticle2Set';
        }

        YAHOO.oxid.container2.getDropAction = function()
        {
            return 'fnc=dgRemoveArticle2Set';
        }

        YAHOO.oxid.container2.subscribe( "rowClickEvent", function( oParam )
        {
            
        })
        YAHOO.oxid.container2.subscribe( "dataReturnEvent", function()
        {
            
        })
        YAHOO.oxid.container2.onSave = function()
        {
            YAHOO.oxid.container1.getDataSource().flushCache();
            YAHOO.oxid.container1.getPage( 0 );
            YAHOO.oxid.container2.getDataSource().flushCache();
            YAHOO.oxid.container2.getPage( 0 );
        }
        YAHOO.oxid.container2.onFailure = function() { /* currently does nothing */ }
        YAHOO.oxid.container2.saveAttribute = function()
        {
            var callback = {
                success: YAHOO.oxid.container2.onSave,
                failure: YAHOO.oxid.container2.onFailure,
                scope:   YAHOO.oxid.container2
            };
            YAHOO.util.Connect.asyncRequest( 'GET', '[{ $oViewConf->getAjaxLink() }]&cmpid=container2&container=dgidealoart2local&fnc=dgSaveAmountValue&oxid=[{ $oxid }]&oxtype_value=' + encodeURIComponent( $('oxtype_value').value ) + '&oxamount_value=' + encodeURIComponent( $('oxamount_value').value ) + '&oxtype_oxid=' + encodeURIComponent( $('oxtype_oxid').value ), callback );

        }
        // subscribint event listeners on buttons
        $E.addListener( $('saveBtn'), "click", YAHOO.oxid.container2.saveAttribute, $('saveBtn') );

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
            <td align="center"><b>aktive Idealo Artikel</b></td>
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
            <td></td>
        </tr>
        <tr>
            <td valign="top" id="container1"></td>
            <td valign="top" id="container2"></td>
            <td valign="top" align="center" class="edittext" id="arrt_conf" style="visibility:hidden">
            </td>
        </tr>
        <tr>
            <td class="oxid-aoc-actions"><input type="button" value="[{ oxmultilang ident="GENERAL_AJAX_ASSIGNALL" }]" id="container1_btn" /></td>
            <td class="oxid-aoc-actions"><input type="button" value="[{ oxmultilang ident="GENERAL_AJAX_UNASSIGNALL" }]" id="container2_btn" /></td>
            <td></td>
        </tr>
    </table>
</body>
</html>