<?php

namespace Netensio\Sitemap\Controller\Admin;

use \OxidEsales\Eshop\Core\Registry;

class SitemapCategoryController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    public function render()
    {
        parent::render();

        $this->_aViewData['edit'] = $oCategory = oxNew(\OxidEsales\Eshop\Application\Model\Category::class);

        $soxId = $this->getEditObjectId();
        if ($soxId != '-1' && isset($soxId)) {
            $oCategory->load($soxId);
        }

        return "net_sitemap_category.tpl";
    }

    public function save() {
        parent::save();

        $aParams = Registry::getConfig()->getRequestParameter("editval");

        $soxId = $this->getEditObjectId();

        $oCategory = oxNew(\OxidEsales\Eshop\Application\Model\Category::class);
        $oCategory->load($soxId);
        $oCategory->assign($aParams);
        $oCategory->save();
    }
}