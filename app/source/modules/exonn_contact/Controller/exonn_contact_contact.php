<?php
/**
 * Created by PhpStorm.
 * User: koray
 * Date: 26.06.2019
 * Time: 15:10
 */

class exonn_contact_contact extends exonn_contact_contact_parent
{
//    protected $_sThisTemplate = 'exonn_contact.tpl';

    public function send()
    {
        $aParams = oxRegistry::getConfig()->getRequestParameter('editval');

        // checking email address
        if (!oxRegistry::getUtils()->isValidEmail($aParams['oxuser__oxusername'])) {
            oxRegistry::get("oxUtilsView")->addErrorToDisplay('ERROR_MESSAGE_INPUT_NOVALIDEMAIL');

            return false;
        }

        // spam spider prevension
        $sMac = oxRegistry::getConfig()->getRequestParameter('c_mac');
        $sMacHash = oxRegistry::getConfig()->getRequestParameter('c_mach');
        $oCaptcha = $this->getCaptcha();

        if (!$oCaptcha->pass($sMac, $sMacHash)) {
            // even if there is no exception, use this as a default display method
            oxRegistry::get("oxUtilsView")->addErrorToDisplay('MESSAGE_WRONG_VERIFICATION_CODE');

            return false;
        }

        $sSubject = oxRegistry::getConfig()->getRequestParameter('c_subject');
        if (!$aParams['oxuser__oxfname'] || !$aParams['oxuser__oxlname'] || !$aParams['oxuser__oxusername'] || !$sSubject) {
            // even if there is no exception, use this as a default display method
            oxRegistry::get("oxUtilsView")->addErrorToDisplay('ERROR_MESSAGE_INPUT_NOTALLFIELDS');

            return false;
        }

        $oLang = oxRegistry::getLang();
        $sMessage = $oLang->translateString('MESSAGE_FROM') . " " .
            $aParams['oxuser__oxcompany'] . " " .
            $oLang->translateString($aParams['oxuser__oxsal']) . " " .
            $aParams['oxuser__oxfname'] . " " .
            $aParams['oxuser__oxlname'] . "(" . $aParams['oxuser__oxusername'] . ")<br /><br />" .
            nl2br(oxRegistry::getConfig()->getRequestParameter('c_message'));

        $oEmail = oxNew('oxemail');
        if ($oEmail->sendContactMail($aParams['oxuser__oxusername'], $sSubject, $sMessage)) {
            $this->_blContactSendStatus = 1;
        } else {
            oxRegistry::get("oxUtilsView")->addErrorToDisplay('ERROR_MESSAGE_CHECK_EMAIL');
        }
    }
}