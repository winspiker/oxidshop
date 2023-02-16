[{block name="widget_locator_attributes"}]

    [{if $attributes}]

        <div class="filter-attributes">
            <form method="get" action="[{$oViewConf->getSelfActionLink()}]" name="_filterlist" id="filterList">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                    <input type="hidden" name="tpl" value="[{$oViewConf->getActTplName()}]">
                    <input type="hidden" name="oxloadid" value="[{$oViewConf->getActContentLoadId()}]">
                    <input type="hidden" name="fnc" value="executefilter">
                    <input type="hidden" name="fname" value="">
                </div>

                <div class="box-filter">
                    [{if $oView->getClassName() == 'alist'}]
                    <div class="title-filter">
                        <p>[{oxmultilang ident="DD_LISTLOCATOR_FILTER_ATTRIBUTES"}]</p>
                        <button type="button" class="btn-hide-filter"><i class="far fa-chevron-down"></i></button>
                    </div>
                    [{/if}]
                    <div class="list-item-filter">
                        [{foreach from=$attributes item=oFilterAttr key=sAttrID name=attr}]
                        [{assign var="sActiveValue" value=$oFilterAttr->getActiveValue()}]
                        <div class="btn-group filter-attributes--item">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <strong>[{$oFilterAttr->getTitle()}]:</strong>
                                [{if $sActiveValue}]
                                [{$sActiveValue}]
                                [{else}]
                                [{oxmultilang ident="PLEASE_CHOOSE"}]
                                [{/if}]
                                <span class="caret"></span>
                            </button>
                            <input type="hidden" name="attrfilter[[{$sAttrID}]]" value="[{$sActiveValue}]">
                            <ul class="dropdown-menu" role="menu">
                                [{if $sActiveValue}]
                                <li><a data-selection-id="" href="#">[{oxmultilang ident="PLEASE_CHOOSE"}]</a></li>
                                [{/if}]
                                [{foreach from=$oFilterAttr->getValues() item=sValue}]
                                <li><a data-selection-id="[{$sValue}]" href="#" [{if $sActiveValue == $sValue}]class="selected"[{/if}] >[{$sValue}]</a></li>
                                [{/foreach}]
                            </ul>
                        </div>
                        [{/foreach}]
                    </div>
                </div>

            </form>
        </div>
    [{/if}]
[{/block}]