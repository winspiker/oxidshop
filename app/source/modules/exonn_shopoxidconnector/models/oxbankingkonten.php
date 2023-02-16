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
 * @package   core
 * @copyright (C) OXID eSales AG 2003-2013
 * @version OXID eShop CE
 */

/**
 * Group manager.
 * Base class for user groups. Does nothing special yet.
 *
 * @package model
 */
class oxbankingkonten extends oxI18n
{
    /**
     * Name of current class
     * @var string
     */
    protected $_sClassName = 'oxbankingkonten';
    protected $_sBuchungkonto = null;
    protected $_oMandant = null;

    public $apiError;

    public $_sFieldTabTitle = 'oxbankingkonten__komment';

    /**
     * Class constructor, initiates parent constructor (parent::oxBase()).
     */
    public function __construct()
    {
        parent::__construct();
        $this->init( 'oxbankingkonten' );
    }

    public function getMandant()
    {
        if ($this->_oMandant===null) {
            $this->_oMandant = oxNew("oxmandanten");
            $this->_oMandant->load($this->oxbankingkonten__oxmandantid->value);

        }

        return $this->_oMandant;
    }


    public function loadKontoForLastschrift()
    {
        $sOxId = oxDb::getDb()->getOne("select oxid from  oxbankingkonten where forlastschrift = 1");
        if ($sOxId)
            parent::load($sOxId);

    }

    public function getLastTransaktionRow()
    {
        $sSelect = "select oxdate + interval 1 day as oxnextdate, oxnum, saldo, UNIX_TIMESTAMP(valutadate + interval 1 day) as nextdate_valuta_timestamp from oxbankingtransaktions where oxkontoid=".oxDb::getDb()->quote($this->oxbankingkonten__oxid->value)." order by oxnum desc limit 1";

        $row = oxDb::getDb(oxDB::FETCH_MODE_ASSOC )->getRow($sSelect);

        if (!$row['oxnextdate'] || $row['oxnextdate']=='0000-00-00')
            $row['oxnextdate']='';

        return $row;
    }

    public function loadKontoWichKontonum($sKontonum, $sBLZ, $kontotype)
    {
        $sOxId = oxDb::getDb()->getOne("select oxid from  oxbankingkonten where oxkontonum = ".oxDB::getDb()->quote($sKontonum)." && blz = ".oxDB::getDb()->quote($sBLZ)." && kontotype = ".oxDB::getDb()->quote($kontotype));
        if ($sOxId)
            parent::load($sOxId);

    }


    public function import_transaktions($sPin, $aFile=null)
    {

        $aLastTransaktionData = $this->getLastTransaktionRow();


        switch ($this->oxbankingkonten__kontotype->value)
        {
            case "bank":
                $oAPI = oxNew("oxbankapi");
                if ($aFile) {
                    $res = $oAPI->import_transaktionsFromFile($this, $aLastTransaktionData, $aFile);
                } else {
                    $res = $oAPI->import_transaktions($this, $sPin, $aLastTransaktionData, $aFile);
                    $this->apiError=$oAPI->apiError;
                }
                break;

            case "paypal":
                $oAPI = oxNew("oxpaypalapi");
                $res = $oAPI->import_transaktions($this, $aLastTransaktionData);
                $this->apiError=$oAPI->apiError;
                break;

        }


        if (!$res)
            return false;
        else
            return true;

    }


    //упращенная функция которая просто проверяет работает ли еще скрипт или нет.
    // в закоментированной функции не правильно определяется $formdate (может взяться из другой конты) если предыдущая работа прошла с ошибкой
    public function startBankingProcess()
    {
        $oDb = oxDb::getDb();
        $oDb->execute( 'update oxbankingprocess set startdate=now(), oxkontoid='.$oDb->quote($this->getId()).' where (startdate="0000-00-00 00:00:00" || startdate + interval 20 minute < now())' );
        // ошибка при выполнении запроса
        if ($oDb->ErrorMsg())
            return false;

        // предыдущий запрос обработан без ошибок
        if ($oDb->affected_Rows()>0)
            return true;

        return false;

    }





    /*
        protected function startBankingProcess($formdate)
        {
            $oDb = oxDb::getDb();
            $oDb->execute( 'update oxbankingprocess set startdate=now(), oxkontoid='.$oDb->quote($this->getId()).' where startdate="0000-00-00 00:00:00"' );
            // ошибка при выполнении запроса
            if ($oDb->ErrorMsg())
                return false;

            // предыдущий запрос обработан без ошибок
            if ($oDb->affected_Rows()>0)
                return $formdate;



            // предыдущий запрос обработан с ошибкой!
            list($formdate, $sOldKontoId) = $oDb->getRow('select process_fromdate, oxkontoid from oxbankingprocess');


            // пытаемся стартовать процесс (изменять process_fromdate или oxkontoid здесь нельзя)
            $oDb->execute( 'update oxbankingprocess set startdate=now() where startdate<>"0000-00-00 00:00:00" && startdate + interval 60 minute < now()' );
            if ($oDb->affected_Rows()<=0) // возможно процесс запущен на другом компе
                return false;


            // удаляем загруженные в прошлый раз банковские транзакции, так как не изместно до конца ли они загрузились.
            // только Bank!!!
            $oTrans = oxNew("oxbankingtransaktions");
            $oldTransaktion = $oDb->getCol("select oxid from oxbankingtransaktions where  oxkontotype='bank' && oxkontoid='.$oDb->quote($sOldKontoId).' && oxdate>now() - interval 10 day && oxdate>='".$formdate."'");
            foreach($oldTransaktion as $transId)
            {
                $oTrans->delete($transId);
            }



            $oDb->execute( 'update oxbankingprocess set process_fromdate="'.$formdate.'", oxkontoid='.$oDb->quote($this->getId()));

            return $formdate;

        }
    */
    public function endBankingProcess()
    {
        oxDb::getDb()->execute( 'update oxbankingprocess set startdate="0000-00-00 00:00:00"' );

    }





}
