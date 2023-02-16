
[{$smarty.block.parent}]
[{assign var="oUser" value=$oView->getUser()}]
[{assign var="customerCredit" value=$oUser->getCustomerCredit()}]

[{if $customerCredit.creditLimit>0.01 }]
    <!-- Get Customer Credit -->

    [{if $customerCredit.isCreditLimitAcceptable && $customerCredit.creditLimit > 0}]
    <!-- IF  Credit Limit Acceptable and bigger then 0 -->
    <div id="paymentUserCredit" style="max-width: 500px; border-radius:3px; color: #3c763d; background-color: #dff0d8 ">
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
                <td>[{oxprice price=$customerCredit.availableLimit currency=$currency}]</td>
            </tr>
        </table>
    </div>
    <!-- IF  Credit Limit Acceptable and bigger then 0 -->
    [{/if}]

    [{if !$customerCredit.isCreditLimitAcceptable}]

    <!-- IF  CreditLimit Not Acceptable -->

    <script type="text/javascript">
        // Disable oxidinvoce Payment Radio Input
        const oxid[{$paymentmethod->oxpayments__oxid->value}]Button = document.getElementById("payment_[{$paymentmethod->oxpayments__oxid->value}]");
        oxid[{$paymentmethod->oxpayments__oxid->value}]Button.disabled = true;
        oxid[{$paymentmethod->oxpayments__oxid->value}]Button.removeAttribute('checked');

        // Add Warnig Message after  oxidinvoce Payment Label
        const oxid[{$paymentmethod->oxpayments__oxid->value}]Label = document.querySelector('[for="payment_[{$paymentmethod->oxpayments__oxid->value}]"]');
        oxid[{$paymentmethod->oxpayments__oxid->value}]Label.outerHTML += `
            <p style="padding:10px; color: #fff; background-color: #d9534f; border-color: #d43f3a;" >
                [{ oxmultilang ident="INVOICE_PAYMENT_CREDIT_LIMIT_NOT_ACCEPTABLE" }]
            </p>
        `;
    </script>
    <!-- IF  CreditLimit Not Acceptable -->
    [{/if}]

    [{/if}]