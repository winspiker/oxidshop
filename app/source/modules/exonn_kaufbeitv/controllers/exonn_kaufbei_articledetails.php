<?php

/**
 *
 *
 * @author EXONN
 */
class exonn_kaufbei_articledetails extends exonn_kaufbei_articledetails_parent
{

    //detail seite wird immer angezeigt unabhängig von oxstockstatus!
    protected function _additionalChecksForArticle()
    {
        $config = $this->getConfig();
        $oldUseStock = $config->getConfigParam('blUseStock');
        $config->setConfigParam('blUseStock', false);

        parent::_additionalChecksForArticle();

        $config->setConfigParam('blUseStock', $oldUseStock);

    }


	  /**
     * Returns view canonical url
     *
     * @return string
     */
    public function getCanonicalUrl()
    {
        if (($article = $this->getProduct()))
		{


			if($url = $article->getBaseSeoLink($article->getLanguage(), false))
			{
				return $url;
			}

            $utilsUrl = \OxidEsales\Eshop\Core\Registry::getUtilsUrl();
            if (\OxidEsales\Eshop\Core\Registry::getUtils()->seoIsActive()) {
                $url = $utilsUrl->prepareCanonicalUrl($article->getBaseSeoLink($article->getLanguage(), true));
            } else {
                $url = $utilsUrl->prepareCanonicalUrl($article->getBaseStdLink($article->getLanguage()));
            }

            return $url;
        }
    }


}
