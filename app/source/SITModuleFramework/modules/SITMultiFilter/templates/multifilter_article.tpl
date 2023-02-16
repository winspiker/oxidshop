[{assign var="oCurrency" value=$oFunctions->getActCurrency()}]
<li class="articleResultMain">
    <a title="[{ $oArticle->getTitle()|strip_tags|htmlentities }]" href="[{ $oArticle->getLink() }]">
        
		<div class="articleResultTitle">
            [{ $oArticle->getTitle()|htmlentities }]
        </div>

        <div class="articleResultImage">
            [{if $oArticle->getThumbnailUrl() != ""}]
                <img alt="[{ $oArticle->getTitle()|strip_tags|htmlentities }]" src="[{$oArticle->getThumbnailUrl()}]" >
            [{/if}]
        </div>
    
        <div class="articleResultPrice">
            [{if $oArticle->getFPrice() > 0}]
				[{$oArticle->getFPrice()}] [{$oCurrency->sign}]
			[{elseif $oArticle->getFVarMinPrice() > 0}]
				[{ oxmultilang ident="PRICE_FROM" }] [{$oArticle->getFVarMinPrice()}] [{$oCurrency->sign}]
			[{/if}]
        </div>

    </a>
</li>