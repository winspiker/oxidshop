<?php
// -------------------------------
// RESOURCE IDENTIFIER = STRING
// -------------------------------
$sLangName = 'Deutsch';

$aLang = array(
    'charset'                               => 'UTF-8',

    // payment methods
    'DD'                                    => 'Lastschrift',    
    'CC'                                    => 'Kreditkarte',
    'CC3D'                                  => 'Kreditkarte (3D Secure)',
    'PREPAID'                               => 'Vorkasse',
    'PAYPAL'                                => 'PayPal',
    'SU'                                    => 'Sofort',
    'BILL'                                  => 'Rechnung',
    'COD'                                   => 'Vorkasse',

    // additional payment information
    'PREPAID_INFO'                          => 'Bitte überweisen Sie den fälligen Betrag <i>innerhalb von %s Tagen</i> auf das folgende Bankkonto:',
    'BILL_INFO'                             => 'Bitte überweisen Sie den fälligen Betrag <i>innerhalb von %s Tagen</i> ab Rechnungsdatum auf das folgende Bankkonto:',
    'paymentMethod'                         => 'Bezahlart',
    'paymentReference'                      => 'Verwendungszweck',
    'accountHolder'                         => 'Empfänger',
    'iban'                                  => 'IBAN',
    'bankname'                              => 'Name der Bank',
    'bic'                                   => 'BIC',
    'customerEmail'                         => 'Käufer E-Mail',
    'transactionAmount'                     => 'Betrag',
    'transactionCurrency'                   => 'Währung',

    // frontend labels
    'DATE_OF_BIRTH'                         => 'Geburtsdatum',

    // Frontend error translations can be defined here (WARNING: This file will be overwritten with the next update of the module)
    // Beispiel für Fehlercode 2001:
    // 'cppayments_error_2001'              => 'Die Zahlung wurde vom Zahlungsdienstleister abgelehnt',
);
