<?php
/*
 * EXONN ABO
 * */

class exonn_googlem extends oxBase
{
    /**
     * Current class name
     *
     * @var string
     */
    protected $_sClassName = 'exonn_googlem';

    protected $_sCoreTable = 'exonn_googlem';

    public function __construct()
    {
        parent::__construct();
        $this->init( $this->_sCoreTable );
    }

    public static function getCategoryEnginesStatistic($oxid) {
        $oDB = oxDB::getDb();
        $sSelect = "select count(a.oxid) from  exonn_googlem a inner join oxobject2category o2c on a.oxid = o2c.OXOBJECTID";
        $sSelect .= " where  o2c.OXCATNID = '".$oxid."'";
        $rs = $oDB->getAll($sSelect);
        return count($rs) ? $rs[0][0] : 0;
    }

    /**
     * Updates/inserts order object and related info to DB
     *
     * @return null
     */
    public function save()
    {
        if ( ( $blSave = parent::save() ) ) {

        }

        return $blSave;
    }

    /**
     * Inserts order object information in DB. Returns true on success.
     *
     * @return bool
     */
    protected function _insert()
    {
        if ( ( $blInsert = parent::_insert() ) ) {

        }

        return $blInsert;
    }

    /**
     * Updates stock information, deletes current ordering details from DB,
     * returns true on success.
     *
     * @param string $sOxId Ordering ID (default null)
     *
     * @return bool
     */
    public function delete( $sOxId = null )
    {
        return parent::delete( $sOxId );
    }

    public function cleanup() {
        //cleanup everything from attributes
        foreach (get_class_vars(__CLASS__) as $clsVar => $_) {
            $prop = new ReflectionProperty(__CLASS__, $clsVar);
            if (!$prop->isStatic()) {
                unset($this->$clsVar);
            }
        }
    }

}
