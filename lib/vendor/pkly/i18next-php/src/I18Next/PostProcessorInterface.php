<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 26.09.2019
 * Time: 14:19
 */

namespace Pkly\I18Next;

/**
 * Interface PostProcessorInterface
 *
 * @package Pkly\I18Next
 */
interface PostProcessorInterface {
    /**
     * Process the value
     *
     * @param $value
     * @param $key
     * @param $options
     * @param $translator
     * @return mixed
     */
    public function process($value, $key, $options, $translator);
}