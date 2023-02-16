[{ oxmultilang ident="THANK_YOU_FOR_ORDER" }] [{ $oxcmp_shop->oxshops__oxname->value }]. <br>
[{assign var="paymentMethod" value=$oView->getPaymentMethod()}]
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
            <table class="table table-striped">
                <tbody>
                [{foreach key=cpKey item=cpValue from=$oViewConf->getAdditionalData()}]
                    <tr>
                        <th>[{ oxmultilang ident=$cpKey}]:</th>
                        <td>[{$cpValue}]</td>
                    </tr>
                [{/foreach}]
                </tbody>
            </table>
        </div>
    [{/if}]
[{else}]
    [{ oxmultilang ident="REGISTERED_YOUR_ORDER" args=$order->oxorder__oxordernr->value}] <br>
[{/if}]
[{$oViewConf->regenerateSessionId()}]

[{if !$oView->getMailError() }]
    [{ oxmultilang ident="MESSAGE_YOU_RECEIVED_ORDER_CONFIRM" }]<br>
[{else}]<br>
    [{ oxmultilang ident="MESSAGE_CONFIRMATION_NOT_SUCCEED" }]<br>
[{/if}]
<br>
[{ oxmultilang ident="MESSAGE_WE_WILL_INFORM_YOU" }]<br><br>
