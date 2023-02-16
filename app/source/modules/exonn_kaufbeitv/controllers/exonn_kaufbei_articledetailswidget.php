<?php

/**
 *
 *
 * @author EXONN
 */
class exonn_kaufbei_articledetailswidget extends exonn_kaufbei_articledetailswidget_parent
{

    /**
     * Returns bundle product
     *
     * @return \OxidEsales\Eshop\Application\Model\Article|false
     */
    public function getBundleArticle()
    {
        $article = $this->getProduct();
        if ($article && $article->oxarticles__oxbundleid->value) {
            $bundle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
            $bundle->load($article->oxarticles__oxbundleid->value);

            return $bundle;
        }

        return false;
    }


    //detail seite wird immer angezeigt unabhängig von oxstockstatus!
    protected function _additionalChecksForArticle($myUtils, $myConfig)
    {
        $config = $this->getConfig();
        $oldUseStock = $config->getConfigParam('blUseStock');
        $config->setConfigParam('blUseStock', false);

        parent::_additionalChecksForArticle($myUtils, $myConfig);


        $config->setConfigParam('blUseStock', $oldUseStock);

    }


}
