<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 11.10.2019
 * Time: 08:58
 */

namespace Pkly\I18Next\Plugin;

use Pkly\I18Next\DetectorInterface;
use Pkly\I18Next\I18n;
use Pkly\I18Next\Utils;

/**
 * Class LanguageDetector
 *
 * A general utility class for I18Next language detection, with dynamic plugin load
 *
 * @package Pkly\I18Next\Plugin
 */
class LanguageDetector extends BaseLanguageDetector {
    /**
     * LanguageDetector constructor.
     *
     * @param array $detectors a key -> class name list of detectors to be used
     * @param array $options
     */
    public function __construct(array $detectors = [], array $options = []) {
        $order = $options['order'] ?? array_keys($detectors);
        $caches = $options['caches'] ?? [];

        foreach ($detectors as $name => $class) {
            $invalid = false;

            if (!class_exists($class))
                $invalid = true;

            if (!$invalid) {
                // Creating new object here to prevent a fatal error later because of type difference on parameter
                $ob = new $class();
                if (!($ob instanceof DetectorInterface))
                    $invalid = true;
            }

            if ($invalid) {
                if (($pos = array_search($name, $order)) !== false)
                    unset($order[$pos]);

                if (($pos = array_search($name, $caches)) !== false)
                    unset($order[$pos]);

                continue;
            }

            $this->addDetector($name, $ob);
        }

        $options['order'] = $order;
        $options['caches'] = array_values($caches); //clean up keys

        $this->_i18nOptions = $options;
    }

    /**
     * @inheritDoc
     */
    public function init(&$services, array $options, I18n &$instance): void {
        parent::init($services, $options, $instance);
        $this->_options = Utils\arrayMergeRecursiveDistinct($this->_options, $this->_i18nOptions);
    }
}