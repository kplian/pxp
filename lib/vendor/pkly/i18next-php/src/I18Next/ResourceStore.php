<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 18.09.2019
 * Time: 14:04
 */

namespace Pkly\I18Next;

require_once __DIR__ . '/Utils.php';

/**
 * Class ResourceStore
 *
 * Container for language keys ready to be used for translation
 *
 * @package Pkly\I18Next
 */
class ResourceStore implements \JsonSerializable {
    /**
     * Stored currently loaded data
     *
     * @var array
     */
    private $_data                              =   [];

    /**
     * @var array|null
     */
    private $_options                           =   [];

    /**
     * ResourceStore constructor.
     *
     * @param array $data
     * @param array|null $options
     */
    public function __construct(array $data = [], ?array $options = null) {
        $this->_data = $data;

        $defaults = Utils\getDefaults();

        if ($options === null) {
            $options = [
                'ns'            =>  $defaults['ns'],
                'defaultNS'     =>  $defaults['defaultNS']
            ];
        }

        $options['keySeparator'] = $options['keySeparator'] ?? $defaults['keySeparator'];

        $this->_options = $options;
    }

    /**
     * Add namespace to options
     *
     * @param $namespaces
     */
    public function addNamespaces($namespaces) {
        if (!is_array($namespaces))
            $namespaces = [$namespaces];

        foreach ($namespaces as $namespace)
            if (!in_array($namespace, $this->_options['ns']))
                $this->_options['ns'][] = $namespace;
    }

    /**
     * Remove namespace from options
     *
     * @param $namespaces
     */
    public function removeNamespaces($namespaces) {
        if (!is_array($namespaces))
            $namespaces = [$namespaces];

        foreach ($namespaces as $namespace) {
            $key = array_search($namespace, $this->_options['ns']);
            if ($key !== false)
                unset($this->_options['ns'][$key]);
        }

        // Technically not required but otherwise the keys will be a mess when removing namespaces
        $this->_options['ns'] = array_values($this->_options['ns']);
    }

    /**
     * Get loaded resource
     *
     * @param string $lng
     * @param string $ns
     * @param null $key
     * @param array $options
     * @return mixed|null
     */
    public function getResource(string $lng, string $ns, $key = null, array $options = []) {
        $keySeparator = $options['keySeparator'] ?? $this->_options['keySeparator'];

        $path = [$lng, $ns];

        if ($key && !is_string($key))
            $path = array_merge($path, $key);

        if ($key && is_string($key))
            $path = array_merge($path, ($keySeparator ? explode($keySeparator, $key) : $key));

        if (mb_strpos($lng, '.') !== false) {
            $path = explode($lng, '.');
        }

        return Utils\getPath($this->_data, $path);
    }

    /**
     * Add new resource
     *
     * @param string $lng
     * @param $ns
     * @param $key
     * @param $value
     * @param array $options
     */
    public function addResource(string $lng, $ns, $key, $value, array $options = ['silent' => false]) {
        $keySeparator = $options['keySeparator'] ?? $this->_options['keySeparator'];

        $path = [$lng, $ns];

        if ($key)
            $path = array_merge($path, ($keySeparator ? explode($keySeparator, $key) : $key));

        if (mb_strpos($lng, '.') !== false) {
            $path = explode('.', $lng);
            $value = $ns;
            $ns = $path[1];
        }

        $this->addNamespaces($ns);

        Utils\setPath($this->_data, $path, $value);

        // event emitting here
    }

    /**
     * Add multiple new resources
     *
     * @param string $lng
     * @param $ns
     * @param array $resources
     * @param array $options
     */
    public function addResources(string $lng, $ns, array $resources, array $options = ['silent' => false]) {
        foreach ($resources as $key => $value) {
            if (is_string($value))
                $this->addResource($lng, $ns, $key, $value, $options);
        }

        // event emitting here
    }

    /**
     * Add resource bundle
     *
     * @param string $lng
     * @param $ns
     * @param $resources
     * @param bool $deep
     * @param bool $overwrite
     * @param array $options
     */
    public function addResourceBundle(string $lng, $ns, $resources, bool $deep = false, bool $overwrite = false, array $options = ['silent' => false]) {
        $path = [$lng, $ns];

        if (mb_strpos($lng, '.') !== false) {
            $path = explode('.', $lng);
            $deep = $resources;
            $resources = $ns;
            $ns = $path[1];
        }

        $this->addNamespaces($ns);

        $pack = Utils\getPath($this->_data, $path) ?? [];

        if ($deep) {
            $pack = Utils\deepMerge($pack, $resources, $overwrite);
        }
        else {
            $pack = array_merge($pack, $resources);
        }

        Utils\setPath($this->_data, $path, $pack);

        // event emitting here
    }

    /**
     * Remove resource bundle
     *
     * @param string $lng
     * @param string $ns
     */
    public function removeResourceBundle(string $lng, string $ns) {
        if ($this->hasResourceBundle($lng, $ns)) {
            unset($this->_data[$lng][$ns]);
        }

        $this->removeNamespaces($ns);

        // event emitting here
    }

    /**
     * Check if a resource bundle exists
     *
     * @param string $lng
     * @param string $ns
     * @return bool
     */
    public function hasResourceBundle(string $lng, string $ns): bool {
        return $this->getResource($lng, $ns) !== null;
    }

    /**
     * Get resource bundle
     *
     * @param string $lng
     * @param string|null $ns
     * @return mixed|null
     */
    public function getResourceBundle(string $lng, ?string $ns = null) {
        if ($ns === null)
            $ns = $this->_options['defaultNS'];

        return $this->getResource($lng, $ns);
    }

    /**
     * Get data by language
     *
     * @param string $lng
     * @return mixed|null
     */
    public function getDataByLanguage(string $lng) {
        return $this->_data[$lng] ?? null;
    }

    /**
     * @inheritDoc
     */
    public function jsonSerialize() {
        return $this->_data ?? [];
    }
}