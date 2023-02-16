[{*Add to metadata.php: array('template' => 'delivery_main.tpl', 'block'=>'admin_delivery_main_form', 'file'=>'admin_delivery_main_form.tpl'), *}]

[{$smarty.block.parent}]
<script type="">
    function showServiceOptions(service, iFrameId) {
        var servInfos = document.getElementsByClassName('service_info_' + iFrameId);

        for (var i = 0; i < servInfos.length; i ++) {
            servInfos[i].style.display = 'none';
        }

        var servInfos = document.getElementsByClassName(service + "_info_" + iFrameId);

        for (var i = 0; i < servInfos.length; i ++) {
            servInfos[i].style.display = '';
        }
    }
</script>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td class="edittext">
                    Versand service
                </td>
                <td class="edittext">
                    <select class="editinput" name="editval[oxdelivery__oxdelservice]" onchange="showServiceOptions(this.value, '[{$iframeId}]')">
                        <option value="">---</option>
                        <option value="dhl" [{if $edit->oxdelivery__oxdelservice->value == "dhl"}]selected[{/if}]>DHL</option>
                        <option value="dpd" [{if $edit->oxdelivery__oxdelservice->value == "dpd"}]selected[{/if}]>DPD</option>
                        <option value="ups" [{if $edit->oxdelivery__oxdelservice->value == "ups"}]selected[{/if}]>UPS</option>
                        <option value="gls" [{if $edit->oxdelivery__oxdelservice->value == "gls"}]selected[{/if}]>GLS</option>
                        <option value="hermes" [{if $edit->oxdelivery__oxdelservice->value == "hermes"}]selected[{/if}]>Hermes</option>
                    </select>
                </td>
            </tr>

            <tr class="service_info_[{$iframeId}] dhl_info_[{$iframeId}]">
                <td class="edittext" width="140">
                -- [{ oxmultilang ident="DHLIS_PARENTID" }]
                </td>
                <td class="edittext" width="250">
                <input type="text" class="editinput" size="5" maxlength="[{$edit->oxdelivery__dhlispartner_id->fldmax_length}]" name="editval[oxdelivery__dhlispartner_id]" value="[{$edit->oxdelivery__dhlispartner_id->value}]" [{ $readonly }]>
                </td>
            </tr>
            <tr class="service_info_[{$iframeId}] dhl_info_[{$iframeId}]">
                <td class="edittext" width="140">
                -- [{ oxmultilang ident="DHLIS_PRODTYPE" }]
                </td>
                <td class="edittext" width="250">
                <select name="editval[oxdelivery__dhlisprod_code]" [{ $readonly }]>
                     <option> - </option>
                     <option value="BPI" [{if $edit->oxdelivery__dhlisprod_code->value == "BPI"}]selected="y"[{/if}]>BPI - Weltpaket</option>
                     <option value="EPI" [{if $edit->oxdelivery__dhlisprod_code->value == "EPI"}]selected="y"[{/if}]>EPI - DHL Europaket</option>
                     <option value="EPN" [{if $edit->oxdelivery__dhlisprod_code->value == "EPN"}]selected="y"[{/if}]>EPN - DHL Paket</option>
                </select>
                </td>
            </tr>
            <script type="application/javascript">
                showServiceOptions('[{$edit->oxdelivery__oxdelservice->value}]', '[{$iframeId}]');
            </script>