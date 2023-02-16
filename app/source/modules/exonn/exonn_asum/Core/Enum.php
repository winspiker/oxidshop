<?php

namespace Exonn\Asum\Core;

/**
 * Enum Implementierung
 *
 * TODO: ab PHP 8.1 durch native Enums ersetzbar (https://github.com/myclabs/php-enum#native-enums-and-migration)
 */
abstract class Enum
{
    /** @var mixed Wert der Konstante */
    protected $value;

    /** @var string Name der Konstante */
    private $sKey;

    /**
     * Konstruktor
     *
     * @param mixed $value
     */
    public function __construct($value)
    {
        if ($value instanceof static) {
            $value = $value->value();
        }
        $this->sKey = static::assertValidValueReturningKey($value);
        $this->value = $value;
    }

    /**
     * Gibt den Wert der Konstante zurück
     *
     * @return mixed
     */
    public function value()
    {
        return $this->value;
    }

    /**
     * Gibt den Namen der Konstante zurück
     *
     * @return string
     */
    public function key(): string
    {
        return $this->sKey;
    }

    /**
     * Erstellt eine Instanz aus einem Wert sollte dieser existieren
     *
     * @param $value
     *
     * @return static
     */
    public static function from($value): self
    {
        $sKey = static::assertValidValueReturningKey($value);
        return self::__callStatic($sKey, []);
    }

    /**
     * Prüft, ob 2 Enums gleich sind
     *
     * @param Enum $oEnum
     *
     * @return bool
     */
    final public function equals(self $oEnum): bool
    {
        return $this->value() === $oEnum->value()
            && static::class === get_class($oEnum);
    }

    /**
     * Gibt die Namen aller möglichen Werte zurück
     *
     * @return array
     */
    public static function keys(): array
    {
        return array_keys(static::toArray());
    }

    /**
     * Gibt alle Instanzen des Enums zurück
     *
     * @return array
     */
    public static function values(): array
    {
        $aValues = [];
        foreach (static::toArray() as $sKey => $value) {
            $aValues[$sKey] = new static($value);
        }
        return $aValues;
    }

    /**
     * Gibt alle möglichen Werte des Enums als Array zurück
     *
     * @return array
     */
    public static function toArray(): array
    {
        static $aCache = [];
        if (!isset($aCache[static::class])) {
            $oRC = new \ReflectionClass(static::class);
            $aCache[static::class] = $oRC->getConstants();
        }
        return $aCache[static::class];
    }

    /**
     * Prüft, ob der Wert zu einer Konstante des Enums gehört
     *
     * @param int $iValue
     *
     * @return bool
     */
    public static function isValid(int $iValue): bool
    {
        return in_array($iValue, self::toArray(), true);
    }

    /**
     * Behauptet, dass der Wert zu einer Konstante des Enums gehört
     *
     * @param $value
     *
     * @return void
     */
    public static function assertValidValue($value): void
    {
        self::assertValidValueReturningKey($value);
    }

    /**
     * Prüft, ob ein Wert zu einer Konstante des Enums gehört und gibt den Namen der Konstante zurück
     *
     * @param $value
     *
     * @return string
     */
    private static function assertValidValueReturningKey($value): string
    {
        if (false === ($sKey = static::search($value))) {
            throw new \UnexpectedValueException(
                "Value \"$value\" is not part of the enum " . static::class
            );
        }
        return $sKey;
    }

    /**
     * Prüft, ob der gegebene Name der Konstante existiert
     *
     * @param string $sKey
     *
     * @return bool
     */
    public static function isValidKey(string $sKey): bool
    {
        $aArray = static::toArray();
        return isset($aArray[$sKey]) || array_key_exists($sKey, $aArray);
    }

    /**
     * Durchsucht den Enum nach dem Wert und liefert den Namen der Konstante zurück
     *
     * @param $value
     *
     * @return false|int|string
     */
    public static function search($value)
    {
        return array_search($value, static::toArray(), true);
    }

    /**
     * Gibt einen Wert bei statischem Aufruf nach folgendem Schema zurück:
     * TestEnum::FOO_BAR() falls FOO_BAR als Klassenkonstante existiert.
     *
     * @param $sName
     * @param $aArguments
     *
     * @return mixed
     */
    public static function __callStatic($sName, $aArguments)
    {
        static $aInstances = [];
        if (!isset($aInstances[static::class][$sName])) {
            if (!static::isValidKey($sName)) {
                throw new \BadMethodCallException(
                    "No static method or enum constant \"$sName\" in class " . static::class
                );
            }
            $aArray = static::toArray();
            $aInstances[static::class][$sName] = new static($aArray[$sName]);
        }
        return clone $aInstances[static::class][$sName];
    }

    public function __toString(): string
    {
        return (string)$this->value;
    }
}
