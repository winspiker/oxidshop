[{oxscript include="js/pages/details.js" priority=10}]


[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{assign var="badge" value=$oDetailsProduct->getBadgeHtml()}]



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
        </div>
    </form>
[{/if}]

[{oxhasrights ident="TOBASKET"}]
    <form class="js-oxProductForm" id="detailsProductID" action="[{$oViewConf->getSelfActionLink()}]" method="post">
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


<div class="detailsInfo clear block-shadow" itemscope itemtype="http://schema.org/Product">
    <div class="row">

                [{block name="details_productmain_title"}]
                <h1 id="productTitle" itemprop="name">
                    [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
                </h1>
            [{/block}]

                        [{* article number *}]
            [{block name="details_productmain_artnumber"}]
                <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</span>
            [{/block}]


        <div class="col-xs-12 col-sm-6 col-md-6 details-col-left">
        
            [{* article picture with zoom *}]
            [{block name="details_productmain_zoom"}]
                [{oxscript include="js/libs/photoswipe.min.js" priority=8}]
                [{oxscript include="js/libs/photoswipe-ui-default.min.js" priority=8}]
                [{oxscript add="$( document ).ready( function() { if( !window.isMobileDevice() ) Flow.initDetailsEvents(); });"}]

                [{* Wird ausgeführt, wenn es sich um einen AJAX-Request handelt *}]
                [{if $blWorkaroundInclude}]
                    [{oxscript add="$( document ).ready( function() { Flow.initEvents();});"}]
                [{/if}]

                [{if $oView->showZoomPics()}]
                    [{* ToDo: This logical part should be ported into a core function. *}]
                    [{if $oConfig->getConfigParam('sAltImageUrl') || $oConfig->getConfigParam('sSSLAltImageUrl')}]
                        [{assign var="aPictureInfo" value=$oPictureProduct->getMasterZoomPictureUrl(1)|@getimagesize}]
                    [{else}]
                        [{assign var="sPictureName" value=$oPictureProduct->oxarticles__oxpic1->value}]
                        [{assign var="aPictureInfo" value=$oConfig->getMasterPicturePath("product/1/`$sPictureName`")|@getimagesize}]
                    [{/if}]

                    <div class="picture text-center">

                        [{$badge}]

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


                        <a href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" id="zoom1"[{if $aPictureInfo}] data-width="[{$aPictureInfo.0}]" data-height="[{$aPictureInfo.1}]"[{/if}]>
                            <svg class="image-rect" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 364 364">
                                <rect class="cls-1" width="364" height="364"/>
                            </svg>
                            <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-responsive">
                        </a>
                    </div>
                [{else}]
                    <div class="picture  text-center">
                        <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-responsive">
                    </div>
                [{/if}]
            [{/block}]

            [{block name="details_productmain_morepics"}]
                [{include file="page/details/inc/morepics.tpl"}]
            [{/block}]

        </div>

        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 details-col-middle">

               
                        
                    <div class="row">
                        <div class="col-xs-12 col-md-5">
                             [{* ratings *}]
            <div class="star-ratings">
                [{if $oView->ratingIsActive()}]
                    [{block name="details_productmain_ratings"}]
                        [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
                    [{/block}]
                [{/if}]
            </div>
                        </div>

                    </div>



            [{* short description *}]
            [{block name="details_productmain_shortdesc"}]
                [{oxhasrights ident="SHOWSHORTDESCRIPTION"}]
                    [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
                        <div class="shortdesc" id="productShortdesc" itemprop="description">
                        <p>[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
                        </p></div>
                    [{/if}]
                [{/oxhasrights}]
            [{/block}]


            <div class="details--top-info">

            [{block name="details_productmain_stockstatus"}]
                        [{if $oDetailsProduct->getStockStatus() == -1}]
                            <span class="stockFlag notOnStock">
                                <span class="text-danger stockFlag--danger"></span>
                                [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                                [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                [{/if}]
                                [{if $oDetailsProduct->getDeliveryDate()}]
                                    <link itemprop="availability" href="http://schema.org/PreOrder"/>
                                    [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                                [{/if}]
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 1}]
                            <link itemprop="availability" href="http://schema.org/InStock"/>
                            <span class="stockFlag lowStock">
                                <span class="text-warning stockFlag--warning"></span>
                                <span>[{oxmultilang ident="LOW_STOCK"}]</span>
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 0}]
                            <span class="stockFlag">
                                <link itemprop="availability" href="http://schema.org/InStock"/>
                                <span class="text-success stockFlag--success"></span>
                                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                                [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                    <span>[{oxmultilang ident="READY_FOR_SHIPPING"}]</span>
                                [{/if}]
                            </span>
                        [{/if}]
                    [{/block}]
           
            </div>


            [{* article main info block *}]
            <div class="information" itemprop="offers" itemscope itemtype="http://schema.org/Offer">

                
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
                                [{oxscript include="js/widgets/oxarticlevariant.min.js?daapsweirtuertiuerytier" priority=10 }]
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

                    <div class="pricebox">
                        [{block name="details_productmain_tprice"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{assign var=tprice value=$oDetailsProduct->getTPrice()}]
                                [{assign var=price  value=$oDetailsProduct->getPrice()}]

                                 [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                     <div class="oldPrice price--oldPrice">
                                        <del data-oldprice="[{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]">[{$oDetailsProduct->getFTPrice()}] [{$currency->sign}]</del>
                                        <br/>
                                    </div>
                                [{/if}]

                            [{/oxhasrights}]
                        [{/block}]

                        [{block name="details_productmain_watchlist"}][{/block}]

                        [{block name="details_productmain_price"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{block name="details_productmain_price_value"}]
                                    [{if $oDetailsProduct->getFPrice()}]
                                        <label id="productPrice" class="price">
                                            [{assign var="sFrom" value=""}]
                                            [{assign var="fPrice" value=$oDetailsProduct->getFPrice()}]
                                            [{if $oDetailsProduct->isParentNotBuyable()}]
                                                [{assign var="fPrice" value=$oDetailsProduct->getFVarMinPrice()}]
                                                [{if $oDetailsProduct->isRangePrice()}]
                                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                                [{/if}]
                                            [{/if}]
                                            <span[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}] class="text-danger"[{/if}]>
                                                <span class="price-from">[{$sFrom}]</span>
                                                <span class="finalSum">[{$fPrice}]</span>
                                                <span class="currency">[{$currency->sign}]</span>
                                                [{if $oView->isVatIncluded()}]
                                                    
                                                [{/if}]
                                                <span class="hidden">
                                                    <span itemprop="price">[{$fPrice}] [{$currency->sign}]</span>
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

                    <div class="number-icon">  
                              
                       <div class="number down">
                           <span></span>
                       </div> 
                   
                       <input id="amountToBasket" type="text" min="1" maxlength="10" name="am" value="1" size="3" autocomplete="off" class="textbox">
                                             
                       <div class="number up">
                           <span></span><span></span>
                       </div>
                               
                   </div>

                </div>

                <div class="tobasket">
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
					<div style="margin: 0 0 10px 0;">
					inkl. MwSt., [{$oDetailsProduct->getArticleVat()}]% zzgl. 5,90&euro; Versandkosten
					
					</div>
                    <div class="tobasketFunction clear">
                            [{oxhasrights ident="TOBASKET"}]
                                [{if !$oDetailsProduct->isNotBuyable()}]
                                    <div class="input-group">

                                        <div class="input-group-tweak">
                                            <div id="toBasket" type="submit" [{if !$blCanBuy && !$aVariantSelections}]disabled="disabled"[{/if}] class="[{if $blCanBuy}]cart-ajax [{/if}]btn btn-primary submitButton largeButton">[{oxmultilang ident="TO_CART"}]</div>
                                        </div>
                                    </div>
                                [{/if}]
                            [{/oxhasrights}]
                        </div> 


                                [{assign var="oSession" value=$oConfig->getSession()}]



                    [{block name="details_productmain_productlinksselector"}]
                        [{block name="details_productmain_productlinks"}]
                                <div class="tobasket--add-wishlist wishlistBlock">
                                    [{if $oViewConf->getShowListmania()}]
                                       [{if $oxcmp_user}]


                                        [{if $oDetailsProduct->isArticleInNoticeList()}]
                                            <a id="linkToNoticeList" class="wishlist-ajax wishlist-is" href="#"><i class="fa fa-heart-o" aria-hidden="true"></i>&nbsp; [{oxmultilang ident="DD_DELETE_ARTICLE"}]</a>

                                            [{else}]
                                            <a id="linkToNoticeList" class="wishlist-ajax wishlist-not" href="#"><i class="fa fa-heart-o" aria-hidden="true"></i>&nbsp; [{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                                            </span>
                                        [{/if}]

                                        [{else}]
                                            <a id="loginToNotice" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]"><i class="fa fa-heart-o" aria-hidden="true"></i>&nbsp; [{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                                        [{/if}]
                                    [{/if}]

                                    
                                </div>
                        [{/block}]
                    [{/block}]

                </div>
            </div>

            <div class="detailsInfo--social">
                <span>[{oxmultilang ident="DD_SHARE_THIS_PRODUCT"}]</span>
                <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,telegram,gplus,twitter,viber,whatsapp,skype"></div>
            </div>

    [{block name="details_tabs_tags"}]
        [{if $oView->showTags() && ( $oView->getTagCloudManager() || ( ( $oView->getTagCloudManager() || $oxcmp_user) && $oDetailsProduct ) )}]
[{assign var="oCloudManager" value=$oView->getTagCloudManager()}]

                        [{if $oCloudManager->getCloudArray()|@count > 0}]
                <div class="tagCloud--container">
                    <div class="tagCloud--title"><i class="fa fa-tags" aria-hidden="true"></i>&nbsp; Tags</div>
                    <p class="tagCloud">
                 
                        
                        [{foreach from=$oCloudManager->getCloudArray() item="oTag" name="detailsTags"}]
                            <a class="tagitem_[{$oCloudManager->getTagSize($oTag->getTitle())}]" href="[{$oTag->getLink()}]">[{$oTag->getTitle()}]</a>[{if !$smarty.foreach.detailsTags.last}], [{/if}]
                        [{/foreach}]
                    </p>
                </div>
[{/if}]
        [{/if}]
    [{/block}]

        </div>






            
    </div>
</div>



[{oxhasrights ident="TOBASKET"}]
    </form>
[{/oxhasrights}]

