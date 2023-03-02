<?php

// exonn_warehouse_oxorder - на последней позиции
// exonn_warehouse_order_article - на первой позиции

// заказы которые давно в New сторнировать если на складе эти товары есть. если нет то сторнировать не надо, могут ждать.

$aModule = array(
    'id'           => 'exonn_kaufbeitv',
    'title'        => 'exonn_kaufbeitv',
    'description'  => '',
    'thumbnail'    => 'exonn_logo.png',
    'version'      => '1.0.2',
    'author'       => 'EXONN',
    'email'        => 'info@exonn.de',
    'url'          => 'http://www.oxidmodule24.de/',

    'events'       => array(
        'onActivate' 	=> 'exonnkaufbei_event::onActivate',
        'onDeactivate' 	=> 'exonnkaufbei_event::onDeactivate',
    ),

    'files'        => array(
        'exonnkaufbei_event'                 => 'exonn_kaufbeitv/models/exonnkaufbei_event.php',
        'exonnkaufbei_cron'                  => 'exonn_kaufbeitv/controllers/exonnkaufbei_cron.php',
        'exonnkaufbei_installment'           => 'exonn_kaufbeitv/core/exonnkaufbei_installment.php',
    ),
    'extend'       => array(
        'oxarticle' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxarticle',
        'oxarticlelist' => 'exonn_kaufbeitv/models/exonn_warehouse_oxarticlelist',
        'oxcategory' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxcategory',
        'start' => 'exonn_kaufbeitv/controllers/exonn_kaufbei_start',
        'alist' => 'exonn_kaufbeitv/controllers/exonn_kaufbei_alist',
        'oxwidgetcontrol' => 'exonn_kaufbeitv/controllers/exonn_kaufbei_details',
        'oxcategorylist' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxcategorylist',
        'oxactionlist' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxactionlist',
        'oxactions' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxactions',
        'oxwarticledetails'   => 'exonn_kaufbeitv/controllers/exonn_kaufbei_articledetailswidget',
        'oxwcategorytree' => 'exonn_kaufbeitv/Component/Widget/exonn_marketplace_category_tree',
        'details'   => 'exonn_kaufbeitv/controllers/exonn_kaufbei_articledetails',
        'manufacturerlist'   => 'exonn_kaufbeitv/controllers/exonn_kaufbei_manufacturerlist',
        'oxpaymentlist' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxpaymentlist',
        'oxbasket' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxbasket',
        'oxorder' => 'exonn_kaufbeitv/models/exonn_kaufbei_oxorder',
    ),
    'blocks' => array(
        array(
            'template'                                                      => 'page/checkout/inc/payment_other.tpl',
            'block'                                                         => 'checkout_payment_longdesc',
            'file'                                                          => 'views/blocks/payment_other.tpl'),
    ),
);