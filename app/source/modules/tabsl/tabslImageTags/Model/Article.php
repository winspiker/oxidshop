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
 * Class Article
 * @package Tabsl\ImageTags\Model
 */
class Article extends Article_parent
{
    /**
     * Prepares article image tag
     *
     * @param string $sTabslTag
     * @param int $sIndex
     * @return string
     */
    public function getTabslImageTag($sTabslTag = '', $sIndex = 1)
    {
        $sImageTag = '';
        $myConfig = \OxidEsales\Eshop\Core\Registry::getConfig();


        // module active?
        if (!$myConfig->getConfigParam('tabsl_imagetags_art_status')) {
            return $this->oxarticles__oxtitle->value;
        }

        // module article shortdesc?
        if ($myConfig->getConfigParam('tabsl_imagetags_art_shortdesc')) {
            $sImageTag .= $this->oxarticles__oxshortdesc->value . ' ';
        }

        // module article icon/thumb filename?
        if ($myConfig->getConfigParam('tabsl_imagetags_art_imagename')) {
            $sImage = 'oxarticles__oxpic' . $sIndex;
            $sImageTag .= $this->_clearTabslFileName($this->$sImage->value) . ' ';
        }

        // module article brand?
        if ($myConfig->getConfigParam('tabsl_imagetags_art_brand')) {
            $sBrandId = $this->oxarticles__oxmanufacturerid->value;
            $oManufacturer = oxNew('oxmanufacturer');
            if ($oManufacturer->load($sBrandId)) {
                $sImageTag .= $oManufacturer->oxmanufacturers__oxtitle->value . ' ';
            }
        }



        // module article category?
        if ($myConfig->getConfigParam('tabsl_imagetags_art_cat')) {
            $sActCatId = \OxidEsales\Eshop\Core\Registry::getConfig()->getRequestParameter('cnid');
            $oCategory = oxNew('oxcategory');



            if ($oCategory->load($sActCatId)) {



                $sImageTag .= $oCategory->oxcategories__oxtitle->value . ' ';
            }
        }

        // module article title?
        if ($myConfig->getConfigParam('tabsl_imagetags_art_title')) {
            $sImageTag .= $this->oxarticles__oxtitle->value . ($this->oxarticles__oxvarselect->value ? ' ' . $this->oxarticles__oxvarselect->value : '');
        }

        // use tabsl_imagetag?
        if (!empty($sTabslTag) && $sTabslTag != NULL) {
            $sImageTag .= $sTabslTag;
        }

        // fallback
        if ($sImageTag == '') {
            $sImageTag = $this->oxarticles__oxtitle->value . ($this->oxarticles__oxvarselect->value ? ' ' . $this->oxarticles__oxvarselect->value : '');
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

}
