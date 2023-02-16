<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_order_oxdocumentsrechnungen extends exonn_order_oxdocumentsrechnungen_parent
{


    protected function _setRandNum( $firstNum=0)
    {

        $myConfig=$this->getConfig();
        if ($this->isWawi && !$myConfig->getConfigParam('sRandNummerCreate'))
            return parent::_setRandNum( $firstNum);


        do {
            if ($firstNum)
            {
                $iNum=rand(10000,99999);
                $iNum=$firstNum*100000 + $iNum;
            }
            else
                $iNum=rand(100000,999999);

            $oDB = oxDb::getDb(true);
            $sSelect = "select oxid from oxdocumentsrechnungen where oxdocumenttype=".$oDB->quote($this->oxdocumentsrechnungen__oxdocumenttype->value)." && oxdocumentnummer=".$iNum ;

            if ($this->isWawi && getWawiId()=="ec964d706c29b7e4615495e34d30b143") {
                $sSelect.=" && oxmandantid = ".$oDB->quote($this->oxdocumentsrechnungen__oxmandantid->value);
            }

            if ( !oxDb::getDb()->getOne( $sSelect )  ) {
                return $iNum;
            }
        }while(true);

    }

}
