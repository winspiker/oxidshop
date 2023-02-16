[{capture name="originalTemplate"}]
[{include file=$oView->sOriginalTemplate}]
[{/capture}]
[{capture name="insertTemplate"}]

[{if $searchpopup }]
    aTabsdiv = document.getElementsByClassName('tabs');
    if (aTabsdiv[0])
        aTabsdiv[0].style.display='none';

[{/if}]

[{include file='exonn_pagination.tpl'}]


if (parent.parent)

[{/capture}]
[{$smarty.capture.originalTemplate|replace:'if (parent.parent)':$smarty.capture.insertTemplate }]


