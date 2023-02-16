
[{assign var="actCategory" value=$oView->getActiveCategory()}]

[{capture append="oxidBlock_sidebar"}]
    [{assign var="listType" value=$oView->getListType()}]
    [{if $listType=='manufacturer' || $listType=='vendor'}]
        [{if $actCategory && $actCategory->getIconUrl()}]
        <div class="box">
            <h3>
                [{if $listType=='manufacturer'}]
                    [{oxmultilang ident="BRAND"}]
                [{elseif $listType=='vendor'}]
                    [{oxmultilang ident="VENDOR"}]
                [{/if}]
            </h3>
            <div class="featured icon">
                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$actCategory->getIconUrl()}]" alt="[{$actCategory->getTitle()}]">
            </div>
        </div>
        [{/if}]
    [{/if}]
[{/capture}]
[{capture append="oxidBlock_content"}]

    [{block name="page_list_listhead"}]



    [{assign var='rsslinks' value=$oView->getRssLinks()}]
    [{assign var="parts" value="/"|explode:$rsslinks.activeCategory.link}]
    [{foreach from=$parts item=item}]
        [{if $item != ''}]
            [{assign var='lastPath' value=$item}]
        [{/if}]
    [{/foreach}]

    [{assign var="lastPath" value=$lastPath|replace:'-':''}]


    [{if !$lastPath && $listType=='manufacturer'}]
        [{assign var="lastPath" value=$oView->getTitle()|replace:'&':' '|replace:'amp;':' '|replace:' ':''}]
        [{assign var="lastPath" value=$lastPath|replace:'-':''}]
    [{/if}]
    <div data-lastpath="[{$lastPath|cat:'Banner'|truncate:32:''}]"></div>
    [{oxifcontent ident=$lastPath|cat:'Banner'|truncate:32:''}]
    <section class="startpage-container section-slider-cat">
        <div class="line line-slider-cat">
            [{oxcontent ident=$lastPath|cat:'Banner'|truncate:32:''}]
        </div>
    </section>
    [{/oxifcontent}]
    [{if $oView->getClassName()  == "alist" }]

    [{if !$actCategory->oxcategories__oxtemplate->rawValue}]
    <button type="button" class="toggle-box-sort-in-cat">Filtern & Sortieren</button>
    [{/if}]
    [{/if}]
    <div class="category--head-sorting">
        <div class="page-header">

            <h1>
                [{$oView->getTitle()}]
                [{if $rsslinks.activeCategory}]
                <a class="rss" id="rssActiveCategory" href="[{$rsslinks.activeCategory.link}]" title="[{$rsslinks.activeCategory.title}]" target="_blank">
                    <i class="fa fa-rss"></i>
                </a>
                [{/if}]
            </h1>

        </div>
        [{if $listType=='manufacturer' && $lastPath != 'NachHersteller' && $lastPath != 'Попроизводителю'}]
        <div class="manufacturer-header">
            <div class="manufacturer-logo"><img src="[{$actCategory->getIconUrl()}]" alt="[{$oView->getTitle()}]"></div>
            <p>[{$oView->getMetaDescription()}]</p>
        </div>
        [{/if}]
        <div class="listRefine">
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true itemsPerPage=true sort=true}]
        </div>
    </div>
        [{assign var="oPageNavigation" value=$oView->getPageNavigation()}]
        [{if $listType=='manufacturer' || $listType=='vendor'}]
            [{if $oView->hasVisibleSubCats()}]
                [{assign var="iSubCategoriesCount" value=0}]

                <section class="subCat">
                    <div class="subcatList">
                        [{foreach from=$oView->getSubCatList() item=category name=MoreSubCat}]
                            [{if $category->getIsVisible()}]
                                [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                                [{assign var="iconUrl" value=$category->getIconUrl()}]
                                <div class="item-cat">

                                    [{if $iconUrl}]
                                        <div class="item-cat-image-wrapper img-loader">
                                            <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                                <rect class="cls-1" width="364" height="364"/>
                                            </svg>
                                            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$category->getIconUrl()}]" alt="[{$category->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
                                        </div>
                                    [{else}]
                                        <div class="box-btn">
                                            <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                                        </div>

                                    [{/if}]

                                    <div class="box-description">
                                        <a href="[{$category->getLink()}]" class="title">[{$category->oxcategories__oxtitle->value}]</a>
                                        <div class="description">[{if $oView->showCategoryArticlesCount() && ($category->getNrOfArticles() > 0)}] [{$category->getNrOfArticles()}]  [{oxmultilang ident="DD_ARTICLE"}][{/if}]</div>
                                    </div>
                                </div>
                            [{/if}]
                        [{/foreach}]
                    </div>
                </section>
            [{/if}]
        [{/if}]
[{/block}]
[{block name="page_list_listbody"}]
    [{if $oView->getArticleList()|@count > 0}]
            [{* List types: grid|line|infogrid *}]
            [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="productList" products=$oView->getArticleList()}]
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedBottom() place="bottom"}]
    [{/if}]
[{/block}]
        [{if $actCategory->oxcategories__oxlongdesc->value && $oPageNavigation->actPage == 1}]
            <div id="catLongDescLocator" class="categoryDescription">[{oxeval var=$actCategory->oxcategories__oxlongdesc}]</div>
        [{/if}]
[{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl" tree_path=$oView->getTreePath()}]