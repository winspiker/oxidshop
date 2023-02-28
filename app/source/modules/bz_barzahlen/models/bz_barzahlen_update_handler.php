<?php
/**
 * Barzahlen Payment Module (OXID eShop)
 *
 * @copyright   Copyright (c) 2015 Cash Payment Solutions GmbH (https://www.barzahlen.de)
 * @author      Alexander Diebler
 * @license     http://opensource.org/licenses/GPL-3.0  GNU General Public License, version 3 (GPL-3.0)
 */

/**
 * Model to handle updates of transactions and refunds.
 */
class bz_barzahlen_update_handler extends oxSuperCfg
{
    /**
     * Transaction status codes.
     */
    const STATE_PENDING = "pending";
    const STATE_PAID = "paid";
    const STATE_EXPIRED = "expired";
    const STATE_REFUND_COMPLETED = "refund_completed";
    const STATE_REFUND_EXPIRED = "refund_expired";

    /**
     * Log file
     */
    const LOGFILE = "barzahlen.log";

    /**
     * Module identifier
     *
     * @var string
     */
    protected $_sModuleId = "bz_barzahlen";

    /**
     * Module identifier
     *
     * @var string
     */
    protected $_sShopId;

    /**
     * Module identifier
     *
     * @var string
     */
    protected $_sNotificationKey;

    /**
     * Notification object.
     *
     * @var Barzahlen_Notification
     */
    private $_oNotification;

    /**
     * Gets the requested order from the database.
     */
    public function __construct()
    {
        $oxConfig = $this->getConfig();
        $sShopId = $oxConfig->getShopId();
        $sModule = oxConfig::OXMODULE_MODULE_PREFIX . $this->_sModuleId;

        $this->_sShopId = $oxConfig->getShopConfVar('bzShopId', $sShopId, $sModule);
        $this->_sNotificationKey = $oxConfig->getShopConfVar('bzNotificationKey', $sShopId, $sModule);
    }

    /**
     * Creates the notification object and checks the received data.
     *
     * @param array $aData request data
     * @return boolean
     */
    public function checkData(array $aData)
    {
        $this->_oNotification = new Barzahlen_Notification($this->_sShopId, $this->_sNotificationKey, $aData);

        try {
            $this->_oNotification->validate();
        } catch (Exception $e) {
            $this->_logIpnError("Notification failed: " . $e);
        }

        return $this->_oNotification->isValid();
    }

    /**
     * Returns the notification state.
     *
     * @return string
     */
    public function getState()
    {
        return $this->_oNotification->getState();
    }

    /**
     * Looks up and updates orders for payment notifications.
     *
     * @return boolean
     */
    public function updatePayment()
    {
        $oOrder = $this->_getOrder();

        if ($this->_oNotification->getOrderId() != null && $oOrder->oxorder__oxordernr->value != $this->_oNotification->getOrderId()) {
            $this->_logIpnError("Order ID not valid for " . $this->_oNotification->getTransactionId());
            return false;
        }

        if ($oOrder->oxorder__bzstate->value != self::STATE_PENDING) {
            $this->_logIpnError("Unable to change state of transaction " . $this->_oNotification->getTransactionId());
            return false;
        }

        if ($this->_oNotification->getState() == self::STATE_PAID) {
            $oOrder->oxorder__oxpaid->setValue(date("Y-m-d H:i:s", time()));
        } elseif ($this->_oNotification->getState() == self::STATE_EXPIRED) {
            $oOrder->cancelOrder();
        }

        $oOrder->oxorder__bzstate = new oxField($this->_oNotification->getState());
        $oOrder->save();
        return true;
    }

    /**
     * Looks up and updates orders for refund notifications.
     *
     * @return boolean
     */
    public function updateRefund()
    {
        $oOrder = $this->_getOrder();

        if ($this->_oNotification->getOriginOrderId() != null && $oOrder->oxorder__oxordernr->value != $this->_oNotification->getOriginOrderId()) {
            $this->_logIpnError("Order ID not valid for " . $this->_oNotification->getRefundTransactionId());
            return false;
        }

        $aRefunds = unserialize(str_replace("&quot;", "\"", $oOrder->oxorder__bzrefunds->value));

        foreach ($aRefunds as $iKey => $aRefund) {

            if ($aRefund['refundid'] == $this->_oNotification->getRefundTransactionId()) {

                if ($aRefund['state'] != self::STATE_PENDING) {
                    $this->_logIpnError("Unable to change state of refund " . $this->_oNotification->getRefundTransactionId());
                    return false;
                }

                $aRefunds[$iKey]['state'] = str_replace("refund_", "", $this->_oNotification->getState());
                $oOrder->oxorder__bzrefunds = new oxField(serialize($aRefunds));
                $oOrder->save();
                return true;
            }
        }
        $this->_logIpnError("Refund not found for given ID: " . $this->_oNotification->getRefundTransactionId());
        return false;
    }

    /**
     * Grabs the requested order from the database.
     *
     * @return oxOrder
     */
    protected function _getOrder()
    {
        $sTransaction = $this->_oNotification->getTransactionId() != null ? $this->_oNotification->getTransactionId() : $this->_oNotification->getOriginTransactionId();

        //exonn
        $sOxid = oxDb::getDb()->getOne("SELECT OXID FROM oxorder WHERE BZTRANSACTION = '" . $sTransaction . "'");
        $oOrder = oxNew("oxorder");
        $oOrder->load($sOxid);

        return $oOrder;
    }

    /**
     * Logs error message along with the received data.
     *
     * @param string $message
     */
    protected function _logIpnError($sMessage)
    {
        $sMessage .= ' ' . serialize($this->_oNotification->getNotificationArray());
        oxRegistry::getUtils()->writeToLog(date('c') . ' ' . $sMessage . "\r\r", self::LOGFILE);
    }
}
