    <fieldset class="attrrow kaufbeistyle">
    [{foreach from=$attributes item=oFilterAttr key=sAttrID name=testAttr}]
        [{assign var="filterColEnabled" value=0}]
        [{assign var="filterColActive" value=0}]
        [{foreach from=$oFilterAttr->aValues item=oValue}]
            [{assign var="filterColEnabled" value=1}]
            [{ if $oValue->blSelected }]
                [{assign var="filterColActive" value=1}]
            [{/if}]
        [{/foreach}]
        [{if $filterColEnabled == 1}]
                <div class="box-filter attrcol [{$oFilterAttr->type}] [{$oFilterAttr->styles}][{if $oView->isDropdownCategory($oFilterAttr->title)}] dropdown[{/if}]" data-hideafter="[{$oView->getHideAfter($sAttrID)}]">
                    <div class="title-filter attrhead[{if $oView->isDropdownCategory($oFilterAttr->title)}] dropdown-toggle[{/if}]"[{if $oView->isDropdownCategory($oFilterAttr->title)}] data-toggle="dropdown"[{/if}]>
                        <label id="test_attrfilterTitle_[{$sAttrID}]_[{$smarty.foreach.testAttr.iteration}]">
                            [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                                [{assign var="aSettings" value=$oValue->settings}]
                                [{assign var="unit" value=$aSettings->unit}]
                            [{/foreach}]
                            [{ $oFilterAttr->title }][{if $unit}] ([{$unit}])[{/if}][{if $oView->isDropdownCategory($oFilterAttr->title)}] <i class="fa fa-angle-down"></i>[{/if}]
                        </label>
                [{if $filterColActive}]
                        <a title="[{ oxmultilang ident="Z_MULTIFILTER_RESET_FILTERS" }]" class="multifilter_reset_icon" data-ident="[{$sAttrID}]" href="#">
                        [{ oxmultilang ident="Z_MULTIFILTER_RESET" }]
                        </a>
                [{elseif $oFilterAttr->type=='searchterm'}]
                    [{assign var=noAjaxReset value=$oFilterAttr->infoval}]
                        <a href="[{$noAjaxReset}]" title="[{ oxmultilang ident="Z_MULTIFILTER_RESET_FILTERS" }]" class="multifilter_reset_icon">
                        [{ oxmultilang ident="Z_MULTIFILTER_RESET" }]
                        </a>
                [{/if}]
                    </div>
                    <div class="attrbody[{if $oView->isDropdownCategory($oFilterAttr->title)}] dropdown-menu[{/if}]">
                    [{if $oView->isDropdownCategory($oFilterAttr->title)}]<div class="dropdown-inner">[{/if}]
                [{*PRICE SLIDER----------------------------------------*}]
                [{if $oFilterAttr->type=='price_slider'}]
                    [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                        [{assign var="aSettings" value=$oValue->settings}]
                        [{assign var="pricemin" value=$aSettings->min}]
                        [{assign var="pricemax" value=$aSettings->max}]
                        [{assign var="priceminselected" value=$aSettings->minSelected}]
                        [{assign var="pricemaxselected" value=$aSettings->maxSelected}]
                        [{assign var="pricerange" value=$aSettings->range}]
                        [{assign var="disabled" value=$aSettings->disabled}]
                    [{/foreach}]
                    <div class="slider-range" data-values="[{$pricemin}]|[{$pricemax}]|[{$priceminselected}]|[{$pricemaxselected}]" data-disabled="[{$disabled}]">
                        <input class="mf_filter" class="slider_input"  type="hidden"  name="attrfilter[[{ $sAttrID }]][[{ $oValue->id }]]"  value="[{$pricerange}]">
                    </div>
                    <div class="slider-amount">
                        <div class="slidervalbox">
                            <input type="text" class="slidervalinput slidermin" onClick="this.select();" name="minpriceselected" value="[{$priceminselected}]"[{if $disabled}] disabled[{/if}]>
                        </div>
                        <div class="slidervalto">-</div>
                        <div class="slidervalbox">
                            <input type="text" class="slidervalinput slidermax" onClick="this.select();" name="maxpriceselected" value="[{$pricemaxselected}]"[{if $disabled}] disabled[{/if}]>
                        </div>
                        <div class="slidersubmit">
                            [{if !$disabled}]
                            <button type="button" class="slidersubmitbutton submitButton largeButton">[{ oxmultilang ident="Z_MULTIFILTER_SUBMIT" }]</button>
                            [{/if}]
                        </div>
                    </div>
                    [{oxscript add="$( '.slider-range' ).mfSlider();"}]

                [{*SEARCH----------------------------------------*}]
                [{elseif $oFilterAttr->type=='searchterm'}]
                    <p class="attrfilter" style="padding-left: 0px">
                        <span>
                                <b>[{ $oValue->value }]</b>
                        </span>
                    </p>

                [{*CATEGORIES----------------------------------------*}]
                [{elseif $oFilterAttr->type=='category'}]
                    [{assign var="blIsBreadcrumb" value=true}]
                    [{assign var="marginleft" value=0}]
                    [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                        [{if $blIsBreadcrumb}]
                            [{if $oValue->current && !$smarty.foreach.testInput.first}]
                                [{assign var="marginleft" value=$marginleft+10}]
                            [{/if}]
                    <p class="attrfilter" style="padding-left: [{$marginleft}]px">
                            [{if $oValue->current}]
                        <span class="category-link">
                            <i class="far fa-angle-right"></i>
                                <b>[{ $oValue->value }]</b>
                        </span>
                                [{assign var="marginleft" value=$marginleft+10}]
                                [{assign var="blIsBreadcrumb" value=false}]
                            [{else}]
                        <a class="category-link" href="[{ $oValue->infoval|oxaddparams:$oValue->keepfilter}]">
                            <i class="far fa-angle-right"></i>
                                [{ $oValue->value }]
                        </a>
                            [{/if}]
                            [{assign var="marginleft" value=$marginleft}]
                    </p>
                        [{else}]
                    <p class="attrfilter" style="padding-left: [{$marginleft}]px">
                            [{if $oValue->blDisabled}]
                        <span class="lgrey category-link" >
                                <i class="far fa-angle-right"></i>
                                [{ $oValue->value }][{ if $oView->showFilterArticleCount()}]&nbsp;([{ $oValue->count }])[{/if}]
                        </span>
                            [{else}]
                        <a class="category-link" href="[{ $oValue->infoval|oxaddparams:$oValue->keepfilter }]">
                            <i class="far fa-angle-right"></i>
                                [{ $oValue->value }][{ if $oView->showFilterArticleCount()}]&nbsp;([{ $oValue->count }])[{/if}]
                        </a>
                            [{/if}]
                    </p>
                        [{/if}]
                    [{/foreach}]

                [{*COLOR SWATCHES----------------------------------------*}]
                [{elseif $oView->isColorCategory($oFilterAttr->title)}]
                    [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                    <div class="colorpick[{ if $oValue->blSelected }] active[{/if}][{ if !$oValue->blDisabled }] colorpickerjs[{else}] disabled[{/if}]" title="[{ $oValue->value }][{ if $oValue->blDisabled }]&nbsp;([{ oxmultilang ident='Z_MULTIFILTER_NOT_AVAILBALE' }])[{ elseif $oView->showFilterArticleCount()}]&nbsp;([{ $oValue->count }])[{/if}]">
                        <div style="background-color: [{ $oView->getSwatchBg($oValue->value)}]" class="colorpick_picker[{ if $oValue->blDisabled }] disabled[{/if}][{ if $oValue->blSelected }] active[{/if}]"></div>
                        <input class="mf_filter" id="[{ $oValue->id }]"  type="hidden"  name="attrfilter[[{ $sAttrID }]][[{ $oValue->id }]]"  value="[{ if $oValue->blSelected }]1[{/if}]">
                    </div>
                        [{ if $oValue->blSelected }][{assign var=showreset value=true}][{/if}]
                    [{/foreach}]

                [{*DROPDOWNS----------------------------------------*}]
                [{*DWA über Bootstrap dropdown gelöst*}]
                [{*elseif $oView->isDropdownCategory($oFilterAttr->title)}]
                    [{oxscript add="$('div.dropDown p').oxDropDown();" }]

                    [{assign var=selectedvalue value=''}]
                    [{assign var=selectedid value=''}]
                    [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                        [{ if $oValue->blSelected }]
                            [{assign var=showreset value=true}]
                            [{assign var=selectedvalue value=$oValue->value}]
                            [{assign var=selectedid value=$oValue->id}]
                        [{/if}]
                    [{/foreach}]


                <div class="selectorsBox">
                <div class="dropDown js-fnSubmit">
                    <p class="selectorLabel underlined">
                        [{if $selectedvalue}]
                            <span>[{$selectedvalue}]</span>
                        [{elseif !$blHideDefault}]
                            <span>
                                [{ oxmultilang ident="PLEASE_CHOOSE" }]
                            </span>
                        [{/if}]
                    </p>
                    [{if $editable !== false}]
                        <input class="mf_filter" type="hidden" name="attrfilter_single[[{ $sAttrID }]]" value="[{$selectedid}]">
                        <ul class="drop vardrop FXgradGreyLight shadow">
                            [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                                <li class="[{if $oValue->blDisabled}]js-disabled disabled[{/if}]">
                                    <a data-selection-id="[{ $oValue->id }]" class="[{if $oValue->blSelected}]selected[{/if}]">[{ $oValue->value }]</a>
                                </li>
                            [{/foreach}]
                        </ul>
                    [{/if}]
                </div>
                </div>
                *}]
                [{*CHECKBOXES----------------------------------------*}]
                [{else}]
                    [{foreach from=$oFilterAttr->aValues item=oValue name=testInput}]
                    <p class="attrfilter[{ if $oValue->blSelected }] active[{/if}]">
                        <input class="mf_filter" id="attrfilter_[{ $sAttrID }]_[{ $oValue->id }]" [{if $oValue->blDisabled}]disabled="disabled"[{/if}] type="checkbox" [{if !$oView->isDropdownCategory($oFilterAttr->title)}]onclick="$('#filterList').submit();"[{/if}] name="attrfilter[[{ $sAttrID }]][[{ $oValue->id }]]"  value="1" [{ if $oValue->blSelected }]checked[{/if}]>
                        <label for="attrfilter_[{ $sAttrID }]_[{ $oValue->id }]">
                            <span id="attrtitle_[{ $sAttrID }]_[{ $oValue->id }]" class="[{if $oValue->blDisabled}] lgrey[{/if}] [{ if $oValue->blSelected }]checked[{/if}]">
                                [{ $oValue->value }][{ if $oView->showFilterArticleCount()}] ([{ $oValue->count }])[{/if}]
                            </span>
                        </label>
                    </p>
                        [{ if $oValue->blSelected }][{assign var=showreset value=true}][{/if}]
                    [{/foreach}]
                [{/if}]
                [{if $oView->isDropdownCategory($oFilterAttr->title)}]</div>[{/if}]
                <div class="mfshowmore">[{ oxmultilang ident="Z_MULTIFILTER_MORE" }]</div>
                <div class="mfshowless">[{ oxmultilang ident="Z_MULTIFILTER_LESS" }]</div>
                    [{if $oView->isDropdownCategory($oFilterAttr->title)}]<p class="btn btn-primary btn-block" onclick="$('#filterList').submit();">filtern</p>[{/if}]
                [{oxscript add="$( '.attrcol' ).attrCol();"}]
                    </div>
                </div>
        [{/if}]
        [{if $oView->getDisplayTop() && $smarty.foreach.testAttr.iteration%4==0}]
    </fieldset>
    <fieldset class="attrrow kaufbeistyle">
        [{/if}]
    [{/foreach}]
    </fieldset>

