<?php
namespace Phpdocx\Elements;
/**
 * Create table of contents
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateTableContents extends CreateElement
{

    /**
     *
     * @var string
     * @access protected
     */
    protected $_xml;

    /**
     *
     * @var CreateTableContents
     * @access protected
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
     *
     * @return CreateTableContents
     * @access public
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateTableContents();
        }
        return self::$_instance;
    }

    /**
     * Create table of contents
     *
     * @param string $font
     * @access public
     */
    public function createTableContents($format, $legendData)
    {

        //We first construct the instructions for the TOC format
        $instr = 'TOC \o ';
        if (!empty($format['displayLevels'])) {
            $instr .= '&quot;' . $format['displayLevels'] . '&quot; ';
        } else {
            $instr .= '&quot;1-4&quot; ';
        }
        $instr .= '\h \z \u';

        //Generate the associated XML
        $fldSimpleStart = '<w:fldSimple w:instr="' . $instr . '">';
        $fldSimpleEnd = '</w:fldSimple>';
        $sdtStart = '<w:sdt><w:sdtPr><w:id w:val="' . rand(111111111, 999999999) . '" /> 
                    <w:docPartObj><w:docPartGallery w:val="Table of Contents" /> <w:docPartUnique /> 
                    </w:docPartObj></w:sdtPr><w:sdtContent>';
        $sdtEnd = '</w:sdtContent></w:sdt>';
        $legendData = $sdtStart . $legendData . $sdtEnd;
        $this->_xml = $legendData;
        $this->_xml = str_replace('<w:r>', $fldSimpleStart . '<w:r>', $this->_xml);
        $this->_xml = str_replace('</w:r>', '</w:r>' . $fldSimpleEnd, $this->_xml);
    }

}
