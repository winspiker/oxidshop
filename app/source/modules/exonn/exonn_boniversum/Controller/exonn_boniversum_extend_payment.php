<?php

class exonn_boniversum_extend_payment extends exonn_boniversum_extend_payment_parent
{


    function make_timestamp($string)
    {
        if(empty($string)) {
            // use "now":
            $time = time();

        } elseif (preg_match('/^\d{14}$/', $string)) {
            // it is mysql timestamp format of YYYYMMDDHHMMSS?
            $time = mktime(substr($string, 8, 2),substr($string, 10, 2),substr($string, 12, 2),
                substr($string, 4, 2),substr($string, 6, 2),substr($string, 0, 4));

        } elseif (is_numeric($string)) {
            // it is a numeric string, we handle it as timestamp
            $time = (int)$string;

        } else {
            // strtotime should handle it
            $time = strtotime($string);
            if ($time == -1 || $time === false) {
                // strtotime() was not able to parse $string, use "now":
                $time = time();
            }
        }
        return $time;

    }

    function modifier_date_format($string, $format = '%b %e, %Y', $default_date = '')
    {
        if ($string != '') {
            $timestamp = $this->make_timestamp($string);
        } elseif ($default_date != '') {
            $timestamp = $this->make_timestamp($default_date);
        } else {
            return;
        }
        if (DIRECTORY_SEPARATOR == '\\') {
            $_win_from = array('%D',       '%h', '%n', '%r',          '%R',    '%t', '%T');
            $_win_to   = array('%m/%d/%y', '%b', "\n", '%I:%M:%S %p', '%H:%M', "\t", '%H:%M:%S');
            if (strpos($format, '%e') !== false) {
                $_win_from[] = '%e';
                $_win_to[]   = sprintf('%\' 2d', date('j', $timestamp));
            }
            if (strpos($format, '%l') !== false) {
                $_win_from[] = '%l';
                $_win_to[]   = sprintf('%\' 2d', date('h', $timestamp));
            }
            $format = str_replace($_win_from, $_win_to, $format);
        }
        return strftime($format, $timestamp);
    }

    public function getPaymentList()
    {
        if ($this->_oPaymentList === null) {

            parent::getPaymentList();



            if ($this->_oPaymentList) {

                $oLang = oxRegistry::getLang();

                $oSession = $this->getSession();
                $oBasket = $oSession->getBasket();
                $oUser = $oBasket->getUser();

                $payerror = $oSession->getVariable('payerror');


                if (substr($oUser->oxuser__oxbirthdate->value,0,2)<>'00' && $oUser->oxuser__oxbirthdate->value != "" && $oUser->oxuser__oxbirthdate->value) {

                    $sBData = $this->modifier_date_format($oUser->oxuser__oxbirthdate->value, '%d.%m.%Y') ;
                } else {
                    $sBData = "";

                }



                foreach($this->_oPaymentList as $oPayment ) {
                    if (!$oPayment->oxpayments__boniversumsecuritypayment->value) {
                        $oPayment->oxpayments__oxdesc->value .= ' <span style="font-weight: normal">'.$oLang->translateString('EXONN_BONIVERSUM_BONITAET_VOR')."</span>";
                        $oPayment->oxpayments__oxlongdesc->value.='
                        
                        <div class="panel panel-default"  id="boniversum_confirm_block" style="margin-top: 10px">
    <div class="panel-body">
                        <div  class="'.(($payerror == 152142) ? 'text-danger' : '').'">
            <label >'.$oLang->translateString("EXONN_BONIVERSUM_BIRTHDATE").'</label>
            <div>
            <div class="col-xs-3 col-lg-3 ">
                <input id="oxDay" class="oxDay form-control" name="invadr_'.$oPayment->getId().'[oxuser__oxbirthdate]" type="text"  value="'.$sBData.'" placeholder="dd.mm.YYYY">
            </div>
            </div>
        </div>

        <div style="clear: both;"></div>
        <div class="'.(($payerror == 152141) ? 'text-danger' : '').'" style=" margin-top: 15px">
            <input type="checkbox" name="boniversum_confirm_'.$oPayment->getId().'" >
            '.$oLang->translateString("EXONN_BONIVERSUM_CONFIRM").'
        </div>
            </div>
            </div>
                        ';
                    }
                }
            }

        }

        return $this->_oPaymentList;
    }


    public function validatePayment()
    {
        $res = parent::validatePayment();

        $oBasket = $this->getSession()->getBasket();
        if (!$oBasket) {
            return;
        }

        $oBasket->sPaymentTypeCheckBoniversum = '';

        if ($res == 'order') {

            $myConfig = $this->getConfig();
            $oSession = $this->getSession();
            $sPaymentId = $oSession->getVariable('paymentid');
            $oPayment = oxNew("oxpayment");
            $oPayment->load($sPaymentId);

            if (!$oPayment->oxpayments__boniversumsecuritypayment->value) {

                //wenn Lieferadresse eingegeben, dürfen nur Sichere Zahlungsarten benutzt werden
                if ($myConfig->getRequestParameter('deladrid') || $oSession->getVariable('deladrid')) {
                    $oSession->setVariable('payerror', 152147);
                    $this->setAllowPayment();
                    return;
                }

                $aInvadr = $myConfig->getRequestParameter('invadr_'.$oPayment->getId());
                //print_r($aInvadr);
                if (!$aInvadr["oxuser__oxbirthdate"]) {
                    $oSession->setVariable('payerror', 152142);
                    return;

                } else {

                    $aDateBirth = explode(".", $aInvadr["oxuser__oxbirthdate"]);

                    $oUser = $this->getUser();
                    $oUser->assign(array('oxuser__oxbirthdate' => $aDateBirth[2]."-".$aDateBirth[1]."-".$aDateBirth[0]));
                    $oUser->save();

                }

                $boniversum_confirm = $myConfig->getRequestParameter('boniversum_confirm_'.$oPayment->getId());
                if (!$boniversum_confirm) {
                    $oSession->setVariable('payerror', 152141);
                    return;
                }


                $oBoniversum = oxNew("exonn_boniversum");

                $oBoniversum->loadBoniversumData($oBasket);

                if ($oBoniversum->exonn_boniversum__errorcode->value==1008) {
                    $oSession->setVariable('payerror', "152158");
                    return "user";
                }


                if ($oBoniversum->hasError()) {
                    //Boniversum schnittstelle funktioniert nicht

                    $oSession->setVariable('payerror', 152145);
                    $oBasket->blOnlySecurePayment = true;
                    return;
                }

                $oCur = $this->getConfig()->getActShopCurrencyObject();
                $dBasketPrice = $oBasket->getPriceForPayment() / $oCur->rate;
                if ($aAllowPaymentIds = $oBoniversum->getAllowPayment($dBasketPrice)) {

                    if (!in_array($oPayment->getId(),$aAllowPaymentIds)) {
                        $oSession->setVariable('payerror', 152147);
                        $this->setAllowPayment($aAllowPaymentIds);
                        return;
                    }

                    if ($oBoniversum->exonn_boniversum__adressvalidierung->value=='Die angegebene Adresse wurde postalisch korrigiert und validiert.') {

                        $oUser = $this->getUser();
                        $oUser->assign(array(
                            'oxuser__oxstreet' => $oBoniversum->exonn_boniversum__strasse_valide->value,
                            'oxuser__oxstreetnr' => $oBoniversum->exonn_boniversum__hausnr_valide->value,
                            'oxuser__oxzip' => $oBoniversum->exonn_boniversum__plz_valide->value,
                            'oxuser__oxcity' => $oBoniversum->exonn_boniversum__ort_valide->value,
                        ));
                        $oUser->save();


                        $oSession->setVariable('payerror', "152159");
                        return "user";

                    }


                } else {
                    //setzen nur sichere Zahlungsarten
                    $oSession->setVariable('payerror', 152147);
                    $this->setAllowPayment($aAllowPaymentIds);
                    return;
                }

                $oBasket->sPaymentTypeCheckBoniversum = $oPayment->getId();

            }

        }

        return $res;
    }


    protected function setAllowPayment($aAllowPaymentIds=array())
    {
        if (!$aAllowPaymentIds)
            $aAllowPaymentIds = array();

        $oPaymentList = $this->getPaymentList();

        foreach($oPaymentList as $key => $oPayment) {
            if (!in_array($oPayment->getId(), $aAllowPaymentIds) && !$oPayment->oxpayments__boniversumsecuritypayment->value) {
                unset($oPaymentList[$key]);
            }
        }

        $this->_oPaymentList = $oPaymentList;

    }
    



}
