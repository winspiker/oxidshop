<?php
/**
 * Metadata version
 */
$sMetadataVersion = '1.1';

/**
 * Module information
 */
$aModule = array(
    'id' => 'cppayments',
    'title' => 'CrefoPay Bezahlarten',
    'description' => array(
        'de' => '<p>Die Komplettlösung für Ihre Zahlungsabwicklung. Mehr Umsatz, weniger Risiko und geringere Kosten.<br>
                    Ausführliche Informationen zu CrefoPay finden Sie auf unserer <a href="https://www.crefopay.de" target="_blank">Webseite</a>.
                </p>
                <p>Detaillierte Informationen zu Ihren CrefoPay Transaktionen finden Sie im <a href="https://service.crefopay.de" target="_blank">CrefoPay Händler Service Bereich</a>.<br>
                    Weitere Informationen rund um CrefoPay finden Sie in der <a href="https://www.manula.com/manuals/crefopayment/" target="_blank">Online-Dokumentation</a>.
                </p>
                ',
        'en' => '<p>The complete solution for your payment processing. More sales, less risk and lower costs.<br>
                    Find more information about CrefoPay on our <a href="https://www.crefopay.de" target="_blank">website</a>.
                </p>
                <p>You can find detailed information about your CrefoPay transaction in our <a href="https://service.crefopay.de" target="_blank">CrefoPay Merchant Service Area</a>.<br>
                    Anything else about CrefoPay you can find in our <a href="https://www.manula.com/manuals/crefopayment/" target="_blank">Online-Documentation</a>.
                </p>'
    ),
    //'lang' => 'de',
    'thumbnail' => 'logo.jpg',
    'version' => '1.2.0',
    'author' => 'Shakuras GbR',
    'url' => 'https://www.shakuras.de',
    'email' => 'kontakt@shakuras.de',
    'extend' => array(
        'payment' => 'crefopay/cppayments/controllers/crefopay_payment',
        'order' => 'crefopay/cppayments/controllers/crefopay_order',
        'thankyou' => 'crefopay/cppayments/controllers/crefopay_thankyou',
        'oxpaymentgateway' => 'crefopay/cppayments/models/crefopay_paymentgateway',
        'oxorder' => 'crefopay/cppayments/models/crefopay_oxorder',
        'oxviewconfig' => 'crefopay/cppayments/core/cpcrefopayoxviewconfig',
        'oxsession' => 'crefopay/cppayments/core/cpcrefopayoxsession'
    ),
    'files' => array(
        'crefoPayTransaction' => 'crefopay/cppayments/components/crefopay_transaction.php',
        'crefoPayUser' => 'crefopay/cppayments/components/crefopay_user.php',
        'crefoPayAddress' => 'crefopay/cppayments/components/crefopay_address.php',
        'crefoPayBasket' => 'crefopay/cppayments/components/crefopay_basket.php',
        'crefoPayLogger' => 'crefopay/cppayments/components/crefopay_logger.php',
        'crefoPayConfig' => 'crefopay/cppayments/components/crefopay_config.php',
        'crefoPayApi' => 'crefopay/cppayments/components/crefopay_api.php',
        'crefopay_internal' => 'crefopay/cppayments/controllers/crefopay_internal.php',
        'cppayments_events' => 'crefopay/cppayments/core/cppayments_events.php',
        'crefopay_cporders' => 'crefopay/cppayments/models/crefopay_cporders.php'
    ),
    'events' => array(
        'onActivate' => 'cppayments_events::onActivate',
        'onDeactivate' => 'cppayments_events::onDeactivate'
    ),
    'blocks' => array(
        array(
            'template' => 'page/checkout/payment.tpl',
            'block' => 'select_payment',
            'file' => '/views/blocks/crefopaypaymentselector.tpl'
        ),
        array(
            'template' => 'page/checkout/payment.tpl',
            'block' => 'checkout_payment_nextstep',
            'file' => '/views/blocks/crefopaypaymentnextstep.tpl'
        ),
        array(
            'template' => 'page/checkout/thankyou.tpl',
            'block' => 'checkout_thankyou_info',
            'file' => '/views/blocks/crefopaycheckoutthankyouinfo.tpl'
        ),
        array(
            'template' => 'email/html/order_cust.tpl',
            'block' => 'email_html_order_cust_paymentinfo_top',
            'file' => '/views/blocks/crefopayemailpaymentinfo.tpl'
        )
    ),
    // available Types: str | bool | arr | aarr | select | password
    'settings' => array(
        array(
            'group' => 'merchant',
            'name' => 'CrefoPayMerchantId',
            'type' => 'str'
        ),
        array(
            'group' => 'merchant',
            'name' => 'CrefoPayStoreId',
            'type' => 'str'
        ),
        array(
            'group' => 'merchant',
            'name' => 'CrefoPayPrivateKey',
            'type' => 'password'
        ),
        array(
            'group' => 'merchant',
            'name' => 'CrefoPayShopPublicKey',
            'type' => 'password'
        ),
        array(
            'group' => 'environment',
            'name' => 'CrefoPaySystemMode',
            'type' => 'select',
            'value' => '0',
            'constraints' => '0|1'
        ),
        array(
            'group' => 'environment',
            'name' => 'CrefoPayDefaultLang',
            'type' => 'select',
            'value' => 'DE',
            'constraints' => 'DE|EN|ES|FR|IT|NL'
        ),
        array(
            'group' => 'environment',
            'name' => 'CrefoPayAllowOtherPayments',
            'type' => 'select',
            'value' => '0',
            'constraints' => '0|1'
        ),
        array(
            'group' => 'environment',
            'name' => 'CrefoPayLogLevel',
            'type' => 'select',
            'value' => '0',
            'constraints' => '0|1|2'
        ),
        array(
            'group' => 'environment',
            'name' => 'CrefoPayLogFile',
            'type' => 'str'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayAutoCapture',
            'type' => 'bool'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayB2BEnabled',
            'type' => 'select',
            'value' => '0',
            'constraints' => '0|1'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayPrepaidPeriod',
            'type' => 'str',
            'value' => '14'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayBillPeriod',
            'type' => 'str',
            'value' => '30'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayBasketVal',
            'type' => 'str'
        ),
        array(
            'group' => 'transaction',
            'name' => 'CrefoPayBasketValUnit',
            'type' => 'select',
            'value' => 'h',
            'constraints' => 'h|m|d'
        ),
        array(
            'group' => 'images',
            'name' => 'CrefoPayCvvLogo',
            'type' => 'select',
            'value' => '1',
            'constraints' => '0|1'
        ),
        array(
            'group' => 'images',
            'name' => 'CrefoPayMcLogo',
            'type' => 'select',
            'value' => '1',
            'constraints' => '0|1'
        ),
        array(
            'group' => 'images',
            'name' => 'CrefoPayVisaLogo',
            'type' => 'select',
            'value' => '1',
            'constraints' => '0|1'
        )
    ),
    'templates' => array(
        'payment_crefobill.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefobill.tpl',
        'payment_crefocashondelivery.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefocashondelivery.tpl',
        'payment_crefocreditcard.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefocreditcard.tpl',
        'payment_crefodebit.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefodebit.tpl',
        'payment_crefopaypal.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefopaypal.tpl',
        'payment_crefoprepaid.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefoprepaid.tpl',
        'payment_crefosofort.tpl' => 'crefopay/cppayments/views/tpl/page/checkout/inc/payment_crefosofort.tpl',
    )
);
