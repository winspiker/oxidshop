[{if $paypalpluscw_widgets}]
	<div class="lineBox">
		[{foreach from=$paypalpluscw_widgets item=widget}]
			<div class="paypalpluscw-external-checkout-widget">
				[{$widget.html}]
			</div>
		[{/foreach}]
	</div>

	<style type="text/css">
	.paypalpluscw-external-checkout-widget {
		display: inline-block;
  		margin-right: 15px;
  		margin-bottom: 15px;
	}
	</style>
[{/if}]

[{$smarty.block.parent}]