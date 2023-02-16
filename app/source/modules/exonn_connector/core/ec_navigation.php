<?php

class ec_navigation extends ec_navigation_parent {

    public function render() {
        $result = parent::render();
        /*
        $utils = oxNew("exonn_connector_utils");
        $mods = $utils->getServerModList();

        foreach ($mods as $moduleId => $modInfo) {
            $addInfo = $utils->getServerModInfo($moduleId);
        }
        $aMessage = array();
        $aMessage['message'] = "New version";
        */
        //$this->_aViewData['aMessage'] = $aMessage;
        return $result;
    }
}
 
