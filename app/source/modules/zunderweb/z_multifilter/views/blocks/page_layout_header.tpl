[{$smarty.block.parent}]
[{if $oView->getClassName() == 'alist'}]
    [{if !$oView->getDisplayTop()}]
        [{assign var='sidebar' value="Left"}]
    [{/if}]
[{/if}]