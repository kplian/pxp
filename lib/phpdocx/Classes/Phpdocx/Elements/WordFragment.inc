<?php
namespace Phpdocx\Elements;
use Phpdocx\Create\CreateDocx;
use Phpdocx\Create\CreateDocxFromTemplate;
/**
 * Creates a Word fragment to be inserted elsewhere
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */

class WordFragment extends CreateDocx
{

    /**
     *
     * @access public
     * @var string
     */
    public $wordML;

    /**
     * Construct
     *
     * @param CreateDocx $docx
     * @param string $target document (default value), defaultHeader, firstHeader, evenHeader, defaultFooter, firstFooter, evenFooter, footnote, endnote, comment
     * @access public
     */
    public function __construct($docx = NULL, $target = 'document')
    {
        $this->wordML = '';
        $this->target = $target;
        if ($docx instanceof CreateDocx || $docx instanceof CreateDocxFromTemplate) {
            $this->_zipDocx = $docx->_zipDocx;
            $this->_contentTypeT = $docx->_contentTypeT;
            $this->_wordRelsDocumentRelsT = $docx->_wordRelsDocumentRelsT;
            $this->_wordFootnotesT = $docx->_wordFootnotesT;
            $this->_wordFootnotesRelsT = $docx->_wordFootnotesRelsT;
            $this->_wordEndnotesT = $docx->_wordEndnotesT;
            $this->_wordEndnotesRelsT = $docx->_wordEndnotesRelsT;
            $this->_wordCommentsT = $docx->_wordCommentsT;
            $this->_wordCommentsRelsT = $docx->_wordCommentsRelsT;
            $this->_wordNumberingT = $docx->_wordNumberingT;
        }
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
        return $this->wordML;
    }

    /**
     * Adds a chunk of raw WordML
     *
     * @access public
     * @param string $data
     */
    public function addRawWordML($data)
    {
        $this->wordML .= $data;
    }

    /**
     * returns only the runs of content for embedding
     *
     * @access public
     * @param string $data
     */
    public function inlineWordML()
    {
        $namespaces = 'xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" ';
        $wordML = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><w:root ' . $namespaces . '>' . $this->wordML;
        $wordML = $wordML . '</w:root>';
        $wordMLChunk = new \DOMDocument();
        $wordMLChunk->loadXML($wordML);
        $wordMLXpath = new \DOMXPath($wordMLChunk);
        $wordMLXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $wordMLXpath->registerNamespace('m', 'http://schemas.openxmlformats.org/wordprocessingml/2006/math');
        $query = '//w:r[not(ancestor::w:hyperlink or ancestor::v:textbox)] | //w:hyperlink | //w:bookmarkStart | //w:bookmarkEnd | //w:commentRangeStart | //w:commentRangeEnd | //m:oMath';
        $wrNodes = $wordMLXpath->query($query);
        $blockCleaned = '';
        foreach ($wrNodes as $node) {
            $nodeR = $node->ownerDocument->saveXML($node);
            $blockCleaned .= $nodeR;
        }
        return $blockCleaned;
    }

}
