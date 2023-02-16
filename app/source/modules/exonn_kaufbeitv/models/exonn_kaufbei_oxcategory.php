<?php

class exonn_kaufbei_oxcategory extends exonn_kaufbei_oxcategory_parent
{
    /**
     * Save this Object to database, insert or update as needed.
     *
     * @throws Exception
     *
     * @return string|bool
     */
    public function save()
    {
        $this->setParentHierarchy();
        $this->updateChildsHierarchy($this->oxcategories__oxid->value, (int)$this->oxcategories__hierarchy->value);
        return parent::save();
    }

    protected function setParentHierarchy(): void
    {
        $oParentCategory = oxNew(\OxidEsales\Eshop\Application\Model\Category::class);
        if (!$oParentCategory->load($this->oxcategories__oxparentid->value)) {
            $this->assign(['oxcategories__hierarchy' => 0]);
            return;
        }

        $this->assign(['oxcategories__hierarchy' => $oParentCategory->oxcategories__hierarchy->value + 1]);
    }

    protected function updateChildsHierarchy(?string $oxid, int $hierarchy): void
    {
        $childHierarchy = $hierarchy + 1;
        if ($oxid) {
            $data = $this->getChild($oxid);
            if ($data) {
                $this->updateHierarchySQL($oxid, $childHierarchy);
                foreach ($data as $category) {
                    $this->updateChildsHierarchy($category['OXID'], $childHierarchy);
                }
            }
        }
    }

    protected function getChild(string $oxId): array
    {
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC);
        $sql = "
                SELECT OXID
                FROM oxcategories
                WHERE OXPARENTID = " . $oDb->quote($oxId);
        return $oDb->getAll($sql);
    }

    protected function updateHierarchySQL(string $parentId, int $hierarchy): void
    {
        $oDb = \OxidEsales\Eshop\Core\DatabaseProvider::getDb(\OxidEsales\Eshop\Core\DatabaseProvider::FETCH_MODE_ASSOC);
        $sql = "
                UPDATE oxcategories 
                SET hierarchy = " . $oDb->quote($hierarchy) . "
                WHERE OXPARENTID = " . $oDb->quote($parentId);
        $oDb->execute($sql);
    }

}
