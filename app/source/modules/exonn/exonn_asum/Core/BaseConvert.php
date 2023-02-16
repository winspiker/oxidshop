<?php

namespace Exonn\Asum\Core;


/**
 * Konvertiert Zahlensysteme
 */
class BaseConvert
{
    /**
     * Konvertiert eine beliebige Nummer zum Dezimalsystem
     *
     * @param string $sNum
     * @param BaseConvertAlphabet $oAlphabet
     * @return string
     */
    protected static function toDec(string $sNum, BaseConvertAlphabet $oAlphabet): string
    {
        $aNum = str_split($sNum, 1);
        $sResult = '0';
        $iLength = strlen($sNum);
        $iBase = strlen($oAlphabet);
        for ($iNum = 0; $iNum < $iLength; $iNum++) {
            $sChar = array_pop($aNum);
            $sResult = bcadd($sResult, bcmul(strpos($oAlphabet, $sChar), bcpow($iBase, $iNum)));
        }
        return $sResult;
    }

    /**
     * Konvertiert eine Nummer in einem beliebigen System zu einem anderen beliebigen System
     *
     * @param string $sNum
     * @param BaseConvertAlphabet $oFromAlphabet
     * @param BaseConvertAlphabet $oToAlphabet
     * @return string
     */
    public static function toBase(
        string              $sNum,
        BaseConvertAlphabet $oFromAlphabet,
        BaseConvertAlphabet $oToAlphabet
    ): string
    {
        if ($oFromAlphabet->equals($oToAlphabet)) {
            return $sNum;
        }
        $sDec = static::toDec($sNum, $oFromAlphabet);
        if ($oToAlphabet->equals(BaseConvertAlphabet::BASE_DEC())) {
            return $sDec;
        }
        $iBase = strlen($oToAlphabet);
        $aResult = [];
        do {
            $aResult[] = substr($oToAlphabet, bcmod($sDec, $iBase), 1);
            $sDec = bcdiv($sDec, $iBase);
        } while (bccomp($sDec, '0') === 1);
        return implode('', array_reverse($aResult));
    }
}
