[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{if $oDetailsProduct->oxarticles__oxfile->value}]
    <a id="productFile" href="[{$oConfig->getPictureUrl('media/')}][{$oDetailsProduct->oxarticles__oxfile->value}]">[{$oDetailsProduct->oxarticles__oxfile->value}]</a>
[{/if}]

[{if $oView->getMediaFiles()}]
    [{foreach from=$oView->getMediaFiles() item="oMediaUrl" name="mediaURLs"}]
        [{assign var="sUrl" value=$oMediaUrl->oxmediaurls__oxurl->value}]
        [{assign var="blIsYouTubeMedia" value=false}]
        [{if $sUrl|strpos:'youtube.com' || $sUrl|strpos:'youtu.be'}]
            [{assign var="blIsYouTubeMedia" value=true}]
            
            [{if $oMediaUrl->oxmediaurls__oxdesc->value !=''}]
                <div id="media_youtube">
                    <div class="h2 page-header page-header--title" style="margin-bottom: 20px;">[{$oMediaUrl->oxmediaurls__oxdesc->value}]</div>
                    [{$oMediaUrl->getHtml()}]
                </div>
                <br>
            [{/if}]
        [{/if}]
    [{/foreach}]
[{/if}]