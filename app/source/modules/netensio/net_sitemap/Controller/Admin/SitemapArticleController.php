<?php

namespace Netensio\Sitemap\Controller\Admin;

use \OxidEsales\Eshop\Core\Registry;

class SitemapArticleController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{

    public function render()
    {
        parent::render();

        $this->_aViewData['edit'] = $oArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);

        $soxId = $this->getEditObjectId();
        if ($soxId != "-1" && isset($soxId)) {
            $oArticle->load($soxId);

            if ($oArticle->isDerived()) {
                $this->_aViewData["readonly"] = true;
            }
        }

        return "net_sitemap_article.tpl";
    }

    public function save() {
        parent::save();

        $aParams = Registry::getConfig()->getRequestParameter("editval");

        $soxId = $this->getEditObjectId();

        $oArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
        $oArticle->load($soxId);
        $oArticle->assign($aParams);
        $oArticle->save();
    }
}