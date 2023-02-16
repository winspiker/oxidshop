[{capture append="oxidBlock_content"}]
    [{* ordering steps *}]
    [{include file="page/checkout/inc/steps.tpl" active=3}]

    [{block name="checkout_payment_main"}]
        [{assign var="currency" value=$oView->getActCurrency()}]

        [{block name="checkout_payment_errors"}]
            [{assign var="iPayError" value=$oView->getPaymentError()}]

                [{if $iPayError == 1}]
                    <div class="alert alert-danger">[{oxmultilang ident="ERROR_MESSAGE_COMPLETE_FIELDS_CORRECTLY"}]</div>
                [{elseif $iPayError == 2}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError == 4}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_UNAVAILABLE_SHIPPING_METHOD"}]</div>
                [{elseif $iPayError == 5}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError == 6}]
                    <div class="alert alert-danger">[{oxmultilang ident="TRUSTED_SHOP_UNAVAILABLE_PROTECTION"}]</div>
                [{elseif $iPayError > 6}]
                    <!--Add custom error message here-->
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_AUTHORIZATION_FAILED"}]</div>
                [{elseif $iPayError == -1}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_UNAVAILABLE_PAYMENT_ERROR"}] "[{$oView->getPaymentErrorText()}]").</div>
                [{elseif $iPayError == -2}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_NO_SHIPPING_METHOD_FOUND"}]</div>
                [{elseif $iPayError == -3}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_SELECT_ANOTHER_PAYMENT"}]</div>
                [{elseif $iPayError == -4}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_BANK_CODE_INVALID"}]</div>
                [{elseif $iPayError == -5}]
                    <div class="alert alert-danger">[{oxmultilang ident="MESSAGE_PAYMENT_ACCOUNT_NUMBER_INVALID"}]</div>
                [{/if}]
        [{/block}]

		<div class="row">
        [{block name="change_payment"}]
            [{oxscript include="js/widgets/oxpayment.min.js" priority=10}]
            [{oxscript include="js/libs/jqBootstrapValidation.min.js?1234" priority=10}]
            [{oxscript add="$( '#payment' ).oxPayment();"}]
            [{oxscript add="$('input,select,textarea').not('[type=submit]').jqBootstrapValidation();"}]
			<div class="col-sm-6">
            <form action="[{$oViewConf->getSslSelfLink()}]" class="form-horizontal js-oxValidate payment" id="payment" name="order" method="post" novalidate="novalidate">
                <div class="hidden">
                    [{$oViewConf->getHiddenSid()}]
                    [{$oViewConf->getNavFormParams()}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                    <input type="hidden" name="fnc" value="validatepayment">
                </div>

                [{if $oView->getPaymentList()}]
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 id="paymentHeader" class="panel-title">[{oxmultilang ident="PAYMENT_METHOD"}]</h3>
                        </div>
                        <style>

                            .payment dl {
                                margin-bottom: 0 !important;
                            }

                            .payment-methods > * {
                                display: block !important;
                                padding: 0 !important;
                                margin: 0 !important;
                            }

                            .payment-methods > * + * {
                                border-top: solid 1px #f7f7f7 !important;
                                margin-top: 10px !important;
                                margin-bottom: 0 !important;
                                padding-top: 10px !important;
                            }

                            .payment-methods .klarna-logo-wrap {
                                display: none;
                            }

                            .payment-methods .float-left {
                                position: relative;
                            }

                            .payment-methods #klarna_part #payment_klarna_part {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #klarna_part #payment_klarna_part + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #klarna_part #payment_klarna_part + label > * {
                                display: block;
                                box-sizing: border-box;

                                margin-right: 5px;
                            }

                            .payment-methods #klarna_part #payment_klarna_part + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/kralna_ratenkauf.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }


                            .payment-methods #klarna_invoice dt {
                                min-height: 0 !important;
                            }

                            .payment-methods #klarna_invoice #payment_klarna_invoice {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #klarna_invoice #payment_klarna_invoice + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #klarna_invoice #payment_klarna_invoice + label > * {
                                display: block;
                                box-sizing: border-box;

                                margin-right: 5px;
                            }

                            .payment-methods #klarna_invoice #payment_klarna_invoice + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/klarna_Rechnung.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }


                            .payment-methods dt {
                                position: relative;
                                display: block;
                            }

                            .payment-methods #payment_oxidpayadvance {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_oxidpayadvance + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_oxidpayadvance + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/vorkasse.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }


                            .payment-methods #payment_oxidcashondel {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_oxidcashondel + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_oxidcashondel + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/DHL.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }

                            .payment-methods #payment_oxidinvoice {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_oxidinvoice + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_oxidinvoice + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/rechnung.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }

                            .payment-methods #payment_bestitamazon {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_bestitamazon + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_bestitamazon + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/amazon-pay.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }



                            .payment-methods #payment_molliesofort {
                                 position: absolute;
                                 top: 50%;
                                 transform: translateY(-50%);
                                 margin-top: 0;
                             }

                            .payment-methods #payment_molliesofort + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_molliesofort + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/sofort.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }

                            .payment-methods #payment_mollieapplepay {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_mollieapplepay + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_mollieapplepay + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/applepay.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }


                            .payment-methods #payment_molliecreditcard {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_molliecreditcard + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_molliecreditcard + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/creditcard.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }

                            .payment-methods #payment_molliegiropay {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_molliegiropay + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_molliegiropay + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/giropay.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }


                            .mollie-payment-icon {
                                display: none !important;
                            }




                            .payment-methods #payment_e946f33709a09d842c177340c709d7a3 {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }

                            .payment-methods #payment_e946f33709a09d842c177340c709d7a3 + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }

                            .payment-methods #payment_e946f33709a09d842c177340c709d7a3 + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/ups_nachname.jpg?dff) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                                background-size: 100px 50px;
                            }

                            .payment-methods dl {
                                position: relative;
                                display: block;
                            }

                            .payment-methods dl #payment_paypalpluscw_paypalplus {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }
                            @media (max-width:1200px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus {
                                    transform: unset;
                                    top: 30px;
                                }
                            }
                            .payment-methods dl #payment_paypalpluscw_paypalplus + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;
                            }
                            @media (max-width:1200px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label {
                                    padding-top: 25px;
                                    padding-bottom: 60px;
                                }
                            }
                            @media (max-width:767px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label {
                                    padding: 15px 0 15px 140px;
                                }
                            }
                            @media (max-width:550px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label {
                                    padding-top: 25px;
                                    padding-bottom: 60px;
                                }
                            }
                            .payment-methods dl > dt {
                                position: relative;
                            }

                            .payment-methods dl #payment_paypalpluscw_paypalplus + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top:10px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/paypal.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }
                            .payment-methods dl #payment_paypalpluscw_paypalplus + label img{
                                display: block;
                                max-width: 60px;
                                margin: 0 5px;
                            }

                            .payment-methods dl #payment_paypalpluscw_paypalplus + label img.rechnung-logo {
                                max-width: 37px !important;
                            }
                            .payment-methods dl #payment_paypalpluscw_paypalplus + label .wrapp-img-payment-paypalplu{
                                display: flex;
                                align-items: center;
                                margin-left: 20px;
                                border: solid 1px #f7f7f7;
                                padding: 5px;
                                width: 270px;
                            }
                            @media (max-width:1200px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label .wrapp-img-payment-paypalplu{
                                    position: absolute;
                                    bottom: 0;
                                    left: 0;
                                    margin-left:0;
                                }
                            }
                            @media (max-width:767px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label .wrapp-img-payment-paypalplu{
                                    position: unset;
                                    bottom: unset;
                                    left:unset;
                                    margin-left: 20px;
                                }
                            }
                            @media (max-width:550px){
                                .payment-methods dl #payment_paypalpluscw_paypalplus + label .wrapp-img-payment-paypalplu{
                                    position: absolute;
                                    bottom: 0;
                                    left: 0;
                                    margin-left:0;
                                }
                            }
                            .payment-methods  #payment_mp_creditcard, .payment-methods  #payment_oxidcreditcard {
                                position: absolute;
                                top: 50%;
                                transform: translateY(-50%);
                                margin-top: 0;
                            }



                            .payment-methods  #payment_mp_creditcard + label, .payment-methods  #payment_oxidcreditcard + label {
                                display: flex;
                                flex-wrap: wrap;
                                align-items: center;
                                margin: 0 !important;
                                padding: 15px 0 15px 140px;
                                min-height: 70px;
                                text-indent: 0;
                                position: relative;

                            }



                            .payment-methods  #payment_mp_creditcard + label:before,  .payment-methods  #payment_oxidcreditcard + label:before {
                                display: block;
                                content: '';
                                width: 100px;
                                height: 50px;
                                box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                position: absolute;
                                left: 25px;
                                top: 50%;
                                margin-top: -25px;
                                background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/creditcard.svg) center no-repeat;
                                border-radius: 10px;
                                overflow: hidden;
                            }


                            .payment-methods .col-lg-offset-3 {
                                margin-left: 0 !important;
                            }



                        </style>
                        <div class="panel-body payment-methods">
                            [{assign var="inptcounter" value="-1"}]
                            [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                                [{assign var="inptcounter" value="`$inptcounter+1`"}]
                                [{block name="select_payment"}]
                                    <div class="well well-sm">
                                        [{if $sPaymentID == "oxidcashondel"}]
                                            [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                                        [{elseif $sPaymentID == "oxidcreditcard"}]
                                            [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                                        [{elseif $sPaymentID == "oxiddebitnote"}]
                                            [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                                        [{else}]
                                            [{include file="page/checkout/inc/payment_other.tpl"}]
                                        [{/if}]
                                    </div>
                                [{/block}]
                            [{/foreach}]

                        </div>
                    </div>

                    [{block name="checkout_payment_nextstep"}]
                        [{if $oView->isLowOrderPrice()}]
                            <div class="alert alert-info">
                                <b>[{oxmultilang ident="MIN_ORDER_PRICE"}] [{$oView->getMinOrderPrice()}] [{$currency->sign}]</b>
                            </div>
                        [{else}]
                            <div class="well well-sm cart-buttons">
                                <a href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]" class="btn btn-default pull-left prevStep submitButton largeButton" id="paymentBackStepBottom"><i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
                                <button type="submit" name="userform" class="btn btn-primary pull-right submitButton nextStep largeButton" id="paymentNextStepBottom">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}] <i class="fa fa-caret-right"></i></button>
                                <div class="clearfix"></div>
                            </div>
                        [{/if}]
                    [{/block}]

                [{elseif $oView->getEmptyPayment()}]
                    [{block name="checkout_payment_nopaymentsfound"}]
                        <div class="lineBlock"></div>
                        <h3 id="paymentHeader" class="blockHead">[{oxmultilang ident="PAYMENT_INFORMATION"}]</h3>
                        [{oxifcontent ident="oxnopaymentmethod" object="oCont"}]
                            [{$oCont->oxcontents__oxcontent->value}]
                        [{/oxifcontent}]
                        <input type="hidden" name="paymentid" value="oxempty">
                        <div class="lineBox clear">
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user"}]" class="btn btn-default pull-left prevStep submitButton largeButton"><i class="fa fa-caret-left"></i> [{oxmultilang ident="PREVIOUS_STEP"}]</a>
                            <button type="submit" name="userform" class="btn btn-primary pull-right submitButton nextStep largeButton" id="paymentNextStepBottom">[{oxmultilang ident="CONTINUE_TO_NEXT_STEP"}] <i class="fa fa-caret-right"></i></button>
                        </div>
                    [{/block}]
                [{/if}]
            </form>
			</div>
        [{/block}]

		[{block name="change_shipping"}]
            [{if $oView->getAllSets()}]
                [{assign var="aErrors" value=$oView->getFieldValidationErrors()}]
				<div class="col-sm-6">
                <form action="[{$oViewConf->getSslSelfLink()}]" name="shipping" id="shipping" method="post">
                    <div class="hidden">
                        [{$oViewConf->getHiddenSid()}]
                        [{$oViewConf->getNavFormParams()}]
                        <input type="hidden" name="cl" value="[{$oViewConf->getActiveClassName()}]">
                        <input type="hidden" name="fnc" value="changeshipping">
                    </div>
                        		<style>
                                    .shipping-methods .form-group {
                                        padding: 15px 0 15px 115px;
                                        position: relative;
                                    }


                                    .shipping-methods .form-group:before {
                                        display: block;
                                        content: '';
                                        width: 100px;
                                        height: 100px;
                                        box-shadow: 0px 1px 3px 0px rgba(0,0,0,0.2);
                                        position: absolute;
                                        left: 0;
                                        top: 50%;
                                        margin-top: -50px;
                                        background: url(https://kaufbei.tv/out/flow_kaufbei_2020/img/DHL-shipping.svg?sds) center no-repeat;
                                        border-radius: 10px;
                                        overflow: hidden;
                                    }
									
								
									
									
									
								</style>
                    <div class="panel shipping-methods">
                        <div class="panel-heading">
                            <h3 class="panel-title">[{if $oView->getAllSetsCnt() > 1}][{oxmultilang ident="SELECT_SHIPPING_METHOD"}][{else}][{oxmultilang ident="SELECTED_SHIPPING_CARRIER"}][{/if}]</h3>
                        </div>
                        <div class="panel-body">
                            [{block name="act_shipping"}]
                                <div class="form-group">
                                    <select class="form-control selectpicker" name="sShipSet" onchange="this.form.submit();">
                                        [{foreach key=sShipID from=$oView->getAllSets() item=oShippingSet name=ShipSetSelect}]
                                            <option value="[{$sShipID}]" [{if $oShippingSet->blSelected}]SELECTED[{/if}]>[{$oShippingSet->oxdeliveryset__oxtitle->value}]</option>
                                        [{/foreach}]
                                    </select>
                                </div>
                                <noscript>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-success submitButton largeButton">[{oxmultilang ident="UPDATE_SHIPPING_CARRIER"}]</button>
                                    </div>
                                </noscript>
                            [{/block}]

                            [{assign var="oDeliveryCostPrice" value=$oxcmp_basket->getDeliveryCost()}]
                            [{if $oDeliveryCostPrice && $oDeliveryCostPrice->getPrice() > 0}]
                                [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                                    <div id="shipSetCost">
                                        <b>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getNettoPrice() currency=$currency}]
                                            ([{oxmultilang ident="PLUS_VAT"}] [{oxprice price=$oDeliveryCostPrice->getVatValue() currency=$currency}])
                                        </b>
                                    </div>
                                [{else}]
                                    <div id="shipSetCost">
                                        <b>[{oxmultilang ident="CHARGES" suffix="COLON"}] [{oxprice price=$oDeliveryCostPrice->getBruttoPrice() currency=$currency}]</b>
                                    </div>
                                [{/if}]
                            [{/if}]
                        </div>
                    </div>
                </form>
				</div>
            [{/if}]
        [{/block}]
    [{/block}]
	</div>
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]

[{include file="layout/page.tpl"}]
