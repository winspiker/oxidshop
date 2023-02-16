<?php

class exonn_boniversum_extend_user extends exonn_boniversum_extend_user_parent
{


    public function render()
    {
        $res = parent::render();

        $payerror = $this->getSession()->getVariable('payerror');

        switch ($payerror) {
            case "152158":
                $oEx = oxNew("oxinputexception");
                $oEx->setMessage(oxRegistry::getLang()->translateString('ERROR_MESSAGE_BONIVERSUM_PLZ'));

                $oInputValidator = oxRegistry::getInputValidator();
                $oInputValidator-> addValidationError('oxuser__oxzip', $oEx);

                $oEx2 = oxNew("oxexceptiontodisplay");
                $oEx2->setMessage(oxRegistry::getLang()->translateString('ERROR_MESSAGE_BONIVERSUM_PLZ'));

                $this->_aViewData["Errors"]['default'][]=$oEx2;
                break;
            case "152159":
                $oEx2 = oxNew("oxexceptiontodisplay");
                $oEx2->setMessage(oxRegistry::getLang()->translateString('ERROR_MESSAGE_BONIVERSUM_ADDRESSKORRIGIERT'));

                $this->_aViewData["Errors"]['default'][]=$oEx2;
                break;

        }


        return $res;
    }
}
