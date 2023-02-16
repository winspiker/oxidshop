[{ assign var="dynvalue" value=$oView->getDynValue()}]
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
        <div class="cp-payment-logos">
            <div class="cp-ccissuer-logos">
            [{if ($oViewConf->logoEnabled('mc'))}]
                [{if ($sPaymentID == 'cpcredit3d')}]
                    <img class="img-responsive img-thumbnail" src="[{$oViewConf->getModuleUrl('cppayments','img/CC3D_MC.png')}]" alt="master_card_3ds_logo" />
                [{else}]
                    <img class="img-responsive img-thumbnail" src="[{$oViewConf->getModuleUrl('cppayments','img/CC_MC.png')}]" alt="master_card_logo" />
                [{/if}]
            [{/if}]
            [{if ($oViewConf->logoEnabled('visa'))}]
                [{if ($sPaymentID == 'cpcredit3d')}]
                    <img class="img-responsive img-thumbnail" src="[{$oViewConf->getModuleUrl('cppayments','img/CC3D_VISA.png')}]" alt="visa_card_3ds_logo" />
                [{else}]
                    <img class="img-responsive img-thumbnail" src="[{$oViewConf->getModuleUrl('cppayments','img/CC_VISA.png')}]" alt="visa_logo" />
                [{/if}]
            [{/if}]
            </div>
        [{if ($oViewConf->logoEnabled('cvv'))}]
            <br>
            <img class="img-responsive img-thumbnail" src="[{$oViewConf->getModuleUrl('cppayments','img/CVV.png')}]" alt="cvv_logo" />
        [{/if}]
        </div>
        <input style="display: none;" data-crefopay="paymentMethod" id="cppayment_[{$sPaymentID}]" type="radio" name="cppaymentid" value="[{$oViewConf->getPaymentTag($sPaymentID)}]">
        
        <div class="form-group col-xs-12 col-lg-3">
                <label id="pinLabel" class="req" for="ccnumber">[{ oxmultilang ident="NUMBER" suffix="COLON" }]</label>
			    <div id="ccnumber" class="cp-placeholder" data-crefopay-placeholder="paymentInstrument.number" required="required"></div>

                <label id="piaLabel" class="req control-label" for="ccholder">[{ oxmultilang ident="BANK_ACCOUNT_HOLDER" suffix="COLON" }]</label>
				<div id="ccholder" class="cp-placeholder" data-crefopay-placeholder="paymentInstrument.accountHolder" required="required"></div>
           
                <label id="pivLabel" class="req control-label" for="ccvalidity">[{ oxmultilang ident="VALID_UNTIL" suffix="COLON" }]</label>
                <div id="ccvalidity" class="cp-placeholder" data-crefopay-placeholder="paymentInstrument.validity" required="required"></div>

                <label id="picLabel" class="req control-label" for="cccvv">[{ oxmultilang ident="CARD_SECURITY_CODE" suffix="COLON"}]</label>
                <div id="cccvv" class="cp-placeholder cvv" data-crefopay-placeholder="paymentInstrument.cvv" required="required"></div>
                <span class="help-block">[{oxmultilang ident="CARD_SECURITY_CODE_DESCRIPTION"}]</span>
        </div>

        <div class="clearfix"></div>
        
        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                <div class="desc">
                    [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>