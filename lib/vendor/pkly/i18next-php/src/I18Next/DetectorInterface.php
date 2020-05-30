<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 09.10.2019
 * Time: 12:55
 */

namespace Pkly\I18Next;

/**
 * Interface DetectorInterface
 *
 * Base interface to be used by language detectors
 *
 * @package Pkly\I18Next
 */
interface DetectorInterface {
    /**
     * Search for user language in detector
     *
     * @param array $options
     * @return string|string[]
     */
    public function lookup(array $options = []);

    /**
     * Cache user language for detector
     *
     * @param $lng
     * @param array $options
     * @return mixed
     */
    public function cacheUserLanguage($lng, array $options = []);
}