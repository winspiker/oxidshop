<?php
/**
 * You are allowed to use this API in your web application.
 *
 * Copyright (C) 2018 by customweb GmbH
 *
 * This program is licenced under the customweb software licence. With the
 * purchase or the installation of the software in your application you
 * accept the licence agreement. The allowed usage is outlined in the
 * customweb software licence which can be found under
 * http://www.sellxed.com/en/software-license-agreement
 *
 * Any modification or distribution is strictly forbidden. The license
 * grants you the installation in one application. For multiuse you will need
 * to purchase further licences at http://www.sellxed.com/shop.
 *
 * See the customweb software licence agreement for more details.
 *
 *
 * @category	Customweb
 * @package		Customweb_PayPalPlusCw
 * @version		2.0.224
 */

/**
 * Metadata version
 */
$sMetadataVersion = '1.1';

/**
 * Module information
 */
$aModule = array(
	'id'           => 'paypalpluscw',
	'title'        => 'PayPalPlusCw',
	'description'  => array(
		'de' => 'Integriert PayPalPlusCw in OXID eSales Shop.',
		'en' => 'Integrates PayPalPlusCw into the OXID eSales shop.'
	),
	'version'      => '2.0.224',
	'author'       => 'customweb GmbH',
	'extend'       => array(
		'module_config' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_module_config',
		'thankyou' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_thankyou',
		'navigation' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_navigation',
		'payment_list' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_payment_list',
		'payment' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_payment',
		'order_list' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_order_list',
		'order' => 'customweb/paypalpluscw/controllers/core/paypalpluscw_order',
		'oxbasketitem' => 'customweb/paypalpluscw/models/core/paypalpluscw_oxbasketitem',
		'oxpayment' => 'customweb/paypalpluscw/models/core/paypalpluscw_oxpayment',
		'oxorder' => 'customweb/paypalpluscw/models/core/paypalpluscw_oxorder',
		'oxuserpayment' => 'customweb/paypalpluscw/models/core/paypalpluscw_oxuserpayment',
		'oxconfig' => 'customweb/paypalpluscw/core/paypalpluscw_oxconfig',
		'oxemail' => 'customweb/paypalpluscw/core/paypalpluscw_oxemail',
		'oxlang' => 'customweb/paypalpluscw/core/paypalpluscw_oxlang',
		'oxinputvalidator' => 'customweb/paypalpluscw/core/paypalpluscw_oxinputvalidator',
		'oxsession' => 'customweb/paypalpluscw/core/paypalpluscw_oxsession',
		'oxwlanguagelist' => 'customweb/paypalpluscw/components/core/widgets/paypalpluscw_oxwlanguagelist',
		'oxwservicemenu' => 'customweb/paypalpluscw/components/core/widgets/paypalpluscw_oxwservicemenu',
		'oxwcurrencylist' => 'customweb/paypalpluscw/components/core/widgets/paypalpluscw_oxwcurrencylist',
	),
	'files'			=> array(
		'paypalpluscw_breakout' => 'customweb/paypalpluscw/controllers/paypalpluscw_breakout.php',
		'paypalpluscw_widget' => 'customweb/paypalpluscw/controllers/paypalpluscw_widget.php',
		'paypalpluscw_redirect' => 'customweb/paypalpluscw/controllers/paypalpluscw_redirect.php',
		'paypalpluscw_cron' => 'customweb/paypalpluscw/controllers/paypalpluscw_cron.php',
		'paypalpluscw_payment' => 'customweb/paypalpluscw/controllers/paypalpluscw_payment.php',
		'paypalpluscw_transaction_refund_form' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_refund_form.php',
		'paypalpluscw_payment_settings' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_payment_settings.php',
		'paypalpluscw_transaction_capture_form' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_capture_form.php',
		'paypalpluscw_backendform' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_backendform.php',
		'paypalpluscw_order_transactions' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_order_transactions.php',
		'paypalpluscw_transaction_refund' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_refund.php',
		'paypalpluscw_transaction_view' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_view.php',
		'paypalpluscw_transaction_admin' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_admin.php',
		'paypalpluscw_transaction_list' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_list.php',
		'paypalpluscw_transaction_capture' => 'customweb/paypalpluscw/controllers/admin/paypalpluscw_transaction_capture.php',
		'paypalpluscw_alias' => 'customweb/paypalpluscw/controllers/paypalpluscw_alias.php',
		'paypalpluscw_process' => 'customweb/paypalpluscw/controllers/paypalpluscw_process.php',
		'paypalpluscw_iframe' => 'customweb/paypalpluscw/controllers/paypalpluscw_iframe.php',
		'paypalpluscw_template' => 'customweb/paypalpluscw/controllers/paypalpluscw_template.php',
		'paypalpluscw_layout' => 'customweb/paypalpluscw/controllers/paypalpluscw_layout.php',
		'paypalpluscw_pending' => 'customweb/paypalpluscw/controllers/paypalpluscw_pending.php',
		'paypalpluscw_endpoint' => 'customweb/paypalpluscw/controllers/paypalpluscw_endpoint.php',

		'PayPalPlusCwConfigurationAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwConfigurationAdapter.php',
		'PayPalPlusCwAdapterServerAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterServerAdapter.php',
		'PayPalPlusCwTransactionCleanUpCron' => 'customweb/paypalpluscw/classes/PayPalPlusCwTransactionCleanUpCron.php',
		'PayPalPlusCwLicenseAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwLicenseAdapter.php',
		'PayPalPlusCwBackendCancelAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwBackendCancelAdapter.php',
		'PayPalPlusCwAdapterHiddenAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterHiddenAdapter.php',
		'PayPalPlusCwTransactionContext' => 'customweb/paypalpluscw/classes/PayPalPlusCwTransactionContext.php',
		'PayPalPlusCwBackendRefundAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwBackendRefundAdapter.php',
		'PayPalPlusCwBackendCaptureAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwBackendCaptureAdapter.php',
		'PayPalPlusCwOrderContext' => 'customweb/paypalpluscw/classes/PayPalPlusCwOrderContext.php',
		'PayPalPlusCwControlCssClassResolver' => 'customweb/paypalpluscw/classes/PayPalPlusCwControlCssClassResolver.php',
		'PayPalPlusCwAdapterPaymentPageAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterPaymentPageAdapter.php',
		'PayPalPlusCwPaymentMethodSetting' => 'customweb/paypalpluscw/classes/PayPalPlusCwPaymentMethodSetting.php',
		'PayPalPlusCwStorage' => 'customweb/paypalpluscw/classes/PayPalPlusCwStorage.php',
		'PayPalPlusCwPaymentMethod' => 'customweb/paypalpluscw/classes/PayPalPlusCwPaymentMethod.php',
		'PayPalPlusCwLayoutRenderer' => 'customweb/paypalpluscw/classes/PayPalPlusCwLayoutRenderer.php',
		'PayPalPlusCwAdapterIAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterIAdapter.php',
		'PayPalPlusCwSetup' => 'customweb/paypalpluscw/classes/PayPalPlusCwSetup.php',
		'PayPalPlusCwAdapterAbstractAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterAbstractAdapter.php',
		'PayPalPlusCwEndpointAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwEndpointAdapter.php',
		'PayPalPlusCwAdapterIframeAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterIframeAdapter.php',
		'PayPalPlusCwHelper' => 'customweb/paypalpluscw/classes/PayPalPlusCwHelper.php',
		'PayPalPlusCwFormControlAgb' => 'customweb/paypalpluscw/classes/PayPalPlusCwFormControlAgb.php',
		'PayPalPlusCwBackendFormRenderer' => 'customweb/paypalpluscw/classes/PayPalPlusCwBackendFormRenderer.php',
		'PayPalPlusCwFormValidatorAgb' => 'customweb/paypalpluscw/classes/PayPalPlusCwFormValidatorAgb.php',
		'PayPalPlusCwTranslationResolver' => 'customweb/paypalpluscw/classes/PayPalPlusCwTranslationResolver.php',
		'PayPalPlusCwPaymentCustomerContext' => 'customweb/paypalpluscw/classes/PayPalPlusCwPaymentCustomerContext.php',
		'PayPalPlusCwTransaction' => 'customweb/paypalpluscw/classes/PayPalPlusCwTransaction.php',
		'PayPalPlusCwFormRenderer' => 'customweb/paypalpluscw/classes/PayPalPlusCwFormRenderer.php',
		'PayPalPlusCwPreparation' => 'customweb/paypalpluscw/classes/PayPalPlusCwPreparation.php',
		'PayPalPlusCwDocument' => 'customweb/paypalpluscw/classes/PayPalPlusCwDocument.php',
		'PayPalPlusCwAdapterAjaxAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterAjaxAdapter.php',
		'PayPalPlusCwLoggingListener' => 'customweb/paypalpluscw/classes/PayPalPlusCwLoggingListener.php',
		'PayPalPlusCwDatabaseConnectionWrapper' => 'customweb/paypalpluscw/classes/PayPalPlusCwDatabaseConnectionWrapper.php',
		'PayPalPlusCwContextRequest' => 'customweb/paypalpluscw/classes/PayPalPlusCwContextRequest.php',
		'PayPalPlusCwAdapterWidgetAdapter' => 'customweb/paypalpluscw/classes/PayPalPlusCwAdapterWidgetAdapter.php',
		'PayPalPlusCwDatabaseDriver' => 'customweb/paypalpluscw/classes/PayPalPlusCwDatabaseDriver.php',

		'paypalpluscw_transaction' => 'customweb/paypalpluscw/models/paypalpluscw_transaction.php',
	),
	'blocks'		=> array(
		array('template' => 'page/checkout/user.tpl', 'block' => 'checkout_user_main', 'file' => 'views/blocks/page/checkout/user/checkout_user_main.tpl'),
		array('template' => 'page/checkout/thankyou.tpl', 'block' => 'checkout_thankyou_info', 'file' => 'views/blocks/page/checkout/thankyou/checkout_thankyou_info.tpl'),
		array('template' => 'page/checkout/order.tpl', 'block' => 'checkout_order_btn_confirm_bottom', 'file' => 'views/blocks/page/checkout/order/checkout_order_btn_confirm_bottom.tpl'),
		array('template' => 'page/checkout/basket.tpl', 'block' => 'checkout_basket_main', 'file' => 'views/blocks/page/checkout/basket/checkout_basket_main.tpl'),
		array('template' => 'page/checkout/payment.tpl', 'block' => 'checkout_payment_errors', 'file' => 'views/blocks/page/checkout/payment/checkout_payment_errors.tpl'),
		array('template' => 'page/checkout/payment.tpl', 'block' => 'select_payment', 'file' => 'views/blocks/page/checkout/payment/select_payment.tpl'),
		array('template' => 'page/checkout/payment.tpl', 'block' => 'checkout_payment_main', 'file' => 'views/blocks/page/checkout/payment/checkout_payment_main.tpl'),
		array('template' => 'page/checkout/payment.tpl', 'block' => 'mb_select_payment', 'file' => 'views/blocks/page/checkout/payment/mb_select_payment.tpl'),
		array('template' => 'page/checkout/payment.tpl', 'block' => 'checkout_payment_nextstep', 'file' => 'views/blocks/page/checkout/payment/checkout_payment_nextstep.tpl'),
		array('template' => 'email/plain/order_cust.tpl', 'block' => 'email_plain_order_cust_paymentinfo', 'file' => 'views/blocks/email/plain/order_cust/email_plain_order_cust_paymentinfo.tpl'),
		array('template' => 'email/html/order_cust.tpl', 'block' => 'email_html_order_cust_paymentinfo_top', 'file' => 'views/blocks/email/html/order_cust/email_html_order_cust_paymentinfo_top.tpl'),
		array('template' => 'module_config.tpl', 'block' => 'admin_module_config_var_types', 'file' => 'views/blocks/module_config/admin_module_config_var_types.tpl'),
	),
	'events'		=> array(
		'onActivate'   => 'PayPalPlusCwSetup::onActivate',
		'onDeactivate' => 'PayPalPlusCwSetup::onDeactivate'
	),
	'templates'		=> array(
		'paypalpluscw_transaction.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction.tpl',
		'paypalpluscw_order_transactions_missing.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_order_transactions_missing.tpl',
		'paypalpluscw_transaction_refund.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_refund.tpl',
		'paypalpluscw_transaction_list.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_list.tpl',
		'paypalpluscw_payment_settings.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_payment_settings.tpl',
		'paypalpluscw_order_transactions.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_order_transactions.tpl',
		'paypalpluscw_order_transactions_pending.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_order_transactions_pending.tpl',
		'paypalpluscw_backendform.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_backendform.tpl',
		'paypalpluscw_transaction_refund_form.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_refund_form.tpl',
		'paypalpluscw_payment_list.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_payment_list.tpl',
		'paypalpluscw_order_transactions_invalid.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_order_transactions_invalid.tpl',
		'paypalpluscw_order_list.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_order_list.tpl',
		'paypalpluscw_payment_settings_invalid.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_payment_settings_invalid.tpl',
		'paypalpluscw_transaction_capture.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_capture.tpl',
		'paypalpluscw_transaction_capture_form.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_capture_form.tpl',
		'paypalpluscw_transaction_view.tpl' => 'customweb/paypalpluscw/views/admin/tpl/paypalpluscw_transaction_view.tpl',
		'paypalpluscw_iframe.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/iframe.tpl',
		'paypalpluscw_payment.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/payment.tpl',
		'paypalpluscw_template.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/template.tpl',
		'paypalpluscw_agb.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/agb.tpl',
		'paypalpluscw_layout.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/layout.tpl',
		'paypalpluscw_redirect.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/redirect.tpl',
		'paypalpluscw_widget.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/widget.tpl',
		'paypalpluscw_breakout.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/breakout.tpl',
		'paypalpluscw_pending.tpl' => 'customweb/paypalpluscw/views/azure/tpl/page/paypalpluscw/pending.tpl',
		'paypalpluscw_header_servicemenu.tpl' => 'customweb/paypalpluscw/views/azure/tpl/widgets/paypalpluscw/header/servicemenu.tpl',
		'paypalpluscw_header_currencies.tpl' => 'customweb/paypalpluscw/views/azure/tpl/widgets/paypalpluscw/header/currencies.tpl',
		'paypalpluscw_header_languages.tpl' => 'customweb/paypalpluscw/views/azure/tpl/widgets/paypalpluscw/header/languages.tpl',
	),
	'settings'		=> array(
		array(
			'name' => 'paypalpluscw_operation_mode',
 			'type' => 'cwselect',
 			'value' => 'test',
 			'constraints' => 'test|live',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_id_live',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_secret_live',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_id_test',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_rest_client_secret_test',
 			'type' => 'str',
 			'value' => '',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_description_schema',
 			'type' => 'str',
 			'value' => 'Order {id}',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_shop_name',
 			'type' => 'str',
 			'value' => 'This shop',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_seller_protection',
 			'type' => 'multiselect',
 			'value' => 'ineligible',
 			'constraints' => 'ineligible|itemNotReceived|unauthorizedPayment',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_address_check',
 			'type' => 'cwselect',
 			'value' => 'enabled',
 			'constraints' => 'enabled|disabled',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_update_interval',
 			'type' => 'str',
 			'value' => '0',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_creation',
 			'type' => 'cwselect',
 			'value' => 'after',
 			'constraints' => 'before|after',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_order_id',
 			'type' => 'cwselect',
 			'value' => 'default',
 			'constraints' => 'default|enforce',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_delete_failed_orders',
 			'type' => 'cwselect',
 			'value' => 'no',
 			'constraints' => 'yes|no',
 			'group' => 'paypalpluscw',
 		),
		array(
			'name' => 'paypalpluscw_logging_level',
 			'type' => 'cwselect',
 			'value' => 'error',
 			'constraints' => 'error|info|debug',
 			'group' => 'paypalpluscw',
 		),
		//List payment method settings, to avoid deletion upon reactivation
		array(
			'name' => 'paypal_capturing',
 			'type' => 'select',
 			'value' => 'sale',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_status_finallydeclined',
 			'type' => 'select',
 			'value' => 'no_status_change',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_status_authorized',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_NEW',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_status_uncertain',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_PROBLEMS',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_status_cancelled',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_FINISHED',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_status_captured',
 			'type' => 'select',
 			'value' => 'no_status_change',
 			'group' => null,
 		),
		array(
			'name' => 'paypal_authorizationMethod',
 			'type' => 'select',
 			'value' => 'PaymentPage',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_status_authorized',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_NEW',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_status_uncertain',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_PROBLEMS',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_status_cancelled',
 			'type' => 'select',
 			'value' => 'ORDERFOLDER_FINISHED',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_status_captured',
 			'type' => 'select',
 			'value' => 'no_status_change',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_status_finallydeclined',
 			'type' => 'select',
 			'value' => 'no_status_change',
 			'group' => null,
 		),
		array(
			'name' => 'paypalplus_authorizationMethod',
 			'type' => 'select',
 			'value' => 'AjaxAuthorization',
 			'group' => null,
 		),


	)
);

require_once 'classes/PayPalPlusCwPreparation.php';
PayPalPlusCwPreparation::alterVarLengths();