<?php

namespace Netensio\RedirectManager\Model;

class Language extends Language_parent {

    public function getMultiLangTables()
    {
        return array_merge(array('netredirectmanager'), parent::getMultiLangTables());
    }

}