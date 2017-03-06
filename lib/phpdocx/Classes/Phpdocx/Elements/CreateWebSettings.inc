<?php
namespace Phpdocx\Elements;
/**
 * Create default websettings XML
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateWebSettings extends CreateElement
{

    /**
     *
     * @access protected
     */
    protected $_xml;

    /**
     *
     * @access private
     * @static
     */
    private static $_instance = NULL;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        
    }

    /**
     * Destruct
     *
     * @access public
     */
    public function __destruct()
    {
        
    }

    /**
     * Magic method, returns current XML
     *
     * @access public
     * @return string Return current XML
     */
    public function __toString()
    {
        return $this->_xml;
    }

    /**
     * Singleton, return instance of class
     *
     * @access public
     * @return CreateWebSettings
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateWebSettings();
        }
        return self::$_instance;
    }

    /**
     * Main tags of websettings XML
     *
     * @access public
     */
    public function generateWebSettings()
    {
        $this->_xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>'
                . '<' . CreateElement::NAMESPACEWORD . ':webSettings '
                . 'xmlns:r="http://schemas.openxmlformats.org/officeDocument/'
                . '2006/relationships" xmlns:w="http://schemas.openxmlformats.'
                . 'org/wordprocessingml/2006/main"><'
                . CreateElement::NAMESPACEWORD . ':optimizeForBrowser /></'
                . CreateElement::NAMESPACEWORD . ':webSettings>';
    }

}
