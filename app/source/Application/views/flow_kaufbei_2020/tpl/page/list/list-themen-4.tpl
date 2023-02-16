
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
	<section class="startpage-container section-slider-cat">
		<div class="line line-slider-cat"> 
            [{ oxcontent ident=main_banner_themen_4 }]                 
		</div>
	</section>
    <section class="top-themes-cat">
    	<div class="list-top-themes-cat">
            [{ oxcontent ident=top_banners_themen_4 }]    
    	</div>
    </section>
    [{block name="page_list_listhead"}]
    <div class="category--head-sorting">
        <div class="page-header">
            [{assign var='rsslinks' value=$oView->getRssLinks()}]
            <h1>
                [{$oView->getTitle()}]
                [{if $rsslinks.activeCategory}]
                <a class="rss" id="rssActiveCategory" href="[{$rsslinks.activeCategory.link}]" title="[{$rsslinks.activeCategory.title}]" target="_blank">
                    <i class="fa fa-rss"></i>
                </a>
                [{/if}]
            </h1>
        </div>
        <div class="listRefine">
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true itemsPerPage=true sort=true}]
        </div>
    </div>
        [{assign var="oPageNavigation" value=$oView->getPageNavigation()}]
        [{if $oView->hasVisibleSubCats()}]
            [{assign var="iSubCategoriesCount" value=0}]
            [{if false}]
            <div class="subcatList">
                <div class="row">
                <div class="sly-wrapper">
                    <div class="controls">
                        <span class="kiconk-icon-arrow-round-left prevPage"></span>
                        <span class="kiconk-icon-arrow-round-right nextPage"></span>
                    </div>
                  <div class="frame sly-carousel owl-theme">
                    <ul class="clearfix">
                    [{foreach from=$oView->getSubCatList() item=category name=MoreSubCat}]
                        [{if $category->getContentCats()}]
                            [{foreach from=$category->getContentCats() item=ocont name=MoreCms}]
                                [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                                <div class="box">
                                    <h3>
                                        <a id="moreSubCms_[{$smarty.foreach.MoreSubCat.iteration}]_[{$smarty.foreach.MoreCms.iteration}]" href="[{$ocont->getLink()}]">[{$ocont->oxcontents__oxtitle->value}]</a>
                                    </h3>
                                    <ul class="content"></ul>
                                </div>
                            [{/foreach}]
                        [{/if}]
                        [{if $category->getIsVisible()}]
                            [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                            [{assign var="iconUrl" value=$category->getIconUrl()}]
                        <li>
                            <a href="[{$category->getLink()}]" class="category--type productData">
                                <div class="category-type--cat block-shadow">
                                    <div class="panel-body">
                                        [{if $iconUrl}]
                                            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$category->getIconUrl()}]" alt="[{$category->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
                                        [{else}]
                                            <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                                        [{/if}]
                                        
                                    </div>
                                    <div class="category-type--head">
                                        <span class="category-type--head-title">[{$category->oxcategories__oxtitle->value}]</span>
                                        <span class="category-type--head-count">[{if $oView->showCategoryArticlesCount() && ($category->getNrOfArticles() > 0)}] [{$category->getNrOfArticles()}] [{/if}] [{oxmultilang ident="DD_ARTICLE"}]
                                        </span>
                                    </div>
                                </div>
                            </a>
                        [{/if}]
                    </li>
                    [{/foreach}]
                </ul>
            </div>
        </div>
    </div>
</div>
    [{/if}]
<section class="subCat">
    <div class="subcatList">
        [{foreach from=$oView->getSubCatList() item=category name=MoreSubCat}]
            [{if $category->getIsVisible()}]
                [{assign var="iSubCategoriesCount" value=$iSubCategoriesCount+1}]
                [{assign var="iconUrl" value=$category->getIconUrl()}]
                <div class="item-cat">

                    [{if $iconUrl}]
                        <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$category->getIconUrl()}]" alt="[{$category->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
                    [{else}]
                        <div class="box-btn">
                            <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                        </div>
                        
                    [{/if}]

                    <div class="box-description">
                        <a href="[{$category->getLink()}]" class="title">[{$category->oxcategories__oxtitle->value}]</a>
                        <div class="description">[{if $oView->showCategoryArticlesCount() && ($category->getNrOfArticles() > 0)}] [{$category->getNrOfArticles()}] [{/if}] [{oxmultilang ident="DD_ARTICLE"}]</div>
                    </div>
                </div>
            [{/if}]
        [{/foreach}]
    </div>
</section>    
    [{/if}]
[{/block}]


[{block name="page_list_listbody"}]
    [{if $oView->getArticleList()|@count > 0}]
            [{* List types: grid|line|infogrid *}]
            [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="productList" products=$oView->getArticleList()}]
            [{include file="widget/locator/listlocator.tpl" locator=$oView->getPageNavigationLimitedBottom() place="bottom"}]
    [{/if}]
[{/block}]
   <section class="top-themes-cat">
    	<div class="list-top-themes-cat">
            [{ oxcontent ident=bottom_banners_themen_4 }]  
    	</div>
    </section>
        [{if $actCategory->oxcategories__oxlongdesc->value && $oPageNavigation->actPage == 1}]
            <div id="catLongDescLocator" class="categoryDescription">[{oxeval var=$actCategory->oxcategories__oxlongdesc}]</div>
        [{/if}]
[{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl" tree_path=$oView->getTreePath()}]