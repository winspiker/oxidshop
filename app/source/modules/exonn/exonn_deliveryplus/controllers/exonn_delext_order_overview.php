<?php

/**
 *  add to metadata.php in extend section: 'order_overview' => 'exonn_deliveryext/controllers/exonn_delext_order_overview',
 **/ 
class exonn_delext_order_overview extends exonn_delext_order_overview_parent {


    public function getProcessIds() {
        if (method_exists($this, "getProcessingIds")) {
            return $this->getProcessingIds();
        } else {
            return array();
        }
    }
    
    public function render() {

        $soxId = $this->getEditObjectId();
        $oOrder = oxNew("oxorder");
        if ($soxId != "-1" && isset($soxId)) {
            // load object
            $oOrder->load($soxId);

            if (count($packets = $oOrder->getDeliveryLabelsGroupByService())) {
                $oOrder->getCheckAndFixDeliveryLabels();
                $this->_aViewData["delPackets"] = $oOrder->getDeliveryLabelsGroupByService();
            } else {
                $exonn_delext_labels = oxNew("exonn_delext_labels");
                $exonn_delext_labels->definedAndSavePackets(array($soxId));
                $this->_aViewData["delPackets"] = $oOrder->getDeliveryLabelsGroupByService();
                //$this->_aViewData["delPackets"] = $oOrder->defineDeliveryPackets();
            }
            $oOrderUser = $oOrder->getOrderUser();

            if ($oOrderUser && ($oOrderUser->oxuser__oxlieferscheinfromuser->value && !$oOrderUser->oxuser__oxshopaddr->value)) {
                $this->_aViewData["deliveryUser"] = $oOrderUser;
            }
            if ($oOrderUser && $oOrderUser->oxuser__oxshopaddr->value) {
                $this->_aViewData["shipperisshop"] = 1;
            }
            $delLidt = oxNew("oxdeliverylist");
            $delLidt->selectString("select * from oxdelivery order by oxtitle, oxsort");
            $this->_aViewData["dellist"] = $delLidt->getArray();
        } else {
           //print_r($this->getLabelsStatistick());
        }
        return parent::render();
    }

    /*public function createlabel($soxId = "") {

        $myConfig = $this->getConfig();
        $soxId = $soxId ? $soxId : $myConfig->getRequestParameter( "oxid" );
        $userId = $myConfig->getRequestParameter( "delivery" );

         if ( $soxId != "-1") {
            $oOrder = oxNew( "oxorder" );
            $oOrder->load( $soxId );

            $deliveryUser = oxNew("oxuser");
            $deliveryUser->load($userId);

            $exonn_delext_labels = oxNew("exonn_delext_labels");
            $exonn_delext_labels->exportLabels(array($oOrder->getId()), "", $deliveryUser);
        }
    }*/

    public function printlabel($soxId = "", $service = "", $packetId = "") {
        $myConfig = $this->getConfig();

        $soxId = $soxId ? $soxId : $myConfig->getRequestParameter( "oxid" );
        $service = $service ? $service : $myConfig->getRequestParameter( "deliveryservice" );
        $packetId = $packetId ? $packetId : $myConfig->getRequestParameter( "packetid" );

        oxRegistry::getUtils()->writeToLog("\r\n Start process printlabel - order: $soxId, service: $service, pkId: $packetId \r\n", 'labels_log.txt');

        $userId = $myConfig->getRequestParameter( "delivery" );

         if ( $soxId != "-1") {
            $oOrder = oxNew( "oxorder" );
            $oOrder->load( $soxId );

            $deliveryUser = oxNew("oxuser");
            $deliveryUser->load($userId);

            $exonn_delext_labels = oxNew("exonn_delext_labels");
            $exonn_delext_labels->exportLabels(array($oOrder->getId()), $service, $deliveryUser, $packetId);
        }
    }

    public function cancelLabel($soxId = "", $service = "", $packetGroupId = "", $clearlabel = "", $sendemail = "")
    {
        if (!$soxId) {
            $soxId = $this->getConfig()->getRequestParameter("oxid");
        }
        if (!$packetGroupId) {
            $packetGroupId = $this->getConfig()->getRequestParameter("packetid");
        }
        if (!$service) {
            $service = $this->getConfig()->getRequestParameter("service");
        }
        if (!$clearlabel) {
            $clearlabel = $this->getConfig()->getRequestParameter("clearlabel");
        }
        if (!$sendemail) {
            $sendemail = $this->getConfig()->getRequestParameter("sendemail");
        }

        oxRegistry::getUtils()->writeToLog("\r\n Start process cancelLabel - order: $soxId, service: $service, pkId: $packetGroupId \r\n", 'labels_log.txt');

        $exonn_delext_labels = oxNew("exonn_delext_labels");
        $exonn_delext_labels->removeOrderLabels($soxId, $service, $packetGroupId, $clearlabel, $sendemail);
    }

    public function updateLabel()
    {
        $packetGroupId = $this->getConfig()->getRequestParameter("packetid");
        $newDeliveryId = $this->getConfig()->getRequestParameter("newDeliveryId");

        oxRegistry::getUtils()->writeToLog("\r\n Start process updateLabel - pkId: $packetGroupId \r\n", 'labels_log.txt');
        echo "update delid " . $newDeliveryId;
        $label = oxNew("oxdeliverylabel");
        if($label->loadLabelByGroupId($packetGroupId)) {
            $label->savePositions(false, $newDeliveryId);
        }
    }

    public function renewLabel($soxId = "", $packetId = "", $service = "")
    {
        if (!$soxId) {
            $soxId = $this->getConfig()->getRequestParameter("oxid");
        }

        if (!$packetId) {
            $packetId = $this->getConfig()->getRequestParameter("packetid");
        }

        if (!$service) {
            $service = $this->getConfig()->getRequestParameter("service");
        }

        //oxRegistry::getUtils()->writeToLog("Cancel labels order: $soxId, service: $service, pkId: $packetId \r\n", 'labels_log.txt');

        $exonn_delext_labels = oxNew("exonn_delext_labels");
        $exonn_delext_labels->renewOrderLabel($soxId, $service, $packetId);
    }

    public function exportlabels()
    {
        /*try {
            oxDb::getDb()->Execute("update oxorder set orderprocessingprint=1 where orderprocessing=1 ");
        } catch(Exception $e){}
        */

        ini_set('memory_limit', '1024M');

        if (count($ids = $this->getProcessIds())) {
            $exonn_delext_labels = oxNew("exonn_delext_labels");

            $myConfig = $this->getConfig();

            $service = $myConfig->getRequestParameter( "deliveryservice" );

            if ($sFilename = $exonn_delext_labels->exportLabels($ids, $service)) {
                $oUtils = oxRegistry::getUtils();
                $oUtils->setHeader("Pragma: public");
                $oUtils->setHeader("Cache-Control: must-revalidate, post-check=0, pre-check=0");
                $oUtils->setHeader("Expires: 0");
                $oUtils->setHeader("Content-type: application/pdf");
                $oUtils->setHeader("Content-Disposition: attachment; filename=labels.pdf");
                oxRegistry::getUtils()->showMessageAndExit(file_get_contents($sFilename));
            }
        }

        $this->_aViewData["updatelist"] = "1";
    }

    public function printexportdocs()
    {

        ini_set('memory_limit', '1024M');

        if (count($ids = $this->getProcessIds())) {
            $exonn_delext_labels = oxNew("exonn_delext_labels");

            $myConfig = $this->getConfig();

            $service = $myConfig->getRequestParameter( "deliveryservice" );

            if ($sFilename = $exonn_delext_labels->exportDocs($ids, $service)) {
                $oUtils = oxRegistry::getUtils();
                $oUtils->setHeader("Pragma: public");
                $oUtils->setHeader("Cache-Control: must-revalidate, post-check=0, pre-check=0");
                $oUtils->setHeader("Expires: 0");
                $oUtils->setHeader("Content-type: application/pdf");
                $oUtils->setHeader("Content-Disposition: attachment; filename=labels.pdf");
                oxRegistry::getUtils()->showMessageAndExit(file_get_contents($sFilename));
            }
        }

        $this->_aViewData["updatelist"] = "1";
    }

    /*
    public function exportdhlcods()
    {
        try {
            oxDb::getDb()->Execute("update oxorder set orderprocessingprint=1 where orderprocessing=1 ");
        } catch(Exception $e){}

        ini_set('memory_limit', '1024M');

        if (count($ids = $this->getProcessIds())) {
            $exonn_delext_labels = oxNew("exonn_delext_labels");

            $myConfig = $this->getConfig();
            $sFilename = "dhlcods.pdf";
            if ($exonn_delext_labels->exportdhlcods($ids)) {
                $oUtils = oxRegistry::getUtils();
                $oUtils->setHeader("Pragma: public");
                $oUtils->setHeader("Cache-Control: must-revalidate, post-check=0, pre-check=0");
                $oUtils->setHeader("Expires: 0");
                $oUtils->setHeader("Content-type: application/pdf");
                $oUtils->setHeader("Content-Disposition: attachment; filename=" . $sFilename);
                oxRegistry::getUtils()->showMessageAndExit(file_get_contents($myConfig->getConfigParam('sShopDir') . "export/$sFilename"));
            }
        }

        $this->_aViewData["updatelist"] = "1";
    }
    */



    public function getLabelsStatistick() {
        $result = array();
        if (count($ids = $this->getProcessIds())) {
            foreach($ids as $id) {
                $oOrder = oxNew("oxorder");
                $oOrder->load($id);
                $labels = $oOrder->getLabelsInformation();
                $docs = $oOrder->needExportDocuments();
                foreach ($labels as $serv => $label) {
                    $labelExtInfo = array();
                    $labelExtInfo["ordernr"] = $oOrder->oxorder__oxordernr->value;
                    $labelExtInfo["customer"] = $oOrder->oxorder__oxbillfname->value . " " . $oOrder->oxorder__oxbilllname->value;
                    if ($oOrder->oxorder__oxdellname->value) {
                        $labelExtInfo["customer"] = $oOrder->oxorder__oxdelfname->value . " " . $oOrder->oxorder__oxdellname->value;
                    }
                    $labelExtInfo["label"] = $label;
                    $result["labels"][] = $labelExtInfo;
                    $result["services"][$serv]++;
                    if($docs) {
                        $result["docs"][$serv]++;
                    }
                }

                //fix for old orders

            }
        }
        //print_r($result);
        return $result;
    }

    public function packListePrint()
    {
        $sFilename = "packlist.pdf";
        $statistick = $this->getLabelsStatistick();
        if (count($statistick) == 0) return;

        $sUserId = oxRegistry::getSession()->getVariable( 'auth' );
        $oUser = oxNew("oxuser");
        $oUser->load($sUserId);


        $oPdf = oxNew( 'oxPDF' );
        $oPdf->setPrintHeader( false );
        $oPdf->open();


        $headerText = "Packliste ".date("d.m.Y H:i")." Uhr; ".$oUser->oxuser__oxfname->value." ".$oUser->oxuser__oxlname->value." (".$oUser->oxuser__oxusername->value.")";

        $yy = $this->_headerPackListe($oPdf, $headerText );

        $this->_bodyPackListe($oPdf, $statistick["labels"], $yy, $headerText);


        $myConfig = $this->getConfig();
        $oPdf->output( $myConfig->getConfigParam('sShopDir') . "export/".$sFilename, 'F' );

        $oUtils = oxRegistry::getUtils();
        $oUtils->setHeader( "Pragma: public" );
        $oUtils->setHeader( "Cache-Control: must-revalidate, post-check=0, pre-check=0" );
        $oUtils->setHeader( "Expires: 0" );
        $oUtils->setHeader( "Content-type: application/pdf" );
        $oUtils->setHeader( "Content-Disposition: attachment; filename=".$sFilename );
        oxRegistry::getUtils()->showMessageAndExit( file_get_contents($myConfig->getConfigParam( 'sShopDir' )."export/$sFilename") );

    }

    protected function _headerPackListe($oPdf, $headerText)
    {
        $oPdf->addPage();
        $xx=15;
        $yy=15;
        $oPdf->text( $xx, $yy, $headerText );
        $yy+=4;

        return $yy;
    }


    protected function _bodyPackListe($oPdf, $aPackListe, $yy, $headerText)
    {
        $fieldConfid = array(
            15,
            23,
            31,
            70,
            100,
            175,
            185,

        );

        $i = 1;

        $yy+=4;
        $oPdf->setFont( 'Arial', '', 10 );
        $oPdf->text( $fieldConfid[0], $yy, 'Nr' );
        $oPdf->text( $fieldConfid[1], $yy, 'O. Nr' );
        $oPdf->text( $fieldConfid[2], $yy, 'Customer' );
        $oPdf->text( $fieldConfid[3], $yy, 'Lebelid' );
        $oPdf->text( $fieldConfid[4], $yy, 'Article' );
        $oPdf->text( $fieldConfid[5], $yy, 'Stk' );
        $oPdf->text( $fieldConfid[6], $yy, 'Service' );
        $yy+=2;
        $oPdf->line( 15, $yy, 195, $yy );
        $orderNr = 0;

        foreach($aPackListe as $label)
        {

            if ($yy  > 260) {
                $yy = $this->_headerPackListe($oPdf, $headerText);

                $yy+=4;
                $oPdf->setFont( 'Arial', '', 10 );
                $oPdf->text( $fieldConfid[0], $yy, 'Nr' );
                $oPdf->text( $fieldConfid[1], $yy, 'O. Nr' );
                $oPdf->text( $fieldConfid[2], $yy, 'Customer' );
                $oPdf->text( $fieldConfid[3], $yy, 'Lebelid' );
                $oPdf->text( $fieldConfid[5], $yy, 'Stk' );
                $oPdf->text( $fieldConfid[6], $yy, 'Service' );
                $yy+=2;
                $oPdf->line( 15, $yy, 195, $yy );
            }


            if ($orderNr != $label["ordernr"] ) {
                $orderNr = $label["ordernr"];
                $yy++;
                $oPdf->line( 15, $yy, 195, $yy );
            }



            $oPdf->setFont( 'Arial', '', 6 );
            foreach($label['label'] as $pack) {
                $yy+=6;
                $oPdf->setFont( 'Arial', '', 8 );
                $oPdf->text( $fieldConfid[0] + 2, $yy, $i );
                $oPdf->text( $fieldConfid[1] + 2, $yy, $label["ordernr"] );
                $oPdf->text( $fieldConfid[2] + 2, $yy, $label['customer'] );
                $oPdf->text( $fieldConfid[3] + 2, $yy, $pack[0]["labelid"] );
                $oPdf->text( $fieldConfid[6] + 2, $yy, $pack[0]["delservice"] );

                foreach ($pack as $art) {
                    $article = oxNew("oxarticle");
                    if ($article->load($art["artid"])) {

                        $oPdf->text($fieldConfid[4] + 2, $yy, $article->getArtTitle() . "(" . $art["weight"] . " kg)");
                        $oPdf->text($fieldConfid[5] + 2, $yy, $art["amount"]);
                        $yy += 4;
                    }
                }
                $oPdf->line( 15, $yy, 195, $yy );
                $i++;
            }
            //$oPdf->line( 15, $yy, 195, $yy );
            //$i++;
        }

    }
}
