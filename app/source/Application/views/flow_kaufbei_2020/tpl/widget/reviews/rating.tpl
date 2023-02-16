<div>
    [{assign var="iRatingValue" value=$oView->getRatingValue()}]

    [{if $iRatingValue}][{strip}]
    <div class="hidden" itemtype="http://schema.org/AggregateRating" itemscope="" itemprop="aggregateRating">
        <div itemprop="itemReviewed" itemscope itemtype="https://schema.org/Product">
            <span itemprop="name">[{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]</span>
            <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                <span itemprop="priceCurrency" content="EUR">€</span>
                <span itemprop="price" content="[{$oDetailsProduct->getFPrice()|replace:',':'.'}]">[{$oDetailsProduct->getFPrice()|replace:',':'.'}]</span>
                <link itemprop="availability" href="https://schema.org/InStock" />In stock
            </div>
        </div>
        <span itemprop="worstRating">1</span>
        <span itemprop="bestRating ">5</span>
        <span itemprop="ratingValue">[{$iRatingValue}]</span>
        <span itemprop="reviewCount">[{$oView->getRatingCount()}]</span>
    </div>
    [{/strip}][{/if}]

    [{if !$oxcmp_user}]
        [{assign var="_star_title" value="MESSAGE_LOGIN_TO_RATE"|oxmultilangassign}]
    [{elseif !$oView->canRate()}]
        [{assign var="_star_title" value="MESSAGE_ALREADY_RATED"|oxmultilangassign}]
    [{else}]
        [{assign var="_star_title" value="MESSAGE_RATE_THIS_ARTICLE"|oxmultilangassign}]
    [{/if}]

 <a class="open-review-tab" href="#review">
    [{section name="starRatings" start=0 loop=5}]

   
        [{if $iRatingValue == 0}]
            <i class="fa fa-star rating-star-empty"></i>
        [{else}]
            [{if $iRatingValue > 1}]
                <i class="fa fa-star rating-star-filled"></i>
                [{assign var="iRatingValue" value=$iRatingValue-1}]
            [{else}]
                [{if $iRatingValue < 0.5}]
                    [{if $iRatingValue < 0.3}]
                        <i class="fa fa-star rating-star-empty"></i>
                    [{else}]
                         <i class="fa fa-star rating-star-empty" style="position: relative;">
                             <i class="fa fa-star-half rating-star-filled" style="position: absolute; left: 0;"></i>
                         </i>
                    [{/if}]
                    [{assign var="iRatingValue" value=0}]
                [{elseif $iRatingValue > 0.8}]
                    <i class="fa fa-star rating-star-filled"></i>
                    [{assign var="iRatingValue" value=0}]
                [{else}]
                     <i class="fa fa-star rating-star-empty" style="position: relative;">
                         <i class="fa fa-star-half rating-star-filled" style="position: absolute; left: 0;"></i>
                     </i>
                    [{assign var="iRatingValue" value=0}]
                [{/if}]
            [{/if}]
        [{/if}]
    
    [{/section}]
     <span class="count--review [{if $oView->canRate()}]ox-write-review[{/if}]" title="[{$oView->getRatingCount()}] [{oxmultilang ident="DD_RATING_CUSTOMERRATINGS"}]">
        ([{$oView->getRatingCount()}])
    </span>
    </a>

</div>