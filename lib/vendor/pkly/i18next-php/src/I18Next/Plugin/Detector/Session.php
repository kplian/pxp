<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 11.10.2019
 * Time: 10:14
 */

namespace Pkly\I18Next\Plugin\Detector;

use Pkly\I18Next\DetectorInterface;
use Pkly\I18Next\Utils;

class Session implements DetectorInterface {
    /**
     * @inheritDoc
     */
    public function lookup(array $options = []) {
        $lookup = $options['lookupSession'] ?? null;

        if ($lookup === null)
            return null;

        if (!is_array($lookup))
            $lookup = [$lookup];

        return Utils\getPath($_SESSION, $lookup);
    }

    /**
     * @inheritDoc
     */
    public function cacheUserLanguage($lng, array $options = []) {
        $lookup = $options['lookupSession'] ?? null;

        if ($lookup === null)
            return null;

        if (!is_array($lookup))
            $lookup = [$lookup];

        Utils\setPath($_SESSION, $lookup, $lng);
    }
}