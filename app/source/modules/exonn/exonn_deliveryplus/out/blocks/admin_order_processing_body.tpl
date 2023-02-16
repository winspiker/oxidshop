[{assign var="statistik" value=$oView->getLabelsStatistick()}]

[{$smarty.block.parent}]
<input type="hidden" name="deliveryservice" value="">

<a href="javascript:void(0)" onclick="[{if (!$orderprocessingprint)}] if (!confirm('[{ oxmultilang ident="orderprocessing_CONFIRM_PRINT" }]')) return false;[{/if}] document.myexportform.oxdocumenttype.value='Lieferschein';document.getElementById('idfnc').value='packListePrint'; document.myexportform.submit();  " ><img  src="[{$oViewConf->getModuleUrl('exonn_order_processing', 'out/img/pdflogo.jpg')}]">  Packliste </a>
<br>
<br>
[{foreach from=$statistik.services key=service item=cou}]
    [{if $service}]
    <a href="javascript:void(0)" onclick="document.myexportform.deliveryservice.value='[{$service}]';document.getElementById('idfnc').value='exportlabels'; document.myexportform.submit();  " >
    <img  src="[{$oViewConf->getModuleUrl('exonn_order_processing', 'out/img/pdflogo.jpg')}]"> [{$service|upper}] Labels ([{$cou}])</a><br>

    [{if $statistik.docs[$service]}]
    <a href="javascript:void(0)" onclick="document.myexportform.deliveryservice.value='[{$service}]';document.getElementById('idfnc').value='printexportdocs'; document.myexportform.submit();  " >
    <img  src="[{$oViewConf->getModuleUrl('exonn_order_processing', 'out/img/pdflogo.jpg')}]"> [{$service|upper}] Export Dokumenten ([{$cou}])</a><br>
    [{/if}]
    [{/if}]
[{/foreach}]


<div>
    <div id="packlist" style="display: none;">
        <table>
            <tr><td>Order Nr</td><td>Label Nr</td><td>Customer</td><td>Article</td><td>Status</td></tr>
        [{assign var="statistik" value=$oView->getLabelsStatistick()}]
        [{foreach from=$statistik.labels item=labelInfo}]
            <tr>
                <td>[{$labelInfo.ordernr}]</td>
                <td>[{if $labelInfo.label.labelid}][{$labelInfo.label.labelid}][{else}]-[{/if}]</td>
                <td>[{$labelInfo.customer}]</td>
                <td>
                    [{foreach from=$labelInfo.label.articles item=art}]
                    [{assign var="article" value=$art.article}]
                    [{$article->oxarticles__oxtitle->value|cat:" "|cat:$art.amount|cat:" Stk"}]<br>
                    [{/foreach}]
                </td>
                <td>[{if $labelInfo.label.labelerr}]<label title="[{$labelInfo.label.labelerr}]">Err</label>[{else}]Ok[{/if}] </td>
            </tr>
        [{/foreach}]
        </table>
    </div>

</div>