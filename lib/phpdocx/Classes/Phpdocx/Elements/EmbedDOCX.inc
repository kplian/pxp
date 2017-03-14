<?php
namespace Phpdocx\Elements;
/**
 * Create DOCX from DOCX file
 *
 * @category   Phpdocx
 * @package    elements
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class EmbedDOCX extends CreateElement implements EmbedDocument
{

    /**
     *
     * @access private
     * @var int
     */
    private $_id = 0;

    /**
     *
     * @access private
     * @var string
     */
    private static $_instance = NULL;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_xml = '';

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
     * @return CreateText
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new EmbedDOCX();
        }
        return self::$_instance;
    }

    /**
     * Getter. Return current HTML ID
     *
     * @access public
     * @return int
     */
    public function getId()
    {
        return $this->_id;
    }

    /**
     * Embed HTML in DOCX
     *
     * @param bool $matchSource
     * @access public
     */
    public function embed($matchSource = false)
    {
        $this->_xml = '';
        $this->_id++;
        $this->generateALTCHUNK($matchSource);
    }

    /**
     * Generate w:altChunk
     *
     * @param bool $matchSource
     * @access protected
     */
    public function generateALTCHUNK($matchSource = false)
    {
        $this->_xml = '<' . CreateElement::NAMESPACEWORD .
                ':altChunk r:id="rDOCXId' . $this->_id . '" ' .
                'xmlns:r="http://schemas.openxmlformats.org/' .
                'officeDocument/2006/relationships" ' .
                'xmlns:w="http://schemas.openxmlformats.org/' .
                'wordprocessingml/2006/main" >';
        if ($matchSource) {
            $this->_xml .= '<w:altChunkPr><w:matchSrc/></w:altChunkPr>';
        }

        $this->_xml .= '</w:altChunk>';
    }

}
