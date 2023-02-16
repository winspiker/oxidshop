<?php
class updatefilters extends oxUBase
{
    public function init()
    {
        $oLangHandler =oxRegistry::getLang();
        $aLangs = $oLangHandler->getLanguageArray();
        $iMaxCacheAge = $this->getConfig()->getConfigParam('iMfCachingMaxAge');
        //oxRegistry::getUtils()->resetMfAttributesCache();
        foreach ($aLangs as $oLang){
            $iLang = $oLang->id;
            $oLangHandler->setBaseLanguage( $iLang );
            $sTable = getViewName( 'oxcategories' );
            $sSql = "
                Select oxid from $sTable
                where oxactive=1
            ";
            $oDb = oxDb::getDb( oxDb::FETCH_MODE_ASSOC );
            $rs = $oDb->execute( $sSql );
            if ($rs != false && $rs->count() > 0) {
                while ( !$rs->EOF) {
                    $row = $rs->getFields();
                    $sKey = 'mf_attributecache_'.$row['OXID'].'_'.$iLang;
                    $iCacheAge = oxRegistry::getUtils()->z_GetCacheAge( $sKey );
                    if (!$iCacheAge || $iMaxCacheAge <= $iCacheAge){
                        $_GET['cnid'] = ($row['OXID']);
                        $_GET['lang'] = ($iLang);
                        $oAttributelist = oxnew('oxattributelist');
                        if (0 && $_GET['cnid'] != '0f41a4463b227c437f6e6bf57b1697c4'){
                            $rs->fetchRow();
                            continue;
                        }
                        parent::init();
                        $oAttributelist->z_initialize();
                        oxRegistry::getUtils()->fromFileCache( $sKey );
                        oxRegistry::getConfig()->pageClose();
                        die ("update filtercache ".$_GET['cnid']." lang $iLang OK");
                        break(2);
                    }
                    $rs->fetchRow();
                }
            }
        }
    }
    public function render()
    {
        die ('everything up to date!');
    }
}