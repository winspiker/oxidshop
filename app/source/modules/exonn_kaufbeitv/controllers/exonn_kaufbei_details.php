<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_details extends exonn_kaufbei_details_parent
{
    protected $_oBadgeList = null;


    public function getBadgeList()
    {
        if ($this->_oBadgeList===null) {

            $this->_oBadgeList = oxNew("oxactionlist");
            $this->_oBadgeList->loadBadge();

        }

        return $this->_oBadgeList;

    }

}
