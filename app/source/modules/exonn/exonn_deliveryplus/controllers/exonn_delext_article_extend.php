<?php

/**
 *  add to metadata.php in extend section: 'article_extend' => 'exonn_deliveryext/controllers/exonn_delext_article_extend',
 **/ 
class exonn_delext_article_extend extends exonn_delext_article_extend_parent {

    public function render()
    {
        $result = parent::render();

        $soxId = $this->getEditObjectId();
        $article = oxNew("oxarticle");
        $article->load($soxId);

        $this->_aViewData["addWeights"] = $article->getArticleParts();

        return $result;
    }

    public function save() {
        parent::save();

        $myConfig = $this->getConfig();
        $addWeights = $myConfig->getRequestParameter("addweight");
        if (is_array($addWeights)) {
            $addWeightsVal = implode(",", $addWeights);
        }

        $soxId = $this->getEditObjectId();
        $article = oxNew("oxarticle");
        $article->load($soxId);
        $article->assign(array("oxarticles__addweight" => $addWeightsVal));
        $article->save();
    }
}
