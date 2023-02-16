<?php

namespace OxidEsales\EshopCommunity\Application\Model;
 
use OxidEsales\Eshop\Core\DatabaseProvider as oxDb;
use OxidEsales\Eshop\Core\Model\BaseModel;
use OxidEsales\Eshop\Core\Registry;
 
/**
 * This model represents the cporcpadditionals table in database
 */
class crefopay_cpadditionals extends BaseModel
{
    /**
     * CrefoPay additional information table
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | Field               | Type         | Null | Key | Default             | Extra |
     * +---------------------+--------------+------+-----+---------------------+-------+
     * | CPORDERID           | varchar(30)  | YES  |     | NULL                |       |
     * | CPBANKNAME          | varchar(256) | YES  |     | NULL                |       |
     * | CPBANKACCOUNTHOLDER | varchar(256) | YES  |     | NULL                |       |
     * | CPIBAN              | varchar(32)  | YES  |     | NULL                |       |
     * | CPBIC               | varchar(16)  | YES  |     | NULL                |       |
     * | CPPAYMENTREFERENCE  | varchar(16)  | YES  |     | NULL                |       |
     * | CPCREATEDAT         | timestamp    | NO   |     | CURRENT_TIMESTAMP   |       |
     * | CPLASTUPDATE        | timestamp    | NO   |     | 0000-00-00 00:00:00 |       |
     * +---------------------+--------------+------+-----+---------------------+-------+ 
     */

    /**
     * Default constructor
     */
    public function __construct() 
    {
        $this->init();
        return parent::__construct();
    }

}