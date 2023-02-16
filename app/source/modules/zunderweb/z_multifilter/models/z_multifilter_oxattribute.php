<?php
class z_multifilter_oxattribute extends z_multifilter_oxattribute_parent
{  
    public function getAttributeIdByTitle($sSelTitle)
    {
        return parent::_getAttrId($sSelTitle);
    }
}
