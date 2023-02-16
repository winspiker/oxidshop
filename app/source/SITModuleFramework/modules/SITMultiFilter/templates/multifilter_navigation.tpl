<div class="sitResultNavigation">
	[{if $paging.COUNT_ALL > 0}]
	<div class="sitResultNavigationPages">
		<ul>
    	[{ if $paging.CURRENT_PAGE_INDEX > 0 }]
    		<li><a href="#" id="[{$paging.CURRENT_PAGE_INDEX - 1}]">[{oxmultilang ident="SIT_NAVIGATION_PAGE_PREVIOUS"}]</a></li>
    	[{/if}]
    	
		[{if ($paging.CURRENT_PAGE_INDEX - 3) >= 0 }]
        	<li><a href="#" id="0" [{$activeString}]>1</a></li>
			[{if ($paging.CURRENT_PAGE_INDEX - 3) > 0 }]
				<li><a href="#" id="[{$paging.CURRENT_PAGE_INDEX - 1}]" [{$activeString}]>...</a></li>
			[{/if}]
        [{/if}]

    	[{foreach from=$paging.PAGES item=currentPage}]
    		
    		[{assign var="activeString" value=""}]
    		[{if $currentPage.INDEX == $paging.CURRENT_PAGE_INDEX}]
    			[{assign var="activeString" value="class='active'"}]
    		[{/if}]
    		
    		[{if $currentPage.INDEX > ($paging.CURRENT_PAGE_INDEX - 3) and $currentPage.INDEX < ($paging.CURRENT_PAGE_INDEX + 3) }]
                   <li><a href="#" id="[{$currentPage.INDEX}]" [{$activeString}]>[{$currentPage.INDEX + 1}]</a></li>
            [{/if}]
            
    	[{/foreach}]

    	[{if ($paging.CURRENT_PAGE_INDEX + 3) <= ($paging.PAGE_COUNT - 1) }]
			[{if ($paging.CURRENT_PAGE_INDEX + 3) < ($paging.PAGE_COUNT - 1) }]
				<li><a href="#" id="[{$paging.CURRENT_PAGE_INDEX + 1}]" [{$activeString}]>...</a></li>
  			[{/if}]
        	<li><a href="#" id="[{$paging.PAGE_COUNT -1}]" [{$activeString}]>[{$paging.PAGE_COUNT}]</a></li>
        [{/if}]

    	[{ if $paging.CURRENT_PAGE_INDEX < ($paging.PAGE_COUNT -1) }]
    		<li><a href="#" id="[{$paging.CURRENT_PAGE_INDEX + 1}]">[{oxmultilang ident="SIT_NAVIGATION_PAGE_NEXT"}]</a></li>
    	[{/if}]
	    </ul>
	</div>
	<div class="sitResultNavigationCounts">
		[{if $paging.COUNTS}]
		[{assign var="activeText" value=""}]
		[{foreach from=$paging.COUNTS item=currentCount}]
    		[{if $currentCount.INDEX == $paging.CURRENT_COUNT_INDEX}]
    			[{assign var="activeText" value=$currentCount.INDEX}]
    		[{/if}]
		[{/foreach}]	
		<span>[{oxmultilang ident="SIT_NAVIGATION_ARTICLES_PER_PAGE"}][{if $activeText}] [{oxmultilang ident=$activeText}][{/if}]</span>
		<ul class="sitDrop">
			[{foreach from=$paging.COUNTS item=currentCount}]

				[{assign var="activeString" value=""}]
    			[{if $currentCount.INDEX == $paging.CURRENT_COUNT_INDEX}]
    				[{assign var="activeString" value="class='active'"}]
    			[{/if}]				

				<li><a href="#" id="[{$currentCount.INDEX}]" [{$activeString}]>[{oxmultilang ident=$currentCount.INDEX}]</a></li>
			[{/foreach}]	
		</ul>
		[{/if}]
	</div>
	<div class="sitResultNavigationSorts">
		[{if $paging.SORTS}]
		[{assign var="activeText" value=""}]
		[{foreach from=$paging.SORTS item=currentSort}]
    		[{if $currentSort.INDEX == $paging.CURRENT_SORT_INDEX}]
    			[{assign var="activeText" value=$currentSort.INDEX}]
    		[{/if}]				
		[{/foreach}]	
		<span>[{if $activeText}][{oxmultilang ident=$activeText}][{else}][{oxmultilang ident="SIT_NAVIGATION_ARTICLES_SORTING"}][{/if}]</span>
		<ul class="sitDrop">
			[{foreach from=$paging.SORTS item=currentSort}]

				[{assign var="activeString" value=""}]
    			[{if $currentSort.INDEX == $paging.CURRENT_SORT_INDEX}]
    				[{assign var="activeString" value="class='active'"}]
    			[{/if}]				

				<li><a href="#" id="[{$currentSort.INDEX}]" [{$activeString}]>[{oxmultilang ident=$currentSort.INDEX}]</a></li>
			[{/foreach}]	
		</ul>
		[{/if}]
	</div>
	[{/if}]
</div>