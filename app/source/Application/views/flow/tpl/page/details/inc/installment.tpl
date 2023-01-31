[{assign var="oInstallment" value=$oDetailsProduct->getInstallment()}]
[{assign var="oPaymentMonths" value=$oInstallment->getPaymentMonths()}]
[{assign var="oFirstPayment" value=$oInstallment->getFirstPayment()}]
[{assign var="oMonthPayment" value=$oInstallment->getMonthPayment()}]
[{assign var="oFullPrice" value=$oInstallment->getFullPrice()}]
[{assign var="isActive" value=$oInstallment->isInstallmentActive()}]



[{if $isActive}]
    <div>
        [{include file="page/details/inc/installment_popup.tpl"}]
    </div>
[{/if}]