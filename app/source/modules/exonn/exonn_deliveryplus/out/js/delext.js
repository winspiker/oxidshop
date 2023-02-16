
    function deleteLabel(service, packetId, clear, sendEmail, isOrderCOD, iFrameID) {
        var addMessage = "";
        if (isOrderCOD && service == "ups") {
            addMessage = " Wegen Nachname alle packeten werden storniert.";
        }

        var formID = "#exonn_delext_" + iFrameID;
        if (confirm((packetId ? "Etikett stornieren? " + addMessage : 'Alle Etiketten stornieren?'))) {
            console.log("remove " + service + " - " + packetId);
            jQuery(formID + " #packetid").val(packetId);
            jQuery(formID + " #service").val(service);
            jQuery(formID + " #clearlabel").val(clear);
            jQuery(formID + " #sendemail").val(sendEmail);
            jQuery(formID + " #fnc").val('cancelLabel');

            jQuery(formID).submit();
            top.forceReloadingEditFrame();
        } else {
            return false;
        }
    }

    function disableLabel(packetId, iFrameID) {
        var formID = "#exonn_delext_" + iFrameID;

        if (confirm('Wollen Sie dieses Paket für die Erstellung des Versandetiketts sperren?')) {
            jQuery(formID + " #packetid").val(packetId);
            jQuery(formID + " #clearlabel").val(1);
            jQuery(formID + " #fnc").val('cancelLabel');

            jQuery(formID).submit();
            top.forceReloadingEditFrame();
        } else {
            return false;
        }
    }

    function labelRenew(packetId, service, iFrameID) {
        var formID = "#exonn_delext_" + iFrameID;

        if (confirm("Wollen Sie dieses Paket für die Erstellung des Versandetiketts freigeben?")) {
            jQuery(formID + " #packetid").val(packetId);
            jQuery(formID + " #service").val(service);
            jQuery(formID + " #fnc").val('renewLabel');

            jQuery(formID).submit();
            top.forceReloadingEditFrame();
        } else {
            return false;
        }
    }

    function labelUpdate(packetId, deliveryId, iFrameID) {
        var formID = "#exonn_delext_" + iFrameID;

        if (confirm("Etikett updaten?")) {
            jQuery(formID + " #packetid").val(packetId);
            jQuery(formID + " #newDeliveryId").val(deliveryId);
            jQuery(formID + " #fnc").val('updateLabel');

            jQuery(formID).submit();
            top.forceReloadingEditFrame();
        } else {
            return false;
        }
    }

    function onMenuMouseOut(event, id, self) {
        e = event.toElement || event.relatedTarget;


        if (e.parentNode.parentNode == self || e.parentNode == self || e == self) {
            return;
        }
        toggleElement(id);
    };

    function toggleElement(id) {
        jQuery("#" + id).toggle();
        //console.log("toggle");
    }

    function openLinkAndReload(url, iFrameID) {
        console.log("openLinkAndReload");
        var formID = "#exonn_delext_" + iFrameID;

        window.open(url, '_blank');
        window.focus();
        jQuery(formID).submit();
    }
