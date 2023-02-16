<?php

namespace Netensio\RedirectManager\Model;


class RedirectManager extends \OxidEsales\Eshop\Core\Model\MultiLanguageModel
{

    protected $_sClassName = "RedirectManager";

    public function __construct()
    {
        parent::__construct();
        $this->init("netredirectmanager");
    }

}
