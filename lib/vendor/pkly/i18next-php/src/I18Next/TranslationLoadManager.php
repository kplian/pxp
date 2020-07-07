<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 27.09.2019
 * Time: 10:37
 */

namespace Pkly\I18Next;

use Pkly\I18Next\Plugin\BaseLoader;
use Psr\Log\LoggerInterface;

require_once __DIR__ . '/Utils.php';

/**
 * Class TranslationLoadManager
 *
 * This class is the equivalent of BackendConnector in i18next for JS, as we're already on the backend that name
 * didn't really make much sense, as such it was renamed. Functionality is kept mostly in-tact with the BackendController,
 * with small changes made
 *
 * @package Pkly\I18Next
 */
class TranslationLoadManager {
    /**
     * @var array
     */
    private $_options                           =   [];

    /**
     * @var ResourceStore|null
     */
    private $_store                             =   null;

    /**
     * @var BaseLoader|null
     */
    private $_loader                            =   null;

    /**
     * @var LanguageUtil|null
     */
    private $_languageUtils                     =   null;

    /**
     * @var LoggerInterface|null
     */
    private $_logger                            =   null;

    /**
     * @var array
     */
    private $_queue                             =   [];

    /**
     * @var array
     */
    private $_state                             =   [];

    /**
     * TranslationLoadManager constructor.
     *
     * @param BaseLoader|null $loader
     * @param ResourceStore $store
     * @param $services
     * @param I18n $i18n
     * @param array $options
     */
    public function __construct(?BaseLoader &$loader, ResourceStore &$store, &$services, I18n &$i18n, array $options = []) {
        $this->_loader = &$loader;
        $this->_store = &$store;
        $this->_options = $options;
        $this->_languageUtils = &$services->_languageUtils;
        $this->_logger = &$services->_logger;

        if ($this->_loader !== null) {
            $this->_loader->init($services, $options, $i18n);
        }
    }

    /**
     * Set loader for manager
     *
     * @param BaseLoader|null $loader
     * @return $this
     */
    public function setLoader(?BaseLoader &$loader) {
        $this->_loader = &$loader;
        return $this;
    }

    /**
     * Queue load to run
     *
     * @param array $languages
     * @param array $namespaces
     * @param array $options
     * @return array
     */
    public function queueLoad(array $languages, array $namespaces, array $options = []) {
        $toLoad = [];
        $pending = [];
        $toLoadLanguages = [];
        $toLoadNamespaces = [];

        foreach ($languages as $lng) {
            $hasAllNamespaces = true;

            foreach ($namespaces as $ns) {
                $name = $lng . '|' . $ns;

                if (!($options['reload'] ?? false) && $this->_store->hasResourceBundle($lng, $ns)) {
                    $this->_state[$name] = 2; // loaded
                }
                else if ($this->_state[$name] ?? 0 < 0) {
                    // nothing?
                }
                else if ($this->_state[$name] ?? 0 === 1) {
                    if (!in_array($name, $pending))
                        $pending[] = $name;
                }
                else {
                    $this->_state[$name] = 1;

                    $hasAllNamespaces = false;

                    if (!in_array($name, $pending))
                        $pending[] = $name;

                    if (!in_array($name, $toLoad))
                        $toLoad[] = $name;

                    if (!in_array($ns, $toLoadNamespaces))
                        $toLoadNamespaces[] = $ns;
                }
            }

            if (!$hasAllNamespaces)
                $toLoadLanguages[] = $lng;
        }

        if (count($toLoad) || count($pending))
            $this->_queue[] = [
                'pending'       =>  $pending,
                'loaded'        =>  [],
                'errors'        =>  []
            ];

        return [
            'toLoad'                =>  $toLoad,
            'pending'               =>  $pending,
            'toLoadLanguages'       =>  $toLoadLanguages,
            'toLoadNamespaces'      =>  $toLoadNamespaces
        ];
    }

    /**
     * Process loaded data for request
     *
     * @param $name
     * @param $data
     */
    public function loaded($name, $data) {
        list($lng, $ns) = explode("|", $name);

        if ($data) {
            $this->_store->addResourceBundle($lng, $ns, $data);
        }

        $this->_state[$name] = 2;

        $loaded = [];

        $remove = function(&$arr, $what) {
            while (($pos = array_search($what, $arr)) !== false) {
                unset($arr[$pos]);
            }
        };

        foreach ($this->_queue as &$q) {
            Utils\pushPath($q['loaded'], [$lng], $ns);
            $remove($q['pending'], $name);

            if (count($q['pending']) === 0 && !($q['done'] ?? false)) {
                foreach ($q as $l => $v) {
                    if (!array_key_exists($l, $loaded))
                        $loaded[$l] = [];

                    foreach ($q['loaded'][$l] ?? [] as $ns) {
                        if (!in_array($ns, $loaded[$l]))
                            $loaded[$l][] = $ns;
                    }
                }
            }

            $q['done'] = true;
        }

        // event emit consolidated loaded event

        $this->_queue = array_filter($this->_queue, function($o) {
            return $o['done'] ?? false;
        });
    }

    /**
     * Read data from loader
     *
     * @param $lng
     * @param $ns
     * @param $fcName
     * @return |null
     */
    public function read($lng, $ns, $fcName) {
        if (!$lng)
            return null;

        if (!is_callable([$this->_loader, $fcName])) {
            $this->_logger->warning('No valid loader was found when trying to read data in TranslationLoadManager');
            return null;
        }

        return $this->_loader->{$fcName}($lng, $ns);
    }

    /**
     * Prepare loading for resources
     *
     * @param $languages
     * @param $namespaces
     * @param array $options
     * @return bool|null
     */
    public function prepareLoading($languages, $namespaces, array $options = []) {
        if ($this->_loader === null) {
            $this->_logger->warning('No loader was added via i18next.useModule. Will not load resources.');
            return false;
        }

        if (is_string($languages))
            $languages = $this->_languageUtils->toResolveHierarchy($languages);

        if (is_string($namespaces))
            $namespaces = [$namespaces];

        $toLoad = $this->queueLoad($languages, $namespaces, $options);
        if (!count($toLoad['toLoad'])) {
            if (!count($toLoad['pending']))
                return true;

            return null;
        }

        foreach ($toLoad['toLoad'] as $name) {
            $this->loadOne($name);
        }

        return true;
    }

    /**
     * Load resources
     *
     * @param $languages
     * @param $namespaces
     */
    public function load($languages, $namespaces) {
        $this->prepareLoading($languages, $namespaces);
    }

    /**
     * Reload resources
     *
     * @param $languages
     * @param $namespaces
     */
    public function reload($languages, $namespaces) {
        $this->prepareLoading($languages, $namespaces, ['reload' => true]);
    }

    /**
     * Load data for language and namespace by string
     *
     * @param $name
     * @param string $prefix
     */
    public function loadOne($name, string $prefix = '') {
        list($lng, $ns) = explode("|", $name);

        try {
            $data = $this->read($lng, $ns, 'read');
            if ($data !== null)
                $this->_logger->info($prefix . 'Loaded namespace ' . $ns . ' for language ' . $lng, (array)$data);

            $this->loaded($name, $data);
        }
        catch (\Exception $e) {
            $this->_logger->warning($prefix . 'Loading namespace ' . $ns . ' for language '. $lng . ' failed', (array)$e);
            $this->_state[$name] = -1;
        }
    }

    /**
     * Save missing keys and data
     *
     * @param $languages
     * @param $namespace
     * @param $key
     * @param $fallbackValue
     * @param bool $isUpdate
     * @param array $options
     */
    public function saveMissing($languages, $namespace, $key, $fallbackValue, bool $isUpdate = false, array $options = []) {
        if ($this->_loader !== null)
            $this->_loader->create($languages, $namespace, $key, $fallbackValue, $options, $isUpdate);

        // write to store to avoid resending
        if (!isset($languages[0]))
            return;

        $this->_store->addResource($languages[0], $namespace, $key, $fallbackValue);
    }
}