[{oxscript include=$oViewConf->getModuleUrl('paypalpluscw','out/src/js/checkout.js')}]
[{oxscript add="$(document).ready(function() { var defaultTemplateCheckoutHandler = window['paypalpluscw_checkout_processor']; defaultTemplateCheckoutHandler.init('$processingLabel', '$selfUrl', '$paypalpluscwAliasUrl'); });"}]

[{$smarty.block.parent}]