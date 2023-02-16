<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxcategorylist extends exonn_kaufbei_oxcategorylist_parent
{

    protected $_loadStartCat;

    public function loadStartCategories()
    {
        $this->_loadStartCat = true;
        $aData = $this->_loadFromDb();

        $this->assignArray($aData);
    }

    protected function _getSelectString($blReverse = false, $aColumns = null, $sOrder = null)
    {
        if ($this->isAdmin()) {
            return parent::_getSelectString($blReverse, $aColumns, $sOrder);
        }

        if ($this->_loadStartCat) {
            $sViewName = $this->getBaseObject()->getViewName();
            $sFieldList = $this->_getSqlSelectFieldsForTree($sViewName, $aColumns);

            $sUnion = '';
            $sWhere = ' stertseite=1 ';

            if (!$sOrder) {
                $sOrdDir = $blReverse ? 'desc' : 'asc';
                $sOrder = "oxrootid $sOrdDir, oxleft $sOrdDir";
            }
            return "select $sFieldList from $sViewName where $sWhere $sUnion order by $sOrder";
        }

        return $this->getBaseSQL($blReverse, $aColumns, $sOrder);

    }


    protected function _getSqlSelectFieldsForTree($sTable, $aColumns = null)
    {
        if ($aColumns && count($aColumns)) {
            foreach ($aColumns as $key => $val) {
                $aColumns[$key] .= ' as ' . $val;
            }

            return "$sTable." . implode(", $sTable.", $aColumns);
        }

        $sFieldList = "$sTable.oxid as oxid, $sTable.oxactive as oxactive,"
            . " $sTable.oxhidden as oxhidden, $sTable.oxparentid as oxparentid,"
            . " $sTable.oxdefsort as oxdefsort, $sTable.oxdefsortmode as oxdefsortmode,"
            . " $sTable.oxleft as oxleft, $sTable.oxright as oxright,"
            . " $sTable.oxrootid as oxrootid, $sTable.oxsort as oxsort,"
            . " $sTable.oxtitle as oxtitle, $sTable.oxdesc as oxdesc,"
            . " $sTable.oxpricefrom as oxpricefrom, $sTable.oxpriceto as oxpriceto,"
            . " $sTable.oxicon as oxicon, $sTable.oxextlink as oxextlink,"
            . " $sTable.oxthumb as oxthumb, $sTable.oxpromoicon as oxpromoicon, $sTable.oxicon as icon";

        $sFieldList .= ",not $sTable.oxactive as oxppremove";


        return $sFieldList;
    }

    /**
     * Get data from db
     *
     * @return array
     */
    protected function _loadFromDb()
    {
        $sSql = $this->_getSelectString(false, null, 'oxparentid, oxsort, oxtitle');
        $aData = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sSql);

        $newData = $this->getParentBranch($this->getConfig()->getRequestParameter('cnid'));
        return array_merge($aData, $newData);
    }

    /**
     * Generates a SQL query to get the main categories as well as the category from the request and its children categories.
     *
     * @return string
     */
    private function getBaseSQL($blReverse = false, $aColumns = null, $sOrder = null): string
    {
        $sViewName = $this->getBaseObject()->getViewName();
        $sFieldList = $this->_getSqlSelectFieldsForTree($sViewName, $aColumns);

        $sUnion = '';
        $sWhere = 'hierarchy < 3 AND OXACTIVE = 1';

        $baseSql = "
            SELECT $sFieldList
            FROM $sViewName
            WHERE $sWhere
        ";

        $parentSql = '';
        if($currentOxid = $this->getConfig()->getRequestParameter('cnid')) {
            $parentSql = "
                    SELECT $sFieldList
                    FROM $sViewName
                    WHERE oxparentid = '$currentOxid'
                    AND hierarchy > 2 AND OXACTIVE = 1
                    UNION
                    SELECT $sFieldList
                    FROM $sViewName
                    WHERE OXID = '$currentOxid'
                    UNION
                    ";
        }

        $resultSql = $parentSql . $baseSql;
        return "$resultSql $sUnion order by $sOrder";
    }

    /**
     * Get all parent branches up to 2 hierarchies from database
     *
     * @return array
     */
    protected function getParentBranch(?string $oxid): array
    {
        $parentData = [];
        if ($oxid) {
            $sql = $this->getParentSQL($oxid);
            $data = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC)->getAll($sql);
            if ($data) {
                $parentData[] = $data[0];
                $parentData = array_merge($parentData, $this->getParentBranch($data[0]['oxid']));
            }
        }
        return $parentData;
    }

    /**
     * Generates a sql query to get the parent of the incoming category
     *
     * @return string
     */
    protected function getParentSQL(string $parentId): string
    {
        $sViewName = $this->getBaseObject()->getViewName();
        $sFieldList = $this->_getSqlSelectFieldsForTree($sViewName);
        $sWhere = 'hierarchy > 2 AND OXACTIVE = 1';

        $parentSql = "
                    SELECT $sFieldList
                    FROM $sViewName
                    WHERE OXID
                    IN (
                        SELECT OXPARENTID
                        FROM $sViewName
                        WHERE OXID='$parentId'
                    )
                    AND $sWhere
                    ";

        return $parentSql;
    }

    // _ppRemoveInactiveCategories
    // diese funktion macht cache in der tabelle oxcategories (alle nicht aktive kategorien werden markiert)
    // wenn kunde die seite öffnet, wird diese funktion nicht ausgeführt, weil werden nur oxremove=0 geladen.
    /*protected function _markInactiveCategories()
    {
        $oDb = \oxDb::getDb();
        $oDb->execute("update oxcategories set oxremove_edit=0");
        // Collect all items which must be remove
        $aRemoveList = [];
        foreach ($this->_aArray as $sId => $oCat) {
            if ($oCat->oxcategories__oxppremove->value) {
                if (!isset($aRemoveList[$oCat->oxcategories__oxrootid->value])) {
                    $aRemoveList[$oCat->oxcategories__oxrootid->value] = [];
                }
                $aRemoveList[$oCat->oxcategories__oxrootid->value][$oCat->oxcategories__oxleft->value] = $oCat->oxcategories__oxright->value;
                $oDb->execute("update oxcategories set oxremove_edit=1 where oxid=".$oDb->quote($sId));
                unset($this->_aArray[$sId]);
            } else {
                unset($oCat->oxcategories__oxppremove);
            }
        }

        // Remove collected item's children from the list too (in the ranges).
        foreach ($this->_aArray as $sId => $oCat) {
            if (isset($aRemoveList[$oCat->oxcategories__oxrootid->value]) &&
                is_array($aRemoveList[$oCat->oxcategories__oxrootid->value])
            ) {
                foreach ($aRemoveList[$oCat->oxcategories__oxrootid->value] as $iLeft => $iRight) {
                    if (($iLeft <= $oCat->oxcategories__oxleft->value)
                        && ($iRight >= $oCat->oxcategories__oxleft->value)
                    ) {
                        // this is a child in an inactive range (parent already gone)
                        $oDb->execute("update oxcategories set oxremove_edit=1 where oxid=".$oDb->quote($sId));
                        unset($this->_aArray[$sId]);
                        break 1;
                    }
                }
            }
        }
        $oDb->execute("update oxcategories set oxremove = oxremove_edit");
    }*/

    //diese funktion muss nichts gemacht werden (NICHT LÖSCHEN !!!)
    //weil ist schon im cache gemacht!
    /*protected function _ppRemoveInactiveCategories()
    {

    }*/

    /*public function buildTreeForCache()
    {
        startProfile("buildTree");

        $this->load();
        // remove inactive categories
        $this->_markInactiveCategories();

        stopProfile("buildTree");
    }*/

}
