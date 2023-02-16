<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_oxuser extends exonn_order_oxuser_parent
{


    public function createUser()
    {

        $res = parent::createUser();

        if (!$this->oxuser__oxcustnr->value)
            $this->_setNumber();

        return $res;
    }


    public function save()
    {
        $res = parent::save();

        if (!$this->oxuser__oxcustnr->value)
            $this->_setNumber();


        return $res;
    }


    protected function _setRandNum( $sField, $aWhere = null, $firstNum=0)
    {
        // в вави не работает
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
            $sCheck = "select $sField from ".$this->getViewName()." where $sField=$iNum && $sWhere 1 ";
            $iChkCnt = oxDb::getDb(true)->GetOne( $sCheck );
            if ( $iChkCnt > 1 )
                continue;
            else
            {
                $sUpdate = "update {$this->getViewName()} as t1 set t1.$sField=$iNum where t1.oxid = '".$this->getId()."'";
                if ( oxDb::getDb(true)->Execute( $sUpdate ) === false ) {
                    return false;
                }

                $sFieldName = $this->getViewName().'__'.$sField;
                $this->$sFieldName = new oxField($iNum, oxField::T_RAW);//int value

                return true;
            }
        }while(true);

    }




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

        return $this->_setRandNum( 'oxcustnr', $aWhere, 1 );

    }



}