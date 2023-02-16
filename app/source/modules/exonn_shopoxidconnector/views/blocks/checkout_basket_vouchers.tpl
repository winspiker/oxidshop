[{$smarty.block.parent}]
[{assign var="oUser" value=$oxcmp_basket->getBasketUser()}]

[{if is_object($oUser)}]

[{assign var="customerCredit" value=$oUser->getCustomerCredit()}]

[{/if}]

[{if $customerCredit.creditLimit>0.01}]
    <div id="basketUserCredit" style="margin-top: 7rem; max-width: 500px; border-radius:3px; color: #3c763d; background-color: #dff0d8 ">
        <table class="table">
            <tr>
                <td colspan="2"><b>[{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_PANEL_TITLE" }]</b></td>
            </tr>
            <tr>
                <td>[{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_LIMIT" }]</td>
                <td>[{oxprice price=$customerCredit.creditLimit currency=$currency}]</td>
            </tr>
            <tr>
                <td>[{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_OPEN_INVOICE_SUM" }]</td>
                <td>[{oxprice price=$customerCredit.offenePosten currency=$currency}]</td>
            </tr>
            <tr>
                <td>[{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_FREE_LIMIT" }]</td>
                <td>
                    [{if $customerCredit.availableLimit < 0}]
                    <span class="text-danger">[{oxprice price=$customerCredit.availableLimit currency=$currency}]</span>
                    [{else}]
                    <span>[{oxprice price=$customerCredit.availableLimit currency=$currency}]</span>
                    [{/if}]
                </td>
            </tr>
        </table>
    </div>
    [{/if}]