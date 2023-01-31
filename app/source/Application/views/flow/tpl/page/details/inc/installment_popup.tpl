[{oxscript include="js/libs/jquery.magnific-popup.min.js"}]
[{oxscript include="js/libs/jquery.installment_popup.js"}]
[{oxstyle include="css/libs/jquery.magnific-popup.css"}]
[{oxstyle include="css/libs/popup.css"}]

<ui id="inline-popups">
    <a href="#test-popup" data-effect="mfp-zoom-in">
        <img src="[{$oViewConf->getImageUrl('installment_logo.png')}]"
             width=60 alt="asd">
    </a>
</ui>

<div id="test-popup" class="white-popup mfp-with-anim mfp-bg mfp-hide">
    <div class="wrapper">
        <div class="title">
            <img src="[{$oViewConf->getImageUrl('installment.jpg')}]" alt="installment">
            <header>[{oxmultilang ident="INSTALLMENT_TITLE"}]</header>
        </div>
        <div class="content">
            <div class="popupText">
                <div class="block1 ">
                    [{oxmultilang ident="INSTALLMENT_FIRST_PAYMENT"}]
                </div>
                <div class="block2">
                    [{$oFirstPayment->getPrice()}] [{$currency->sign}]
                </div>
            </div>
            <div class="popupText">
                <div class="block1 ">
                    [{oxmultilang ident="INSTALLMENT_NUMBER_OF_PAYMENT"}]
                </div>
                <div class="block2">
                    [{$oPaymentMonths}] [{oxmultilang ident="MONTHS"}]
                </div>
            </div>
            <div class="popupText">
                <div class="block1 ">
                    [{oxmultilang ident="INSTALLMENT_MONTHLY_PAYMENT"}]
                </div>
                <div class="block2">
                    [{$oMonthPayment->getPrice()}] [{$currency->sign}]
                </div>
            </div>
            <div class="fullPrice popupText">
                <p>[{oxmultilang ident="INSTALLMENT_FULL_PRICE"}]</p>
                <p>[{$oFullPrice->getPrice()}] [{$currency->sign}]</p>
            </div>
        </div>
    </div>
</div>

