[{assign var="oDetailsProduct" value=$oView->getProduct()}]
[{if $oView->showTags() && ( $oView->getTagCloudManager() || ( $oxcmp_user && $oDetailsProduct ) )}]
    [{oxscript include='js/widgets/oxajax.min.js'}]
    [{oxscript include='js/widgets/oxtag.min.js'}]
    [{oxscript add="$('p.tagCloud a.tagText').click(oxTag.highTag);"}]
    [{oxscript add="$('#saveTag').click(oxTag.saveTag);"}]
    [{oxscript add="$('#cancelTag').click(oxTag.cancelTag);"}]
    [{oxscript add="$('#editTag').click(oxTag.editTag);"}]


[{/if}]