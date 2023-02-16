<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_oxorder extends exonn_order_oxorder_parent
{

    protected $_auftragstype = null;


    protected function _setRandNum( $sField, $aWhere = null, $firstNum=0)
    {
        // не работает в вави!

        // filtering
        $sWhere = "";
        if ( is_array( $aWhere ) && count( $aWhere ) > 0) {
            $sWhere = implode(" and ", $aWhere).' and ';
        }

        do {
            if ($firstNum)
            {
                $iNum=rand(10000,99999);
                $iNum=$firstNum*100000 + $iNum;
            }
            else
                $iNum=rand(100000,999999);
            $sCheck = "select $sField from ".$this->getViewName()." where $sField='$iNum' && $sWhere 1 ";
            $iChkCnt = oxDb::getDb(true)->GetOne( $sCheck );
            if ( $iChkCnt > 1 )
                continue;

            if ($sField=='oxordernr') {
                $sCheck = "select $sField from oxdocumentsrechnungen where $sField='$iNum' ";
                $iChkCnt = oxDb::getDb(true)->GetOne( $sCheck );
                if ( $iChkCnt > 1 )
                    continue;
            }

            $sUpdate = "update {$this->getViewName()} as t1 set t1.$sField=$iNum where t1.oxid = '".$this->getId()."'";
            if ( oxDb::getDb(true)->Execute( $sUpdate ) === false ) {
                return false;
            }

            $sFieldName = $this->getViewName().'__'.$sField;
            $this->$sFieldName = new oxField($iNum, oxField::T_RAW);//int value

            return $iNum;

        }while(true);

    }


/*
    public function getHerkunftName()
    {
        $name = "Sonstiges";
        if ($this->oxorder__callcenter_recipient->value=='tvrus_shop_gazety' || $this->oxorder__callcenter_recipient->value=='057312451511')
            $name="Bem-Zeitungen";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_ZG-Krugozor' || $this->oxorder__callcenter_recipient->value=='057312451558')
            $name="ZG-Krugozor";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_zg_karjera' || $this->oxorder__callcenter_recipient->value=='057312451554')
            $name="ZG-Karjera";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_7_7' || $this->oxorder__callcenter_recipient->value=='057312451553')
            $name="ZG 7+7";
        elseif ($this->oxorder__callcenter_recipient->value=='maksimus_best' || $this->oxorder__callcenter_recipient->value=='057312451570')
            $name="Maksimus";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_ort' || $this->oxorder__callcenter_recipient->value=='057312451551')
            $name="ORT-Tvrusshop";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_ORT_KnigiDR' || $this->oxorder__callcenter_recipient->value=='057312451556')
            $name="ORT-KinigiDR";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_ORT_Dom-Rest' || $this->oxorder__callcenter_recipient->value=='057312451557')
            $name="ORT-Dom-Rest";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_rez_zdorow' || $this->oxorder__callcenter_recipient->value=='057312451552')
            $name="ZG-Zdorowje";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_twoy' || $this->oxorder__callcenter_recipient->value=='057312451545')
            $name="TWOJ-shop";
        elseif ($this->oxorder__callcenter_recipient->value=='tvrus_shop_1' || $this->oxorder__callcenter_recipient->value=='057312451510')
            $name="TVRUS-shop";
        elseif ($this->oxorder__callcenter_recipient->value<>'')
            $name=$this->oxorder__callcenter_recipient->value;

        return $name;
    }
*/
    protected function _setNumber()
    {
        if ($this->isWawi)
            return parent::_setNumber( );

        $myConfig = $this->getConfig();

        $aWhere = '';
        // separate order numbers for shops ...
        if ( $this->_blSeparateNumbering ) {
            $aWhere = array( 'oxshopid = "'.$myConfig->getShopId().'"' );
        }

        return $this->_setRandNum( 'oxordernr', $aWhere, 8 );

    }

    public function getNextBillNum()
    {
        if ($this->isWawi)
            return parent::getNextBillNum( );


        $myConfig = $this->getConfig();

        $aWhere = '';
        // separate order numbers for shops ...
        if ( $this->_blSeparateNumbering ) {
            $aWhere = array( 'oxshopid = "'.$myConfig->getShopId().'"' );
        }

        return $this->_setRandNum( 'oxbillnr', $aWhere, 9 );


    }


}
