[{capture append="oxidBlock_content"}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]
    [{assign var='rsslinks' value=$oView->getRssLinks()}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
    [{oxscript include="js/pages/start.min.js"}]

    [{block name="start_welcome_text"}]
        [{oxifcontent ident="oxstartwelcome" object="oCont"}]
            <div class="welcome-teaser">[{$oCont->oxcontents__oxcontent->value}]</div>
        [{/oxifcontent}]
    [{/block}]


    [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
    [{assign var="oTopArticles" value=$oView->getTop5ArticleList()}]
    

    [{if false}]
    <div class="boxwrapper subcatList[{if $smarty.get.dev == true }] fadeIn[{/if}]">

    <div class="page-header">
        <span>[{oxmultilang ident="DD_TOP_ARTICLES"}]</span>
    </div>
[{if $smarty.get.dev == true}]
    <div class="sly-wrapper">

                    <div class="controls">
                        <span class="kiconk-icon-arrow-round-left prevPage"></span>
                        <span class="kiconk-icon-arrow-round-right nextPage"></span>
                    </div>
				
                  <div class="frame sly-carousel check-size-topcat">
                    <ul class="clearfix top-category-box">
        [{foreach from=$oView->getStartCategories() item=oStartCategory}]
     
                [{assign var="iconUrl" value=$oStartCategory->getIconUrl()}]
				[{assign var="promoIconUrl" value=$oStartCategory->getPromotionIconUrl()}]

                        <li class="top-category-box--item">
                            <a href="[{$oStartCategory->getLink()}]" class="category--type productData">
                                <div class="category-type--cat block-shadow">
                                    
                                    <div class="panel-body">
                                        [{if $promoIconUrl || $iconUrl}]
                                                <div class="item-cat-image-wrapper img-loader" style="opacity: 0;">
                                                    <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                                        <rect class="cls-1" width="364" height="364"/>
                                                    </svg>
                                                    [{if $promoIconUrl}]
                                                    <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$promoIconUrl}]" alt="[{$oStartCategory->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
                                                        [{else}]
                                                    <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$iconUrl}]" alt="[{$oStartCategory->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
                                                    [{/if}]
                                                </div>

                                        
                                        [{else}]
                                            <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                                        [{/if}]

                                        [{if $oStartCategory->getHasVisibleSubCats()}]
                                        
                                            <ul class="list-unstyled">
                                                [{foreach from=$oStartCategory->getSubCats() item=subcategory}]
                                                    [{if $subcategory->getIsVisible()}]
                                                        [{foreach from=$subcategory->getContentCats() item=ocont name=MoreCms}]
                                                            <li>
                                                                <span><strong>[{$ocont->oxcontents__oxtitle->value}]</strong></span>
                                                            </li>
                                                        [{/foreach}]
                                                        <li>
                                                            <span[{$subcategory->oxcategories__oxtitle->value}]</span>[{if $oView->showCategoryArticlesCount() && ($subcategory->getNrOfArticles() > 0)}]&nbsp;([{$subcategory->getNrOfArticles()}])[{/if}]
                                                        </li>
                                                    [{/if}]
                                                [{/foreach}]
                                            </ul>
                                        [{/if}]
                                    </div>

                                    <div class="category-type--head">
                                        <span class="category-type--head-title">[{$oStartCategory->oxcategories__oxtitle->value}]</span>
                                        <span class="category-type--head-count">[{if $oView->showCategoryArticlesCount() && ($oStartCategory->getNrOfArticles() > 0)}] [{$oStartCategory->getNrOfArticles()}] [{/if}] [{oxmultilang ident="DD_ARTICLE"}]
                                        </span>
                                    </div>
                                </div>
                            </a>
    

                    </li>
        [{/foreach}]



                </ul>
            </div>
            	<div class="scrollbar">
                <div class="handle">
                  <div class="mousearea"></div>
                </div>
              </div>
        </div>
		[{else}]
		<div class="sly-wrapper">

                    <div class="controls">
                        <span class="kiconk-icon-arrow-round-left prevPage"></span>
                        <span class="kiconk-icon-arrow-round-right nextPage"></span>
                    </div>
				
                  <div class="frame">
                    <div class="clearfix owl-carousel owl-top-cats owl-theme top-category-box">
                [{foreach from=$oView->getStartCategories() item=oStartCategory}]
     
                [{assign var="iconUrl" value=$oStartCategory->getIconUrl()}]
				[{assign var="promoIconUrl" value=$oStartCategory->getPromotionIconUrl()}]
						<div class="item">
                        <div class="top-category-box--item">
                            <a href="[{$oStartCategory->getLink()}]" class="category--type productData">
                                <div class="category-type--cat block-shadow">
                                    
                                    <div class="panel-body">
                                        [{if $promoIconUrl || $iconUrl}]
                          						[{if $promoIconUrl}]
										
                                                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$promoIconUrl}]" alt="[{$oStartCategory->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
												[{else}]
												<img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$iconUrl}]" alt="[{$oStartCategory->oxcategories__oxtitle->value}]" class="img-responsive subcat-icon">
												[{/if}]
                                        
                                        [{else}]
                                            <span class="btn btn-block btn-info">[{oxmultilang ident="DD_LIST_SHOW_MORE"}]</span>
                                        [{/if}]

                                        [{if $oStartCategory->getHasVisibleSubCats()}]
                                        
                                            <ul class="list-unstyled">
                                                [{foreach from=$oStartCategory->getSubCats() item=subcategory}]
                                                    [{if $subcategory->getIsVisible()}]
                                                        [{foreach from=$subcategory->getContentCats() item=ocont name=MoreCms}]
                                                            <li>
                                                                <span><strong>[{$ocont->oxcontents__oxtitle->value}]</strong></span>
                                                            </li>
                                                        [{/foreach}]
                                                        <li>
                                                            <span[{$subcategory->oxcategories__oxtitle->value}]</span>[{if $oView->showCategoryArticlesCount() && ($subcategory->getNrOfArticles() > 0)}]&nbsp;([{$subcategory->getNrOfArticles()}])[{/if}]
                                                        </li>
                                                    [{/if}]
                                                [{/foreach}]
                                            </ul>
                                        [{/if}]
                                    </div>

                                    <div class="category-type--head">
                                        <span class="category-type--head-title">[{$oStartCategory->oxcategories__oxtitle->value}]</span>
                                        <span class="category-type--head-count">[{if $oView->showCategoryArticlesCount() && ($oStartCategory->getNrOfArticles() > 0)}] [{$oStartCategory->getNrOfArticles()}] [{/if}] [{oxmultilang ident="DD_ARTICLE"}]
                                        </span>
                                    </div>
                                </div>
                            </a>
    

                    </div>
					</div>
                [{/foreach}]



                </div>
            </div>
            	<div class="scrollbar">
                <div class="handle">
                  <div class="mousearea"></div>
                </div>
              </div>
        </div>
		[{/if}]


    </div>	
    [{/if}]



    [{block name="start_bargain_articles"}]
        [{assign var="oBargainArticles" value=$oView->getBargainArticleList()}]
        [{if $oBargainArticles && $oBargainArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_BARGAIN_HEADER"|oxmultilangassign subhead="START_BARGAIN_SUBHEADER"|oxmultilangassign listId="bargainItems" products=$oBargainArticles rsslink=$rsslinks.bargainArticles rssId="rssBargainProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]

   

    [{block name="start_manufacturer_slider"}]
        [{if $oViewConf->getViewThemeParam('bl_showManufacturerSlider')}]
            [{include file="widget/manufacturersslider.tpl"}]
        [{/if}]
    [{/block}]

   
    [{block name="start_newest_articles"}]
        [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
        
        [{if $oNewestArticles && $oNewestArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_NEWEST_HEADER"|oxmultilangassign subhead="START_NEWEST_SUBHEADER"|oxmultilangassign listId="newItems" products=$oNewestArticles rsslink=$rsslinks.newestArticles rssId="rssNewestProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]

    [{if $oNewestArticles && $oNewestArticles->count() && $oTopArticles && $oTopArticles->count() && false}]
        <div class="row">
            [{if $blFullwidth}]
                <div class="col-xs-12"><hr></div>
            [{else}]
                <hr>
            [{/if}]
        </div>
    [{/if}]

    
    [{block name="start_top_articles"}]
        [{if $oTopArticles && $oTopArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_TOP_PRODUCTS_HEADER"|oxmultilangassign subhead="START_TOP_PRODUCTS_SUBHEADER"|oxmultilangassign:$oTopArticles->count() listId="topBox" products=$oTopArticles rsslink=$rsslinks.topArticles rssId="rssTopProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]

    [{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl"}]
