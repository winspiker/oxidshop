<?php

use OxidEsales\Eshop\Application\Controller\FrontendController;
use OxidEsales\Eshop\Application\Model\Search;
use OxidEsales\EshopCommunity\Core\Request;
use OxidEsales\Eshop\Core\Registry;

class exonn_search_controller extends \OxidEsales\Eshop\Application\Controller\SearchController
{
    /**
     * If search was empty
     *
     * @var bool
     */
    protected $_blEmptySearch = false;

    /**
     * @throws \OxidEsales\Eshop\Core\Exception\DatabaseConnectionException
     */
    public function init()
    {
        /** @var Request $oRequest */
        $oRequest = Registry::getRequest();
        $searchRequestData = trim($oRequest->getRequestEscapedParameter('searchparam'));
        $sortRequestData = [];
        $orderBy = trim($oRequest->getRequestEscapedParameter('listorderby'));
        $order = trim($oRequest->getRequestEscapedParameter('listorder'));

        if ($orderBy) {
            $sortRequestData = [$orderBy, $order];
        }

        if (trim($oRequest->getRequestEscapedParameter('type')) === 'JSON') {
            $oSearchHandler = oxNew(Search::class);
            $this->_aArticleList = $oSearchHandler->searchArticles($searchRequestData, $sortRequestData);
            $this->_iAllArtCnt = $this->_aArticleList->count();
            return true;
        }

        FrontendController::init();

        $oConfig = Registry::getConfig();

        if (!$searchRequestData) {
            $this->_aArticleList = null;
            $this->_blEmptySearch = true;

            return false;
        }

        /** @var exonn_search $oSearchHandler */
        $oSearchHandler = oxNew(Search::class);

        $this->_aArticleList = $oSearchHandler->searchArticles($searchRequestData, $sortRequestData);
        $this->_iAllArtCnt = $this->_aArticleList->count();

        $iNrofCatArticles = (int) $oConfig->getConfigParam('iNrofCatArticles');
        $iNrofCatArticles = $iNrofCatArticles ?: 1;

        $this->_iCntPages = ceil($this->_iAllArtCnt / $iNrofCatArticles);
    }
}
