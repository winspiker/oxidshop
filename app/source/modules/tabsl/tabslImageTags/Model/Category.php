<?php

/**
 *
 * @package   tabslImageTags
 * @version   3.0.1
 * @license   kaufbei.tv
 * @link      https://oxid-module.eu
 * @author    Tobias Merkl <support@oxid-module.eu>
 * @copyright Tobias Merkl | 2021-09-23
 *
 * This Software is the property of Tobias Merkl
 * and is protected by copyright law, it is not freeware.
 *
 * Any unauthorized use of this software without a valid license
 * is a violation of the license agreement and will be
 * prosecuted by civil and criminal law.
 *
 * 58fdc7af16ec0fe83c4774f81b336f31
 *
 **/

namespace Tabsl\ImageTags\Model;

/**
 * Class Category
 * @package Tabsl\ImageTags\Model
 */
class Category extends Category_parent
{
    /**
     * Prepares category image tag
     *
     * @param string $sType
     * @param string $sTabslTag
     * @return string
     */
    public function getTabslImageTag($sType = 'icon', $sTabslTag = '')
    {
        $sImageTag = '';
        $myConfig = \OxidEsales\Eshop\Core\Registry::getConfig();

        // module active?
        if (!$myConfig->getConfigParam('tabsl_imagetags_cat_status')) {
            return $this->oxcategories__oxtitle->value;
        }

        // module category shortdesc?
        if ($myConfig->getConfigParam('tabsl_imagetags_cat_shortdesc')) {
            $sImageTag .= $this->oxcategories__oxdesc->value . ' ';
        }

        // module category title?
        if ($myConfig->getConfigParam('tabsl_imagetags_cat_title')) {
            $sImageTag .= $this->oxcategories__oxtitle->value . ' ';
        }

        // module category icon/thumb filename?
        if ($myConfig->getConfigParam('tabsl_imagetags_cat_imagename')) {
            $sImage = 'oxcategories__ox' . $sType;
            $sImageTag .= $this->_clearTabslFileName($this->$sImage->value) . ' ';
        }

        // use tabsl_imagetag?
        if (!empty($sTabslTag) && $sTabslTag != NULL) {
            $sImageTag .= $sTabslTag . ' ';
        } else {
            // fallback
            $sTabslTag = $this->_checkTabslImageTag();
            if (!empty($sTabslTag) && $sTabslTag != NULL) {
                $sImageTag .= $sTabslTag . ' ';
            } else {
                $sImageTag .= $this->oxcategories__oxtitle->value;
            }
        }

        return trim(strip_tags($sImageTag));
    }

    /**
     * Cleans image file name
     *
     * @param $sName
     * @return string
     */
    protected function _clearTabslFileName($sName)
    {
        $sName = str_replace('.jpg', '', $sName);
        $sName = str_replace('.gif', '', $sName);
        $sName = str_replace('.png', '', $sName);
        $sName = str_replace('_', ' ', $sName);
        $sName = str_replace('-', ' ', $sName);
        return trim(ucwords($sName));
    }

    /**
     * Get tabsl image tag from database
     *
     * @param string $sType
     * @return false|string
     * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
     */
    protected function _checkTabslImageTag($sType = 'icon')
    {
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
        $sTable = getViewName('oxcategories');
        $sSql = 'SELECT tabsl_imagetag_' . $sType . ' FROM ' . $sTable . ' WHERE oxid = ' . $oDb->quote($this->oxcategories__oxid->value);
        return $oDb->getOne($sSql);
    }
}
