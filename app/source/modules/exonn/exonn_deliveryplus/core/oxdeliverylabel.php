<?php

/**
 * Class oxdeliverylabel
 *
 * @property oxField oxdeliverylabels__oxid
 * @property oxField oxdeliverylabels__oxorderid
 * @property oxField oxdeliverylabels__oxartid
 * @property oxField oxdeliverylabels__oxartamount
 * @property oxField oxdeliverylabels__oxlabelid
 * @property oxField oxdeliverylabels__oxtrackcode
 * @property oxField oxdeliverylabels__oxlabelurl
 * @property oxField oxdeliverylabels__oxdocsurl
 * @property oxField oxdeliverylabels__oxlabelinfo
 * @property oxField oxdeliverylabels__oxlabelerr
 * @property oxField oxdeliverylabels__oxweight
 * @property oxField oxdeliverylabels__oxartweight
 * @property oxField oxdeliverylabels__oxcodsum
 * @property oxField oxdeliverylabels__oxdelservice
 * @property oxField oxdeliverylabels__oxlabelgroup
 * @property oxField oxdeliverylabels__oxposprice
 * @property oxField oxdeliverylabels__oxcanceled
 * @property oxField oxdeliverylabels__oxdeliveryid
 * @property oxField oxdeliverylabels__oxdocs2url
 * @property oxField oxdeliverylabels__oxmainlabelid
 * @property oxField oxdeliverylabels__oxurltype
 * @property oxField oxdeliverylabels__oxarttitle
 * @property oxField oxdeliverylabels__oxartnum
 */
class oxdeliverylabel extends oxBase
{
    /**
     * @var oxdeliverylabel[]
     */
    protected $_labelPositions = null;

    /**
     * @var oxarticle
     */
    protected $_article = null;

    /**
     * @var oxdelivery
     */
    protected $_delivery = null;

    /**
     * @var string Name of current class
     */
    protected $_sClassName = 'oxdeliverylabel';

    /**
     * Class constructor, initiates parent constructor (parent::oxBase()).
     */
    public function __construct()
    {
        parent::__construct();
        $this->init('oxdeliverylabels');
    }

    /**
     * Return oxid article.
     *
     * @return oxArticle
     */
    public function getArticle() {
        if (!$this->_article) {
            $this->_article = oxNew("oxarticle");
            $this->_article->load($this->oxdeliverylabels__oxartid->value);
        }
        return $this->_article;
    }

    /**
     * Return osdelivery.
     *
     * @return oxDelivery
     */
    public function getDelivery() {
        if (!$this->_delivery) {
            $this->_delivery = oxNew("oxdelivery");
            $this->_delivery->load($this->oxdeliverylabels__oxdeliveryid->value);
        }
        return $this->_delivery;
    }

    /**
     * Return URL to label.
     *
     * @return mixed|null
     */
    public function getLabelUrl() {
        return $this->oxdeliverylabels__oxlabelurl->value;
    }

    public function getExportDocUrl() {
        return $this->oxdeliverylabels__oxdocsurl->value;
    }

    public function getService() {
        return $this->oxdeliverylabels__oxdelservice->value;
    }

    public function getGroupId() {
        return $this->oxdeliverylabels__oxlabelgroup->value;
    }

    public function getOrderId() {
        return $this->oxdeliverylabels__oxorderid->value;
    }

    public function isCanceled() {
        return $this->oxdeliverylabels__oxcanceled->value;
    }

    public function isCancelFailed() {
        return $this->oxdeliverylabels__oxcanceled->value >= 2;
    }

    public function isCanCancelPerEmail() {
        return $this->oxdeliverylabels__oxcanceled->value == 3;
    }

    public function getNumber() {
        return $this->oxdeliverylabels__oxlabelid->value;
    }

    public function getTrackcode() {
        return $this->oxdeliverylabels__oxtrackcode->value ? $this->oxdeliverylabels__oxtrackcode->value : $this->oxdeliverylabels__oxlabelid->value;
    }

    public function getLabelErrHTML() {
        return nl2br($this->oxdeliverylabels__oxlabelerr->value);
    }

    public function getLabelInfoHTML() {
        return nl2br($this->oxdeliverylabels__oxlabelinfo->value);
    }

    public function getInfo() {
        return $this->oxdeliverylabels__oxlabelinfo->value;
    }

    public function getErr() {
        return $this->oxdeliverylabels__oxlabelerr->value;
    }

    public function getLabelErr() {
        return $this->oxdeliverylabels__oxlabelerr->value;
    }

    public function getAmount() {
        return $this->oxdeliverylabels__oxartamount->value;
    }

    public function getArtnum() {
        return $this->oxdeliverylabels__oxartnum->value;
    }

    public function getWeight() {
        return $this->oxdeliverylabels__oxartweight->value ? $this->oxdeliverylabels__oxartweight->value : $this->getArticle()->oxarticles__oxweight->value;
    }

    public function getPackageWeight() {
        $result = 0;
        foreach($this->getPositions() as $position) {
            $result += $position->getWeight() * $position->getAmount();
        }
        return $result;
    }


    /**
     * fillPackageInfo
     *
     * @param $oxartid
     * @param $oxartamount
     * @param $oxartweight
     * @param $oxposprice
     * @param $oxarttitle
     * @param $oxdeliveryid
     */
    public function fillPositionInfo($oxorderid, $oxartid, $oxartnum, $oxartamount, $oxartweight, $oxposprice, $oxarttitle, $oxdeliveryid, $oxdelservice) {
        $this->oxdeliverylabels__oxorderid = new oxField($oxorderid);
        $this->oxdeliverylabels__oxartid = new oxField($oxartid);
        $this->oxdeliverylabels__oxartnum = new oxField($oxartnum);
        $this->oxdeliverylabels__oxartamount = new oxField($oxartamount);
        $this->oxdeliverylabels__oxartweight = new oxField($oxartweight);
        $this->oxdeliverylabels__oxposprice = new oxField($oxposprice);
        $this->oxdeliverylabels__oxdeliveryid = new oxField($oxdeliveryid);
        $this->oxdeliverylabels__oxarttitle = new oxField($oxarttitle);
        $this->oxdeliverylabels__oxdelservice = new oxField($oxdelservice);
    }

    public function loadLabelByGroupId($groupId)
    {
        if ($positions = $this->getPositions($groupId)) {
            $first = array_pop($positions);
            $this->load($first->getId());
            return $this;
        }
        return false;

    }

    /**
     * Load Label-Packet positions.
     *
     * @param $labelgroupId         packet ID
     * @return oxdeliverylabel[]
     */
    public function getPositions($labelgroupId = null) {
        if (!$labelgroupId) $labelgroupId = $this->oxdeliverylabels__oxlabelgroup->value;

        if (!$this->_labelPositions) {
            $oDb = oxDb::getDb();
            $rows = $oDb->getAll($q = "SELECT oxid FROM oxdeliverylabels WHERE oxlabelgroup='" . $labelgroupId . "'");
            
            $this->_labelPositions = array();

            foreach ($rows as $row) {
                $labelArt = oxNew("oxdeliverylabel");
                $labelArt->load($row[0]);
                $this->_labelPositions[$row[0]] = $labelArt;
            }
        }

        return $this->_labelPositions;
    }

    public function getLastPositionArtNum() {
        $result = "";
        foreach($this->getPositions() as $position) {
            $result = $position->oxdeliverylabels__oxartnum->value;
        }
        return $result;
    }

    public function addPosition($position) {
        if (!$this->_labelPositions) {
            $this->_labelPositions = array();
        }

        $this->_labelPositions[] = $position;
    }

    public function removePosition($artid) {
        foreach($this->getPositions() as $key => $position) {
            if ($position->oxdeliverylabels__oxartid->value == $artid) {
                if ($position->oxdeliverylabels__oxid->value) {
                    //TODO: delete position from DB
                }
                unset($this->_labelPositions[$key]);
                break;
            }
        }
    }

    public function savePositions($updateService = false, $updateDelivery = false) {
        if (!$this->getGroupId()) {
            $newlabelgroup = new oxField(oxUtilsObject::getInstance()->generateUID());
        }
        foreach ($this->getPositions() as $position) {
            if ($newlabelgroup) {
                $position->oxdeliverylabels__oxlabelgroup = new oxField($newlabelgroup);
            }
            if ($updateService) {
                $position->oxdeliverylabels__oxdelservice = new oxField($updateService);
            }
            if ($updateDelivery) {
                $position->oxdeliverylabels__oxdeliveryid = new oxField($updateDelivery);
            }
            $position->save();
        }
    }

    public function clonePackage() {
        $newPackage = new oxdeliverylabel();
        $newPackage->fillPositionInfo(
            $this->oxdeliverylabels__oxorderid->value,
            "",
            "",
            "",
            "",
            "",
            "",
            $this->oxdeliverylabels__oxdeliveryid->value,
            $this->oxdeliverylabels__oxdelservice->value);

        foreach ($this->getPositions() as $position) {
            $newPackage->addPosition(clone $position);
        }
        return $newPackage;
    }

    public function getAmountPrice() {
        return $this->oxdeliverylabels__oxposprice->value * $this->oxdeliverylabels__oxartamount->value;
    }

    public function getPackagePrice() {
        $result = 0;
        foreach($this->getPositions() as $position) {
            $result += $position->getAmountPrice();
        }
        return $result;
    }

    /**
     * Collect information from exists label-packet.
     *
     * @param null $orderPacketsInfo
     * @return array
     */
    public function labelPositionsToPacketInfo() {
        $deliveryPackets = array();
        foreach ($this->getPositions() as $label) {
            $packetArtInfo = array();
            $packetArtInfo["oxid"] = $label->getId();
            $packetArtInfo["artid"] = $label->oxdeliverylabels__oxartid->value;
            $packetArtInfo["amount"] = $label->oxdeliverylabels__oxartamount->value;
            $packetArtInfo["weight"] = $label->oxdeliverylabels__oxartweight->value;
            $packetArtInfo["price"] = $label->oxdeliverylabels__oxposprice->value ? $label->oxdeliverylabels__oxposprice->value : $label->getArticle()->getPrice()->getPrice();
            $packetArtInfo["codsum"] = $label->oxdeliverylabels__oxcodsum->value;

            $packetArtInfo["canceled"] = $label->oxdeliverylabels__oxcanceled->value;
            $packetArtInfo["labelurl"] = $label->oxdeliverylabels__oxlabelurl->value;
            $packetArtInfo["oxdocsurl"] = $label->oxdeliverylabels__oxdocsurl->value;
            $packetArtInfo["labelerr"] = $label->oxdeliverylabels__oxlabelerr->value;
            $packetArtInfo["labelerrHTML"] = str_replace("\\n", "<br>", $label->oxdeliverylabels__oxlabelerr->value);
            $packetArtInfo["labelid"] = $label->oxdeliverylabels__oxlabelid->value;
            $packetArtInfo["trackcode"] = $label->oxdeliverylabels__oxtrackcode->value;
            $packetArtInfo["trackurl"] = $label->getTrackingUrl();
            $packetArtInfo["labelpacketid"] = $label->oxdeliverylabels__oxlabelgroup->value;
            $packetArtInfo["delservice"] = $label->oxdeliverylabels__oxdelservice->value;
            $packetArtInfo["deliveryid"] = $label->oxdeliverylabels__oxdeliveryid->value;
            $packetArtInfo["labeloxid"] = $label->getId();

            $deliveryPackets[] = $packetArtInfo;
        }

        return $deliveryPackets;
    }


    public function getTrackingUrl() {
        if ($code = ($this->oxdeliverylabels__oxtrackcode->value ? $this->oxdeliverylabels__oxtrackcode->value : $this->oxdeliverylabels__oxlabelid->value)) {
            $service = $this->oxdeliverylabels__oxdelservice->value;
            $edl = oxNew("exonn_delext_labels");
            if($client = $edl->createClient($service)) {
                return $client->getTrackingUrl($code);
            }

            /*if ($service == "dhl") {
                $url = !$this->checkDhlCodeMode($code)
                    ? "https://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=de&internationalShipment=on&idc=" . $code
                    : "https://nolp.dhl.de/nextt-online-public/set_identcodes.do?lang=de&zip=50737&idc=" . $code;
            } elseif ($service == "ups") {
                $url = "https://www.ups.com/WebTracking/processInputRequest?loc=de_DE&Requester=NES&AgreeToTermsAndConditions=yes&WT.z_eCTAid=ct1_eml_Tracking__ct1_eml_qvn_eml_resi_7del&WT.z_edatesent=11292016&tracknum=" . $code;
            } elseif ($service == "schenker") {
                $url = "https://www.ups.com/WebTracking/track?loc=de_DE";
            }*/
        }

        return "";
    }

}