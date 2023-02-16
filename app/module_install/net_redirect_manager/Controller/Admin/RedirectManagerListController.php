<?php

namespace Netensio\RedirectManager\Controller\Admin;

class RedirectManagerListController extends \OxidEsales\Eshop\Application\Controller\Admin\AdminListController
{


    protected $_sThisTemplate = 'redirectmanager_list.tpl';


    protected $_sListClass = '\Netensio\RedirectManager\Model\RedirectManager';


    protected $_sDefSortField = 'oxsource';


    public function render()
    {
        parent::render();

        return $this->_sThisTemplate;
    }


    protected function _prepareWhereQuery($aWhere, $sqlFull)
    {
        $sQ = parent::_prepareWhereQuery($aWhere, $sqlFull);
        $sTable = getViewName("netredirectmanager");

        $iShopId = $this->getConfig()->getShopId();
        $sQ .= " and {$sTable}.oxshopid = '{$iShopId}' ";

        return $sQ;
    }
}
