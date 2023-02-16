<?php
namespace SeemannIT\MoreTabsModule\Application\Controller\Admin;

class AdminDetailsController extends \OxidEsales\EshopCommunity\Application\Controller\Admin\AdminDetailsController {
    /**
     * Loads article data from DB, passes it to Smarty engine, returns name
     * of template file "article_userdef.tpl".
     *
     * @return string
     */
    public function render() {
        $myConfig = $this->getConfig();
        parent::render();

        $this->_aViewData['edit'] = $oArticle = oxNew( 'oxarticle' );

        $soxId = $this->getEditObjectId();
        $svoxId = $myConfig->getRequestParameter( "voxid" );
        $soxparentId = $myConfig->getRequestParameter( "oxparentid" );

        if (  $soxId && $soxId != "-1") {
            // load object
            $oArticle->loadInLang( $this->_iEditLang, $soxId );


            // load object in other languages
            $oOtherLang = $oArticle->getAvailableInLangs();
            if (!isset($oOtherLang[$this->_iEditLang])) {
                // echo "language entry doesn't exist! using: ".key($oOtherLang);
                $oArticle->loadInLang( key($oOtherLang), $soxId );
            }

            // load object
            $oArticle->load( $soxId );

            $aLang = array_diff(\OxidEsales\Eshop\Core\Registry::getLang()->getLanguageNames(), $oOtherLang);
            if ( count( $aLang))
                $this->_aViewData["posslang"] = $aLang;

            foreach ( $oOtherLang as $id => $language) {
                $oLang= new \stdClass();
                $oLang->sLangDesc = $language;
                $oLang->selected = ($id == $this->_iEditLang);
                $this->_aViewData["otherlang"][$id] =  clone $oLang;
            }
        }

        $this->_aViewData["editor1"] = $this->_generateTextEditor( "80%", 300, $oArticle, "mstabs__tab1_desc", "details.tpl.css");
        $this->_aViewData["editor2"] = $this->_generateTextEditor( "80%", 300, $oArticle, "mstabs__tab2_desc", "details.tpl.css");
        $this->_aViewData["editor3"] = $this->_generateTextEditor( "80%", 300, $oArticle, "mstabs__tab3_desc", "details.tpl.css");
        $this->_aViewData["editor4"] = $this->_generateTextEditor( "80%", 300, $oArticle, "mstabs__tab4_desc", "details.tpl.css");
        $this->_aViewData["editor5"] = $this->_generateTextEditor( "80%", 300, $oArticle, "mstabs__tab5_desc", "details.tpl.css");

        return "article_moretabs.tpl";
    }

    protected function _getEditValue($oObject, $sField) {
        $num = intval(substr($sField, strrpos($sField, "tab") + 3, 1));
        $sEditObjectValue = '';
        if ( $oObject ) {
            $oDescField = $oObject->getTabDesc($num);
            $sEditObjectValue = $this->_processEditValue($oDescField->getRawValue());
            $oDescField = new \OxidEsales\Eshop\Core\Field($sEditObjectValue, \OxidEsales\Eshop\Core\Field::T_RAW);
        }
        return $sEditObjectValue;
    }



    public function save() {
        $myConfig = $this->getConfig();
        parent::save();
        $soxId = $this->getEditObjectId();
        $aParams = $myConfig->getRequestParameter("editval");

        // shopid
        $sShopID = \OxidEsales\Eshop\Core\Registry::getSession()->getVariable("actshop");
        $aParams['oxarticles__oxshopid'] = $sShopID;

        $oArticle = oxNew("oxarticle");
        $oArticle->loadInLang($this->_iEditLang, $soxId);

        for($num = 1; $num <= 5; $num++) {
            $titles[$num] = $aParams["mstabs__tab{$num}_title"];
            $descs[$num] = $aParams["mstabs__tab{$num}_desc"];
            $poss[$num] = $aParams["mstabs__tab{$num}_pos"];
        }
        $oArticle->saveTab($titles, $descs, $poss);


        $oArticle->setLanguage(0);
        $oArticle->assign($aParams);

        //tells to article to save in different language
        $oArticle->setLanguage($this->_iEditLang);
        $oArticle = \OxidEsales\Eshop\Core\Registry::get("oxUtilsFile")->processFiles($oArticle);
        $oArticle->save();
    }
}
