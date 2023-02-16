[{if $oView->isLowOrderPrice()}]
    <div class="well well-sm">
        <div><b>[{ oxmultilang ident="MIN_ORDER_PRICE" }] [{oxprice price=$oxcmp_basket->getMinOrderPrice() currency=$currency}]</b></div>
    </div>
[{else}]
    <div class="well well-sm">
        <a href="[{oxgetseourl ident=$oViewConf->getOrderLink()}]" class="btn btn-default pull-left prevStep submitButton largeButton" id="paymentBackStepBottom"><i class="fa fa-caret-left"></i> [{ oxmultilang ident="PREVIOUS_STEP" }]</a>
        <button type="submit" name="userform" class="btn btn-primary pull-right submitButton nextStep largeButton" id="paymentNextStepBottom">[{ oxmultilang ident="CONTINUE_TO_NEXT_STEP" }] <i class="fa fa-caret-right"></i></button>
        <div class="clearfix"></div>
    </div>
[{/if}]

<script type="text/javascript">
    $("#paymentNextStepBottom").click(function(event) {
        $("input[data-crefopay='paymentMethod']").each(function() {
            
            if ($(this).prop("checked")) {
                event.preventDefault();
                console.log("register payment...");
                secureFieldsClientInstance.registerPayment();
                console.log('done');
                return true;
            }
        });
    });
</script>
