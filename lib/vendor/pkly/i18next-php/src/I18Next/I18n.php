<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 18.09.2019
 * Time: 13:06
 */

namespace Pkly\I18Next;

use Pkly\I18Next\Plugin\BaseLanguageDetector;
use Pkly\I18Next\Plugin\BaseLoader;
use Psr\Log\LoggerInterface;
use Psr\Log\NullLogger;

require_once __DIR__ . '/Utils.php';

const RTL_LANGUAGES = [
    'ar', 'shu', 'sqr', 'ssh', 'xaa', 'yhd', 'yud', 'aao', 'abh', 'abv', 'acm', 'acq',
    'acw', 'acx', 'acy', 'adf', 'ads', 'aeb', 'aec', 'afb', 'ajp', 'apc', 'apd', 'arb',
    'arq', 'ars', 'ary', 'arz', 'auz', 'avl', 'ayh', 'ayl', 'ayn', 'ayp', 'bbz', 'pga',
    'he', 'iw', 'ps', 'pbt', 'pbu', 'pst', 'prp', 'prd', 'ur', 'ydd', 'yds', 'yih', 'ji',
    'yi', 'hbo', 'men', 'xmn', 'fa', 'jpr', 'peo', 'pes', 'prs', 'dv', 'sam',
];

const STORE_API = [
    'getResource',
    'addResource',
    'addResources',
    'addResourceBundle',
    'removeResourceBundle',
    'hasResourceBundle',
    'getResourceBundle',
    'getDataByLanguage'
];

/**
 * Class I18n
 *
 * Base class for translating text
 *
 * To use either create a new instance yourself, or simply initialize it globally via I18n::get() (suggested)
 *
 * @package Pkly\I18Next
 * @method mixed getResource(string $lng, string $ns, $key = null, array $options = [])
 * @method void addResource(string $lng, $ns, $key, $value, array $options = ['silent' => false])
 * @method void addResources(string $lng, $ns, array $resources, array $options = ['silent' => false])
 * @method void addResourceBundle(string $lng, $ns, $resources, bool $deep = false, bool $overwrite = false, array $options = ['silent' => false])
 * @method void removeResourceBundle(string $lng, string $ns)
 * @method bool hasResourceBundle(string $lng, string $ns)
 * @method mixed getResourceBundle(string $lng, ?string $ns = null)
 * @method mixed getDataByLanguage(string $lng)
 */
class I18n {
    /**
     * Instance options
     *
     * @var array
     */
    protected $_options                         =   [];

    /**
     * @var LoggerInterface|null
     */
    protected $_logger                          =   null;

    /**
     * @var array
     */
    protected $_languages                       =   [];

    /**
     * @var string
     */
    protected $_language                        =   '';

    /**
     * @var array
     */
    protected $_modules                         =   ['external' => []];

    /**
     * @var null|\Closure
     */
    protected $_format                          =   null;

    /**
     * @var null|\stdClass
     */
    protected $_services                        =   null;

    /**
     * @var ResourceStore|null
     */
    protected $_store                           =   null;

    /**
     * @var Translator|null
     */
    protected $_translator                      =   null;

    /**
     * @var PostProcessor|null
     */
    protected $_postProcessor                   =   null;

    /**
     * @var TranslationLoadManager|null
     */
    protected $_translationLoadManager          =   null;

    /**
     * @var BaseLoader|null
     */
    protected $_loader                          =   null;

    /**
     * @var null|$this
     */
    protected static $_instance                 =   null;

    /**
     * Return shared instance of the translation framework
     *
     * @return $this
     */
    public static function &get(...$args) {
        if (self::$_instance === null)
            self::$_instance = new static(...$args);

        return self::$_instance;
    }

    /**
     * I18n constructor.
     *
     * @param array $options
     */
    public function __construct(array $options = [], ?LoggerInterface $logger = null) {
        $this->_options = Utils\transformOptions($options);

        $this->_services = new \stdClass();

        if ($logger === null)
            $logger = new NullLogger();

        $this->_logger = $logger;

        $this->init($this->_options);
    }

    /**
     * Initialize or re-initialize the translation framework
     *
     * @param array|null $options
     */
    public function init(?array $options = null) {
        if ($options === null)
            $options = $this->_options;

        $this->_options = Utils\arrayMergeRecursiveDistinct(Utils\getDefaults(), $this->_options, Utils\transformOptions($options));
        $this->_format = $this->_options['interpolation']['format'];

        // init services
        if (!($this->_options['isClone'] ?? false)) {
            $this->_store = new ResourceStore($this->_options['resources'] ?? [], $this->_options);

            $this->_services->_logger = &$this->_logger;
            $this->_services->_resourceStore = &$this->_store;
            $this->_services->_languageUtils = new LanguageUtil($this->_options, $this->_logger);
            $this->_services->_pluralResolver = new PluralResolver($this->_services->_languageUtils, [
                'prepend'               =>  $this->_options['pluralSeparator'],
                'simplifyPluralSuffix'  =>  $this->_options['simplifyPluralSuffix']
            ], $this->_logger);
            $this->_services->_interpolator = new Interpolator($this->_options, $this->_logger);

            $this->_translationLoadManager = new TranslationLoadManager($this->_loader, $this->_store, $this->_services, $this, $this->_options);
            $this->_services->_translationLoadManager = &$this->_translationLoadManager;

            if (isset($this->_modules['languageDetector'])) {
                $this->_modules['languageDetector']->init($this->_services, $this->_options, $this);
                $this->_services->_languageDetector = &$this->_modules['languageDetector'];
            }

            $this->_translator = new Translator($this->_services, $this->_options);

            // TODO: Init external modules here
        }

        // append api
        foreach (STORE_API as $fcName) {
            unset($this->{$fcName});
            $this->{$fcName} = function (...$args) use ($fcName) {
                return call_user_func([$this->_store, $fcName], ...$args);
            };
        }

        $this->changeLanguage($this->_options['lng']);
    }

    /**
     * Load resources for the framework
     */
    public function loadResources() {
        if (!isset($this->_options['resources']) || $this->_options['partialBundledLanguages']) {
            if ($this->_language && mb_strtolower($this->_language) === 'cimode')
                return; // avoid loading resources for cimode

            $toLoad = [];

            $append = function ($lng) use (&$toLoad) {
                if (!$lng)
                    return;

                foreach ($this->_services->_languageUtils->toResolveHierarchy($lng) as $l) {
                    if (!in_array($l, $toLoad))
                        $toLoad[] = $l;
                }
            };

            if (!$this->_language) {
                // at least load fallbacks in this case
                $fallbacks = call_user_func([$this->_services->_languageUtils, 'getFallbackCodes'], $this->_options['fallbackLng']);
                array_map($append, $fallbacks);
            }
            else
                $append($this->_language);

            if ($this->_options['preload'] && is_array($this->_options['preload']))
                array_map($append, $this->_options['preload']);

            $this->_translationLoadManager->load($toLoad, $this->_options['ns']);
        }
    }

    /**
     * Reload resources
     *
     * @param null $lngs
     * @param null $ns
     */
    public function reloadResources($lngs = null, $ns = null) {
        if (!$lngs)
            $lngs = $this->_languages;

        if (!$ns)
            $ns = $this->_options['ns'];

        $this->_translationLoadManager->reload($lngs, $ns);
    }

    /**
     * Load a module
     *
     * @param ModuleInterface $module
     * @return $this
     */
    public function useModule(ModuleInterface $module) {
        if ($module->getModuleType() === MODULE_TYPE_LANGUAGE_DETECTOR && $module instanceof BaseLanguageDetector) {
            $this->_modules['languageDetector'] = $module;
        }

        if ($module->getModuleType() === MODULE_TYPE_I18N_FORMAT) {
            $this->_modules['i18nFormat'] = $module;
        }

        if ($module->getModuleType() === MODULE_TYPE_POST_PROCESSOR && $module instanceof PostProcessorInterface) {
            $this->_postProcessor->addPostProcessor($module->getModuleName(), $module);
        }

        if ($module->getModuleType() === MODULE_TYPE_EXTERNAL) {
            $this->_modules['external'][] = $module;
        }

        if ($module->getModuleType() === MODULE_TYPE_LOADER) {
            $this->_loader = $module;
        }

        return $this;
    }

    /**
     * Change currently used language
     *
     * @param string $lng
     */
    public function changeLanguage(string $lng) {
        $setLng = function ($l) {
            if ($l) {
                $this->_language = $l;
                $this->_languages = $this->_services->_languageUtils->toResolveHierarchy($l);

                if (!$this->_translator->getLanguage())
                    $this->_translator->changeLanguage($l);

                if (isset($this->_services->_languageDetector))
                    $this->_services->_languageDetector->cacheUserLanguage($l);
            }

            $this->loadResources();

            $this->_translator->changeLanguage($l);
            $this->_logger->info('Language changed', ['language' => $l]);
        };

        // In JS this also has an async check, but no such thing is available or really required in PHP
        if (!$lng && isset($this->_services->_languageDetector))
            $setLng($this->_services->_languageDetector->detect());
        else
            $setLng($lng);
    }

    /**
     * Get a translation function locked to specific data
     *
     * @param $lng
     * @param $ns
     * @return \Closure
     */
    public function getFixedT($lng, $ns = null) {
        if ($ns === null)
            $ns = $this->_options['ns'] ?? ['translation'];

        if (!is_array($ns))
            $ns = [$ns];

        $staticOptions = [
            'ns'                                    =>  $ns,
            (is_string($lng) ? 'lng' : 'lngs')      =>  $lng
        ];

        return function ($key, $opts = null, ...$rest) use ($staticOptions) {
            if (!is_array($opts)) {
                $options = call_user_func($this->_options['overloadTranslationOptionHandler'], array_merge([$key, $opts], $rest));
            }
            else {
                $options = $opts;
            }

            $options['lng'] = $options['lng'] ?? $staticOptions['lng'] ?? null;
            $options['lngs'] = $options['lngs'] ?? $staticOptions['lngs'] ?? null;
            $options['ns'] = $options['ns'] ?? $staticOptions['ns'];

            // PHP fix because we don't actually want these garbage keys
            if ($options['lng'] === null)
                unset($options['lng']);

            if ($options['lngs'] === null)
                unset($options['lngs']);

            return $this->t($key, $options);
        };
    }

    /**
     * Translate text
     *
     * @param mixed ...$args
     * @return array|mixed|string|null
     */
    public function t(...$args) {
        return $this->_translator->translate(...$args) ?? null;
    }

    /**
     * Check if a key has a translation
     *
     * @param mixed ...$args
     * @return bool|null
     */
    public function exists(...$args) {
        return $this->_translator->exists(...$args) ?? null;
    }

    /**
     * Change default namespace
     *
     * @param string $ns
     */
    public function setDefaultNamespace(string $ns) {
        $this->_options['defaultNS'] = [$ns];
    }

    /**
     * Load namespaces
     *
     * @param string|string[] $ns
     */
    public function loadNamespaces($ns) {
        if (is_string($ns))
            $ns = [$ns];

        if (!is_array($ns)) {
            $this->_logger->warning('Invalid parameter passed to loadNamespaces', ['ns' => $ns]);
            return;
        }

        foreach ($ns as $n)
            if (!in_array($n, $this->_options['ns']))
                $this->_options['ns'][] = $n;

        $this->loadResources();
    }

    /**
     * Load languages
     *
     * @param string|string[] $lngs
     */
    public function loadLanguages($lngs) {
        if (is_string($lngs))
            $lngs = [$lngs];

        if (!is_array($lngs)) {
            $this->_logger->warning('Invalid parameter passed to loadLanguages', ['lngs' => $lngs]);
            return;
        }

        $preloaded = $this->_options['preload'] ?? [];
        $newLngs = array_filter($lngs, function($l) use ($preloaded) {
            return !in_array($l, $preloaded);
        });

        if (!count($newLngs))
            return;

        $this->_options['preload'] = array_merge($preloaded, $newLngs);
        $this->loadResources();
    }

    /**
     * Get text direction
     *
     * @param string|null $lng
     * @return string
     */
    public function dir(?string $lng): string {
        if (!$lng)
            $lng = $this->_languages[0] ?? $this->_language;

        if (!$lng)
            return 'rtl';

        return in_array($this->_services->_languageUtils->getLanguagePartFromCode($lng), RTL_LANGUAGES) ? 'rtl' : 'ltr';
    }

    /**
     * Overloaded clone operation
     *
     * @return $this
     */
    public function __clone() {
        $clone = clone $this;
        $clone->_options = array_merge($clone->_options, ['isClone' => true]);
        return $clone;
    }
}