
<div class="row">
    <div id="manufacturerSlider" class="boxwrapper fadeIn">
        <div class="page-header">
            <h3>[{oxmultilang ident="OUR_BRANDS"}]</h3>
            <span class="subhead">[{oxmultilang ident="MANUFACTURERSLIDER_SUBHEAD"}]</span>
        </div>

        <div class="flexslider">
            <ul class="slides">
                [{foreach from=$oView->getManufacturerForSlider() item=oManufacturer}]
                    [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                        <li>
                            <a href="[{$oManufacturer->getLink()}]" title="[{oxmultilang ident="VIEW_ALL_PRODUCTS"}]">
                                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oManufacturer->getIconUrl()}]" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                            </a>
                        </li>
                    [{/if}]
                [{/foreach}]
            </ul>
        </div>
    </div>
</div>