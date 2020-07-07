<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 09.10.2019
 * Time: 14:14
 */

namespace Pkly\I18Next\Plugin\Detector;

use Pkly\I18Next\DetectorInterface;

/**
 * Class Cookie
 *
 * Accepts the following options:
 * <ul>
 *   <li>lookupCookie - name of the cookie to search for/cache to</li>
 *   <li>cookieMinutes - minutes of cookie time (if 0 - current session) [optional, default is 1 day])</li>
 *   <li>cookieDomain - domain of the cookie to be used [optional]</li>
 * </ul>
 *
 * @package Pkly\I18Next\Plugin\Detector
 */
class Cookie implements DetectorInterface {
    /**
     * @inheritDoc
     */
    public function lookup(array $options = []) {
        $cookieName = $options['lookupCookie'] ?? null;
        $found = null;

        if ($cookieName) {
            $found = $_COOKIE[$cookieName] ?? null;
        }

        return $found;
    }

    /**
     * @inheritDoc
     */
    public function cacheUserLanguage($lng, array $options = []) {
        $cookieName = $options['lookupCookie'] ?? null;

        if ($cookieName) {
            $minutes = ($options['cookieMinutes'] ?? (60 * 24)) * 60;
            $domain = $options['cookieDomain'] ?? '';
            setcookie($cookieName, $lng, $minutes, '/', $domain);
        }
    }
}