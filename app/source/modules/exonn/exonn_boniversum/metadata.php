<?php


$aModule = array(
    'id'           => 'exonn_boniversum',
    'title'        => 'EXONN Boniversum Module',
    'description'  => 'EXONN Boniversum Module',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0.0',//
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'events'       => array(
    	'onActivate' 	=> 'exonnboniversum_event::onActivate',
		'onDeactivate' 	=> 'exonnboniversum_event::onDeactivate',
        ),

    'files'        => array(
        'exonn_boniversum_payment'                 => 'exonn/exonn_boniversum/Controller/exonn_boniversum_payment.php',
        'exonn_boniversum_securitypayment'                 => 'exonn/exonn_boniversum/Controller/exonn_boniversum_securitypayment.php',
        'exonnboniversum_event'                 => 'exonn/exonn_boniversum/Model/exonnboniversum_event.php',
        'exonn_boniversum'                 => 'exonn/exonn_boniversum/Model/exonn_boniversum.php',
        'exonn_boniversumpayments'                 => 'exonn/exonn_boniversum/Model/exonn_boniversumpayments.php',
    ),

    'templates'    => array(
        'exonn_boniversum_payment.tpl'      => 'exonn/exonn_boniversum/views/exonn_boniversum_payment.tpl',
        'exonn_boniversum_securitypayment.tpl'      => 'exonn/exonn_boniversum/views/exonn_boniversum_securitypayment.tpl',

    ),
    'extend'       => array(
        'payment'                 => 'exonn/exonn_boniversum/Controller/exonn_boniversum_extend_payment',
        'user'                 => 'exonn/exonn_boniversum/Controller/exonn_boniversum_extend_user',
        'oxbasket'              => 'exonn/exonn_boniversum/Model/exonn_boniversum_extend_oxbasket',
        'oxpaymentlist'         => 'exonn/exonn_boniversum/Model/exonn_boniversum_extend_oxpaymentlist',
        'oxpaymentgateway'       => 'exonn/exonn_boniversum/Model/exonn_boniversum_oxpaymentgateway',
    ),

    'blocks' => array(
        array('template' => 'page/checkout/payment.tpl',          'block'=>'checkout_payment_errors',      'file'=>'/views/blocks/exonnboniversum_payment_errors.tpl'),

    ),

    'settings' => array(
        array('group' => 'EXONN_BONIVERSUM_SETTINGMAIN', 'name' => 'EXONN_BONIVERSUM_PRODID', 'type' => 'str'),
        array('group' => 'EXONN_BONIVERSUM_SETTINGMAIN', 'name' => 'EXONN_BONIVERSUM_USERNAME', 'type' => 'str'),
        array('group' => 'EXONN_BONIVERSUM_SETTINGMAIN', 'name' => 'EXONN_BONIVERSUM_PASSWORD', 'type' => 'str'),
        array('group' => 'EXONN_BONIVERSUM_SETTINGMAIN', 'name' => 'EXONN_BONIVERSUM_SAVEPERIODE', 'type' => 'str'),
    )

);