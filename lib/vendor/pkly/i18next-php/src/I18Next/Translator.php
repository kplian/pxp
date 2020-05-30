<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 18.09.2019
 * Time: 14:45
 */

namespace Pkly\I18Next;

use Psr\Log\LoggerInterface;

require_once __DIR__ . '/Utils.php';

/**
 * Class Translator
 *
 * Takes the input and turns it into something actually usable
 *
 * @package Pkly\I18Next
 */
class Translator {
    /**
     * @var array
     */
    protected $_options                         =   [];

    /**
     * @var string
     */
    protected $_language                        =   '';

    /**
     * @var ResourceStore|null
     */
    public $_resourceStore                      =   null;

    /**
     * @var LanguageUtil|null
     */
    public $_languageUtils                      =   null;

    /**
     * @var PluralResolver|null
     */
    public $_pluralResolver                     =   null;

    /**
     * @var Interpolator|null
     */
    public $_interpolator                       =   null;

    /**
     * @var TranslationLoadManager|null
     */
    public $_translationLoadManager             =   null;

    /**
     * @var null
     */
    public $_i18nFormat                         =   null;

    /**
     * @var PostProcessor|null
     */
    public $_postProcessor                      =   null;

    /**
     * @var LoggerInterface|null
     */
    public $_logger                             =   null;

    /**
     * Translator constructor.
     *
     * @param $services
     * @param array $options
     */
    public function __construct(&$services, array $options = []) {
        Utils\copy([
            '_resourceStore',
            '_languageUtils',
            '_pluralResolver',
            '_interpolator',
            '_translationLoadManager',
            '_i18nFormat',
            '_postProcessor',
            '_logger'
        ], $services, $this);

        $this->_options = $options;
        if (!isset($this->_options['keySeparator'])) {
            $this->_options['keySeparator'] = '.';
        }
    }

    /**
     * Change current language
     *
     * @param null|string $lng
     */
    public function changeLanguage(?string $lng) {
        if ($lng)
            $this->_language = $lng;
    }

    /**
     * Get current language
     *
     * @return string
     */
    public function getLanguage(): string {
        return $this->_language;
    }

    /**
     * Check if key exists
     *
     * @param string $key
     * @param array $options
     * @return bool
     */
    public function exists(string $key, array $options = ['interpolation' => []]): bool {
        $resolved = $this->resolve($key, $options);
        return $resolved && !($resolved['res'] instanceof \stdClass);
    }

    /**
     * Extract key and namespaces from key
     *
     * @param string $key
     * @param array $options
     * @return array
     */
    public function extractFromKey(string $key, array $options = []) {
        $nsSeparator = $options['nsSeparator'] ?? $this->_options['nsSeparator'] ?? ':';
        $keySeparator = $options['keySeparator'] ?? $this->_options['keySeparator'];

        $namespaces = $options['ns'] ?? $this->_options['defaultNS'];

        if ($nsSeparator && mb_strpos($key, $nsSeparator) !== false) {
            $parts = explode($nsSeparator, $key);
            if ($nsSeparator !== $keySeparator || ($nsSeparator === $keySeparator && in_array($parts[0], $this->_options['ns'] ?? [])))
                $namespaces = array_shift($parts);

            $key = implode($keySeparator, $parts);
        }

        if (is_string($namespaces))
            $namespaces = [$namespaces];

        return [
            $key,
            $namespaces
        ];
    }

    /**
     * Translate text
     *
     * @param $keys
     * @param array|null $options
     * @return array|mixed|string
     */
    public function translate($keys, ?array $options = null) {
        if (!is_array($options) && isset($this->_options['overloadTranslationOptionHandler'])) {
            $options = call_user_func($this->_options['overloadTranslationOptionHandler'], func_get_args());
        }

        if (!$options)
            $options = [];

        // non-valid key handling
        if (!$keys)
            return '';

        if (!is_array($keys))
            $keys = [$keys];

        // separators
        $keySeparator = $options['keySeparator'] ?? $this->_options['keySeparator'];

        // get namespaces
        list($key, $namespaces) = $this->extractFromKey($keys[count($keys) - 1], $options);
        $namespace = $namespaces[count($namespaces) - 1];

        // return key on CIMode
        $lng = $options['lng'] ?? $this->_language;
        $appendNamespaceToCIMode = $options['appendNamespaceToCIMode'] ?? $this->_options['appendNamespaceToCIMode'];
        if ($lng && mb_strtolower($lng) === 'cimode') {
            if ($appendNamespaceToCIMode) {
                $nsSeparator = $options['nsSeparator'] ?? $this->_options['nsSeparator'];
                return $namespace . $nsSeparator . $key;
            }

            return $key;
        }

        $resolved = $this->resolve($keys, $options);
        $res = $resolved['res'];
        $resUsedKey = $resolved['usedKey'] ?? $key;
        $resExactUsedKey = $resolved['exactUsedKey'] ?? $key;

        $resType = gettype($res);
        $noObject = ['number', 'callable'];
        $joinArrays = $options['joinArrays'] ?? $this->_options['joinArrays'];

        $handleAsObjectInI18nFormat = $this->_i18nFormat->handleAsObject ?? false;
        $handleAsObject = !in_array($resType, $noObject);

        if ($handleAsObjectInI18nFormat && $res && $handleAsObject && !(is_string($joinArrays) && $resType === 'array')) {
            if (!($options['returnObjects'] ?? $this->_options['returnObjects'] ?? false)) {
                $this->_logger->warning('Accessing an object - but returnObjects option is not enabled!');
                return isset($this->_options['returnedObjectHandler']) ?
                    call_user_func($this->_options['returnedObjectHandler'], $resUsedKey, $res, $options) :
                    'key ' . $key . ' (' . $this->_language . ') returned an object instead of string';
            }

            // if we got a separator we loop over children - else we just return object as is
            // as having it set to false means no hierarchy so no lookup for nested values
            if ($keySeparator) {
                // res type is required as array, so if somehow there'd be an object here it's required to implement the array interface
                $copy = [];

                $newKeyToUse = $resExactUsedKey;
                foreach ($res as $m => $v) {
                    $deepKey = $newKeyToUse.$keySeparator.$m;
                    $copy[$m] = $this->translate($deepKey, array_merge($options, ['joinArrays' => false, 'ns' => $namespaces]));

                    if ($copy[$m] === $deepKey)
                        $copy[$m] = $res[$m]; // if nothing found use original value as fallback
                }

                $res = $copy;
            }
        }
        else if ($handleAsObjectInI18nFormat && is_string($joinArrays) && $resType === 'array') {
            // array special treatment
            $res = array_merge($res, $joinArrays);
            if ($res)
                $res = $this->extendTranslation($res, $keys, $options);
        }
        else {
            // string empty or null
            $usedDefault = false;
            $usedKey = false;

            // fallback value
            if (!$this->isValidLookup($res) && isset($options['defaultValue'])) {
                $usedDefault = true;

                if (isset($options['count'])) {
                    $suffix = $this->_pluralResolver->getSuffix($lng, $options['count']);
                    $res = $options['defaultValue' . $suffix];
                }

                if (!$res)
                    $res = $options['defaultValue'];
            }

            if (!$this->isValidLookup($res)) {
                $usedKey = true;
                $res = $key;
            }

            // save missing
            $updateMissing = $options['defaultValue'] ?? false && $options['defaultValue'] !== $res && $this->_options['updateMissing'];
            if ($usedKey || $usedDefault || $updateMissing) {
                $this->_logger->info(($updateMissing ? 'UpdateKey' : 'MissingKey'), ['lng' => $lng, 'ns' => $namespace, 'key' => $key, 'updateMissing' => $updateMissing ? $options['defaultValue'] : $res]);

                $lngs = [];
                $fallbackLngs = $this->_languageUtils->getFallbackCodes($this->_options['fallbackLng'], $options['lng'] ?? $this->_language);
                if ($this->_options['saveMissingTo'] === 'fallback' && count($fallbackLngs))
                    $lngs = $fallbackLngs;
                else if ($this->_options['saveMissingTo'] === 'all')
                    $lngs = $this->_languageUtils->toResolveHierarchy($options['lng'] ?? $this->_language);
                else
                    $lngs[] = $options['lng'] ?? $this->_language;

                $send = function($l, $k) use ($namespace, $updateMissing, $options, $res) {
                    if (isset($this->_options['missingKeyHandler']) && is_callable([$this->_options, 'missingKeyHandler'])) {
                        call_user_func([$this->_options, 'missingKeyHandler'], $l, $namespace, $k, $updateMissing ? $options['defaultValue'] ?? null : $res, $updateMissing, $options);
                    }
                    else if ($this->_translationLoadManager !== null) {
                        $this->_translationLoadManager->saveMissing($l, $namespace, $k, $updateMissing ? $options['defaultValue'] ?? null : $res, $updateMissing, $options);
                    }
                    // TODO: Event emitting here missingKey
                };

                if ($this->_options['saveMissing'] ?? false) {
                    $needsPluralHandling = isset($options['count']) && is_numeric($options['count']);
                    if ($this->_options['saveMissingPlurals'] ?? true && $needsPluralHandling) {
                        foreach ($lngs as $l) {
                            foreach ($this->_pluralResolver->getPluralFormsOfKey($l, $key) as $p)
                                $send([$l], $p);
                        }
                    }
                    else
                        $send($lngs, $key);
                }
            }

            // extend
            $res = $this->extendTranslation($res, $keys, $options, $resolved);

            // append namespace if still key
            if ($usedKey && $res === $key && $this->_options['appendNamespaceToMissingKey'] ?? true)
                $res = $namespace . ':' . $key;

            // parseMissingKeyHandler
            if ($usedKey && is_callable($this->_options['parseMissingKeyHandler'] ?? null)) {
                $res = call_user_func($this->_options['parseMissingKeyHandler'], $res);
            }
        }

        return $res;
    }

    /**
     * Extend translations
     *
     * @param $res
     * @param $key
     * @param $options
     * @param array $resolved
     * @return mixed|string
     */
    public function extendTranslation($res, $key, $options, array $resolved = []) {
        if (is_callable([$this->_i18nFormat, 'parse'])) {
            $res = call_user_func([$this->_i18nFormat, 'parse'], $res, $options, $resolved['usedLng'], $resolved['usedNS'], $resolved['usedKey'], $resolved);
        }
        else if (!($options['skipInterpolation'] ?? false)) {
            // i18next.parsing
            if ($options['interpolation'] ?? false)
                $this->_interpolator->init(array_merge($options, ['interpolation' => array_merge($this->_options['interpolation'] ?? [], $options['interpolation'] ?? [])]));

            $data = is_array($options['replace'] ?? null) ? $options['replace'] : $options;
            if (isset($this->_options['interpolation']['defaultVariables']))
                $data = array_merge($this->_options['interpolation']['defaultVariables'], $data);

            $res = $this->_interpolator->interpolate($res, $data, $options['lng'] ?? $this->_language, $options);

            // nesting
            if ($options['nest'] ?? true !== false)
                $res = $this->_interpolator->nest($res, function(...$args) { return $this->translate(...$args); }, $options);

            if ($options['interpolation'] ?? false)
                $this->_interpolator->reset();
        }

        // post process
        $postProcess = $options['postProcess'] ?? $this->_options['postProcess'] ?? [];
        $postProcessorNames = is_string($postProcess) ? [$postProcess] : $postProcess;

        if (!is_array($postProcessorNames))
            $postProcessorNames = [];

        if ($res && count($postProcessorNames) && $options['applyPostProcessor'] ?? true !== false && $this->_postProcessor !== null)
            $res = $this->_postProcessor->handle($postProcessorNames, $res, $key, $options, $this);

        return $res;
    }

    /**
     * Resolve key lookup
     *
     * @param $keys
     * @param array $options
     * @return array
     */
    public function resolve($keys, array $options = []) {
        if (!is_array($keys))
            $keys = [$keys];

        $found = new \stdClass();
        $usedKey = null;
        $exactUsedKey = null;
        $usedLng = null;
        $usedNS = null;

        foreach ($keys as $k) {
            if ($this->isValidLookup($found))
                break;

            list ($key, $namespaces) = $this->extractFromKey($k, $options);
            if (is_array($this->_options['fallbackNS'] ?? null))
                $namespaces = array_merge($namespaces, $this->_options['fallbackNS']);

            $needsPluralHandling = !is_string($options['count'] ?? '');
            $needsContextHandling = is_string($options['context'] ?? null) && $options['context'] ?? '' !== '';

            $codes = $options['lngs'] ?? $this->_languageUtils->toResolveHierarchy($options['lng'] ?? $this->_language, $options['fallbackLng'] ?? null);

            foreach ($namespaces as $ns) {
                if ($this->isValidLookup($found))
                    break;

                $usedNS = $ns;

                foreach ($codes as $code) {
                    if ($this->isValidLookup($found))
                        break;

                    $usedLng = $code;

                    $finalKey = $key;
                    $finalKeys = [$finalKey];

                    if ($this->_i18nFormat !== null && is_callable([$this->_i18nFormat, 'addLookupKeys'])) {
                        call_user_func([$this->_i18nFormat, 'addLookupKeys'], $finalKeys, $key, $code, $ns, $options);
                    }
                    else {
                        $pluralSuffix = '';
                        if ($needsPluralHandling)
                            $pluralSuffix = $this->_pluralResolver->getSuffix($code, $options['count']);

                        // fallback for plural if context not found
                        if ($needsPluralHandling && $needsContextHandling)
                            $finalKeys[] = $finalKey . $pluralSuffix;

                        // get key for context if needed
                        if ($needsContextHandling)
                            $finalKeys[] = $finalKey .= ($this->_options['contextSeparator'] ?? '') . $options['context'];

                        // get key for plural if needed
                        if ($needsPluralHandling)
                            $finalKeys[] = $finalKey .= $pluralSuffix;
                    }

                    // iterate over $finalKeys starting with most specific plural key (-> context key only) -> singular key only
                    $possibleKey = null;

                    while (($possibleKey = array_pop($finalKeys))) {
                        if ($this->isValidLookup($found))
                            break;

                        $exactUsedKey = $possibleKey;
                        $f = $this->getResource($code, $ns, $possibleKey, $options);

                        if ($f !== null)
                            $found = $f;
                    }
                }
            }
        }

        return [
            'res'               =>  $found,
            'usedKey'           =>  $usedKey,
            'exactUsedKey'      =>  $exactUsedKey,
            'usedLng'           =>  $usedLng,
            'usedNS'            =>  $usedNS
        ];
    }

    /**
     * Check if resource is valid
     *
     * @param $res
     * @return bool
     */
    public function isValidLookup($res) {
        // In JS this includes an undefined check, but in PHP there's no such thing, so we're creating an stdClass instead, great I know.
        return !($res instanceof \stdClass) &&
            !(!($this->_options['returnNull'] ?? true) && $res === null) &&
            !(!($this->_options['returnEmptyString'] ?? true) && $res === '');
    }

    /**
     * Get resource
     *
     * @param $code
     * @param $ns
     * @param $key
     * @param array $options
     * @return mixed
     */
    public function getResource($code, $ns, $key, array $options = []) {
        $f = is_callable([$this->_i18nFormat, 'getResource']) ?
            \Closure::fromCallable([$this->_i18nFormat, 'getResource']) :
            \Closure::fromCallable([$this->_resourceStore, 'getResource']);
        return $f($code, $ns, $key, $options);
    }
}
