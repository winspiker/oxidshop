<?php

namespace Exonn\Asum\Model;

use Exception;
use Exonn\Asum\Core\Module;
use OxidEsales\Eshop\Application\Model\Article;
use OxidEsales\Eshop\Core\Database\Adapter\DatabaseInterface;
use OxidEsales\Eshop\Core\DatabaseProvider;
use OxidEsales\Eshop\Core\Exception\DatabaseConnectionException;
use OxidEsales\Eshop\Core\Exception\DatabaseErrorException;
use OxidEsales\Eshop\Core\Registry;
use Throwable;

class ExonnAsumSeoEncoderArticle extends ExonnAsumSeoEncoderArticle_parent
{
    protected $logger;

    /**
     * Returns target "extension" (.html)
     *
     * @return string
     */
    protected function _getUrlExtension(): string
    {
        return '/';
    }

    public function __construct()
    {
        parent::__construct();
        $this->logger = Registry::getLogger();
    }


    /**
     * 2 Wege sind notwendig um neue URIs zu implementieren
     *
     * 1. Beim auslesen der Links zu Artikeln
     * 2. Bei Anfragen muss die URI überprüft werden
     *
     * Hier wird Ansatz 1 umgesetzt...
     *
     *
     * für ansatz 2...
     *
     * // url schema schnellüberprüfung auf neues format
     * // ist die angeforderte URL im neuen format?
     * // neues format zeichnet sich durch  "art/" aus
     * // falls url nach dem neuen format angefordert und
     * // gefunden wurde
     * // -> diese zurück geben
     * // nicht gefunden wurde
     * // -> weitermachen...weil noch altes format angefragt und hinterlegt ist
     */

    /**
     * @inheritDoc
     */
    public function getArticleUri($oArticle, $iLang, $blRegenerate = false): string
    {
        $sGenerationFn = Module::USE_RANDOM_ALGORITHM
            ? [$this, 'getRandomArticleUri']
            : [$this, 'getEncodedArticleUri'];
        return call_user_func($sGenerationFn, $oArticle, $iLang)
            ?: parent::getArticleUri($oArticle, $iLang, $blRegenerate);
    }

    /**
     * _loadFromDb loads data from oxseo table if exists
     * returns oxseo url
     *
     * @param string $sType object type
     * @param string $sId object identifier
     * @param int $iLang active language id
     * @param mixed $iShopId active shop id
     * @param null $sParams additional seo params. optional (mostly used for db indexing)
     * @param bool $blStrictParamsCheck strict parameters check
     *
     * @return string|false
     * @throws DatabaseConnectionException
     * @throws DatabaseErrorException
     */
    protected function _loadFromDb($sType, $sId, $iLang, $iShopId = null, $sParams = null, $blStrictParamsCheck = true)
    {
        if ($iShopId === null) {
            $iShopId = $this->getConfig()->getShopId();
        }

        $iLang = (int)$iLang;
        $oDb = DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC);

        $sQ = "
            SELECT
                `oxfixed`,
                `oxseourl`,
                `oxexpired`,
                `oxtype`
            FROM `oxseo`
            WHERE `oxtype` = " . $oDb->quote($sType) . "
               AND `oxobjectid` = " . $oDb->quote($sId) . "
               AND `oxshopid` = " . $oDb->quote($iShopId) . "
               AND `oxlang` = '{$iLang}'";

        $sParams = $sParams ?: '';
        if ($sParams && $blStrictParamsCheck) {
            $sQ .= " ORDER BY oxfixed DESC";
        } else {
            $sQ .= " ORDER BY `oxparams` ASC";
        }
        $sQ .= " LIMIT 1";

        // caching to avoid same queries..
        $sIdent = md5($sQ);

        // looking in cache
        if (($sSeoUrl = $this->_loadFromCache($sIdent, $sType, $iLang, $iShopId, $sParams)) === false) {
            // wenn EXONN ARTICLE SEO cache nicht gesetzt, aus DB auslesen
            $oRs = $oDb->select($sQ);

            if ($oRs && $oRs->count() > 0 && !$oRs->EOF) {
                // moving expired static urls to history ..
                if (!$oRs->fields['oxexpired'] || $oRs->fields['oxfixed']) {
                    // if seo url is available and is valid
                    $sSeoUrl = $oRs->fields['oxseourl'];
                }

                // storing in cache
                $this->_saveInCache($sIdent, $sSeoUrl, $sType, $iLang, $iShopId, $sParams);
            }
        }

        return $sSeoUrl;
    }

    /**
     * @param $sArticleOxId
     * @param null $iLang
     * @return ?string
     * @throws DatabaseConnectionException
     */
    protected function getUniqueUriByArticle($sArticleOxId, $iLang = null): ?string
    {
        $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);

        $shopId = $this->getConfig()->getShopId();


        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Trying to get uniqueId for articleId: ' . print_r($sArticleOxId, 1) . " iLang: " . $iLang);

        // seo tabelle auf uri prüfen
        $seoQuery =
            '
			SELECT `oxseourl` FROM `oxseo` WHERE `oxobjectid` = ? AND `oxlang` = ? AND `oxshopid` = ?;
		';

        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] seoQuery: SELECT oxseourl FROM oxseo where oxobjectid = ' . $sArticleOxId . ' and oxlang = ' . $iLang . ' and oxshopid = ' . $shopId . '');


        $seoResult = $oDb->getOne($seoQuery, [$sArticleOxId, $iLang, $shopId]);

        if (!$seoResult) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] seoResult: ' . print_r($seoResult, 1));
        }

        // wenn neue uri erkannt wurde, diese zurückgeben
        if ($seoResult && strpos($seoResult, 'art/') !== false) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] neue URi bereits vorhanden...');
            return $seoResult;
        }
        // falls alte oder keine uri erkannt wurde, false zurückgeben
        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] No new URi was detected for this request --> articleId: ' . print_r($sArticleOxId, 1) . " --> iLang: " . print_r($iLang, 1));
        return null;
    }

    /**
     * @throws DatabaseErrorException
     * @throws DatabaseConnectionException
     */
    protected function createUniqueUri(Article $oArticle, $sUniqueId, $iLang)
    {
        $sArticleOxId = $oArticle->getId();
        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] creating unique URi for article: ' . print_r($sArticleOxId, 1) . " --> uniqueId: " . $sUniqueId . " --> iLang: " . $iLang);

        // Wenn diese Funktion aufgerufen wird, wissen wir bereits, dass
        // bisher keine uniqueId vorhande ist am Artikel und somit
        // auch keine neue URI
        $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);

        // nur neue id erzeugen, falls artikel noch keine hat
        if (!$sUniqueId) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] article has no unique id, yet...');
            // so lange neue ID erzeugen, bis einzigartigkeit verifiziert wurde
            $isIdUniqueResult = true;
            while ($isIdUniqueResult) {
                // erstelle unique id
                $sUniqueId = Module::createRandomUniqueId();
                // prüfe, ob id wirklich unique
                $isIdUniqueQuery =
                    '
					SELECT `exonn_unique_article_id` FROM `oxarticles` WHERE `exonn_unique_article_id` = :uniqueId;
				';

                try {
                    $isIdUniqueResult = $oDb->getOne($isIdUniqueQuery, [":uniqueId" => $sUniqueId]);
                } catch (Throwable $e) {
                    $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] ' . $e->getMessage());
                }
            }

            // unique ID am Artikel speichern
            $saveUniqueIdOnArticleQuery =
                '
				UPDATE `oxarticles` SET `exonn_unique_article_id` = ? WHERE `oxid` = ?;
			';

            try {
                $iSaveUniqueIdOnArticleResult = $oDb->execute($saveUniqueIdOnArticleQuery, [$sUniqueId, $sArticleOxId]);
            } catch (Throwable $e) {
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . ']  New unique id (' . $sUniqueId . ") for article (" . $sArticleOxId . ") NOT SAVED!!!");
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . ']  Reason: ' . print_r($e->getMessage(), 1));
                return false;
            }

            if (!$iSaveUniqueIdOnArticleResult) {
                // log unique id not saved...
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . ']  New unique id (' . $sUniqueId . ") for article (" . $sArticleOxId . ") NOT SAVED!!!");

                $aBacktrace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS, 10);
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Backtrace: ' . print_r($aBacktrace, 1));

                return null;
            } else {
                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] New unique id (' . $sUniqueId . ") for article " . $sArticleOxId . " saved...");
            }
        }
        return $this->maybeUpdateSeoRecords($oArticle, $sUniqueId, $iLang);
    }

    /**
     * @param $oArticle
     * @param int $iLang
     * @return string
     * @throws DatabaseConnectionException
     * @throws DatabaseErrorException
     */
    private function getRandomArticleUri($oArticle, int $iLang): string
    {
        static $aCache = [];
        /**
         * START Unique SEO Article URIs
         */
        // unique id von artikel lesen, zur not erzeugen wenn nicht vorhanden
        $articleId = $oArticle->getId();
        $sCacheKey = "{$articleId}:{$iLang}";
        if (isset($aCache[$sCacheKey])) {
            return $aCache[$sCacheKey];
        }

        // Artikel und ArtikelID überprüfen
        if (!is_object($oArticle) || empty($articleId)) {
            $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Article is no object or oxid of article is empty.');
        }

        $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);

        // auch Varianten bekommen einen eigenen unique link

        // query für varianten
        $articleVariantsQuery =
            '
			SELECT `oxid` FROM `oxarticles` WHERE `oxparentid` = ?;
		';

        $articleId = $oArticle->getId();
        $articleOxidStack = array_merge(
            [$articleId],
            array_column($oDb->getAll($articleVariantsQuery, [$articleId]), 'oxid')
        );

        $newArticleUri = [];
        $aUri = [];

        $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Articlestack including variants: ' . print_r($articleOxidStack, 1));

        foreach ($articleOxidStack as $articleOxid) {
            $oArticle = oxNew(Article::class);
            $oArticle->load($articleOxid);

            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] Trying to get uniqueId for articleId: ' . print_r($articleOxid, 1));

            $articleUniqueIdQuery =
                '
				SELECT `exonn_unique_article_id` FROM `oxarticles` where `oxid` = ?;
			';

            $articleUniqueIdResult = '';
            try {
                $articleUniqueIdResult = $oDb->getOne($articleUniqueIdQuery, [$articleOxid]);
            } catch (Exception $e) {
                $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] illegal database request: ' . $e->getMessage());
            }

            // falls der Artikel bereits eine uniqueId besitzt, prüfen, ob neue
            // URI bereits vorhanden (sprachen etc...)
            if ($articleUniqueIdResult) {
                $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] article already has unique id: ' . print_r($articleUniqueIdResult, 1) . " iLang: " . $iLang);

                // wenn unique id vorhanden ist
                $newArticleUri[$articleOxid] = $this->getUniqueUriByArticle($articleOxid, $iLang);
            }

            if ($articleUniqueIdResult && !$newArticleUri[$articleOxid]) {
                $this->logger->info(basename(__FILE__) . ' [' . __LINE__ . '] Article does not have a unique URi yet, but already has a unique id: ' . print_r($articleUniqueIdResult, 1));
            }

            // falls neue uri nicht verfügbar, muss diese erstellt werden
            if (!isset($newArticleUri[$articleOxid])) {
                $this->logger->info(basename(__FILE__) . ' [' . __LINE__ . '] creating new unique uri for this article...');
                $aUri[$articleOxid] = $this->createUniqueUri($oArticle, $articleUniqueIdResult, $iLang);
            }
        }

        if (isset($aUri[$articleId])) {
            $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] New unique URi created: ' . json_encode($aUri));
            $aCache[$sCacheKey] = $aUri[$articleId];
            return $aUri[$articleId];
        }

        return '';
    }

    /**
     * Mathematische Artikel-ID Konvertierung
     *
     * @param Article $oArticle
     * @param int|null $iLang
     * @return string
     * @throws DatabaseErrorException
     * @throws DatabaseConnectionException
     */
    private function getEncodedArticleUri(Article $oArticle, ?int $iLang = null): string
    {
        if ($oArticle->getId()) {
            return $this->maybeUpdateSeoRecords(
                $oArticle,
                Module::encodeOxId($oArticle->getId()),
                $iLang
            );
        }
        return '';
    }

    /**
     * @throws DatabaseErrorException
     * @throws DatabaseConnectionException
     */
    private function maybeUpdateSeoRecords(
        Article $oArticle,
        string  $sUniqueId,
        ?int    $langId
    ): ?string {
        $shopId = Registry::getConfig()->getShopId();

        // zuerst prüfen ob bereits eine URL mit unique ID besteht...
        $sGuessedArticleSeoQuery =
            '
			SELECT * FROM `oxseo` WHERE `oxobjectid` = :object AND `oxlang` = :lang AND `oxshopid` = :shop AND `oxseourl` LIKE :url AND `oxexpired` = 0;
		';

        $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);
        $aGuessedArticleSeoData = $oDb->getAll(
            $sGuessedArticleSeoQuery,
            [
                ':object' => $oArticle->getId(),
                ':lang' => $langId,
                ':shop' => $shopId,
                ':url' => "%art/{$sUniqueId}%",
            ]
        );

        if ($aGuessedArticleSeoData) {
            $sSeoUrl = $aGuessedArticleSeoData[0]['OXSEOURL'];
            if (
                8 === strlen($sSeoUrl)
                || Module::encodeOxId($oArticle->getId()) === $sUniqueId
            ) {
                $this->logger->info(basename(__FILE__) . ' [' . __LINE__ . '] Found existing NEW SEO URi...returning SEOURL...');
                return $sSeoUrl;
            }
        }

        // hole passenden SEO Eintrag zum Artikel
        $sArticleSeoQuery =
            '
				SELECT * FROM `oxseo` WHERE `oxobjectid` = :object AND `oxlang` = :lang AND `oxshopid` = :shop AND `oxexpired` = 0;
			';

        $aArticleSeoData = $oDb->getAll(
            $sArticleSeoQuery,
            [
                ':object' => $oArticle->getId(),
                ':lang' => $langId,
                ':shop' => $shopId,
            ]
        );

        $sStdUrl = '';
        $sParams = '';
        if ($aArticleSeoData) {
            // jeder Eintrag muss in die History übertragen werden
            foreach ($aArticleSeoData as $aSeoDataRow) {
                // Standard URL und PARAMS aus original Eintrag nehmen
                $sStdUrl = $aSeoDataRow['OXSTDURL'];
                $sParams = $aSeoDataRow['OXPARAMS'];

                // hier muss in die oxseohistory übertragen werden....
                $historyQuery =
                    '
					INSERT INTO `oxseohistory` (`oxobjectid`, `oxident`, `oxshopid`, `oxlang`, `oxhits`, `oxinsert`)
					    VALUES (:object, :ident, :shop, :lang, :hits, now())
					    ON DUPLICATE KEY UPDATE `oxlang` = VALUES(`oxlang`), `oxhits` = VALUES(`oxhits`), `oxinsert` = VALUES(`oxinsert`) 			
				';

                try {
                    $oDb->startTransaction();
                    $oDb->execute(
                        $historyQuery,
                        [
                            ':object' => $oArticle->getId(),
                            ':ident' => $aSeoDataRow['OXIDENT'],
                            ':shop' => $shopId,
                            ':lang' => $langId,
                            ':hits' => 1,
                        ]
                    );

                    // wenn erfolgreich übertragen wurde, originaleintrag löschen
                    $this->logger->debug(basename(__FILE__) . ' [' . __LINE__ . '] updating original entry after moving it to oxseo table...');

                    $seoUpdateQuery =
                        '
						UPDATE `oxseo` SET `oxexpired` = 1 WHERE `oxobjectid` = :object AND `oxlang` = :lang AND `oxshopid` = :shop AND `oxident` = :ident;
					';

                    $oDb->execute(
                        $seoUpdateQuery,
                        [
                            ':object' => $oArticle->getId(),
                            ':lang' => $langId,
                            ':shop' => $shopId,
                            ':ident' => $aSeoDataRow['OXIDENT'],
                        ]
                    );

                    $oDb->commitTransaction();
                } catch (Throwable $e) {
                    $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] Fehler beim Speichern in `oxseohistory` oder Löschen in `oxseo`: ' . $e->getMessage());
                    // TODO: what todo with exception here???
                }
            }
        }

        $oCategory = $oArticle->getCategory();
        $sCategoryId = $oCategory ? $oCategory->getId() : '';

        if (!$sStdUrl) {
            $sStdUrl = 'index.php?' . http_build_query(
                [
                    'cl' => 'details',
                    'anid' => $oArticle->getId(),
                    'cnid' => $sCategoryId
                ],
                '',
                '&amp;'
            );
        }

        $sSeoUrl = Module::generateUrl($sUniqueId, $langId);

        // Neuen SEO Eintrag erzeugen
        $insertNewSeoLinkQuery =
            '
            INSERT INTO `oxseo` (`oxobjectid`, `oxident`, `oxshopid`, `oxlang`, `oxstdurl`, `oxseourl`, `oxtype`, `oxfixed`, `oxexpired`, `oxparams`)
                VALUES (:object, :ident, :shop, :lang, :stdurl, :seourl, :type, :fixed, :expired, :params)
                ON DUPLICATE KEY UPDATE oxobjectid = VALUES(oxobjectid), oxstdurl = VALUES(oxstdurl), oxseourl = VALUES(oxseourl), oxtype = VALUES(oxtype), oxfixed = VALUES(oxfixed), oxexpired = VALUES(oxexpired), oxparams = VALUES(oxparams)
        ';

        try {
            $aParams = [
                ':object' => $oArticle->getId(),
                ':ident' => md5($sSeoUrl),
                ':shop' => $shopId,
                ':lang' => $langId ?? Registry::getLang()->getObjectTplLanguage(),
                ':stdurl' => $sStdUrl,
                ':seourl' => $sSeoUrl,
                ':type' => 'oxarticle',
                ':fixed' => 1,
                ':expired' => 0,
                ':params' => $sParams ?: $sCategoryId ?: '',
            ];
            $oDb->execute($insertNewSeoLinkQuery, $aParams);
            return $sSeoUrl;
        } catch (Throwable $e) {
            $this->logger->error(basename(__FILE__) . ' [' . __LINE__ . '] ' . $e->getMessage());
            // TODO: what todo with exception???
            // TODO: possible reroll required??? or failsafe values...
        }
        return null;
    }
}
