[{assign var="oCurrency" value=$oFunctions->getActCurrency()}]
[{* Attribute groups *}]
	[{if $filterList|@count > 0}]
<div class="sitMultifilterGroupContent">
		[{assign var="title" value="SIT_FILTER_CONTENT_TITLE"|oxmultilangassign:$oLang}]
		[{assign var="title" value=$title|replace:"COUNT_ALL":$COUNT_ALL}]
		<div class="sitMultifilterGroupContentHeadline">[{$title}]</div>
 	[{/if}]
 	
	[{assign var="filterCount" value=0}]
	[{assign var="lastTitle" value=""}]
	
	[{if $priceFilterArray and $priceFilterArray.max_price > 0}]
		[{assign var="pricefilterValueArray" value=","|explode:$priceFilterArray.setting}]
		[{if $pricefilterValueArray.0 > $priceFilterArray.min_price || $pricefilterValueArray.1 < $priceFilterArray.max_price}]
    		<div class="sitMultifilterGroup" id="pricefilter">
    			<span>[{"pricefilter"|oxmultilangassign:$oLang}]</span>
    			<ul>
    				<li>
             		   <label for="pricefilter[{$priceFilterArray.setting}]">[{$pricefilterValueArray.0}] - [{$pricefilterValueArray.1}] [{$oCurrency->name}]</label>
 					</li>
				</ul>
    		</div>	
		[{/if}]
	[{/if}]
	
	[{foreach from=$attributeList key=attributeTitle item=attributeArray name="attributeList"}] 
    	[{foreach from=$attributeArray key=attributeValue item=attribute}]
    		[{if $attribute.SELECTED == "1" }]
    		
    			[{assign var="filterCount" value=$filterCount+1}]

    			[{* Check new group *}]
    			[{if $attributeTitle != $lastTitle }]
    			
    				[{* Close last group *}]
    				[{if $lastTitle != ""}]
    					</ul>
    					</div>	
    				[{/if}]
    			
    				[{* Open group *}]
    				<div class="sitMultifilterGroup" id="[{$attributeTitle}]">
    				<span>[{$attributeTitle|oxmultilangassign:$oLang}]</span>
    				<ul>
    						
    				[{assign var="lastTitle" value=$attributeTitle}]
    			[{/if}]

    			<li>
					[{if $attribute.TYPE == "dropdown"}]           		
						<label id="[{$attributeTitle}]" class="dropdownlabel">[{$attributeValue|htmlentities}]</label>
					[{else}]           		
						<label for="[{$attributeTitle}][{$attributeValue|htmlentities}]">[{$attributeValue|htmlentities}]</label>
					[{/if}]
 				</li>
 				
 			[{/if}]
    	[{/foreach}]
    [{/foreach}]

[{* Close last group *}]
	
    [{if $lastTitle != ""}]
	    </ul>
    	</div>
	[{/if}]
	
	[{if $filterCount > 1}]
    	<div class="sitMultifilterGroup">
    		<span id="sitMultifilterResetAll">[{ oxmultilang ident="SIT_FILTER_RESET_ALL" }]</span>
    	</div>
	[{/if}]
[{if $filterList|@count > 0}]
</div>
[{/if}]