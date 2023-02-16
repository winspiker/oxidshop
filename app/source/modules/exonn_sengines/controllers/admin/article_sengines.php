<?php

class Article_sengines extends oxAdminDetails
{
    /**
     * Loads article overview data, passes to Smarty engine and returns name
     * of template file "article_overview.tpl".
     *
     * @return string
     */
    public function render()
    {
        parent::render();
        $myConfig = $this->getConfig();
        $soxId = $myConfig->getRequestParameter('oxid');

        if ($soxId != "-1" && isset($soxId)) {
            $googlem = oxNew("exonn_googlem");
            $googlem->load($soxId);
            //print_r($googlem);
            $this->_aViewData['engineInfo'] = $googlem;
        }

        return "article_sengines.tpl";
    }

    public function save()
    {
        $myConfig = $this->getConfig();
        $soxId = $myConfig->getRequestParameter("oxid");
        $engineInfo = $myConfig->getRequestParameter("engineInfo");
        $googlem = oxNew("exonn_googlem");
        $googlem->assign($engineInfo);
        $googlem->setId($soxId);
        $googlem->save();

        $oRows = oxDb::getDb()->getAll("select oxid from oxarticles where oxparentid = '" . $soxId . "' ");
        $article = oxNew("oxarticle");
        $article->load($soxId);
        $engineInfo["exonn_googlem__item_group_id"] = $article->oxarticles__oxartnum->value;
        unset($engineInfo["exonn_googlem__color"]);
        unset($engineInfo["exonn_googlem__size"]);
        unset($engineInfo["exonn_googlem__material"]);
        unset($engineInfo["exonn_googlem__pattern"]);
        if (count($oRows)) {
            foreach($oRows as $row) {
                $googlem = oxNew("exonn_googlem");
                if (!$googlem->load($row[0])) {
                    $googlem->setId($row[0]);
                }
                $googlem->assign($engineInfo);
                $googlem->save();
            }
        }

        $this->_aViewData["updatelist"] = "1";
    }

}
