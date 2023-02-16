<ul class="sitResultsMain" id="[{$containerId}]">

	[{foreach from=$oArticleList item=oArticle}]
		[{include file="multifilter_article.tpl" oArticle=$oArticle}]
	[{/foreach}]

</ul>