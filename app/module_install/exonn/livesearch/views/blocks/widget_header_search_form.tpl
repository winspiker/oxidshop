[{assign var="config" value=$oViewConf->getConfig()}]
[{assign var="icon_classes" value=$config->getConfigParam('EXONN_LIVESEARCH_SEARCH_ICON_CLASSES')}]
[{oxstyle include=$oViewConf->getModuleUrl('exonn_livesearch', "views/front/css/jquery-ui.css")}]
[{oxscript include="js/widgets/oxinnerlabel.js" priority=10 }]
[{oxscript include=$oViewConf->getModuleUrl('exonn_livesearch', "views/front/js/livesearch.js") priority=11}]
[{*oxscript add="$( '#searchParam' ).oxInnerLabel();"*}]

<form class="form search" id="exonnsearch" action="[{$oViewConf->getSelfActionLink()}]" method="get" name="search">
    <div class="searchBox">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="exonn_livesearch_controller">

        [{block name="dd_widget_header_search_form_inner"}]
            <div class="input-group searchBox">
                [{block name="header_search_field"}]
                    <input
                        type="text"
                        id="searchParam"
                        class="form-control"
                        name="searchparam"
                        value="[{$oView->getSearchParamForHtml()}]"
                        placeholder="[{oxmultilang ident="SEARCH"}]"
                        data-action="[{$oViewConf->getSelfActionLink()}]"
                    >
                [{/block}]

                [{block name="dd_header_search_button"}]
                    <span class="input-group-btn">
                        <button
                            type="submit"
                            class="btn btn-search searchSubmit"
                            title="[{oxmultilang ident="SEARCH_SUBMIT"|oxescape:quote}]"
                        >
                            <i class="[{$icon_classes|oxescape:quotes}]"></i>
                        </button>
                    </span>
                [{/block}]
            </div>
        [{/block}]
    </div>
</form>

