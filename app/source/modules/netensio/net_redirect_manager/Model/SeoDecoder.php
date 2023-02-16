<?php

namespace Netensio\RedirectManager\Model;

use \OxidEsales\Eshop\Core\DatabaseProvider;
use \OxidEsales\Eshop\Core\Registry;

class SeoDecoder extends SeoDecoder_parent
{


    public function decodeUrl($sSeoUrl)
    {
        $ret = parent::decodeUrl($sSeoUrl);
        $sSeoUrl = $this->_addQueryString($sSeoUrl);

        $oDb = DatabaseProvider::getDb();
        $sShopId = Registry::getConfig()->getShopId();
        if ($ret["lang"] != 0) {
            $sSql = "SELECT oxid from netredirectmanager where oxshopid=" . $oDb->quote($sShopId) . " and oxsource_" . $ret["lang"] . "=" . $oDb->quote($sSeoUrl) . " and oxactive='1'";
        }
        else {
            $sSql = "SELECT oxid from netredirectmanager where oxshopid=" . $oDb->quote($sShopId) . " and oxsource=" . $oDb->quote($sSeoUrl) . " and oxactive='1'";
        }

        $sRedirectTarget = DatabaseProvider::getDb()->getOne($sSql);

        $oRedirectManager = oxNew(\Netensio\RedirectManager\Model\RedirectManager::class);
        if ($oRedirectManager->loadInLang( $ret["lang"], $sRedirectTarget )) {

            switch ($oRedirectManager->netredirectmanager__oxhttpcode->value) {
                case 301:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 301 Moved Permanently";
                    break;
                case 302:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 302 Found";
                    break;
                case 307:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 307 Temporary Redirect";
                    break;
                case 404:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 404 Not found";
                    break;
                case 410:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 410 Gone";
                    break;
                default:
                    $sHeaderCode = $_SERVER["SERVER_PROTOCOL"]." 302 Found";
            }


            if ($oRedirectManager->netredirectmanager__oxhttpcode->value != "404" && $oRedirectManager->netredirectmanager__oxhttpcode->value != "410") {
                $sLocation = "Location: ".$this->getConfig()->getShopURL() . $oRedirectManager->netredirectmanager__oxtarget->value;
                $oHeader = oxNew("oxHeader");
                $oHeader->setHeader($sHeaderCode);
                $oHeader->setHeader($sLocation);
                $oHeader->setHeader("Connection: close");
                $oHeader->sendHeader();
                exit;
            }
            elseif($oRedirectManager->netredirectmanager__oxhttpcode->value == "404")  {

                Registry::getUtils()->handlePageNotFoundError($oRedirectManager->netredirectmanager__oxsource->value);
                exit;
            }
            elseif($oRedirectManager->netredirectmanager__oxhttpcode->value == "410") {
                Registry::getUtils()->netHandlePageNotFoundError410($oRedirectManager->netredirectmanager__oxsource->value);
                exit;
            }

        }
        else return $ret;

    }

}