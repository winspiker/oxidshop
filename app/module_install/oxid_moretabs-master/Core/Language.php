<?php
namespace SeemannIT\MoreTabsModule\Core;

class Language extends Language_parent {
    public function getMultiLangTables() {
        $arr = parent::getMultiLangTables();
        array_push($arr, "mstabs");
        return $arr;
    }
}
