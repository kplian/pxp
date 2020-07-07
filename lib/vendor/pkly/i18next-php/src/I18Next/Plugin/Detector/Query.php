<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 10.10.2019
 * Time: 14:09
 */

namespace Pkly\I18Next\Plugin\Detector;

use Pkly\I18Next\DetectorInterface;

/**
 * Class Query
 *
 * Accepts the following options:
 * <ul>
 *   <li>lookupQuery - the GET variable to look for</li>
 *   <li>cacheUserLanguageQuery - a callable object, single parameter (language) [optional] [required if you want to cache]</li>
 * </ul>
 *
 * @package Pkly\I18Next\Plugin\Detector
 */
class Query implements DetectorInterface {
    /**
     * @inheritDoc
     */
    public function lookup(array $options = []) {
        $getName = $options['lookupQuery'] ?? null;
        $found = null;

        if ($getName) {
            $found = $_GET[$getName] ?? null;
        }

        return $found;
    }

    /**
     * Query function will not be able to save data about the language unless a callback is specified
     * and the programmer takes care of it himself
     *
     * @param $lng
     * @param array $options
     * @return void
     */
    public function cacheUserLanguage($lng, array $options = []) {
        if (is_callable($options['cacheUserLanguageQuery']))
            call_user_func($options['cacheUserLanguageQuery'], $lng);
    }
}