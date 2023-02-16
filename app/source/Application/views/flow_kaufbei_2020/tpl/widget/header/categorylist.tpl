[{block name="dd_widget_header_categorylist"}]
[{assign var="topCategories" value=$topCategories}]
<div id="nav-row">
    <div class="container">
        <nav class="nav-row--category-list">
            <ul>
                <li>
                    <button type="button" class="all-categories--toggle">
                        <i class="far fa-bars"></i><span> [{oxmultilang ident="ALL_CATEGORIES"}]</span></button>
                </li>
                [{foreach from=$topCategories item="ocat" key="catkey" name="root"}]
                <li>
                    <a href="[{$ocat->getLink()}]">[{$ocat->getTitle()}]</a>
                </li>
                [{/foreach}]
            </ul>
        </nav>
    </div>
</div>


    [{if $oxcmp_categories}]
        [{assign var="homeSelected" value="false"}]
        [{if $oViewConf->getTopActionClassName() == 'start'}]
            [{assign var="homeSelected" value="true"}]
        [{/if}]
        [{assign var="oxcmp_categories" value=$oxcmp_categories}]
        [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
        <div id="all-categories--nav-row">

            <div class="all-categories--nav-row--inner">
                <button type="button" class="all-categories--nav-row--close" title="Close">
                    <i class="far fa-times"></i>
                </button>
                <div class="box-logo">
                    [{assign var="blHolidaySelect" value=$oViewConf->getViewThemeParam('blHolidaySelect')}]
                    <a class="logo" href="[{$oViewConf->getHomeLink()}]" title="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                        <img src="[{$oViewConf->getImageUrl()}][{if $blHolidaySelect == 'blackfriday'}]logo-blackfriday.svg[{else}]logo.svg?2[{/if}]" alt="[{$oxcmp_shop->oxshops__oxtitleprefix->value}]">
                    </a>
                </div>
                <nav class="nav-row--category-list">
                    <ul class="nav-row--category-priority">
                        [{block name="dd_widget_header_categorylist_navbar_list"}]
                        [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]
                            [{if $ocat->getIsVisible()}]
                                [{if $ocat->oxcategories__oxsort->value <= 10}]
                                <li [{if $homeSelected == 'false' && $ocat->expanded}]class="active"[{/if}]>
                                    <a data-child="[{$ocat->oxcategories__oxid->value}]" href="[{$ocat->getLink()}]" [{if $ocat->getSubCats()}] class="hasSubcats"[{/if}]>
                                        <span>[{$ocat->oxcategories__oxtitle->value}]</span>[{if $ocat->getSubCats()}] <i class="far fa-chevron-right"></i>[{/if}]
                                    </a>
                                </li>
                                [{/if}]
                            [{/if}]
                        [{/foreach}]
                        [{/block}]

                    </ul>
                    <ul>
                        [{block name="dd_widget_header_categorylist_navbar_list"}]
                        [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]
                            [{if $ocat->getIsVisible()}]
                                [{if $ocat->oxcategories__oxsort->value > 10}]
                                <li [{if $homeSelected == 'false' && $ocat->expanded}]class="active"[{/if}]>
                                    <a data-child="[{$ocat->oxcategories__oxid->value}]" href="[{$ocat->getLink()}]" [{if $ocat->getSubCats()}] class="hasSubcats"[{/if}]>
                                        <span>[{$ocat->oxcategories__oxtitle->value}]</span>[{if $ocat->getSubCats()}] <i class="far fa-chevron-right"></i>[{/if}]
                                    </a>
                                </li>
                                [{/if}]
                            [{/if}]
                        [{/foreach}]
                        [{/block}]
                    </ul>
                </nav>
            </div>
        </div>


                    [{block name="dd_widget_header_categorylist_navbar_list"}]
                    [{foreach from=$oxcmp_categories item="ocat" key="catkey" name="root"}]
                    [{if $ocat->getIsVisible()}]

                        [{if $ocat->getSubCats() && $ocat->getSubCats()|@count > 0}]

                            <div data-count="[{$ocat->getSubCats()|@count}]" id="child_[{$ocat->oxcategories__oxid->value}]">
                                <button type="button" class="all-categories--child--back" title="Back">
                                    <i class="far fa-chevron-left"></i> <span>Zurück</span>
                                </button>
                                <button type="button" class="all-categories--child--close" title="Close">
                                    <i class="far fa-times"></i>
                                </button>

                                <ul>
                                        <li class="parent_category">
                                            <a href="[{$ocat->getLink()}]">[{$ocat->getTitle()}] <span>[{ oxmultilang ident="MORE" }]</span></a>
                                        </li>
                                        [{foreach from=$ocat->getSubCats() item="osubcat" key="subcatkey" name="SubCat"}]
                                        [{if $osubcat->getIsVisible()}]

                                        <li>
                                            <a [{if $homeSelected == 'false' && $osubcat->expanded}]class="current"[{/if}] href="[{$osubcat->getLink()}]">
                                                [{if false}]
                                                <div class="imageWrapper"><img src="[{$osubcat->getIconUrl()}]" alt="[{$osubcat->oxcategories__oxtitle->value}]"></div>
                                                [{/if}]

                                                [{$osubcat->oxcategories__oxtitle->value}]</a>

                                            [{if $osubcat->getSubCats()}]
                                            <ul class="sub-cats-third">
                                                [{foreach from=$osubcat->getSubCats() item="osubcatSec" key="subcatkeySec" name="SubCatSec"}]
                                                [{if $osubcatSec->getIsVisible()}]
                                                <li class="[{if $homeSelected == 'false' && $osubcatSec->expanded}] active[{/if}]">
                                                    <a [{if $homeSelected == 'false' && $osubcatSec->expanded}]class="current"[{/if}] [{if $osubcatSec->getSubCats()}] class="hasSubcats"[{/if}] href="[{$osubcatSec->getLink()}]">
                                                        [{$osubcatSec->oxcategories__oxtitle->value}]
                                                    </a>
                                                </li>
                                                [{/if}]
                                                [{/foreach}]
                                            </ul>
                                            [{/if}]

                                        </li>

                                        [{/if}]
                                        [{/foreach}]
                                </ul>

                            </div>
                        [{/if}]

                    [{/if}]
                    [{/foreach}]
                    [{/block}]



[{/if}]
[{/block}]

