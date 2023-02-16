[{oxstyle include=$oViewConf->getModuleUrl('paypalpluscw', 'out/src/css/payment_form.css')}]

[{if $paymentmethod->isPaypalpluscwPaymentMethod()}]
    <dl>
        <dt>
            <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
            <label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
        </dt>
        <dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
        	[{if $paymentmethod->oxpayments__oxlongdesc->value}]
                <div class="desc">
                    [{ $paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        	[{if $paymentmethod->isPaypalpluscwPaymentFormOnPaymentPage()}]
	        	<div class="paypalpluscw-payment-form [{$sPaymentID}]-form" data-authorization-method="[{$paymentmethod->getPaypalpluscwAuthorizationMethod()}]">
					<ul class="form">
						<div class="paypalpluscw-alias-form-fields">
							[{$paymentmethod->getPaypalpluscwAliasFormFields()}]
						</div>
						
						<div class="paypalpluscw-visible-form-fields">
							[{$paymentmethod->getPaypalpluscwVisibleFormFields()}]
						</div>
					</ul>
				</div>
			[{/if}]
        </dd>
    </dl>
[{else}]
    [{$smarty.block.parent}]
[{/if}]