<?php
// -------------------------------
// RESOURCE IDENTIFIER = STRING
// -------------------------------
$sLangName = 'English';

$aLang = array(
    'charset'                               => 'UTF-8',

    // payment methods
    'DD'                                    => 'Direct Debit',    
    'CC'                                    => 'Credit Card',
    'CC3D'                                  => 'Credit Card (3D Secure)',
    'PREPAID'                               => 'Prepaid',
    'PAYPAL'                                => 'PayPal',
    'SU'                                    => 'Sofort',
    'BILL'                                  => 'Bill',
    'COD'                                   => 'Cash on Delivery',

    // additional payment information
    'PREPAID_INFO'                          => 'Please transfer the amount <i>due within %s days</i> to the following bank account:',
    'BILL_INFO'                             => 'Please transfer the amount <i>due within %s days</i> from invoice date to the following bank account:',
    'paymentMethod'                         => 'Payment Method',
    'paymentReference'                      => 'Payment Reference',
    'accountHolder'                         => 'Account Holder',
    'iban'                                  => 'IBAN',
    'bankname'                              => 'Bankname',
    'bic'                                   => 'BIC',
    'customerEmail'                         => 'Customer E-Mail',
    'transactionAmount'                     => 'Amount',
    'transactionCurrency'                   => 'Currency',

    // frontend labels
    'DATE_OF_BIRTH'                         => 'Date of Birth',

    // Frontend error translations can be defined here (WARNING: This file will be overwritten with the next update of the module)
    // Example for resultCode 2001:
    // 'cppayments_error_2001'              => 'The payment was rejected by the payment provider',
);
