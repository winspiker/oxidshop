[{if count($Errors)>0 && count($Errors.default) > 0}]
    <div class="error-container">
    [{foreach from=$Errors.default item=oEr key=key}]
        <p class="alert alert-danger">[{$oEr->getOxMessage()}]</p>
    [{/foreach}]
    </div>
[{/if}]