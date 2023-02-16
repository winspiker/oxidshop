[{$smarty.block.parent}]
[{assign var="oUser" value=$oView->getUser()}]
[{assign var="customerCredit" value=$oUser->getCustomerCredit()}]
[{if $customerCredit.creditLimit > 0}]
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">[{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_PANEL_TITLE" }]</h3>
        </div>
        <table class="table">
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
