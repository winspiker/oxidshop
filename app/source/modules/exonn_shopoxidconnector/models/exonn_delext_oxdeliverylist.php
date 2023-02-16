<?php

/**
 *  add to metadata.php in extend section: 'oxdeliverylist' => 'exonn_deliveryext/core/exonn_delext_oxdeliverylist',
 **/ 
class exonn_delext_oxdeliverylist extends exonn_delext_oxdeliverylist_parent {

    public function getUsedDeliveryList($oBasket, $oUser = null, $sDelCountry = null, $sDelSet = null)
    {
        // ids of deliveries that does not fit for us to skip double check
        $aSkipDeliveries = array();
        $aDelSetList = oxRegistry::get("oxDeliverySetList")->getDeliverySetList($oUser, $sDelCountry, $sDelSet);
        $usedDeliveries = array();
        $oDb = oxDb::getDb();
        $shipId = $oBasket->getShippingId();

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

                if ($oDb->getOne("select 1 from oxdel2delset where OXDELSETID='" . $shipId . "' && OXDELID='" . $sDeliveryId . "'")) {
                    if ($oDelivery->isForBasket($oBasket)) {
                        $articles = $oDelivery->isArticlesForBasket($oBasket);
                        if ($oDelivery->oxdelivery__oxfinalize->value) {
                            $articles[] = "stop";
                        }
                        $usedDeliveries[$sDeliveryId] = $articles;
                    }
                }
            }


        }
        //print_r($usedDeliveries);
        //exit;
        return $usedDeliveries;
    }
}
