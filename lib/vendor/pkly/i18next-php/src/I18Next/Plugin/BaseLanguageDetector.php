<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 09.10.2019
 * Time: 12:44
 */

namespace Pkly\I18Next\Plugin;

use Pkly\I18Next\DetectorInterface;
use Pkly\I18Next\I18n;
use Pkly\I18Next\ModuleInterface;
use Psr\Log\LoggerInterface;
use Psr\Log\NullLogger;
use const Pkly\I18Next\MODULE_TYPE_LANGUAGE_DETECTOR;
use Pkly\I18Next\Utils;

require_once __DIR__ . '/../Utils.php';

/**
 * Class BaseLanguageDetector
 *
 * Basic class for language detection plugins to be used in i18n
 *
 * @package Pkly\I18Next\Plugin
 */
abstract class BaseLanguageDetector implements ModuleInterface {
    /**
     * @var array
     */
    protected $_options                         =   [];

    /**
     * @var array
     */
    protected $_i18nOptions                     =   [];

    /**
     * @var LoggerInterface|null
     */
    protected $_logger                          =   null;

    /**
     * @var I18n|null
     */
    protected $_i18n                            =   null;

    /**
     * @var \stdClass|null
     */
    protected $_services                        =   null;

    /**
     * @var DetectorInterface[]
     */
    protected $_detectors                       =   [];

    /**
     * @inheritDoc
     */
    public function getModuleType(): string {
        return MODULE_TYPE_LANGUAGE_DETECTOR;
    }

    /**
     * @inheritDoc
     */
    public function getModuleName(): string {
        return 'loader-base';
    }

    /**
     * @inheritDoc
     */
    public function init(&$services, array $options, I18n &$instance): void {
        $this->_options = Utils\arrayMergeRecursiveDistinct(Utils\getDefaults(), $options);
        $this->_i18n = &$instance;
        $this->_logger = &$services->_logger;
        $this->_services = &$services;

        if ($this->_logger === null)
            $this->_logger = new NullLogger();
    }

    /**
     * Add detector
     *
     * @param string $name
     * @param DetectorInterface $detector
     */
    public function addDetector(string $name, DetectorInterface $detector): void {
        $this->_detectors[$name] = $detector;
    }

    /**
     * Detect the current language
     *
     * @param string[]|null $detectionOrder
     * @return mixed
     */
    public function detect($detectionOrder = null) {
        if ($detectionOrder === null)
            $detectionOrder = $this->_options['order'] ?? array_keys($this->_detectors);

        $detected = [];
        foreach ($detectionOrder as $detectorName) {
            if (!isset($this->_detectors[$detectorName]))
                continue;

            $lookup = $this->_detectors[$detectorName]->lookup($this->_options);
            if ($lookup && is_string($lookup))
                $lookup = [$lookup];

            if ($lookup)
                $detected = array_merge($detected, $lookup);
        }

        $found = null;
        foreach ($detected as $lng) {
            $cleanedLng = $this->_services->_languageUtils->formatLanguageCode($lng);
            if (!($this->_options['checkWhitelist'] ?? true) || $this->_services->_languageUtils->isWhitelisted($cleanedLng))
                $found = $cleanedLng;

            if ($found)
                break;
        }

        if (!$found) {
            $fallbacks = $this->_i18nOptions['fallbackLng'] ?? [];
            if (is_string($fallbacks))
                $fallbacks = [$fallbacks];
            if (!$fallbacks)
                $fallbacks = [];

            $found = is_array($fallbacks) ? $fallbacks[0] ?? null : null;
        }

        if ($found === null) {
            $this->_logger->warning('No language could be detected');
        }
        else {
            $this->_logger->info('Automatically detected language', ['found' => $found]);
        }

        return $found;
    }

    /**
     * @param string $lng
     * @param string[]|null $caches
     */
    public function cacheUserLanguage(string $lng, $caches = null) {
        if ($caches === null)
            $caches = $this->_options['caches'] ?? [];

        if (!count($caches))
            return;

        if (in_array($lng, $this->_options['excludeCacheFor'] ?? []))
            return;

        foreach ($caches as $cacheName) {
            if (!isset($this->_detectors[$cacheName]))
                continue;

            $this->_detectors[$cacheName]->cacheUserLanguage($lng, $this->_options);
        }
    }
}