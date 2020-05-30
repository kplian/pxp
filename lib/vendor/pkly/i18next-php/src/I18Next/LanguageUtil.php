<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 20.09.2019
 * Time: 08:32
 */

namespace Pkly\I18Next;

use Psr\Log\LoggerInterface;
use Psr\Log\NullLogger;

require_once __DIR__ . '/Utils.php';

/**
 * Class LanguageUtil
 *
 * Utility class for providing the user with various data about the requested keys or languages
 *
 * @package Pkly\I18Next
 */
class LanguageUtil {
    /**
     * @var array
     */
    protected $_options                         =   [];

    /**
     * Whitelist for codes
     *
     * When false or empty the whitelist is disabled and everything is returned as whitelisted
     *
     * @var bool|array
     */
    protected $_whitelist                       =   false;

    /**
     * @var LoggerInterface|null
     */
    protected $_logger                          =   null;

    /**
     * LanguageUtil constructor.
     *
     * @param array $options
     */
    public function __construct(array $options = [], ?LoggerInterface $logger = null) {
        $this->_options = $options;

        $this->_whitelist = $this->_options['whitelist'] ?? false;

        if ($logger === null)
            $logger = new NullLogger();

        $this->_logger = $logger;
    }

    /**
     * Return the script part from code
     *
     * @param string $code
     * @return string|null
     */
    public function getScriptPartFromCode(string $code) {
        if (!$code || mb_strpos($code, '-') === false)
            return null;

        $p = explode('-', $code);
        if (count($p))
            return null;
        array_pop($p);
        return $this->formatLanguageCode(implode('-', $p));
    }

    /**
     * Return the language part from code
     *
     * @param string $code
     * @return string
     */
    public function getLanguagePartFromCode(string $code) {
        if (!$code || mb_strpos($code, '-') === false)
            return $code;

        $p = explode('-', $code);
        return $this->formatLanguageCode($p[0]);
    }

    /**
     * Format language code
     *
     * @param string $code
     * @return string
     */
    public function formatLanguageCode(string $code) {
        if (mb_strpos($code, '-') !== false) {
            $specialCases = ['hans', 'hant', 'latn', 'cyrl', 'cans', 'mong', 'arab'];
            $p = explode('-', $code);

            if ($this->_options['lowerCaseLng'] ?? false) {
                $p = array_map(function($o) {
                    return mb_strtolower($o);
                }, $p);
            }
            else if (count($p) === 2) {
                $p[0] = mb_strtolower($p[0]);
                $p[1] = mb_strtolower($p[1]);

                if (in_array(mb_strtolower($p[1]), $specialCases))
                    $p[1] = Utils\capitalize(mb_strtolower($p[1]));
            }
            else if (count($p) === 3) {
                $p[0] = mb_strtolower($p[0]);

                // if length is 2 guess it's a country
                if (mb_strlen($p[1]) === 2)
                    $p[1] = mb_strtoupper($p[1]);

                if ($p[0] !== 'sgn' && mb_strlen($p[2]) === 2)
                    $p[2] = mb_strtoupper($p[2]);

                if (in_array(mb_strtolower($p[1]), $specialCases))
                    $p[1] = Utils\capitalize(mb_strtolower($p[1]));

                if (in_array(mb_strtolower($p[2]), $specialCases))
                    $p[2] = Utils\capitalize(mb_strtolower($p[2]));
            }

            return implode('-', $p);
        }

        return ($this->_options['cleanCode'] ?? false) || ($this->_options['lowerCaseLng'] ?? false) ? mb_strtolower($code) : $code;
    }

    /**
     * Check if a specified language code is whitelisted
     *
     * @param string $code
     * @return bool
     */
    public function isWhitelisted(string $code) {
        if ($this->_options['load'] ?? null === 'languageOnly' || $this->_options['nonExplicitWhitelist'] ?? false) {
            $code = $this->getLanguagePartFromCode($code);
        }

        return $this->_whitelist === false || !count($this->_whitelist) || in_array($code, $this->_whitelist);
    }

    /**
     * Get fallback language codes
     *
     * @param $fallbacks
     * @param string|null $code
     * @return array|mixed|string|null
     */
    public function getFallbackCodes($fallbacks, ?string $code = null) {
        if (!$fallbacks)
            return [];

        if (is_string($fallbacks))
            $fallbacks = [$fallbacks];

        if (is_array($fallbacks))
            return $fallbacks;

        if ($code === null)
            return $fallbacks['default'] ?? [];

        $found = $fallbacks[$code] ?? null;

        if ($found === null)
            $found = $fallbacks[$this->getScriptPartFromCode($code)] ?? null;

        if ($found === null)
            $found = $fallbacks[$this->formatLanguageCode($code)] ?? null;

        if ($found === null)
            $found = $fallbacks['default'] ?? null;

        return $found ?? [];
    }

    /**
     * Resolve hierarchy between language codes
     *
     * @param string|null $code
     * @param string|null $fallbackCode
     * @return array
     */
    public function toResolveHierarchy(?string $code, ?string $fallbackCode = null) {
        $fallbackCodes = $this->getFallbackCodes($fallbackCode ?? $this->_options['fallbackLng'] ?? [], $code);

        $codes = [];
        $addCode = function($c) use (&$codes) {
            if (!$c)
                return;

            if ($this->isWhitelisted($c))
                $codes[] = $c;
            else
                $this->_logger->warning('Rejecting non-whitelisted language code', ['lng' => $c]);
        };

        if (is_string($code) && mb_strpos($code, '-') !== false) {
            if ($this->_options['load'] ?? false !== 'languageOnly')
                $addCode($this->formatLanguageCode($code));

            if ($this->_options['load'] ?? false !== 'languageOnly' && $this->_options['load'] ?? false !== 'currentOnly')
                $addCode($this->formatLanguageCode($code));

            if ($this->_options['load'] ?? false !== 'currentOnly')
                $addCode($this->getLanguagePartFromCode($code));
        }
        else if (is_string($code))
            $addCode($this->formatLanguageCode($code));

        array_map(function($fc) use (&$addCode, &$codes) {
            if (!in_array($fc, $codes))
                $addCode($this->formatLanguageCode($fc));
        }, $fallbackCodes);

        return $codes;
    }
}