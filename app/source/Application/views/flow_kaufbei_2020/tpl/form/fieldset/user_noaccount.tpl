<div class="form-group [{if $aErrors.oxuser__oxusername}]oxInValid[{/if}]">
    [{block name="user_noaccount_email"}]
        <label class="control-label col-lg-3 req">[{oxmultilang ident="EMAIL_ADDRESS"}]</label>
        <div class="col-lg-9">
            <input id="userLoginName" class="form-control js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr" value="[{$oView->getActiveUsername()}]">
            <div class="help-block">
                [{include file="message/inputvalidation.tpl" aErrors=$aErrors.oxuser__oxusername}]
            </div>
        </div>
    [{/block}]
</div>
<div class="form-group[{if $aErrors.oxuser__oxprevusername}] oxInValid[{/if}]">
    [{block name="user_account_prevusername"}]
    <label class="control-label col-lg-3 req" for="userPevName">[{oxmultilang ident="EMAIL_ADDRESS_REPEAT"}]</label>
    <div class="col-lg-9">
        <input id="userPevName" data-validation-match-match="lgn_usr" data-validation-match-message="[{oxmultilang ident="DD_FORM_VALIDATION_VALIDEMAIL_REPEAT"}]" class="form-control js-oxValidate js-oxValidate_notEmpty js-oxValidate_email" type="email" name="lgn_usr_prev" value="[{$oView->getActiveUsername()}]" required="required">
        <div class="help-block"></div>
    </div>
    [{/block}]
</div>
<div class="form-group">
    [{block name="user_noaccount_newsletter"}]
        <div class="col-lg-9 col-lg-offset-3">
            <input type="hidden" name="blnewssubscribed" value="0">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="blnewssubscribed" value="1" [{if $oView->isNewsSubscribed()}]checked[{/if}]> [{oxmultilang ident="NEWSLETTER_SUBSCRIPTION"}]
                </label>
            </div>
            <span class="help-block">[{oxmultilang ident="MESSAGE_NEWSLETTER_SUBSCRIPTION"}]</span>
        </div>
    [{/block}]
</div>