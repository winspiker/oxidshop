[{assign var="oCurrency" value=$oFunctions->getActCurrency()}]
<form id="sitMultifilterForm" class="sitMultifilterForm">
<input type="hidden" id="activeFilterFlag" value="[{$activeFilterFlag}]">

[{if ($priceFilterArray and $priceFilterArray.max_price > 0) or $attributeList|count > 0}]
<div class="sitMultifilterHeader">
	<span id="sitMultifilterHeader">[{ oxmultilang ident="SIT_FILTER_TITLE" }]</span>
</div>
[{/if}]

[{* Price filter *}]
    [{if $priceFilterArray and $priceFilterArray.max_price > 0}]
    <div class="sitMultifilterGroup hidden-xs" id="multifilterPrice" style="z-index: 100;">
        <span>[{ oxmultilang ident="SIT_FILTER_PRICE" }]<span>&nbsp;</span></span>     
 		<link rel="stylesheet" href="[{$basePath}]/SITModuleFramework/lib/css/jquery-ui-1.12.1.min.css">
        <script type="text/javascript">
			if(typeof jQuery != "function")	{
				document.write('<scr'+'ipt type="text/javascript" src="[{$basePath}]/SITModuleFramework/lib/javascript/jquery-3.1.1.min.js"></scr'+'ipt>'); 
			}
			if (typeof jQuery.ui == 'undefined') {
  				document.write('<scr'+'ipt type="text/javascript" src="[{$basePath}]/SITModuleFramework/lib/javascript/jquery-ui.1.12.1.min.js"></scr'+'ipt>'); 	
				[{* document.write('<scr'+'ipt type="text/javascript" src="[{$basePath}]/SITModuleFramework/lib/javascript/jquery-ui.touch-punch.min.js"></scr'+'ipt>'); *}]
			}
    	</script>
		<ul>
            <li>
				<label id="sitMultifilterPriceSliderAmount" class="active"></label>
				<div id="sitMultifilterPriceSlider" data-url="[{$priceFilterArray.SEOURL}]" data-reseturl="[{$priceFilterArray.SEOURLRESET}]" data-currenturl="[{$priceFilterArray.CURRENTSEOURL}]"></div>
				<input id="sitMultifilterPriceSliderFilter" type="slider" name="pricefilter" value="[{$priceFilterArray.setting}]" style="display: none;">
				<input type="hidden" id="sitMultifilterPriceSliderCurrency" value="[{$oCurrency->name}]">
            </li>
        </ul>
        <script type="text/javascript">
			mf_sliderMinPrice 	 = [{$priceFilterArray.min_price}];
			mf_sliderMinPriceTop = [{$priceFilterArray.min_price_top}];
			mf_sliderMaxPrice 	 = [{$priceFilterArray.max_price}];
			mf_sliderMaxPriceLow = [{$priceFilterArray.max_price_low}];			
  		</script>
    </div>
    [{/if}]


[{* Category filter 
[{foreach from=$categoryArray key=categoryId item=oCategory name="categoryList"}]
	[{$oCategory->getTitle()}] - [{$oCategory->getLink()}]
[{/foreach}]
*}]

[{* Attribute groups *}]
    [{assign var="lastTitle" value=""}]
	[{assign var="closeDropdown" value=""}]
    [{assign var="groupSelectCount" value=0}]
    [{foreach from=$attributeList key=attributeTitle item=attributeArray name="attributeList"}]
    
    	[{foreach from=$attributeArray key=attributeValue item=attribute}]
    	
    		[{* Check new group *}]
    		[{if $attributeTitle != $lastTitle }]
    			
    			[{* Close last group *}]
    			[{if $lastTitle != ""}]
    				[{if $groupSelectCount > 1 }]
						
    					<div id="sitMultifilterGroupReset" class="sitMultifilterGroupReset">[{ oxmultilang ident="SIT_FILTER_RESET" }]</div>
    				[{/if}]
					[{assign var="groupSelectCount" value=0}]
					[{if $closeDropdown == "1" }]
						</select>
						[{assign var="closeDropdown" value=""}]
					[{/if}]
					</ul>
					<div style="clear: both;"></div>
    				</div>	
    			[{/if}]
    			
    			[{* Open group *}]
    			<div class="sitMultifilterGroup hidden-xs" id="[{$attributeTitle}]" style="z-index: [{(100 - $smarty.foreach.attributeList.iteration)}]">
    				<span>[{$attributeTitle}]<span>&nbsp;</span></span>
					<ul>
					[{if $attribute.TYPE == "dropdown"}]
						<select class="sitMultifilterGroupEntry" name="[{$attributeTitle}]">
							<option value="-999">[{ oxmultilang ident="SIT_FILTER_SELECT" }]</option>
						[{assign var="closeDropdown" value="1"}]
					[{else}]
    					<li class="sitMultifilterGroupSearchfield"><input type="text" name="sitMultifilterGroupSearchfield" value="" placeholder="[{ oxmultilang ident="SIT_FILTER_SEARCH" }]"></li>		
					[{/if}]

    				[{assign var="lastTitle" value=$attributeTitle}]
    		[{/if}]
    		
    		[{assign var="labelClass" value="active"}]
			[{assign var="disabledString" value=""}]
    		[{if $attribute.ACTIVE != "1" and $attribute.SELECTED != "1"}]
					
				[{if $hideUnuseableAttributesMode == "1" }]
    				[{assign var="labelClass" value="hidden"}]
					[{assign var="disabledString" value="style='display: none;'"}]
				[{else}]
					[{assign var="labelClass" value="disabled"}]
					[{assign var="disabledString" value="disabled='disabled'"}]
				[{/if}]
    		[{/if}]
    		
    		[{assign var="checkedString" value=""}]
    		[{assign var="selectedString" value=""}]
    		[{if $attribute.SELECTED == "1" }]
				[{assign var="labelClass" value="selected"}]
    			[{assign var="checkedString" value="checked"}]
    			[{assign var="selectedString" value="selected"}]
				[{assign var="groupSelectCount" value=$groupSelectCount+1}]
    		[{/if}]

			[{if $attribute.TYPE == "color"}]
			<li class="[{$attribute.TYPE}]">
                <input data-url="[{$attribute.SEOURL}]" data-reseturl="[{$attribute.CURRENTSEOURL_GROUPRESET}]" data-currenturl="[{$attribute.CURRENTSEOURL}]" class="sitMultifilterGroupEntry" style="display: none;" [{$disabledString}] type="checkbox" id="[{$attributeTitle}][{$attributeValue}]" name="[{$attributeTitle}]" value="[{$attributeValue}]" [{$checkedString}]> 
                [{*if $labelClass == 'active' or $labelClass == 'selected'}]<a href="[{$attribute.SEOURL}]">[{/if*}]<label for="[{$attributeTitle}][{$attributeValue}]" class="[{$labelClass}] [{$attribute.TYPE}]" title="[{$attributeValue}][{if $attribute.COUNT && $labelClass == 'active' }] ([{$attribute.COUNT}])[{/if}]" [{if $attribute.SPECIAL != ""}]style="background-color: [{$attribute.SPECIAL|urldecode}];"[{/if}]>[{if $attribute.SPECIAL == ""}][{$attributeValue}][{/if}]</label>[{*if $labelClass == 'active' or $labelClass == 'selected'}]</a>[{/if*}]
            </li>	
			[{elseif $attribute.TYPE == "dropdown"}]
           		<option data-url="[{$attribute.SEOURL}]" data-currenturl="[{$attribute.CURRENTSEOURL}]" id="[{$attributeTitle}][{$attributeValue}]" value="[{$attributeValue}]" [{$selectedString}] [{$disabledString}]>[{$attributeValue}][{if $attribute.COUNT && $labelClass == 'active' }] ([{$attribute.COUNT}])[{/if}]</option>
    		[{elseif $attributeTitle != ""}]
    		<li>
                <input data-url="[{$attribute.SEOURL}]" data-reseturl="[{$attribute.CURRENTSEOURL_GROUPRESET}]" data-currenturl="[{$attribute.CURRENTSEOURL}]" class="sitMultifilterGroupEntry" [{$disabledString}] type="checkbox" id="[{$attributeTitle}][{$attributeValue}]" name="[{$attributeTitle}]" value="[{$attributeValue}]" [{$checkedString}]> 
                [{*if $labelClass == 'active' or $labelClass == 'selected'}]<a href="[{$attribute.SEOURL}]">[{/if*}]<label for="[{$attributeTitle}][{$attributeValue}]" class="[{$labelClass}]">[{$attributeValue}][{if $attribute.COUNT && $labelClass == 'active' }] ([{$attribute.COUNT}])[{/if}]</label>[{*if $labelClass == 'active' or $labelClass == 'selected'}]</a>[{/if*}]
            </li>	
            [{/if}]
    	[{/foreach}]
    [{/foreach}]
	
[{* Close last group *}]
	
    [{if $lastTitle != ""}]
	    [{if $groupSelectCount > 1 }]
    		<div id="sitMultifilterGroupReset" class="sitMultifilterGroupReset">[{ oxmultilang ident="SIT_FILTER_RESET" }]</div>
    	[{/if}]
		[{if $closeDropdown == "1" }]
			</select>
		[{/if}]
		</ul>
		<div style="clear: both;"></div>
    	</div>
	[{/if}]
</form>