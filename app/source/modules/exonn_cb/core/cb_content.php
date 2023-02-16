<?php

class cb_content extends cb_content_parent
{
    protected $_sActContIDForCB = null;


    public function getActContentIDForCB()
    {

        if ($this->_sActContIDForCB === null) {
            $this->_sActContIDForCB = $this->getViewConfig()->getActContentLoadId();
        }

        return $this->_sActContIDForCB;

    }


    public function getParsedContent()
    {
        $exonn_cb_content = oxNew("exonn_cb_content");
        $contentTop = $exonn_cb_content->getCbContent($this->getContent()->oxcontents__oxloadid->value . "_top");
        $contentBot = $exonn_cb_content->getCbContent($this->getContent()->oxcontents__oxloadid->value . "_bot");

        $oUser = $this->getUser();
        $result = parent::getParsedContent();

        $result = ($oUser->oxuser__oxrights->value == 'malladmin' ?
                '<div class="cb_container">
                    <div class="row clearfix">
                        <div class="column full center">
                            <button onclick="save(\'top\')" class="cb-save btn btn-primary"> ' . oxRegistry::getLang()->translateString('EXONNCB_SAVE') . ' </button>
                        </div>
                    </div>
                </div>' : '')
            . '<div id="contentarea_top" class="contentarea cb_container ' . ($oUser->oxuser__oxrights->value != 'malladmin' ? 'live' : '') . '">' . $contentTop . "</div>"
            . ($oUser->oxuser__oxrights->value == 'malladmin' ?
                '<div class="cb_container">
                    <div class="row clearfix">
                        <div class="column full center">
                            <button onclick="save(\'top\')" class="cb-save btn btn-primary"> ' . oxRegistry::getLang()->translateString('EXONNCB_SAVE') . ' </button>
                        </div>
                    </div>
                </div>' : '')

            . $result

            . ($oUser->oxuser__oxrights->value == 'malladmin' ?
                '<div class="cb_container">
                    <div class="row clearfix">
                        <div class="column full center">
                            <button onclick="save(\'bot\')" class="cb-save btn btn-primary"> ' . oxRegistry::getLang()->translateString('EXONNCB_SAVE') . ' </button>
                        </div>
                    </div>
                </div>' : '')
            . '<div id="contentarea_bot" class="contentarea cb_container ' . ($oUser->oxuser__oxrights->value != 'malladmin' ? 'live' : '') . '">' . $contentBot . "</div>"
            . ($oUser->oxuser__oxrights->value == 'malladmin' ?
                '<div class="cb_container">
                    <div class="row clearfix">
                        <div class="column full center">
                            <button onclick="save(\'bot\')" class="cb-save btn btn-primary"> ' . oxRegistry::getLang()->translateString('EXONNCB_SAVE') . ' </button>
                        </div>
                    </div>
                </div>' : '');
        return $result;
    }

}