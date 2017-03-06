<?php
namespace Phpdocx;
/**
 * Autoloader
 *
 * @category   Phpdocx
 * @package    loader
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */



class AutoLoader
{

    /**
     * Main tags of relationships XML
     *
     * @access public
     * @static
     */
    public static function load()
    {
        spl_autoload_register(array('Phpdocx\AutoLoader', 'autoloadGenericClasses'));
        spl_autoload_register(array('Phpdocx\AutoLoader', 'autoloadLog4php'));
        spl_autoload_register(array('Phpdocx\AutoLoader', 'autoloadPdf'));
        spl_autoload_register(array('Phpdocx\AutoLoader', 'autoloadMht'));
    }

    /**
     * Autoload dompdf
     *
     * @access public
     * @param string $className Class to load
     */
    public static function autoloadDompdf($namespace)
    {
        
    }

    /**
     * Autoload phpdocx
     *
     * @access public
     * @param string $className Class to load
     */
    public static function autoloadGenericClasses($namespace)
    {
        $splitpath = explode('\\', $namespace);
        $path = '';
        $name = '';
        $firstword = true;
        for ($i = 0; $i < count($splitpath); $i++) {
            if ($splitpath[$i] && !$firstword) {
                if ($i == count($splitpath) - 1){
                    $name = $splitpath[$i];
                }
                else{
                    $path .= DIRECTORY_SEPARATOR . $splitpath[$i];
                }
            }
            if ($splitpath[$i] && $firstword) {
                if ($splitpath[$i] != __NAMESPACE__){
                    break;
                }
                $firstword = false;
            }
        }
        if (!$firstword) {
            $fullpath = __DIR__ . $path . DIRECTORY_SEPARATOR . $name . '.inc';
            if (file_exists($fullpath)) {
                return include_once($fullpath);
            }
            
        }
        return false;
    }

    function loadPath($absPath) 
    {
        return include_once($absPath);
    }

    /**
     * Autoload log4php
     *
     * @access public
     * @param string $className Class to load
     */
    public static function autoloadLog4php($namespace)
    {
        $className = explode('\\', $namespace);
        $className = $className[count($className)-1];
        $pathLogphp = dirname(__FILE__) . '/../../lib/log4php/'
                . $className . '.php';
        if (file_exists($pathLogphp)) {
            require_once $pathLogphp;
        }
    }

    /**
     * Autoload mht
     *
     * @access public
     * @param string $className Class to load
     */
    public static function autoloadMht($namespace)
    {
    	 $className = explode('\\', $namespace);
        $className = $className[count($className)-1];
        $pathMht = dirname(__FILE__) . '/../../lib/'
                . $className . '.php';
        if (file_exists($pathMht)) {
            require_once $pathMht;
        }
    }

    /**
     * Autoload PDF libraries
     *
     * @access public
     * @param string $className Class to load
     */
    public static function autoloadPdf($namespace)
    {
    	
        $className = explode('\\', $namespace);
        $className = $className[count($className)-1];

        $pathPDF = dirname(__FILE__) . '/../../lib/pdf/' . $className . '.inc';
        if (file_exists($pathPDF)) {
            require_once $pathPDF;
        }
        $pathDOMPDF = dirname(__FILE__) . '/../../lib/pdf/dompdf_config.inc.php';
        if (file_exists($pathDOMPDF)) {
            require_once $pathDOMPDF;
        }
        $pathTCPDF = dirname(__FILE__) . '/../../lib/pdf/tcpdf/tcpdf.php';
        if (file_exists($pathTCPDF)) {
            require_once $pathTCPDF;
        }
        $pathMainTCPDF = dirname(__FILE__) . '/../../lib/pdf/class.tcpdf.php';
        if (file_exists($pathMainTCPDF)) {
            require_once $pathMainTCPDF;
        }
        $pathFPDI = dirname(__FILE__) . '/../../lib/fpdi/fpdi.php';
        if (file_exists($pathFPDI)) {
            require_once $pathFPDI;
        }
    }

}
