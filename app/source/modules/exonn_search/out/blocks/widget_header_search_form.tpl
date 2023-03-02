
[{oxstyle include=$oViewConf->getModuleUrl('exonn_search', "out/front/css/jquery-ui.css")}]
[{oxscript include=$oViewConf->getModuleUrl('exonn_search', 'out/front/js/live-search.js')}]

<form class="form search" id="exonnsearch" action="[{ $oViewConf->getSelfActionLink() }]" method="get" name="search">
    <div class="searchBox">
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="cl" value="exonn_search_controller">

        [{block name="dd_widget_header_search_form_inner"}]
        <div class="input-group searchBox">
            [{block name="header_search_field"}]
            <div class="form-control">
                <input
                        type="text"
                        id="searchParam"
                        name="searchparam"
                        value="[{$oView->getSearchParamForHtml()}]"
                        placeholder="[{oxmultilang ident="SEARCH"}]"
                >
            </div>
            [{/block}]

            [{block name="dd_header_search_button"}]
            <button type="submit" class="btn btn-search searchSubmit" title="[{oxmultilang ident="SEARCH_SUBMIT"}]">
                <i class="far fa-search"></i>
            </button>

            [{/block}]
        </div>
        [{/block}]

    <div id="result"></div>
    </div>
</form>
