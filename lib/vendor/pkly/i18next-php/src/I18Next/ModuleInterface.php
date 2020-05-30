<?php
/**
 * Created by PhpStorm.
 * User: pkly
 * Date: 26.09.2019
 * Time: 14:11
 */

namespace Pkly\I18Next;

const MODULE_TYPE_LANGUAGE_DETECTOR             =   'languageDetector';
const MODULE_TYPE_I18N_FORMAT                   =   'i18nFormat';
const MODULE_TYPE_POST_PROCESSOR                =   'postProcessor';
const MODULE_TYPE_EXTERNAL                      =   '3rdParty';
const MODULE_TYPE_LOADER                        =   'loader';

/**
 * Interface ModuleInterface
 *
 * Implement this interface in your class if you'd like to hook into I18next-php and simply useModule()
 *
 * @package I18Next
 */
interface ModuleInterface {
    /**
     * Tell I18n class which type of module you're implementing
     *
     * Allowed values are the const variables listed below
     *
     * @see MODULE_TYPE_LANGUAGE_DETECTOR
     * @see MODULE_TYPE_I18N_FORMAT
     * @see MODULE_TYPE_POST_PROCESSOR
     * @see MODULE_TYPE_EXTERNAL
     * @see MODULE_TYPE_LOADER
     * @return string
     */
    public function getModuleType(): string;

    /**
     * Simply specify module name
     *
     * Required unique for postProcessing, might show up in logs and the like
     *
     * @return string
     */
    public function getModuleName(): string;

    /**
     * Initialize module
     *
     * This is called by I18n
     *
     * @param \stdClass $services
     * @param array $options
     * @param I18n $instance
     */
    public function init(&$services, array $options, I18n &$instance): void;
}