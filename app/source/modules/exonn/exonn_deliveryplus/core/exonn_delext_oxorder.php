<?php

/**
 *  add to metadata.php in extend section: 'oxorder' => 'exonn_deliveryext/exonn_delext_oxorder',
 **/

/**
 * Class exonn_delext_oxorder.
 *
 * @extends oxOrder
 */
class exonn_delext_oxorder extends exonn_delext_oxorder_parent {

    public function finalizeOrder(oxBasket $oBasket, $oUser, $blRecalculatingOrder = false)
    {

        // load fitting deliveries list
        $usedDeliveries = oxRegistry::get("oxDeliveryList")->getUsedDeliveryList($oBasket, $oUser);

        $result = parent::finalizeOrder($oBasket, $oUser, $blRecalculatingOrder);

        if (!$this->checkDeliveryPacketsExists()) {
            $oDb = oxDb::getDb();
            oxRegistry::getUtils()->writeToLog("finalizeOrder save usedDeliveries: " . count($usedDeliveries) . " \r\n", 'labels_log.txt' );
            foreach ($usedDeliveries as $deliveryId => $articles) {
                if (count($articles)) {
                    foreach ($articles as $artid) {
                        oxRegistry::getUtils()->writeToLog(" -- delid " . $deliveryId . " artid " . $artid . " \r\n", 'labels_log.txt' );
                        $oDb->execute("INSERT INTO oxdelivery2order (oxid, oxorderid, oxdeliveryid,	oxarticleid) VALUES ('" . oxUtilsObject::getInstance()->generateUID() . "', '" . $oBasket->getOrderId() . "', '" . $deliveryId . "', '" . $artid . "');");
                    }
                } else {
                    oxRegistry::getUtils()->writeToLog(" -- delid " . $deliveryId . " artid NO ART \r\n", 'labels_log.txt' );
                    $oDb->execute("INSERT INTO oxdelivery2order (oxid, oxorderid, oxdeliveryid,	oxarticleid) VALUES ('" . oxUtilsObject::getInstance()->generateUID() . "', '" . $oBasket->getOrderId() . "', '" . $deliveryId . "', '');");
                }
            }
        }
        return $result;
    }

    public function checkDeliveryPacketsExists()
    {
        $oDb = oxDb::getDb();
        $info = $oDb->getAll($q = "SELECT oxdeliveryid, oxarticleid FROM oxdelivery2order WHERE oxorderid='" . $this->getId() . "'");
        return is_array($info) && count($info) > 0;
    }

    /**
     * bugfix for old orders
     */
    public function checkIfDeliveryIsOk($sDeliveryId) {
        $oDb = oxDb::getDb();
        $res = $oDb->getOne($q = "select 1 from oxdel2delset where OXDELSETID='" . $this->oxorder__oxdeltype->value . "' && OXDELID='" . $sDeliveryId . "'");
        return $res;
    }


    /*
    public function findDelivery() {
        $oBasket = $this->_getOrderBasket();
        $oUser = $this->getOrderUser;
        $sDelCountry = $this->oxorder__oxdelcountryid->value ? $this->oxorder__oxdelcountryid->value : $this->oxorder__oxbillcountryid->value;
        $sDelSet = $this->oxorder__oxdeltype->value;

        // ids of deliveries that does not fit for us to skip double check
        $aSkipDeliveries = array();
        $aFoundDeliveries = array();
        $aDelSetList = oxRegistry::get("oxDeliverySetList")->getDeliverySetList($oUser, $sDelCountry, $sDelSet);

        // must choose right delivery set to use its delivery list
        foreach ($aDelSetList as $sDeliverySetId => $oDeliverySet) {

            // loading delivery list to check if some of them fits
            $aDeliveries = $this->_getList($oUser, $sDelCountry, $sDeliverySetId);

            foreach ($aDeliveries as $sDeliveryId => $oDelivery) {

                // skipping that was checked and didn't fit before
                if (in_array($sDeliveryId, $aSkipDeliveries)) {
                    continue;
                }

                $aSkipDeliveries[] = $sDeliveryId;

                if ($oDelivery->isForBasket($oBasket, false)) {

                    // delivery fits conditions
                    $aFoundDeliveries[$sDeliveryId] = $aDeliveries[$sDeliveryId];

                    // removing from unfitting list
                    array_pop($aSkipDeliveries);

                    // maybe checked "Stop processing after first match" ?
                    if ($oDelivery->oxdelivery__oxfinalize->value) {
                        break;
                    }
                }
            }

        }

        $result = 0;
        foreach ($aFoundDeliveries as $delivery) {
            echo $delivery->oxdelivery__oxtitle->value . "<br>";
        }

        return $result;
    }
    */

    /**
     * Deviding order postions to delivery packets positions.
     *
     * Structure of result:
     *  [service]
     *     |-- oxdeliverylabel as package
     *     |    |-- oxdeliverylabel as package position
     *     |    |-- ...
     *     |-- ...
     *   ...
     *
     * @return array()[deliveryservice][packet][packetpositions]
     */
    public function defineDeliveryPackets($filterService = "") {

        $oDb = oxDb::getDb();
        $usedDeliveries = $oDb->getAll($q = "select oxdeliveryid, oxarticleid from oxdelivery2order where oxorderid='" . $this->getId() . "'");

        $usedDeliveriesInfo = array();
        $stopDelivery = "";
        $emptyDelivery = "";

        foreach($usedDeliveries as $row) {
            if (!$this->checkIfDeliveryIsOk($row[0])) {
                continue;
            }

            if($row[1] != "stop") {
                $usedDeliveriesInfo[$row[0]][] = $row[1];
            }
            if ($row[1] == "stop") {
                $stopDelivery = $row[0];
            }
            if ($row[1] == "") {
                $emptyDelivery = $row[0];
            }
        }

        $orderPackets = array();
        foreach($this->getOrderArticles() as $orderArticle) {
            $inPacket = false;
            $deliveryId = "";

            foreach ($usedDeliveriesInfo as $deliveryId => $articleId) {
                if (in_array($orderArticle->oxorderarticles__oxartid->value, $articleId)) {
                    $inPacket = $deliveryId;
                    break;
                }
            }

            if (!$inPacket) {
                if ($stopDelivery) {
                    $orderPackets[$stopDelivery][] = $orderArticle;
                } elseif ($emptyDelivery) {
                    $orderPackets[$emptyDelivery][] = $orderArticle;
                } else {
                    $orderPackets[$deliveryId ? $deliveryId : "xxx" ][] = $orderArticle;
                }
            } else {
                $orderPackets[$inPacket][] = $orderArticle;
            }
        }

        $deliveryPackets = array();

        // if article must be delivered in dedecates package then it add to new package
        // else article going to "general" package

        foreach ($orderPackets as $deliveryId => $articles) {
            $delivery = oxNew("oxdelivery");
            $delService = $delivery->load($deliveryId) ? $delivery->oxdelivery__oxdelservice->value : "";

            foreach ($articles as $orderArticle) {

                $artId = $orderArticle->oxorderarticles__oxartid->value;
                $amount = $orderArticle->oxorderarticles__oxamount->value;
                $price = $orderArticle->getPrice()->getPrice();//$orderArticle->oxorderarticles__oxprice->value;
                $artnum = $orderArticle->oxorderarticles__oxartnum->value;
                $orderid = $this->getId();

                $article = oxNew("oxarticle");
                $article->load($artId);

                $articleParts = $article->getArticleParts($price);

                if (count($articleParts)) {
                    $partsPackets = array();
                    foreach($articleParts as $key => $articlePart) {
                        $package = oxNew("oxdeliverylabel");
                        $package->fillPositionInfo($orderid, $artId, $artnum, 1, $articlePart["weight"], $articlePart["price"],
                            $article->getDeliveryTitle(), $deliveryId, $delService);

                        $position = clone $package;
                        $package->addPosition($position);
                        $partsPackets[] = $package;
                    }

                    for ($i = 0; $i < $amount; $i++) {
                        foreach ($partsPackets as $partsPacket) {
                            $deliveryPackets[$delService][] = $partsPacket->clonePackage();
                        }
                    }

                } else {

                    $package = $deliveryPackets[$delService]["general"];

                    $position = oxNew("oxdeliverylabel");
                    $position->fillPositionInfo($orderid, $artId, $artnum, $amount, $article->getDeliveryWeight(), $price,
                            $article->getDeliveryTitle(), $deliveryId, $delService);
                    if (!$package) {
                        $package = clone $position;
                    }
                    $package->addPosition($position);
                    $deliveryPackets[$delService]["general"] = $package;

                    //TODO: if general packet weight > 30 need to general packets
                }
            }
        }


        //correction if no delivery
        if(!$this->checkDeliveryPacketsExists()) {

            foreach ($deliveryPackets as $serv => $servicePackets) {
                /**
                 * @var oxdeliverylabel $package
                 */
                foreach ($servicePackets as $packetId => $package) {

                    foreach ($package->getPositions() as $key => $position) {

                        $parentId = $oDb->getOne("select oxparentid from oxarticles where oxid='" . $position->oxdeliverylabels__oxartid->value . "'");
                        $rows = $oDb->getAll($q = "select oxdeliveryid from oxobject2delivery where oxobjectid='" . ($parentId ? $parentId : $position->oxdeliverylabels__oxartid->value) . "'");

                        foreach ($rows as $row) {
                            if ($oDb->getOne("select 1 from oxobject2delivery where oxdeliveryid = '".$row[0]."' && oxobjectid='".($this->oxorder__oxdelcountryid->value ? $this->oxorder__oxdelcountryid->value : $this->oxorder__oxbillcountryid->value)."'")) {
                                if ($this->checkIfDeliveryIsOk($deliveryId = $row[0])) {
                                    if ($newserv = $oDb->getOne("SELECT oxdelservice FROM oxdelivery WHERE oxid='" . $deliveryId . "'")) {

                                        $position->oxdeliverylabels__oxdeliveryid->value = $deliveryId;
                                        $position->oxdeliverylabels__oxdelservice->value = $newserv;
                                        $package->oxdeliverylabels__oxdeliveryid->value = $deliveryId;
                                        $package->oxdeliverylabels__oxdelservice->value = $newserv;

                                        //if packahe is general, the move only on position
                                        //else move whole package

                                        if ($packetId == "general") {

                                            $newPackage = $deliveryPackets[$newserv]["general"];
                                            if(!$newPackage) {
                                                $newPackage = clone $position;
                                                $deliveryPackets[$newserv]["general"] = $newPackage;
                                            }
                                            $package->removePosition($position->oxdeliverylabels__oxartid->value);
                                            $newPackage->addPosition($position);
                                        } else {
                                            $deliveryPackets[$newserv][] = $package;
                                            unset($deliveryPackets[$serv][$packetId]);
                                        }

                                        break;
                                    }
                                }
                            }
                        }
                    }
                    if (count($package->getPositions()) === 0) {
                        unset($deliveryPackets[$serv][$packetId]);
                    }
                }
                if (count($deliveryPackets[$serv]) === 0) {
                        unset($deliveryPackets[$serv]);
                    }
            }
        }


        if ($this->isCODPayment()) {
            $largePrice = 0;
            $largePacket = null;
            $largeServ = "";
            $totalPositions = 0;
            foreach ($deliveryPackets as $serv => $packets) {
                foreach($packets as $packetId => $package) {
                    $totalPositions += $price = $package->getPackagePrice();
                    if ($price > $largePrice || $largePacket == null) {
                        $largePrice = $price;
                        $largePacket = $package;
                        $largeServ = $serv;
                    }
                }
            }

            $position = oxNew("oxdeliverylabel");
            $position->fillPositionInfo($this->getId(), "", "", 1, 0, $restSum = (($this->oxorder__nachnahmebetrag->value ? $this->oxorder__nachnahmebetrag->value : $this->oxorder__oxtotalordersum->value) - $totalPositions),
                            "", $largePacket->oxdeliverylabels__oxdeliveryid->value, $largeServ);
            $position->restsum = 1;
            $largePacket->addPosition($position);
        }
        if ($filterService == "empty") {
           // print_r($deliveryPackets);
        }

        return $filterService ? $deliveryPackets[$filterService == "empty" ? "" : $filterService] : $deliveryPackets;
    }

    public function getCheckAndFixDeliveryLabels() {
        $packets = $this->getDeliveryLabelsGroupByService();
        if(count($packets[''])) {
            $oDb = oxDb::getDb();
            foreach($packets[''] as $packet) {
               if($deliveryId = $packet->oxdeliverylabels__oxdeliveryid->value) {
                   if ($newserv = $oDb->getOne("SELECT oxdelservice FROM oxdelivery WHERE oxid='" . $deliveryId . "'")) {
                       $packet->savePositions($newserv);
                   }
               }
            }
        }

    }

    /**
     * Load Label-Packet positions.
     *
     * @param string $service
     * @return oxdeliverylabel[]
     */
    public function getDeliveryLabels($service = "") {
        $exonn_delext_labels = oxNew("exonn_delext_labels");
        $result = $exonn_delext_labels->getOrderLabels($this->getId(), $service);
        return $result;
    }

    /**
     * Load Label-Packet positions grouped by services.
     *
     * @param string $service
     * @return [oxdeliverylabel[]]
     */
    public function getDeliveryLabelsGroupByService() {
        $result = array();
        $labels = $this->getDeliveryLabels();

        foreach($labels as $package) {
            $result[$package->getService()][] = $package;
        }

        return $result;
    }

    public function getLabelsInformation() {
        $result = array();
        $labels = $this->getDeliveryLabelsGroupByService();
        if(count($labels) == 0) {
            $labels = $this->defineDeliveryPackets();
        }
        foreach ($labels as $serv => $packages) {
            /**
             * @var oxdeliverylabel $mainLabel
             */
            foreach ($packages as $mainLabel) {
                $result[$serv][] = $mainLabel->labelPositionsToPacketInfo();
            }
        }
        return $result;
    }

    public function getLabelsInformationHTML() {
        $result = "";
        $labels = $this->getDeliveryLabelsGroupByService();
        if(count($labels) == 0) {
            $labels = $this->defineDeliveryPackets();
        }

        $res = array();
        $counts = array();
        $servErrs = array();
        $servDone = array();

        if(count($labels)) {

            foreach ($labels as $serv => $packages) {
                /**
                 * @var oxdeliverylabel $mainLabel
                 */
                foreach ($packages as $mainLabel) {

                    $counts[$serv]++;
                    /**
                     * @var oxdeliverylabel $position
                     */
                    //check for old version
                    $arts = "";
                    foreach ($mainLabel->getPositions() as $position) {
                        $article = $position->getArticle();
                        $arts .= $article->oxarticles__oxtitle->value . " " . $position->oxdeliverylabels__oxartamount->value . " Stk<br>";
                    }

                    if ($mainLabel->oxdeliverylabels__oxlabelid->value) {
                        $servDone[$serv]++;

                        $res[$serv] .= '<a target="_blank" href="' . $mainLabel->getLabelUrl() . '" '
                            . ' class="deliver_label" articles="' . $arts . '">'
                            . strtoupper($serv) . " " . $counts[$serv] . '</a><br>';
                    } else {
                        if ($mainLabel->oxdeliverylabels__oxlabelerr->value) {
                            $labelerrHTML = $mainLabel->getLabelErrHTML();
                            $servErrs[$serv]++;
                        }

                        $res[$serv] .= '<label title="' . ($labelerrHTML ? $labelerrHTML : '') . '" '
                            . ($labelerrHTML ? 'style="color: red; cursor: help;"' : '') . '>'
                            . strtoupper($serv) . ' ' . $counts[$serv] . '</label><br>';
                    }
                }
            }
        }
        /*
        //oldversions
        if ($this->oxorder__dhlislabelurl->value) {
            $res["dhl"] = '<a href="' . $this->oxorder__dhlislabelurl->value . '">DHL</a><br>' . $result;
            $counts["dhl"] = 1;
        }
        */
        $i = 1;
        foreach ($res as $serv => $info) {
            $lcount = $counts[$serv];
            $result .= '<label title="Versanddienstleister" style="color: '.($servErrs[$serv] ? 'orange' : ($servDone ? 'green' : '#aaa')).';" class="active-popovers"  data-placement="right" data-trigger="hover"  data-rel="popover" data-original-title="Labels">'
                . strtoupper($serv) . '<sup>'.$lcount.'</sup>'
                . '<span class="help-text">' . $info . '</span></label>' . ($i < count($res) ? " | " : "");
            $i++;
        }


        return $result;
    }

    public function removeDeliveryLabels($service = "", $packetId = "") {
        $exonn_delext_labels = oxNew("exonn_delext_labels");
        $exonn_delext_labels->removeOrderLabels($this->getId(), $service, $packetId);
    }

    public function isCODPayment() {
        return $this->oxorder__oxpaymenttype->value == "oxidcashondel";
    }

    public function needExportDocuments() {

        $countryId = $this->oxorder__oxdelcity->value ? $this->oxorder__oxdelcountryid->value : $this->oxorder__oxbillcountryid->value;

        return !oxDb::getDb()->getOne("SELECT 1 FROM oxcountry WHERE oxeuropunion = 1 AND oxid = '" . $countryId . "'");
    }









    private function checkDhlCodeMode($code) {
        return strpos($code, "003") === 0;
    }

    public function getTrackingNumbers() {
        $numbers = array();

        $labels = $this->getDeliveryLabels();
        $gotDhl = false;
        foreach($labels as $key => $labelInfo) {
            $firstLabel = array_pop($labelInfo);
            if ($code = ($firstLabel->oxdeliverylabels__oxtrackcode->value ? $firstLabel->oxdeliverylabels__oxtrackcode->value : $firstLabel->oxdeliverylabels__oxlabelid->value)) {
                if ($firstLabel->oxdeliverylabels__oxdelservice->value == "dhl") {
                    $gotDhl = $gotDhl || $code;
                }
                $numbers[] = array("number" => $code, "type" => $firstLabel->oxdeliverylabels__oxdelservice->value, "mode" => $this->checkDhlCodeMode($code));
            }
        }
        //for old version
        if (!$gotDhl && $this->oxorder__dhlislabelurl->value) {
            $numbers[] = array("number" => $this->oxorder__oxtrackcode->value, "type" => "dhl", "mode" => $this->checkDhlCodeMode($this->oxorder__oxtrackcode->value));
        }

        //for sxt old orders
        if (count($numbers) == 0 && getWawiId() == "45428500ea2e586bb35c2242b0995719") {
            $numbers = $this->getTrackingNumbersSXT();
        }
        return $numbers;
    }

    private function getTrackingNumbersSXT() {
        $numbers = array();

        $db = oxDb::getDb();
        $rows = $db->getAll("select * from oxtrackings where order_nr='" . $this->oxorder__oxordernr->value . "'");
        foreach ($rows as $row) {
            $mode = 0;
            if ($row[2] == "dhl" && strpos($row[1], "003") === 0) {
                $mode = 1;
            }
            $numbers[] = array("number" => $row[1], "type" => $row[2], "mode" => $mode);
        }

        return $numbers;
    }

}
