<?php

class exonnconnector_oxconfig extends exonnconnector_oxconfig_parent
{
    protected function getParamForABCUser($sName)
    {
        if ($this->getConfigParam($sName)) {
            if ($oUser = $this->getUser()) {
                if ($oUser->getId()) {
                    if ($oUser->isInABCGroup()) {
                        return true;
                    }
                }
            }
        }

        return false;

    }

    public function getConfigParam($name, $default = null)
    {

        $value = parent::getConfigParam($name, $default);

        //Netto Zeigen und Eingeben
        if (!$value && $this->getRequestParameter('cl')<>"article_main") {
            if ($name == "blEnterNetPrice") {
                $value = $this->getParamForABCUser('EXONN_CONNECTOR_SET_ABC_AS_NETTO');
            } elseif ($name == "blShowNetPrice") {
                $value = $this->getParamForABCUser('EXONN_CONNECTOR_SHOW_ABC_AS_NETTO');
            }
        }

        return $value;
    }

    public function getConfigParamOriginal($name, $default = null)
    {
        $this->init();

        if (isset($this->_aConfigParams[$name])) {
            $value = $this->_aConfigParams[$name];
        } elseif (isset($this->$name)) {
            $value = $this->$name;
        } else {
            $value = $default;
        }

        return $value;
    }

}