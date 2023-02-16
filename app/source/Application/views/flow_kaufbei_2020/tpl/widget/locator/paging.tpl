[{block name="widget_locator_paging"}]
    [{if $pages->changePage}]
        <ol class="pagination pagination-sm[{if $place eq "bottom"}] lineBox[{/if}]" id="itemsPager[{$place}]">
            <li class="prev[{if !$pages->previousPage}] disabled[{/if}]">
                [{if $pages->previousPage}]
                    <a href="[{$pages->previousPage}]" class="btn"><span class="kiconk-icon-arrow-left"></span></a>
                [{else}]
                    
                [{/if}]
            </li>

            [{assign var="i" value=1}]

            [{foreach key=iPage from=$pages->changePage item=page}]

                [{if $iPage == $i}]
                    <li[{if $iPage == $pages->actPage}] class="active"[{/if}]>
                        [{if $iPage == $pages->actPage}]
                            <span>[{$iPage}]</span>
                        [{else}]
                            <a href="[{$page->url}]" class="btn">[{$iPage}]</a>
                        [{/if}]
                    </li>
                   [{assign var="i" value=$i+1}]
                [{elseif $iPage > $i}]
                    <li class="disabled">
                        <span>...</span>
                    </li>
                    <li[{if $iPage == $pages->actPage}] class="active"[{/if}]>
                        <a href="[{$page->url}]" class="btn">[{$iPage}]</a>
                    </li>
                    [{assign var="i" value=$iPage+1}]
                [{elseif $iPage < $i}]
                    <li[{if $iPage == $pages->actPage}] class="active"[{/if}]>
                        <a href="[{$page->url}]" class="btn">[{$iPage}]</a>
                    </li>
                    <li class="disabled">
                        <span>...</span>
                    </li>
                   [{assign var="i" value=$iPage+1}]
                [{/if}]
            [{/foreach}]

            <li class="next[{if !$pages->nextPage}] disabled[{/if}]">
                [{if $pages->nextPage}]
                    <a href="[{$pages->nextPage}]" class="btn"><span class="kiconk-icon-arrow-right"></span></a>
                [{else}]
                   
                [{/if}]
            </li>
         </ol>
    [{/if}]
[{/block}]