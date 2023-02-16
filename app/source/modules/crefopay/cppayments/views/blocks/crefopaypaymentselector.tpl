[{oxstyle include=$oViewConf->getModuleUrl('cppayments','out/src/css/cppayments.css')}]

[{if not $oView->secureFieldsInitialized()}]
	[{oxscript include=$oViewConf->getCpsfLib() priotity=10 }]
	<script type="text/javascript" src="[{$oViewConf->getModuleUrl('cppayments','out/src/js/jquery-3.2.1.min.js')}]"></script>
	<script type="text/javascript">
		var cpsfShopPublicKey = "[{$oViewConf->getShopPublicKey()}]";
		var cpsfOrderID = "[{$oView->getOrderID()}]";
		var cpsfUrl = "[{$oViewConf->getCpsfUrl()}]";
		var cpsfAccountHolder = "[{oxmultilang ident=$oViewConf->getPlaceholder('accountHolder')}]";
		var cpsfCardNumber = "[{$oViewConf->getPlaceholder('cardNumber')}]";
		var cpsfCvv = "[{$oViewConf->getPlaceholder('cvv')}]";
		var cpsfBaseUrl = "[{$oViewConf->getBaseDir()}]";
	</script>
	[{oxscript include=$oViewConf->getModuleUrl('cppayments','out/src/js/cpsecurefields.js') priority=10 }]
[{/if}]


[{if $sPaymentID == "cpdebit" && $oViewConf->isAllowedPaymentMethod('DD')}]
	[{include file="payment_crefodebit.tpl"}]
[{elseif $sPaymentID == "cpcredit" && $oViewConf->isAllowedPaymentMethod('CC')}]
	[{include file="payment_crefocreditcard.tpl"}]
[{elseif $sPaymentID == "cpcredit3d" && $oViewConf->isAllowedPaymentMethod('CC3D')}]
	[{include file="payment_crefocreditcard.tpl"}]
[{elseif $sPaymentID == "cpprepaid" && $oViewConf->isAllowedPaymentMethod('PREPAID')}]
	[{include file="payment_crefoprepaid.tpl"}]
[{elseif $sPaymentID == "cppaypal" && $oViewConf->isAllowedPaymentMethod('PAYPAL')}]
	[{include file="payment_crefopaypal.tpl"}]
[{elseif $sPaymentID == "cpsofort" && $oViewConf->isAllowedPaymentMethod('SU')}]
	[{include file="payment_crefosofort.tpl"}]
[{elseif $sPaymentID == "cpbill" && $oViewConf->isAllowedPaymentMethod('BILL')}]
	[{include file="payment_crefobill.tpl"}]
[{elseif $sPaymentID == "cpcod" && $oViewConf->isAllowedPaymentMethod('COD')}]
	[{include file="payment_crefocashondelivery.tpl"}]
[{/if}]


[{if $oViewConf->allowOtherPayments()}]
	[{if $sPaymentID == "oxidcashondel"}]
		[{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
	[{elseif $sPaymentID == "oxidcreditcard"}]
	    [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
	[{elseif $sPaymentID == "oxiddebitnote"}]
		[{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
	[{else}]
		[{if not $oViewConf->isCrefoPay($sPaymentID)}]
			[{include file="page/checkout/inc/payment_other.tpl"}]
		[{/if}]
	[{/if}]
[{/if}]