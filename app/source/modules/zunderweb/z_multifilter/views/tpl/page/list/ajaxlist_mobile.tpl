[{*Listview for Ajax calls*}]
[{capture name="content" assign="content"}]
[{include file=$oViewConf->getModulePath('z_multifilter',"views/tpl/widget/multifilter/z_multifilter_list_mobile.tpl") attributes=$oView->getAttributes()}]
    [{if !$blFilterOpen}]
        [{assign var="blFilterOpen" value=$oView->getShowFilter()}]
    [{/if}]
    [{oxscript add="$('div.dropdown').oxDropDown();"}]
    [{oxscript include="js/widgets/oxattribute.js" priority=10 }]
    [{oxscript add="$('#filterItems').oxAttribute({blShowFilter:'$blFilterOpen'});"}]
    [{oxscript add="$('#sortItems').oxAttribute({blShowFilter:'$blFilterOpen'});"}]
    [{oxscript}]
[{/capture}]
[{capture name="filters" assign="filters"}]
    [{include file=$oViewConf->getModulePath('z_multifilter',"views/tpl/widget/multifilter/z_multifilter_sidebar_mobile.tpl") attributes=$oView->getAttributes()}]
    [{oxscript}]
[{/capture}]
[{$oView->toJson('content',$content)}]
[{$oView->toJson('filters',$filters)}]
[{$oView->outputJson()}]