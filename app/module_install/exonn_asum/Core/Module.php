<?php

namespace Exonn\Asum\Core;

use OxidEsales\Eshop\Core\Registry;

class Module
{
    public const USE_RANDOM_ALGORITHM = false;

    public static function encodeOxId(string $sOxId): string
    {
        static $aCache = [];
        if (!isset($aCache[$sOxId])) {
            $aCache[$sOxId] = BaseConvert::toBase(
                strtoupper($sOxId),
                BaseConvertAlphabet::BASE_HEX(),
                BaseConvertAlphabet::BASE_62()
            );
        }
        return $aCache[$sOxId];
    }

    public static function decodeToOxId(string $sEncoded): string
    {
        static $aCache = [];
        if (!isset($aCache[$sEncoded])) {
            $aCache[$sEncoded] = strtolower(
                str_pad(
                    BaseConvert::toBase(
                        $sEncoded,
                        BaseConvertAlphabet::BASE_62(),
                        BaseConvertAlphabet::BASE_HEX()
                    ),
                    32,
                    '0',
                    STR_PAD_LEFT
                )
            );
        }
        return $aCache[$sEncoded];
    }

    /**
     * Erzeugt eine zufällige Id anhand eines Alphabetes
     *
     * @param int $length
     * @param string $keyspace
     * @return string
     */
    public static function createRandomUniqueId(
        int $length = 8,
        string $keyspace = '0123456789abcdefghijklmnopqrstuvwxyz'
    ): string {
        if ($length < 1) {
            throw new \RangeException("Length must be a positive integer");
        }

        $pieces = [];
        $max = mb_strlen($keyspace, '8bit') - 1;
        for ($i = 0; $i < $length; ++$i) {
            try {
                $pieces [] = $keyspace[random_int(0, $max)];
            } catch (\Exception $e) {
                // handle exception
            }
        }

        return implode('', $pieces);
    }

    /**
     * @param string $sUniqueId
     * @param int|null $iLang
     * @return string
     */
    public static function generateUrl(string $sUniqueId, ?int $iLang = null): string
    {
        $sUrl = "art/{$sUniqueId}";
        $sLangShort = Registry::getLang()->getLanguageAbbr($iLang);
        if ($sLangShort !== 'de') {
            $sUrl = "{$sLangShort}/{$sUrl}";
        }
        return rtrim($sUrl, '/') . '/';
    }
}
