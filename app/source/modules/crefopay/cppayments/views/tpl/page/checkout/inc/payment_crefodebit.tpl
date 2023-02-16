[{assign var="dynvalue" value=$oView->getDynValue()}]
[{assign var="iPayError" value=$oView->getPaymentError() }]

<dl>
    <dt>
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
        <label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}]
        [{if $paymentmethod->getPrice()}]
            [{assign var="oPaymentPrice" value=$paymentmethod->getPrice() }]
            [{if $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge') }]
                [{if $oPaymentPrice->getNettoPrice() != 0 }]
                    ( [{oxprice price=$oPaymentPrice->getNettoPrice() currency=$currency}]
                    [{if $oPaymentPrice->getVatValue() != 0}]
                        [{ oxmultilang ident="PLUS_VAT" }] [{oxprice price=$oPaymentPrice->getVatValue() currency=$currency }]
                    [{/if}])
                [{/if}]
            [{else}]
                [{if $oPaymentPrice->getBruttoPrice() != 0 }]
                    ([{oxprice price=$oPaymentPrice->getBruttoPrice() currency=$currency}])
                [{/if}]
            [{/if}]
        [{/if}]
        </b></label>
    </dt>
    <dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
        <input style="display: none;" data-crefopay="paymentMethod" id="cppayment_[{$sPaymentID}]" type="radio" name="cppaymentid" value="[{$oViewConf->getPaymentTag($sPaymentID)}]">

        <div class="form-group col-xs-12 col-lg-3">
            <label class="req control-label" for="bankAccountHolder">[{ oxmultilang ident="BANK_ACCOUNT_HOLDER" suffix="COLON" }]</label>
            <input id="bankAccountHolder" type="text" class="cp-placeholder form-control js-oxValidate js-oxValidate_notEmpty" data-crefopay="paymentInstrument.bankAccountHolder" required="required">

            <label class="req control-label" for="iban">[{ oxmultilang ident="IBAN" suffix="COLON" }]</label>
            <input id="iban" type="text" class="cp-placeholder form-control js-oxValidate js-oxValidate_notEmpty" data-crefopay="paymentInstrument.iban" required="required">
       
            <label class="req control-label" for="bic">[{ oxmultilang ident="BIC" suffix="COLON" }]</label>
            <input id="bic" type="text" class="cp-placeholder form-control js-oxValidate js-oxValidate_notEmpty" data-crefopay="paymentInstrument.bic" required="required">
        </div>

        <div class="clearfix"></div>
        
        [{if $oView->dobMissing()}]
        <div class="form-group col-xs-12 col-lg-3">   
            <label class="req control-label" for="crefoPayDOBDD">[{oxmultilang ident="DATE_OF_BIRTH"}]: </label>
            <input name="crefoPayDOB"
                    data-crefopay="additionalInformation.dateOfBirth"
                    type="date"
                    id="crefoPayDOBDD"
                    placeholder="{s name='DateOfBirthFormat'}YYYY-MM-DD{/s}"
                    {literal}pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))"{/literal}
                    class="form-control js-oxValidate js-oxValidate_notEmpty"
                    required="required" />
        </div>
        <div class="clearfix"></div>
        [{/if}]


        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                <div class="desc">
                    [{ $paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>