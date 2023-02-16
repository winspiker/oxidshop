[{* |layout/base.tpl|base_style|dggoogleanalytics_base_style.tpl|1| *}]
[{ $smarty.block.parent }]

[{capture name=dgAddGogleanAnaytics}][{/capture}] 

[{ insert name="dggoogleanalytics" position="top" add=$smarty.capture.dgAddGogleanAnaytics }]
