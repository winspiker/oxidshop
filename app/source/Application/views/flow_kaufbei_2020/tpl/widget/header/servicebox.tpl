<div class="topPopList">
    [{block name="widget_header_servicebox_flyoutbox"}]
        <span class="lead popup-form-title">[{oxmultilang ident="ACCOUNT"}]</span>
        <div class="flyoutBox">
            <ul id="services" class="list-unstyled">
                [{block name="widget_header_servicebox_items"}]





                    <li>
                        <a class="btn btn-default" href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account"}]"><i class="far fa-user"></i><span>[{oxmultilang ident="MY_ACCOUNT"}]</span></a>
                    </li>

                    <li>
                        <a class="btn btn-default" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist"}]"><i class="far fa-file-edit"></i><span>[{oxmultilang ident="MY_WISH_LIST"}]</span>[{if $oxcmp_user && $oxcmp_user->getNoticeListArtCnt()}] <span class="badge">[{$oxcmp_user->getNoticeListArtCnt()}]</span>[{/if}]</a>
                    </li>
                    [{if $oViewConf->getShowWishlist()}]
                    <li>
                        <a class="btn btn-default" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_wishlist"}]"><i class="far fa-heart"></i><span>[{oxmultilang ident="MY_GIFT_REGISTRY"}]</span>[{if $oxcmp_user && $oxcmp_user->getWishListArtCnt()}] <span class="badge">[{$oxcmp_user->getWishListArtCnt()}]</span>[{/if}]</a>
                    </li>
                    [{/if}]
                    [{if $oViewConf->getShowListmania()}]
                    <li>
                        <a class="btn btn-default" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_recommlist"}]"><i class="far fa-star"></i><span>[{oxmultilang ident="MY_LISTMANIA"}]</span>[{if $oxcmp_user && $oxcmp_user->getRecommListsCount()}] <span class="badge">[{$oxcmp_user->getRecommListsCount()}]</span>[{/if}]</a>
                    </li>
                    [{/if}]

                [{/block}]
            </ul>
        </div>
    [{/block}]
</div>