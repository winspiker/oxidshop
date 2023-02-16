[{* |page/checkout/thankyou.tpl|checkout_thankyou_main|dgidealo_checkout_thankyou_main.tpl|7| *}]

[{ $smarty.block.parent }]

[{assign var="oIdealo" value=$oViewConf->getIdealo() }]
[{ if $oIdealo->getIdealoParam('dgIdealoPerformaceTracking') }]
    <!-- BEGIN IDEALO PARTNER TRACKING CODE -->
    [{ insert name="dgidealotracking" }]
    <!-- END IDEALO PARTNER TRACKING CODE -->
[{/if}]