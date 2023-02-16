<?php

use \OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
class crefopay_thankyou extends crefopay_thankyou_parent
{
    public function render()
    {
        return parent::render();
    }

    public function callback()
    {
        $logger = oxNew('crefoPayLogger');
        $getData = $_GET;
        $cpOrderId = $getData['orderID'];

        // additional check if we really really have a user now
        try {
            $oUser = $this->getUser();
            $oBasket = $this->getBasket();
        } catch (Exception $e) {
            $logger->warn(__FILE__, "Problem beim Versuch User/Basket wiederherzustellen: " . $e->getMessage());
            $logger->debug(__FILE__, "Versuche Session Informationen wiederherzustellen.");

            $sessionId = $this->restoreSessionIdFromOrder($cpOrderId);
            if ($sessionId != null) {
                // restore session ID
                oxRegistry::getSession()->setId($sessionId);
                $logger->debug(__FILE__, "Die Sessioninformationen der Bestellung mit der Order ID " . $cpOrderId . " wurde erfolgreich wiederhergestellt.");

            } else {
                // unable to restore sessionId
                $logger->warn(__FILE__, "Die Session der Bestellung mit der Order ID " . $cpOrderId . " konnte nicht wiederhergestellt werden.");
                # do more stuff here in later versions...
            }
        }

        if (!$oUser) {
            # retry restoring from session
            $logger->debug(__FILE__, "Versuche Benutzer Informationen wiederherzustellen.");

            $oUser = oxRegistry::getSession()->getVariable('_oUser');
        }

        if (!$oBasket) {
            # retry restoring from session
            $logger->debug(__FILE__, "Versuche Warenkorb Informationen wiederherzustellen.");

            $oBasket = oxRegistry::getSession()->getVariable('_oBasket');
        }

        oxRegistry::getSession()->setReservationExists();
        oxRegistry::getSession()->setCrefoOrderId($cpOrderId);
        try {
            $oOrder = oxNew('crefopay_oxorder');

            // finalizing ordering process (validating, storing order into DB, executing payment, setting status ...)
            if ($oOrder->finalizeOrder($oBasket, $oUser)) {
                $iSuccess = true;
            } else {
                # error while try to finalize order
                $logger->log(2, __FILE__, "Fehler beim Versuch die Bestellung mit CrefoPay Order ID " . $cpOrderId . " abzuschließen.");
                $iSuccess = false;
            }

            // performing special actions after user finishes order (assignment to special user groups)
            $oUser->onOrderExecute($oBasket, $iSuccess);

            // Database update
            $cpOxDb = oxDb::getDb();
            $oxId = $oOrder->oxorder__oxpaymentid->value;
            $sql = "update cporders set OXID=? where CPORDERID=?";
            $result = $cpOxDb->execute($sql, [$oxId, $cpOrderId]);
            if ($result) {
                $logger->log(0, __FILE__, "update erfolgreich");
            } else {
                $logger->log(0, __FILE__, "update nicht erfolgreich");
            }

        } catch (oxOutOfStockException $oEx) {
            $logger->log(2, __FILE__, "Out of Scope - Fehler beim Versuch die Bestellung mit CrefoPay Order ID " . $cpOrderId . " abzuschließen.");
            $oEx->setDestination('basket');
            oxRegistry::get("oxUtilsView")->addErrorToDisplay($oEx, false, true, 'basket');
        } catch (oxNoArticleException $oEx) {
            $logger->log(2, __FILE__, "Kein Artikel - Fehler beim Versuch die Bestellung mit CrefoPay Order ID " . $cpOrderId . " abzuschließen.");
            oxRegistry::get("oxUtilsView")->addErrorToDisplay($oEx);
        } catch (oxArticleInputException $oEx) {
            $logger->log(2, __FILE__, "Artikel Eingabe - Fehler beim Versuch die Bestellung mit CrefoPay Order ID " . $cpOrderId . " abzuschließen.");
            oxRegistry::get("oxUtilsView")->addErrorToDisplay($oEx);
        }

        //finish redirect
        $conf = oxRegistry::getConfig();
        oxRegistry::getUtils()->redirect($conf->getShopCurrentURL() . '&cl=thankyou', true, 302);
    }


    public function getPaymentMethod() 
    {
        $cpOxDb = oxDb::getDb();
        $logger = oxNew('crefoPayLogger');
        $sessionId = oxRegistry::getSession()->getId();

        // update OXORDERID
        $cpOxDb->setFetchMode(2);
        try {
            // get paymentMethod from cporders
            $sql = 'select CPPAYMENTMETHOD from cporders where OXSESSIONID =?';
            $result = $cpOxDb->getRow($sql, [$sessionId]);
            return $result['CPPAYMENTMETHOD'];    

        } catch (Exception $e) {
            $logger->error(__FILE__, "Fehler beim lesen der Datenbank Tabelle: " . $e->getMessage());
            return 'oxemtpy';
        }
    }


    /**
     * try to restore missing oxid session by loading the session ID from cporders table
     * 
     * @param string $orderId
     * 
     * @return mixed
     */
    private function restoreSessionIdFromOrder($orderId) {
        $logger = oxNew('crefoPayLogger');
        // make sure orderId is set
        if (empty($orderId) || $orderId == null) {
            $logger->log(2, __FILE__, "Kann keine Session mit leerer Order ID wiederherstellen.");
            return null;
        }

        $cpOxDb = oxDb::getDb();
        $cpOxDb->setFetchMode(2);
        $sql = 'select OXSESSIONID from cporders where CPORDERID="' . $orderId . '"';
        
        try {
            $result = $cpOxDb->getRow($sql);
            $sessionId = $result['OXSESSIONID'];
            if (empty($sessionId)) {
                return null;
            } else {
                return $sessionId;
            }

        } catch (Exception $e) {
            $logger->error(__FILE__, "Fehler beim lesen der Datenbank Tabelle: " . $e->getMessage());
            return null;
        }
    }

}
