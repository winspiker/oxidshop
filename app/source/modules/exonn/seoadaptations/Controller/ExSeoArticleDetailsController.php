<?php

namespace exonn\seoAdaptations\Controller;


class ExSeoArticleDetailsController extends ExSeoArticleDetailsController_parent
{
	//	protected $_sThisTemplate = 'page/details/details.tpl';

//	public function render()
//	{
//		$articleSeoTitle = $this->getSeoTitle();
//
//		$this->_aViewData['seoTitle'] = $articleSeoTitle;
//
//		return parent::render();;
//	}
//
//	private function getSeoTitle()
//	{
//		$article = $this->getProduct();
//
////		$article = oxNew('oxarticle');
////		$article->load($articleId);
//
////		$langId = \OxidEsales\Eshop\Core\Registry::getLang()->getTplLanguage();
//
//		$articleTitle = $article->oxarticles__oxtitle->value;
//
//		return $articleTitle;
//	}


    /**
     * Returns view canonical url
     *
     * @return string
     */
 /*   public function getCanonicalUrl()
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
    }*/



    public function noIndex()
    {

        //wir wollen bei manufacture und vendor auch kein 'noindex' schreiben.
        //noindex soll bei manufactur und vendor nicht stehen, weil gleichen link auch für normale artikel benutzt sind

        return \OxidEsales\Eshop\Application\Controller\FrontendController::noIndex();
    }


}