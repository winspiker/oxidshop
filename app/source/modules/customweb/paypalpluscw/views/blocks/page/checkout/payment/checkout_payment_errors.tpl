[{assign var="iPayError" value=$oView->getPaymentError() }]
[{if $iPayError == 'paypalpluscw'}]
	<div class="status error">[{ $oView->getPaymentErrorText() }]</div>
[{else}]
    [{$smarty.block.parent}]
[{/if}]