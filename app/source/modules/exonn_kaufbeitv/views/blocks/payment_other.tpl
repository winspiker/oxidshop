[{$smarty.block.parent}]

[{if $paymentmethod->oxpayments__installmentpayment->value}]
    <div class="desc">
        Anzahlung insgesamt: [{oxprice price=$oxcmp_basket->getFirstinstallmentTotal() currency=$currency}]<br>
    </div>
    [{/if}]