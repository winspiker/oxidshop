<?php

namespace Exonn\Asum\Core;

use OxidEsales\Eshop\Application\Model\Article;
use OxidEsales\Eshop\Application\Model\SeoEncoderArticle;
use OxidEsales\Eshop\Core\Registry;

class ExonnAsumSeoEncoder extends ExonnAsumSeoEncoder_parent
{
    public function getStaticUrl($sStdUrl, $iLang = null, $iShopId = null)
    {
        parse_str(parse_url($sStdUrl, PHP_URL_QUERY), $aComponents);
        $sClass = $aComponents['cl'] ?? Registry::getRequest()->getRequestEscapedParameter('cl', '');
        $sArticleId = Registry::getRequest()->getRequestEscapedParameter('anid', '');
        if (in_array($sClass, ['', 'details'], true) && $sArticleId) {
            $oArticle = oxNew(Article::class);
            if ($oArticle->load($sArticleId)) {
                $oEncoder = oxNew(SeoEncoderArticle::class);
                return $this->_getFullUrl(
                    $oEncoder->getArticleUri($oArticle, $iLang),
                    $iLang
                );
            }
        }
        return parent::getStaticUrl($sStdUrl, $iLang, $iShopId);
    }
}
