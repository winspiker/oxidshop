<?php



class exonn_boniversumpayments extends oxBase {

    protected $_sClassName = 'exonn_boniversumpayments';

    protected $_oPayments = null;
    protected $_aArrayData = null;

    public function __construct()
    {
        parent::__construct();
        $this->init( 'exonn_boniversumpayments' );
    }



    public  function getPayments()
    {
        if ($this->_oPayments===null) {
            $this->_oPayments = oxDb::getDb()->getCol("select oxpaymentid from exonn_boniversum2payments where oxboniversumid=".oxdb::getDb()->quote($this->getId()));
        }
        return $this->_oPayments;
    }


    public  function getArrayData($sFeld)
    {
        if ($this->_aArrayData[$sFeld]===null) {
            if (is_array($this->{$sFeld}->value)) {
                $this->_aArrayData[$sFeld] = $this->{$sFeld}->value;
            } else {
                if ($this->{$sFeld}->value) {
                    $this->_aArrayData[$sFeld] = explode(",", $this->{$sFeld}->value);
                } else {
                    $this->_aArrayData[$sFeld] = array();
                }
            }
        }

        return $this->_aArrayData[$sFeld];

    }


}