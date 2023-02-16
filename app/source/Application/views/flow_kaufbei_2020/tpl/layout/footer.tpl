[{block name="footer_main"}]
    [{assign var="blShowFullFooter" value=$oView->showSearch()}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
    [{$oView->setShowNewsletter($oViewConf->getViewThemeParam('blFooterShowNewsletterForm'))}]

    [{if $oxcmp_user}]
        [{assign var="force_sid" value=$oView->getSidForWidget()}]
    [{/if}]

    <footer id="footer">

    
       
   
        <div class="[{if $blFullwidth}]container[{else}]container[{/if}]">
            <div class="row">
                <div class="col-xs-12 col-md-9">
                    <div class="row">
                        <div class="footer-left-part">
                            [{block name="dd_footer_servicelist"}]
                                <section class="col-xs-12 col-sm-3 footer-box footer-box-service">
                                    <h4 class="h4 footer-box-title">[{oxmultilang ident="SERVICES"}]</h4>
                                    <div class="footer-box-content">
                                        [{block name="dd_footer_servicelist_inner"}]
                                            [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1 force_sid=$force_sid}]
                                        [{/block}]
                                    </div>
                                </section>
                            [{/block}]
                                <section class="col-xs-12 col-sm-3 footer-box footer-box-career">
                                    <h4 class="h4 footer-box-title">KAUFBEI</h4>
                                    <div class="footer-box-content">
                                    <ul class="list-unstyled">
                                    	 <li><a href="[{ oxgetseourl ident="handlerhersteller" type="oxcontent" }]">[{oxmultilang ident="HANDLER_HERSTELLER"}]</a></li>
                                        <li><a href="[{ oxgetseourl ident="tvshoppage" type="oxcontent" }]">[{oxmultilang ident="SATELLITE"}]</a></li>
                                        <li><a href="https://www.kaufbei.tv/ueber-kaufbei/">[{oxmultilang ident="BLOG"}]</a></li>
                                        <li><a href="https://www.kaufbei.tv/ueber-kaufbei/jobs">Jobs</a></li>
                                    </ul>
										
                                    </div>
                                </section>
                            [{block name="dd_footer_information"}]
                                <section class="col-xs-12 col-sm-3 footer-box footer-box-information">
                                    <h4 class="h4 footer-box-title">[{oxmultilang ident="INFORMATION"}]</h4>
                                    <div class="footer-box-content">
                                        [{block name="dd_footer_information_inner"}]
                                            [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1 force_sid=$force_sid}]
                                        [{/block}]
                                    </div>
                                </section>
                            [{/block}]
                           
                                [{block name="dd_footer_manufacturerlist"}]
                                    <section class="col-xs-12 col-sm-3 footer-box">
                                        <h4 class="h4 footer-box-title">[{oxmultilang ident="UNTERWEGS_SCHAUEN"}]</h4>
                                        <div class="footer-box-content">
                                            <div style="margin-bottom: 10px;"><a href="https://play.google.com/store/apps/details?id=tv.bemtv" target="_blank"><img style="max-width: 130px;" alt="BEM TV Google Play" src="/out/flow_kaufbei_2020/img/google-play-app.svg"></a></div>
                                            <div><a href="https://itunes.apple.com/de/app/bem-tv-streaming/id1222920332?mt=8" target="_blank"><img style="max-width: 130px;" alt="BEM TV App Store" src="/out/flow_kaufbei_2020/img/app-store-app.svg"></a></div>
                                        </div>

                                            <div class="whatsapp">
                                                <a target='_blank' href="https://wa.me/4915792360170">
                                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512">
                                                    <g>
                                                        <g>
                                                            <path d="M440.164,71.836C393.84,25.511,332.249,0,266.737,0S139.633,25.511,93.308,71.836S21.473,179.751,21.473,245.263    c0,41.499,10.505,82.279,30.445,118.402L0,512l148.333-51.917c36.124,19.938,76.904,30.444,118.403,30.444    c65.512,0,127.104-25.512,173.427-71.836C486.488,372.367,512,310.776,512,245.263S486.488,118.16,440.164,71.836z     M387.985,336.375L359.67,364.69c-23.456,23.456-90.011-5.066-148.652-63.708c-58.642-58.642-87.165-125.195-63.708-148.652    l28.314-28.314c5.864-5.864,15.372-5.864,21.236,0l35.393,35.393c5.864,5.864,5.864,15.372,0,21.236l-21.236,21.236    c20.599,43.487,55.615,78.502,99.102,99.101l21.236-21.236c5.864-5.864,15.372-5.864,21.236,0l35.393,35.393    C393.849,321.004,393.849,330.511,387.985,336.375z"/>
                                                        </g>
                                                    </g>
                                                </svg>
                                                <h4 class="h4 footer-box-title">WhatsApp</h4>                                             
                                                    <span>+49 1579-2360170</span>
                                                </a>
                                            </div>
                                            <div class="whatsapp">
                                                <a target="_blank" href="https://t.me/Kaufbei_bot">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512"><path d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm121.8 169.9l-40.7 191.8c-3 13.6-11.1 16.9-22.4 10.5l-62-45.7-29.9 28.8c-3.3 3.3-6.1 6.1-12.5 6.1l4.4-63.1 114.9-103.8c5-4.4-1.1-6.9-7.7-2.5l-142 89.4-61.2-19.1c-13.3-4.2-13.6-13.3 2.8-19.7l239.1-92.2c11.1-4 20.8 2.7 17.2 19.5z"></path></svg>
                                                    <h4 class="h4 footer-box-title">Telegram</h4>
                                                    <span>t.me/Kaufbei_bot</span>
                                                </a>
                                            </div>

                                    </section>
                                [{/block}]
                            
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-md-3">
                    <div class="row">
                        <div class="footer-right-part">
                            <div class="col-xs-12 col-sm-12 col-sm-offset-0">
                                [{if $oView->showNewsletter()}]
                                    <section class="footer-box footer-box-newsletter">
                                        <h4 class="h4 footer-box-title">[{oxmultilang ident="NEWSLETTER"}]</h4>
                                        <div class="footer-box-content">
                                            [{block name="dd_footer_newsletter"}]
                                                <p class="small">[{oxmultilang ident="FOOTER_NEWSLETTER_INFO"}]</p>
                                                <p class="small">[{oxmultilang ident="FOOTER_NEWSLETTER_INFO_SECOND"}]</p>
                                                [{include file="widget/footer/newsletter.tpl"}]
                                            [{/block}]
                                        </div>
                                    </section>
                                    <div class="footer--contacts-box">
                                        <span><i class="far fa-map-marker-alt"></i>Oeynhausener Str. 54, 32584 Löhne</span>
                                        <a href="mailto:post@kaufbei.tv"><i class="far fa-envelope"></i>post@kaufbei.tv
                                        </a>
                                        <a href="tel:057312451590"><i class="fal fa-mobile"></i>05731-245 15 90</a>
                                        <span style="line-height: 18px; margin-top: 5px;"><i class="far fa-clock"></i>[{oxmultilang ident="FOOTER_TELEFONISCH"}]<br>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[{oxmultilang ident="FOOTER_UHR_ZEITEN"}]</span>
                                    </div>
                                [{/if}]
                                [{if ($oView->isActive('FbLike') && $oViewConf->getFbAppId())}]
                                    <section class="footer-box footer-box-facebook">
                                        [{block name="footer_fblike"}]
                                            [{if $oView->isActive('FbLike') && $oViewConf->getFbAppId()}]
                                                <div class="facebook pull-left" id="footerFbLike">
                                                    [{include file="widget/facebook/enable.tpl" source="widget/facebook/like.tpl" ident="#footerFbLike" parent="footer"}]
                                                </div>
                                            [{/if}]
                                        [{/block}]
                                    </section>
                                [{/if}]
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      


        [{if $oView->isPriceCalculated()}]
        [{block name="layout_page_vatinclude"}]
        [{block name="footer_deliveryinfo"}]
        [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
        [{/oxifcontent}]
        [{/block}]
        [{/block}]
        [{/if}]
        <div class="container check-size">
            <div class="row">
                [{if $oView->getClassName()  == "alist"}]
                    <div class="col-xs-6 col-sm-3 col-md-2 alist check-size-product-container">
                        <div class="check-size-product-container-inner"></div>
                    </div>
                    [{else}]
                    <div class="col-xs-12 col-sm-6 col-md-3 check-size-product-container">
                        <div class="check-size-product-container-inner"></div>
                    </div>
                    <div class="col-xs-12 co-sm-12 col-sm-9">
                        <div class="row">
                            <div class="col-xs-6 col-sm-4 col-md-3 check-size-with-topcat">
                                <div class="check-size-product-container-topcat"></div>
                            </div>
                        </div>    
                    </div>
                [{/if}]
            </div>
        </div>
        <script type="text/javascript">
            (function(e,t,o,n,p,r,i){e.visitorGlobalObjectAlias=n;e[e.visitorGlobalObjectAlias]=e[e.visitorGlobalObjectAlias]||function(){(e[e.visitorGlobalObjectAlias].q=e[e.visitorGlobalObjectAlias].q||[]).push(arguments)};e[e.visitorGlobalObjectAlias].l=(new Date).getTime();r=t.createElement("script");r.src=o;r.async=true;i=t.getElementsByTagName("script")[0];i.parentNode.insertBefore(r,i)})(window,document,"https://diffuser-cdn.app-us1.com/diffuser/diffuser.js","vgo");
            vgo('setAccount', '1000428378');
            vgo('setTrackByDefault', true);
    
            vgo('process');
        </script>
    </footer>

    <i class="fa fa-angle-up" id="jumptotop"></i>



    [{oxifcontent ident="oxstdfooter" object="oCont"}]
        <div class="legal">
            <div class="container">
                    <div class="row">


						<div class="col-sm-4 copyright">
							<span>
							[{block name="dd_footer_copyright"}]
								[{oxifcontent ident="oxstdfooter" object="oCont"}]
									[{$oCont->oxcontents__oxcontent->value}]
								[{/oxifcontent}]
							[{/block}]
							</span>
						</div>
						<div class="col-sm-3 social-links">
                        [{* <<START>> Social Links *}]
                        [{block name="dd_footer_social_links"}]
                            [{if $oViewConf->getViewThemeParam('sFacebookUrl') || $oViewConf->getViewThemeParam('sGooglePlusUrl') || $oViewConf->getViewThemeParam('sTwitterUrl') || $oViewConf->getViewThemeParam('sYouTubeUrl') || $oViewConf->getViewThemeParam('sBlogUrl')}]
                                <div class="bottom--social-box">
                                                [{block name="dd_footer_social_links_inner"}]
                                                        [{block name="dd_footer_social_links_list"}]
                                                            [{if $oViewConf->getViewThemeParam('sFacebookUrl')}]
                                                                    <a class="fb" target="_blank" href="[{$oViewConf->getViewThemeParam('sFacebookUrl')}]"><i class="fab fa-facebook-f"></i></a>
                                                            [{/if}]
                                                            [{if $oViewConf->getViewThemeParam('sOdnoklassnikiUrl')}]
                                                                    <a class="ok" target="_blank" href="[{$oViewConf->getViewThemeParam('sOdnoklassnikiUrl')}]"><i class="fab fa-odnoklassniki-square"></i></a>
                                                            [{/if}]
                                                            [{if $oViewConf->getViewThemeParam('sInstagramUrl')}]
                                                                    <a class="instagram" target="_blank" href="[{$oViewConf->getViewThemeParam('sInstagramUrl')}]"><i class="fab fa-instagram"></i></a>
                                                            [{/if}]
                                                            [{if $oViewConf->getViewThemeParam('sYouTubeUrl')}]
                                                                    <a class="yb" target="_blank" href="[{$oViewConf->getViewThemeParam('sYouTubeUrl')}]">
                                                                        <i class="fab fa-youtube"></i>
                                                                    </a>
                                                            [{/if}]
                                                            [{if $oViewConf->getViewThemeParam('sTwitterUrl')}]
                                                                    <a class="tw" target="_blank" href="[{$oViewConf->getViewThemeParam('sTwitterUrl')}]">
                                                                        <i class="fab fa-twitter"></i>
                                                                    </a>
                                                            [{/if}]
                                                            [{if $oViewConf->getViewThemeParam('sTikTokUrl')}]

                                                                <a class="tiktok" style="padding-top: 3px;" target="_blank" href="[{$oViewConf->getViewThemeParam('sTikTokUrl')}]">
                                                                    <svg style="max-width: 24px;" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                                         viewBox="0 0 48 48" style="enable-background:new 0 0 48 48;" xml:space="preserve">
                                                                    <path style="fill:#FFFFFF;" d="M38.4,21.7V16c-2.7,0-4.7-0.7-6-2.1c-1.3-1.6-2.1-3.6-2.1-5.6V7.9l-5.4-0.1c0,0,0,0.2,0,0.5v22.5
                                                                        c-0.5,2.7-3.1,4.5-5.8,4c-2.7-0.5-4.5-3.1-4-5.8c0.5-2.7,3.1-4.5,5.8-4c0.3,0,0.5,0.1,0.8,0.2v-5.5c-0.6-0.1-1.1-0.1-1.7-0.1
                                                                        c-5.7,0-10.4,4.6-10.4,10.4S14.2,40.3,20,40.3s10.4-4.6,10.4-10.4c0-0.4,0-0.8-0.1-1.3v-9.1C32.7,21,35.5,21.8,38.4,21.7z"/>
                                                                    </svg>
                                                                </a>

                                                            [{/if}]
                                                            <a class="tg" target="_blank" href="https://t.me/kaufbei">
                                                                <i class="fab fa-telegram"></i>
                                                            </a>
                                                        [{/block}] 
                                                [{/block}]
                                </div>
                            [{/if}]
                        [{/block}]
                        [{* <<ENDE>> Social Links *}]
                    	</div>
						<div class="col-sm-5 legal--payment-box">
							<img src="[{$oViewConf->getImageUrl()}]payment-list.png" alt="Payment List">
                        </div>
                      
                    </div>
            </div>
        </div>
    [{/oxifcontent}]

[{/block}]
</div>
<div class="login-box--wrapper">
    <div class="login-box--container">
        <div class="login-box--container-inner">
        [{include file="widget/header/loginbox.tpl"}]
        </div>
    </div>
</div>
<div class="profile-box--wrapper">
    <div class="profile-box--container">
        <div class="profile-box--container-inner">
            [{block name="dd_layout_page_header_icon_menu_account"}]
                                            [{if $oxcmp_user || $oView->getCompareItemCount() || $Errors.loginBoxErrors}]
                                                [{assign var="blAnon" value=0}]
                                                [{assign var="force_sid" value=$oViewConf->getSessionId()}]
                                            [{else}]
                                                [{assign var="blAnon" value=1}]
                                            [{/if}]
                                            [{* Account Dropdown *}]
                                            [{oxid_include_widget cl="oxwServiceMenu" _parent=$oView->getClassName() force_sid=$force_sid nocookie=$blAnon _navurlparams=$oViewConf->getNavUrlParams() anid=$oViewConf->getActArticleId()}]
             [{/block}]
        </div>
     </div>
</div>
<div class="cart-box--wrapper">
    <div class="cart-box--container">
        <div class="cart-box--container-inner">
        [{oxid_include_dynamic file="widget/minibasket/minibasket.tpl"}]
        </div>
    </div>
</div>
<div class="callback-box--wrapper"> 
    <div class="callback-box--container">
        <div class="callback-box--container-inner">
             <form class="form form--validation" id="callback" name="callback" action="/callback.php" method="post">
                <span class="lead popup-form-title">[{oxmultilang ident="DD_PLAESE_CALL_BACK"}]</span>
                <div class="form-group">
                <label for="inputName">[{oxmultilang ident="DD_FIRSNAME"}]</label>
                <input id="inputName" type="text" name="inputName" class="form-control" placeholder="[{oxmultilang ident="DD_FIRSNAME"}]">
            </div>
            <div class="form-group">
                    <label for="inputPhone">[{oxmultilang ident="DD_PHONE"}]</label>
                    <input id="inputPhone" type="tel" name="inputPhone" class="form-control required" placeholder="[{oxmultilang ident="DD_PHONE"}]"> 
            </div>
            <div class="messenger"> </div>
            <div class="popup-button-container">
                <button type="submit" class="btn btn-primary">[{oxmultilang ident="DD_PLAESE_CALL_BACK"}]</button>
            </div>
             </form>
        </div>
    </div>
</div>

                        <style>


							.ui-autocomplete{
								position: absolute;
								top: 100% !important;
								right: 0 !important;
								background: #fff;
								padding: 15px 0 0;
								border-top: 2px solid #F2F2F2;
								border-radius: 0 !important;
								list-style: none;
							    box-shadow: 0 1px 1px 0 rgba(0,0,0,.2);
								z-index: 7777!important;
								
								max-height: 0;
								transition: max-height 0.15s ease-out;
								overflow: hidden;
							}
							
							.ui-autocomplete.opened{
								height: auto;
							}
							
							.ui-autocomplete li{
								margin-bottom: 0 !important;
							}
							
							.ui-autocomplete a{
								padding: 5px 20px;
								display: block;
							}
							
							.ui-autocomplete a:hover{
								text-decoration: none !important;
								background: #f9f9f9 !important;
								color: inherit !important;
							}
							
							.ui-autocomplete a:hover table b{
								color: #87B144 !important;
							}
							
							.ui-autocomplete table th{
								vertical-align: middle;
							}
							
							.ui-autocomplete .img-result{
								max-width: 70px;
								max-height: 70px;
								min-width: 70px;
								min-height: 70px;
								border: 2px solid #F1F1F1;
								margin-right: 15px;
								display: block;
								overflow: hidden;
							}
							
							.ui-autocomplete .img-result img{
								width: 100%;
								max-width: 70px;
							}
							
							.ui-autocomplete label{
								display: block;
								margin-top: 5px;
							}
							
							.ui-autocomplete table td b{
								font-size: 18px;
							}
							
							.ui-autocomplete td span{
								color: #87B144;
							}
							
							.search--result-f-count b{
								font-weight: 400;
							}
							
							.ui-autocomplete li{
								margin-bottom: 10px;
							}
							form.search .form-control{
								border-radius: 20px 20px 0 0;
							}
							.ui-helper-hidden-accessible{
								display: none;
							}
							.search--result-f{
								display: flex;
								align-items: center;
								justify-content: space-between;
								background: #F3F3F4;
								padding: 20px;
								margin: 10px 0 0 !important;
								border-radius: 0 0 20px 20px;
							}
							
							.search--result-f .search--result-f-count{
								color: #979797;
								font-size: 18px;
							}
							.search--result-f .search--result-f-all{
								color: #87B144;
								font-size: 22px;
								text-decoration: none;
								font-weight: 500;
								cursor: pointer;
								border-bottom: 1px solid transparent;
								transition: border-bottom .15s ease;
							}
							
							.search--result-f .search--result-f-all:hover{
								border-bottom: 1px solid #ddd;
							}
							
							@media (max-width: 767px) {
								.m-search-container{
									position: static !important;
								}
								.ui-autocomplete{
									left: 10px !important;
									right: 10px !important;
									padding: 10px 0 0;
									width: auto !important;
									max-width: 767px !important;
								}
								.ui-autocomplete a{
									padding: 5px 10px;
									display: block;
								}
								.ui-autocomplete .img-result{
									margin-right: 10px;
								}
								.ui-autocomplete label{
									display: none;
								}
								form.search .form-control{
									border-radius: 20px !important;
								}
								.search--result-f{
									padding: 10px;
									margin: 0 -10px;
									border-radius: 0 0 20px 20px;
									flex-flow: wrap;
								}
								.search--result-f .search--result-f-count{
									font-size: 14px;
									margin-bottom: 5px;
									display: block;
									width: 100%;
								
								}
								.ui-autocomplete table td b{
									font-size: 14px;
									line-height: 16px;
								}
								
								.search--result-f .search--result-f-all{
									font-size: 16px;
								}
							}
						</style>
[{if $oView->isRootCatChanged()}]
    <div id="scRootCatChanged" class="popupBox corners FXgradGreyLight glowShadow">
        [{include file="form/privatesales/basketexcl.tpl"}]
    </div>
[{/if}]
