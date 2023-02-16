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
namespace Ecs\AdminRights\Model;

use OxidEsales\Eshop\Core\Registry;

class User extends User_parent
{

    public function delete($sOXID = null)
    {
        $oConfig = Registry::getConfig();
        if (!$oConfig->getConfigParam('bAdminRightsDelete') or !$this->isAdmin()) {
            return parent::delete($sOXID);
        }

        $oUser     = $this->getUser();
        $sUserID   = $oUser->getID();
        $sUserArID = 'ar_' . $sUserID;
        $aParamsAr = $oConfig->getConfigParam($sUserArID);
        $sParamsAr = $aParamsAr['ecs_adminrights_menu'];
        if ($sParamsAr) {
            return;
        }

        return parent::delete($sOXID);
    }

    public function isLimited()
    {
        $oConfig = Registry::getConfig();
        if (!$oConfig->getConfigParam('bAdminRightsOrderOverview') or !$this->isAdmin()) {
            return false;
        }

        $oUser     = $this->getUser();
        $sUserID   = $oUser->getID();
        $sUserArID = 'ar_' . $sUserID;
        $aParamsAr = $oConfig->getConfigParam($sUserArID);
        $sParamsAr = $aParamsAr['ecs_adminrights_menu'];
        if ($sParamsAr) {
            return true;
        }
        return false;
    }
}
