<?php

namespace Exonn\Asum\Controller;

use Exception;
use Exonn\Asum\Core\Module;
use OxidEsales\Eshop\Application\Controller\FrontendController;
use OxidEsales\Eshop\Application\Model\Article;
use OxidEsales\Eshop\Core\DatabaseProvider;
use OxidEsales\Eshop\Core\Exception\DatabaseConnectionException;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\EshopCommunity\Core\Database\Adapter\DatabaseInterface;

class ExonnAsumAjaxController extends FrontendController
{
    /**
     * Ajax Controller für Varianten-Unique-Id
     *
     * @return void
     *
     * @throws DatabaseConnectionException
     */
    public function getVariantUri(): void
    {
        $oRequest = Registry::getRequest();

        $sArticleId = $oRequest->getRequestEscapedParameter('oxid');
        $sArticleSelId = $oRequest->getRequestEscapedParameter('selid');

        if (!$sArticleId || !$sArticleSelId || strlen($sArticleId) !== 32 || strlen($sArticleSelId) !== 32) {
            // Fehlerfall: unvollständiger / fehlerhafter request
            $this->sendJsonAndExit();
        }

        $oProduct = oxNew(Article::class);
        $oProduct->load($sArticleId);

        $aVariantSelections = $oProduct->getVariantSelections();

        $sVariantOxId = '';
        foreach ($aVariantSelections['rawselections'] as $key => $selection) {
            if ($selection[0]['hash'] === $sArticleSelId) {
                $sVariantOxId = $key;
            }
        }

        if (!$sVariantOxId) {
            // Fehlerfall: findet keine oxid zur selection
            $this->sendJsonAndExit();
        }

        $sVariantUniqueId = '';
        if (Module::USE_RANDOM_ALGORITHM) {
            $variantUniqueIdQuery =
                '
                SELECT `exonn_unique_article_id` FROM `oxarticles` WHERE `oxid` = ?;
            ';

            $oDb = DatabaseProvider::getDb(DatabaseInterface::FETCH_MODE_ASSOC);

            try {
                $sVariantUniqueId = $oDb->getOne($variantUniqueIdQuery, [$sVariantOxId]);

                if (!$sVariantUniqueId) {
                    // Fehlerfall: findet keine uniqueId zum Artikel
                    $this->sendJsonAndExit();
                }
            } catch (Exception $e) {
                // Fehlerfall: Fehler im Datenbank-Query
                $this->sendJsonAndExit();
            }
        } else {
            $sVariantUniqueId = Module::encodeOxId($sVariantOxId);
        }

        $sCurrUri = Module::generateUrl($sVariantUniqueId);

        $aUriVariants = [];
        foreach (Registry::getLang()->getLanguageArray() as $oLang) {
            $aUriVariants[$oLang->abbr] = Module::generateUrl($sVariantUniqueId, $oLang->id);
        }

        $this->sendJsonAndExit(
            [
                'currentUri' => $sCurrUri,
                'uniqueUris' => $aUriVariants,
            ],
            'ok'
        );
    }

    /**
     * Sendet eine Json-Antwort
     *
     * @param array $data
     * @param string $status
     * @return void
     */
    private function sendJsonAndExit(array $data = [], string $status = 'error'): void
    {
        Registry::getUtils()->setHeader('Content-Type: application/json; charset=utf-8');
        Registry::getUtils()->showMessageAndExit(
            json_encode([
                'data' => $data,
                'hash' => $data ? md5(json_encode($data)) : '',
                'status' => $status,
            ])
        );
    }
}
