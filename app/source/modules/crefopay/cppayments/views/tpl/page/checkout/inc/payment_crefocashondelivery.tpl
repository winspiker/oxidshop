<dl>
    <dt>
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
        <label for="payment_[{$sPaymentID}]"><b>[{$paymentmethod->oxpayments__oxdesc->value}]
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
        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value|trim}]
                <div class="desc">
                    [{ $paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>