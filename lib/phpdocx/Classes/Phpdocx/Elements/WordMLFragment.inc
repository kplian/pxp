<?php
namespace Phpdocx\Elements;
/**
 * Creates a WordML fragment to be inserted elsewhere
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class WordMLFragment extends CreateElement
{

    /**
     *
     * @access private
     * @var string
     */
    private $_wordML;

    /**
     *
     * @access private
     * @var string
     */
    private static $_instance = NULL;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        $this->_debug = Debug::getInstance();
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
        return $this->_wordML;
    }

    /**
     * Adds a chunk of raw WordML
     *
     * @access public
     * @param string $data
     */
    public function addRawWordML($data)
    {
        $this->_wordML .= $data;
    }

    /**
     * returns only the runs of content for embedding
     *
     * @access public
     * @param string $data
     */
    public function inlineWordML()
    {
        $wordMLChunk = new \DOMDocument();
        $namespaces = 'xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" ';
        $wordML = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><w:root ' . $namespaces . '>' . $this->_wordML;
        $wordML = $wordML . '</w:root>';
        $wordMLChunk->loadXML($wordML);
        $wordMLXpath = new \DOMXPath($wordMLChunk);
        $wordMLXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $wordMLXpath->registerNamespace('m', 'http://schemas.openxmlformats.org/wordprocessingml/2006/math');
        $query = '//w:r[not(ancestor::w:hyperlink)] | //w:hyperlink | //w:bookmarkStart | //w:bookmarkEnd | //w:commentRangeStart | //w:commentRangeEnd | //m:oMath';
        $wrNodes = $wordMLXpath->query($query);
        $blockCleaned = '';
        foreach ($wrNodes as $node) {
            $nodeR = $node->ownerDocument->saveXML($node);
            $blockCleaned .= $nodeR;
        }

        return $blockCleaned;
    }

}
