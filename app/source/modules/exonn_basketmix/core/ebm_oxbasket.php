<?php
class ebm_oxbasket extends ebm_oxbasket_parent {

    public function addToBasket( $sProductID, $dAmount, $aSel = null, $aPersParam = null, $blOverride = false, $blBundle = false, $sOldBasketItemId = null )
    {

        $oDb = oxDb::getDb();
        $groupsExlude = $oDb->getAll("select oxid from oxcategories where oxonlysingle=1");


        //echo "check";
        $curArt = oxNew("oxarticle");
        $sOldControllerRight = $curArt->sControllerRight;
        $curArt->sControllerRight = 'order_list';
        $curArt->load($sProductID);
        $curArt->sControllerRight = $sOldControllerRight;
        if (count($groupsExlude)) {
            foreach ($this->getBasketArticles() as $article) {
                if ($article instanceof oxorderarticle) {
                    $article = $article->getArticle();
                }

                $curArtInGroup = false;
                $artInGroup = false;

                foreach ($groupsExlude as $row)
                {
                	// in den warenkorb zu legender (zu prüfender) artikel
                    $curArtInGroup = $curArtInGroup || $curArt->inCategory($row[0]);
                    // im warenkorb befindliche artikel in schleife
                    $artInGroup = $artInGroup || $article->inCategory($row[0]);
                }

                // wenn der zu prüfende artikel in einer onlysingle kategorie ist
	            // aber ein im warenkorb befindlichen artikel nicht
                if ($curArtInGroup && !$artInGroup)
                {
                    $oEx = oxNew('oxArticleInputException');
                    $oEx->setMessage('ERROR_MESSAGE_ARTICLE_ARTICLE_CANT_MIX_1');
                    //oxRegistry::get("oxUtilsView")->addErrorToDisplay( $oEx );
                    throw $oEx;
                }

                // wenn der zu prüfende artikel nicht in einer onlysingle kategorie
	            // ist aber dafür ein im warenkorb befindlicher artikel
                if (!$curArtInGroup && $artInGroup)
                {
                    $oEx = oxNew('oxArticleInputException');
                    $oEx->setMessage('ERROR_MESSAGE_ARTICLE_ARTICLE_CANT_MIX_2');
                    //oxRegistry::get("oxUtilsView")->addErrorToDisplay( $oEx );
                    throw $oEx;
                }

                // wenn beide artikel in einer onlysingle kategorie sind, mischen verhindern
	            // ausnahme bei selber kagegorie
	            if ($curArtInGroup && $artInGroup && ($curArt->getCategory() != $article->getCategory()))
	            {
		            $oEx = oxNew('oxArticleInputException');
		            $oEx->setMessage('ERROR_MESSAGE_ARTICLE_ARTICLE_CANT_MIX_2');
		            //oxRegistry::get("oxUtilsView")->addErrorToDisplay( $oEx );
		            throw $oEx;
	            }
            }
        }
        return parent::addToBasket( $sProductID, $dAmount, $aSel, $aPersParam, $blOverride, $blBundle, $sOldBasketItemId );
    }
}