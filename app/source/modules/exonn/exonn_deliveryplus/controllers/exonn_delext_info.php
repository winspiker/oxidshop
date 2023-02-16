<?php

class exonn_delext_info extends oxView {

    public function downloadlabel() {
        $myConfig = $this->getConfig();
        $packetId = $myConfig->getRequestParameter("labelid");
        $orderId = $myConfig->getRequestParameter("orderid");
        $service = $myConfig->getRequestParameter("service");

        $userId = $myConfig->getRequestParameter( "delivery" );

        oxRegistry::getUtils()->writeToLog("Start downloadlabel" . ")\r\n", 'labels_log.txt');

        $deliveryUser = oxNew("oxuser");
        $deliveryUser->load($userId);

        $edl = oxNew("exonn_delext_labels");
        $file = $edl->exportLabels(array($orderId), $service, $deliveryUser, $packetId);

        oxRegistry::getUtils()->writeToLog("Cant cancel label, it was not created" . ")\r\n", 'labels_log.txt');

        if (file_exists($file)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="'.basename($file).'"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            readfile($file);
            exit;
        } else {
            echo "Kein Versandetiketten zum drucken";
        }
        exit;
    }

    public function downloadlabeldoc() {
        $myConfig = $this->getConfig();
        $packetId = $myConfig->getRequestParameter("labelid");

        oxRegistry::getUtils()->writeToLog("Start downloadlabeldoc" . "\r\n", 'labels_log.txt');

        $edl = oxNew("exonn_delext_labels");
        $file = $edl->getExportDocument($packetId);

        oxRegistry::getUtils()->writeToLog("Done " . "\r\n", 'labels_log.txt');

        if (file_exists($file)) {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename="'.basename($file).'"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            readfile($file);
            exit;
        } else {
            echo "Kein Versandetiketten zum drucken";
        }
        exit;
    }
}