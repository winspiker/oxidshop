[{block name="dd_widget_sidebar_news"}]
    <div id="newsBox" class="box well well-sm" style="display: none;">
        <section class="sidebar--news">
            <div class="page-header h3">[{oxmultilang ident="NEWS"}]</div>
            [{block name="dd_widget_sidebar_news_inner"}]
                <ul class="content">
                    [{block name="dd_widget_sidebar_news_list"}]
                        [{foreach from=$oNews item="_oNewsItem" name="_sNewsList"}]
                            <li class="block-shadow">
                                 <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=news"}]#[{$_oNewsItem->oxnews__oxid->value}]" class="sidebar--news-title">[{oxmultilang ident="LATEST_NEWS_AND_UPDATES_AT"}] [{$oxcmp_shop->oxshops__oxname->value}]</a>
                                <span class="sidebar--news-desc">[{$_oNewsItem->getLongDesc()|strip_tags|oxtruncate:200}]</span>
                            </li>
                        [{/foreach}]
                    [{/block}]
                </ul>
            [{/block}]
        </section>
    </div>
[{/block}]

