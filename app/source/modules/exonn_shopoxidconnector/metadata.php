<?php

/**
 * Metadata version
 */
$sMetadataVersion = '1.1';

/*

Kann Konflikt mit Boniversum Modul geben!!!
exonn_boniversum_extend_payment -
exonn_connector_extend_payment - soll parent sein
exonn_boniversum_extend_oxpaymentlist -
exonn_connector_oxpaymentlist - soll parent sein

*/


// Je nach Installationsart zu oxid4 oder zu oxid6 kompatibel, da oxid4 Probleme mit den
// Unterverzeichnissen hat
if (file_exists('../modules/exonn/exonn_shopoxidconnector/models/exonnconnector_oxid.php'))
{
    $sDir = 'exonn/';
}
else
{
    $sDir ='';
}

/**
 * Module information
 */
$aModule = array(
    'id'          => 'exonn_shopoxidconnector',
    'title'       => 'EXONN WaWi OXID-Shop-Connector Modul',
    'description' => 'EXONN WaWi OXID-Shop-Connector Modul',
    'thumbnail'   => 'exonn_logo.png',
    'version'     => '3.3.2',
    'author'      => 'EXONN',
    'email'       => 'info@exonn.de',
    'url'         => 'http://www.oxidmodule24.de/',
    'events'       => array(
        'onActivate' 	=> 'exonnconnector_event::onActivate',
        'onDeactivate' 	=> 'exonnconnector_event::onDeactivate',
    ),
    'extend'      => array(
        'oxconfig'     => $sDir.'exonn_shopoxidconnector/models/exonnconnector_oxconfig',
        'oxarticle'     => $sDir.'exonn_shopoxidconnector/models/exonnconnector_oxarticle',
        'oxuser'        => $sDir.'exonn_shopoxidconnector/models/exonnconnector_oxuser',
        'oxorder'       => $sDir.'exonn_shopoxidconnector/models/exonnconnector_oxorder',
        'oxdeliverylist'=> $sDir.'exonn_shopoxidconnector/models/exonn_delext_oxdeliverylist',
        'oxdelivery'    => $sDir.'exonn_shopoxidconnector/models/exonn_delext_oxdelivery',
        'payment'       => $sDir.'exonn_shopoxidconnector/controllers/exonn_connector_extend_payment',
        'oxpaymentlist' => $sDir.'exonn_shopoxidconnector/models/exonn_connector_oxpaymentlist',
        'order'         => $sDir.'exonn_shopoxidconnector/controllers/exonn_connector_extend_order',
        'oxemail'         => $sDir.'exonn_shopoxidconnector/models/exonn_connector_oxemail',
    ),
    'files' => array(
        'exonnconnector_oxid'   => $sDir.'exonn_shopoxidconnector/models/exonnconnector_oxid.php',
        'exonnconnector_event'  => $sDir.'exonn_shopoxidconnector/models/exonnconnector_event.php',
        'oxbankingkonten'       => $sDir.'exonn_shopoxidconnector/models/oxbankingkonten.php',
        'exonn_shopconnector'   => $sDir.'exonn_shopoxidconnector/controllers/exonn_shopconnector.php',
    ),
    'templates' => array(
    ),
    'blocks' => array(
        array(
            'template'                                                      => 'page/account/dashboard.tpl',
            'block'                                                         =>'account_dashboard_col1',
            'file'                                                          => 'views/blocks/account_dashboard_col1.tpl'),
        array(
            'template'                                                      => 'page/checkout/inc/basketcontents.tpl',
            'block'                                                         => 'checkout_basket_vouchers',
            'file'                                                          => 'views/blocks/checkout_basket_vouchers.tpl'),
        array(
            'template'                                                      => 'page/checkout/inc/payment_other.tpl',
            'block'                                                         => 'checkout_payment_longdesc',
            'file'                                                          => 'views/blocks/payment_other.tpl'),
        array(
            'template'                                                      => 'page/checkout/inc/payment_oxiddebitnote.tpl',
            'block'                                                         => 'checkout_payment_longdesc',
            'file'                                                          => 'views/blocks/payment_oxiddebitnote.tpl')
    ),
    'settings' => array(
        array('group' => 'EXONN_CONNECTOR_NETTOPRICES_MAIN', 'name' => 'EXONN_CONNECTOR_SET_ABC_AS_NETTO', 'type' => 'bool',  'value' => false),
        array('group' => 'EXONN_CONNECTOR_NETTOPRICES_MAIN', 'name' => 'EXONN_CONNECTOR_SHOW_ABC_AS_NETTO', 'type' => 'bool',  'value' => false),
        array('group' => 'EXONN_CONNECTOR_NETTOPRICES_MAIN', 'name' => 'EXONN_CONNECTOR_EMAIL_COPY_BACK', 'type' => 'bool',  'value' => false),
        array('group' => 'EXONN_CONNECTOR_NETTOPRICES_MAIN', 'name' => 'EXONN_CONNECTOR_NOT_EMAIL_OWNER', 'type' => 'bool',  'value' => false),
    )

);

