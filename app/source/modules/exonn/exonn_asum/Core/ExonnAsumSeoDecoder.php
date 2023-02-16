<?php
/**
 * Copyright © OXID eSales AG. All rights reserved.
 * See LICENSE file for license details.
 */

namespace Exonn\Asum\Core;

use OxidEsales\Eshop\Application\Model\Article;
use OxidEsales\Eshop\Core\Database\Adapter\DatabaseInterface;
use OxidEsales\Eshop\Core\DatabaseProvider;
use OxidEsales\Eshop\Core\Registry;

/**
 * Seo encoder base
 */
class ExonnAsumSeoDecoder extends ExonnAsumSeoDecoder_parent
{
    private $logger;

    public function __construct()
    {
        parent::__construct();
        $this->logger = Registry::getLogger();
    }

    /**
     * processSeoCall handles Server information and passes it to decoder
     *
     * @param string $sRequest request
     * @param string $sPath path
     *
     * @access public
     */
    public function processSeoCall($sRequest = null, $sPath = null)
    {
        // first - collect needed parameters
        if (!$sRequest) {
            if (isset($_SERVER['REQUEST_URI']) && $_SERVER['REQUEST_URI']) {
                $sRequest = $_SERVER['REQUEST_URI'];
            } else {
                // try something else
                $sRequest = $_SERVER['SCRIPT_URI'];
            }
        }

        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Start logging processSeoCall() method...');

        /**
         * NEUARTIGE Artikel-URi
         */
        $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);
        // falls request uri art/ enthält muss gesplittet werden um unique id zu erhalten
        if (strpos($sRequest, 'art/') !== false) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Neuartige ankommende URI erkannt...(art/): ' . $sRequest);

            $oConfig = $this->getConfig();
            $shopId = $oConfig->getShopId();

            $oLang = Registry::getLang();
            $langId = $oLang->getEditLanguage();

            $sRequest = explode('?', $sRequest, 2)[0] ?? $sRequest;
            $aModifiedRequest = explode('/', trim($sRequest, '/'));
            $sUniqueId = $aModifiedRequest[count($aModifiedRequest) - 1];

            $blUseFallback = true;
            $sOxId = '';
            if (strlen($sUniqueId !== 8)) {
                $sOxId = Module::decodeToOxId($sUniqueId);
                $oArticle = oxNew(Article::class);
                $blUseFallback = !$oArticle->load($sOxId);
            }

            if ($blUseFallback) {
                // wenn unique ID keine unique ID ist...
                if (strlen($sUniqueId) === 8 && !ctype_alnum($sUniqueId)) {
                    $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Unique ID entspricht nicht der Richtlinie und kommt nicht vom System!');
                    error_404_handler();
                }

                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Request array, unique id detected: ' . $sUniqueId);

                // über unique id muss object id ermittelt werden
                $articleOxidQuery =
                    '
                    SELECT `oxid` FROM `oxarticles` where `exonn_unique_article_id` = ?;
                ';

                $sOxId = $oDb->getOne($articleOxidQuery, [$sUniqueId]);
                if (!$sOxId) {
                    $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Unique id (' . $sUniqueId . ') hat keinen Artikel!?!?');
                    error_404_handler();
                }

                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Artikel zu Unique id (' . $sUniqueId . '): ' . $sOxId);

                Registry::getUtils()->redirect(
                    rtrim($this->getConfig()->getShopURL(), '/') . '/' . Module::generateUrl(Module::encodeOxId($sOxId), $langId),
                    false,
                    301
                );
            }

            // zuerst prüfen, ob bereits eine URL mit unique ID besteht...
            $articleSeoQuery =
                '
				SELECT * FROM `oxseo` WHERE `oxobjectid` = ? AND oxlang = ? AND `oxshopid` = ? AND `oxseourl` LIKE ? AND `oxexpired` = 0;
			';

            $sGuessedSeoUrl = "%art/{$sUniqueId}%";

            $articleSeoData = $oDb->getAll($articleSeoQuery, [$sOxId, $langId, $shopId, $sGuessedSeoUrl]);

            // falls nicht eine vorhandene URL zum Artikel suchen
            if (empty($articleSeoData)) {
                // über objekt id, sprachid, shopid muss uri ermittelt werden
                $articleSeoQuery =
                    '
					SELECT * FROM `oxseo` WHERE `oxobjectid` = ? AND `oxlang` = ? AND `oxshopid` = ? AND `oxexpired` = 0;
				';

                $articleSeoData = $oDb->getAll($articleSeoQuery, [$sOxId, $langId, $shopId]);
                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Article URi was taken from available ones');
            }

            // wenn sich herausstellt, dass die angeforderte neue URi
            // der hinterlegten URi entspricht
            // TODO: ggf anders behandeln
            if ($articleSeoData[0]['OXSEOURL'] !== ltrim($sRequest, '/')) {
                $_GET['cl'] = 'details';
                $_GET['anid'] = $sOxId;

                /**
                 * Haupt KATEGORIE AUSLESEN
                 */
                $_GET['cnid'] = $articleSeoData['OXPARAMS'] ?? $articleSeoData['oxparams'];

                Registry::getLang()->resetBaseLanguage();
            }
        }
        /**
         * HERKÖMMLICHE Artikel-URi
         */
        elseif (strpos($sRequest, ".html") !== false) {
            // alte URLS umleiten mit 301 auf neue url
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Alte URi erkannt...wird auf typ geprüft...');

            // falls ein leading
            if (substr($sRequest, 0, 1) == "/") {
                $sRequest = substr($sRequest, 1);
            }

            // todo: prüfen ob hier die falsche seo url ausgelesen wird...
            $oldUriRequest =
                '
				SELECT * FROM `oxseo` WHERE `oxseourl` = ?;
			';

            try {
                $oldUriData = $oDb->getAll($oldUriRequest, [$sRequest]);
            } catch (\Throwable $e) {
                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Database issue: ' . $e->getMessage());
            }


            if ($oldUriData) {
                // wenn alte Daten gefunden wurden, gibt es noch keine unique id am artikel
                // dies muss alles erzeugt werden und dann die urls gehandled...
                $currentArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
                $currentArticle->load($oldUriData[0]['OXOBJECTID']);
                // neuen artikel erstellen
                $currentEncoderArticle = oxNew(\Exonn\Asum\Model\ExonnAsumSeoEncoderArticle::class);

                // url erzeugungs methode aufrufen
                $newUri = $currentEncoderArticle->getArticleUri($currentArticle, $oldUriData[0]['oxlang'] ?? $oldUriData[0]['OXLANG']);

                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Alte URi daten gefunden...leite auf neue URi um: ' . $newUri);


                Registry::getUtils()->redirect($this->getConfig()->getShopURL() . $newUri, false, 301);
            } else {
                Registry::getUtils()->redirect($this->getConfig()->getShopURL(), false, 404);
            }

            $newUriRequest =
                '
				SELECT * FROM oxseo WHERE oxobjectid = ? and oxlang = ? and oxshopid = ?
			';

            $newUriData = $oDb->getAll($newUriRequest, [$oldUriData[0]['OXOBJECTID'], $oldUriData[0]['OXLANG'], $oldUriData[0]['OXSHOPID']]);

            if ($newUriData) {
                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Leite auf neue URI um...');
                Registry::getUtils()->redirect($this->getConfig()->getShopURL() . $newUriData[0]['OXSEOURL'], false, 301);
            } else {
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Neue Uri hat keinen Tabelleneintrag !?!?!?');
                // TODO: what todo here ???
            }

        }
        /**
         * ANDERE URi
         */
        elseif (count(explode('/', $sRequest)) == 2) {
            if (substr($sRequest, 0, 1) == "/") {
                $sRequest = substr($sRequest, 1);
            }

            $netDataQuery =
                '
				SELECT oxsource, oxtarget FROM netredirectmanager WHERE oxsource = ?
			';

            $netDataResult = $oDb->getAll($netDataQuery, [$sRequest])[0];

            if (is_array($netDataResult) && count($netDataResult) > 0) {
                // todo: prüfen ob hier die falsche seo url ausgelesen wird...
                $oldUriRequest =
                    '
					SELECT * FROM oxseo WHERE oxseourl = ?
				';

                try {
                    $oldUriData = $oDb->getAll($oldUriRequest, [$sRequest]);
                } catch (\Throwable $e) {
                    $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Database issue: ' . $e->getMessage());
                }

                if ($oldUriData) {
                    // wenn alte Daten gefunden wurden, gibt es noch keine unique id am artikel
                    // dies muss alles erzeugt werden und dann die urls gehandled...
                    $currentArticle = oxNew(\OxidEsales\Eshop\Application\Model\Article::class);
                    $currentArticle->load($oldUriData[0]['OXOBJECTID']);
                    // neuen artikel erstellen
                    $currentEncoderArticle = oxNew(\Exonn\Asum\Model\ExonnAsumSeoEncoderArticle::class);

                    // url erzeugungs methode aufrufen
                    $newUri = $currentEncoderArticle->getArticleUri($currentArticle, $oldUriData[0]['oxlang'] ?? $oldUriData[0]['OXLANG']);

                    $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Alte URi daten gefunden...leite auf neue URi um: ' . $newUri);

                    Registry::getUtils()->redirect($this->getConfig()->getShopURL() . $newUri, false, 301);
                    exit(0);

                }
            }
        }

        /**
         * ALTES SYSTEM, wird zusätzlich angewendet!
         */
        $sPath = $sPath ?: str_replace('oxseo.php', '', $_SERVER['SCRIPT_NAME']);

        if (($sParams = $this->_getParams($sRequest, $sPath))) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] PARAMETER check: ' . print_r($sParams, 1));
            // in case SEO url is actual
            if (is_array($aGet = $this->decodeUrl($sParams))) {
                $_GET = array_merge($aGet, $_GET);

                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] FULL PARAMETER check: ' . print_r($_GET, 1));
                Registry::getLang()->resetBaseLanguage();
            } elseif (strpos($sParams, 'art/' . $sUniqueId) && ($sRedirectUrl = $this->_decodeOldUrl($sParams))) {
                // in case SEO url was changed - redirecting to new location
                $this->logger->debug(__FILE__ . ' [' . __LINE__ . '] Trying to redirect to new location....');
                Registry::getUtils()->redirect($this->getConfig()->getShopURL() . $sRedirectUrl, false, 301);
            } elseif (($sRedirectUrl = $this->_decodeSimpleUrl($sParams))) {
                // old type II seo urls
                $this->logger->debug(__FILE__ . ' [' . __LINE__ . '] Trying old type II SEO Url redirect...');
                Registry::getUtils()->redirect($this->getConfig()->getShopURL() . $sRedirectUrl, false, 301);
            } else {

                Registry::getSession()->start();

                if (!$aModifiedRequest) {
                    // unrecognized url
                    error_404_handler($sParams);
                }
            }
        }
    }

    /**
     * decodeUrl decodes given url into oxid eShop required parameters which are returned as array
     *
     * @param string $seoUrl SEO url
     *
     * @access        public
     * @return array || false
     */
    public function decodeUrl($seoUrl)
    {
        if (strpos($seoUrl, 'art/') !== false) {
            $uniqueArticleSeoUrlQuery =
                '
				SELECT * FROM `oxseo` WHERE `oxseourl` LIKE ?;
			';
            $oDB = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);

            $uniqueArticleSeoUrlData = $oDB->getAll($uniqueArticleSeoUrlQuery, ["{$seoUrl}%"]);

            if (!empty($uniqueArticleSeoUrlData)) {
                $aUrlParameters = $this->parseStdUrl($uniqueArticleSeoUrlData[0]['OXSTDURL']);
                $aUrlParameters['lang'] = $uniqueArticleSeoUrlData[0]['OXLANG'];
                // $aUrlParameters['listtype'] = "article";

                return $aUrlParameters;
            }

        }

        return parent::decodeUrl($seoUrl);
    }
}
