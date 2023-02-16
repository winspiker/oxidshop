<?php
class exonn_cb_content extends oxBase
{

    /**
     * Current class name
     *
     * @var string
     */
    protected $_sClassName = 'exonn_cb_content';


    /**
     * Class constructor, initiates parent constructor (parent::oxI18n()).
     */
    public function __construct()
    {
        parent::__construct();
        $this->init( 'cb_contents' );
    }

    protected function _setFieldData( $sFieldName, $sValue, $iDataType = oxField::T_TEXT )
    {
        if ( 'content' === strtolower( $sFieldName ) || 'cb_contents__content' === strtolower( $sFieldName ) ) {
            $iDataType = oxField::T_RAW;
        }
        return parent::_setFieldData( $sFieldName, $sValue, $iDataType );
    }

    public function getCbContent($cbid) {
        $oShopId = $this->getConfig()->getShopId();

        $oLang = oxRegistry::getLang();
        $langId = $oLang->getEditLanguage();
        $field = "content";
        if ($langId > 0) {
            $field = "content_" . $langId;
        }

        $content = oxDb::getDb()->getOne("select $field from cb_contents where oxshopid=".oxDb::getDb()->quote($oShopId)." && cbid = '".$cbid."'");
        //echo "-*" . $content . "*-";
        if (!$content) {
            $content = oxDb::getDb()->getOne("select content from cb_contents where oxshopid=" . oxDb::getDb()->quote($oShopId) . " && cbid = '" . $cbid . "'");
        }
        return $content;
    }



}
