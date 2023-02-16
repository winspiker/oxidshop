[{block name="widget_header_search_form"}]
    [{if $oView->showSearch()}]
        <form class="form search" action="[{$oViewConf->getSelfActionLink()}]" method="get" name="search">
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="cl" value="search">
            [{block name="dd_widget_header_search_form_inner"}]
                <div class="input-group">
                    [{block name="header_search_field"}]
                        <div class="form-control">
                        <i class="fa fa-search"></i><input type="text" id="searchParam" name="searchparam" value="[{$oView->getSearchParamForHtml()}]" placeholder="[{oxmultilang ident="SEARCH"}]">
                        
                        </div>
                    [{/block}]
                    [{block name="dd_header_search_button"}]
                        <button type="submit" class="btn btn-search" title="[{oxmultilang ident="SEARCH_SUBMIT"}]">
                            <span>[{oxmultilang ident="SEARCH_SUBMIT"}]</span>
                        </button>
                    [{/block}]
                </div>
            [{/block}]
        </form>
    [{/if}]
[{/block}]