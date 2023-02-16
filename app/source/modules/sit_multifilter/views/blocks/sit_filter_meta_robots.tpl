[{if $smarty.get.setFilter == 1}]
	<meta name="robots" content="noindex,follow">
[{else}]
	[{$smarty.block.parent}]
[{/if}]