[{capture name="saveTopButton"}]
    <div class="cb_container">
        <div class="row clearfix">
            <div class="column full center">
                <button onclick="saveCat()" class="cb-save btn btn-primary"> [{oxmultilang ident='EXONNCB_SAVE'}]
                </button>
            </div>
        </div>
    </div>
    [{/capture}]


[{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveTopButton}]
    [{/if}]

<div id="contentarea_cat"
     class="contentarea cb_container [{if !$oxcmp_user->oxuser__oxrights->value == 'malladmin'}]live[{/if}]">

</div>

[{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveTopButton}]
    [{/if}]


[{$smarty.block.parent}]