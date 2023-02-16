<?php

class exonn_connector_extend_payment extends exonn_connector_extend_payment_parent
{

    public function getPaymentList()
    {

        /*
         * FUNKTION:
         * Kunden von bestimmten Kundengruppen sehen bei zahlungsart extra Beschreibung.
         *
         */

        if ($this->_oPaymentList === null) {

            parent::getPaymentList();


            if ($oUser = $this->getUser()) {

                $sGroupIds  = '';
                if ( $oUser ) {
                    foreach ( $oUser->getUserGroups() as $oGroup ) {
                        if ( $sGroupIds ) {
                            $sGroupIds .= ', ';
                        }
                        $sGroupIds .= "'".$oGroup->getId()."'";
                    }
                }


                foreach ($this->_oPaymentList as $oPayment) {
                    if (oxDb::getDb()->getOne(" select 1 from oxpaymentamount2group where oxtype='description' and OXOBJECTID=".oxDb::getDb()->quote($oPayment->getId())." and OXGROUPSID in ( {$sGroupIds} ) limit 1")) {
                        $oPayment->oxpayments__oxlongdesc->setValue($oPayment->oxpayments__oxlongdescusergroup->value);
                    }

                }
            }


        }

        return $this->_oPaymentList;
    }


}
