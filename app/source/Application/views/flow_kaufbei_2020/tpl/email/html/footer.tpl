                                    <table class="row footer" width="100%">
                                        <tr bgcolor="#ebebeb">
                                            <td class="wrapper">
                                                <table class="six columns">
                                                    <tr>
                                                        <td class="left-text-pad">
                                                            <h5>[{oxmultilang ident="DD_FOOTER_CONTACT_INFO"}]</h5>
                                                            [{oxcontent ident="oxemailfooter"}]
                                                        </td>
                                                        <td class="expander"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            [{if $oViewConf->getViewThemeParam('sFacebookUrl') || $oViewConf->getViewThemeParam('sGooglePlusUrl') || $oViewConf->getViewThemeParam('sTwitterUrl') || $oViewConf->getViewThemeParam('sYouTubeUrl') || $oViewConf->getViewThemeParam('sBlogUrl')}]
                                                <td class="wrapper last">
                                                    <table class="six columns">
                                                        <tr>
                                                            <td class="right-text-pad">

                                                               <div style="white-space: nowrap;">Besuchen Sie uns auch auf: </div>
																<div style="text-align: center; margin-top: 5px;">
																
 <a class="fb" title="Facebook" target="_blank" href="https://www.facebook.com/kaufebei.tv" style="display: inline-block;"> <img width="30" src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/icon-facebook.png" alt="facebook"> 
 </a> <a class="ok" target="_blank" href="https://ok.ru/group/55403353931807" style="display: inline-block;"> <img  width="30" src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/icon-ok.png" alt="odnoklassniki"> </a> <a class="instagram" target="_blank" href="https://www.instagram.com/kaufbei.tv/" style="display: inline-block;"> <img  width="30" src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/icon-insta.png" alt="instagram"> </a> <a  class="yb" target="_blank" href="https://www.youtube.com/channel/UCLbEHm0iCE60DBJrRafu-Iw" style="display: inline-block;"> <img  width="30" src="https://www.kaufbei.tv/out/flow_kaufbei_2020/img/icon-youtube.png" alt="youtube"> </a> 
 
																</div>
                                                            </td>
                                                            <td class="expander"></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            [{/if}]
                                        </tr>
                                    </table>


                                    <table class="row">
                                        <tr>
                                            <td class="wrapper last">

                                                <table class="twelve columns">
                                                    <tr>
                                                        <td align="left">
                                                            [{*ToDo*}]
                                                        </td>
                                                        <td class="expander"></td>
                                                    </tr>
                                                </table>

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>


                    </center>
                </td>
            </tr>
        </table>
    </body>
</html>