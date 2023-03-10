<?php
// Moduloptionen
$aLang = array(
    'charset'                        => 'UTF-8',
    
    // Merchant Setup Group
    'SHOP_MODULE_GROUP_merchant' => 'Access Sata',
    'SHOP_MODULE_CrefoPayMerchantId' => 'Merchant ID',
    'HELP_SHOP_MODULE_CrefoPayMerchantId' => 'You will get your Merchant ID from the CrefoPay <a href="mailto:service@crefopay.de">Integrations-Team</a>',
    'SHOP_MODULE_CrefoPayStoreId' => 'Store ID',
    'HELP_SHOP_MODULE_CrefoPayStoreId' => 'You will get your Merchant ID from the CrefoPay <a href="mailto:service@crefopay.de">Integrations-Team</a>',
    'SHOP_MODULE_CrefoPayPrivateKey' => 'Private Key',
    'HELP_SHOP_MODULE_CrefoPayPrivateKey' => 'Your will get your individual Private Key from the CrefoPay 
                                              <a href="mailto:service@crefopay.de">Integrations-Team</a>',
    'SHOP_MODULE_CrefoPayShopPublicKey' => 'Public Key',
    'HELP_SHOP_MODULE_CrefoPayShopPublicKey' => 'Your will get the Public Key for your Domain from the CrefoPay
                                             <a href="mailto:service@crefopay.de">Integrations-Team</a>',
                                                                                          
    // Environment Group
    'SHOP_MODULE_GROUP_environment' => 'Environment',
    'SHOP_MODULE_CrefoPaySystemMode' => 'Mode',
    'SHOP_MODULE_CrefoPaySystemMode_0' => 'Sandbox',
    'SHOP_MODULE_CrefoPaySystemMode_1' => 'Production',
    'HELP_SHOP_MODULE_CrefoPaySystemMode' => 'Here you can switch between Sandbox (demo mode) and Production mode',
    
    'SHOP_MODULE_CrefoPayDefaultLang' => 'Default Language',
    'SHOP_MODULE_CrefoPayDefaultLang_DE' => 'German',
    'SHOP_MODULE_CrefoPayDefaultLang_EN' => 'English',
    'SHOP_MODULE_CrefoPayDefaultLang_ES' => 'Spanish',
    'SHOP_MODULE_CrefoPayDefaultLang_FR' => 'French',
    'SHOP_MODULE_CrefoPayDefaultLang_IT' => 'Italian',
    'SHOP_MODULE_CrefoPayDefaultLang_NL' => 'Dutch',
    'HELP_SHOP_MODULE_CrefoPayDefaultLang' => 'Define the default output language in case the user language is not compatible with CrefoPay.',
    'SHOP_MODULE_CrefoPayAllowOtherPayments' => 'Allow not CrefoPay payment methods',
    'SHOP_MODULE_CrefoPayAllowOtherPayments_0' => 'Hide', 
    'SHOP_MODULE_CrefoPayAllowOtherPayments_1' => 'Allow', 
    'HELP_SHOP_MODULE_CrefoPayAllowOtherPayments' => 'Here you can hide not CrefoPay payment methods if you only want to allow payments through CrefoPay.', 
    'SHOP_MODULE_CrefoPayLogLevel' => 'Log Level',
    'SHOP_MODULE_CrefoPayLogLevel_0' => 'Debug',
    'SHOP_MODULE_CrefoPayLogLevel_1' => 'Warn',
    'SHOP_MODULE_CrefoPayLogLevel_2' => 'Error',
    'HELP_SHOP_MODULE_CrefoPayLogLevel' => 'The log level determines which events are logged in the log file. Possible values are Debug (all), Warning (warnings and errors), or Error (only errors).',
    'SHOP_MODULE_CrefoPayLogFile' => 'Logfile',
    'HELP_SHOP_MODULE_CrefoPayLogFile' => 'Enter the name of the log file here. Leaving the field blank will cause crefopay.log to be used.',
    
    // Transaction Group
    'SHOP_MODULE_GROUP_transaction' => 'Orders',
    'SHOP_MODULE_CrefoPayAutoCapture' => 'Auto Capture',
    'HELP_SHOP_MODULE_CrefoPayAutoCapture' => '<span class="text-danger">Attention!</span> Enable Auto Capture only after consultation with the CrefoPay <a href="mailto:service@crefopay.de">Integrations-Team</a>',
    'SHOP_MODULE_CrefoPayB2BEnabled' => 'Business Transaktions (B2B)',
    'SHOP_MODULE_CrefoPayB2BEnabled_0' => 'Disable',
    'SHOP_MODULE_CrefoPayB2BEnabled_1' => 'Enable',
    'HELP_SHOP_MODULE_CrefoPayB2BEnabled' => '<span class="text-danger">Attention!</span> You should only activate this function if the processing of B2B transactions is part of your CrefoPay contract.',
    'SHOP_MODULE_CrefoPayMerchantRef' => 'Merchant Reference',
    'HELP_SHOP_MODULE_CrefoPayMerchantRef' => 'You can enter here (optional) an additional reference for your orders',
    'SHOP_MODULE_CrefoPayBillPeriod' => 'Bill Payment Period',
    'HELP_SHOP_MODULE_CrefoPayBillPeriod' => 'Define how many days want your customers to pay bill payments',
    'SHOP_MODULE_CrefoPayPrepaidPeriod' => 'Prepaid Payment Period',
    'HELP_SHOP_MODULE_CrefoPayPrepaidPeriod' => 'Define how many days want your customers to pay prepaid payments',
    'SHOP_MODULE_CrefoPayBasketVal' => 'Basket Validity',
    'HELP_SHOP_MODULE_CrefoPayBasketVal' => 'You can enter here (optional) the validity of the shopping basket of your orders.',
    'SHOP_MODULE_CrefoPayBasketValUnit' => 'Unit',
    'SHOP_MODULE_CrefoPayBasketValUnit_d' => 'Day',
    'SHOP_MODULE_CrefoPayBasketValUnit_m' => 'Minutes',
    'SHOP_MODULE_CrefoPayBasketValUnit_h' => 'Hours',
    'HELP_SHOP_MODULE_CrefoPayBasketValUnit' => 'You can define (optional) the basket validity unit here.',

    // Image Group
    'SHOP_MODULE_GROUP_images' => 'Payment Logos',
    'SHOP_MODULE_CrefoPayCvvLogo' => 'CVV Help',
    'SHOP_MODULE_CrefoPayCvvLogo_0' => 'Hide',
    'SHOP_MODULE_CrefoPayCvvLogo_1' => 'View',
    'HELP_SHOP_MODULE_CrefoPayCvvLogo' => 'With this option you can view or hide a picture of the back of a credit card that shows where the CVV can be found.',
    'SHOP_MODULE_CrefoPayMcLogo' => 'MasterCard Logo',
    'SHOP_MODULE_CrefoPayMcLogo_0' => 'Hide',
    'SHOP_MODULE_CrefoPayMcLogo_1' => 'View',
    'HELP_SHOP_MODULE_CrefoPayMcLogo' => 'With this option you can view or hide MasterCard Logo. (recommended)',
    'SHOP_MODULE_CrefoPayVisaLogo' => 'VISA Logo',
    'SHOP_MODULE_CrefoPayVisaLogo_0' => 'Hide',
    'SHOP_MODULE_CrefoPayVisaLogo_1' => 'View',
    'HELP_SHOP_MODULE_CrefoPayVisaLogo' => 'With this option you can view or hide VISA Logo. (recommended)',
);