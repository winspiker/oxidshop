[{assign var="blFirstTab" value=true}]



[{block name="details_tabs_longdescription"}]
    [{oxhasrights ident="SHOWLONGDESCRIPTION"}]
    [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]
    [{if $oLongdesc->value}]
    [{capture append="tabs"}]<a href="#description" data-toggle="tab">[{oxmultilang ident="DESCRIPTION"}]</a>[{/capture}]
    [{capture append="tabsContent"}]
    <div id="description" class="tab-pane[{if $blFirstTab}] active[{/if}]" itemprop="description">

        [{include file="page/details/inc/media_youtube.tpl"}]

        <div class="h2 page-header page-header--title page-header--description">[{oxmultilang ident="PRODUCT_DESCRIPTION"}]</div>
        [{oxeval var=$oLongdesc}]
        [{if $oDetailsProduct->oxarticles__oxexturl->value}]
        <a id="productExturl" class="js-external" href="[{$oDetailsProduct->oxarticles__oxexturl->value}]">
            [{if $oDetailsProduct->oxarticles__oxurldesc->value}]
            [{$oDetailsProduct->oxarticles__oxurldesc->value}]
            [{else}]
            [{$oDetailsProduct->oxarticles__oxexturl->value}]
            [{/if}]
        </a>
        [{/if}]
    </div>
    [{/capture}]
    [{assign var="blFirstTab" value=false}]
    [{/if}]
    [{/oxhasrights}]
    [{/block}]

[{block name="details_tabs_attributes"}]
    [{if $oView->getAttributes()}]
    [{capture append="tabs"}]<a href="#attributes" data-toggle="tab">[{oxmultilang ident="SPECIFICATION"}]</a>[{/capture}]
    [{capture append="tabsContent"}]
    <div id="attributes" class="tab-pane[{if $blFirstTab}] active[{/if}]">
        [{if $oDetailsProduct->oxarticles__oxean->value or $oManufacturer or ($oDetailsProduct->oxarticles__oxlength->value or $oDetailsProduct->oxarticles__oxwidth->value or $oDetailsProduct->oxarticles__oxheight->value) or $oDetailsProduct->oxarticles__oxweight->value or $oDetailsProduct->oxarticles__oxexturl->value }]
        <div class="h2">[{oxmultilang ident="GRUNDINFORMATION"}]</div>
        <ul>
            [{if $oDetailsProduct->oxarticles__oxean->value}]
            <li>
                <span>EAN</span>
                <p>[{$oDetailsProduct->oxarticles__oxean->value}]</p>
            </li>
            [{/if}]
            [{if $oManufacturer}]
            <li>
                <span>[{oxmultilang ident="HERSTELLER"}]</span>
                <p>[{$oManufacturer->oxmanufacturers__oxtitle->value}]</p>
            </li>
            [{/if}]
            [{if $oDetailsProduct->oxarticles__oxlength->value or $oDetailsProduct->oxarticles__oxwidth->value or $oDetailsProduct->oxarticles__oxheight->value}]
            <li>
                <span>[{oxmultilang ident="MASSE"}]</span>
                <p>[{if $oDetailsProduct->oxarticles__oxlength->value}]L:[{$oDetailsProduct->oxarticles__oxlength->value}] [{oxmultilang ident="ARTICLE_EXTEND_DIMENSIONS_UNIT"}]&nbsp;&nbsp;&nbsp;[{/if}][{if $oDetailsProduct->oxarticles__oxwidth->value}]B:[{$oDetailsProduct->oxarticles__oxwidth->value}] [{oxmultilang ident="ARTICLE_EXTEND_DIMENSIONS_UNIT"}]&nbsp;&nbsp;&nbsp;[{/if}][{if $oDetailsProduct->oxarticles__oxheight->value}]H:[{$oDetailsProduct->oxarticles__oxheight->value}] [{oxmultilang ident="ARTICLE_EXTEND_DIMENSIONS_UNIT"}] [{/if}]</p>
            </li>
            [{/if}]
            [{if $oDetailsProduct->oxarticles__oxweight->value}]
            <li>
                <span>[{oxmultilang ident="GEWICHT_BRUTTO"}]</span>
                <p>[{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="ARTICLE_EXTEND_WEIGHT_UNIT"}]</p>
            </li>
            [{/if}]
            [{if $oDetailsProduct->oxarticles__oxexturl->value}]
            <li>
                <span>Externe URL</span>
                <p><a href="[{$oDetailsProduct->oxarticles__oxexturl->value}]" target="_blank">[{$oDetailsProduct->oxarticles__oxexturl->value}]</a></p>
            </li>
            [{/if}]

            [{if $oDetailsProduct->oxarticles__oxstockcondition->value}]
            <li>
                <span>[{oxmultilang ident="STATUS"}]</span>
                <p>[{$oDetailsProduct->oxarticles__oxstockcondition->value}]</p>
            </li>
            [{/if}]



        </ul>
        [{/if}]
        [{if $oView->getAttributes()}]

        <h2>[{oxmultilang ident="ADDITIONAL_INFO"}]</h2>
        [{include file="page/details/inc/attributes.tpl"}]
        [{/if}]
    </div>
    [{assign var="blFirstTab" value=false}]
    [{/capture}]
    [{/if}]
    [{/block}]

    [{if false}]
        [{block name="details_tabs_pricealarm"}]
        [{if $oView->isPriceAlarm() && !$oDetailsProduct->isParentNotBuyable()}]
        [{capture append="tabs"}]<a href="#pricealarm" data-toggle="tab">[{oxmultilang ident="PRICE_ALERT"}]</a>[{/capture}]
        [{capture append="tabsContent"}]
        <div id="pricealarm" class="tab-pane[{if $blFirstTab}] active[{/if}]">[{include file="form/pricealarm.tpl"}]</div>
        [{assign var="blFirstTab" value=false}]
        [{/capture}]
        [{/if}]
        [{/block}]
    [{/if}]


    [{capture append="tabs"}]<a href="#versand_custom" data-toggle="tab">[{oxmultilang ident="Shipping"}]</a>[{/capture}]
    [{capture append="tabsContent"}]
    <div id="versand_custom" class="tab-pane">
        <h2>[{oxmultilang ident="Shipping_within_Germany"}]</h2>
        <h3>[{oxmultilang ident="Delivery_service"}]:</h3>
        <div style="display: flex;">
            <img src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/DHL-shipping.svg" alt="" style="height: 100px; width: 100px; border-radius: 10px; box-shadow: 0px 1px 3px 0px rgb(0,0,0,0.2); margin-bottom: 20px;">
            <img src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/spedition.svg" alt="" style="height: 100px; width: 150px; border-radius: 10px; box-shadow: 0px 1px 3px 0px rgb(0,0,0,0.2); margin-bottom: 20px; margin-left: 20px;">
        </div>
        <div class="versand_custom-row" style="margin-bottom: 10px;">
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
                                    <span>[{oxmultilang ident="LOW_STOCK"}]</span>
                                </span>
            [{elseif $oDetailsProduct->getStockStatus() == 0}]
            <span class="stockFlag">

                                    <span class="text-success stockFlag--success"></span>
                                    [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                        [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                        <span>
                                                [{assign var="oxDeltimeUnit" value=$oDetailsProduct->oxarticles__oxdeltimeunit->value}]

                                                [{oxmultilang ident="ARTICLE_STOCK_DELTIME"}] [{$oDetailsProduct->oxarticles__oxmindeltime->value}]-[{$oDetailsProduct->oxarticles__oxmaxdeltime->value}]
                                                [{if $oxDeltimeUnit == "DAY"}]
                                                [{oxmultilang ident="Working_days"}]
                                                [{/if}]
                                                [{if $oxDeltimeUnit == "MONTH"}]
                                                [{oxmultilang ident="ARTICLE_STOCK_MONTHS"}]
                                                [{/if}]
                                                [{if $oxDeltimeUnit == "WEEK"}]
                                                [{oxmultilang ident="ARTICLE_STOCK_WEEKS"}]
                                                [{/if}]
                                            [{*oxmultilang ident="READY_FOR_SHIPPING"*}]</span>
                                    [{/if}]
                                </span>
            [{/if}]
        </div>
        <h3>[{oxmultilang ident="Shipping"}]:</h3>
        <p><a style="color: #87B144;" href="https://www.kaufbei.tv/Zahlung-und-Versand/">https://www.kaufbei.tv/Zahlung-und-Versand/</a></p>


    </div>
    [{/capture}]








[{block name="details_tabs_media"}]

    [{if $oView->getMediaFiles()}]
    [{assign var="filescount" value=0}]
    [{foreach from=$oView->getMediaFiles() item="oMediaUrl" name="mediaURLs"}]
    [{assign var="sUrl" value=$oMediaUrl->oxmediaurls__oxurl->value}]

    [{if $sUrl|strpos:'youtube.com' || $sUrl|strpos:'youtu.be'}]
    [{else}]
    [{assign var="filescount" value=$filescount+1}]
    [{/if}]
    [{/foreach}]
        [{if $filescount > 0}]
            [{capture append="tabs"}]<a href="#media" data-toggle="tab">[{oxmultilang ident="DOWNLOADS"}]</a>[{/capture}]
            [{capture append="tabsContent"}]
            <div id="media" class="tab-pane[{if $blFirstTab}] active[{/if}]">

                [{include file="page/details/inc/media.tpl"}]</div>
            [{assign var="blFirstTab" value=false}]
            [{/capture}]
        [{/if}]
    [{/if}]

[{/block}]

[{block name="details_tabs_comments"}]
    [{capture append="tabs"}]<a href="#reviews" data-toggle="tab">[{oxmultilang ident="WRITE_PRODUCT_REVIEW"}]</a>[{/capture}]
    [{capture append="tabsContent"}]
        <div id="reviews" class="tab-pane">
            <div class="relatedInfo[{if !$oView->getSimilarProducts() && !$oView->getCrossSelling() && !$oView->getAccessoires()}] relatedInfoFull[{/if}]">

                [{if $oView->isReviewActive()}]
                <div class="widgetBox reviews reviews--container">
                    [{include file="widget/reviews/reviews.tpl"}]
                </div>
                [{/if}]

            </div>
        </div>
    [{/capture}]

[{/block}]

[{block name="details_tabs_invite"}]
    [{/block}]

[{block name="details_tabs_main"}]
    [{if $tabs}]
    <div class="tabbedWidgetBox clear">
        <ul id="itemTabs" class="nav nav-tabs">
            [{foreach from=$tabs item="tab" name="tabs"}]
        <li[{if $smarty.foreach.tabs.first}] class="active"[{/if}]>[{$tab}]</li>
            [{/foreach}]
            [{block name="details_tabs_social_navigation"}][{/block}]
        </ul>
        <div class="tab-content">
            [{foreach from=$tabsContent item="tabContent" name="tabsContent"}]
            [{$tabContent}]
            [{/foreach}]
            [{block name="details_tabs_social_content"}][{/block}]
        </div>
    </div>
    [{/if}]
    [{/block}]

