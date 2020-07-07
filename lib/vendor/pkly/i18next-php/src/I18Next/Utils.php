<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 18.09.2019
 * Time: 14:47
 */

namespace Pkly\I18Next\Utils;

/**
 * Get default variables for initializing the I18n object
 *
 * @return array
 */
function getDefaults() {
    return [
        /* Logging */
        'debug'                                 =>  false,
        'initImmediate'                         =>  true,
        /* Languages, namespaces, resources */
        'ns'                                    =>  ['translation'],
        'defaultNS'                             =>  ['translation'],
        'fallbackLng'                           =>  ['en'],
        'fallbackNS'                            =>  false,

        'whitelist'                             =>  false,
        'nonExcplicitWhitelist'                 =>  false,
        'load'                                  =>  'all',
        'preload'                               =>  false,

        'simplifyPluralSuffix'                  =>  true,
        'keySeparator'                          =>  '.',
        'nsSeparator'                           =>  ':',
        'pluralSeparator'                       =>  '_',
        'contextSeparator'                      =>  '_',

        /* Missing keys */
        'partialBundledLanguages'               =>  false,
        'saveMissing'                           =>  false,
        'updateMissing'                         =>  false,
        'saveMissingTo'                         =>  'fallback',
        'saveMissingPlurals'                    =>  true,
        'missingKeyHandler'                     =>  false,
        'missingInterpolationHandler'           =>  false,

        /* Translation defaults */
        'postProcess'                           =>  false,
        'returnNull'                            =>  true,
        'returnEmptyString'                     =>  true,
        'returnObjects'                         =>  false,
        'joinArrays'                            =>  false,
        'returnObjectHandler'                   =>  null,
        'parseMissingKeyHandler'                =>  false,
        'appendNamespaceToMissingKey'           =>  false,
        'appendNamespaceToCIMode'               =>  false,
        'overloadTranslationOptionHandler'      =>  function (...$args) {
            $ret = [];

            if (is_array($args[1] ?? null))
                $ret = $args[1];
            if (is_string($args[1] ?? null))
                $ret['defaultValue'] = $args[1];
            if (is_string($args[2] ?? null))
                $ret['tDescription'] = $args[2];
            if (is_array($args[2] ?? null) || is_array($args[3] ?? null)) {
                $options = $args[3] ?? $args[2];
                foreach ($options as $key => $option) {
                    $ret[$key] = $option;
                }
            }

            return $ret;
        },

        /* Interpolation */
        'interpolation'                         =>  [
            'escapeValue'                       =>  true,
            'format'                            =>  function ($value, $format, $lng) { return $value; },
            'prefix'                            =>  '{{',
            'suffix'                            =>  '}}',
            'formatSeparator'                   =>  ',',
            'unescapePrefix'                    =>  '-',

            'nestingPrefix'                     =>  '$t(',
            'nestingSuffix'                     =>  ')',
            'maxReplaces'                       =>  1000
        ]
    ];
}

/**
 * Fix options that are supposed to be arrays
 *
 * @param array|null $options
 * @return array|null
 */
function transformOptions(?array $options = null) {
    if (is_string($options['ns'] ?? null))
        $options['ns'] = [$options['ns']];

    if (is_string($options['fallbackLng'] ?? null))
        $options['fallbackLng'] = [$options['fallbackLng']];

    if (is_string($options['fallbackNS'] ?? null))
        $options['fallbackNS'] = [$options['fallbackNS']];

    return $options;
}

/**
 * array_merge_recursive does indeed merge arrays, but it converts values with duplicate
 * keys to arrays rather than overwriting the value in the first array with the duplicate
 * value in the second array, as array_merge does. I.e., with array_merge_recursive,
 * this happens (documented behavior):
 *
 * @return array
 * @author Daniel <daniel (at) danielsmedegaardbuus (dot) dk>
 * @author Gabriel Sobrinho <gabriel (dot) sobrinho (at) gmail (dot) com>
 * @author Pkly [Support more than 2 arrays at a time]
 */
function arrayMergeRecursiveDistinct(...$args) {
    $merge = function(&$a, &$b) use (&$merge) {
        $merged = $a;

        foreach ($b as $key => &$value) {
            if (is_array($value) && isset($merged[$key]) && is_array($merged[$key]))
                $merged[$key] = $merge($merged[$key], $value);
            else
                $merged[$key] = $value;
        }

        return $merged;
    };

    if (count($args) < 2)
        return $args[0];

    $data = $merge($args[0], $args[1]);
    if (count($args) === 2)
        return $data;

    for ($i = 2; $i < count($args); $i++)
        $data = $merge($data, $args[$i]);

    return $data;
}

/**
 * Copy items from one object/array to another
 *
 * @param $search
 * @param $from
 * @param $to
 */
function copy($search, &$from, &$to) {
    foreach ($search as $searchKey) {
        if (is_object($from)) {
            if (isset($from->{$searchKey})) {
                if (is_object($to))
                    $to->{$searchKey} = &$from->{$searchKey};
                else
                    $to[$searchKey] = &$from[$searchKey];
            }
        }
        else {
            if (isset($from[$searchKey])) {
                if (is_object($to))
                    $to->{$searchKey} = &$from[$searchKey];
                else
                    $to[$searchKey] = &$from[$searchKey];
            }
        }
    }
}

/**
 * Traverse an array and return the last possible object and key
 *
 * @param $object
 * @param $path
 * @param null $Empty
 * @return array
 */
function &getLastOfPath(&$object, $path, $Empty = null) {
    $cleanKey = function ($key) {
        return $key && mb_strpos($key, '###') !== false ? str_replace('###', '.', $key) : $key;
    };

    $ret = [];

    $obj = &$object;

    $canNotTraverseDeeper = function () use (&$obj) {
        return $obj === null || is_string($obj);
    };

    $stack = is_array($path) ? $path : explode('.', $path);
    while (count($stack) > 1) {
        if ($canNotTraverseDeeper())
            return $ret;

        $key = $cleanKey(array_shift($stack));
        if (!isset($obj[$key]) && $Empty !== null) {
            $obj[$key] = $Empty;
        }

        $obj = &$obj[$key];
    }

    if ($canNotTraverseDeeper())
        return $ret;

    $ret = [
        &$obj,
        $cleanKey(array_shift($stack))
    ];

    return $ret;
}

/**
 * Modify path of array
 *
 * @param $object
 * @param $path
 * @param $newValue
 */
function setPath(&$object, $path, $newValue) {
    list(&$obj, $key) = getLastOfPath($object, $path, []);

    $obj[$key] = $newValue;
}

/**
 * Add to path of array
 *
 * @param $object
 * @param $path
 * @param $newValue
 * @param bool $concat
 */
function pushPath(&$object, $path, $newValue, bool $concat = false) {
    list(&$obj, $key) = getLastOfPath($object, $path, []);

    $obj[$key] = $obj[$key] ?? [];

    if ($concat)
        $obj[$key] = array_merge($obj[$key], $newValue);
    else
        $obj[$key][] = $newValue;
}

/**
 * Get item from path of array
 *
 * @param $object
 * @param $path
 * @return mixed|null
 */
function getPath(&$object, $path) {
    list(&$obj, $key) = getLastOfPath($object, $path);

    if (!isset($obj))
        return null;

    return $obj[$key] ?? null;
}

/**
 * Merge arrays
 *
 * @param array $target
 * @param array $source
 * @param bool $overwrite
 * @return array
 */
function deepMerge(array $target, array $source, bool $overwrite = false) {
    foreach ($source as $key => $value) {
        if (array_key_exists($key, $target)) {
            if (is_string($source[$key]) && is_string($target[$key])) {
                if ($overwrite)
                    $target[$key] = $source[$key];
            }
            else {
                $target = deepMerge($target[$key], $source[$key], $overwrite);
            }
        }
        else {
            $target[$key] = $source[$key];
        }
    }

    return $target;
}

/**
 * Capitalize words
 *
 * @param string $str
 * @return string
 */
function capitalize(string $str): string {
    return mb_strtoupper(mb_substr($str, 0, 1)).mb_substr($str, 1);
}

/**
 * Escape regex values
 *
 * @param string $str
 * @return string
 */
function regexEscape(string $str): string {
    return preg_quote($str);
}

/**
 * List of values to escape
 */
const ENTITY_MAP = [
    '&'         =>  '&amp;',
    '<'         =>  '&lt;',
    '>'         =>  '&gt;',
    '"'         =>  '&quot;',
    "'"         =>  '&#39;',
    '/'         =>  '&#x2F;'
];

/**
 * Escape some values
 *
 * @param $str
 * @return mixed
 */
function escape($str) {
    if (is_string($str)) {
        return str_replace(array_keys(ENTITY_MAP), ENTITY_MAP, $str);
    }

    return $str;
}

/**
 * Turn variables into a string somewhat safely
 *
 * @param $val
 * @return string
 */
function makeString($val): string {
    if (is_string($val) || is_numeric($val))
        return (string)$val;
    else if (is_object($val)) {
        if (method_exists($val, '__toString'))
            return (string)$val;

        return '[Object ' . get_class($val) . ']';
    }
    else if (is_array($val))
        return '[Array ('.count($val).')]';
    else if (is_null($val))
        return '[Null]';

    return '[Unknown]';
}