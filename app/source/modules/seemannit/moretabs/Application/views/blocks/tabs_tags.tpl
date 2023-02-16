[{$smarty.block.parent}]

[{foreach from=$oDetailsProduct->getPossibeTabNums() item=num}]
    [{if strlen($oDetailsProduct->getTabTitle($num)) > 0 && $oDetailsProduct->getTabPos($num) == "tags"}]
        [{capture append="tabs"}]<a href="#ms_tab[{$num}]" data-toggle="tab">[{$oDetailsProduct->getTabTitle($num)}]</a>[{/capture}]
        [{capture append="tabsContent"}]
            <div id="ms_tab[{$num}]" class="tab-pane">
                [{$oDetailsProduct->getTabDesc($num, true)}]
            </div>
        [{/capture}]

        [{* only needed for ROXID *}]
        [{capture append="panels"}]<a href="#collapse_ms_tab[{$num}]" class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#product-panels" aria-expanded="false">[{$oDetailsProduct->getTabTitle($num)}]</a>[{/capture}]
        [{capture append="panelsContent"}]
            <div id="collapse_ms_tab[{$num}]" class="panel-collapse collapse">
                <div class="panel-body">
                    [{$oDetailsProduct->getTabDesc($num, true)}]
                </div>
            </div>
        [{/capture}]
    [{/if}]
[{/foreach}]
