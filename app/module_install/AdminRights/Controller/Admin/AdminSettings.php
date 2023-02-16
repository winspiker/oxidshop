<?php

/*
 *   *********************************************************************************************
 *      Please retain this copyright header in all versions of the software.
 *      Bitte belassen Sie diesen Copyright-Header in allen Versionen der Software.
 *
 *      Copyright (C) Josef A. Puckl | eComStyle.de
 *      All rights reserved - Alle Rechte vorbehalten
 *
 *      This commercial product must be properly licensed before being used!
 *      Please contact info@ecomstyle.de for more information.
 *
 *      Dieses kommerzielle Produkt muss vor der Verwendung ordnungsgemäß lizenziert werden!
 *      Bitte kontaktieren Sie info@ecomstyle.de für weitere Informationen.
 *   *********************************************************************************************
 */
namespace Ecs\AdminRights\Controller\Admin;

use OxidEsales\Eshop\Application\Controller\Admin\AdminController;
use OxidEsales\Eshop\Application\Model\User;
use OxidEsales\Eshop\Core\Registry;

class AdminSettings extends AdminController
{

    public function render()
    {
        parent::render();
        $soxId = $this->getEditObjectId();
        if ($soxId != "-1" && isset($soxId)) {
            $oUser = oxNew(User::class);
            $oUser->load($soxId);
            $this->_aViewData["edit"] = $oUser;
        }
        if (!$this->_allowAdminEdit($soxId)) {
            $this->_aViewData['readonly'] = true;
        }
        $oNavTree                          = $this->getNavigation();
        $this->_aViewData["activeuserid"]  = $this->getUser()->getID();
        $this->_aViewData["menustructure"] = $oNavTree->getDomXml()->documentElement->childNodes;
        $this->findadmins();
        return "ar_settings.tpl";
    }

    public function findadmins()
    {
        $sql   = "SELECT OXID, OXCUSTNR, OXUSERNAME, OXFNAME, OXLNAME, OXUSERNAME FROM oxuser WHERE oxrights = 'malladmin';";
        $array = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->getAll($sql);
        foreach ($array as $val) {
            $link = "<a href=\"?cl=admin_user&oxid=" . $val[0] . '&am=1&stoken=' . $this->getSession()->getSessionChallengeToken() . "\" target=\"basefrm\" onclick=\"_homeExpActByName('admin_user');\">
                        <img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAANCAYAAACZ3F9/AAAABGdBTUEAALGPC/xhBQAAAAlwSFlzAAAOwwAADsMBx2+oZAAAABl0RVh0U29mdHdhcmUAcGFpbnQubmV0IDQuMC4yMfEgaZUAAAGwSURBVChTYwCBW9sm8oW4WiQrKSklgLCCgkI8jJaXl4fx4+2D83y23XomCtb0+sgcXg8DzWNAif+Escp/I5+SfVeuXGFjONJj4oehQM3wf0lL9/+JEyeC8YQJE/73tFf/t9BR+q+sYviz7/BzbYYjbQpu2DS2Lt75/8mzZ/+fP38Oxo/vXPkf7gTSqPKz9dBjPewagVjF0OH/vst3/z+Dan5y9xJcY9OxF7oMJ7BoVNYx+z9t2/n/r14+B2sEYWSNYBuPtyoFoWjStfg/d89loKYX/58/ufd/dmPu/4r+Ff/v3b4I11h/6K4eio3Ketb/Fx+8/v/VC6BNj+/8n1IW+19dGSiupvHfxd3lv5YKkK2q+rv5+EsbhEYdm//Ljt78//I50E+Pb//vK4j4rwbUBDMUbjjMj/DA0bH+P3fnmf9PH97835EZ9F8VTQMMw/14brZPBVxQ1/R/eIDLfxUkhegYHI8nH2ozfH20WTrB2fAzNkWYWOW/W9rEF08+PhEGJ7u3N7ZaN+bGLwsLC1sWGhq6HIbj4uI2xMTErAWJh4WFLyvqnLfw6qsvhgwMDAwAAnJUMeCBFp4AAAAASUVORK5CYII=\" title=\"Try it!\" alt=\"Link\">
                    </a>";
            $admins[] = '#' . $val[1] . ' | ' . $val[2] . ' | ' . $val[3] . ' ' . $val[4] . $link;
        }
        return $admins;
    }

    public function save()
    {
        parent::save();
        $soxId = $this->getEditObjectId();
        if (!$this->_allowAdminEdit($soxId)) {
            return false;
        }
        $aParams = Registry::getConfig()->getRequestParameter("editval");
        $oUser   = oxNew(User::class);

        if ($soxId != "-1") {
            $oUser->load($soxId);
        } else {
            $aParams['oxuser__oxid'] = null;
        }
        $sUserID = $aParams['oxuser__oxid'];
        $this->saveInConfig($aParams, $sUserID);
        $this->setEditObjectId($oUser->getId());
    }

    public function saveInConfig($aParams, $sUserID)
    {
        $oConfig     = Registry::getConfig();
        $sShopId     = $oConfig->getShopId();
        $sModulename = 'module:ecs_adminrights_save';
        $oConfig->saveShopConfVar('arr', 'ar_' . $sUserID, $aParams, $sShopId, $sModulename);
    }

    public function hasherights($armenu)
    {
        $oConfig             = Registry::getConfig();
        $soxId               = $this->getEditObjectId();
        $aWichMenuehasRights = $oConfig->getConfigParam('ar_' . $soxId);
        if (!$aWichMenuehasRights) {
            return false;
        }

        if (in_array($armenu, $aWichMenuehasRights)) {
            return true;
        }

        return false;
    }
}
