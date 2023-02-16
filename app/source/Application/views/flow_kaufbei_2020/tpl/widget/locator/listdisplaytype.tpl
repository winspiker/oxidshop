[{assign var="listType" value=$oView->getListDisplayType()}]
[{assign var="_additionalParams" value=$oView->getAdditionalParams()}]
[{assign var="_artPerPage" value=$oViewConf->getArtPerPageCount()}]

[{if $oView->canSelectDisplayType()}]

    <div class="sorting--views">


        [{if $oView->getListDisplayType() == "line"}]

        <a href="[{$oView->getLink()|oxaddparams:"ldtype=grid&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'grid'}]class="selected" [{/if}]>

        <span class="kiconk-icon-grid hasTooltip" data-placement="bottom" title="[{oxmultilang ident="LIST_DISPLAY_TYPE"}]: [{oxmultilang ident="grid"}]"></span></a>

        [{else}]

            <span class="kiconk-icon-grid hasTooltip selected" data-placement="bottom" title="[{oxmultilang ident="LIST_DISPLAY_TYPE"}]: [{oxmultilang ident="grid"}]"></span>

        [{/if}]

        
        [{if $oView->getListDisplayType() == "grid"}]

        <a href="[{$oView->getLink()|oxaddparams:"ldtype=line&amp;_artperpage=$_artPerPage&amp;pgNr=0&amp;$_additionalParams"}]" [{if $listType eq 'line'}]class="selected" [{/if}]>

        <span class="kiconk-icon-list hasTooltip" data-placement="bottom" title="[{oxmultilang ident="LIST_DISPLAY_TYPE"}]: [{oxmultilang ident="line"}]"></span></a>

        [{else}]
    
        <span class="kiconk-icon-list hasTooltip selected last-sort" data-placement="bottom" title="[{oxmultilang ident="LIST_DISPLAY_TYPE"}]: [{oxmultilang ident="line"}]"></span>

        [{/if}]

    </div>

[{/if}]