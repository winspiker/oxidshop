<?php

namespace Exonn\Asum\Core;

/**
 * Alphabete zur Nutzung der BaseConvert-Klasse
 * @see BaseConvert
 *
 * @method static $this BASE_BIN
 * @method static $this BASE_OCT
 * @method static $this BASE_DEC
 * @method static $this BASE_HEX
 * @method static $this BASE_36
 * @method static $this BASE_62
 * @method static $this BASE_64
 * @method static $this BASE_66
 */
class BaseConvertAlphabet extends Enum
{
    private const BASE_BIN = '01';
    private const BASE_OCT = '01234567';
    private const BASE_DEC = '0123456789';
    private const BASE_HEX = '0123456789ABCDEF';
    private const BASE_36 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    private const BASE_62 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    private const BASE_64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-';
    private const BASE_66 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_-.~';
}
