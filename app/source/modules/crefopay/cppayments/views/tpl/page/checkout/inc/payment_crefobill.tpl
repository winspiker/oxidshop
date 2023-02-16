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
        [{assign var="aDynValues" value=$paymentmethod->getDynValues()}]
        <input style="display: none;" data-crefopay="paymentMethod" id="cppayment_[{$sPaymentID}]" type="radio" name="cppaymentid" value="[{$oViewConf->getPaymentTag($sPaymentID)}]">
        [{if $aDynValues}]
            <ul>
            [{foreach from=$aDynValues item=value name=PaymentDynValues}]
                <li>
                    <label>[{ $value->name}]</label>
                    <input id="[{$sPaymentID}]_[{$smarty.foreach.PaymentDynValues.iteration}]" type="text" class="textbox" size="20" maxlength="64" name="dynvalue[[{$value->name}]]" value="[{ $value->value}]">
                </li>
            [{/foreach}]
            </ul>
        [{/if}]

        [{if $oView->dobMissing()}]
        <div class="form-group col-xs-12 col-lg-3">
            <label class="req control-label" for="crefoPayDOBBILL">[{oxmultilang ident="DATE_OF_BIRTH"}]: </label>
            <input name="crefoPayDOB"
                    data-crefopay="additionalInformation.dateOfBirth"
                    type="date"
                    id="crefoPayDOBBILL"
                    placeholder="{s name='DateOfBirthFormat'}YYYY-MM-DD{/s}"
                    {literal}pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))"{/literal}
                    class="form-control js-oxValidate js-oxValidate_notEmpty"
                    required="required" />
        </div>
        <div class="clearfix"></div>
        [{/if}]

        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value|trim}]
                <div class="desc">
                    [{ $paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>