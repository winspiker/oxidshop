<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_warehouse_oxarticlelist extends exonn_warehouse_oxarticlelist_parent
{

    protected $_oBaseObject = null;
    protected $_blLoadParentData = false;

    public function setLoadParentData($blLoadParentData)
    {
        $this->_blLoadParentData = $blLoadParentData;
    }
    public function getBaseObject()
    {
        if (!$this->_oBaseObject) {
            $this->_oBaseObject = oxNew($this->_sObjectsInListName);
            if ($this->_blLoadParentData) {
                $this->_oBaseObject->setLoadParentData(true);
            }
            $this->_oBaseObject->setInList();
            $this->_oBaseObject->init($this->_sCoreTable);
        }

        return $this->_oBaseObject;
    }

    /**
     * Loads article cross selling
     *
     * @param string $sArticleId Article id
     *
     * @return null
     */
    public function loadArticleCrossSell($sArticleId, $sParentId="")
    {
        $myConfig = $this->getConfig();

        // Performance
        if (!$myConfig->getConfigParam('bl_perfLoadCrossselling')) {
            return null;
        }

        $oBaseObject = $this->getBaseObject();
        $sArticleTable = $oBaseObject->getViewName();

        $sArticleId = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quote($sArticleId);

        // #525 bidirectional cross selling
        if (!$myConfig->getConfigParam('blBidirectCross')) {

            $sSelect = "SELECT $sArticleTable.*
                        FROM $sArticleTable INNER JOIN oxobject2article ON oxobject2article.oxobjectid=$sArticleTable.oxid ";
            $sSelect .= "WHERE oxobject2article.oxarticlenid = $sArticleId ";
            $sSelect .= " AND " . $oBaseObject->getSqlActiveSnippet();

            if ($sParentId) {

                $sParentId = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quote($sParentId);
                $sSelect .= "UNION SELECT $sArticleTable.*
                        FROM $sArticleTable INNER JOIN oxobject2article ON oxobject2article.oxobjectid=$sArticleTable.oxid ";
                $sSelect .= "WHERE oxobject2article.oxarticlenid = $sParentId ";
                $sSelect .= " AND " . $oBaseObject->getSqlActiveSnippet();

            }

        } else {

            $sSelect = "
                (
                    SELECT $sArticleTable.* FROM $sArticleTable
                        INNER JOIN oxobject2article AS O2A1 on
                            ( O2A1.oxobjectid = $sArticleTable.oxid AND O2A1.oxarticlenid = $sArticleId )
                    WHERE 1
                    AND " . $oBaseObject->getSqlActiveSnippet() . "
                    AND ($sArticleTable.oxid != $sArticleId)
                )
                UNION
                (
                    SELECT $sArticleTable.* FROM $sArticleTable
                        INNER JOIN oxobject2article AS O2A2 ON
                            ( O2A2.oxarticlenid = $sArticleTable.oxid AND O2A2.oxobjectid = $sArticleId )
                    WHERE 1
                    AND " . $oBaseObject->getSqlActiveSnippet() . "
                    AND ($sArticleTable.oxid != $sArticleId)
                )";
            if ($sParentId) {

                $sParentId = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quote($sParentId);

                $sSelect .= " UNION
                (
                    SELECT $sArticleTable.* FROM $sArticleTable
                        INNER JOIN oxobject2article AS O2A1 on
                            ( O2A1.oxobjectid = $sArticleTable.oxid AND O2A1.oxarticlenid = $sParentId )
                    WHERE 1
                    AND " . $oBaseObject->getSqlActiveSnippet() . "
                    AND ($sArticleTable.oxid != $sParentId)
                )
                UNION
                (
                    SELECT $sArticleTable.* FROM $sArticleTable
                        INNER JOIN oxobject2article AS O2A2 ON
                            ( O2A2.oxarticlenid = $sArticleTable.oxid AND O2A2.oxobjectid = $sParentId )
                    WHERE 1
                    AND " . $oBaseObject->getSqlActiveSnippet() . "
                    AND ($sArticleTable.oxid != $sParentId)
                )";
            }
        }

        $this->setSqlLimit(0, $myConfig->getConfigParam('iNrofCrossellArticles'));
        $this->selectString($sSelect);
    }

    /**
     * Loads article accessories
     *
     * @param string $sArticleId Article id
     *
     * @return null
     */
    public function loadArticleAccessoires($sArticleId, $sParentId)
    {
        $myConfig = $this->getConfig();

        // Performance
        if (!$myConfig->getConfigParam('bl_perfLoadAccessoires')) {
            return;
        }

        $sArticleId = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quote($sArticleId);

        $oBaseObject = $this->getBaseObject();
        $sArticleTable = $oBaseObject->getViewName();

        $sSelect = "select $sArticleTable.*, oxaccessoire2article.oxsort as sortfield from oxaccessoire2article left join $sArticleTable on oxaccessoire2article.oxobjectid=$sArticleTable.oxid ";
        $sSelect .= "where oxaccessoire2article.oxarticlenid = $sArticleId ";
        $sSelect .= " and $sArticleTable.oxid is not null and " . $oBaseObject->getSqlActiveSnippet();
        //sorting articles

        if ($sParentId) {
            $sParentId = \OxidEsales\Eshop\Core\DatabaseProvider::getDb()->quote($sParentId);

            $sSelect .= "UNION select $sArticleTable.*, oxaccessoire2article.oxsort as sortfield from oxaccessoire2article left join $sArticleTable on oxaccessoire2article.oxobjectid=$sArticleTable.oxid ";
            $sSelect .= "where oxaccessoire2article.oxarticlenid = $sParentId ";
            $sSelect .= " and $sArticleTable.oxid is not null and " . $oBaseObject->getSqlActiveSnippet();
            //sorting articles

        }
        $sSelect .= " order by sortfield";

        $this->selectString($sSelect);
    }


}
