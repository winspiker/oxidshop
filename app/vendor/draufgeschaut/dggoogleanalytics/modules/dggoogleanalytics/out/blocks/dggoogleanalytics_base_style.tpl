[{* |layout/base.tpl|base_style|dggoogleanalytics_base_style.tpl|1| *}]
[{ $smarty.block.parent }]

[{capture name=dgAddGogleanAnaytics}][{/capture}] 

[{ insert name="dggoogleanalytics" cookiename="_ga" position="top" add=$smarty.capture.dgAddGogleanAnaytics }]

[{assign var="oConf" value=$oView->getConfig()}]

[{ if $oConf->getConfigParam('dgFaceBookRemaketingActive')}]
  [{ insert name="dgfacebookpixel" cookiename="_fbp" position="top" add="" }]
[{/if}]

[{ if $oConf->getConfigParam('dgCriteoActive')}]
  [{ insert name="dgcriteo" cookiename="_ceg*" position="top" add="" }]
[{/if}]

[{ if $oConf->getConfigParam('dgBingOrderActive')}]
  [{ insert name="dgbing" cookiename="" position="top" add="" }]
[{/if}]


[{ if $oConf->getConfigParam('dgGoogleAddWordActive')}]
  [{ insert name="dgadwords" cookiename="_gac*" position="top" add="" }]
[{/if}]

[{ if $oConf->getConfigParam('dgGoogleTagManagerActive')}]
  [{ insert name="dgtagmanager" cookiename="" position="top" add="" }]
[{/if}]