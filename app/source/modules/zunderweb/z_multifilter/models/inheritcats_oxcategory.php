<?php
class inheritcats_oxcategory extends inheritcats_oxcategory_parent
{    
    public function z_getUpperCategoryIdsForSelect($sCatId){
        
        $aCatIds = $this->z_getUpperCategoryIds($sCatId);
        $sIds = "";
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                if ($sIds){
                    $sIds .= ', ';
                }
                $sIds .= oxDb::getDb()->quote( $aCatId  );
            }
        }
        return $sIds;
    }
    public function z_getSubCategoriesIdsRecursiveForSelect($sCatId){
        
        $aCatIds = $this->z_getSubCategoriesIdsRecursive($sCatId);
        $sIds = "";
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                if ($sIds){
                    $sIds .= ', ';
                }
                $sIds .= oxDb::getDb()->quote( $aCatId  );
            }
        }
        return $sIds;
    }
    public function z_getSubCategoriesIdsRecursive($sCatId){
        $oDb = oxDb::getDb();
        $aIds = array();
        
        //get left right
        $sSelect = "select oxleft, oxright, oxrootid, oxactive from oxcategories where oxid=".$oDb->quote($sCatId);
        $aFields = $oDb->getRow( $sSelect );
        $iLeft = $aFields[0];
        $iRight = $aFields[1];
        $sRoot = $aFields[2];
        $blActive = $aFields[3];
        if (!$blActive) return array();
        
        //get subcats
        $sSelect = "select oxid from oxcategories where oxactive=1 and oxleft>$iLeft and oxright<$iRight and oxrootid=".$oDb->quote($sRoot);
        $aCatIds = $oDb->getAll( $sSelect );
        $aIds[] = $sCatId;
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                $aIds[] = current( $aCatId );
            }
        }
        return $aIds;
    }
    public function z_getUpperCategoryIds($sCatId){
        $oDb = oxDb::getDb();
        $aIds = array();
        
        //get left right
        $sSelect = "select oxleft, oxright, oxrootid, oxactive from oxcategories where oxid=".$oDb->quote($sCatId);
        $aFields = $oDb->getRow( $sSelect );
        $iLeft = $aFields[0];
        $iRight = $aFields[1];
        $sRoot = $aFields[2];
        $blActive = $aFields[3];
        if (!$blActive) return array();
        
        //get subcats
        $sSelect = "select oxid from oxcategories where oxactive=1 and oxleft<$iLeft and oxright>$iRight and oxrootid=".$oDb->quote($sRoot);
        $aCatIds = $oDb->getAll( $sSelect );
        $aIds[] = $sCatId;
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                $aIds[] = current( $aCatId );
            }
        }
        return $aIds;
    }
    public function z_getSubCategoriesIds($sCatId){
        $oDb = oxDb::getDb();
        $aIds = array();
                
        //get subcats
        $sSelect = "select oxid from oxcategories where oxactive=1 and oxparentid=".$oDb->quote($sCatId);
        $aCatIds = $oDb->getAll( $sSelect );
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                $aIds[] = current( $aCatId );
            }
        }
        return $aIds;
    }
    public function z_getSubCategoriesIdsForSelect($aCatId){
        $aCatIds = $this->z_getSubCategoriesIds($aCatId);
        $sIds = "";
        if (is_array($aCatIds)){
            foreach ($aCatIds as $aCatId){
                if ($sIds){
                    $sIds .= ', ';
                }
                $sIds .= oxDb::getDb()->quote( $aCatId  );
            }
        }
        return $sIds;
    }
    public function z_getSubCategories($sCatId){
        $aIds = $this->z_getSubCategoriesIds($sCatId);
        return $this->z_getCategoriesFromIds($aIds);
    }
    public function z_getCategoriesFromIds($aIds){
        $aRet = array();
        foreach ($aIds as $sId){
            $oCat = oxnew('oxcategory');
            if ($oCat->load($sId)){
                $aRet[$sId] = $oCat;
            }
        }
        return $aRet;
    }
}