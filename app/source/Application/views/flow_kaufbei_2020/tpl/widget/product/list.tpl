[{if !$type}]
    [{assign var="type" value="grid"}]
[{/if}]
[{if !$iProductsPerLine}]
    [{assign var="iProductsPerLine" value=4}]
[{/if}]
[{if $type == 'infogrid'}]
    [{assign var="iProductsPerLine" value=2}]
[{elseif $type == 'grid' && $listId != 'bargainItems' && $listId != 'newItems' && $listId != 'topBox'}]
    [{assign var="iProductsPerLine" value=5}]
[{elseif $type == 'line'}]
    [{assign var="iProductsPerLine" value=1}]
[{/if}]
[{if $listId == 'noStockCrossPopUp'}]

    [{foreach from=$products item="_product" name="productlistnostock"}]
    [{if $smarty.foreach.productlistnostock.iteration == 1}]
    [{counter print=false assign="productlistCounter"}]
    [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]

        <div style="display: none;">
            <div id="noStockCrossPopUp">
                <div id="noStockCrossPopUp-title">[{oxmultilang ident="NO_STOCK_POP_UP_DESC"}]</div>
                <div id="noStockCrossPopUp-inner">
                    [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_stock iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
                </div>
            </div>
        </div>
        <style>
            #noStockCrossPopUp {
                align-items: center;
                justify-content: center;
                max-width: 600px;
                background: #fff;

            }



            #noStockCrossPopUp-inner {
                display: flex;
                position: relative;
            }


            #noStockCrossPopUp-title {
                font-size: 22px;
                margin-bottom: 10px;
            }

            #noStockCrossPopUp-inner .picture {
                min-width: 300px;
            }

            #noStockCrossPopUp-inner .listDetails {
                padding: 30px;
            }

            @media screen and (max-width:768px) {
                #noStockCrossPopUp-inner {
                    flex-direction: column;
                }


                #noStockCrossPopUp-inner .listDetails {
                    padding: 0;
                    padding-top: 30px;
                    padding-bottom: 20px;
                }

                #noStockCrossPopUp-title {
                    font-size: 18px;
                }
            }


            #noStockCrossPopUp-inner .picture.text-center img {
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                fill: #fff;
                height: 100%;
                object-fit: contain;
                image-rendering: -webkit-optimize-contrast;
            }

            #noStockCrossPopUp-inner .picture.text-center > a {
                display: block;
                position: relative;
            }


            #noStockCrossPopUp-inner .listDetails .noStockCrossPopUptitle {
                font-size: 18px;
                font-weight: 600;
                line-height: 1.3;
                display: block;
                margin-bottom: 10px;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                -o-text-overflow: ellipsis;
                text-overflow: ellipsis;
            }

            #noStockCrossPopUp-inner .listDetails .pricePerUnit {
                font-size: 14px;
                margin-bottom: 10px;
                display: block;
            }

            #noStockCrossPopUp-inner .listDetails  .text-art {
                display: inline-block;
                margin-top: 5px;
            }

            #noStockCrossPopUp-inner .listDetails .btn-primary {
                margin-top: 10px;
            }

            #noStockCrossPopUp-inner .prod_price_visiable {
                font-size: 50px;
                line-height: 50px;
                font-weight: bold;
                font-style: italic;
                color: #2e2e2e;
            }

            #noStockCrossPopUp-inner .prod_price_visiable  .sup-price {
                font-size: 24px;
                vertical-align: top;
                line-height: 29px;
                margin-left: 5px;
                text-decoration: underline;
            }




        </style>
    [{/if}]

    [{/foreach}]


    [{else}]

<section class="boxwrapper [{if ($listId == 'bargainItems' || $listId == 'newItems'  || $listId == 'topBox' || $listId == 'alsoBought' || $listId == 'cross' || $listId == 'similar' || $listId == 'alsoBoughtThankyou' || $listId == 'accessories') && $smarty.get.dev == true  }] fadeIn[{/if}]" id="boxwrapper_[{$listId}]">
    <div class="[{if $listId != 'productList' && $listId != 'searchList'}]swiper-container [{/if}]list-container grid--mobile[{if $listId == 'bargainItems' || $listId == 'newItems'  || $listId == 'topBox' || $listId == 'alsoBought' || $listId == 'similar' || $listId == 'alsoBoughtThankyou' || $listId == 'accessories'}] swiper-product-carousel[{/if}]" id="[{$listId}]">
    [{if $head}]
        [{if $header == "light"}]
            <div class="page-header title-section">
                <span class="h3">[{$head}]</span>
            </div>
        [{else}]
            <div class="page-header page-header--cat-title">
                [{assign var="frisch_eingetroffen_title" value=0}]
                [{oxifcontent ident="frisch_eingetroffen_title" }]
                [{assign var="frisch_eingetroffen_title" value=1}]
                [{/oxifcontent}]

                [{assign var="topseller_title" value=0}]
                [{oxifcontent ident="topseller_title" }]
                [{assign var="topseller_title" value=1}]
                [{/oxifcontent}]

                [{assign var="jetztimtv_title" value=0}]
                [{oxifcontent ident="jetztimtv_title" }]
                [{assign var="jetztimtv_title" value=1}]
                [{/oxifcontent}]


                <span class="title-section">
                     [{if $frisch_eingetroffen_title && $listId == 'newItems' }][{oxcontent ident=frisch_eingetroffen_title}]
                    [{elseif $topseller_title && $listId == 'topBox' }][{oxcontent ident=topseller_title}]
                    [{elseif $jetztimtv_title && $listId == 'bargainItems' }][{oxcontent ident=jetztimtv_title}]
                    [{else}][{$head}][{/if}]
                        [{if $rsslink && false}]

                            <a class="rss" id="[{$rssId}]" href="[{$rsslink.link}]" target="_blank">
                                <i class="fa fa-rss"></i>
                            </a>
                        [{/if}]
                    [{if $subhead && $listId != 'bargainItems' && $listId != 'newItems'  && $listId != '    ' && false}]
                        <small class="subhead">[{$subhead}]</small>
                    [{/if}]
                </span>
				[{if $smarty.get.dev != true}]
				<div class="controls">
                    <button type="button" class="kiconk-icon-arrow-round-left prevPage swiper-button-prev"></button>
                    <button type="button" class="kiconk-icon-arrow-round-right nextPage swiper-button-next"></button>
                </div>
				[{/if}]
            </div>
        [{/if}]
    [{/if}]
    [{assign var="productsCount" value=$products|@count}]
    [{if $productsCount gt 0}]
        [{math equation="x / y" x=12 y=$iProductsPerLine assign="iColIdent"}]
		[{if $smarty.get.dev != true}]

            [{if $listId == 'bargainItems' || $listId == 'newItems'  || $listId == 'topBox' || $listId == 'alsoBought' || $listId == 'cross' || $listId == 'similar' || $listId == 'alsoBoughtThankyou' || $listId == 'accessories' }]


                <div class="swiper-wrapper slider-product">
                  [{foreach from=$products item="_product" name="productlist"}]



                    [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
                    <div class="swiper-slide productData productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
                    </div>



                    [{/foreach}]
                </div>


                [{if $listId != 'cross'}]
               <div class="swiper-scrollbar"></div>
                [{/if}]


            [{else}]
            <div class="row gridView newItems">
            [{foreach from=$products item="_product" name="productlist"}]
                [{*if $_product->getStockStatus() != -1*}]
                    [{counter print=false assign="productlistCounter"}]
                    [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]

                    <div class="productData col-xs-12 col-sm-6 col-md-[{$iColIdent}] productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
                    </div>
                [{*/if*}]

            [{/foreach}]
             </div>
            [{/if}]
            [{* Counter resetten *}]
            [{counter print=false assign="productlistCounter" start=0}]
        </div>
		[{else}]
        <div class="list-container grid--mobile" id="[{$listId}]">
            [{if $listId == 'bargainItems' || $listId == 'newItems'  || $listId == 'topBox' || $listId == 'alsoBought' || $listId == 'cross' || $listId == 'similar' || $listId == 'alsoBoughtThankyou' || $listId == 'accessories' }]
            <div class="sly-wrapper">
              <div class="frame sly-carousel">
                <ul class="clearfix">
                  [{foreach from=$products item="_product" name="productlist"}]
                    <li>
                    [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
                    <div class="productData productBox">
                        [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
                    </div>
                    </li>
                    [{/foreach}]
                </ul>
              </div>
            	<div class="controls">
                    <span class="kiconk-icon-arrow-round-left prevPage"></span>
                    <span class="kiconk-icon-arrow-round-right nextPage"></span>
                </div>
              <div class="scrollbar">
                <div class="handle">
                  <div class="mousearea"></div>
                </div>
              </div>
          	</div>
            [{else}]
            [{foreach from=$products item="_product" name="productlist"}]
                [{counter print=false assign="productlistCounter"}]
                [{assign var="testid" value=$listId|cat:"_"|cat:$smarty.foreach.productlist.iteration}]
                [{if $productlistCounter == 1}]
                    <div class="row [{$type}]View newItems">
                [{/if}]
                <div class="productData col-xs-12 col-sm-6 col-md-[{$iColIdent}] productBox">

                    [{oxid_include_widget cl="oxwArticleBox" _parent=$oView->getClassName() nocookie=1 _navurlparams=$oViewConf->getNavUrlParams() iLinkType=$_product->getLinkType() _object=$_product anid=$_product->getId() sWidgetType=product sListType=listitem_$type iIndex=$testid blDisableToCart=$blDisableToCart isVatIncluded=$oView->isVatIncluded() showMainLink=$showMainLink recommid=$recommid owishid=$owishid toBasketFunction=$toBasketFunction removeFunction=$removeFunction altproduct=$altproduct inlist=$_product->isInList() skipESIforUser=1 testid=$testid}]
                </div>
                [{if $productlistCounter%$iProductsPerLine == 0 || $productsCount == $productlistCounter}]
                    </div>
                [{/if}]
                [{if $productlistCounter%$iProductsPerLine == 0 && $productsCount > $productlistCounter}]
                    <div class="row [{$type}]View newItems">
                [{/if}]
            [{/foreach}]
            [{/if}]
            [{* Counter resetten *}]
            [{counter print=false assign="productlistCounter" start=0}]
        </div>

		[{/if}]
    [{/if}]
</section>
    [{/if}]