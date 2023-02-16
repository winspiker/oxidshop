[{if $payment->oxuserpayments__oxpaymentsid->value != "oxempty"}]
    <h3 style="font-weight: bold; margin: 20px 0 7px; padding: 0; line-height: 35px; font-size: 12px;font-family: Arial, Helvetica, sans-serif; text-transform: uppercase; border-bottom: 4px solid #ddd;">
        [{oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]
    </h3>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; margin: 5px 0 10px;">
        <b>[{ $payment->oxpayments__oxdesc->value }]
            [{assign var="oPaymentCostPrice" value=$basket->getPaymentCost()}]
            [{if $oPaymentCostPrice }]([{oxprice price=$oPaymentCostPrice->getBruttoPrice() currency=$currency}])[{/if}]</b>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; margin: 5px 0 10px;">

    [{assign var="paymentMethod" value=$payment->oxuserpayments__oxpaymentsid->value}]
    [{if $oViewConf->isCrefoPay($paymentMethod) }]
        [{if $oViewConf->hasAdditionalData($paymentMethod)}]
            <div class="cp-additional-payment-info">
                [{if $paymentMethod == 'cpprepaid'}]
                <p>
                    <br>[{ oxmultilang ident="PREPAID_INFO" args=$oViewConf->getPrepaidPeriod()}]<br>
                </p>
                [{elseif $paymentMethod == 'cpbill'}]
                <p>
                    <br>[{ oxmultilang ident="BILL_INFO" args=$oViewConf->getBillPeriod()}]<br>
                </p>
                [{/if}]
                <table class="table">
                    <tbody>
                    [{foreach key=cpKey item=cpValue from=$oViewConf->getAdditionalData()}]
                        <tr>
                            <th>[{ oxmultilang ident=$cpKey}]:</th>
                            <td align="right">[{$cpValue}]</td>
                        </tr>
                    [{/foreach}]
                    </tbody>
                </table>
            </div>
        [{/if}]
    [{/if}]     
    </p>
[{/if}]
