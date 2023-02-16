[{if $oxcmp_user}]
    [{assign var="noticeListCount" value=$oxcmp_user->getNoticeListArtCnt()}]
    [{assign var="wishListCount" value=$oxcmp_user->getWishListArtCnt()}]
    [{assign var="recommListCount" value=$oxcmp_user->getRecommListsCount()}]
[{else}]
    [{assign var="noticeListCount" value="0"}]
    [{assign var="wishListCount" value="0"}]
    [{assign var="recommListCount" value="0"}]
[{/if}]
[{math equation="a+b+c+d" a=$oView->getCompareItemsCnt() b=$noticeListCount c=$wishListCount d=$recommListCount assign="notificationsCounter"}]

<div class="service-menu">
   
 
        [{block name="dd_layout_page_header_icon_menu_account_list"}]
           
                <div class="row">
                    <div class="[{if !$oxcmp_user}]col-xs-12 col-sm-5[{else}]col-xs-12[{/if}] pull-right">
                        <div class="service-menu-box clearfix">
                            [{include file="widget/header/servicebox.tpl"}]
                            [{if $oxcmp_user}]
                                
                            
                            <div class="popup-button-container align-right">
                            
                                <a class="btn btn-default" role="button" href="[{$oViewConf->getLogoutLink()}]" title="[{oxmultilang ident="LOGOUT"}]">
                                        <i class="fa fa-power-off"></i> [{oxmultilang ident="LOGOUT"}]
                                    </a>
                            </div>
                            [{/if}]
                        </div>
                    </div>
                    
                </div>
         
        [{/block}]
  
</div>