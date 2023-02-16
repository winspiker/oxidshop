[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{if $oView->morePics()}]
    <div class="otherPictures--container">
        [{assign var="iMorePics" value=$oView->getIcons()|@count}]
        <div class="swiper-container-more-pics otherPictures" id="morePicsContainer">
            <ul class="swiper-wrapper [{if $iMorePics < 5}] morePicsSmall[{/if}]">
                [{oxscript add="var aMorePic=new Array();"}]
                [{foreach from=$oView->getIcons() key="iPicNr" item="oArtIcon" name="sMorePics"}]
                [{assign var="aPictureInfo" value=$oPictureProduct->getMasterZoomPictureUrl($iPicNr)|@getimagesize}]
                <li class="swiper-slide">
                    <a id="morePics_[{$smarty.foreach.sMorePics.iteration}]" [{if $smarty.foreach.sMorePics.first}] class="selected"[{/if}] href="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]" data-num="[{$smarty.foreach.sMorePics.iteration}]"[{if $aPictureInfo}] data-width="[{$aPictureInfo.0}]" data-height="[{$aPictureInfo.1}]"[{/if}] data-zoom-url="[{$oPictureProduct->getMasterZoomPictureUrl($iPicNr)}]">
                        [{* tabslImageTags 3.0.1 - START *}]
                        [{assign var="sImage" value="oxarticles__tabsl_imagetag"|cat:$iPicNr}]
                        [{*<img src="[{$oPictureProduct->getIconUrl($iPicNr)}]" alt="morepic-[{$smarty.foreach.sMorePics.iteration}]">*}]
                        <img src="[{$oPictureProduct->getIconUrl($iPicNr)}]" title="[{$oPictureProduct->getTabslImageTag($oPictureProduct->$sImage->value) }]" alt="[{$oPictureProduct->getTabslImageTag($oPictureProduct->$sImage->value) }]">
                        [{* tabslImageTags 3.0.1 - END *}]
                    </a>
                </li>
                [{/foreach}]
            </ul>
            <button type="button" class="swiper-button-prev"><i class="far fa-long-arrow-left"></i></button>
            <button type="button" class="swiper-button-next"><i class="far fa-long-arrow-right"></i></button>
        </div>
    </div>
    [{/if}]