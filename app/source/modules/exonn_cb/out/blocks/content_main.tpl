[{capture name="saveTopButton"}]
    <div class="cb_container">
        <div class="row clearfix">
            <div class="column full center">
                <button onclick="save('top')" class="cb-save btn btn-primary"> [{oxmultilang ident='EXONNCB_SAVE'}]
                </button>
            </div>
        </div>
    </div>
    [{/capture}]

[{capture name="saveBotButton"}]
    <div class="cb_container">
        <div class="row clearfix">
            <div class="column full center">
                <button onclick="save('bot')" class="cb-save btn btn-primary"> [{oxmultilang ident='EXONNCB_SAVE'}]
                </button>
            </div>
        </div>
    </div>
    [{/capture}]

[{if $oView->getClassName() == "start"}]

    [{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveTopButton}]
    [{/if}]

    <div id="contentarea_top"
         class="contentarea cb_container [{if !$oxcmp_user->oxuser__oxrights->value == 'malladmin'}]live[{/if}]">
        [{$oView->getCbContent('start_top')}]
    </div>

    [{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveTopButton}]
    [{/if}]

    [{$smarty.block.parent}]

    [{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveBotButton}]
    [{/if}]

    <div id="contentarea_bot"
         class="contentarea cb_container [{if !$oxcmp_user->oxuser__oxrights->value == 'malladmin'}]live[{/if}]">
        [{$oView->getCbContent('start_bot')}]
    </div>

    [{if $oxcmp_user->oxuser__oxrights->value == 'malladmin'}]
    [{$smarty.capture.saveBotButton}]
    [{/if}]

    [{else}]
    [{$smarty.block.parent}]
    [{/if}]
