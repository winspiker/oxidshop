[{oxscript include="js/libs/jqBootstrapValidation.min.js?1234" priority=10}]
[{oxscript add="$('input,select,textarea').not('[type=submit]').jqBootstrapValidation();"}]



<div id="review">




[{if $oView->getReviews()}]

<div class="h2 page-header page-header--title">[{$oView->getReviews()|@count}] Produktbewertungen</div>
        
    [{foreach from=$oView->getReviews() item=review name=ReviewsCounter}]
    <div class="reviews--item" id="reviewName_[{$smarty.foreach.ReviewsCounter.iteration}]" itemprop="review" itemscope itemtype="http://schema.org/Review">
    [{* Bloofusion Google-Produkt-Markup für Google *}]
                    <div class="hidden">
                        <div itemprop="itemReviewed" itemscope itemtype="https://schema.org/Product">

                            <span itemprop="name">[{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]</span>
                            <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">


                                <span itemprop="priceCurrency" content="EUR">€</span><span
                                        itemprop="price" content="[{$oDetailsProduct->getFPrice()|replace:',':'.'}]">[{$oDetailsProduct->getFPrice()|replace:',':'.'}]</span>

                                <link itemprop="availability" href="https://schema.org/InStock" />In stock
                            </div>
                        </div>
                    </div>

        [{block name="widget_reviews_record"}]


                <div class="rating-meta">
                    <div class="date-comment">
                        [{assign var=reviewtime value=" "|explode:$review->oxreviews__oxcreate->value}]
                        [{$reviewtime[0]}]
                    </div>
                    <div class="rating-comments">
                        [{if $review->oxreviews__oxrating->value}]
                            <div class="text-warning reviews--text-rating" itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
                                [{section name="starRatings" start=0 loop=5}]
                                    [{if $review->oxreviews__oxrating->value >= $smarty.section.starRatings.iteration}]
                                        <i class="fas fa-star"></i>
                                    [{else}]
                                        <i class="far fa-star"></i>
                                    [{/if}]
                                [{/section}]
                                <div class="hidden">
                                    <span itemprop="worstRating">1</span>
                                    <span itemprop="ratingValue">[{$review->oxreviews__oxrating->value|default:'0'}]</span>
                                    <span itemprop="bestRating">5</span>
                                </div>
                            </div>
                        [{/if}]
                    </div>
                </div>




                      <div class="writer reviews--writer">
                                    <span itemprop="author" itemscope itemtype="https://schema.org/Person">
                                        <span itemprop="name">[{$review->oxuser__oxfname->value}]</span>
                                      </span>
                                    [{if false}]
                                    <span>
                                        <time itemprop="datePublished" datetime="[{$review->oxreviews__oxcreate->value|date_format:"%Y-%m-%d"}]">[{$review->oxreviews__oxcreate->value|date_format:"%d.%m.%Y"}]</time>
                                    </span>
                                    [{/if}]
                        </div>




            <div class="reviews--content" id="reviewText_[{$smarty.foreach.ReviewsCounter.iteration}]" itemprop="description">[{$review->oxreviews__oxtext->value}]</div>


[{/block}]
</div>
         [{/foreach}]
         

        [{else}]
        [{if false}]
        <div class="alert alert-info">
            [{oxmultilang ident="NO_REVIEW_AVAILABLE"}]
        </div>
        [{/if}]
    [{/if}]



    <div class="panel-group">
        <div class="panel panel-default reviews--panel">

<div class="review--block-head">

    <div class="h2 page-header page-header--title">[{oxmultilang ident="WRITE_PRODUCT_REVIEW"}]</div>

</div>


                <div class="h4 panel-title">
                    [{if $oxcmp_user}]

                    [{else}]
                        <div class="reviews--login-no">
                            <i class="fa fa-user"></i>&nbsp; <a id="reviewsLogin" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl=details"|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="MESSAGE_LOGIN_TO_WRITE_REVIEW"}]</a>
                        </div>
                    [{/if}]
            </div>

            [{if $oxcmp_user}]
                <div class="panel-collapse">
                    <div class="panel-body reviews--panel-body">
                        [{block name="widget_reviews_form"}]
                            <form action="[{$oViewConf->getSelfActionLink()}]" method="post" id="rating" class="form-horizontal" novalidate>
                                <div id="writeReview">
                                    <div class="hidden">
                                        [{if $oView->canRate()}]
                                            <input id="productRating" type="hidden" name="artrating" value="5">
                                            <input id="recommListRating" type="hidden" name="recommlistrating" value="5">
                                        [{/if}]
                                        [{$oViewConf->getHiddenSid()}]
                                        [{$oViewConf->getNavFormParams()}]
                                        [{oxid_include_dynamic file="form/formparams.tpl"}]
                                        <input type="hidden" name="fnc" value="savereview">
                                        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                                        [{if $oDetailsProduct}]
                                            <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
                                        [{else}]
                                            [{assign var="_actvrecommlist" value=$oView->getActiveRecommList()}]
                                            <input type="hidden" name="recommid" value="[{$_actvrecommlist->oxrecommlists__oxid->value}]">
                                        [{/if}]

                                        [{if $sReviewUserHash}]
                                            <input type="hidden" name="reviewuserhash" value="[{$sReviewUserHash}]">
                                        [{/if}]
                                    </div>
                                    [{block name="widget_reviews_form_fields"}]
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <textarea  rows="8" name="rvw_txt" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    [{/block}]

                                    [{if $oView->canRate()}]
                                        <ul id="reviewRating" class="rating list-inline" style="margin-top: 15px;">
                                            <p>[{oxmultilang ident="COMMENT_RATING_AND_REVIEW"}]</p>
                                            [{section name=star start=1 loop=6}]
                                                <li class="s[{$smarty.section.star.index}]" data-rate-value="[{$smarty.section.star.index}]">
                                                    <a href="#" class="ox-write-review ox-rateindex-[{$smarty.section.star.index}] text-warning reviews--text-rating" title="[{$smarty.section.star.index}] [{if $smarty.section.star.index==1}][{oxmultilang ident="STAR"}][{else}][{oxmultilang ident="STARS"}][{/if}]">
                                                       <i class="fas fa-star"></i>
                                                    </a>
                                                </li>
                                            [{/section}]
                                        </ul>
                                    [{/if}]

                                    [{block name="widget_reviews_form_buttons"}]
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <button id="reviewSave" type="submit" class="submitButton btn btn-primary">[{oxmultilang ident="SAVE_RATING_AND_REVIEW"}]</button>
                                        </div>
                                    </div>
                                    [{/block}]
                                </div>
                            </form>
                        [{/block}]
                    </div>
                </div>
            [{/if}]
        </div>
    </div>



</div>