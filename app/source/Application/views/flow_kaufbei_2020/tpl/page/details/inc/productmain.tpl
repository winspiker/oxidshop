[{oxscript include="js/pages/details.min.js" priority=10}]

[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]
[{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
    [{assign var="_sSelectionHash" value=""}]
    [{foreach from=$oSelectionList item=oListItem key=iPos}]
    [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
    [{/foreach}]
    [{if $_sSelectionHash}]
    [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
    [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
    [{/if}]
    [{/foreach}]
    [{oxscript add="oxVariantSelections  = [`$_sSelectionHashCollection`];"}]

    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        <div>
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
            <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
            <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
            <input type="hidden" name="nocookie" value="1">
            <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
            <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
            <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
            [{if $oConfig->getRequestParameter('preview')}]
        <input type="hidden" name="preview" value="[{$oConfig->getRequestParameter('preview')}]">
            [{/if}]
        </div>
    </form>
    [{/if}]

[{oxhasrights ident="TOBASKET"}]
<form class="js-oxProductForm" action="[{$oViewConf->getSelfActionLink()}]" method="post">
    <div class="hidden">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
        <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
        <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="panid" value="">
        [{if !$oDetailsProduct->isNotBuyable()}]
    <input type="hidden" name="fnc" value="tobasket">
        [{/if}]
    </div>
    [{/oxhasrights}]
    <div class="detailsInfo clear block-shadow">
        <div class="row">
            <div class="col-xs-12 col-sm-7 col-md-8 details-col-left">
                [{block name="details_productmain_title"}]
                <h1 id="productTitle">
                    [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
                </h1>
                [{/block}]
                <div class="line-sub-title">
                    [{if $oManufacturer}]
                    <div class="brandLogo">
                        [{block name="details_productmain_manufacturersicon"}]
                        <a href="[{$oManufacturer->getLink()}]" title="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                            [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                        <img src="[{$oManufacturer->getIconUrl()}]" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                            [{/if}]
                        </a>
                        <span class="hidden">[{$oManufacturer->oxmanufacturers__oxtitle->value}]</span>
                        [{/block}]
                    </div>
                    [{/if}]
                    [{* ratings *}]

                </div>
                [{* article picture with zoom *}]
                [{block name="details_productmain_zoom"}]
                [{*oxscript include="js/libs/photoswipe.min.js" priority=8*}]
                [{*oxscript include="js/libs/photoswipe-ui-default.min.js" priority=8*}]
                [{oxscript add="$( document ).ready( function() {  Flow.initDetailsEvents(); });"}]

                [{* Wird ausgeführt, wenn es sich um einen AJAX-Request handelt *}]
                [{if $blWorkaroundInclude}]
                [{oxscript add="$( document ).ready( function() { Flow.initEvents();});"}]
                [{/if}]




                [{/block}]


                [{if $oView->morePics()}]
                <div class="swiper-container swiper--main-product--carousel">
                    [{if $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'cool_transport' }]
                    <div class="cool-shipping-icons">
                        <i class="fas fa-snowflake"></i>
                    </div>
                    [{elseif $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'frozen_transport'}]
                    <div class="cool-shipping-icons">
                        <i class="fas fa-snowflake"></i>
                        <i class="fas fa-snowflake"></i>
                    </div>
                    [{/if}]
                    <div class="swiper-wrapper">
                        [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
                        <div class="swiper-slide">
                            <a data-fancybox="gallery" href="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]">
                                <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                    <rect class="cls-1" width="364" height="364"/>
                                </svg>
                                <img src="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]" alt="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" title="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">
                                <div class="swiper-lazy-preloader swiper-lazy-preloader-black"></div>
                            </a>

                        </div>
                        [{/foreach}]


                    </div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
                <div class="otherPictures--container">
                    <div thumbsSlider="" class="swiper-container-more-pics swiper--main-product--thumbs" id="morePicsContainer">
                        <div class="swiper-wrapper">
                            [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
                            <div class="swiper-slide">
                                <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                    <rect class="cls-1" width="364" height="364"/>
                                </svg>
                                <img src="[{$oPictureProduct->getPictureUrl($iPicNr)}]" alt="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" title="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">
                                <div class="swiper-lazy-preloader swiper-lazy-preloader-black"></div>
                            </div>
                            [{/foreach}]
                        </div>
                        <button type="button" class="swiper-button-prev"><i class="far fa-long-arrow-left"></i></button>
                        <button type="button" class="swiper-button-next"><i class="far fa-long-arrow-right"></i></button>
                    </div>
                </div>




                [{else}]
                [{* ToDo: This logical part should be ported into a core function. *}]
                [{if $oConfig->getConfigParam('sAltImageUrl') || $oConfig->getConfigParam('sSSLAltImageUrl')}]
                [{assign var="aPictureInfo" value=$oPictureProduct->getMasterZoomPictureUrl(1)|@getimagesize}]
                [{else}]
                [{assign var="sPictureName" value=$oPictureProduct->oxarticles__oxpic1->value}]
                [{assign var="aPictureInfo" value=$oConfig->getMasterPicturePath("product/1/`$sPictureName`")|@getimagesize}]
                [{/if}]

                <div class="picture text-center">
                    [{if $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'cool_transport' }]
                    <div class="cool-shipping-icons">
                        <i class="fas fa-snowflake"></i>
                    </div>
                    [{elseif $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'frozen_transport'}]
                    <div class="cool-shipping-icons">
                        <i class="fas fa-snowflake"></i>
                        <i class="fas fa-snowflake"></i>
                    </div>
                    [{/if}]

                    [{if $oDetailsProduct->getFTPrice()}]
                    [{assign var="oldPrice"    value=$oDetailsProduct->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                    [{assign var="newPrice"    value=$oDetailsProduct->getFPrice()|replace:'.':''|replace:',':'.'|floatval }]
                    [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)"
                    nprice=$newPrice
                    hundred=100
                    oprice=$oldPrice
                    }]
                    <div class="test--badge">
                        <div class="badge-default">-[{$discount|round:0}]%</div>
                    </div>
                    [{/if}]

                    <a data-fancybox="gallery" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" id="zoom1"[{if $aPictureInfo}] data-width="[{$aPictureInfo.0}]" data-height="[{$aPictureInfo.1}]"[{/if}]>
                        <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                            <rect class="cls-1" width="364" height="364"/>
                        </svg>

                        <img src="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" alt="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" title="[{$oDetailsProduct->getTabslImageTag($oDetailsProduct->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">

                    </a>
                </div>
                [{/if}]
            </div>

            <div class="col-xs-12 col-sm-5 col-md-4 col-lg-4 details-col-middle">
                [{if $oDetailsProduct->isInstallmentActive()}]
                    [{assign var="oInstallment" value=$oDetailsProduct->getInstallment()}]

                    [{assign var="oPaymentMonths" value=$oInstallment->getPaymentMonths()}]
                    [{assign var="oFullPrice" value=$oInstallment->getFullPrice()|number_format:2|replace:'.':','}]
                    [{assign var="oFirstPayment" value=$oInstallment->getFirstPayment()|number_format:2|replace:'.':','}]
                    [{assign var="oMonthlyPayment" value=$oInstallment->getMonthlyPayment()|number_format:2|replace:'.':','}]

                    <button type="button" id="filter_credit_popup"><img alt="FILTER CREDIT" src="/out/flow_kaufbei_2020/img/filter_credit_[{$oView->getActiveLangAbbr()}].svg"></button>
                    <div class="cool-shipping-tooltip">
                        [{ oxcontent ident=FILTER_CREDIT }]
                    </div>
                        <div id="filter_credit_popup_content" class="white-popup">
                            <div class="popup_title">
                                <img src="/out/flow_kaufbei_2020/img/filter_credit_popup_[{$oView->getActiveLangAbbr()}].svg" alt="popup">
                                <header>[{oxmultilang ident="filter_credit_title_1"}] [{$oPaymentMonths}] [{oxmultilang ident="filter_credit_title_2"}] [{if $oPaymentMonths <= 4}] [{oxmultilang ident="filter_payment_1"}] [{elseif $oPaymentMonths > 4}] [{oxmultilang ident="filter_payment_2"}] [{/if}] </header>
                            </div>
                            <div class="popup_content">
                                <div class="popup_text no_space">
                                    <div class="popup_block1 ">
                                        [{oxmultilang ident="filter_credit_price"}]
                                    </div>
                                    <div class="popup_block2">
                                        [{$oFullPrice}] <span class="popup_span">[{$currency->sign}]</span>
                                    </div>
                                </div>
                                <div class="popup_text">
                                    <div class="popup_block1 ">
                                        [{oxmultilang ident="filter_credit_avans"}]
                                    </div>
                                    <div class="popup_block2">
                                        [{$oFirstPayment}]  <span class="popup_span">[{$currency->sign}]</span>
                                    </div>
                                </div>
                                <div class="popup_monthly">
                                    <div class="popup_block">
                                        <div class="popup_block1">
                                            [{$oMonthlyPayment}]
                                            <span class="popup_span">[{$currency->sign}]/[{oxmultilang ident="filter_credit_euro_month"}]</span>
                                        </div>
                                        <div class="popup_block2">
                                            [{$oPaymentMonths}] [{if $oPaymentMonths <= 4}] [{oxmultilang ident="filter_payment_1"}] [{elseif $oPaymentMonths > 4}] [{oxmultilang ident="filter_payment_2"}] [{/if}]
                                        </div>
                                    </div>
                                    <div id="no_bold" class="popup_block mini_size">
                                        <div class="popup_block1">
                                            [{oxmultilang ident="filter_credit_percent"}] 0,00 <span class="popup_span">[{$currency->sign}]</span>
                                        </div>
                                    </div>
                                    <div id="no_bold" class="popup_block mini_size">
                                        <div class="popup_block1">
                                            [{oxmultilang ident="filter_credit_year_percent"}] 0,00  <span class="popup_span">[{oxmultilang ident="filter_credit_year_percent_sign"}]</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="popup_info">
                                    <p>[{oxmultilang ident="filter_credit_info_1"}]</p>
                                    <p>[{oxmultilang ident="filter_credit_info_2"}]</p>
                                    <p>[{oxmultilang ident="filter_credit_info_3"}]</p>
                                </div>
                                <div class="popup_logo">
                                    <img src="[{$oViewConf->getImageUrl()}][{if $blHolidaySelect == 'blackfriday'}]logo-blackfriday.svg[{else}]logo.svg?2[{/if}]" alt="logo">
                                </div>
                            </div>
                        </div>
                [{/if}]

                [{if $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'cool_transport' ||  $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'frozen_transport'}]
                <a href="[{ oxgetseourl ident="info_frische_produkte" type="oxcontent" }]" target="_blank" class="cool-shipping-tooltip">
                    [{if $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'cool_transport'}]
                    [{oxmultilang ident="COOL_SHIPPING_TOOLTIP"}]
                    [{/if}]
                    [{if $oDetailsProduct->oxarticles__exonn_cool_shipping->value == 'frozen_transport'}]
                    [{oxmultilang ident="COOL_SHIPPING_TOOLTIP_2"}]
                    [{/if}]
                </a>
                [{/if}]

                [{assign var=oBundle value=$oView->getBundleArticle()}]
                [{if $oBundle}]


                <div class="product-set-title-gift">[{oxmultilang ident="GIFT"}]</div>
                <div class="product-set-items slider-product" style="position: relative;">
                    <div class="productData">
                        <div class="picture text-center">

                            <a href="[{$oBundle->getLink()}]" title="[{$oBundle->oxarticles__oxtitle->value}] [{$oBundle->oxarticles__oxvarselect->value}]">
                                <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                    <rect class="cls-1" width="364" height="364"/>
                                </svg>
                                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oBundle->getThumbnailUrl()}]" alt="[{$oPictureProduct->getTabslImageTag($oPictureProduct->oxarticles__tabsl_imagetag1->value) }]" title="[{$oPictureProduct->getTabslImageTag($oPictureProduct->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">
                            </a>
                        </div>
                        <div class="listDetails">

                            <a href="[{$oBundle->getLink()}]" title="[{$oBundle->oxarticles__oxtitle->value}] [{$oBundle->oxarticles__oxvarselect->value}]">
                                <span>[{$oBundle->oxarticles__oxtitle->value}] [{$oBundle->oxarticles__oxvarselect->value}]</span>
                            </a>






                            [{assign var="oUnitQuantity" value=$oBundle->oxarticles__oxunitquantity->value}]
                            [{assign var="oUnitPrice" value=$oBundle->getUnitPrice()}]

                            [{* $category->oxcategories__oxtitle->value == 'Honig Sets' *}]



                            <div class="price">
                                <div class="content">


                                    [{block name="widget_product_listitem_grid_price"}]
                                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                    [{assign var="oUnitPrice" value=$oBundle->getUnitPrice()}]
                                    [{assign var="tprice"     value=$oBundle->getTPrice()}]
                                    [{assign var="price"      value=$oBundle->getPrice()}]

                                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                    <span class="oldPrice text-muted">
                                    <del>[{$oBundle->getFTPrice()}] [{$currency->sign}] UVP</del>
                                </span>
                                    [{/if}]

                                    [{block name="widget_product_listitem_line_price_value"}]
                                    <span id="productPrice_sets_[{$smarty.foreach.productSets.iteration}]" class="lead text-nowrap">
                                    <span class="finalSum">
                                        [{if $oBundle->isRangePrice()}]
                                            [{oxmultilang ident="PRICE_FROM"}]
                                            [{if !$oBundle->isParentNotBuyable()}]
                                                [{$oBundle->getFMinPrice()}]
                                            [{else}]
                                                [{$oBundle->getFVarMinPrice()}]
                                            [{/if}]
                                        [{else}]
                                            [{if !$oBundle->isParentNotBuyable()}]
                                                [{$oBundle->getFPrice()}]
                                            [{else}]
                                                [{$oBundle->getFVarMinPrice()}]
                                            [{/if}]
                                        [{/if}]
                                    </span>
                                    <span class="currency">[{$currency->sign}]</span>
                                    [{if $oView->isVatIncluded()}]
                                        [{if !($oBundle->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oBundle->getSelections(1)) || $oBundle->getVariants())}][{/if}]
                                    [{/if}]
                                </span>
                                    [{/block}]







                                    [{/oxhasrights}]
                                    [{/block}]
                                </div>
                            </div>


                            [{if $oBundle->getFTPrice()}]
                            [{assign var="oldPrice"    value=$oBundle->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                            [{assign var="newPrice"    value=$oBundle->getFMinPrice()|replace:'.':''|replace:',':'.'|floatval }]

                            [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)" nprice=$newPrice hundred=100 oprice=$oldPrice}]

                            <div class="size-discount">[{oxmultilang ident="SIE_SPAREN"}] [{$discount|round:0}]%</div>

                            [{/if}]
                            <div class="text-art">Art.: [{$oBundle->oxarticles__oxartnum->value}]</div>



                            <span class="priceDefault" style="display:none" >
                               [{if $oBundle->isRangePrice()}]
                                        [{oxmultilang ident="PRICE_FROM"}]
                                        [{if !$oBundle->isParentNotBuyable()}]
                                            [{$oBundle->getFMinPrice()}]
                                        [{else}]
                                            [{$oBundle->getFVarMinPrice()}]
                                        [{/if}]
                                    [{else}]
                                        [{if !$oBundle->isParentNotBuyable()}]
                                            [{$oBundle->getFPrice()}]
                                        [{else}]
                                            [{$oBundle->getFVarMinPrice()}]
                                        [{/if}]
                                    [{/if}]

                                    [{if $oView->isVatIncluded()}]
                                        [{if !($oBundle->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oBundle->getSelections(1)) || $oBundle->getVariants())}][{/if}]
                                    [{/if}]
                            </span>

                        </div>

                    </div>
                    <span class="gift--triangle" style="border-bottom: 85px solid rgba(246, 47, 94, 0.8); border-left: 85px solid transparent;"><i  style="left: -43px; top: 42px; font-size: 34px;" class="fa fa-gift" aria-hidden="true"></i></span>
                </div>

                [{/if}]



                [{* article main info block *}]
                <div class="custom-variants">

                </div>


                <div data-product-id="[{$oDetailsProduct->oxarticles__oxid->value}]" data-product-parentid="[{$oDetailsProduct->oxarticles__oxparentid->value}]" class="information">

                    <div class="productMainInfo[{if $oManufacturer->oxmanufacturers__oxicon->value}] hasBrand[{/if}]">

                        [{* additional info *}]



                        <div class="additionalInfo clearfix">
                            [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                        </div>

                        [{block name="details_productmain_vpe"}]
                        [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                        <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                        <br>
                        [{/if}]
                        [{/block}]

                        [{assign var="blCanBuy" value=true}]
                        [{* variants | md variants *}]
                        [{block name="details_productmain_variantselections"}]
                        [{if $aVariantSelections && $aVariantSelections.selections}]
                        [{oxscript include="js/widgets/oxajax.min.js" priority=10 }]
                        [{oxscript include="js/widgets/oxarticlevariant1.min.js?cdoxvulkjfdslkjgfhdfgurtuityrwefgsdjfg" priority=10 }]
                        [{oxscript add="$( '#variants' ).oxArticleVariant();"}]
                        [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                        [{if !$blHasActiveSelections}]
                        [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                        [{assign var="blCanBuy" value=true}]
                        [{/if}]
                        [{/if}]
                        <div id="variants" class="selectorsBox js-fnSubmit clear">
                            [{assign var="blHasActiveSelections" value=false}]
                            [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                            [{if $oList->getActiveSelection()}]
                            [{assign var="blHasActiveSelections" value=true}]
                            [{/if}]
                            [{include file="widget/product/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                            <div class="clearfix"></div>
                            [{/foreach}]
                        </div>
                        [{/if}]
                        [{/block}]
                    </div>

                    [{* selection lists *}]
                    [{block name="details_productmain_selectlists"}]
                    [{if $oViewConf->showSelectLists()}]
                    [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                    [{if $oSelections}]
                    <div class="selectorsBox js-fnSubmit clear" id="productSelections">
                        [{foreach from=$oSelections item=oList name=selections}]
                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                        [{/foreach}]
                    </div>
                    [{/if}]
                    [{/if}]
                    [{/block}]



                    <div class="details--price-container">
                        [{if $oView->getRatingValue() != 0}]
                        <div class="star-ratings">
                            [{if $oView->ratingIsActive()}]
                            [{block name="details_productmain_ratings"}]
                            [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
                            [{/block}]
                            [{/if}]
                        </div>
                        [{/if}]
                        <div class="pricebox">

                            [{assign var="fPriceForDiscount" value=$oDetailsProduct->getFPrice()}]
                            [{if $oDetailsProduct->isParentNotBuyable()}]
                                [{assign var="fPriceForDiscount" value=$oDetailsProduct->getFVarMinPrice()}]
                            [{/if}]

                            [{block name="details_productmain_tprice"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                            [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                            [{assign var=price  value=$oDetailsProduct->getPrice()}]
                            [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                            <div class="oldPrice price--oldPrice">
                                <span class="oldPrice-wrap">UVP <del data-oldprice="[{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]">[{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]</del></span>

                                [{if $oDetailsProduct->getFTPrice()}]
                                [{assign var="oldPrice"    value=$oDetailsProduct->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                                [{assign var="newPrice"    value=$fPriceForDiscount|replace:'.':''|replace:',':'.'|floatval }]
                                [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)"
                                nprice=$newPrice
                                hundred=100
                                oprice=$oldPrice
                                }]



                                <div class="size-discount">[{oxmultilang ident="PAGE_PRICE_INFO_SPAREN"}] [{$discount|round:0}]%</div>
                                [{/if}]
                            </div>




                            [{/if}]
                            [{/oxhasrights}]
                            [{/block}]

                            [{block name="details_productmain_watchlist"}][{/block}]

                            [{block name="details_productmain_price"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                            [{block name="details_productmain_price_value"}]
                            [{if $oDetailsProduct->getFPrice()}]
                                [{assign var="sFrom" value=""}]
                                [{assign var="fPrice" value=$oDetailsProduct->getFPrice()}]
                                [{if $oDetailsProduct->isParentNotBuyable()}]
                                    [{assign var="fPrice" value=$oDetailsProduct->getFVarMinPrice()}]
                                    [{if $oDetailsProduct->isRangePrice()}]
                                        [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                    [{/if}]
                                [{/if}]
                                [{assign var="finalSumParts" value=','|explode:$fPrice }]

                                <label id="productPrice" class="price">
                                    <span[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}] class="text-danger"[{/if}]>
                                    <span class="sup-ab">[{$sFrom}]</span>
                                        <span class="finalSum">
                                            [{strip}]
                                                [{$finalSumParts.0}]
                                                <span class="sup-price">[{$finalSumParts.1}]</span>
                                            [{/strip}]
                                        </span>
                                        [{if $oView->isVatIncluded()}]

                                        [{/if}]
                                        [{$currency->sign}]
                                        <span class="hidden">
                                            <span>[{$fPrice}] [{$currency->sign}]</span>
                                        </span>
                                    </span>
                                </label>
                            [{/if}]
                            [{if $oDetailsProduct->loadAmountPriceInfo()}]
                            [{include file="page/details/inc/priceinfo.tpl"}]
                            [{/if}]
                            [{/block}]
                            [{/oxhasrights}]
                            [{/block}]
                        </div>

                        <span class="priceDefault" style="display:none" >
                        [{$fPrice}]
                    </span>
                        [{if false}]
                        <div class="number-icon">
                            <div class="number down"><span></span></div>
                            <input id="amountToBasket" type="text" min="1" maxlength="10" name="am" value="1" size="3" autocomplete="off" class="textbox">
                            <div class="number up"><span></span><span></span></div>
                        </div>
                        [{/if}]

                    </div>

                    [{if $oDetailsProduct->oxarticles__oxstockflag->value == 3 && $oDetailsProduct->oxarticles__oxstock->value == 0}]
                    [{else}]
                    [{oxhasrights ident="TOBASKET"}]
                    [{if !$oDetailsProduct->isNotBuyable()}]
                    <div class="number-icon">
                        <span>[{oxmultilang ident="QUANTITY"}]:</span>
                        <select name="am" id="amountToBasket" value="1">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select>
                    </div>
                    [{/if}]
                    [{/oxhasrights}]
                    [{/if}]

                    [{if $oDetailsProduct->getStockStatus() == -1}]
                    <span class="stockFlag notOnStock">
                                <span class="text-danger stockFlag--danger"></span>
                                <span>
                                    [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]

                                        [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                                    [{elseif $oViewConf->getStockOffDefaultMessage()}]

                                        [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                    [{/if}]
                                    [{if $oDetailsProduct->getDeliveryDate()}]
                                        [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]

                                    [{/if}]
                                </span>
                            </span>
                    [{elseif $oDetailsProduct->getStockStatus() == 1}]

                    <span class="stockFlag lowStock">
                                <span class="text-warning stockFlag--warning"></span>
                                <span>[{oxmultilang ident="LOW_STOCK"}]
                                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]&nbsp;
                                [{/if}]
                                [{if $oViewConf->getStockOnDefaultMessage()}]
                                            <span style="display: block; height: 10px; width: 100%;"></span>
                                            [{assign var="oxDeltimeUnit" value=$oDetailsProduct->oxarticles__oxdeltimeunit->value}]

                                            [{oxmultilang ident="ARTICLE_STOCK_DELTIME"}] [{$oDetailsProduct->oxarticles__oxmindeltime->value}]-[{$oDetailsProduct->oxarticles__oxmaxdeltime->value}]
                                            [{if $oxDeltimeUnit == "DAY"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_DAYS"}]
                                            [{/if}]
                                            [{if $oxDeltimeUnit == "MONTH"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_MONTHS"}]
                                            [{/if}]
                                            [{if $oxDeltimeUnit == "WEEK"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_WEEKS"}]
                                            [{/if}]
                                        [{*oxmultilang ident="READY_FOR_SHIPPING"*}]
                                [{/if}]
                                </span>
                            </span>
                    [{elseif $oDetailsProduct->getStockStatus() == 0}]
                    <span class="stockFlag">

                                <span class="text-success stockFlag--success"></span>
                                <span>
                                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]&nbsp;
                                [{/if}]
                                [{if $oViewConf->getStockOnDefaultMessage()}]
                                            [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                            <span style="display: block; height: 10px; width: 100%;"></span>
                                            [{/if}]
                                            [{assign var="oxDeltimeUnit" value=$oDetailsProduct->oxarticles__oxdeltimeunit->value}]

                                            [{oxmultilang ident="ARTICLE_STOCK_DELTIME"}] [{$oDetailsProduct->oxarticles__oxmindeltime->value}]-[{$oDetailsProduct->oxarticles__oxmaxdeltime->value}]
                                            [{if $oxDeltimeUnit == "DAY"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_DAYS"}]
                                            [{/if}]
                                            [{if $oxDeltimeUnit == "MONTH"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_MONTHS"}]
                                            [{/if}]
                                            [{if $oxDeltimeUnit == "WEEK"}]
                                            [{oxmultilang ident="ARTICLE_STOCK_WEEKS"}]
                                            [{/if}]
                                        [{*oxmultilang ident="READY_FOR_SHIPPING"*}]
                                [{/if}]
                                </span>
                            </span>
                    [{/if}]

                    [{if $oDetailsProduct->oxarticles__oxstockflag->value == 3 && $oDetailsProduct->oxarticles__oxstock->value == 0}]
                    [{else}]
                        [{oxhasrights ident="TOBASKET"}]
                        [{if !$oDetailsProduct->isNotBuyable()}]
                        <div data-stock-flag="[{$oDetailsProduct->oxarticles__oxstockflag->value}]" class="tobasket">

                            <div class="button-part">

                                [{* pers params *}]
                                [{block name="details_productmain_persparams"}]
                                [{if $oView->isPersParam()}]
                                <div class="persparamBox clear form-group">
                                    <label for="persistentParam" class="control-label">[{oxmultilang ident="LABEL"}]</label>
                                    <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35" class="form-control">
                                </div>
                                [{/if}]
                                [{/block}]

                                [{assign var="oSession" value=$oConfig->getSession()}]
                                <div class="tobasketFunction clear">
                                    [{oxhasrights ident="TOBASKET"}]
                                    [{if !$oDetailsProduct->isNotBuyable()}]
                                    <div class="input-group">
                                        <div class="input-group-tweak">
                                            <div id="toBasket" type="submit" [{if !$blCanBuy && !$aVariantSelections}]disabled="disabled"[{/if}] class="[{if $blCanBuy}]cart-ajax [{/if}]btn btn-primary submitButton largeButton"><i class="fas fa-cart-plus"></i>[{oxmultilang ident="TO_CART"}]</div>
                                            [{if $oDetailsProduct->getStockStatus() == -1}]
                                            <div class="send-later-notification">
                                                [{oxmultilang ident="SEND_LATER_NOTIFICATION"}]
                                            </div>
                                            [{/if}]
                                        </div>
                                    </div>
                                    [{/if}]
                                    [{/oxhasrights}]
                                </div>


                                [{block name="details_productmain_tobasket"}][{/block}]
                            </div>



                        </div>
                        [{/if}]
                        [{/oxhasrights}]
                    [{/if}]
                    [{* exonn Start PayPal Ratenzahlung *}]
                    <div
                            data-pp-message
                            data-pp-style-layout="text"
                            data-pp-style-logo-type="inline"
                            data-pp-style-text-color="black"
                            data-pp-amount="[{"."|implode:$finalSumParts|oxescape}]"
                    ></div>
                    [{* exonn Ende PayPal Ratenzahlung *}]
                    [{block name="details_productmain_artnumber"}]
                    <p class="art">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</p>
                    [{/block}]


                    [{if $oUnitPrice}]
                    <div class="line-detailinfo">
                        <div class="price">
                            <i class="fas fa-money-bill-wave"></i>
                            [{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]
                        </div>

                    </div>
                    [{/if}]
                    <div class="product-list-versandkosten">
                        inkl. MwSt., <a style="display: inline-block;" href="[{ oxgetseourl ident="oxdeliveryinfo" type="oxcontent" }]" target="_blank">zzgl. Versandkosten</a>
                    </div>
                </div>
                [{if $oDetailsProduct->oxarticles__oxid->value == '2ebb5992fb387f9ed6c9794aff964dcb' || $oDetailsProduct->oxarticles__oxparentid->value == '2ebb5992fb387f9ed6c9794aff964dcb' || $oDetailsProduct->oxarticles__oxid->value == '020480fac23aa46b52666b376a24e5a2' || $oDetailsProduct->oxarticles__oxparentid->value == '020480fac23aa46b52666b376a24e5a2' || $oDetailsProduct->oxarticles__oxid->value == '2f9742922141bb8f9405d93706cde145' || $oDetailsProduct->oxarticles__oxparentid->value == '2f9742922141bb8f9405d93706cde145'}]
                <div class="cancel-subscription">
                    <a href="https://bem-media.de/kuendigung" target="_blank" class="btn largeButton">Kündigung</a>
                </div>
                [{/if}]
                [{block name="details_productmain_productlinksselector"}]
                [{block name="details_productmain_productlinks"}]

                <ul class="list-unstyled action-links">


                    
                    [{if $oViewConf->getShowWishlist()}]
                    <li>
                        [{if $oxcmp_user}]
                        <a id="linkToWishList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=towishlist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]"><i class="far fa-heart"></i><span>[{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</span></a>
                        [{else}]
                        <a id="loginToWish" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]"><i class="far fa-heart"></i><span>[{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</span></a>
                        [{/if}]
                    </li>
                    [{/if}]
                    <li>
                        <a href="#" class="share-popup-button"><i class="far fa-share-square"></i><span>[{oxmultilang ident="SHARE"}]</span></a>
                    </li>


                </ul>

                [{/block}]
                [{/block}]

                [{if $oDetailsProduct->oxarticles__oxstockcondition->value == 'B-Ware'}]
                <a href="https://www.kaufbei.tv/Lagerwaren-Deals-Zertifizierte-B-Waren/" class="block-certificate">
                    <div class="block-certificate__img">
                        <img src="[{$oViewConf->getImageUrl('Kaufbei_B-Ware_button_zertifikat_1b.png')}]" alt="">
                    </div>
                    <div class="block-certificate__text">[{oxmultilang ident="CERTIFICATE_TEXT"}]</div>
                </a>
                [{/if}]


                [{assign var=oBandleArray
                value=$oDetailsProduct->getAllTeilFromSetArticleObject(false, true)}]

                [{if $oBandleArray|@count gt 0}]
                <div class="product-set-title">[{oxmultilang ident="SET_CONSIST"}]</div>
                <div class="product-set-items slider-product">
                    [{foreach from=$oBandleArray item=oProductPart name=productSets}]

                    <div class="productData[{if $smarty.foreach.productSets.iteration > 3}] toggledProduct[{/if}]"[{if $smarty.foreach.productSets.iteration > 3}] style="display: none;"[{/if}]>
                        <div class="picture text-center">

                            <a href="[{$oProductPart->getLink()}]" title="[{$oProductPart->oxarticles__oxtitle->value}] [{$oProductPart->oxarticles__oxvarselect->value}]">
                                <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                    <rect class="cls-1" width="364" height="364"/>
                                </svg>
                                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$oProductPart->getThumbnailUrl()}]" alt="[{$oPictureProduct->getTabslImageTag($oPictureProduct->oxarticles__tabsl_imagetag1->value) }]" title="[{$oPictureProduct->getTabslImageTag($oPictureProduct->oxarticles__tabsl_imagetag1->value) }]" itemprop="image" class="img-responsive">
                            </a>
                            <span class="product-in-set">[{$oProductPart->oxarticles__partcount->value}] <span>x</span></span>
                        </div>
                        <div class="listDetails">

                            <a href="[{$oProductPart->getLink()}]" title="[{$oProductPart->oxarticles__oxtitle->value}] [{$oProductPart->oxarticles__oxvarselect->value}]">
                                <span>[{$oProductPart->oxarticles__oxtitle->value}] [{$oProductPart->oxarticles__oxvarselect->value}]</span>
                            </a>






                            [{assign var="oUnitQuantity" value=$oProductPart->oxarticles__oxunitquantity->value}]
                            [{assign var="oUnitPrice" value=$oProductPart->getUnitPrice()}]

                            [{* $category->oxcategories__oxtitle->value == 'Honig Sets' *}]



                            <div class="price">
                                <div class="content">


                                    [{block name="widget_product_listitem_grid_price"}]
                                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                    [{assign var="oUnitPrice" value=$oProductPart->getUnitPrice()}]
                                    [{assign var="tprice"     value=$oProductPart->getTPrice()}]
                                    [{assign var="price"      value=$oProductPart->getPrice()}]

                                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                    <span class="oldPrice text-muted">
                                    <del>[{$oProductPart->getFTPrice()}] [{$currency->sign}] UVP</del>
                                </span>
                                    [{/if}]

                                    [{block name="widget_product_listitem_line_price_value"}]
                                    <span id="productPrice_sets_[{$smarty.foreach.productSets.iteration}]" class="lead text-nowrap">
                                    <span class="finalSum">
                                        [{if $oProductPart->isRangePrice()}]
                                            [{oxmultilang ident="PRICE_FROM"}]
                                            [{if !$oProductPart->isParentNotBuyable()}]
                                                [{$oProductPart->getFMinPrice()}]
                                            [{else}]
                                                [{$oProductPart->getFVarMinPrice()}]
                                            [{/if}]
                                        [{else}]
                                            [{if !$oProductPart->isParentNotBuyable()}]
                                                [{$oProductPart->getFPrice()}]
                                            [{else}]
                                                [{$oProductPart->getFVarMinPrice()}]
                                            [{/if}]
                                        [{/if}]
                                    </span>
                                    <span class="currency">[{$currency->sign}]</span>
                                    [{if $oView->isVatIncluded()}]
                                        [{if !($oProductPart->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oProductPart->getSelections(1)) || $oProductPart->getVariants())}][{/if}]
                                    [{/if}]
                                </span>
                                    [{/block}]







                                    [{/oxhasrights}]
                                    [{/block}]
                                </div>
                            </div>


                            [{if $oProductPart->getFTPrice()}]
                            [{assign var="oldPrice"    value=$oProductPart->getFTPrice()|replace:'.':''|replace:',':'.'|floatval }]
                            [{assign var="newPrice"    value=$oProductPart->getFMinPrice()|replace:'.':''|replace:',':'.'|floatval }]

                            [{math  assign="discount"  equation="(oprice - nprice) / (oprice / hundred)" nprice=$newPrice hundred=100 oprice=$oldPrice}]

                            <div class="size-discount">[{oxmultilang ident="SIE_SPAREN"}] [{$discount|round:0}]%</div>

                            [{/if}]
                            <div class="text-art">Art.: [{$oProductPart->oxarticles__oxartnum->value}]</div>



                            <span class="priceDefault" style="display:none" >
                               [{if $oProductPart->isRangePrice()}]
                                        [{oxmultilang ident="PRICE_FROM"}]
                                        [{if !$oProductPart->isParentNotBuyable()}]
                                            [{$oProductPart->getFMinPrice()}]
                                        [{else}]
                                            [{$oProductPart->getFVarMinPrice()}]
                                        [{/if}]
                                    [{else}]
                                        [{if !$oProductPart->isParentNotBuyable()}]
                                            [{$oProductPart->getFPrice()}]
                                        [{else}]
                                            [{$oProductPart->getFVarMinPrice()}]
                                        [{/if}]
                                    [{/if}]

                                    [{if $oView->isVatIncluded()}]
                                        [{if !($oProductPart->hasMdVariants() || ($oViewConf->showSelectListsInList() && $oProductPart->getSelections(1)) || $oProductPart->getVariants())}][{/if}]
                                    [{/if}]
                            </span>

                        </div>

                    </div>
                    [{/foreach}]
                    [{if $oBandleArray|@count > 3}]
                    <div class="show-all-product-parts--container">
                        <button class="btn" type="button" id="show-all-product-parts"><span class="all-show">[{oxmultilang ident="SHOW_ALL"}]</span><span class="all-hide">[{oxmultilang ident="HIDE_ALL"}]</span></button>
                    </div>
                    [{/if}]
                </div>
                [{/if}]

                [{foreach from=$oView->getAttributes() item=oAttr name=attribute}]
                [{if $oAttr->title == 'FSK 18'}]
                <div class="fsk-18--wrapper">
                    <div class="fsk-18">
                        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             viewBox="0 0 372 372" enable-background="new 0 0 372 372" xml:space="preserve">
<g>
    <g>
        <path fill="#EB1C24" d="M186,372C83.4,372,0,288.6,0,186S83.4,0,186,0s186,83.4,186,186S288.6,372,186,372z M186,26
			C97.8,26,26,97.8,26,186c0,88.2,71.8,160,160,160c88.2,0,160-71.8,160-160C346,97.8,274.2,26,186,26z"/>
    </g>
    <g>
        <g>
            <path fill="#242424" d="M78.3,161.9v-25l28.8-19.5h16.1v136.8h-22.9V147.8L78.3,161.9z"/>
            <path fill="#242424" d="M222,243.2c-8.2,8.6-18.2,12.9-30.1,12.9c-11.9,0-21.9-4.3-30.1-12.9c-8.2-8.6-12.3-19.1-12.3-31.5
				c0-14.5,5.7-26,17.1-34.6c-6.3-6.5-9.5-14.5-9.5-24c0-10.6,3.3-19.5,9.9-26.8c6.6-7.3,14.9-10.9,24.8-10.9
				c9.9,0,18.2,3.6,24.8,10.9c6.6,7.3,9.9,16.2,9.9,26.8c0,9.5-3.2,17.5-9.5,24c11.4,8.6,17.1,20.1,17.1,34.6
				C234.3,224.1,230.2,234.6,222,243.2z M178,226.6c3.7,4,8.4,6.1,13.9,6.1c5.5,0,10.2-2,13.9-6.1c3.7-4,5.6-9,5.6-14.9
				c0-5.9-1.9-10.8-5.6-15c-3.7-4.1-8.4-6.2-13.9-6.2c-5.5,0-10.2,2.1-13.9,6.2c-3.7,4.1-5.6,9.1-5.6,15
				C172.4,217.6,174.3,222.5,178,226.6z M183.4,163.2c2.2,2.7,5.1,4,8.6,4c3.5,0,6.4-1.3,8.6-4c2.2-2.7,3.3-6,3.3-10.1
				c0-4-1.1-7.4-3.3-10.2c-2.2-2.7-5.1-4.1-8.6-4.1c-3.5,0-6.4,1.4-8.6,4.1c-2.2,2.7-3.3,6.1-3.3,10.2
				C180.1,157.1,181.2,160.5,183.4,163.2z"/>
        </g>
        <g>
            <path fill="#242424" d="M245.3,178.5h30.1v-30.1h15.5v30.1H321V194h-30.1v30.1h-15.5V194h-30.1V178.5z"/>
        </g>
    </g>
</g>
</svg>
                        <div>[{oxmultilang ident="fsk_text"}] <a href="https://www.kenn-dein-limit.info" target="_blank">kenn-dein-limit.info</a>.</div>
                        <button type="button" data-fancybox-close class="fsk-ok">OK</button>
                    </div>
                </div>
                [{/if}]
                [{/foreach}]

                [{block name="details_relatedproducts_crossselling"}]
                    [{if $oView->getCrossSelling()}]
                        [{capture append="oxidBlock_productbar"}]
                            [{include file="widget/product/list.tpl" type="grid" listId="cross" products=$oView->getCrossSelling() head="HAVE_YOU_SEEN"|oxmultilangassign subhead="WIDGET_PRODUCT_RELATED_PRODUCTS_CROSSSELING_SUBHEADER"|oxmultilangassign}]
                        [{/capture}]
                    [{/if}]
                [{/block}]

                [{if $oxidBlock_productbar}]
                    <div id="relProducts" class="relatedProducts relatedProducts-min">
                        [{foreach from=$oxidBlock_productbar item="_block"}]
                            [{$_block}]
                        [{/foreach}]
                    </div>
                [{/if}]








                <!-- </div> -->
                <!-- </div> -->
            </div>
        </div>
    </div>

    [{oxhasrights ident="TOBASKET"}]
</form>
    [{/oxhasrights}]


[{literal}]

<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"Product",
  "productID":"[{/literal}][{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}][{literal}]",
  "name":"[{/literal}][{$oDetailsProduct->oxarticles__oxtitle->value}][{literal}]",
  "description":"[{/literal}][{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}][{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}][{/if}][{literal}]",
  "url":"[{/literal}][{$oDetailsProduct->getLink()}][{literal}]",
  "image":"[{/literal}][{$oView->getActPicture()}][{literal}]",
  "gtin13": "[{/literal}][{$oDetailsProduct->oxarticles__oxean->value}][{literal}]",
  "sku": "[{/literal}][{$oDetailsProduct->oxarticles__oxartnum->value}][{literal}]",
  "brand": {
    "@type": "Brand",
    "name": "[{/literal}][{$oManufacturer->oxmanufacturers__oxtitle->value}][{literal}]"
  },
  "offers": [
    {
      "@type": "Offer",
      "price": "[{/literal}][{$fPrice|replace:',':'.'}][{literal}]",
      "priceCurrency": "EUR",
      "itemCondition": "NewCondition",
      "availability": "[{/literal}][{if $oDetailsProduct->getStockStatus() == -1}]OutOfStock[{else}]InStock[{/if}][{literal}]",
      "priceValidUntil": "[{/literal}][{$date_iso|date_format:"%Y-%m-%d"}][{literal}]",
      "url":"[{/literal}][{$oDetailsProduct->getLink()}][{literal}]"

    }
  ]
}


</script>
    [{/literal}]