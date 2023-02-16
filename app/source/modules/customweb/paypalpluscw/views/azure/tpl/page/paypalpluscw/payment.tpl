[{oxstyle include=$oViewConf->getModuleUrl('paypalpluscw', 'out/src/css/payment_form.css')}]

[{oxscript include=$oViewConf->getModuleUrl('paypalpluscw','out/src/js/checkout.js')}]
[{oxscript add="$(document).ready(function() { var defaultTemplateCheckoutHandler = window['paypalpluscw_checkout_processor']; defaultTemplateCheckoutHandler.init('$processingLabel', '$selfUrl', '$aliasUrl', '$paymentMethodId', '$transactionId'); });"}]

[{capture append="oxidBlock_content"}]
	<form action="[{$formActionUrl}]" method="post" id="paypalpluscwPaymentForm" accept-charset="UTF-8" class="form-horizontal">
		<div class="paypalpluscw-payment-form">
			[{if !empty($hiddenFormFields)}]
				<div class="paypalpluscw-hiddenFormFields">
					[{$hiddenFormFields}]
				</div>
			[{/if}]
			
			[{if !empty($visibleFormFields) || !empty($aliasFormFields)}]
				<div class="panel panel-default">
					<div class="panel-heading">[{oxmultilang ident="Your Payment Information"}]</div>
					<div class="panel-body">
						<div class="paypalpluscw-alias-form-fields">
							[{$aliasFormFields}]
						</div>
						
						<div class="paypalpluscw-visible-form-fields">
							[{$visibleFormFields}]
						</div>
					</div>
				</div>
			[{/if}]
		</div>
		
		<div class="well well-sm">
            <a href="[{$previousUrl}]" class="btn btn-default pull-left prevStep submitButton largeButton"><i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
            <button type="submit" class="btn btn-primary pull-right submitButton nextStep largeButton" id="submitButton">[{oxmultilang ident="SUBMIT_ORDER"}] <i class="fa fa-caret-right"></i></button>
            <div class="clearfix"></div>
        </div>
	</form>
[{/capture}]
[{include file="layout/page.tpl"}]