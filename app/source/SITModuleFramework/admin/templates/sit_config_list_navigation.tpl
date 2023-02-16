[{math a=$count b=20 equation="round((a / b) + .49)" assign="pages"}]

[{if $pages > 0}]
    <div class="navigation">Seite</div>
[{/if}] 
[{if $page > 0}]
	<a id="navfirst" href="0" class="navigation">&laquo;&laquo; </a>
	<a id="navprevious" href="[{$page-1}]" class="navigation">&laquo; | </a> 
[{/if}]


[{assign var="y" value=0}]
[{math a=$page b=5 equation="a-b" assign="start"}]
	
[{if $start < 0}]
	[{assign var="start" value=0}]
[{/if}]

[{section name=navigation loop=10}]
	
	[{if $smarty.section.navigation.iteration <= $pages}] 
		<a id="nav[{$start}]" href="[{$start}]" class="navigation[{if $start == $page}] active[{/if}]">[{$start+1}]</a>
    	[{assign var="start" value=$start+1}]
    [{/if}]
    
[{/section}]
	
[{if $page < ($pages-1)}]
	<a id="navnext" href="[{$page+1}]" class="navigation"> | &raquo;</a>
	<a id="navlast" href="[{$pages-1}]" class="navigation"> &raquo;&raquo;</a>
[{/if}]

[{*
	if ( (pages - parseInt(currentPage)) > 10 ) {
		htmlNavigation += '<a id="navprevious" href="'+ ( parseInt(currentPage) + 10 ) +'" class="navigation right"> | + 10</a> ';
	}
	else {
		htmlNavigation += '<a href="#" onclick="return false;" class="navigation right"> | + 10</a> ';
	}
	
	if (pages >= 50) {
		if ( (pages - parseInt(currentPage)) > 50 ) {
			htmlNavigation += '<a id="navprevious" href="'+ ( parseInt(currentPage) + 50 ) +'" class="navigation right"> | + 50</a> ';
		}
		else {
			htmlNavigation += '<a href="#" onclick="return false;" class="navigation right"> | + 50</a> ';	
		}
	}
	
	if (pages >= 100) {
		if ( (pages - parseInt(currentPage)) > 100 ) {
			htmlNavigation += '<a id="navprevious" href="'+ ( parseInt(currentPage) + 100 ) +'" class="navigation right"> | + 100</a> ';
		}
		else {
			htmlNavigation += '<a href="#" onclick="return false;" class="navigation right"> | + 100</a> ';
		}
	}
	
	htmlNavigation += '<a href="#" onclick="return false;" class="navigation right">__</a> ';
	
	if (pages >= 100) {
		if ( currentPage >= 100 ) {
			htmlNavigation += '<a id="navprevious" href="'+ (  parseInt(currentPage) - 100 ) +'" class="navigation right">- 100 | </a> ';
		}
		else {
			htmlNavigation += '<a href="#" onclick="return false;" class="navigation right">- 100 | </a> ';
		}
	}
	
	if (pages >= 50) {
		if ( currentPage >= 50 ) {
			htmlNavigation += '<a id="navprevious" href="'+ ( parseInt(currentPage) - 50 ) +'" class="navigation right">- 50 | </a> ';
		}
		else {
			htmlNavigation += '<a href="#" onclick="return false;" class="navigation right">- 50 | </a> ';
		}
	}
	
	if ( currentPage >= 10 ) {
		htmlNavigation += '<a id="navprevious" href="'+ ( parseInt(currentPage) - 10 ) +'" class="navigation right">- 10 | </a> ';
	}
	else {
		htmlNavigation += '<a href="#" onclick="return false;" class="navigation right">- 10 | </a> ';
	}
	*}]