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
class exonnconnector_oxuser extends exonnconnector_oxuser_parent
{


    public function createUser()
    {


        $res = parent::createUser();

        if (1 /*weil das ist immer neue User */ || !$this->oxuser__oxcustnr->value)
            $this->_setNumber();

        return $res;
    }

    public function delete($sOXID = null)
    {

        if (!$sOXID) {
            $sOXID = $this->getId();
        }

        //wir löschen Kunden nur wenn keine Bestelungen und Buchungen gibt, sonst ändern wir die Username

        oxDb::getDb()->execute("update oxuser set oxusername=concat('KundeGeloescht_', oxusername, '_".str_replace(" ",".",microtime())."') where oxid=".oxDb::getDb()->quote($sOXID));

        return true;
    }

    public function save()
    {
        $blNew = false;
        if (!$this->getId()) {
            $blNew = true;
        }

        $res = parent::save();

        if ($blNew || !$this->oxuser__oxcustnr->value)
            $this->_setNumber();


        return $res;
    }



    protected function _setNumber()
    {

        $oDB = oxDb::getDb();

        $iUserNummerLength = $oDB->getOne("select oxvalue from exonnwawi_config where oxvar='sExUserNummerLength' ");
        $iPrefix = $oDB->getOne("select oxvalue from exonnwawi_config where oxvar='sExPrefixNummer' ");

        $oDB->Execute("LOCK TABLES oxuser WRITE");


        if (!$iUserNummerLength)
            $iUserNummerLength=7;

        if ($this->getConfig()->getConfigParam('sRandNummerCreate')) {

            do {
                $iRegister = pow(10,($iUserNummerLength-2));

                $StartNummer = 1;
                $EndNummer = $iRegister - 1;

                $iNum='1'.$iPrefix.str_pad(rand($StartNummer,$EndNummer), $iUserNummerLength-2, '0', STR_PAD_LEFT);

                $sCheck = "select oxcustnr from oxuser where oxcustnr='$iNum'  && oxid<>".$oDB->quote($this->getId());
                $iC = $oDB->GetOne( $sCheck );
                if ( $iC > 1 )
                    continue;

                $iChkCnt=$iNum;

                break;

            }while(true);


        } else {

            $iRegister = pow(10,($iUserNummerLength-2));

            $StartNummer = ("1".$iPrefix) * $iRegister;
            $EndNummer = ("1".($iPrefix+1)) * $iRegister - 1;

            $iChkCnt = $oDB->GetOne( "select max(oxcustnr) from oxuser where oxcustnr>=".$StartNummer." && oxcustnr<".$EndNummer."  && oxid<>".$oDB->quote($this->getId()) );
            if ( !$iChkCnt  ) {
                $iChkCnt=$StartNummer;
            } else {
                $iChkCnt++;
            }

            //extra sicherung, wenn kunde in Datenbank gelöscht, wird trotzdem neue Nummer erstellt
            $iNumFromlog = @file_get_contents($this->getLogFilePath());
            if ($iChkCnt<=$iNumFromlog) {
                $iChkCnt = $iNumFromlog+1;
            }
        }

        $sUpdate = "update oxuser set oxcustnr=".$iChkCnt." where oxid = ".$oDB->quote($this->getId());
        $oDB->Execute( $sUpdate );

        $this->oxuser__oxcustnr = new oxField($iChkCnt, oxField::T_RAW);

        file_put_contents($this->getLogFilePath(), $iChkCnt);

        $oDB->Execute("UNLOCK TABLES");

    }

    protected function getLogFilePath()
    {
        $oConfig = $this->getConfig();
        if (!file_exists($oConfig->getOutDir()."exonn_documents/exonn_shopoxidconnector")) {
            if (!file_exists($oConfig->getOutDir()."exonn_documents")) {
                mkdir($oConfig->getOutDir()."exonn_documents");
            }

            mkdir($oConfig->getOutDir()."exonn_documents/exonn_shopoxidconnector");

        }

        return $oConfig->getOutDir()."exonn_documents/exonn_shopoxidconnector/data.txt";
    }


    public function getCustomerCredit()
    {

        if (!$this->getConfig()->getConfigParam('EXONN_CONNECTOR_KREDITLIMIT_ACTIV')) {
            return array();
        }

        $oBasket = $this->getSession()->getBasket();

        $sWawiId = oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sWawiId' ");
        $sWawiShopId = oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sWawiShopId' ");
        $sWawiUrl = oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sWawiUrl' ");
        $sKeyShopWawi = oxDb::getDb()->getOne("select oxvalue from exonnwawi_config where oxvar='sKeyShopWawi' ");

        $url = $sWawiUrl . "/index.php?cl=shopconnector_cron&fnc=getCustomerCreditLimit&shop_id=".$sWawiShopId."&wawi_id=" . $sWawiId.'&keywawi='.$sKeyShopWawi.'&user_id='.$this->getId();

        $curl = curl_init($url);
        curl_setopt ($curl, CURLOPT_HEADER, 0);
        curl_setopt ($curl, CURLOPT_RETURNTRANSFER, 1);
        $res = json_decode(curl_exec ($curl));
        curl_close ($curl);

        $credit = array(
            'offenePosten' => ($res->sumOpenPosition > 1 ? $res->sumOpenPosition : 0),
            'creditLimit' => $res->usercreditLimit,
            'availableLimit' => $res->usercreditLimit - $res->sumOpenPosition,
        );

        if($credit["availableLimit"] < $oBasket->getPriceForPayment())
        {
            $credit["isCreditLimitAcceptable"] = false;
        } else {
            $credit["isCreditLimitAcceptable"] = true;
        }


        return $credit;
    }


    public function isInABCGroup()
    {
        return $this->inGroup("oxidpricea") || $this->inGroup("oxidpriceb") || $this->inGroup("oxidpricec");
    }



}