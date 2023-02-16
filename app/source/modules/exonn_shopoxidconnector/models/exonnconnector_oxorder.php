<?php
/**
 *    This file is part of OXID eShop Community Edition.
 *
 *    OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.oxid-esales.com
 * @package   admin
 * @copyright (C) OXID eSales AG 2003-2013
 * @version OXID eShop CE
 */

/**
 * Admin user list manager.
 * Performs collection and managing (such as filtering or deleting) function.
 * Admin Menu: User Administration -> Users.
 * @package admin
 */
class exonnconnector_oxorder extends exonnconnector_oxorder_parent
{

    protected $_aBankData = null;


    public function save()
    {
        $blNew = false;
        if (!$this->getId()) {
            $blNew = true;
        }

        $result = parent::save();

        if ( $blNew || !$this->oxorder__oxordernr->value ) {
            $this->_setNumber();
        }
        return $result;
    }


    public function getBankdata()
    {
        if ($this->_aBankData===null) {

            $this->_aBankData = array();
            $oBankkontoList = oxNew("oxlist");
            $oBankkontoList->init('oxbase', 'oxbankingkonten');
            $oBankkontoList->getList();
            foreach($oBankkontoList as $oKonto) {
                $this->_aBankData[]=array(
                    "name" => $oKonto->oxbankingkonten__bankname->getRawValue(),
                    "iban" => $oKonto->oxbankingkonten__oxiban->value,
                    "bic" => $oKonto->oxbankingkonten__oxbic->value,
                );
            }

            //todo: изменить конто если нет данных от вави
            //todo: добавить блок в емайл

            if (!$this->_aBankData) {
                $oShop = $this->getConfig()->getActiveShop();
                $this->_aBankData[]=array(
                    "name" => $oShop->oxshops__oxbankname->getRawValue(),
                    "iban" => $oShop->oxshops__oxibannumber->getRawValue(),
                    "bic" => $oShop->oxshops__oxbiccode->getRawValue(),
                );
            }

        }

        return $this->_aBankData;
    }

    protected function _setNumber()
    {

        $oDB = oxDb::getDb();

        $iOrderNummerLength = oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sExOrderNummerLength' ");
        $iPrefix = (int)(oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sExPrefixNummer' "));

        $oDB->Execute("LOCK TABLES oxorder WRITE");

        if (!$iOrderNummerLength)
            $iOrderNummerLength=7;





        if ($this->getConfig()->getConfigParam('sRandNummerCreate')) {

            do {
                $iRegister = pow(10,($iOrderNummerLength-2));

                $StartNummer = 1;
                $EndNummer = $iRegister - 1;

                $iNum='8'.$iPrefix.str_pad(rand($StartNummer,$EndNummer), $iOrderNummerLength-2, '0', STR_PAD_LEFT);

                $sCheck = "select oxordernr from oxorder where oxordernr='$iNum' && oxid<>".$oDB->quote($this->getId());
                $iChkCnt = $oDB->GetOne( $sCheck );
                if ( $iChkCnt > 1 )
                    continue;


                try {
                    $sCheck = "select oxordernr from oxdocumentsrechnungen where oxordernr='$iNum' ";
                    $iChkCnt = $oDB->GetOne( $sCheck );
                    if ( $iChkCnt > 1 )
                        continue;
                } catch (Exception $e) {
                }

                break;

            }while(true);


        } else {

            $iRegister = pow(10,($iOrderNummerLength-2));

            $StartNummer = ("8".$iPrefix) * $iRegister;
            $EndNummer = ("8".($iPrefix+1)) * $iRegister - 1;

                $iNum = $oDB->GetOne( "select max(oxordernr) from oxorder where oxordernr>=".$StartNummer." && oxordernr<".$EndNummer." && oxid<>".$oDB->quote($this->getId()) );
            if ( !$iNum  ) {

                //für erste bestellung:
                //Derzeit aktuellste Order-ID 4414 würde also nächste 800004415
                $iNumOldFormat = $oDB->GetOne( "select max(oxordernr) from oxorder where oxorderdate>= now() - interval 3 month && oxid<>".$oDB->quote($this->getId()) ); //zur sichercheit nur letzte bestellungen.
                if ($iNumOldFormat) {
                    $iNum = $StartNummer + $iNumOldFormat + 1;
                    if ($iNum > $EndNummer) {
                        $iNum = $StartNummer;
                    }
                } else {
                    $iNum = $StartNummer;
                }


            } else {
                $iNum++;
            }
        }

        $sUpdate = "update oxorder set oxordernr=".$iNum." where oxid = ".$oDB->quote($this->getId());
        $oDB->Execute( $sUpdate );

        $this->oxorder__oxordernr = new oxField($iNum, oxField::T_RAW);


        $oDB->Execute("UNLOCK TABLES");


    }


    /*

    von exonn_delext_oxdelivery

    */

    public function finalizeOrder(oxBasket $oBasket, $oUser, $blRecalculatingOrder = false)
    {

        // load fitting deliveries list
        $usedDeliveries = oxRegistry::get("oxDeliveryList")->getUsedDeliveryList($oBasket, $oUser);

        $result = parent::finalizeOrder($oBasket, $oUser, $blRecalculatingOrder);

        if (!$this->checkDeliveryPacketsExists()) {
            $oDb = oxDb::getDb();
            foreach ($usedDeliveries as $deliveryId => $articles) {
                if (count($articles)) {
                    foreach ($articles as $artid) {
                        $oDb->execute("INSERT INTO oxdelivery2order (oxid, oxorderid, oxdeliveryid,	oxarticleid) VALUES ('" . oxUtilsObject::getInstance()->generateUID() . "', '" . $oBasket->getOrderId() . "', '" . $deliveryId . "', '" . $artid . "');");
                    }
                } else {
                    $oDb->execute("INSERT INTO oxdelivery2order (oxid, oxorderid, oxdeliveryid,	oxarticleid) VALUES ('" . oxUtilsObject::getInstance()->generateUID() . "', '" . $oBasket->getOrderId() . "', '" . $deliveryId . "', '');");
                }
            }
        }
        return $result;
    }

    public function checkDeliveryPacketsExists() {
        $oDb = oxDb::getDb();
        $info = $oDb->getAll($q = "SELECT oxdeliveryid, oxarticleid FROM oxdelivery2order WHERE oxorderid='" . $this->getId() . "'");
        return is_array($info) && count($info) > 0;
    }


}