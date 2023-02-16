<?php

class exonnconnector_oxarticle extends exonnconnector_oxarticle_parent
{

    public function getMediaUrls()
    {
        $result = parent::getMediaUrls();

        if (!$result || !$result->count() && $parent = $this->getParentArticle()) {
            if ($parent->oxarticles__oxmediafromparent->value) {
                $result = $parent->getMediaUrls();
            }
        }

        return $result;
    }


    protected function _getUserPriceSufix()
    {
        //damit brutto preis beim Artikel in admin richtig angezeigt wird (auch wenn admin in gruppe ABC ist)
        if ($this->getConfig()->getRequestParameter('cl')=="article_main") {
            return '';
        }

        return parent::_getUserPriceSufix();
    }


    //wenn nur ABC preise Netto eingegeben sind, dann muss eingegebene UVP Preis als Brutto verstehen werden
    public function getTPrice()
    {

        $oConfig = $this->getConfig();

        $bl_param_changed = false;
        if (!$oConfig->getConfigParamOriginal('blEnterNetPrice') && $oConfig->getConfigParam('blEnterNetPrice')) {
            $oConfig->setConfigParam('EXONN_CONNECTOR_SET_ABC_AS_NETTO', 0);
            $bl_param_changed = true;
        }

        $res = parent::getTPrice();


        //einstellungen zurücksetzen
        if ($bl_param_changed) {
            $oConfig->setConfigParam('EXONN_CONNECTOR_SET_ABC_AS_NETTO', 1);
        }

        return $res;
    }


}