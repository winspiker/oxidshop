var configuration = {
    url: cpsfUrl,
    placeholders: {
        accountHolder: cpsfAccountHolder,
        number: cpsfCardNumber,
        cvv: cpsfCvv
    }
}

function paymentRegisteredCallback(response) {
    console.log(response);
    if (response.resultCode === 0) {
        // Successful registration, continue to next page with Javascript
        console.log("Zahlung erfolgreich regstriert: ");

        // Date of birth has to be updated, if not provided yet
        var dateOfBirthID = 'crefoPayDOB' + response.paymentMethod;
        if (document.getElementById(dateOfBirthID) !== null) {
            var userDateOfBirth = $('#' + dateOfBirthID).val().trim();
            if (userDateOfBirth !== '') {
                response.dateOfBirth = userDateOfBirth;
            }
        }

        // Response ins "Backend" posten
        $.post(cpsfBaseUrl + "index.php?cl=crefopay_internal", response, function(result) {
            $("#payment").submit();
        });

    } else {
        // Error during registration, check the response for more details and dynamically show a message for the customer
        if (response.resultCode === 1002 && response.errorDetails !== undefined) {
            var currentMethod = $('input[data-crefopay="paymentMethod"]:checked').val();
            var input;

            // reset credit card input fields
            $('#pinLabel').removeClass('text-danger');
            $('#piaLabel').removeClass('text-danger');
            $('#pivLabel').removeClass('text-danger');
            $('#picLabel').removeClass('text-danger');

            // mark credit card fields with issues
            for (var index = 0; index < response.errorDetails.length; index++) {
                var detail = response.errorDetails[index];
                if (currentMethod === 'DD') {
                    $("#payment").submit();
                } else {
                    if (detail.field === 'paymentInstrument.number') {
                        $('#pinLabel').addClass('text-danger');
                    }
                    if (detail.field === 'paymentInstrument.accountHolder') {
                        $('#piaLabel').addClass('text-danger');
                    }
                    if (detail.field === 'paymentInstrument.validity') {
                        $('#pivLabel').addClass('text-danger');
                    }
                    if (detail.field === 'paymentInstrument.cvv') {
                        $('#picLabel').addClass('text-danger');
                    }
                }
            }
        }
    }
}

function initializationCompleteCallback(response) {
    $("#result-content").html(JSON.stringify(response, null, 4));
    console.log(response.resultCode);
    if (response.resultCode === 0) {
        console.log("Session created");
        sessionId = response.token;
    } else {
        console.log(response);
    }
}

var secureFieldsClientInstance = new SecureFieldsClient(cpsfShopPublicKey, cpsfOrderID, paymentRegisteredCallback, initializationCompleteCallback, configuration);

$("input[name='paymentid']").on(
    "change",
    function(event) {
        var current = $(event.target);
        $("input[data-crefopay='paymentMethod']").each(function() {
            $(this).prop("checked", false);
        })
        $("#cp" + current.attr("id")).prop("checked", current.prop("checked"));
    }
);

var cchecked = $("input[name='paymentid']:checked");
$("#cp" + cchecked.attr("id")).prop("checked", cchecked.prop("checked"));