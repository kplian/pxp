<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 27.09.2019
 * Time: 12:13
 */

namespace Pkly\I18Next\Plugin;

use Pkly\I18Next\I18n;
use Pkly\I18Next\Interpolator;
use Pkly\I18Next\Utils;

/**
 * Class JsonLoader
 *
 * Basic loader used for loading data from .json files
 *
 * @package Pkly\I18Next
 */
class JsonLoader extends BaseLoader {
    /**
     * @var string|null
     */
    protected $_filePath                        =   null;

    /**
     * @var array
     */
    protected $_jsonOptions                     =   [];

    /**
     * Get defaults used for this class
     *
     * @return array
     */
    public static function getDefaults(): array {
        return [
            'parse'             =>  function ($d) { return \json_decode($d, true); }
        ];
    }

    public function __construct(array $options = []) {
        $this->_jsonOptions = $options;
    }

    /**
     * @inheritDoc
     */
    public function getModuleName(): string {
        return 'loader-basic-json';
    }

    /**
     * @inheritDoc
     */
    public function init(&$services, array $options, I18n &$instance): void {
        parent::init($services, $options, $instance);
        $this->_options = Utils\arrayMergeRecursiveDistinct(self::getDefaults(), $this->_options, $this->_jsonOptions);

        if (!isset($this->_options['json_resource_path'])) {
            $this->_logger->error('No resource path was found for the JsonLoader instance', $options);
            return;
        }

        $this->_filePath = $this->_options['json_resource_path'];
    }

    /**
     * @inheritDoc
     */
    public function read($language, $namespace) {
        /**
         * @var Interpolator $interpolator
         */
        $interpolator = &$this->_services->_interpolator;
        $path = $interpolator->interpolate($this->_filePath, ['lng' => $language, 'ns' => $namespace]);

        return $this->load($path);
    }

    /**
     * Load data from file
     *
     * @param $path
     * @return mixed|null
     */
    protected function load($path) {
        $paths = [$path];
        $path = null;

        foreach ($paths as $p) {
            if (is_file($p)) {
                $path = $p;
                break;
            }
        }

        if (!$path) {
            $this->_logger->error('Json target file not found', $paths);
            return null;
        }

        try {
            $data = file_get_contents($path);
            $ret = call_user_func($this->_options['parse'], $data);

            if ($this->_options['parse'] === self::getDefaults()['parse']) {
                if (json_last_error() !== JSON_ERROR_NONE)
                    throw new \Exception('Json parse error');
            }

            return $ret;
        }
        catch (\Exception $e) {
            $this->_logger->error($e->getMessage(), $path);
            return null;
        }
    }
}