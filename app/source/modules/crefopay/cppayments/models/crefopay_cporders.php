<?php

use OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\Model\BaseModel;
 
/**
 * This model represents the cporders table in database
 */
class crefopay_cporders extends BaseModel
{
    /**
     * Possible CrefoPay transaction states
     */
    const CPORDERSTATE = [
        'NEW' => 'New',
        'ACKNOWLEDGEPENDING' => 'AcknowledgePending',
        'FRAUDPENDING' => 'FraudPending',
        'MERCHANTPENDING' => 'MerchantPending',
        'CIAPENDING' => 'CIAPending',
        'EXPIRED' => 'Expired',
        'CANCELLED' => 'Cancelled',
        'FRAUDCANCELLED' => 'FraudCancelled',
        'DONE' => 'Done'
    ];

    /**
     * Possible CrefoPay payment methods
     */
    const CPPAYMENTMETHOD = [
        'DD' =>	'Direct debit',
        'CC' => 'Credit card',
        'CC3D' => 'Credit card 3D-Secure',
        'PREPAID' => 'Cash in advance',
        'PAYPAL' => 'PayPal',
        'SU' => 'Sofort',
        'BILL' => 'Bill payment',
        'COD' => 'Cash on delivery',
        'DUMMY'	=> 'Dummy'
    ];

    /**
     * Possible CrefoPay risk classes
     */
    const CPRISKCLASS = [
        0 => 'Trusted',
        1 => 'Default',
        2 => 'Highrisk'
    ];

    /**
     * Database fieldnames
     */
    const COL_OXID = 'OXID';
    const COL_OXSESSIONID = 'OXSESSIONID';
    const COL_OXORDERID = 'OXORDERID';
    const COL_CPSTOREID = 'CPSTOREID';
    const COL_CPORDERID = 'CPORDERID';
    const COL_CPORDERSTATE = 'CPORDERSTATE';
    const COL_CPUSERID = 'CPUSERID';
    const COL_CPUSERTYPE = 'CPUSERTYPE';
    const COL_CPPAYMENTMETHOD = 'CPPAYMENTMETHOD';
    const COL_CPPID = 'CPPID';
    const COL_CPADDITIONAL = 'CPADDITIONAL';
    const COL_CPRISKCLASS = 'CPRISKCLASS';
    const COL_CPORDERUPDATE = 'CPORDERUPDATE';
    const COL_CPORDERDATE = 'CPORDERDATE';

    /**
     * SQL Commands
     */
    const SQL_UPDATE = "UPDATE cporders SET OXID=?, OXSESSIONID=?, OXORDERID=?, CPSTOREID=?, CPORDERSTATE=?, CPUSERID=?, CPUSERTYPE=?, CPPAYMENTMETHOD=?, CPPID=?, CPADDITIONAL=?, CPRISKCLASS=?, CPORDERUPDATE=? WHERE CPORDERID=?";

    /**
     * CpAdditionalData - might be stored for some reasons
     * Columnname: CPADDITIONAL
     *
     * @var string (50)
     */
    protected $cpadditional;

    /**
     * CpOrderDate - timestamp when the CrefoPay transaction object has been created
     * Columnname: CPORDERDATE
     *
     * @var timestamp [current_timestamp]
     */
    protected $cporderdate;
    /**
     * CpOrderID - systenwide CrefoPay internal id
     * Columnname: CPORDERID
     *
     * @var string (60)
     */
    protected $cporderid;

    /**
     * CpOrderState - state of the transaction (see also CONST CPORDERSTATE)
     * Columnname: CPORDERSTATE
     *
     * @var const string (20)
     */
    protected $cporderstate;

    /**
     * CpOrderUpdate
     * Columnname: CPORDERUPDATE
     *
     * @var datetime [last_update]
     */
    protected $cporderupdate;

    /**
     * CpPaymentMethod - the used payment method for the payment (see also CONST CPPAYMENTMETHOD)
     * Columnname: CPPAYMENTMETHOD
     *
     * @var const string (16)
     */
    protected $cppaymentmethod;

    /**
     * CpPaymentInstrumentId - the identifier for users payment insruments (credit/debit cards & bank accounts)
     * Columnname: CPPID
     *
     * @var string (50)
     */
    protected $cppaymentinstrumentid;

    /**
     * CpRiskClass - the CrefoPay transaction risk class (see CPRISKCLASS)
     * Columnname: CPRISKCLASS
     *
     * @var tinyint
     */
    protected $cpriskclass;

    /**
     * CpUserId - the systemwide CrefoPay user id
     * Columnname: CPUSERID
     *
     * @var string (50)
     */
    protected $cpuserid;

    /**
     * CpUserType - indicates if user/transaction is BUSINESS or protected
     * Columnname: CPUSERTYPE
     *
     * @var const string (8)
     */
    protected $cpusertype;

    /**
     * OxId - systemwide oxid internal id
     *
     * @var string (32)
     */
    protected $oxid;

    /**
     * OxSessionId - the oxid user session id
     * Columnname: OXSESSIONID
     *
     * @var string (32)
     */
    protected $oxsessionid;

    /**
     * OxOrderID - Oxid order number
     * Columnname: OXORDERID
     *
     * @var string (32)
     */
    protected $oxorderid;

    /**
     * Store ID - based on CrefoPay configuration
     * Columnname: CPSTOREID
     *
     * @var string (16)
     */
    protected $cpstoreid;

    /**
     * Logger
     *
     * @var crefoPayLogger $logger
     */
    private $logger;


    /**
     * Default constructor
     */
    public function __construct()
    {
        parent::__construct();
        $this->init('crefopay_cporders');
        $this->logger = oxNew('crefoPayLogger');
    }

    /**
     * Get the CrefoPay orderID
     *
     * @return string
     */
    public function getCpOrderId()
    {
        return $this->cporderid;
    }

    /**
     * Get the oxId
     *
     * @return string
     */
    public function getOxId()
    {
        return $this->oxid;
    }

    /**
     * Get the oxOrderId (Order Number)
     *
     * @return string
     */
    public function getOxOrderNr()
    {
        return $this->oxorderid;
    }

    /**
     * Get the RiskClass of a transaction
     *
     * @param string $id
     * 
     * @throws Exception
     * @return int
     */
    public function getRiskClassBySessionId($id)
    {
        try {
            $cpOxDb = oxDb::getDb();
            $cpOxDb->setFetchMode(2);
            $sql = 'select * from cporders where OXSESSIONID=?';
            $result = $cpOxDb->getRow($sql, [$id]);
            
            if ($result) {
                $this->cporderid = $result[self::COL_CPORDERID];
                $this->oxid = $result[self::COL_OXID];
                $this->oxorderid = $result[self::COL_OXORDERID];
                $this->oxsessionid =  $id;
                $this->cpstoreid = $result[self::COL_CPSTOREID];
                $this->cporderstate = $result[self::COL_CPORDERSTATE];
                $this->cpuserid = $result[self::COL_CPUSERID];
                $this->cpusertype = $result[self::COL_CPUSERTYPE];
                $this->cppaymentmethod = $result[self::COL_CPPAYMENTMETHOD];
                $this->cppaymentinstrumentid = $result[self::COL_CPPID];
                $this->cpadditional = $result[self::COL_CPADDITIONAL];
                $this->cpriskclass = $result[self::COL_CPRISKCLASS];
                $this->cporderupdate = $result[self::COL_CPORDERUPDATE];
                $this->cporderdate = $result[self::COL_CPORDERDATE];
            } else {
                $this->logger->debug(__FILE__, self::COL_OXSESSIONID . " " . $id . " nicht gefunden");
                return 1;
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
        if ($this->cpriskclass == null) {
            return 1;
        } else {
            return (int) $this->cpriskclass;
        }
    }

    /**
     * Loads object data from DB by CrefoPay orderID
     *
     * @param string $id
     * 
     * @throws ObjectException
     * @return bool
     */
    public function cpLoad($id) 
    {
        try {
            $cpOxDb = oxDb::getDb();
            $cpOxDb->setFetchMode(2);
            $sql = 'select * from cporders where CPORDERID=?';
            $result = $cpOxDb->getRow($sql, [$id]);
            
            if ($result) {
                $this->cporderid = $id;
                $this->oxid = $result[self::COL_OXID];
                $this->oxorderid = $result[self::COL_OXORDERID];
                $this->oxsessionid =  $result[self::COL_OXSESSIONID];
                $this->cpstoreid = $result[self::COL_CPSTOREID];
                $this->cporderstate = $result[self::COL_CPORDERSTATE];
                $this->cpuserid = $result[self::COL_CPUSERID];
                $this->cpusertype = $result[self::COL_CPUSERTYPE];
                $this->cppaymentmethod = $result[self::COL_CPPAYMENTMETHOD];
                $this->cppaymentinstrumentid = $result[self::COL_CPPID];
                $this->cpadditional = $result[self::COL_CPADDITIONAL];
                $this->cpriskclass = $result[self::COL_CPRISKCLASS];
                $this->cporderupdate = $result[self::COL_CPORDERUPDATE];
                $this->cporderdate = $result[self::COL_CPORDERDATE];
            } else {
                $this->logger->warn(__FILE__, self::COL_CPORDERID . " " . $id . " nicht gefunden");
                return $result;
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
        return $true;
    }

    /**
     * Save the model
     *
     * @throws Exception
     * @return bool
     */
    public function save()
    {
        if (empty($this->cporderid)) {
            $this->logger->warn(__FILE__, "Speichern fehlgeschlagen: keine OrderID");
            return false;
        }
        if (empty($this->timestamp)) {
            $this->logger->debug(__FILE__, "Setze timestamp auf aktuelle/s Datum/Uhrzeit");
            $this->timestamp = $this->timestamp();
        }

        try {
            if ($this->orderCheck()) {
                $this->logger->debug(__FILE__, "Bestellung erfolgreich geprüft");
            } else {
                $this->logger->debug(__FILE__, "Bestellung wird aktualisiert: LinkOxId");
                $this->linkOxId();
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }

        $sql = $this::SQL_UPDATE;
        $values = [
            $this->oxid,
            $this->oxsessionid,
            $this->oxorderid,
            $this->cpstoreid,
            $this->cporderstate,
            $this->cpuserid,
            $this->cpusertype,
            $this->cppaymentmethod,
            $this->cppaymentinstrumentid,
            $this->cpadditional,
            $this->cpriskclass,
            $this->timestamp,

            $this->cporderid
        ];

        try {
            $cpOxDb = oxDb::getDb();
            if ($cpOxDb->execute($sql, $values)) {
                $this->logger->debug(__FILE__, "Speichern der cporders erfolgreich mit OrderID " . $this->cporderid);
            } else {
                $this->logger->warn(__FILE__, "Kein Treffer in cporders mit OrderID " . $this->cporderid);
                return false;
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
        return true;
    }


    /**
     * Check if order is already linked
     *
     * @throws Exception
     * @return mixed
     */
    private function orderCheck()
    {
        try {
            $cpOxDb = oxDb::getDb();
            $cpOxDb->setFetchMode(2);
            $sql = 'SELECT OXID, OXORDERNR FROM oxorder WHERE OXID=?';
            return ($cpOxDb->getRow($sql, [$this->oxid]));
        } catch (Exception $e) {
            throw $e;
        }
    }


    /**
     * Link OxId based on OxPaymentId
     *
     * @throws Exception
     * @return void
     */
    private function linkOxId()
    {
        try {
            $cpOxDb = oxDb::getDb();
            $cpOxDb->setFetchMode(2);
            $sql = 'SELECT OXID, OXORDERNR FROM oxorder WHERE OXPAYMENTID=?';
            $result = $cpOxDb->getRow($sql, [$this->oxorderid]);
            if ($result) {
                $this->logger->debug(__FILE__, "Setze OxId: " . $result['OXID'] . " bei Bestellung " . $result['OXORDERNR']);
                $this->oxid = $result['OXID'];
                $this->oxorderid = $result['OXORDERNR'];
                $this->updateTransactionData($this->cporderid, $this->oxorderid);
            } else {
                // Try if it was a redirect payment method
                $result = $cpOxDb->getRow($sql, [$this->oxid]);
                if ($result) {
                    $this->logger->debug(__FILE__, "Setze OxId: " . $result['OXID'] . " bei Bestellung " . $result['OXORDERNR']);
                    $this->oxid = $result['OXID'];
                    $this->oxorderid = $result['OXORDERNR'];
                    $this->updateTransactionData($this->cporderid, $this->oxorderid);
                } else {
                    $this->logger->warn(__FILE__, "Keine OxId in oxorder der OrderID " . $this->cporderid . " gefunden");
                }
            }
        } catch (Exception $e) {
            throw $e;
        }
    }


    /**
     * Save additional transaction data
     *
     * @param string $data
     * @throws Exception
     * @return bool
     */
    public function saveAdditionalData(string $data)
    {
        if (empty($this->cporderid)) {
            $this->logger->warn(__FILE__, "Speichern fehlgeschlagen: keine OrderID");
            return false;
        }
        try {
            $cpOxDb = oxDb::getDb();
            $sql = "UPDATE cporders SET CPADDITIONAL=?, CPORDERUPDATE=? WHERE CPORDERID=?";

            if ($cpOxDb->execute($sql, [
                $data,
                $this->timestamp(),
                $this->cporderid
            ])) {
                return true;
            } else {
                return false;
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }

    /**
     * Save payment instrument id
     *
     * @param string $pid
     * @throws Exception
     * @return bool
     */
    public function savePaymentInstrumentId(string $pid)
    {
        if (empty($this->cporderid)) {
            $this->logger->warn(__FILE__, "Speichern fehlgeschlagen: keine OrderID");
            return false;
        }
        try {
            $cpOxDb = oxDb::getDb();
            $sql = "UPDATE cporders SET CPPID=?, CPORDERUPDATE=? WHERE CPORDERID=?";

            if ($cpOxDb->execute($sql, [
                $pid,
                $this->timestamp(),
                $this->cporderid
            ])) {
                return true;
            } else {
                return false;
            }
        } catch (Exception $e) {
            $this->logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }

    /**
     * Sets cporderid
     *
     * @param string $cporderid
     * @return crefopay_cporders
     */
    public function setOrderId(string $cporderid)
    {
        $this->cporderid = $cporderid;
        return $this;
    }

    /**
     * Converts given $time into db-update conform timestamp
     *
     * @param string $time
     * @return crefopay_cporders
     */
    public function setOrderUpdate(string $time)
    {
        $this->timestamp = date("Y-m-d H:i:s", time($time));
        return $this;
    }

    /**
     * Sez the order state
     *
     * @param string $state
     * @return crefopay_cporders
     */
    public function setOrderState($state)
    {
        $this->cporderstate = $state;
        return $this;
    }


    /**
     * Returns the current timestamp in database compatible format
     *
     * @return string
     */
    private function timestamp()
    {
        return date("Y-m-d H:i:s", time());
    }


    /**
     * set oxid order number as CrefoPay merchantReference
     *
     * @param string $cpOrderId
     * @param string $oxOrderNr
     * 
     * @throws Exception
     * @return void
     */
    private function updateTransactionData(string $cpOrderId, string $oxOrderNr)
    {
        $config = oxNew('crefoPayConfig');
        $params = $config->getApiAuth();

        $params['orderID'] = $cpOrderId;
        $params['merchantReference'] = $oxOrderNr;

        try {
            $api = oxNew('crefoPayApi');
            $response = $api->call($params, 'updateTransactionData');
            if ($this->response->resultCode != 0)
            {
                $this->logger->error(__FILE__, "Fehler bei updateTransactionData für Order ID " . $cpOrderId . ": " . $response->message . ':' . $response->errorDetails);
                throw new Exception($response->message);
            }
        } catch (Exception $e) {
            $logger->error(__FILE__, $e->getMessage());
            throw $e;
        }
    }
}
