<?php

class cb_oxarticle extends cb_oxarticle_parent
{

    protected $_cb_oLongDesc;

    protected $_sActContIDForCB;

	public function getActContentIDForCB() {

		if ($this->_sActContIDForCB===null) {
			$this->_sActContIDForCB = $this->getProduct()->getId();
		}

		return $this->_sActContIDForCB;

	}

    public function setSkipCB($on = true) {
        $myConfig = $this->getConfig();
        if($user = $myConfig->getUser()) {
            $myConfig->setConfigParam("skipcb_" . $user->getId(), $on);
        }
    }

    public function isSkipCB() {
        $myConfig = $this->getConfig();
        if($user = $myConfig->getUser()) {
            return $myConfig->getConfigParam("skipcb_" . $user->getId());
        } return false;
    }

    public function getLongDescription()
    {
        if($this->isSkipCB()) return parent::getLongDescription();

        if ($this->_cb_oLongDesc===null) {

            $this->_cb_oLongDesc = parent::getLongDescription();

            if (!$this->isAdmin()) {
                $exonn_cb_content = oxNew("exonn_cb_content");
                $contentTop = $exonn_cb_content->getCbContent($this->getId()."_top");
                $contentBot = $exonn_cb_content->getCbContent($this->getId()."_bot");

                $oUser = $this->getUser();

                $sResDesc = "";
                if ($oUser->oxuser__oxrights->value == 'malladmin' ) {

                    $sResDesc =
                        '<div class="cb_container">
                    <div class="row clearfix">
                        <div class="column full center">
                            <button onclick="save(\'top\'); return false;" class="cb-save btn btn-primary"> Speichern </button>
                        </div>
                    </div>
                    </div>';
                }

                $sResDesc.='<div id="contentarea_top" class="contentarea cb_container ' . ($oUser->oxuser__oxrights->value != 'malladmin' ? 'live' : '') . '">' . $contentTop . "</div>";

                if ($oUser->oxuser__oxrights->value == 'malladmin') {
                    $sResDesc.='<div class="cb_container">
                        <div class="row clearfix">
                            <div class="column full center">
                                <button onclick="save(\'top\'); return false;" class="cb-save btn btn-primary"> Speichern </button>
                            </div>
                        </div>
                    </div>';
                }

                $sResDesc.=$this->_cb_oLongDesc->getRawValue();

                 if ($oUser->oxuser__oxrights->value == 'malladmin') {
                     $sResDesc.='<div class="cb_container">
                        <div class="row clearfix">
                            <div class="column full center">
                                <button onclick="save(\'bot\'); return false;" class="cb-save btn btn-primary"> Speichern </button>
                            </div>
                        </div>
                    </div>';
                 }

                 $sResDesc.='<div id="contentarea_bot" class="contentarea cb_container ' . ($oUser->oxuser__oxrights->value != 'malladmin' ? 'live' : '') . '">' . $contentBot . "</div>";
                 if ($oUser->oxuser__oxrights->value == 'malladmin') {
                      $sResDesc.=      '<div class="cb_container">
                        <div class="row clearfix">
                            <div class="column full center">
                                <button onclick="save(\'bot\'); return false;" class="cb-save btn btn-primary"> Speichern </button>
                            </div>
                        </div>
                    </div>';
                 }


                 $this->_oLongDesc->setValue( $sResDesc, oxField::T_RAW);

            }

        }

        return $this->_cb_oLongDesc;
    }



}