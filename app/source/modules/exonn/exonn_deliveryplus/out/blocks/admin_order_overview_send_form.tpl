[{*Add to metadata.php: array('template' => 'order_overview.tpl.tpl', 'block'=>'admin_order_overview_send_form', 'file'=>'admin_order_overview_send_form.tpl'), *}]

[{$smarty.block.parent}]

[{ assign var="oViewConf" value=$oView->getViewConfig() }]

[{oxscript include="js/libs/jquery.min.js"}]

<tr>
    <td colspan="2">
        <br>
        <br>
        <style>
            .services {
                width: 610px;
            }
            .convert-table-title {
                font-size: 14px;
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
                text-shadow: 1px 1px 1px #aaa;
            }
            .col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12 {
                float: left
            }

            .col-md-12 {
                width: 100%
            }

            .col-md-11 {
                width: 91.66666667%
            }

            .col-md-10 {
                width: 83.33333333%
            }

            .col-md-9 {
                width: 75%
            }

            .col-md-8 {
                width: 66.66666667%
            }

            .col-md-7 {
                width: 58.33333333%
            }

            .col-md-6 {
                width: 50%
            }

            .col-md-5 {
                width: 41.66666667%
            }

            .col-md-4 {
                width: 33.33333333%
            }

            .col-md-3 {
                width: 25%
            }

            .col-md-2 {
                width: 16.66666667%
            }

            .col-md-1 {
                width: 8.33333333%
            }

            .packetInfo .packetTitle {
                background: #eee;
                margin-bottom: 2px;
                padding: 3px;
                padding-left: 5px;
                margin-top: 1px;
            }

            .packetInfo .positionInfo > div {
                float: left;
                margin-right: 5px;
            }

            .packetInfo .pack-col {
                float: left;
                margin-right: 5px;
                background: #fff;
                padding: 4px;
            }

            .packetInfo .pack-col.long-col {
                float: left;
                margin-right: 0;
                background: #fff;
                padding: 0;
                width: 100%;
            }

            .packetInfo .pack-col-0 {
                font-size:14px;
                background: none;
            }

            .packetInfo .pack-cod {
                border-left: 1px solid #333;
                padding: 5px;
            }

            .packetInfo .pack-col-0 span {
                display: inline-block;
                height: 100%;
                width: 32px;
                text-align: center;
            }

            .packetInfo .pack-cod span {
                width: auto;
            }

            .packetInfo .pack-table {
                background: #eee;
                display:flex;
                align-items:center;
                text-align: left;
            }

            .packetInfo {
                background: #fAfAfA; border: 1px solid #ccc;
            }

            .packetInfo .pack-col-5 {
                float: right;;
            }

            .packetInfo a {
                text-decoration: none;
            }

            .packetInfo .label_action {
                background: url([{$oViewConf->getModuleUrl("exonn_deliveryplus", "out/img/delimages.png")}]) no-repeat;
                display: inline-block;
                width: 39px;
                height: 39px;
            }

            .packetInfo .label_action:hover {
                background-position-y: -40px;
            }

            .packetInfo .label_track {
                background-position: -160px 0;
            }

            .packetInfo .label_print {
                background-position: -120px 0;
            }

            .packetInfo .labeldoc_print {
                background-position: -284px 0;
            }

            .packetInfo .label_cancel {
                background-position: -201px 0;
            }

            .packetInfo .label_disable {
                background-position: -80px 0;
            }

            .packetInfo .label_clear {
                background-position: -201px 0;
            }

            .packetInfo .label_err {
                background-position: -40px 0;
            }

            .packetInfo .label_renew {
                background-position: -243px 0;
            }

            .packetInfo .label_muted {
                opacity: .5;
            }

            .packetInfo .packet_actions {
                position: absolute;
                box-shadow: 0 0 4px #666;
                display: block;
                width: 200px;
                display: none;
                background: #fff;
                z-index: 999;
            }

            .packetInfo .packet_actions li {
                display: block;
                padding: 10px;
                list-style: none;
                background: none;
                border-left: 4px solid #ddd;
            }

            .packetInfo .packet_actions li:hover {
                background: #eee;
                border-left: 4px solid dodgerblue;

            }

            .packetInfo .packet_actions li a {
                display: block;
            }

            .footer_buttons a {
                display: inline-block;
                border: 1px solid #cccccc;
                padding: 4px;
                margin-right: 5px;;
            }

            .footer_buttons a.print {
                border-left: 3px solid green;
            }

            .footer_buttons a.storno {
                border-left: 3px solid red;
            }

            .footer_buttons a.renew {
                border-left: 3px solid dodgerblue;
            }
        </style>

        <script type="application/javascript">

            var isOrderCOD = [{if $edit->isCODPayment()}]1[{else}]0[{/if}];

            function deleteLabel(service, packetId, clear, sendEmail) {
                var addMessage = "";
                if (isOrderCOD && service == "ups") {
                    addMessage = " Wegen Nachname alle packeten werden storniert.";
                }

                if (confirm((packetId ? "Etikett stornieren? " + addMessage : 'Alle Etiketten stornieren?'))) {
                    console.log("remove " + service + " - " + packetId);
                    jQuery("#exonn_delext #packetid").val(packetId);
                    jQuery("#exonn_delext #service").val(service);
                    jQuery("#exonn_delext #clearlabel").val(clear);
                    jQuery("#exonn_delext #sendemail").val(sendEmail);
                    jQuery("#exonn_delext #fnc").val('cancelLabel');

                    document.exonn_delext.submit();
                    top.forceReloadingEditFrame();
                } else {
                    return false;
                }
            }

            function disableLabel(packetId) {
                if (confirm('Dieser Paket ausnahmen?')) {
                    jQuery("#exonn_delext #packetid").val(packetId);
                    jQuery("#exonn_delext #clearlabel").val(1);
                    jQuery("#exonn_delext #fnc").val('cancelLabel');
                    document.exonn_delext.submit();
                    top.forceReloadingEditFrame();
                } else {
                    return false;
                }
            }

            function labelRenew(packetId, service) {
                if (confirm("Etikett wiederstellen?")) {
                    jQuery("#exonn_delext #packetid").val(packetId);
                    jQuery("#exonn_delext #service").val(service);
                    jQuery("#exonn_delext #fnc").val('renewLabel');
                    document.exonn_delext.submit();
                    top.forceReloadingEditFrame();
                } else {
                    return false;
                }
            }

            function toggleElement(id) {
                jQuery("#" + id).toggle();
            }

            function openLinkAndReload(url) {
                console.log("openLinkAndReload");

                window.open(url, '_blank');
                window.focus();
                document.exonn_delext.submit();
            }

        </script>

        <form name="exonn_delext" id="exonn_delext" action="[{ $oViewConf->getSelfLink() }]" method="post">
            [{ $oViewConf->getHiddenSid() }]
            <input type="hidden" name="cl" value="order_overview">
            <input type="hidden" name="fnc" id="fnc" value="">
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="packetid" id="packetid" value="">
            <input type="hidden" name="service" id="service" value="">
            <input type="hidden" name="clearlabel" id="clearlabel" value="">
            <input type="hidden" name="sendemail" id="sendemail" value="">
            <input type="hidden" name="editval[oxorder__oxid]" value="[{ $oxid }]">

            [{assign var="downloadlabelURL" value=$oViewConf->getBaseDir()|cat:"/index.php?cl=exonn_delext_info&fnc=downloadlabel&orderid="|cat:$oxid}]
            [{assign var="downloadDocURL" value=$oViewConf->getBaseDir()|cat:"/index.php?cl=exonn_delext_info&fnc=downloadlabeldoc&orderid="|cat:$oxid}]

        [{foreach from=$delPackets key=deltype item=packets}]
            <div class="services" style="padding: 5px; border: 1px solid #999; margin-bottom: 10px;">
                <!-- header -->
                <div class="convert-table-title"><span style="text-transform: uppercase;">[{$deltype}]</span></div>
                <!-- header -->

                <!-- labels -->
                <div class="convert-table-frame" style="margin-bottom: 5px;">
                    <div>
                    [{assign var="packetsPositionArtNum" value=""}]

                    [{foreach from=$packets item=packet name=packetsInfo}]
                        [{if $packetsPositionArtNum != "" && $packetsPositionArtNum != $packet->getLastPositionArtNum()}]
                            [{assign var="newGroup" value="1"}]
                        [{else}]
                            [{assign var="newGroup" value="0"}]
                        [{/if}]
                        [{assign var="packetsPositionArtNum" value=$packet->getLastPositionArtNum()}]

                        [{assign var="delivery" value=$packet->getDelivery()}]

                        <div class="packetInfo" style=" border-left-color: [{if $packet->getNumber() && !$packet->getErr()}]green[{else}][{if $packet->getErr()}]red[{else}]#ccc[{/if}][{/if}];
                            border-left-width: 4px; [{if $packet->isCanceled()}]border-left-style: dashed; color:#999;[{/if}] margin-bottom: 5px; [{if $newGroup}]margin-top: 10px;[{/if}]">

                            <div class="row packetTitle">
                                <div class="col-md-2"><b>Paket [{$smarty.foreach.packetsInfo.index+1}]:</b></div>
                                <div class="col-md-10">[{if  $delivery }]<a href="#" id="delivery_[{$delivery->getId()}]" data-type="text" data-pk="1" data-original-title="">[{$delivery->oxdelivery__oxtitle->value|truncate:100:"...":true}]</a>[{/if}]</div>
                                <br style="clear: both">
                            </div>
                            <div>
                                <div class="pack-table">
                                    <div class="pack-col pack-col-0">
                                        <span [{if $packet->getPackageWeight() == 0}]style="color: red;"[{/if}]>[{$packet->getPackageWeight()}]kg</span>
                                    </div>
                                    [{if $edit->isCODPayment()}]
                                    <div class="pack-col pack-col-0 pack-cod" >
                                        <span>[{$packet->getPackagePrice()|round:2}]&euro;</span>
                                    </div>
                                    [{/if}]
                                    <div class="pack-col long-col">
                                        <div class="pack-col pack-col-1">
                                        [{foreach from=$packet->getPositions() item=position name=packetsArts}]
                                            [{assign var="article" value=$position->getArticle()}]
                                            [{assign var="lastpacketsPositionArtNum" value=$article->oxarticles__oxartnum->value}]
                                            <div class="row positionInfo">
                                                [{*$packetsPositionArtNum}] - [{$lastpacketsPositionArtNum*}]
                                                [{if $article->oxarticles__oxartnum->value == ""}]
                                                <div>Zusätzliche kosten:</div>
                                                [{else}]
                                                <div>[[{$article->oxarticles__oxartnum->value}]]</div>
                                                <div>[{$position->getAmount()}]St</div>
                                                <div [{if $position->getWeight() == 0}]style="color: orange;"[{/if}]>[{$position->getWeight()}]kg</div>
                                                [{/if}]
                                                [{$position->getAmountPrice()}]&euro;

                                            </div>
                                        [{/foreach}]
                                        </div>

                                        <div class="pack-col pack-col-4">
                                            <b>[{$packet->getTrackcode()}]</b>
                                        </div>

                                        <div class="pack-col pack-col-5">

                                            [{if $packet->getInfo()}]
                                                <a href="#" class="label_action label_warn" onclick="toggleElement('packet-info-[{$packet->getGroupId()}]'); return false;"></a>
                                            [{/if}]
                                            [{if $packet->getErr()}]
                                                <a href="#" class="label_action label_err" onclick="toggleElement('packet-err-[{$packet->getGroupId()}]'); return false;"></a>
                                            [{/if}]

                                            [{assign var="label_muted" value=""}]
                                            [{if $packet->isCancelFailed()}]
                                                [{assign var="label_muted" value="label_muted"}]
                                            [{/if}]

                                            [{if $packet->getNumber()}]

                                                <a target="_blank" class="label_action label_print [{$label_muted}]" href="[{$downloadlabelURL}]&labelid=[{$packet->getGroupId()}]"></a>
                                                [{if $edit->needExportDocuments()}]
                                                <a target="_blank" class="label_action labeldoc_print [{$label_muted}]" href="[{$downloadDocURL}]&labelid=[{$packet->getGroupId()}]"></a>
                                                [{/if}]

                                                [{if $packet->getTrackingUrl()}]
                                                <a target="_blank" class="label_action label_track [{$label_muted}]" href="[{$packet->getTrackingUrl()}]"></a>
                                                [{/if}]

                                                [{if $packet->isCancelFailed()}]
                                                    <a href="#" class="label_action label_clear" onclick="toggleElement('packet-err-actions-[{$packet->getGroupId()}]'); return false;"></a>
                                                    <ul class="packet_actions" id="packet-err-actions-[{$packet->getGroupId()}]" onmouseout="toggleElement('packet-err-actions-[{$packet->getGroupId()}]')">
                                                        <li><a href="#" onclick="deleteLabel('[{$packet->getService()}]', '[{$packet->getGroupId()}]'); return false;">Cancel again</a></li>
                                                        <li><a href="#" onclick="deleteLabel('[{$packet->getService()}]', '[{$packet->getGroupId()}]', true); return false;">Clear label</a></li>
                                                        [{if $packet->isCanCancelPerEmail()}]
                                                        <li><a href="#" onclick="deleteLabel('', '[{$packet->getGroupId()}]', true, true); return false;">Send cancel-email and clear label</a></li>
                                                        [{/if}]
                                                    </ul>
                                                [{else}]
                                                    <a href="#" class="label_action label_cancel" onclick="deleteLabel('[{$packet->getService()}]', '[{$packet->getGroupId()}]'); return false;"></a>
                                                [{/if}]

                                            [{else}]

                                                [{if $packet->isCanceled()}]
                                                    <a href="#" class="label_action label_renew" onclick="labelRenew('[{$packet->getGroupId()}]'); return false;"></a>
                                                [{else}]
                                                     <a href="#" class="label_action label_disable" onclick="disableLabel('[{$packet->getGroupId()}]'); return false;"></a></li>
                                                [{/if}]

                                            [{/if}]

                                        </div>
                                    </div>
                                    <br style="clear: both">
                                </div>
                            </div>
                        </div>

                        [{if $packet->getInfo()}]
                            <div class="packetInfo" id="packet-info-[{$packet->getGroupId()}]" style="margin-left: 2px; background: #fAfAfA; white-space: normal; display: none; padding: 5px; border-left-color: orange; border-left-width: 4px; margin-bottom: 5px;">
                                <a href="#" onclick="document.getElementById('packet-info-[{$packet->getGroupId()}]').style.display='none'; return false;" style="float: right;">x</a>
                                [{$packet->getLabelInfoHTML()}]
                            </div>
                        [{/if}]

                        [{if $packet->getErr()}]
                            <div class="packetInfo" id="packet-err-[{$packet->getGroupId()}]" style="margin-left: 2px; background: #fAfAfA; white-space: normal; display: none; padding: 5px; border-left-color: red; border-left-width: 4px; margin-bottom: 5px;">
                                <a href="#" onclick="document.getElementById('packet-err-[{$packet->getGroupId()}]').style.display='none'; return false;" style="float: right;">x</a>
                                [{$packet->getLabelErrHTML()}]
                            </div>
                        [{/if}]

                    [{/foreach}]
                    </div>

                    <!-- footer -->

                    [{if ($packets|@count > 1)}]

                        <div class="footer_buttons" style="border-top-width: 4px; margin: 10px 0 0 0;">
                            <b>Alle <span style="text-transform: uppercase;">[{$deltype}]</span> Etiketten:</b>&nbsp;
                            <a target="_blank" href="#" onclick="if (confirm('Alle Etiketten beauftragen / drucken? Dieser Vorgang kann mehrere Minuten dauern.')) openLinkAndReload('[{$downloadlabelURL}]&service=[{$deltype}]'); return false;" class="print">
                                <span style="font-weight: bold; color: #00A000;">&#x2713;</span> Beauftragen / Drucken
                            </a>
                            <a href="javascript:void(0);" onclick="return deleteLabel('[{$deltype}]', '');" class="storno">
                                 &#9940; Stornieren
                            </a>
                            <a href="javascript:void(0);" onclick="return labelRenew('', '[{$deltype}]');" class="renew">
                                 &#x27A5; Wiedereinstellen
                            </a>

                        </div>
                    [{/if}]
                </div>


            </div>
            [{/foreach}]

            [{if $delPackets|@count > 1}]
            <div class="footer_buttons" style="border: 1px solid #ccc; border-top-width: 4px; padding: 5px; margin: 10px 0 0 0; font-size: 14px;">
                <b>Alle Bestellung Etiketten:</b>&nbsp;
                <a href="#" onclick="if (confirm('Alle Etiketten beauftragen / drucken? Dieser Vorgang kann mehrere Minuten dauern.')) openLinkAndReload('[{$downloadlabelURL}]'); return false;" class="print">
                    <span style="font-weight: bold; color: #00A000;">&#x2713;</span> Beauftragen / Drucken
                </a>
                <a href="javascript:void(0);" onclick="return deleteLabel('', '');" class="storno">
                     &#9940; Stornieren
                </a>

            </div>
            [{/if}]
    </td>
</tr>