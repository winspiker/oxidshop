<?php

/**
 * EXONN Ebay article_main extends.
 *
 * @author EXONN
 */
class exonn_kaufbei_oxarticle extends exonn_kaufbei_oxarticle_parent
{

    protected $_blInNoticelist = null;
    protected $_oBadgeList = array();

    /**
     * Article Installment object.
     *
     * @var exonnkaufbei_installment|null
     */
    protected $_oInstallment = null;

    public function isArticleInNoticeList()
    {
        if ($this->_blInNoticelist===null) {
            $this->_blInNoticelist = false;


            if ($oUser = $this->getUser()) {

                if (oxDb::getDb()->getOne("
                    select a.oxid from
                        oxuserbaskets a join
                        oxuserbasketitems b on (a.oxid=b.OXBASKETID)
                    where
                        a.oxtitle = 'noticelist' and
                        a.oxuserid = ".oxDb::getDb()->quote($oUser->getId())." and
                        b.OXARTID = ".oxDb::getDb()->quote($this->getId())."
                    ")) {
                    $this->_blInNoticelist = true;
                }

            }



        }

        return $this->_blInNoticelist;
    }


    public function getBadgeHtml()
    {
        $oActions = $this->getBadgeList($this->getId());
        //$oActions->loadbadgeForArticle($this->getId());
        $res =  "";
        foreach($oActions as $oAction) {
            $res.= html_entity_decode($oAction->oxactions__badge_html->value, ENT_QUOTES, 'UTF-8');
        }

        return $res;

    }


    public function getBadgeList($sArticleId)
    {
        if ($this->_oBadgeList[$sArticleId]===null) {

            $this->_oBadgeList[$sArticleId] = oxNew("oxactionlist");
            $this->_oBadgeList[$sArticleId]->loadBadge($sArticleId);

        }

        return $this->_oBadgeList[$sArticleId];

    }




    protected $_aAllTeilFromSetArticle = null;
    protected $_aAllTeilFromSetArticleObject = null;
    protected $_blSetArticle = null;


    public function isSetArticle()
    {
        if ($this->_blSetArticle===null) {


            if (!$this->getId()) {
                $this->_blSetArticle = false;
            } else {

                if (oxDb::getDb()->getOne("select oxid from oxarticleset where oxarticleid=".oxDb::getDb()->quote($this->getId())))
                    $this->_blSetArticle = true;
                else
                    $this->_blSetArticle = false;

                // for Variant
                /* это не требуется ни в какой функции. Если это где то нужно будет то нужно сделать через параметр, так как true можно возвращать только не для parent artikle.

                if (oxDb::getDb()->getOne("select a.oxid from oxarticleset a join oxarticles b on (a.oxarticleid=b.oxid) where b.oxparentid=".oxDb::getDb()->quote($this->getId())))
                    return true;*/
            }
        }

        return $this->_blSetArticle;
    }



    public function getAllTeilFromSetArticle($returnSelf=true) // если это не setartikel то возвращается id этого артиклья
    {

        if ($this->_aAllTeilFromSetArticle===null) {

            $this->_aAllTeilFromSetArticle = array();
            $rs = oxDb::getDb()->getAll("select OXOBJECTID, setamount from oxarticleset where oxarticleid=".oxDb::getDb()->quote($this->getId()));
            foreach ($rs as $row) {
                $this->_aAllTeilFromSetArticle[$row[0]] = $row[1];
            }
            if ($returnSelf && !$this->_aAllTeilFromSetArticle) {
                $this->_aAllTeilFromSetArticle[$this->getId()] = 1;
            }
        }

        return $this->_aAllTeilFromSetArticle;
    }

    public function hasAllTeilFromSetArticleObject() // если это не setartikel то возвращается id этого артикля
    {
        if ($this->_aAllTeilFromSetArticleObject !== null && count($this->_aAllTeilFromSetArticleObject)) return true;
        $oDb = oxDb::getDb();
        return $oDb->getOne($q = "select count(a.oxid) from ".getViewName("oxarticles")." a join oxarticleset b on (a.oxid=b.OXOBJECTID) where b.oxarticleid=".oxDb::getDb()->quote($this->getId()));
    }

    public function getAllTeilFromSetArticleObject($returnSelf=true, $blLoadParentData=false) // если это не setartikel то возвращается id этого артикля
    {
        if ($this->_aAllTeilFromSetArticleObject===null) {
            $this->_aAllTeilFromSetArticleObject = oxNew("oxarticlelist");
            if ($blLoadParentData) {
                $this->_aAllTeilFromSetArticleObject->setLoadParentData(true);
            }
            $this->_aAllTeilFromSetArticleObject->selectString($q = "select a.*, b.setamount as partcount from ".getViewName("oxarticles")." a join oxarticleset b on (a.oxid=b.OXOBJECTID) where b.oxarticleid=".oxDb::getDb()->quote($this->getId()));

            if ($returnSelf && $this->_aAllTeilFromSetArticleObject->count()==0) {
                $this->_aAllTeilFromSetArticleObject->selectString($q = "select a.*, 1 as partcount from ".getViewName("oxarticles")." a where a.oxid=".oxDb::getDb()->quote($this->getId()));
            }
        }

        return $this->_aAllTeilFromSetArticleObject;
    }



    /**
     * Loads and returns array with cross selling information.
     *
     * @return array
     */
    public function getCrossSelling()
    {
        $oCrosslist = oxNew(\OxidEsales\Eshop\Application\Model\ArticleList::class);
        $oCrosslist->loadArticleCrossSell($this->oxarticles__oxid->value, $this->oxarticles__oxparentid->value);
        if ($oCrosslist->count()) {
            return $oCrosslist;
        }
    }

    /**
     * Loads and returns array with accessories information.
     *
     * @return array
     */
    public function getAccessoires()
    {
        $myConfig = $this->getConfig();

        // Performance
        if (!$myConfig->getConfigParam('bl_perfLoadAccessoires')) {
            return;
        }

        $oAcclist = oxNew(\OxidEsales\Eshop\Application\Model\ArticleList::class);
        $oAcclist->setSqlLimit(0, $myConfig->getConfigParam('iNrofCrossellArticles'));
        $oAcclist->loadArticleAccessoires($this->oxarticles__oxid->value, $this->oxarticles__oxparentid->value);

        if ($oAcclist->count()) {
            return $oAcclist;
        }
    }

    /**
     * Loads object data from DB (object data ID must be passed to method).
     * Converts dates (\OxidEsales\Eshop\Application\Model\Article::oxarticles__oxinsert)
     * to international format (oxUtils.php \OxidEsales\Eshop\Core\Registry::getUtilsDate()->formatDBDate(...)).
     * Returns true if article was loaded successfully.
     *
     * @param string $sOXID Article object ID
     *
     * @return bool
     */
    public function load($sOXID)
    {
        $load = parent::load($sOXID);
        if ($this->isInstallmentActive()) {
            $fullPrice = $this->getBasePrice();
            $this->_oInstallment = new exonnkaufbei_installment(
                $fullPrice,
                $this->getFirstPayment(),
                $this->getPaymentMonths()
            );
        }

        return $load;
    }

    /**
     * Get installment object
     *
     * @return exonnkaufbei_installment|null
     */
    public function getInstallment(): ?exonnkaufbei_installment
    {
        return $this->_oInstallment;
    }

    /**
     * Checks if the installment is active for the given article
     *
     * @return bool
     */
    public function isInstallmentActive(): bool
    {
        $fullPrice = $this->getBasePrice();
        $tooBigFirstPayment = $this->getFirstPayment() > $fullPrice;
        return ($this->getFirstPayment() !== 0.0) && ($this->getPaymentMonths() !== 0) && (!$tooBigFirstPayment);
    }

    /**
     * Get first payment value
     *
     * @return exonnkaufbei_installment|null
     */
    public function getFirstPayment(): float
    {
        return (float)$this->getFieldData('FIRSTINSTALLMENT');
    }

    /**
     * Get the number of monthly payments
     *
     * @return exonnkaufbei_installment|null
     */
    public function getPaymentMonths(): int
    {
        return (int)$this->getFieldData('NUMBERINSTALLMENTS');
    }

}
