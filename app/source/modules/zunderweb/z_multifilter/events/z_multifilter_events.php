<?php
class z_multifilter_events
{
    public static function onactivate(){
        $aAttLangIds = array(
            'mf_Manufacturer' => 'Z_MULTIFILTER_MANUFACTURERS',
            'mf_Price' => 'Z_MULTIFILTER_PRICE',
            'mf_Availability' => 'Z_MULTIFILTER_AVAILABLE',
            'mf_Reduced' => 'Z_MULTIFILTER_REDUCED',
        );
        z_multifilter_events::insertAttributes($aAttLangIds);
    }
    public static function ondeactivate(){
        
    }
    
    protected static function insertAttributes($aAtts){
        $oLang = oxregistry::getLang();
        $aLangs = $oLang->getLanguageArray(null, true);
        foreach ($aAtts as $sAttId => $sAtt){
            foreach ($aLangs as $oLang){
                $iLang = $oLang->id;
                $oAttribute = oxnew('oxattribute');
                $oAttribute->setLanguage($iLang);
                $sAttTitle = oxRegistry::getLang()->translateString( $sAtt, $iLang, false );
                if ($oAttribute->getAttributeIdByTitle($sAttTitle)){
                    $sAttId = $oAttribute->getAttributeIdByTitle($sAttTitle);
                }
                $oAttribute->load($sAttId);
                $oAttribute->setId($sAttId);
                $aParams['oxtitle'] = $sAttTitle;
                $oAttribute->assign($aParams);
                $oAttribute->save();
            }
        }
    }
}
