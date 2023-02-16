<?php

class Category_sengines extends oxAdminDetails
{
    /**
     * Loads article category ordering info, passes it to Smarty
     * engine and returns name of template file "category_order.tpl".
     *
     * @return string
     */
    public function render()
    {
        parent::render();
        $myConfig = $this->getConfig();
        $soxId = $myConfig->getRequestParameter("oxid");
        if ($soxId != "-1" && isset($soxId)) {
            $googlem = oxNew("exonn_googlem");
            $googlem->load($soxId);
            //print_r($googlem);
            $this->_aViewData['engineInfo'] = $googlem;
        }

        return "category_sengines.tpl";
    }

    private function setArticles($soxId, $engineInfo) {
        $oList = oxNew("oxArticleList");
        $oList->loadCategoryIds($soxId, array());

        foreach ($oList->getArray() as $oxid) {
            $engineInfo["exonn_googlem__item_group_id"] = "";

            $googlem = oxNew("exonn_googlem");            
            if (!$googlem->load($oxid)) {
              $googlem->setId($oxid);
            }
            $googlem->assign($engineInfo);
            $googlem->save();

            $oRows = oxDb::getDb()->getAll("select oxid from oxarticles where oxparentid = '" . $oxid . "' ");
            if (count($oRows)) {
                $article = oxNew("oxarticle");
                $article->load($oxid);
                $engineInfo["exonn_googlem__item_group_id"] = $article->oxarticles__oxartnum->value;
                $article->exonncleanup();
                unset($article);

                foreach($oRows as $row) {
                    $googlem = oxNew("exonn_googlem");
                    $soxId = $row[0];
                    if (!$googlem->load($soxId)) {
                      $googlem->setId($soxId);
                    }
                    $googlem->assign($engineInfo);
                    $googlem->save();
                }
            }
        }
    }

    private function setCategories($soxId, $engineInfo) {

        $select = "select oxid from oxcategories where OXPARENTID = '$soxId'";
        $oDB = oxDb::getDb();
        $oRows = oxDb::getDb()->getAll( $select );
        if (count($oRows)) {
            foreach($oRows as $row) {
                $googlem = oxNew("exonn_googlem");
                $soxId = $row[0];
                if (!$googlem->load($soxId)) {
                  $googlem->setId($soxId);
                }
                $googlem->assign($engineInfo);
                $googlem->save();

                $this->setArticles($row[0], $engineInfo);
                $this->setCategories($row[0], $engineInfo);
            }
        }
    }

    public function save()
    {
        $myConfig = $this->getConfig();
        $soxId = $myConfig->getRequestParameter("oxid");
        $engineInfoRequest = $myConfig->getRequestParameter("engineInfo");
        $useEngineInfo = $myConfig->getRequestParameter("use_engineInfo");
        $engineInfo = array(); 
    
        foreach ($useEngineInfo as $key => $val) {
            if ($val) {
                $engineInfo[$key] = $engineInfoRequest[$key];
            }
        }  
       
        $googlem = oxNew("exonn_googlem"); 
        if (!$googlem->load($soxId)) {
          $googlem->setId($soxId);
        } 
        $googlem->assign($engineInfo);
        $googlem->save();
        
        $this->setArticles($soxId, $engineInfo);
        $this->setCategories($soxId, $engineInfo);

        $this->_aViewData["updatelist"] = "1";
    }

}
