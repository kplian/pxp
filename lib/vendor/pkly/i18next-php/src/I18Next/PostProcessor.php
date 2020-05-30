<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 25.09.2019
 * Time: 08:46
 */

namespace Pkly\I18Next;

/**
 * Class PostProcessor
 *
 * Contains post processors to be used on values
 *
 * @package Pkly\I18Next
 */
class PostProcessor {
    /**
     * @var PostProcessorInterface[]
     */
    private $_processors                        =   [];

    /**
     * Add a new post processor
     *
     * @param string $name
     * @param $object
     */
    public function addPostProcessor(string $name, PostProcessorInterface $object) {
        $this->_processors[$name] = $object;
    }

    /**
     * Handle post processing for specified value
     *
     * @param $processors
     * @param $value
     * @param $key
     * @param array $options
     * @param $translator
     * @return mixed
     */
    public function handle($processors, $value, $key, array $options, $translator) {
        foreach ($processors as $name) {
            if (array_key_exists($name, $this->_processors))
                $value = $this->_processors[$name]->process($value, $key, $options, $translator);
        }

        return $value;
    }
}