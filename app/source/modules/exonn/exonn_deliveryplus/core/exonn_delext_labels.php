<?php

//include_once "../interface/DeliveryClientInterface.php";


class exonn_delext_labels extends oxBase {

    private $_services = array("dhl", "ups", "dpd", "gls", "hermes", "empty");

    public function checkInfoForExportLabels($ids) {

        foreach ($ids as $oid) {
            $oOrder = oxNew("oxorder");
            $oOrder->load($oid);

            if (!$oOrder->checkDeliveryPacketsExists()) {
                return false;
            }
        }
        return true;
    }

    /*
    public function exportLabelsInfo($ids, $delservice = "", $absender = null) {

        ini_set('memory_limit', '1024M');
        $packets = array();
        oxRegistry::getUtils()->writeToLog("INFO ORDERS " . count($ids) . " \r\n", 'labels_info_log.txt' );
        $oDb = oxDb::getDb();
        $oDb->execute("delete from dhlerror");
        foreach ($ids as $oid) {
            $oOrder = oxNew("oxorder");
            $oOrder->load($oid);
            if(!$oOrder->isCODPayment()) continue;

            $orderPackets = $oOrder->getDeliveryPackets();
            foreach($orderPackets as $packet) {
                $packets["dhl"][] = array("orderid" => $oid, "packets" => $packet);
            }
        }

        $this->exportdhllabelsInfo($packets["dhl"], $absender);

    }
    */

    /**
     * Collect delivery packets from order and create Labels.
     *
     * @param $ids
     * @param string $delservice
     * @param null $deliveryUser
     * @param string $packageId - export for only one package
     * @return int|string
     */
    public function exportLabels($ids, $delservice = "", $deliveryUser = null, $packageId = "") {

        oxRegistry::getUtils()->writeToLog("\r\n\r\n\r\n---------------------------------------------------------------- \r\n", 'labels_log.txt' );
        oxRegistry::getUtils()->writeToLog("\r\n\r\n\r\n---------------------------------------------------------------- \r\n", 'labels_log.txt' );
        oxRegistry::getUtils()->writeToLog("\r\n" . date("Y-m-d H:i:s") .  ": Start exportLabels (service: $delservice, packageId: $packageId) \r\n", 'labels_log.txt' );

        /*try {
            oxDb::getDb()->Execute("update oxorder set orderprocessingprint=1 where orderprocessing=1 ");
        } catch(Exception $e){}*/

        ini_set('memory_limit', '1024M');

        //TODO: менять название для возможности работы нескольких пользователей
        $sFilename = "delivery_labels.pdf";
        $files = array();
        $printedFile = "";

        //first define and save order packets for all orders
        $this->definedAndSavePackets($ids);

        if ($packageId) {
            //create label only for one packet

            $package = oxNew("oxdeliverylabel");
            if ($package->loadLabelByGroupId($packageId)) {

                oxRegistry::getUtils()->writeToLog("\r\n\r\n>>>>> Start export one package $packageId <<<<<\r\n", 'labels_log.txt');

                if (!$package->getLabelUrl() && $package->getService()) {
                    $this->createServiceLabel($package->getService(), $package->getOrderId(), $deliveryUser, $packageId);
                    //TODO: проверка может ли сервис добавить пакет в уже существующие
                }

                if (count($labels = $this->getOrderLabels($package->getOrderId(), "", $packageId))) {
                    $files = array_merge($files, $this->collectLabelFiles($labels, $packageId));
                } else {
                    oxRegistry::getUtils()->writeToLog("No Labels to print for this order, skip it \r\n", 'labels_log.txt');
                }
            }

        } else {
            //create labels for each service by each order

            foreach ($this->_services as $service) {
                if (($delservice == "" || $delservice == $service)) {

                    oxRegistry::getUtils()->writeToLog("\r\n\r\n>>>>> Start export $service labels <<<<<\r\n", 'labels_log.txt');

                    foreach ($ids as $oid) {

                        $this->createServiceLabel($service, $oid, $deliveryUser, $packageId, true);

                        if (count($labels = $this->getOrderLabels($oid, $service))) {
                            $files = array_merge($files, $this->collectLabelFiles($labels, $packageId));
                        } else {
                            oxRegistry::getUtils()->writeToLog("No Labels to print for this order, skip it \r\n", 'labels_log.txt');
                        }
                    }

                    oxRegistry::getUtils()->writeToLog("End Export $service labels " . " \r\n", 'labels_log.txt');
                }
            }
        }
         if (count($files)) {
            $printedFile = $this->printLabelFilesToOne($files, $sFilename);
        }

        return $printedFile;
    }


    /**
     * @param  $service
     * @return DeliveryClientInterface
     */
    public function createClient($service, $init = false) {
        try {
            $client = oxNew("exonn_" . $service . "_client");
            if ($init) {
                $this->initServiceClient($client, $service);
            }
            return $client;
        } catch (oxSystemComponentException $e) {
            return null;
        }
    }

    /**
     * Define orders packets and save info.
     *
     * @param $ids
     */
    public function definedAndSavePackets($ids) {


        foreach ($ids as $orderId) {
            if (!count($orderPackets = $this->getOrderLabels($orderId))) {

                oxRegistry::getUtils()->writeToLog("Define order packets \r\n", 'labels_log.txt');
                $oOrder = oxNew("oxorder");
                $oOrder->load($orderId);
                /**
                 * @var oxdeliverylabel[] $orderPackets
                 */
                $orderPackets = $oOrder->defineDeliveryPackets();

                if (is_array($orderPackets)) {
                    oxRegistry::getUtils()->writeToLog("Result of define packets: " . count($orderPackets) . " labels \r\n", 'labels_log.txt');
                    foreach ($orderPackets as $service => $servicePackets) {
                        foreach($servicePackets as $package) {
                            $package->savePositions();

                        }
                    }
                }
            }
            if($this->hasOrderLabelsWithoutService($orderId)) {
                $oOrder = oxNew("oxorder");
                $oOrder->load($orderId);
                $oOrder->getCheckAndFixDeliveryLabels();
            }
        }
    }

    /**
     * Creating labels.
     *
     * @param $service
     * @param $orderId
     * @param $deliveryUser
     * @param string $onlyPacketId
     * @param bool $skipCanceled
     * @return array
     */
    protected function createServiceLabel($service, $orderId, $deliveryUser, $onlyPacketId = "", $skipCanceled = false) {

        $resultLabels = array();

        $oOrder = oxNew("oxorder");
        $oOrder->load($orderId);


        oxRegistry::getUtils()->writeToLog("\r\n===== Create $service labels  for orderNr: "
            . $oOrder->oxorder__oxordernr->value
            . " orderId: " . $oOrder->oxorder__oxid->value . "(only for packet: " . $onlyPacketId. ") \r\n", 'labels_log.txt' );

        $orderPackets = $this->getOrderLabels($orderId, $service, $onlyPacketId);

        /*
        //check if labels exists
        if (!count($orderPackets = $this->getOrderLabels($orderId, $service, $onlyPacketId))) {
            //NEW LABELS
            oxRegistry::getUtils()->writeToLog("No labels information, perform define packets \r\n", 'labels_log.txt');

            $orderPackets = $oOrder->defineDeliveryPackets($service);

            if (is_array($orderPackets)) {
                oxRegistry::getUtils()->writeToLog("Result of define packets: " . count($orderPackets) . " labels \r\n", 'labels_log.txt');
                oxRegistry::getUtils()->writeToLog("Save empty labels \r\n", 'labels_log.txt');
                foreach ($orderPackets as $key => $package) {
                    $package->savePositions();
                }

            } else {
                oxRegistry::getUtils()->writeToLog("There are no packets for this service \r\n", 'labels_log.txt');
            }

        }
        */

        if (!$client = $this->createClient($service)) {
            oxRegistry::getUtils()->writeToLog("Cant create client for service $service, skip it \r\n", 'labels_log.txt');
            return $resultLabels;
        }

        if (count($orderPackets)) {

            oxRegistry::getUtils()->writeToLog("Got packets: " . count($orderPackets) . " labels \r\n", 'labels_log.txt');

            $labelInfo = "";

            $this->initServiceClient($client, $service, $oOrder);

            if (!$this->setServiceShipper($client, $service, $deliveryUser, $oOrder)) {
                $labelInfo = "Absender nicht unterstützt\r\n";
            }

            $this->setServiceSendToAddr($client, $service, $oOrder);

            if (!$this->setServiceBankData($client, $service, $oOrder)) {
                $labelInfo .= "Bank daten nicht unterstützt\r\n";
            }

            $packagesPrice = 0;
            $packetsCount = 0;
            $workWithPackets = array();

            /**
             * @var $package oxdeliverylabel
             */
            foreach($orderPackets as $key => $package) {

                if ($number = $package->oxdeliverylabels__oxlabelid->value) {
                    oxRegistry::getUtils()->writeToLog("Packet $packetsCount label exists " . $number . " \r\n", 'labels_log.txt');

                } else {

                    if ($onlyPacketId && $package->oxdeliverylabels__oxlabelgroup->value != $onlyPacketId
                        || $skipCanceled and $package->oxdeliverylabels__oxcanceled->value
                    ) continue;

                    $workWithPackets[] = $package;

                    oxRegistry::getUtils()->writeToLog("Label exists without number / or new, try to create it \r\n", 'labels_log.txt');

                    oxRegistry::getUtils()->writeToLog("Packet info: \r\n", 'labels_log.txt');

                    $positions = array();

                    $packageWeight = 0;
                    $packagePrice = 0;

                    foreach ($package->getPositions() as $key => $position) {
                        $positionArr = array();
                        oxRegistry::getUtils()->writeToLog(" -- "
                            . ($positionArr["title"] = $position->oxdeliverylabels__oxarttitle->value) . " : "
                            . ($positionArr["artnum"] = $position->oxdeliverylabels__oxartnum->value) . " : "
                            . ($positionArr["amount"] = $position->oxdeliverylabels__oxartamount->value) . "st : "
                            . ($positionArr["weight"] = $this->getPositionWeight($position)) . "kg : price "
                            . ($positionArr["price"] = $position->oxdeliverylabels__oxposprice->value) . "€ \r\n", 'labels_log.txt');

                        if($oOrder->needExportDocuments() && $positionArr["artnum"]) {
                            $positionArr = $this->setPositionExportInformation($client, $service, $positionArr, $position->getArticle());
                        }

                        if($position->oxdeliverylabels__oxartid->value) {
                            $positions[] = $positionArr;
                        }

                        $packageWeight += $positionArr["weight"];
                        $packagePrice += $positionArr["price"];
                        $packagesPrice += $positionArr["price"];

                    }
                    //print_r($positions);

                    $deliveryUserForPacket = $deliveryUser ? $deliveryUser : $this->getDeliveryUser($oOrder, $package);

                    if (!$deliveryUser && $deliveryUserForPacket) {
                        oxRegistry::getUtils()->writeToLog("Got Delivery User from packet" .") \r\n", 'labels_log.txt' );
                    }

                    //need update weight if it was 0
                    $package->oxdeliverylabels__oxweight = new oxField($packageWeight);
                    //$package->oxdeliverylabels__oxcodsum = new oxField($packagePrice);

                    $exportDocsInfo = array();
                    if($oOrder->needExportDocuments()) {
                        $exportDocsInfo = $this->setExportInformation($client, $service, $deliveryUser, $oOrder);
                    }

                    $packageAddInfo = $this->setServicePackageAddInfo($service, $oOrder, $package);

                    $client->addPackage($package->getGroupId() ? $package->getGroupId() : $packetsCount,
                            $packageWeight,
                            "",
                            0,0,0,
                            array("exportinfo" => $exportDocsInfo, "positions" => $positions),
                            $packageAddInfo);

                    $packetsCount++;

                    if(!$client->isManyPackagesSupported()) {

                        oxRegistry::getUtils()->writeToLog("Service do not support many packages, create label now: \r\n", 'labels_log.txt');

                        $this->doCreateLabel($client, $service, $workWithPackets, $packagePrice, $oOrder, $labelInfo);

                        $workWithPackets = array();
                        $client->clearPackages();
                    }
                }
            }

            if($packetsCount > 0 && $client->isManyPackagesSupported()) {

                oxRegistry::getUtils()->writeToLog("Start many packets label: \r\n", 'labels_log.txt');

                $this->doCreateLabel($client, $service, $workWithPackets, $packagesPrice, $oOrder, $labelInfo);
            }
        } else {
            oxRegistry::getUtils()->writeToLog("There are no packets for this service \r\n", 'labels_log.txt');
        }

        return $resultLabels;
    }

    public function doCreateLabel($client, $service, $packages, $packagesPrice, $oOrder, $labelInfo  ) {
        $myConfig = $this->getConfig();
        $labelsDir = $this->getLabelsDir();

        $result = array();

        if ($oOrder->isCODPayment()) {
            $codAddPrice = $myConfig->getConfigParam("exonn_cod_add_price_" . $service);
            oxRegistry::getUtils()->writeToLog("COD Mode, add price: " . $codAddPrice . " \r\n", 'labels_log.txt');
            $client->setCODOptions($packagesPrice, $codAddPrice);
        }

        if ($this->isWriteable($labelsDir)) {
            $result = $client->getLabel($oOrder->oxorder__oxordernr->value, "", $labelsDir);

            oxRegistry::getUtils()->writeToLog("Service result: \r\n", 'labels_log.txt');
            oxRegistry::getUtils()->writeToLog(print_r($result, 1) . " \r\n", 'labels_log.txt');
        } else {
            oxRegistry::getUtils()->writeToLog("Labels directory not writeable, cant create label. \r\n", 'labels_log.txt');
            $result["err"] = "Labels directory not writeable, cant create label";
        }

        $result["info"] .= $labelInfo;

        $this->saveLabelInfo($oOrder->getId(), $packages, $result);
    }

    /**
     * @param $position oxdeliverylabel
     */
    public function getPositionWeight($position) {
        $result = $position->oxdeliverylabels__oxartweight->value;
        if (!$result) {
            $art = $position->getArticle();
            $result = $art->oxarticles__oxweight->value;
        }
        return $result;
    }

    /**
     * Initialize service client.
     *
     * @param DeliveryClientInterface $client
     * @param $service
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     */
    public function initServiceClient($client, $service, $oOrder = null, $package = null) {

        oxRegistry::getUtils()->writeToLog("\r\nInit $service client \r\n", 'labels_log.txt' );
        $client->initClient(false, false, false, $this->isLabelsTest());
    }

    /**
     * Add export information to position.
     *
     * @param $client
     * @param $service
     * @param $position
     * @param $article
     * @return array
     */
    public function setPositionExportInformation($client, $service, $position, $article) {
        $myConfig = $this->getConfig();

        $countryCodeOrigin = $article->oxarticles__dhlisorigncountry->value;
        $customsTariffNumber = $article->oxarticles__dhliscommoditycode->value;

        $result = array(
                'description' => $article->oxarticles__dhlistitle->value
                    ? $article->oxarticles__dhlistitle->value : $article->oxarticles__oxtitle->value,
                'countryCodeOrigin' => $countryCodeOrigin ? $countryCodeOrigin
                     : ($myConfig->getConfigParam('exonn_delext_origncountry') ?
                        $myConfig->getConfigParam('exonn_delext_origncountry') : "DE"),
                'customsTariffNumber' => $customsTariffNumber ? $customsTariffNumber
                        : $myConfig->getConfigParam('exonn_delext_commoditycode'),
                'amount' => $position["amount"],
                'netWeightInKG' => $position["weight"],
                'customsValue' => $position["price"]);

        $result = array_merge($position, $result);

        return $result;
    }

    /**
     * @param $client
     * @param $service
     * @param $deliveryUser
     * @param $oOrder
     * @return array
     */
    public function setExportInformation($client, $service, $deliveryUser, $oOrder) {
        /**
         *
         *  EX WORKS – Ab Werk                                      EXW
            FREE CARRIER – Frei Frachtführer                        FCA
            CARRIAGE PAID TO – Frachtfrei                           CPT
            DELIVERED AT PLACE – Geliefert benannter Ort            DAP
            DELIVERED AT TERMINAL – Geliefert Terminal              DAT
            DELIVERED DUTY PAID – Geliefert verzollt                DDP

         * EXW (Ex Works): Der Verkäufer muss dem Käufer die Waren (nicht
exportfähig und nicht verladen) auf seinem Firmengelände oder
einem anderen benannten Ort zur Abholung bereitstellen. Der
Verkäufer trägt somit keine Kosten.
         *
DAP (Delivered at Place): Der Verkäufer muss die Waren an den
vereinbarten Bestimmungsort bringen und dort zur Abholung/
Abladung verfügbar machen. Der Verkäufer trägt alle Transportkosten.
Der Käufer übernimmt die Zollformalitäten einschließlich
Zollgebühren, Steuern und sonstiger Gebühren, die bei der Einfuhr
der Waren zu bezahlen sind.
         *
DDP (Delivered Duty Paid): Der Verkäufer muss die importfertigen
Waren an den vereinbarten Bestimmungsort liefern. Der Verkäufer
trägt die Kosten, bis die Waren noch nicht abgeladen den
Bestimmungsort erreichen und ist verantwortlich für alle
Einfuhrformalitäten und die Zahlung der Zollgebühren
         *
         * DAT (Geliefert Terminal)
Die neue DAT­Klausel bezeichnet die Entladung der
Ware vom ankommenden Beförderungsmittel und deren
Zurverfügungstellung. Die Klausel DAT löst somit die
bekannte Klausel DEQ (Geliefert ab Kai) ab, wobei DAT
im Gegensatz zu DEQ multimodal anwendbar ist.
         *
         */
        $myConfig = $this->getConfig();
        $termsOfTrade = $myConfig->getConfigParam("EXONN_DELEXT_DHL_TERMSOFTRADE");
        $placeOfCommital = $myConfig->getConfigParam("EXONN_DELEXT_DHL_PLACEOFCOMMITAL");
        $additionalFee = $myConfig->getConfigParam("EXONN_DELEXT_DHL_ADDITIONALFEE");

        $export_document = array(
            'invoiceNumber' => $oOrder->oxorder__oxordernr->value,
            'exportType' => 'DOCUMENT',
            'exportTypeDescription' => '',
            'termsOfTrade' => $termsOfTrade ? $termsOfTrade : "DDP",
            'placeOfCommital' => $placeOfCommital ? $placeOfCommital: 'Deutschland',
            'additionalFee' => $additionalFee ? $additionalFee : 0,
            'attestationNumber' => '0',
            'permitNumber' => '0',
            'WithElectronicExportNtfctn' => '0');
        return $export_document;
    }

    private $shipperName;
    private $shipperStreetNr;
    private $shipperStreet;
    private $shipperCity;
    private $shipperZip;
    private $shipperCountryCode;
    private $shipperCountry;
    private $shipperEmail;
    private $shipperPhone;
    private $shipperCompany;
    private $shipperAddInfo;

    protected function _setShipper($name, $street, $streetNr, $city, $zip, $country,
                                $countryCode, $email, $phone, $company, $addInfo = array()) {
        $this->shipperName = $name;
        $this->shipperStreetNr = $streetNr;
        $this->shipperStreet = $street;
        $this->shipperCity = $city;
        $this->shipperZip = $zip;
        $this->shipperCountryCode = $countryCode;
        $this->shipperCountry = $country;
        $this->shipperEmail = $email;
        $this->shipperPhone = $phone;
        $this->shipperCompany = $company;
        $this->shipperAddInfo = $addInfo;
    }

    /**
     * Set shipper data.
     *
     * @param DeliveryClientInterface $client
     * @param $service
     * @param oxbase $deliveryUser
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     */
    public function setServiceShipper($client, $service, $deliveryUser, $oOrder, $package = null) {
        $oShop = $this->getShop();
        $myConfig = $this->getConfig();

        oxRegistry::getUtils()->writeToLog("\r\nSet shipper address \r\n", 'labels_log.txt' );

        try {
            if ($deliveryUser && $deliveryUser->getId() && $deliveryUser->getCoreTableName() == "oxorderretoure") {

                oxRegistry::getUtils()->writeToLog("Shipper is retoure" . "\r\n", 'labels_log.txt');

                $sadrType = $deliveryUser->oxorderretoure__oxdelcity->value ? "oxdel" : "oxbill";

                $country = oxNew("oxcountry");
                $country->load($deliveryUser->{'oxorderretoure__' . $sadrType . 'countryid'}->value);

                $this->_setShipper($this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'fname'}->value . " " . $deliveryUser->{'oxorderretoure__' . $sadrType . 'lname'}->value),
                    $this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'street'}->value),
                    $this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'streetnr'}->value),
                    $this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'city'}->value),
                    trim($this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'zip'}->value)),
                    $country->oxcountry__oxtitle->value,
                    $country->oxcountry__oxisoalpha2->value,
                    $this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'username'}->value),
                    $this->convertPhone($this->convertStr($deliveryUser->{'oxorderretoure__' . $sadrType . 'fon'}->value)),
                    $this->convertStr(substr(trim($deliveryUser->{'oxorderretoure__' . $sadrType . 'company'}->value
                        . " " . $deliveryUser->{'oxorderretoure__' . $sadrType . 'fname'}->value
                        . " " . $deliveryUser->{'oxorderretoure__' . $sadrType . 'lname'}->value), 0, 30)));

            } elseif ($deliveryUser && $deliveryUser->getId()) {


                oxRegistry::getUtils()->writeToLog("Shipper is user " . $deliveryUser->oxuser__oxusername->value . "\r\n", 'labels_log.txt');

                $country = oxNew("oxcountry");
                $country->load($deliveryUser->oxuser__oxcountryid->value);

                $this->_setShipper($this->convertStr($deliveryUser->oxuser__oxfname->value . " " . $deliveryUser->oxuser__oxlname->value),
                    $this->convertStr($deliveryUser->oxuser__oxstreet->value),
                    $this->convertStr($deliveryUser->oxuser__oxstreetnr->value),
                    $this->convertStr($deliveryUser->oxuser__oxcity->value),
                    trim($this->convertStr($deliveryUser->oxuser__oxzip->value)),
                    $country->oxcountry__oxisoalpha2->value,
                    $country->oxcountry__oxtitle->value,
                    $this->convertStr($deliveryUser->oxuser__oxusername->value),
                    $this->convertPhone($this->convertStr($deliveryUser->oxuser__oxfon->value)),
                    $this->convertStr(substr($deliveryUser->oxuser__oxcompany->value, 0, 30)));

            } else {


                if ($this->isWawi) {

                    $oMandantprofile = $oOrder->getMandantprofile();



                    if ($myConfig->getConfigParam('delivery_blAlternativeAddress')) {
                        oxRegistry::getUtils()->writeToLog("Shipper is AlternativeAddress " . "\r\n", 'labels_log.txt');

                        $this->_setShipper($this->convertStr($myConfig->getConfigParam('deliveryaltaddr_FirstName') . ' ' . $myConfig->getConfigParam('deliveryaltaddr_LastName')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_Street')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_StreetNr')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_City')),
                            trim($myConfig->getConfigParam('deliveryaltaddr_Zip')),
                            $myConfig->getConfigParam('deliveryaltaddr_country') ? $myConfig->getConfigParam('deliveryaltaddr_country') : $oMandantprofile->oxmandantenprofiles__oxcountry->value,
                            $myConfig->getConfigParam('deliveryaltaddr_country_code'),
                            $myConfig->getConfigParam('deliveryaltaddr_Email'),
                            $this->convertPhone($myConfig->getConfigParam('deliveryaltaddr_Phone')),
                            $this->convertStr(substr($myConfig->getConfigParam('deliveryaltaddr_Company'), 0, 30)));

                    } else {

                        oxRegistry::getUtils()->writeToLog("Shipper is shop " . "\r\n", 'labels_log.txt');
                        $addInfo = array();
                        if ($service == "ups") {
                            $addInfo = array("shipperNumber" => $myConfig->getConfigParam('exonn_ups_shipnumber'));
                        }
                        $shipperStreetInf = $this->getDoubleAddress($oMandantprofile->oxmandantenprofiles__oxstreet->value);

                        $oWawiShop = $oOrder->getWawiShop();
                        $this->_setShipper($this->convertStr($oMandantprofile->oxmandantenprofiles__oxfname->value . ' ' . $oMandantprofile->oxmandantenprofiles__oxlname->value),
                            $this->convertStr($shipperStreetInf["street"]),
                            $this->convertStr($shipperStreetInf["nr"]),
                            $this->convertStr($oMandantprofile->oxmandantenprofiles__oxcity->value),
                            $this->shipperZip = trim($oMandantprofile->oxmandantenprofiles__oxzip->value),
                            $this->convertStr($oMandantprofile->oxmandantenprofiles__oxcountry->value),
                            "DE" /*$myConfig->getConfigParam('EXONN_DELEXT_SHIP_COUNTRY_CODE')*/,
                            $oWawiShop->wawi_shops__oxorderemail->value,
                            $this->convertPhone($oMandantprofile->oxmandantenprofiles__oxtelefon->value),
                            $this->convertStr($oMandantprofile->getCompanyName(), 0, 30),
                            $addInfo);
                    }
                } else {
                    if ($myConfig->getConfigParam('delivery_blAlternativeAddress')) {
                        oxRegistry::getUtils()->writeToLog("Shipper is AlternativeAddress " . "\r\n", 'labels_log.txt');

                        $this->_setShipper($this->convertStr($myConfig->getConfigParam('deliveryaltaddr_FirstName') . ' ' . $myConfig->getConfigParam('deliveryaltaddr_LastName')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_Street')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_StreetNr')),
                            $this->convertStr($myConfig->getConfigParam('deliveryaltaddr_City')),
                            trim($myConfig->getConfigParam('deliveryaltaddr_Zip')),
                            $myConfig->getConfigParam('deliveryaltaddr_country') ? $myConfig->getConfigParam('deliveryaltaddr_country') : $oShop->oxshops__oxcountry->value,
                            $myConfig->getConfigParam('deliveryaltaddr_country_code'),
                            $myConfig->getConfigParam('deliveryaltaddr_Email'),
                            $this->convertPhone($myConfig->getConfigParam('deliveryaltaddr_Phone')),
                            $this->convertStr(substr($myConfig->getConfigParam('deliveryaltaddr_Company'), 0, 30)));

                    } else {

                        oxRegistry::getUtils()->writeToLog("Shipper is shop " . "\r\n", 'labels_log.txt');
                        $addInfo = array();
                        if ($service == "ups") {
                            $addInfo = array("shipperNumber" => $myConfig->getConfigParam('exonn_ups_shipnumber'));
                        }
                        $shipperStreetInf = $this->getDoubleAddress($oShop->oxshops__oxstreet->value);

                        $this->_setShipper($this->convertStr($oShop->oxshops__oxfname->value . ' ' . $oShop->oxshops__oxlname->value),
                            $this->convertStr($shipperStreetInf["street"]),
                            $this->convertStr($shipperStreetInf["nr"]),
                            $this->convertStr($oShop->oxshops__oxcity->value),
                            $this->shipperZip = trim($oShop->oxshops__oxzip->value),
                            $this->convertStr($oShop->oxshops__oxcountry->value),
                            "DE" /*$myConfig->getConfigParam('EXONN_DELEXT_SHIP_COUNTRY_CODE')*/,
                            $oShop->oxshops__oxorderemail->value,
                            $this->convertPhone($oShop->oxshops__oxtelefon->value),
                            $this->convertStr($oShop->oxshops__oxcompany->value, 0, 30),
                            $addInfo);
                    }

                }
            }

            if ($client) {
                $client->setShipper($this->shipperName,
                    $this->shipperStreet,
                    $this->shipperStreetNr,
                    $this->shipperCity,
                    $this->shipperZip,
                    $this->shipperCountry,
                    $this->shipperCountryCode,
                    $this->shipperEmail,
                    $this->shipperPhone,
                    $this->shipperCompany,
                    $this->shipperAddInfo);
            }
        } catch (Exception $e) {
            oxRegistry::getUtils()->writeToLog("Service do not support Shipper addr " . "\r\n", 'labels_log.txt');
            return false;
        }
        return true;
    }

    private $deliveryName;
    private $deliveryStreetNr;
    private $deliveryStreet;
    private $deliveryCity;
    private $deliveryZip;
    private $deliveryCountryCode;
    private $deliveryCountry;
    private $deliveryEmail;
    private $deliveryPhone;
    private $deliveryCompany;
    private $deliveryAddInfo;

    protected function _setDeliveryAddr($name, $street, $streetNr, $city, $zip, $country,
                                  $countryCode, $email, $phone, $company, $addInfo = array()) {
        $this->deliveryName = $name;
        $this->deliveryStreet = $street;
        $this->deliveryStreetNr = $streetNr;
        $this->deliveryCity = $city;
        $this->deliveryZip = $zip;
        $this->deliveryCountry = $country;
        $this->deliveryCountryCode = $countryCode;
        $this->deliveryEmail = $email;
        $this->deliveryPhone = $phone;
        $this->deliveryCompany = $company;
        $this->deliveryAddInfo = $addInfo;
    }

    /**
     * Set shipper data.
     *
     * @param DeliveryClientInterface $client
     * @param $service
     * @param oxorder $oOrder
     * @param oxbase $deliveryUser
     * @param oxdeliverylabel $package
     */
    public function setServiceSendToAddr($client, $service, $oOrder, $package = null) {

        oxRegistry::getUtils()->writeToLog("\r\nSet receiver" . "\r\n", 'labels_log.txt' );

        $sadrType = $oOrder->oxorder__oxdelcity->value ? "oxdel" : "oxbill";
        $country = oxNew("oxcountry");
        $country->load($oOrder->{'oxorder__'.$sadrType.'countryid'}->value);

        $this->_setDeliveryAddr($this->convertStr($oOrder->{'oxorder__'.$sadrType.'fname'}->value . " " . $oOrder->{'oxorder__'.$sadrType.'lname'}->value),
                            $this->convertStr($oOrder->{'oxorder__'.$sadrType.'street'}->value),
                            $this->convertStr($oOrder->{'oxorder__'.$sadrType.'streetnr'}->value),
                            $this->convertStr($oOrder->{'oxorder__'.$sadrType.'city'}->value),
                            trim($this->convertStr($oOrder->{'oxorder__'.$sadrType.'zip'}->value)),
                            $country->oxcountry__oxtitle->value,
                            $country->oxcountry__oxisoalpha2->value,
                            $this->convertStr($oOrder->{'oxorder__oxbillemail'}->value),
                            $this->convertPhone($this->convertStr($oOrder->{'oxorder__'.$sadrType.'fon'}->value)),
                            $this->convertStr(substr(trim($oOrder->{'oxorder__'.$sadrType.'company'}->value),0,30)));

        if($client) {
            $client->setSendToAddr(
                        $this->deliveryName,
                        $this->deliveryStreet,
                        $this->deliveryStreetNr,
                        $this->deliveryCity,
                        $this->deliveryZip,
                        $this->deliveryCountry,
                        $this->deliveryCountryCode,
                        $this->deliveryEmail,
                        $this->deliveryPhone,
                        $this->deliveryCompany,
                        $this->deliveryAddInfo
            );
        }
    }

    private $bankDataAccountOwner;
    private $bankDataBankName;
    private $bankDataIBAN;
    private $bankDataNote1;
    private $bankDataNote2;
    private $bankDataBIC;
    private $bankDataAccountreference;

    protected function _setBankData($accountOwner, $bankName, $iban, $note1 = null, $note2 = null, $bic = null, $accountreference = null) {
        $this->bankDataAccountOwner = $accountOwner;
        $this->bankDataBankName = $bankName;
        $this->bankDataIBAN = $iban;
        $this->bankDataNote1 = $note1;
        $this->bankDataNote2 = $note2;
        $this->bankDataBIC = $bic;
        $this->bankDataAccountreference = $accountreference;
    }

    /**
     * Set shipper data.
     *
     * @param DeliveryClientInterface $client
     * @param $service
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     */
    public function setServiceBankData($client, $service, $oOrder, $package = null) {

        $myConfig = $this->getConfig();
        $oShop = $myConfig->getActiveShop();

        oxRegistry::getUtils()->writeToLog("\r\nSet bank data" . "\r\n", 'labels_log.txt' );

        try {
            if ($myConfig->getConfigParam('delivery_blAlternativeAddress')) {
                oxRegistry::getUtils()->writeToLog("\r\nSet alternative addr data" . "\r\n", 'labels_log.txt' );

                $this->_setBankData($this->convertStr($myConfig->getConfigParam('deliveryaltaddr__AccountOwner')),
                    $this->convertStr($myConfig->getConfigParam('deliveryaltaddr__BankName')),
                    $this->convertStr($myConfig->getConfigParam('deliveryaltaddr__Iban')),
                    "OrderNr: " . $oOrder->oxorder__oxordernr->value,
                    "",
                    $this->convertStr($myConfig->getConfigParam('deliveryaltaddr__Bic')));

            } else {
                oxRegistry::getUtils()->writeToLog("\r\nSet shop data" . "\r\n", 'labels_log.txt' );

                if ($this->isWawi) {
                    $oMandantprofile = $oOrder->getMandantprofile();

                    $this->_setBankData($this->convertStr($oMandantprofile->getCompanyName(), 0, 30),
                        $this->convertStr($oMandantprofile->oxmandantenprofiles__oxbankname->value),
                        $this->convertStr($oMandantprofile->oxmandantenprofiles__oxibannumber->value),
                        "OrderNr: " . $oOrder->oxorder__oxordernr->value,
                        "",
                        $this->convertStr($oMandantprofile->oxmandantenprofiles__oxbiccode->value));

                } else {
                    $this->_setBankData($this->convertStr($oShop->oxshops__oxcompany->value, 0, 30),
                        $this->convertStr($oShop->oxshops__oxbankname->value),
                        $this->convertStr($oShop->oxshops__oxibannumber->value),
                        "OrderNr: " . $oOrder->oxorder__oxordernr->value,
                        "",
                        $this->convertStr($oShop->oxshops__oxbiccode->value));

                }

            }

            if ($client) {
                $client->setBankData(
                    $this->bankDataAccountOwner,
                    $this->bankDataBankName,
                    $this->bankDataIBAN,
                    $this->bankDataNote1,
                    $this->bankDataNote2,
                    $this->bankDataBIC,
                    $this->bankDataAccountreference);
            }
        } catch (Exception $e) {
            return false;
        }
        return true;
    }

    /**
     * @param $service
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     */
    public function setServicePackageAddInfo( $service, $oOrder, $package) {
        $addInfo = array();

        if ($service == "dhl") {
            oxRegistry::getUtils()->writeToLog("Set addInfo for DHL client \r\n", 'labels_log.txt' );
            //['prodcode', 'teilnahmen', 'issperrgut', 'istransportver']

            $addInfo = array();
            list($partnerId, $prodcode) = $this->getDHLPostionsPartnerAndCode($package, $oOrder);
            $addInfo["teilnahmen"] = $partnerId;
            $addInfo["prodcode"] = $prodcode;
            $addInfo["issperrgut"] = $oOrder->oxorder__dhlissperrgut->value;
            $addInfo["istransportver"] = $oOrder->oxorder__dhlistransportver->value;
            $addInfo["isuservice"] = $oOrder->oxorder__dhlisuservice->value;
        }

        return $addInfo;
    }


    public function convertPhone($phone) {
        $phone = preg_replace("/[^0-9,.]/", "", $phone);
        return $phone;
    }

    private function getDoubleAddress($street)
    {   $result = array();
        $result["street"] = $street;
        $result["nr"] = "";

        $Street1 = explode(" ", trim($street));
        if (count($Street1) > 1) {
            $result["nr"] = $Street1[(count($Street1) - 1)];
            unset($Street1[(count($Street1) - 1)]);
            $result["street"] = implode(" ", $Street1);
        }
        else
        {
            $Street1 = explode(".", trim($street));
            if (count($Street1) > 1) {
                $result["nr"] = $Street1[(count($Street1) - 1)];
                unset($Street1[(count($Street1) - 1)]);
                $result["street"] = implode(" ", $Street1);
            }
        }
        return $result;
    }

    public function isLabelsTest() {
        $myConfig = $this->getConfig();
        return $myConfig->getConfigParam('exonn_delext_testmode');
    }

    /**
     * Get DHL partner_id and prod_code from delivery or order.
     *
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     * @return array
     */
    public function getDHLPostionsPartnerAndCode($package, $oOrder) {

        if ($package && $delId = $package->oxdeliverylabels__oxdeliveryid->value) {
            $oDb = oxDb::getDb();
            $rows = $oDb->getAll($q = "select DHLISPARTNER_ID, DHLISPROD_CODE from oxdelivery where oxid='".$delId."'");
            if ($rows && count($rows) > 0) {
                list($partnerId, $prodcode) = array($rows[0][0], $rows[0][1]);
            }
        }
        //for old version this data can be in order
        if (!$partnerId && !$prodcode) {
            $partnerId = $oOrder->oxorder__dhlispartner_id->value;
            $prodcode = $oOrder->oxorder__dhlisprod_code->value;
        }
        return array($partnerId, $prodcode);
    }

    /**
     * @param DeliveryClientInterface $client
     */
    public function setShipperData($client, $deliveryUser) {

    }

    /**
     * @param oxorder $oOrder
     * @param oxdeliverylabel $package
     * @return null|oxUser
     */
    public function getDeliveryUser($oOrder, $package) {
        $deliveryUser = null;

        //TODO: absebder from articles
        /*
        if (method_exists($oOrder, 'getArticlesForDelivery')) {
            $oOrderArticles = $oOrder->getArticlesForDelivery();
        } else {
            $oOrderArticles = $oOrder->getOrderArticles(true);
        }

        foreach($oOrderArticles as $oOrderArticle ) {
            $usePosition = true;
            if ($package) {
                $usePosition = false;
                foreach ($package->getPositions() as $position) {
                    if ($position->oxdeliverylabels__oxartid->value == $oOrderArticle->oxorderarticles__oxartid->value) {
                        $usePosition = true;
                        break;
                    }
                }
            }
            if ($usePosition && $oOrderArticle->oxorderarticles__dhlabsender->value) {
                $deliveryUser = oxNew("oxuser");
                $deliveryUser->load($oOrderArticle->oxorderarticles__dhlabsender->value);
                oxRegistry::getUtils()->writeToLog("DeliveryUser will be orderarticle absendr info: " . $deliveryUser->getId() . "\r\n", 'labels_log.txt');
                break;
            }
        }
        */

        $oOrderUser = $oOrder ? $oOrder->getOrderUser() : null;
        if ($oOrderUser && ($oOrderUser->oxuser__oxlieferscheinfromuser->value && !$oOrderUser->oxuser__oxshopaddr->value)) {
            $deliveryUser = $oOrderUser;
            oxRegistry::getUtils()->writeToLog("DeliveryUser will be OrderUser: " . $deliveryUser->getId() . "\r\n", 'labels_log.txt');
        }
        return $deliveryUser;
    }

    /**
     * Load Label-Packets positions.
     * Return array of packets of oxdeliverylabels.
     *
     *  |-label group 1
     *    |--> art1
     *    |--> art2
     *  |-label group 2
     *    |--> art1
     *    |--> art2
     *
     * @param $orderid
     * @param $delservice
     * @return [oxdeliverylabel[]]
     */
    public function getOrderLabels($orderid, $delservice = "", $packetId = "") {

        $result = array();
        $oDb = oxDb::getDb();
        $rows = $oDb->getAll($q = "select DISTINCT oxlabelgroup from oxdeliverylabels "
                . "where oxorderid='" . $orderid . "'"
                . ($delservice ? " and oxdelservice='".($delservice == "empty" ? "" : $delservice)."'" : "")
                . ($packetId ? " and oxlabelgroup='".$packetId . "'"  : "")
                . " order by oxdelservice, oxcanceled, oxartid, oxartweight");
        //echo $q;
        foreach($rows as $row) {
            $labelArt = oxNew("oxdeliverylabel");
            $labelArt->loadLabelByGroupId($row[0]);
            $result[] = $labelArt;
        }

        return $result;
    }

    public function hasOrderLabelsWithoutService($orderid) {
        $oDb = oxDb::getDb();
        $rows = $oDb->getAll($q = "select 1 from oxdeliverylabels "
                . "where oxorderid='" . $orderid . "' and oxdelservice=''");
        return count($rows);
    }

    /*
    public function getLabelsStatistick($ids, $delservice = "") {
        $result = array();
        $oDb = oxDb::getDb();
        foreach($ids as $orderid) {

            $rows = $oDb->getArray($q = "SELECT DISTINCT oxlabelgroup FROM oxdeliverylabels WHERE oxorderid='" . $orderid . "' and oxdelservice='" . $delservice . "' and oxlabelerr=''");
            $result["ok"] += count($rows);

            $rows = $oDb->getArray($q = "SELECT DISTINCT oxlabelgroup FROM oxdeliverylabels WHERE oxorderid='" . $orderid . "' and oxdelservice='" . $delservice . "' and oxlabelerr!=''");
            $result["err"] += count($rows);
        }
        return $result;
    }
    */

    /**
     * Cancel or delete labels.
     *
     * @param $orderid
     * @param $curDelservice
     * @param string $packetId
     * @param bool $deleteComplet
     */
    public function removeOrderLabels($orderid, $delservice = "", $packetId = "", $deleteComplet = false, $sendDeleteEmail = false) {

        oxRegistry::getUtils()->writeToLog("-------------------\r\n", 'labels_log.txt');
        oxRegistry::getUtils()->writeToLog("Cancel labels for order $orderid and service $delservice and packet $packetId \r\n", 'labels_log.txt');


        if($delservice == "ups" && $packetId) {
            $order = oxNew("oxorder");
            $order->load($orderid);
            if($order->isCODPayment()) {
                oxRegistry::getUtils()->writeToLog("COD UPS will cancel all packets\r\n", 'labels_log.txt');
                $packetId = "";
            }
        }

        foreach ($this->getOrderLabels($orderid, $delservice, $packetId) as $package) {

            /**
             * @var $package oxdeliverylabel
             */

            $curDelservice = $package->getService();

            if ($packetId == "" || $package->oxdeliverylabels__oxlabelgroup->value == $packetId) {

                if (($labelid = $package->oxdeliverylabels__oxlabelid->value) || $deleteComplet) {

                    oxRegistry::getUtils()->writeToLog("Cancel /disable label " . $package->getService().": $labelid ("
                        . $package->oxdeliverylabels__oxlabelgroup->value.")\r\n", 'labels_log.txt');


                    $client = $this->createClient($curDelservice);
                    if($client && !$deleteComplet) {
                        try {
                            $this->initServiceClient($client, $curDelservice);
                            $result = $client->cancelLabel($labelid, $package->oxdeliverylabels__oxmainlabelid->value);
                        } catch(Exception $ex) {
                            $result["err"] = $ex->getMessage();
                        }
                    }

                    $cancelInfo = "";
                    if (!$deleteComplet && ($cancelErr = $result["err"])) {
                        oxRegistry::getUtils()->writeToLog("Cancel error: ".$result["err"]." \r\n", 'labels_log.txt');

                        $cancelErr = "Cancel label error: " . $cancelErr;
                        oxRegistry::getUtils()->writeToLog($cancelErr .")\r\n", 'labels_log.txt');

                        $package->oxdeliverylabels__oxlabelerr = new oxField($cancelErr);
                        $package->oxdeliverylabels__oxcanceled = new oxField($client->getEmailAddrForDeleteLabel() ? 3 : 2);
                        $package->save();

                    } else {

                        if($sendDeleteEmail) {
                            $email = oxNew("oxemail");
                            if ($emailaddr = $client->getEmailAddrForDeleteLabel()) {
                                $emailaddr = "support@exonn.de";
                                $email->sendEmail($emailaddr, strtoupper($curDelservice) . " - Etikett stornieren", "Bitte "
                                    . strtoupper($curDelservice) . " - Etikett mit Sendungsnummer: $labelid stornieren.");
                            }
                        }
                        $sql = "UPDATE oxdeliverylabels SET oxlabelid='', " . ($client->isManyPackagesSupported() ? "" : " oxmainlabelid='',") . " oxtrackcode='', oxlabelinfo='" . $cancelInfo . "', oxlabelerr='" . $cancelErr . "', oxlabelurl='', oxdocsurl='', oxcanceled=1 WHERE oxlabelgroup='" . $package->oxdeliverylabels__oxlabelgroup->value . "'";
                        oxDb::getDb()->Execute($sql);

                        oxRegistry::getUtils()->writeToLog("Cancel done." . ")\r\n", 'labels_log.txt');
                    }
                } else {
                    oxRegistry::getUtils()->writeToLog($package->getService() . ". Cant cancel label, it was not created" . "\r\n", 'labels_log.txt');
                }

            }

            /*if ($deleteComplet) {
                $oDb = oxDb::getDb();
                $delServiceSql = $delservice ? " and oxdelservice='".$delservice."'" : "";
                $packetIdSql = $packetId ? " and oxlabelgroup='".$packetId."'" : "";
                $oDb->execute("delete from oxdeliverylabels where oxorderid='" . $orderid . "'" . $delServiceSql . $packetIdSql);
            }*/
        }
    }

    /**
     * @param $packetId
     */
    public function renewOrderLabel($orderId, $service, $packetId) {
        oxRegistry::getUtils()->writeToLog("-------------------\r\n", 'labels_log.txt');
        oxRegistry::getUtils()->writeToLog("Renew packet $orderId: $service - $packetId \r\n", 'labels_log.txt');

        $clear = array();

        foreach($this->getOrderLabels($orderId, $service, $packetId) as $package) {
            if (!$package->oxdeliverylabels__oxlabelid->value) {
                $sql = "UPDATE oxdeliverylabels SET oxcanceled=0 WHERE oxlabelgroup='" . $package->oxdeliverylabels__oxlabelgroup->value . "'";
                oxDb::getDb()->Execute($sql);
            }
        }
    }

    /**
     * Save information which got from delivery service.
     *
     * @param $orderid
     * @param $packages array with packages, keys must be in the same order as addPackage
     * @param $serviceInfo
     */
    public function saveLabelInfo($orderid, $packages, $serviceInfo) {

        $info = array();
        if (is_array($serviceInfo["err"])) {
            $serviceInfo["err"] = implode("\r\n", $serviceInfo["err"]);
        }

        //common info
        $info["oxdeliverylabels__oxorderid"] = $orderid;
        $info["oxdeliverylabels__oxlabelerr"] = $generalErr = $serviceInfo["err"];
        $info["oxdeliverylabels__oxlabelinfo"] = $serviceInfo["info"];


        /**
         * @var oxdeliverylabel $package  
         */
        foreach ($packages as $pkNumber => $package) {

            //if packages exist then use oxlabelgroup to indicate info in $serviceInfo
            $oxlabelgroup = $package->oxdeliverylabels__oxlabelgroup->value;

            //skip packages which was ok, or label was created only for one package
            if (!$generalErr && !$serviceInfo[$pkNumber]) {
                continue;
            }

            if ($currentInfo = $serviceInfo[$pkNumber]) {
                $info["oxdeliverylabels__oxlabelid"] = $currentInfo["number"];
                $info["oxdeliverylabels__oxlabelurl"] = $currentInfo["url"];
                $info["oxdeliverylabels__oxdocsurl"] = $currentInfo["docsurl"];
                $info["oxdeliverylabels__oxlabelinfo"] .= $currentInfo["info"];
                $info["oxdeliverylabels__oxmainlabelid"] = $currentInfo["mainlabelid"];
                if ($currentInfo["err"]) {
                    $info["oxdeliverylabels__oxlabelerr"] = $currentInfo["err"];
                }
            }

            //generate label groupid for new packagr
            if(!$oxlabelgroup) {
                $oxlabelgroup = oxUtilsObject::getInstance()->generateUID();
            }

            //save package positions
            foreach ($package->getPositions() as $position) {
                //if position exists the don rewrite oxlabelgroup
                if ($position->getId()) {
                    unset($info["oxdeliverylabels__oxlabelgroup"]);
                } else {
                    $info["oxdeliverylabels__oxlabelgroup"] = $oxlabelgroup;
                }

                $position->assign($info);
                $position->save();
            }
        }
    }


    //******************************************************************************************************************
    //******************************************************************************************************************

    public function isWriteable($path) {
        clearstatcache();
        $result =   is_writable($path);
        //echo $path . "<br>";
        //echo $path . ": " . $result . " (" . decoct(fileperms($path) & 0777) . "," . decoct(fileperms($path) & 0755) . ")" . "<br>";
        return $result;
                //(decoct(fileperms($path) & 0777) == 777) || (decoct(fileperms($path) & 0755) == 755);
    }

    public function getLabelsDir($filename = "") {
        $myConfig = $this->getConfig();
        return $myConfig->getConfigParam( 'sShopDir' ) . "/labels" . ($filename ? "/" . $filename : "");
    }

    /**
     * Download file from Label URL.
     *
     * @param oxdeliverylabel[] $labels
     * @param $packageId
     * @return array
     */
    public function collectLabelFiles($labels, $packageId = "") {

        $files = array();

        oxRegistry::getUtils()->writeToLog("\r\nCollect files for ".count($labels) ." labels \r\n", 'labels_log.txt');

        foreach ($labels as $package) {
            if ($packageId == "" || $package->getGroupId() == $packageId) {
                if ($number = $package->oxdeliverylabels__oxlabelid->value && !$package->isCanceled()) {
                    $files[] = $this->getLabelsDir($package->oxdeliverylabels__oxlabelurl->value);
                } else {
                    oxRegistry::getUtils()->writeToLog("Label exists without number, skip it \r\n", 'labels_log.txt');

                }
            }
        }
        oxRegistry::getUtils()->writeToLog("Done, " . count($files) . " file from " . count($labels) . " labels collected \r\n", 'labels_log.txt');

        return $files;
    }

    protected  function getExportTmpDir() {
        $myConfig = $this->getConfig();
        return $myConfig->getConfigParam('sShopDir') . "tmp" . DIRECTORY_SEPARATOR;
    }

    /**
     * @param $files
     * @param $sFilename
     * @return string
     */
    public function printLabelFilesToOne($files, $sFilename) {
        $myConfig = $this->getConfig();

        require_once $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules/exonn/exonn_deliveryplus/fpdf/fpdf.php';
        require_once $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules/exonn/exonn_deliveryplus/fpdi/FPDI_Protection.php';

        oxRegistry::getUtils()->writeToLog("Collecting  " . count($files) . " to one \r\n", 'labels_log.txt' );

        $pdf = new FPDI_Protection();

        $stdSize = Array(0 => Array(0 => 1, 1 => 0),
                         1 => Array(0 => 1, 1 => 0),
                         2 => Array(0 => 12, 1 => 595.28),
                         3 => Array(0 => 12, 1 => 841.89));

        $errCount = 0;
        for ($i = 0; $i < count($files); $i++) {

            try {
                if (strpos($files[$i], ".pdf") !== false ) {
                    $pagecount = $pdf->setSourceFile($files[$i]);

                    for ($j = 0; $j < $pagecount; $j++) {
                        $tplidx = $pdf->importPage(($j + 1)/*, '/MediaBox'*/); // template index.
                        if (!$PageSize = $pdf->tpls[$pdf->tpl]['parser']->pages[$j][1][1]['/MediaBox'][1]) {
                            $PageSize = $stdSize;
                        }

                        $pdf->StdPageSizes['mysize'] = array($PageSize[2][1], $PageSize[3][1]);
                        $pdf->addPage('P', 'mysize'); // orientation can be P|L
                        $pdf->useTemplate($tplidx, 0, 0, 0, 0, TRUE);
                    }
                } else {
                    $pdf->addPage('P', 'dhl'); // orientation can be P|L
                    $scale = $pdf->StdPageSizes['dhl'][1] / $pdf->StdPageSizes['dhl'][1];
                    $pdf->Image($files[$i], 2, 2, 106, 235);
                }
            } catch (Exception $e) {
                $errCount++;
                oxRegistry::getUtils()->writeToLog("Error on add pdf to page ( ".$e->getMessage().") \r\n", 'labels_log.txt' );
            }
        }

        if (count($files) > $errCount) {
            $output = $pdf->Output('', 'S');

            $dirfn = $this->getExportTmpDir() . $sFilename;
            file_put_contents($dirfn, $output);

            return $dirfn;
        } else {
            return "";
        }
    }





    /*
    public function exportdhlcods($ids) {

        ini_set('memory_limit', '1024M');
        $sFilename = "dhlcods.pdf";
        $files = array();
        $myConfig = $this->getConfig();
        $dhlis = oxNew("GKClient");

        $deId = oxDb::getDb()->getOne("select oxid from oxcountry where OXISOALPHA2='de'");

        oxRegistry::getUtils()->writeToLog("Export dhl cods " . count($ids) ." \r\n", 'labels_log.txt' );

        foreach ($ids as $oid) {
            $oOrder = oxNew("oxorder");
            $oOrder->load($oid);

            $upayment = $oOrder->getPaymentType();
            $payment = oxNew("oxpayment");
            $payment->load($upayment->oxuserpayments__oxpaymentsid->value);

            if (!$payment->oxpayments__dhliscod->value || $oOrder->oxorder__oxbillcountryid->value == $deId) continue;
            $orderPackets = $oOrder->defineDeliveryPackets(false, "dhl");
            if (is_array($orderPackets["dhl"])) {
                foreach ($orderPackets["dhl"] as $packet) {
                    $files[] = $dhlis->printcod($oOrder, $packet);
                }
            }
        }

        oxRegistry::getUtils()->writeToLog("Exported files " . count($files) ." \r\n", 'labels_log.txt' );

        $fdir = $myConfig->getConfigParam( 'sShopDir' )."export/";
        if (count($files)) {
            $pdf = new FPDI_Protection();

            for ($i = 0; $i < count($files); $i++) {
                $pagecount = $pdf->setSourceFile($fdir . $files[$i]);
                for ($j = 0; $j < $pagecount; $j++)
                {
                    $tplidx = $pdf->importPage(($j + 1)); // template index.
                    $pdf->addPage(); // orientation can be P|L
                    $pdf->useTemplate($tplidx, 0, 0, 0, 0, TRUE);
                }
            }

            $output = $pdf->Output('', 'S');

            $dirfn = $myConfig->getConfigParam( 'sShopDir' )."export/$sFilename";
            file_put_contents($dirfn, $output);
        }

        return 1;
    }
    */

    /**
     * @param $oOrder oxorder
     * @param $package oxdeliverylabel
     * @return string
     */
    public function printLabelCODForm($package, $deliveryUser = null) {

        $myConfig = $this->getConfig();

        require_once $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules/exonn/exonn_deliveryplus/fpdf/fpdf.php';
        require_once $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.'modules/exonn/exonn_deliveryplus/fpdi/FPDI_Protection.php';

        $oOrder = oxNew("oxorder");
        $oOrder->load($package->getOrderId());

        oxRegistry::getUtils()->writeToLog("Start print LabelCODForm, order id " . $package->getOrderId() ." \r\n", 'labels_log.txt' );

        $sPathIn = $myConfig->getConfigParam( 'sShopDir' ) . "/modules/exonn/exonn_deliveryplus/auslandszahlkarte.pdf";
        define("FPDF_FONTPATH", $myConfig->getConfigParam( 'sShopDir' ) . "/modules/exonn/exonn_deliveryplus/fpdf/font/");

        $deliveryUser = $deliveryUser ? $deliveryUser : $this->getDeliveryUser($oOrder, $package);

        $totalSum = $package->getPackagePrice();

        $this->_forceISO1859  = true;

        $this->setServiceShipper(null, "", $deliveryUser, $oOrder, $package);
        $this->setServiceSendToAddr(null, "", $oOrder, $package);
        $this->setServiceBankData(null, "", $oOrder, $package);

        /**
         * @var $oResPDF FPDI_Protection
         */
        $oResPDF = new FPDI_Protection();
        $oResPDF->AddPage();
        $oResPDF->setSourceFile($sPathIn);
        $tplIdx = $oResPDF->importPage(1); // template index.
        $oResPDF->useTemplate($tplIdx, 0, 0, 0, 0, true);
        $oResPDF->SetFont('Arial','',8);

        $orderSumm = str_replace(".", ",", $totalSum);
        $x = 3;
        $sy = 5;
        $sy2 = 4;
        $y = 9;
        $font = 8;
        $font2 = 11;

        $oResPDF->SetFont('Arial','',$font);

        //sender
        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperCompany);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperName);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperStreet . " " . $this->shipperStreetNr);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperZip . " " . $this->shipperCity . ", " . $this->shipperCountry);

        //number
        $y = 37;
        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $package->getNumber());

        //receiver
        $y = 48;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryCompany);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryName);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryStreet . " " . $this->deliveryStreetNr);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryZip . " " . $this->deliveryCity . ", " . $this->deliveryCountry);

        //EUR
        $oResPDF->SetFont('Arial','',$font2);
        $y = 72;
        $oResPDF->setXY($x + 2, $y);
        $oResPDF->Write(0, "E  U  R");

        //total summ

        $oResPDF->SetFont('Arial','',$font);
        $y = 83;
        $oResPDF->setXY($x + 2, $y);
        $oResPDF->Write(0, $orderSumm);

        $x = 65;

        //receiver
        $y = 9;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryCompany);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryName);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryStreet . " " . $this->deliveryStreetNr);
        $y += $sy;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->deliveryZip . " " . $this->deliveryCity . ", " . $this->deliveryCountry);

        //number
        $y = 35;
        $oResPDF->setXY($x + 60, $y);
        $oResPDF->Write(0, $package->getNumber());

        //sender
        $y = 42;
        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperCompany);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperName);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperStreet . " " . $this->shipperStreetNr);
        $y += $sy2;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->shipperZip . " " . $this->shipperCity . ", " . $this->shipperCountry);

        //bank info
        $y = 62;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->bankDataIBAN);
        $y += 6;

        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->bankDataBIC);

        //EUR
        $oResPDF->SetFont('Arial','',$font2);
        $y = 77;
        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, "E  U  R");

        //total summ
        $oResPDF->SetFont('Arial','',$font);
        $oResPDF->setXY($x + 17, $y);
        $oResPDF->Write(0, $orderSumm);

        $f = new NumberFormatter("de", NumberFormatter::SPELLOUT);
        $nums = explode(",", $orderSumm);
        //total summ
        $y = 83;
        $oResPDF->setXY($x, $y);
        $oResPDF->Write(0, $this->convertStr($f->format($nums[0]) . ($nums[1] ? " " . $f->format($nums[1]) : "")));


        $output = $oResPDF->Output('', 'S');
        $sFilename = $package->getNumber() . "_cod.pdf";

        $dirfn = $this->getExportTmpDir() . $sFilename;
        file_put_contents($dirfn, $output);

        return $dirfn;
    }

    /**
     * @param $packetId id of packet
     * @return string
     */
    public function getExportDocument($packetId) {
        $result = "";

        oxRegistry::getUtils()->writeToLog("Start Export docs " . $packetId ." \r\n", 'labels_log.txt' );

        $label = oxNew("oxdeliverylabel");
        $label->loadLabelByGroupId($packetId);
        $label->getExportDocUrl();

        $oOrder = oxNew("oxorder");
        $oOrder->load($label->getOrderId());

        $client = $this->createClient($label->getService(), true);


        if ($labelId = $label->getNumber()) {
            $urls = $client->getExportDocuments($labelId, "");
            //print_r($urls);

            oxRegistry::getUtils()->writeToLog("Got " . count($urls) . " doc urls \r\n", 'labels_log.txt' );

            $i = 1;
            $files = array();
            foreach($urls as $url) {
                if (filter_var($url, FILTER_VALIDATE_URL)) {
                    $pdftxt = file_get_contents($url);
                    $files[] = $dirfn = $this->getExportTmpDir() . $labelId . "_doc_" . $i . ".pdf";
                    file_put_contents($dirfn, $pdftxt);
                    $i++;
                } else {
                    oxRegistry::getUtils()->writeToLog("Cannot download url, " . $url . " \r\n", 'labels_log.txt' );
                }
            }

            if($oOrder->isCODPayment()) {
                $files[] = $this->printLabelCODForm($label);
            }

            $result = $this->printLabelFilesToOne($files, $labelId . "_doc.pdf");
        }

        return $result;
    }



    public function exportDocs($ids, $service = "")
    {
        ini_set('memory_limit', '1024M');
        $files = array();

        oxRegistry::getUtils()->writeToLog("Export docs " . count($ids) . " \r\n", 'labels_log.txt');

        foreach ($ids as $oid) {
            $oOrder = oxNew("oxorder");
            $oOrder->load($oid);

            if(count($orderLabels = $oOrder->getDeliveryLabels($service)) && $oOrder->needExportDocuments()) {

                foreach ($orderLabels as $label) {
                    if($fn = $this->getExportDocument($label->getGroupId())) {
                        $files[] = $fn;
                    }
                }

            }
        }
        oxRegistry::getUtils()->writeToLog("Exported files " . count($files) . " \r\n", 'labels_log.txt');
        $result = $this->printLabelFilesToOne($files,  "exportdocs_".$service.".pdf");

        return $result;
    }

    /*
    public function exportdhldocs($ids)
    {
        ini_set('memory_limit', '1024M');
        $sFilename = "dhldocs.pdf";
        $files = array();
        $myConfig = $this->getConfig();
        $dhlis = oxNew("GKClient");

        oxRegistry::getUtils()->writeToLog("Export dhl docs " . count($ids) ." \r\n", 'labels_log.txt' );

        foreach ($ids as $oid) {
            $oOrder = oxNew("oxorder");
            $oOrder->load($oid);

            if ($oOrder->oxorder__oxdelcity->value) {
                if (oxDb::getDb()->getOne("SELECT 1 FROM oxcountry WHERE oxeuropunion = 1 AND oxid = '" . $oOrder->oxorder__oxdelcountryid->value . "'")) continue;
            } else {
                if (oxDb::getDb()->getOne("SELECT 1 FROM oxcountry WHERE oxeuropunion = 1 AND oxid = '" . $oOrder->oxorder__oxbillcountryid->value . "'")) continue;
            }

            $orderLabels = $this->getOrderLabels($oOrder->getId(), "dhl");
            foreach($orderLabels as $label) {
                $url = $dhlis->runGetExportDocDDRequest($label->oxdeliverylabels__oxlabelid->value);
                if ($url) {
                    $pdftxt = file_get_contents($url);
                    $files[] = $dirfn = $myConfig->getConfigParam('sShopDir') . "tmp/" . $label->oxdeliverylabels__oxlabelid->value . "_doc";
                    file_put_contents($dirfn, $pdftxt);
                }
            }
        }

        oxRegistry::getUtils()->writeToLog("Exported files " . count($files) ." \r\n", 'labels_log.txt' );

        if (count($files)) {
            $pdf = new FPDI_Protection();

            for ($i = 0; $i < count($files); $i++) {
                $pagecount = $pdf->setSourceFile($files[$i]);
                for ($j = 0; $j < $pagecount; $j++)
                {
                    $tplidx = $pdf->importPage(($j + 1), '/MediaBox'); // template index.
                    $pdf->addPage('P', 'dhldoc'); // orientation can be P|L
                    $pdf->useTemplate($tplidx, 0, 0, 0, 0, TRUE);
                }
                unlink($files[$i]);
            }

            $output = $pdf->Output('', 'S');

            $dirfn = $myConfig->getConfigParam( 'sShopDir' )."export/$sFilename";
            file_put_contents($dirfn, $output);
        }

        return 1;
    }
    */

    private $_forceISO1859 = false;
    private function convertStr($nValue, $spaces = 0, $cut = false) {
        $utf8 = 0;

        $nValue = str_replace( "&amp;", " ", $nValue);
        $nValue = str_replace( "&nbsp;", " ", $nValue);
        $nValue = str_replace( "&auml;", "ä", $nValue);
        $nValue = str_replace( "&ouml;", "ö", $nValue);
        $nValue = str_replace( "&uuml;", "ü", $nValue);
        $nValue = str_replace( "&Auml;", "Ä", $nValue);
        $nValue = str_replace( "&Ouml;", "Ö", $nValue);
        $nValue = str_replace( "&Uuml;", "Ü", $nValue);
        $nValue = str_replace( "&szlig;", "ß", $nValue);
        $nValue = str_replace( "&", " ", $nValue);

        $nValue = str_replace( "& ", "&amp; ", $nValue);

        $unwanted_array = array(    'Š'=>'S', 'š'=>'s','Č'=>'C', 'č'=>'c', 'Ž'=>'Z', 'ž'=>'z', 'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
                            'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O', 'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U',
                            'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss', 'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c',
                            'è'=>'e', 'é'=>'e', 'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o', 'ô'=>'o', 'õ'=>'o',
                            'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'þ'=>'b', 'ÿ'=>'y' );
        $nValue = strtr( $nValue, $unwanted_array );

        $nValue = str_replace( "\"", "", $nValue);
        $nValue = str_replace( "(", "", $nValue);
        $nValue = str_replace( ")", "", $nValue);
        $nValue = str_replace( "\r\n", "", $nValue);
        $nValue = str_replace( "\n", "", $nValue);
        $nValue = str_replace( "/", " / ", $nValue);

        $oConfig = $this->getConfig();
        $str = $nValue;

        if (!$oConfig->iUtfMode || $this->_forceISO1859) {
            if ($cut) {
                $str = substr($str, 0, $cut);
            }
            $result = mb_convert_encoding($str, "ISO-8859-1", "UTF-8");
        } else {
            if ($cut) {
                $str = iconv_substr($str, 0, $cut, "UTF-8");
            }
            $result = $str;
        }
        $result = htmlspecialchars_decode($result);

        return $spaces ? str_replace(' ', '', $result) : $result;
    }

    protected function getShop( $iLangId = null, $iShopId = null )
    {
        $myConfig = $this->getConfig();

        if ( $iLangId === null ) {
            $oShop = $myConfig->getActiveShop();
        } else {
            $oShop = oxNew( 'oxshop' );
            $oShop->loadInLang( $iLangId, $myConfig->getShopId() );
        }

        return $oShop;
    }

    private function getUrlContent($file) {
        if (function_exists('curl_version')) {
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $file);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
            $content = curl_exec($curl);
            curl_close($curl);
        } elseif (file_get_contents(__FILE__) && ini_get('allow_url_fopen')) {
            $content = file_get_contents($file);
        } else {
            echo 'You have neither cUrl installed nor allow_url_fopen activated. Please setup one of those!';
        }
        return $content;
    }

}