<?php
namespace Phpdocx\Logger;
/**
 * Logger
 *
 * @category   Phpdocx
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class PhpdocxLogger
{

    /**
     *
     * @access private
     * @static
     * @var string
     */
    private static $_log = NULL;

    /**
     * Singleton, return instance of class
     *
     * @access public
     * @param $message Message to send to logging framework
     * @param $level Allowed values: trace, debug, info, warn, error, fatal
     * @static
     */
    public static function logger($message, $level)
    {
        $levels = array(
            'debug',
            'info',
            'notice',
            'warning',
            'error',
            'fatal',
        );

        if (!self::$_log) {
            \Logger::configure(dirname(__FILE__) . '/../../../config/log4php.php');
            self::$_log = \Logger::getLogger('phpdocx_logger');
        }

        // only some levels are valid
        if (in_array($level, $levels)) {
            $stringLevel = strtolower($level);
            self::$_log->$stringLevel($message);

            // stop phpdocx if fatal level
            if ($level == 'fatal') {
                throw new \Exception($message);
            }
        }
    }

    /**
     * Set a custom logger. It must follow the PSR3 messages.
     *
     * @access public
     * @param mixed $logger Custom logger
     * @static
     */
    public static function setLogger($logger)
    {
        self::$_log = $logger;
    }
}
