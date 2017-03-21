<?php
namespace Phpdocx\Elements;
use Phpdocx\Create\CreateDocx;
/**
 * Use DOCX as templates
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateTemplate
{

    /**
     * @access public
     * @var array
     * @static
     */
    public static $embedFiles = array();

    /**
     * @access public
     * @var string
     * @static
     */
    public static $path;

    /**
     * @access public
     * @var array
     * @static
     */
    public static $placeholderImages = array();

    /**
     * @access public
     * @var array
     * @static
     */
    public static $placeholderHeaderImages = array();

    /**
     * @access public
     * @var int
     * @static
     */
    public static $ridInitTemplateCharts;

    /**
     * @access public
     * @var string
     * @static
     */
    public static $templateVariables = array();

    /**
     * @access public
     * @var int
     * @static
     */
    public static $totalTemplateCharts;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_chartsRelsChartXMLRels;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_contentTypes;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_document;

    /**
     * @access private
     * @var array
     * @static
     */
    private static $_footer = array();

    /**
     * @access private
     * @var array
     * @static
     */
    private static $_header = array();

    /**
     * @access private
     * @var int
     */
    private $_idDOCX = 1;

    /**
     * @access private
     * @var int
     */
    private $_idHTML = 1;

    /**
     * @access private
     * @var int
     */
    private $_idMHT = 1;

    /**
     * @access private
     * @var int
     */
    private $_idRTF = 1;

    /**
     * @access private
     * @var CreateTemplate
     * @static
     */
    private static $_instance = NULL;

    /**
     * @access private
     * @var boolean
     */
    private $_isDOCX = false;

    /**
     * @access private
     * @var boolean
     */
    private $_isHTML = false;

    /**
     * @access private
     * @var boolean
     */
    private $_isMHT = false;

    /**
     * @access private
     * @var boolean
     */
    private $_isRTF = false;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_numbering;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_relsDocumentXMLRels;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_styles;

    /**
     * @access private
     * @var bool
     * @static
     */
    private static $_template;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_templateGroupSymbol = '|';

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_templateSymbol = '$';

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
     *
     * @access public
     * @return CreateTemplate
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateTemplate();
        }
        return self::$_instance;
    }

    /**
     * Check if DOCX is a template
     *
     * @access public
     * @return boolean
     * @static
     */
    public static function getBlnTemplate()
    {
        return self::$_template;
    }

    /**
     * Return current document word
     *
     * @access public
     * @return string
     * @static
     */
    public static function getDocument()
    {
        // before returning the document we include a sentence for the trial version
        $docDOM = new \DOMDocument();
        $docDOM->loadXML(self::$_document);
        $docXPath = new \DOMXPath($docDOM);
        $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:body/w:sectPr';
        $nodes = $docXPath->query($query);
        if ($nodes->length > 0) {
            $newNode = $docDOM->createDocumentFragment();
            $message = '<w:p xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
                            <w:r>
                                <w:t>This document has been generated with a</w:t>
                            </w:r>
                            <w:r>
                                <w:rPr>
                                    <w:b/>
                                </w:rPr>
                                <w:t xml:space="preserve"> trial</w:t>
                            </w:r>
                            <w:r>
                                <w:t xml:space="preserve"> copy of </w:t>
                            </w:r>
                            <w:r>
                                <w:rPr>
                                    <w:b/>
                                </w:rPr>
                                <w:t>PHPDocX</w:t>
                            </w:r>
                            <w:r>
                                <w:t>. Please</w:t>
                            </w:r>
                            <w:r>
                                <w:t>, visit</w:t>
                            </w:r>
                            <w:r>
                                <w:t xml:space="preserve"> the </w:t>
                            </w:r>
                            <w:r>
                                <w:fldChar w:fldCharType="begin" />
                            </w:r>
                            <w:r>
                                <w:instrText xml:space="preserve">HYPERLINK "http://www.phpdocx.com"</w:instrText>
                            </w:r>
                            <w:r>
                                <w:fldChar w:fldCharType="separate" />
                            </w:r>
                            <w:r>
                                <w:rPr>
                                    <w:b/>
                                    <w:color w:val="3333EE"/>
                                    <w:u/>
                                </w:rPr>
                                <w:t xml:space="preserve">PHPDocX website</w:t>
                            </w:r>
                            <w:r>
                                <w:fldChar w:fldCharType="end" />
                            </w:r>
                            <w:r>
                                <w:t xml:space="preserve"> to buy the license that best adapts to your needs.</w:t>
                            </w:r>
                        </w:p>';
            $newNode->appendXML($message);
            $sect = $nodes->item(0);
            $sect->parentNode->insertBefore($newNode, $sect);
            self::$_document = $docDOM->saveXML();
        }

        return self::$_document;
    }

    /**
     * Return current document footer
     *
     * @access public
     * @return array
     * @static
     */
    public static function getFooter()
    {
        return self::$_footer;
    }

    /**
     * Return current document header
     *
     * @access public
     * @return array
     * @static
     */
    public static function getHeader()
    {
        return self::$_header;
    }

    /**
     * Return current document word
     *
     * @access public
     * @return string
     * @static
     */
    public static function getNumbering()
    {
        return self::$_numbering;
    }

    /**
     * Return current document styles
     *
     * @access public
     * @return string
     * @static
     */
    public static function getStyles()
    {
        return self::$_styles;
    }

    /**
     * Getter. Return template group symbol
     *
     * @access public
     * @return string
     * @static
     */
    public static function getTemplateGroupSymbol()
    {
        return self::$_templateGroupSymbol;
    }

    /**
     * Setter. Change if DOCX is a template
     *
     * @access public
     * @return void
     * @static
     */
    public static function setBlnTemplate($enable)
    {
        self::$_template = $enable;
    }

    /**
     * Setter. Set template group symbol
     *
     * @access public
     * @param string $templateGroupSymbol
     * @static
     */
    public static function setTemplateGroupSymbol($templateGroupSymbol)
    {
        self::$_templateGroupSymbol = $templateGroupSymbol;
    }

    /**
     * Getter. Return template symbol
     *
     * @access public
     * @return string
     * @static
     */
    public static function getTemplateSymbol()
    {
        return self::$_templateSymbol;
    }

    /**
     * Setter. Set template symbol
     *
     * @access public
     * @param string $templateSymbol
     * @static
     */
    public static function setTemplateSymbol($templateSymbol)
    {
        self::$_templateSymbol = $templateSymbol;
    }

    /**
     * Getter. Return template Variables
     *
     * @access public
     * @return array
     * @static
     */
    public function getTemplateVariables()
    {
        return self::$templateVariables;
    }

    /**
     * Setter. Set template Variables
     *
     * @access public
     * @param array $templateVariables
     * @static
     */
    public function setTemplateVariables($templateVariables)
    {
        self::$templateVariables = $templateVariables;
    }

    /**
     * Return current rels document xml rels
     *
     * @access public
     * @return string
     * @static
     */
    public static function getRelsDocumentXMLRels()
    {
        return self::$_relsDocumentXMLRels;
    }

    /**
     * Return current content types
     *
     * @access public
     * @return string
     * @static
     */
    public static function getContentTypes()
    {
        return self::$_contentTypes;
    }

    /**
     * Add content types
     *
     * @access public
     * @param string $args[0]
     * @static
     */
    public static function addContentTypes()
    {
        $args = func_get_args();

        if (strstr(self::$_contentTypes, 'Default Extension="xlsx"') &&
                $args[0] == '<Default Extension="xlsx" ContentType="application' .
                '/octet-stream"> </Default>'
        ) {
            return;
        }
        // let´s check that tha content type does not exist yet
        if ((strpos(self::$_contentTypes, $args[0]) === false &&
                strpos($args[0], 'Extension="jpg"') === false) ||
                (strpos($args[0], 'Extension="jpg"') !== false &&
                strpos(self::$_contentTypes, 'Extension="jpg"') === false)) {
            $domContentTypes = new \DomDocument();
            $domContentTypes->loadXML(self::$_contentTypes);
            $xmlTypes = $domContentTypes->getElementsByTagName('Types');
            $xmlNewContentType = $domContentTypes->createDocumentFragment();
            $xmlNewContentType->appendXML($args[0]);
            $xmlTypes->item(0)->appendChild($xmlNewContentType);
            self::$_contentTypes = $domContentTypes->saveXML();
        }
    }

    /**
     * Add relationship
     *
     * @access public
     * @param string $args[0]
     * @static
     */
    public static function addRelationship()
    {
        $args = func_get_args();

        $domRelsDocumentXMLRels = new \DomDocument();
        $domRelsDocumentXMLRels->loadXML(self::$_relsDocumentXMLRels);
        $xmlTypes = $domRelsDocumentXMLRels->getElementsByTagName(
                'Relationships'
        );
        $xmlNewRelationship = $domRelsDocumentXMLRels->createDocumentFragment();
        $xmlNewRelationship->appendXML($args[0]);
        $xmlTypes->item(0)->appendChild($xmlNewRelationship);

        self::$_relsDocumentXMLRels = $domRelsDocumentXMLRels->saveXML();
    }

    /**
     * Checks or unchecks a template checkbox
     *
     * @access public
     * @param string $var variable name
     * @param int $value
     */
    public function checkCheckbox($var, $value = 1)
    {
        $searchTerm = self::$_templateSymbol . $var . self::$_templateSymbol;
        $domDocument = new \DOMDocument();
        $domDocument->loadXML(self::$_document);
        $docXPath = new \DOMXPath($domDocument);
        $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $docXPath->registerNamespace('w14', 'http://schemas.microsoft.com/office/word/2010/wordml');
        // check for legacy checkboxes
        $queryDoc = '//w:ffData[w:statusText[@w:val="' . $searchTerm . '"]]';
        $affectedNodes = $docXPath->query($queryDoc);
        foreach ($affectedNodes as $node) {
            $nodeVals = $node->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'default');
            $nodeVals->item(0)->setAttribute('w:val', $value);
        }
        // look for Word 2010 sdt checkboxes
        $queryDoc = '//w:sdtPr[w:tag[@w:val="' . $searchTerm . '"]]';
        $affectedNodes = $docXPath->query($queryDoc);
        foreach ($affectedNodes as $node) {
            $nodeVals = $node->getElementsByTagNameNS('http://schemas.microsoft.com/office/word/2010/wordml', 'checked');
            $nodeVals->item(0)->setAttribute('w14:val', $value);
            // change the selected symbol for checked or unchecked
            $sdt = $node->parentNode;
            $txt = $sdt->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 't');
            if ($value == 1) {
                $txt->item(0)->nodeValue = '☒';
            } else {
                $txt->item(0)->nodeValue = '☐';
            }
        }

        self::$_document = $domDocument->saveXML($domDocument->documentElement);
    }

    /**
     * Clear all the placeholders which start with 'BLOCK_'
     *
     * @access public
     */
    public static function deleteAllBlocks()
    {
        // sometimes Word splits tags. Find and replace all of them with
        // new string surrounded by template symbol value
        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        foreach ($documentSymbol as $documentSymbolValue) {
            if (strpos(strip_tags($documentSymbolValue), 'BLOCK_') !== false) {
                self::$_document = str_replace($documentSymbolValue, strip_tags($documentSymbolValue), self::$_document);
            }
        }
        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);

        $xmlWP = $domDocument->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p');
        $xpath = new \DOMXPath($domDocument);
        $length = $xmlWP->length;
        $itemsWP = array();
        for ($i = 0; $i < $length; $i++) {
            $itemsWP[$i] = $xmlWP->item($i);
        }
        $query = 'w:r/w:t';
        for ($i = 0; $i < $length; $i++) {
            $variables = $xpath->query($query, $itemsWP[$i]);
            $deleteCurrent = false;
            foreach ($variables as $entry) {

                if (
                        strpos($entry->nodeValue, self::$_templateSymbol . 'BLOCK_'
                        ) !== false
                ) {
                    //when we find a placeholder, we delete it
                    $deleteCurrent = true;
                    break;
                }
            }
            if ($deleteCurrent) {
                $padre = $itemsWP[$i]->parentNode;
                $padre->removeChild($itemsWP[$i]);
                self::$_document = $domDocument->saveXML();
            }
        }
    }

    /**
     * Clear a specific placeholder which starts with 'BLOCK_'
     *
     * @access public
     * @param string $blockName Block name
     */
    public function deleteBlock($blockName)
    {
        $aType = array('BLOCK_', 'TAB_'); //deletables types
        foreach ($aType as $type) {
            self::parseBlock($type . $blockName);
            self::$_document = preg_replace('/\\' . self::$_templateSymbol . $type . $blockName . '([|]|\\' . self::$_templateSymbol . ').*?\\' . self::$_templateSymbol . $type . $blockName . '.*?\\' . self::$_templateSymbol . '/', '', self::$_document);
            /* $ini = strpos(self::$_document, self::$_templateSymbol . $type . $blockName . self::$_templateSymbol);
              //CreateDocx::$log->info('borra bloque ' . $ini . '.');
              if ($ini !== false) {
              $end = strpos(self::$_document, self::$_templateSymbol . $type . $blockName . self::$_templateSymbol, $ini + 1);
              if ($end !== false) {
              self::$_document = substr(self::$_document, 0, $ini) .
              substr(self::$_document, $ini + (strlen(self::$_templateSymbol . $type . $blockName . self::$_templateSymbol) * 2) + $end);
              }
              } */
        }
    }

    /**
     * Extract the headers or the footers for the merging
     *
     * @access private
     */
    private function extractHeaderFooter($document, $relsWord, $type)
    {
        $domDocument = new \DomDocument();
        $domDocument->loadXML($document);
        // check if there are footers
        $xmlWP = $domDocument->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', $type . 'Reference');
        $length = $xmlWP->length;
        $itemsWP = array();
        $buenos = array();
        for ($i = 0; $i < $length; $i++) {
            if ($xmlWP->item($i)->attributes->getNamedItem("type")->nodeValue == 'default') {
                // only extract the footers or the headers which are used in document.xml
                $itemsWP[$xmlWP->item($i)->attributes->getNamedItem("id")->nodeValue] = $xmlWP->item($i)->attributes->getNamedItem("type")->nodeValue;
                $buenos[] = $xmlWP->item($i)->attributes->getNamedItem("id")->nodeValue;
            }
        }
        $domDocument = new \DomDocument();
        $domDocument->loadXML($relsWord);
        $xmlWP = $domDocument->getElementsByTagName('Relationship');
        $length = $xmlWP->length;
        $newfooters = array();
        for ($i = 0; $i < $length; $i++) {
            $aux = $xmlWP->item($i);
            foreach ($buenos as $val) {
                if ($aux->attributes->getNamedItem("Id")->nodeValue == $val) {
                    // get the rId from the footers and headers
                    $newfooters[$aux->attributes->getNamedItem("Target")->nodeValue]['rid'] = $aux->attributes->getNamedItem("Id")->nodeValue;
                    $newfooters[$aux->attributes->getNamedItem("Target")->nodeValue]['node'] = $domDocument->saveXML($aux);
                }
            }
        }
        return $newfooters;
    }

    /**
     * Merge the content, the footer and the header from two files
     *
     * @access public
     * @param  $path1 File path
     * @param  $path2 File path
     */
    public function mergeFiles($path1, $path2)
    {
        // use the first file as template
        self::openTemplate($path1);
        $_newFile = tempnam(sys_get_temp_dir(), 'merge_phpdocx');
        copy($path2, $_newFile);
        if (file_exists($_newFile)) {
            $docx = new \ZipArchive();
            $docx->open($_newFile);
            // read document.xml file and extract the wordxml content
            $fullContent = $docx->getFromName('word/document.xml');
            $fullContent = self::cleanDocument($fullContent);

            $startedRemovedUnwantedContent = explode('<w:body>', $fullContent);
            $endedRemovedUnwantedContent = explode('</w:body', $startedRemovedUnwantedContent[1]);
            $newDocumentXml = $endedRemovedUnwantedContent[0];
            // extract files from the zip
            $relsWord = $docx->getFromName('word/_rels/document.xml.rels');
            $_contentType = $docx->getFromName('[Content_Types].xml');
            self::$_document = self::prepareSections(self::$_document);
            self::$_document = str_replace('</w:body', str_replace($aToBeReplace, $aToReplace, $newDocumentXml) . '</w:body', self::$_document);
        }
    }

    /**
     * Open current template
     *
     * @access public
     * @param string $args[0]
     * @static
     */
    public function openTemplate()
    {
        $args = func_get_args();

        $this->objTemplate = new \ZipArchive();

        self::$path = $args[0];
        self::$_template = 1;
        $this->_idDOCX = 1;
        $this->_idHTML = 1;
        $this->_idMHT = 1;
        $this->_idRTF = 1;
        $this->_isDOCX = false;
        $this->_isHTML = false;
        $this->_isMHT = false;
        $this->_isRTF = false;
        $this->objTemplate->open(self::$path);

        self::$_document = $this->objTemplate->getFromName('word/document.xml');

        if ($this->objTemplate->statName('word/_rels/document.xml.rels')) {
            self::$_relsDocumentXMLRels = $this->objTemplate->getFromName(
                    'word/_rels/document.xml.rels'
            );

            $this->getCurrentRID();
        }

        if ($this->objTemplate->statName('word/charts/_rels/chart1.xml.rels')) {
            self::$_chartsRelsChartXMLRels = $this->objTemplate->getFromName(
                    'word/charts/_rels/chart1.xml.rels'
            );
        }

        if ($this->objTemplate->statName('[Content_Types].xml')) {
            self::$_contentTypes = $this->objTemplate->getFromName(
                    '[Content_Types].xml'
            );

            //Required manipulations for inserting a backgroundImage in the trial
            $docDOM = new \DOMDocument();
            $docDOM->loadXML(self::$_document);
            $bgElements = $docDOM->documentElement->getElementsByTagname('background');
            if ($bgElements->length > 0) {
                $bgElements->item(0)->parentNode->removeChild($bgElements->item(0));
            }
            $uid = uniqid(mt_rand(999, 9999));
            $imageId = 'rId' . $uid;
            $bgFrag = '<w:background w:color="FFFFFF" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
                    <v:background id="_x0000_s1025" o:bwmode="white" o:targetscreensize="1024,768" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:v="urn:schemas-microsoft-com:vml">
                        <v:fill r:id="' . $imageId . '" o:title="xsdef" recolor="t" type="frame" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>
                    </v:background>
                </w:background>';
            $docFrag = $docDOM->createDocumentFragment();
            $docFrag->appendXML($bgFrag);
            $bodyElement = $docDOM->documentElement->getElementsByTagname('body')->item(0);
            $bodyElement->parentNode->insertBefore($docFrag, $bodyElement);
            $this->addContentTypes('<Default Extension="jpg" ContentType="image/jpg" />');
            $this->addRelationship('<Relationship Id="' . $imageId .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image ' .
                    'Target="media/image' . $uid . '.jpg"/>');

            // add source and dest filepath
            self::$embedFiles[] = array(
                'src_file' => dirname(__FILE__) . '/../examples/files/img/image.jpg',
                'dest_file' => 'word/media/image' . $uid . '.jpg'
            );

            self::$_document = $docDOM->saveXML();

            // get headers
            $xpathHeaders = new \SimpleXMLElement(self::$_contentTypes);
            $xpathHeaders->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/content-types');
            $xpathHeadersResults = $xpathHeaders->xpath('ns:Override[@ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml"]');
            foreach ($xpathHeadersResults as $headersResults) {
                self::$_header[substr($headersResults['PartName'], 1)] = $this->objTemplate->getFromName(
                        substr($headersResults['PartName'], 1)
                );
            }

            // get footers
            $xpathFooters = new \SimpleXMLElement(self::$_contentTypes);
            $xpathFooters->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/content-types');
            $xpathFootersResults = $xpathFooters->xpath('ns:Override[@ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml"]');
            foreach ($xpathFootersResults as $footersResults) {
                self::$_footer[substr($footersResults['PartName'], 1)] = $this->objTemplate->getFromName(
                        substr($footersResults['PartName'], 1)
                );
            }
        }

        if ($this->objTemplate->statName('word/charts/_rels/chart1.xml.rels')) {
            self::$_chartsRelsChartXMLRels = $this->objTemplate->getFromName(
                    'word/charts/_rels/chart1.xml.rels'
            );
        }
        if ($this->objTemplate->statName('word/styles.xml')) {
            self::$_styles = $this->objTemplate->getFromName(
                    'word/styles.xml'
            );
        }
        if ($this->objTemplate->statName('word/numbering.xml')) {
            self::$_numbering = $this->objTemplate->getFromName(
                    'word/numbering.xml'
            );
        } else {
            self::$_numbering = '';
            $this->addRelationship('<Relationship Id="rI' . rand(9999999, 999999999) . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml" />');
            $this->addContentTypes('<Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml" />
');
        }
    }

    /**
     * Prepare the placeholder. Clear the wordXML code between the characters of the placeholder.
     *
     * @access public
     * @param string $blockName Block name
     */
    public function parseBlock($blockName)
    {
        // sometimes Word splits tags. Find and replace all of them with
        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        foreach ($documentSymbol as $documentSymbolValue) {
            if (strip_tags($documentSymbolValue) == $blockName) {
                self::$_document = str_replace($documentSymbolValue, $blockName, self::$_document);
            }
        }
    }

    /**
     * Prepare sections for merging
     *
     * @access public
     */
    public function prepareSections($document)
    {
        $domDocument = new \DomDocument();
        $domDocument->loadXML($document);
        // check if there are footers
        $xmlWSectPr = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'sectPr');

        $length = $xmlWSectPr->length;
        // get the last section to modify
        $itemsWSectPr = $xmlWSectPr->item($length - 1);
        $new = $itemsWSectPr->cloneNode(true);
        $padre = $itemsWSectPr->parentNode;
        $padre->removeChild($itemsWSectPr);


        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p');
        $length = $xmlWP->length;
        $itemsWP = $xmlWP->item($length - 1);
        if ($itemsWP->hasChildNodes()) {
            $existspPr = false;
            $aSons = array();
            foreach ($itemsWP->childNodes as $hijo) {
                if ($hijo->tagName == 'w:pPr') {
                    $existspPr = true;
                    foreach ($hijo->childNodes as $nieto) {
                        if ($nieto->tagName == 'w:sectPr') {
                            $hijo->removeChild($nieto);
                        }
                    }
                    $hijo->appendChild($new);
                } else {
                    $aSons[] = $hijo->cloneNode(true);
                    $itemsWP->removeChild($hijo);
                }
            }
            if (!$existspPr) {
                $node = $domDocument->createElement("w:pPr");
                $node->appendChild($new);
                $itemsWP->appendChild($node);
                foreach ($aSons as $val) {
                    $itemsWP->appendChild($val);
                }
            }
        } else {
            $node = $domDocument->createElement("w:pPr");
            $node->appendChild($new);
            $itemsWP->appendChild($node);
        }
        return $domDocument->saveXML();
    }

    /**
     * Removes the paragraph containing a variable and replaces it for a special altChunk tag
     *
     * @access public
     * @param string $variableName
     */
    public function removeParentParagraph($variableName)
    {
        // use XPath to find all paragraphs that include the variable name
        $name = self::$_templateSymbol . $variableName . self::$_templateSymbol;
        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);
        $xpath = new \DOMXPath($domDocument);
        $xpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:p[w:r/w:t[text()[contains(.,"' . $variableName . '")]]]';
        $affectedNodes = $xpath->query($query);
        foreach ($affectedNodes as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $name, 0)) !== false) {
                //Insert a "fake node" that we can later remove
                $alt = $domDocument->createElement('alternativeContent', $name);
                $node->parentNode->insertBefore($alt, $node);
                //If we remove a paragraph inside a table cell we need to take special care
                if ($node->parentNode->nodeName == 'w:tc') {
                    $tcChilds = $node->parentNode->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p');
                    if ($tcChilds->length > 1) {
                        $node->parentNode->removeChild($node);
                    } else {
                        $emptyP = $domDocument->createElement("w:p");
                        $node->parentNode->appendChild($emptyP);
                        $node->parentNode->removeChild($node);
                    }
                } else {
                    $node->parentNode->removeChild($node);
                }
            }
        }
        self::$_document = $domDocument->saveXML();
    }

    /**
     * Removes a template variable with its container paragraph
     *
     * @access public
     * @param string $variableName
     * @param string $type
     */
    public function removeVariable($variableName)
    {
        // sometimes Word splits tags. Find and replace all of them with
        // new string surrounded by template symbol value
        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        foreach ($documentSymbol as $documentSymbolValue) {
            // ignore group [tag_name|group]
            $tempSearch = explode('|', trim(strip_tags($documentSymbolValue)));
            $tempSearch = $tempSearch[0];
            if ($tempSearch == $variableName) {
                $pos = strpos(self::$_document, $documentSymbolValue);
                if ($pos !== false) {
                    self::$_document = substr_replace(self::$_document, $var, $pos, strlen($documentSymbolValue));
                }
            }
        }
        // use XPath to find all paragraphs that include the variable name
        $name = self::$_templateSymbol . $variableName . self::$_templateSymbol;
        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);
        $xpath = new \DOMXPath($domDocument);
        $xpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:p[w:r/w:t[text()[contains(.,"' . $variableName . '")]]]';
        $affectedNodes = $xpath->query($query);
        foreach ($affectedNodes as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $name, 0)) !== false) {
                // if a paragraph inside a table cell is removed it's needed to take special care
                if ($node->parentNode->nodeName == 'w:tc') {
                    $tcChilds = $node->parentNode->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p');
                    if ($tcChilds->length > 1) {
                        $node->parentNode->removeChild($node);
                    } else {
                        $emptyP = $domDocument->createElement("w:p");
                        $node->parentNode->appendChild($emptyP);
                        $node->parentNode->removeChild($node);
                    }
                } else {
                    $node->parentNode->removeChild($node);
                }
            }
        }
        self::$_document = $domDocument->saveXML();
    }

    /**
     * Replace chart in template
     *
     * @access public
     * @param string $args[0]
     * @static
     */
    public static function replaceChart()
    {
        $args = func_get_args();
        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        foreach ($documentSymbol as $documentSymbolValue) {
            if (strip_tags($documentSymbolValue) == $args[0]) {
                $pos = strpos(self::$_document, $documentSymbolValue);
                if ($pos !== false) {
                    self::$_document = substr_replace(self::$_document, strip_tags($documentSymbolValue), $pos, strlen($documentSymbolValue));
                }
            }
        }

        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);

        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p'
        );
        $xpath = new \DOMXPath($domDocument);
        $query = 'w:r/w:t';
        for ($i = 0; $i < $xmlWP->length; $i++) {
            $xmlGraphics = $xpath->query($query, $xmlWP->item($i));
            foreach ($xmlGraphics as $entry) {
                $pos = strpos($entry->nodeValue, self::$_templateSymbol . $args[0] . self::$_templateSymbol);
                if ($pos !== false) {
                    $domChart = $entry->parentNode->parentNode;
                    $xmlR = $domChart->getElementsByTagNameNS(
                                    'http://schemas.openxmlformats.org/wordprocessingml/' .
                                    '2006/main', 'r'
                            )->item(0);

                    $domChart->removeChild($xmlR);
                    $domVarChart = $domDocument->createElement(
                            'varchart_' . CreateDocx::$intIdWord
                    );
                    $domChart->appendChild($domVarChart);
                }
            }
        }
        self::$_document = $domDocument->saveXML();
        self::$totalTemplateCharts++;
    }

    /**
     * Replace a placeholder with a checkbox
     *
     * @access public
     * @param string checkName Checkbox variable name
     * @param string $value Value
     */
    public function replaceCheckbox($checkName, $value)
    {
        self::parseBlock('CHECK_' . $checkName);
        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);

        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p'
        );
        $xpath = new \DOMXPath($domDocument);
        $length = $xmlWP->length;
        $itemsWP = array();
        for ($i = 0; $i < $length; $i++) {
            $itemsWP[$i] = $xmlWP->item($i);
        }
        $query = 'w:r/w:t';
        for ($i = 0; $i < $length; $i++) {
            $variables = $xpath->query($query, $itemsWP[$i]);
            foreach ($variables as $entry) {
                if (
                        strpos($entry->nodeValue, self::$_templateSymbol . 'CHECK_' . $checkName . self::$_templateSymbol) !== false
                ) {
                    $entry->setAttribute('xml:space', 'preserve');
                    $padre = $entry->parentNode->parentNode;
                    $newNode = $domDocument->createElement('w:r', '');
                    $newNode2 = $domDocument->createElement('w:sym', '');
                    $newNode2->setAttribute('w:font', 'Wingdings');
                    if ($value)
                        $newNode2->setAttribute('w:char', 'F0FE');
                    else
                        $newNode2->setAttribute('w:char', 'F06F');
                    $newNode->appendChild($newNode2);
                    $padre->insertBefore($newNode, $entry->parentNode);

                    break;
                }
            }
        }
        self::$_document = str_replace(self::$_templateSymbol . 'CHECK_' . $checkName . self::$_templateSymbol, '', $domDocument->saveXML());
    }

    /**
     * Replace image in headers
     *
     * @access public
     * @param string $args[0]
     * @param string $args[1]
     * @static
     */
    public function replaceHeaderImage()
    {
        $args = func_get_args();

        $domDocument = new \DomDocument();
        foreach (self::$_header as $key => $header) {
            $domDocument->loadXML(self::$_header[$key]);
            $domImages = $domDocument->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/' .
                    'wordprocessingDrawing', 'docPr');
            $domImagesId = $domDocument->getElementsByTagNameNS(
                    'http://schemas.openxmlformats.org/drawingml/2006/main', 'blip'
            );
            for ($i = 0; $i < $domImages->length; $i++) {
                if ($domImages->item($i)->getAttribute('descr') ==
                        self::$_templateSymbol . $args[0] . self::$_templateSymbol) {
                    $ind = $domImages->item($i)->parentNode
                                    ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/main', 'blip')
                                    ->item(0)->getAttribute('r:embed');
                    //Now we search this id in header$i.xml.rels
                    $keyNameArray = explode('/', $key);
                    $keyName = $keyNameArray[1];
                    if ($this->objTemplate->statName('word/_rels/' . $keyName . '.rels')) {
                        $tempXMLRelsHeader = $this->objTemplate->getFromName('word/_rels/' . $keyName . '.rels');
                        $domHeader = new \DomDocument();
                        $domHeader->loadXML($tempXMLRelsHeader);
                        $domRelationships = $domHeader->getElementsByTagName('Relationship');
                        foreach ($domRelationships as $domRelationship) {
                            $id = $domRelationship->getAttribute('Id');
                            if ($id == $ind) {
                                self::$placeholderHeaderImages[$args[1]] = 'word/' . $domRelationship->getAttribute('Target');
                            }
                        }
                    }
                }
            }
        }
    }

    /**
     * Replace images in the media folder for header images replacement
     *
     * @access public
     * @param ZipArchive $docxTemplate
     * @static
     */
    public static function replaceHeaderMediaImages(&$docxTemplate)
    {
        foreach (self::$placeholderHeaderImages as $key => $value) {
            $docxTemplate->addFile($key, $value);
        }
    }

    /**
     * Replace image in template
     *
     * @access public
     * @param string $args[0]
     * @param string $args[1]
     * @param string $args[2]
     * @static
     */
    public function replaceImage()
    {
        $args = func_get_args();
        $cx = 0;
        $cy = 0;

        //we get the name and extension of the replacement image
        $imageNameArray = explode('/', $args[1]);
        if (count($imageNameArray) > 1) {
            $imageName = array_pop($imageNameArray);
        } else {
            $imageName = $args[1];
        }
        $imageExtensionArray = explode('.', $args[1]);
        $extension = strtolower(array_pop($imageExtensionArray));

        $wordScaleFactor = 360000;
        if (isset($args[2]['dpi'])) {
            $dpiX = $args[2]['dpi'];
            $dpiY = $args[2]['dpi'];
        } else {
            if ((isset($args[2]['width']) && $args[2]['width'] == 'auto') ||
                    (isset($args[2]['height']) && $args[2]['height'] == 'auto')) {
                if ($extension == 'jpg' || $extension == 'jpeg') {
                    list($dpiX, $dpiY) = $this->getDpiJpg($args[1]);
                } else if ($extension == 'png') {
                    list($dpiX, $dpiY) = $this->getDpiPng($args[1]);
                } else {
                    $dpiX = 96;
                    $dpiY = 96;
                }
            }
        }


        //we check if a width and height have been set
        $width = 0;
        $height = 0;
        if (isset($args[2]['width']) && $args[2]['width'] != 'auto') {
            $cx = (int) $args[2]['width'] * $wordScaleFactor;
        }
        if (isset($args[2]['height']) && $args[2]['height'] != 'auto') {
            $cy = (int) $args[2]['height'] * $wordScaleFactor;
        }
        //We proceed to compute the sizes if the width or height are set to auto
        if ((isset($args[2]['width']) && $args[2]['width'] == 'auto') ||
                (isset($args[2]['height']) && $args[2]['height'] == 'auto')) {
            $realSize = getimagesize($args[1]);
        }
        if (isset($args[2]['width']) && $args[2]['width'] == 'auto') {
            $cx = (int) round($realSize[0] * 2.54 / $dpiX * $wordScaleFactor);
        }
        if (isset($args[2]['height']) && $args[2]['height'] == 'auto') {
            $cy = (int) round($realSize[1] * 2.54 / $dpiY * $wordScaleFactor);
        }

        $domDocument = new \DomDocument();
        $domDocument->loadXML(self::$_document);

        $domImages = $domDocument->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/' .
                'wordprocessingDrawing', 'docPr');

        for ($i = 0; $i < $domImages->length; $i++) {
            if ($domImages->item($i)->getAttribute('descr') ==
                    self::$_templateSymbol . $args[0] . self::$_templateSymbol) {
                //create a new Id
                $ind = 'rId' . uniqid(mt_rand(999, 9999));
                //populate the reference array
                self::$placeholderImages[$ind] = $args[1];
                //generate new relationship
                $relString = '<Relationship Id="' . $ind . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/' . $imageName . '" />';
                $this->addRelationship($relString);
                //generate content type if it does not exist yet
                $ctString = '<Default Extension="' . $extension . '" ContentType="image/' . $extension . '"/>';
                $this->addContentTypes($ctString);
                //modify the image data to modify the r:embed attribute
                $domImages->item($i)->parentNode
                        ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/main', 'blip')
                        ->item(0)->setAttribute('r:embed', $ind);
                if ($cx != 0) {
                    $domImages->item($i)->parentNode
                            ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing', 'extent')
                            ->item(0)->setAttribute('cx', $cx);
                    $domImages->item($i)->parentNode
                            ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/main', 'ext')
                            ->item(0)->setAttribute('cx', $cx);
                }
                if ($cy != 0) {
                    $domImages->item($i)->parentNode
                            ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing', 'extent')
                            ->item(0)->setAttribute('cy', $cy);
                    $domImages->item($i)->parentNode
                            ->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/main', 'ext')
                            ->item(0)->setAttribute('cy', $cy);
                }
                self::$_document = $domDocument->saveXML($domDocument->documentElement);
            }
        }
    }

    /**
     * Replace images in template
     *
     * @access public
     * @param ZipArchive $docxTemplate
     * @static
     */
    public static function replaceImages(&$docxTemplate)
    {
        foreach (self::$placeholderImages as $key => $value) {
            $imageNameArray = explode('/', $value);
            if (count($imageNameArray) > 1) {
                $imageName = array_pop($imageNameArray);
            } else {
                $imageName = $value;
            }
            $docxTemplate->addFile($value, 'word/media/' . $imageName);
        }
    }

    /**
     * Replace variables in template.
     * Allows text strings and array of values as variables.
     *
     * @access public
     * @param mixed $args[0]. Array or string
     * @param mixed $args[1]
     * @param mixed $args[2]. Optional. Settings template
     */
    public function replaceVariable()
    {
        $args = func_get_args();
        $cloneDom = '';
        $domParent = '';

        if (is_string($args[0]) || $args[1] == 'table' || $args[1] == 'list') {
            // TEMPORARY FIX for headers in tables
            if (!isset($args[2]['header']) && !is_string($args[2])) {
                $args[2]['header'] = false;
            }
            // sometimes Word splits tags. Find and replace all of them with
            // new string surrounded by template symbol value
            $documentSymbol = explode(self::$_templateSymbol, self::$_document);
            foreach ($documentSymbol as $documentSymbolValue) {
                // ignore group [tag_name|group]
                $tempSearch = explode('|', trim(strip_tags($documentSymbolValue)));
                $tempSearch = $tempSearch[0];
                if (is_array($args[0])) {
                    foreach ($args[0] as $row) {
                        foreach ($row as $var => $val) {
                            if ($tempSearch == $var) {
                                $pos = strpos(self::$_document, $documentSymbolValue);
                                if ($pos !== false) {
                                    self::$_document = substr_replace(self::$_document, $var, $pos, strlen($documentSymbolValue));
                                }
                            }
                        }
                    }
                } else {
                    if ($tempSearch == $args[0]) {
                        /* self::$_document = str_replace(
                          $documentSymbolValue, $args[0], self::$_document
                          ); */
                        $pos = strpos(self::$_document, $documentSymbolValue);
                        if ($pos !== false) {
                            self::$_document = substr_replace(self::$_document, $args[0], $pos, strlen($documentSymbolValue));
                        }
                    }
                }
                if (strpos($documentSymbolValue, 'xml:space="preserve"')) {
                    $preserve = true;
                }
            }
            if (isset($preserve) && $preserve) {
                $query = '//w:t[text()[contains(., "' . self::$_templateSymbol . $args[0] . self::$_templateSymbol . '")]]';
                $docDOM = new \DOMDocument();
                $docDOM->loadXML(self::$_document);
                $docXPath = new \DOMXPath($docDOM);
                $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $affectedNodes = $docXPath->query($query);
                foreach ($affectedNodes as $node) {
                    $space = $node->getAttribute('xml:space');
                    if (isset($space) && $space == 'preserve') {
                        //Do nothing 
                    } else {
                        $str = $node->nodeValue;
                        $firstChar = $str[0];
                        if ($firstChar == ' ') {
                            $node->nodeValue = substr($str, 1);
                        }
                        $node->setAttribute('xml:space', 'preserve');
                    }
                }
                self::$_document = $docDOM->saveXML($docDOM->documentElement);
            }

            foreach (self::$_footer as $key => $footer) {
                $documentSymbolFooter = explode(self::$_templateSymbol, self::$_footer[$key]);
                foreach ($documentSymbolFooter as $documentSymbolValue) {
                    if (strip_tags($documentSymbolValue) == $args[0]) {
                        self::$_footer[$key] = str_replace($documentSymbolValue, $args[0], self::$_footer[$key]);
                    }
                }
            }

            foreach (self::$_header as $key => $header) {
                $documentSymbolHeader = explode(self::$_templateSymbol, self::$_header[$key]);
                foreach ($documentSymbolHeader as $documentSymbolValue) {
                    if (strip_tags($documentSymbolValue) == $args[0]) {
                        self::$_header[$key] = str_replace($documentSymbolValue, $args[0], self::$_header[$key]);
                    }
                }
            }
        }

        // replace VAR within DOCX
        if ($args[2] == 'docx' && is_string($args[0]) && is_string($args[1])) {
            // in this case remove the "parent paragraph"
            $this->removeParentParagraph($args[0]);
            self::$_document = str_replace('<alternativeContent>', '', self::$_document);
            self::$_document = str_replace('</alternativeContent>', '', self::$_document);
            if (!$this->_isDOCX) {
                $this->addContentTypes('<Default Extension="zip" ContentType="application/vnd.openxmlformats'
                        . '-officedocument.wordprocessingml.document.main+xml"> </Default>');
                $this->_isDOCX = true;
            }
            $this->addRelationship('<Relationship Id="rDOCXId' . $this->_idDOCX .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/' .
                    'aFChunk" Target="docx' . $this->_idDOCX .
                    '.zip" TargetMode="Internal"></Relationship>');
            // add source and dest filepath
            self::$embedFiles[] = array(
                'src_file' => $args[1],
                'dest_file' => 'docx' . $this->_idDOCX . '.zip'
            );
            $args[1] = '<' . CreateElement::NAMESPACEWORD . ':altChunk r:id="rDOCXId' . $this->_idDOCX . '" ' .
                    'xmlns:r="http://schemas.openxmlformats.org/' . 'officeDocument/2006/relationships" ' .
                    'xmlns:w="http://schemas.openxmlformats.org/' . 'wordprocessingml/2006/main" />';
            $this->_idDOCX++;
        }

        // replace VAR within MHT
        if ($args[2] == 'mht' && is_string($args[0]) && is_string($args[1])) {
            //In this case remove the "parent paragraph"
            $this->removeParentParagraph($args[0]);
            self::$_document = str_replace('<alternativeContent>', '', self::$_document);
            self::$_document = str_replace('</alternativeContent>', '', self::$_document);
            if (!$this->_isMHT) {
                $this->addContentTypes('<Default Extension="mht" ContentType="message/rfc822"> </Default>');
                $this->_isMHT = true;
            }
            $this->addRelationship('<Relationship Id="rMHTId' . $this->_idMHT .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' .
                    'relationships/aFChunk" Target="mht' . $this->_idMHT .
                    '.mht" TargetMode="Internal"></Relationship>');
            // add source string and dest filepath
            self::$embedFiles[] = array(
                'src_file' => $args[1],
                'dest_file' => 'mht' . $this->_idMHT . '.mht'
            );
            $args[1] = '<' . CreateElement::NAMESPACEWORD . ':altChunk r:id="rMHTId' . $this->_idMHT . '" ' .
                    'xmlns:r="http://schemas.openxmlformats.org/' . 'officeDocument/2006/relationships" ' .
                    'xmlns:w="http://schemas.openxmlformats.org/' . 'wordprocessingml/2006/main" />';
            $this->_idMHT++;
        }

        // replace VAR within HTML
        if ($args[2] == 'html' && is_string($args[0]) && is_string($args[1])) {
            //In this case remove the "parent paragraph"
            $this->removeParentParagraph($args[0]);
            self::$_document = str_replace('<alternativeContent>', '', self::$_document);
            self::$_document = str_replace('</alternativeContent>', '', self::$_document);
            if (!$this->_isHTML) {
                $this->addContentTypes('<Default Extension="htm" ContentType="application/xhtml+xml"> </Default>');
                $this->_isHTML = true;
            }
            $this->addRelationship('<Relationship Id="rHTMLId' . $this->_idHTML .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' .
                    'relationships/aFChunk" Target="html' . $this->_idHTML .
                    '.htm" TargetMode="Internal"></Relationship>');
            // add source string and dest filepath
            self::$embedFiles[] = array(
                'src_string' => '<html>' . $args[1] . '</html>',
                'dest_file' => 'html' . $this->_idHTML . '.htm'
            );
            $args[1] = '<' . CreateElement::NAMESPACEWORD . ':altChunk r:id="rHTMLId' . $this->_idHTML . '" ' .
                    'xmlns:r="http://schemas.openxmlformats.org/' . 'officeDocument/2006/relationships" ' .
                    'xmlns:w="http://schemas.openxmlformats.org/' . 'wordprocessingml/2006/main" />';
            $this->_idHTML++;
        }

        // replace VAR within an image
        if ($args[2] == 'image' && is_string($args[0]) && is_string($args[1])) {
            //In this case remove the "parent paragraph"
            $this->removeParentParagraph($args[0]);
            self::$_document = str_replace('<alternativeContent>', '', self::$_document);
            self::$_document = str_replace('</alternativeContent>', '', self::$_document);
            // transform image to MHT file to embed it
            $imageToMHT = new \MhtFileMaker();
            list($imgWidth, $imgHeight, $imgType, $imgAttr) = getimagesize($args[1]);
            $imageToMHT->AddContents('file:///C:/2673C891/Doc1.htm', 'text/html; charset="us-ascii"', chunk_split('<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head></head><body lang=3DEN-US style=3D\'tab-interval:36.0pt\'><div class=3DSection1><p class=3DMsoNormal><span style=3D\'mso-no-proof:yes\'><!--[if gte vml 1]><v=:shapetype id=3D"_x0000_t75" coordsize=3D"21600,21600" o:spt=3D"75" o:preferrelative==3D"t" path=3D"m@4@5l@4@11@9@11@9@5xe" filled=3D"f" stroked=3D"f"> <v:stroke joinstyle=3D"miter"/> <v:formulas><v:f eqn=3D"if lineDrawn pixelLineWidth 0"/><v:f eqn=3D"sum @0 1 0"/><v:f eqn=3D"sum 0 0 @1"/><v:f eqn=3D"prod @2 1 2"/><v:f eqn=3D"prod @3 21600 pixelWidth"/><v:f eqn=3D"prod @3 21600 pixelHeight"/><v:f eqn=3D"sum @0 0 1"/><v:f eqn=3D"prod @6 1 2"/><v:f eqn=3D"prod @7 21600 pixelWidth"/><v:f eqn=3D"sum @8 21600 0"/><v:f eqn=3D"prod @7 21600 pixelHeight"/><v:f eqn=3D"sum @10 21600 0"/></v:formulas><v:path o:extrusionok=3D"f" gradientshapeok=3D"t" o:connecttype=3D"rect"/><o:lock v:ext=3D"edit" aspectratio=3D"t"/></v:shapetype><v:shape id=3D"Picture_x0020_1" o:spid=3D"_x0000_i1025" type=3D"#_x0000_t75" style=3D\'width:' . $imgWidth . 'pt;height:' . $imgHeight . 'pt;visibility:visible;mso-wrap-style:square\'><v:imagedata src=3D"Doc1_files/image001.' . $imageToMHT->GetExtension($args[1]) . '" o:title=3D""/></v:shape><![endif]--></span></p></div></body></html>', 5000), 'quoted-printable');
            $imageToMHT->AddFile($args[1]);
            if (!$this->_isMHT) {
                $this->addContentTypes('<Default Extension="mht" ContentType="message/rfc822"> </Default>');
                $this->_isMHT = true;
            }
            $this->addRelationship('<Relationship Id="rMHTId' . $this->_idMHT .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/' .
                    'relationships/aFChunk" Target="mht' . $this->_idMHT .
                    '.mht" TargetMode="Internal"></Relationship>');
            // add source string and dest filepath
            self::$embedFiles[] = array(
                'src_string' => $imageToMHT->GetFile(),
                'dest_file' => 'mht' . $this->_idMHT . '.mht'
            );
            $args[1] = '<' . CreateElement::NAMESPACEWORD . ':altChunk r:id="rMHTId' . $this->_idMHT . '" ' .
                    'xmlns:r="http://schemas.openxmlformats.org/' . 'officeDocument/2006/relationships" ' .
                    'xmlns:w="http://schemas.openxmlformats.org/' . 'wordprocessingml/2006/main" />';
            $this->_idMHT++;
        }

        // replace VAR within RTF
        if ($args[2] == 'rtf' && is_string($args[0]) && is_string($args[1])) {
            //In this case remove the "parent paragraph"
            $this->removeParentParagraph($args[0]);
            self::$_document = str_replace('<alternativeContent>', '', self::$_document);
            self::$_document = str_replace('</alternativeContent>', '', self::$_document);
            if (!$this->_isRTF) {
                $this->addContentTypes('<Default Extension="rtf" ContentType="application/rtf"> </Default>');
                $this->_isRTF = true;
            }
            $this->addRelationship('<Relationship Id="rRTFId' . $this->_idRTF .
                    '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/' .
                    'aFChunk" Target="rtf' . $this->_idRTF . '.rtf" TargetMode="Internal">' .
                    '</Relationship>');
            // add source and dest filepath
            self::$embedFiles[] = array(
                'src_file' => $args[1],
                'dest_file' => 'rtf' . $this->_idRTF . '.rtf'
            );
            $args[1] = '<' . CreateElement::NAMESPACEWORD .
                    ':altChunk r:id="rRTFId' . $this->_idRTF . '" ' .
                    'xmlns:r="http://schemas.openxmlformats.org/' .
                    'officeDocument/2006/relationships" ' .
                    'xmlns:w="http://schemas.openxmlformats.org/' .
                    'wordprocessingml/2006/main" />';
            $this->_idRTF++;
        }

        // only lists and tables are supported
        if (($args[1] == 'list' || $args[1] == 'table') && is_array($args[0])) {
            $domDocument = new \DomDocument();
            $domDocument->loadXML(self::$_document);

            $xmlWP = $domDocument->getElementsByTagNameNS(
                    'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p'
            );
            $xpath = new \DOMXPath($domDocument);
            $query = 'w:r/w:t';
            $length = $xmlWP->length;
            $itemsWP = array();
            for ($i = 0; $i < $length; $i++) {
                $itemsWP[$i] = $xmlWP->item($i);
            }
            for ($i = 0; $i < $length; $i++) {
                $variables = $xpath->query($query, $itemsWP[$i]);
                foreach ($variables as $entry) {
                    if (isset($args[2]['header'])) {
                        foreach ($args[0] as $valuesArray) {
                            foreach ($valuesArray as $keys => $values) {
                                if (empty($entry->nodeValue)) {
                                    continue;
                                }
                                if (
                                        strpos(
                                                $entry->nodeValue, self::$_templateSymbol . $keys .
                                                self::$_templateSymbol
                                        ) !== false
                                ) {
                                    if ($args[1] == 'list') {
                                        $domP = $entry->parentNode->parentNode;
                                        $domParent = $entry->parentNode->
                                                parentNode->parentNode;
                                        $cloneDom = $entry->
                                                parentNode->parentNode->cloneNode(true);
                                        try {
                                            $domP->parentNode->insertBefore(
                                                    $cloneDom, $domP
                                            );
                                        } catch (\Exception $e) {
                                            CreateDocx::$log->fatal(
                                                    $e->getMessage()
                                            );
                                            exit();
                                        }
                                    } elseif ($args[1] == 'table') {
                                        $domTR = $entry->parentNode->
                                                parentNode->parentNode->
                                                parentNode;
                                        if (
                                                $entry->parentNode->
                                                parentNode->parentNode->
                                                parentNode->nodeName == 'w:tr'
                                        ) {
                                            $domParent = $entry->parentNode->
                                                    parentNode->parentNode->
                                                    parentNode->parentNode;
                                            $cloneDom = $entry->parentNode->
                                                    parentNode->parentNode->
                                                    parentNode->cloneNode(true);
                                            try {
                                                $domTR->parentNode->insertBefore(
                                                        $cloneDom, $domTR
                                                );
                                            } catch (\Exception $e) {
                                                CreateDocx::$log->fatal(
                                                        $e->getMessage()
                                                );
                                                exit();
                                            }
                                        }
                                    }
                                }
                                /* only the first key is needed to iterate over
                                 * DOM and clone the required nodes.
                                 */
                                break;
                            }
                        }
                    } else {
                        if ($args[1] == 'list') {
                            $domP = $entry->parentNode->parentNode;
                            $domParent = $entry->parentNode->
                                    parentNode->parentNode;
                            $cloneDom = $entry->
                                    parentNode->parentNode->cloneNode(true);
                            try {
                                $domP->parentNode->insertBefore(
                                        $cloneDom, $domP
                                );
                            } catch (\Exception $e) {
                                CreateDocx::$log->fatal(
                                        $e->getMessage()
                                );
                                exit();
                            }
                        } elseif ($args[1] == 'table') {
                            $domTR = $entry->parentNode->
                                    parentNode->parentNode->
                                    parentNode;
                            if (
                                    $entry->parentNode->
                                    parentNode->parentNode->
                                    parentNode->nodeName == 'w:tr'
                            ) {
                                $domParent = $entry->parentNode->
                                        parentNode->parentNode->
                                        parentNode->parentNode;
                                $cloneDom = $entry->parentNode->
                                        parentNode->parentNode->
                                        parentNode->cloneNode(true);
                                try {
                                    $domTR->parentNode->insertBefore(
                                            $cloneDom, $domTR
                                    );
                                } catch (Exception $e) {
                                    CreateDocx::$log->fatal(
                                            $e->getMessage()
                                    );
                                    exit();
                                }
                            }
                        }
                        /* only the first key is needed to iterate over
                         * DOM and clone the required nodes.
                         */
                        break;
                    }
                }
            }
            /* a last element is created due to number of values plus the first
             *  used as placeholder. Just remove it.
             */
            if (is_object($domParent)) {
                $domParent->removeChild($cloneDom);
            }
            self::$_document = $domDocument->saveXML();
        }

        // iterate text array
        if (is_string($args[0]) && is_array($args[1])) {
            $domDocument = new \DomDocument();
            $domDocument->loadXML(self::$_document);

            $xmlWP = $domDocument->getElementsByTagNameNS(
                    'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'p'
            );
            $xpath = new \DOMXPath($domDocument);
            $query = 'w:r/w:t';
            $length = $xmlWP->length;
            $itemsWP = array();
            for ($i = 0; $i < $length; $i++) {
                $itemsWP[$i] = $xmlWP->item($i);
            }
            for ($i = 0; $i < $length; $i++) {
                $variables = $xpath->query($query, $itemsWP[$i]);
                foreach ($variables as $entry) {
                    foreach ($args[1] as $values) {
                        if (
                                self::$_templateSymbol . $args[0] .
                                self::$_templateSymbol ==
                                $entry->nodeValue && $entry->nodeValue != self::$_templateSymbol
                        ) {
                            $domP = $entry->parentNode->parentNode;
                            $domParent = $entry->parentNode->
                                    parentNode->parentNode;
                            $cloneDom = $entry->
                                    parentNode->parentNode->cloneNode(true);
                            try {
                                $domP->parentNode->insertBefore(
                                        $cloneDom, $domP
                                );
                            } catch (\Exception $e) {
                                CreateDocx::$log->fatal(
                                        $e->getMessage()
                                );
                                exit();
                            }
                        }
                    }
                }
            }
            /* A last element is created due to number of values plus the first
             *  used as placeholder. Just remove it.
             */
            if (is_object($domParent)) {
                $domParent->removeChild($cloneDom);
            }
            self::$_document = $domDocument->saveXML();
        }

        if (is_string($args[0])) {
            // text string or array of texts
            if (is_string($args[1])) {
                // if text string escape chars
                if (empty($args[2])) {
                    $args[1] = htmlspecialchars($args[1]);
                }
                // single text string
                self::$_document = str_replace(
                        self::$_templateSymbol . $args[0]
                        . self::$_templateSymbol, self::processFields($args[0], $args[1]), self::$_document
                );
                foreach (self::$_footer as $key => $footer) {
                    self::$_footer[$key] = str_replace(self::$_templateSymbol . $args[0] . self::$_templateSymbol, self::processFields($args[0], $args[1]), $footer);
                }
                foreach (self::$_header as $key => $header) {
                    self::$_header[$key] = str_replace(self::$_templateSymbol . $args[0] . self::$_templateSymbol, self::processFields($args[0], $args[1]), $header);
                }
            } elseif (is_array($args[1])) {
                // text array
                foreach ($args[1] as $values) {
                    // if text string escape chars
                    if (empty($args[2])) {
                        $values = htmlspecialchars($values);
                    }
                    self::$_document = preg_replace(
                            '/\\' . self::$_templateSymbol . $args[0]
                            . '\\' . self::$_templateSymbol . '/', $values, self::$_document, 1
                    );
                    foreach (self::$_footer as $key => $footer) {
                        self::$_footer[$key] = preg_replace('/\\' . self::$_templateSymbol . $args[0] . '\\' .
                                self::$_templateSymbol . '/', $values, $footer, 1);
                    }
                    foreach (self::$_header as $key => $header) {
                        self::$_header[$key] = preg_replace('/\\' . self::$_templateSymbol . $args[0] . '\\' .
                                self::$_templateSymbol . '/', $values, $header, 1);
                    }
                }
            }
        } elseif (is_array($args[0])) {
            // List or table
            foreach ($args[0] as $values) {
                foreach ($values as $keys => $textValue) {
                    // escape chars
                    $textValue = htmlspecialchars($textValue);
                    $documentSymbol = explode(self::$_templateSymbol, self::$_document);
                    /* foreach ($documentSymbol as $documentSymbolValue) {
                      if (strip_tags($documentSymbolValue) == $keys) {
                      self::$_document = str_replace(
                      $documentSymbolValue, $keys, self::$_document
                      );
                      }
                      } */
                    self::$_document = preg_replace(
                            '/\\' . self::$_templateSymbol . $keys . '\\' .
                            self::$_templateSymbol . '/', $textValue, self::$_document, 1
                    );
                    foreach (self::$_footer as $key => $footer) {
                        self::$_footer[$key] = preg_replace('/\\' . self::$_templateSymbol . $keys . '\\' .
                                self::$_templateSymbol . '/', $textValue, $footer, 1);
                    }
                    foreach (self::$_header as $key => $header) {
                        self::$_header[$key] = preg_replace('/\\' . self::$_templateSymbol . $keys . '\\' .
                                self::$_templateSymbol . '/', $textValue, $header, 1);
                    }
                }
            }
        }
    }

    /**
     * Replace variables in template by HTML.
     *
     * @access public
     * @param $var variable to be replaced
     * @param $type, inline or block
     * @param $wordHTML the world chunck generated out of HTML that we want to insert
     */
    public function replaceVariableByHTML($var, $type, $wordHTML)
    {
        // sometimes Word splits tags. Find and replace all of them with
        // new string surrounded by template symbol value
        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        foreach ($documentSymbol as $documentSymbolValue) {
            // ignore group [tag_name|group]
            $tempSearch = explode('|', trim(strip_tags($documentSymbolValue)));
            $tempSearch = $tempSearch[0];

            if ($tempSearch == $var) {
                $pos = strpos(self::$_document, $documentSymbolValue);
                if ($pos !== false) {
                    self::$_document = substr_replace(self::$_document, $var, $pos, strlen($documentSymbolValue));
                }
            }
        }

        $searchString = self::$_templateSymbol;
        $searchVariable = self::$_templateSymbol . $var . self::$_templateSymbol;

        $docDOM = new \DOMDocument();
        $docDOM->loadXML(self::$_document);

        $docXpath = new \DOMXPath($docDOM);
        $query = '//w:p[w:r/w:t[text()[contains(., "' . $searchString . '")]]]';

        $docNodes = $docXpath->query($query);

        foreach ($docNodes as $node) {
            $nodeText = $node->ownerDocument->saveXML($node);
            $cleanNodeText = strip_tags($nodeText);
            if (strpos($cleanNodeText, $searchVariable) !== false) {
                if ($type == 'block') {
                    $cursorNode = $docDOM->createElement('cursorHTML');
                    // take care of the case that WordHTML is empty and inside a table cell (fix word bug empty cells)
                    if ($wordHTML == '' && $node->parentNode->nodeName == 'w:tc')
                        $wordHTML = '<w:p />';
                    $node->parentNode->insertBefore($cursorNode, $node);
                    $node->parentNode->removeChild($node);
                }else if ($type == 'inline') {
                    $textNode = $node->ownerDocument->saveXML($node);
                    $textChunks = explode($searchString, $textNode);
                    $limit = count($textChunks);
                    for ($j = 0; $j < $limit; $j++) {
                        $cleanValue = strip_tags($textChunks[$j]);
                        if ($cleanValue == $var) {
                            $textChunks[$j] = '</w:t></w:r><cursorHTML/><w:r><w:t xml:space="preserve">';
                        }
                    }
                    $newNodeText = implode($searchString, $textChunks);
                    $newNodeText = str_replace(self::$_templateSymbol . '</w:t></w:r><cursorHTML/><w:r><w:t xml:space="preserve">', '</w:t></w:r><cursorHTML/><w:r><w:t xml:space="preserve">', $newNodeText);
                    $newNodeText = str_replace('</w:t></w:r><cursorHTML/><w:r><w:t xml:space="preserve">' . self::$_templateSymbol, '</w:t></w:r><cursorHTML/><w:r><w:t xml:space="preserve">', $newNodeText);
                    $tempDoc = new \DOMDocument();
                    $tempDoc->loadXML('<w:root xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" >' . $newNodeText . '</w:root>');
                    $newCursorNode = $tempDoc->documentElement->firstChild;
                    $cursorNode = $docDOM->importNode($newCursorNode, true);
                    $node->parentNode->insertBefore($cursorNode, $node);
                    $node->parentNode->removeChild($node);
                }
            }
        }
        self::$_document = $docDOM->saveXML();
        self::$_document = str_replace('<cursorHTML/>', $wordHTML, self::$_document);
    }

    public static function reset()
    {
        self::setBlnTemplate(false);
        self::$embedFiles = array();
        self::$placeholderImages = array();
        self::$path = '';
        self::$ridInitTemplateCharts = '';
        self::$templateVariables = array();
        self::$totalTemplateCharts = '';
        self::$_chartsRelsChartXMLRels = '';
        self::$_contentTypes = '';
        self::$_document = '';
        self::$_footer = array();
        self::$_header = array();
        self::$_relsDocumentXMLRels = '';
        self::$_template = '';
    }

    /**
     * Takes care of the links and images asociated with an HTML chunck processed
     * by the embedHTML method in the case of a Template
     *
     * @access public
     * @param array $sFinalDocX an arry with the required link and image data
     */
    public function TemplateHTMLRels($sFinalDocX, $options, $pathToBaseTemplate)
    {
        foreach ($sFinalDocX[1] as $key => $value) {
            $this->addRelationship('<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="' . $value . '" TargetMode="External"></Relationship>');
        }

        $relsImages = '';
        foreach ($sFinalDocX[2] as $key => $value) {
            $tempArray = explode('?', $value);
            $value = array_shift($tempArray); //We just get the photo path
            if (isset($options['downloadImages']) && $options['downloadImages']) {
                //$photo = file_get_contents($value);
                $arrayExtension = explode('.', $value);
                $extension = strtolower(array_pop($arrayExtension));
                $this->addContentTypes('<Default Extension="' . $extension . '" ContentType="image/' . $extension . '"/>');
                $this->addRelationship('<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $key . '.' . $extension . '" />');
            } else {
                $this->addRelationship('<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' . $value . '" TargetMode="External" />');
            }
        }
    }

    /**
     * Replace variable char in template
     *
     * @access public
     * @param string $args[0]
     * @static
     */
    public static function replaceVariableChart($chart, $i)
    {
        $chart = str_replace('<w:p>', '', $chart);
        $chart = str_replace('</w:p>', '', $chart);
        self::$_document = str_replace(
                '<varchart_' . $i . '/>', $chart, self::$_document
        );
    }

    /**
     * Get image jpg dpi
     *
     * @access private
     * @param string $filename
     * @return array
     */
    private function getDpiJpg($filename)
    {
        $a = fopen($filename, 'r');
        $string = fread($a, 20);
        fclose($a);
        $type = hexdec(bin2hex(substr($string, 13, 1)));
        $data = bin2hex(substr($string, 14, 4));
        if ($type == 1) {
            $x = substr($data, 0, 4);
            $y = substr($data, 4, 4);
            return array(hexdec($x), hexdec($y));
        } else if ($type == 2) {
            $x = floor(hexdec(substr($data, 0, 4)) / 2.54);
            $y = floor(hexdec(substr($data, 4, 4)) / 2.54);
            return array($x, $y);
        } else {
            return array(96, 96);
        }
    }

    /**
     * Get image png dpi
     *
     * @access private
     * @param string $filename
     * @return array
     */
    private function getDpiPng($filename)
    {
        $pngScaleFactor = 29.5;
        $a = fopen($filename, 'r');
        $string = fread($a, 1000);
        $aux = strpos($string, 'pHYs');
        if ($aux > 0) {
            $type = hexdec(bin2hex(substr($string, $aux + strlen('pHYs') + 16, 1)));
        }
        if ($aux > 0 && $type = 1) {
            $data = bin2hex(substr($string, $aux + strlen('pHYs'), 16));
            fclose($a);
            $x = substr($data, 0, 8);
            $y = substr($data, 8, 8);
            return array(round(hexdec($x) / $pngScaleFactor), round(hexdec($y) / $pngScaleFactor));
        } else {
            return array(96, 96);
        }
    }

    /**
     * Process template variables before sustitution in template
     *
     * @access private
     * @param string $name Variable name
     * @param string $value Variable value
     */
    private function processFields($name, $value)
    {
        $ret = $value;

        if (strpos(strtolower($name), 'numbering') === 0) {
            if (!isset($aNameCounts)) {
                static $aNameCounts = array();
            }

            $aAuxNums = array();

            switch ($value) {
                case '1,2,3':
                    $aAuxNums = 1;
                    break;
                case 'I,II,III':
                    $aAuxNums = array('I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'XIII', 'XIV', 'XV', 'XVI', 'XVII', 'XVIII', 'XIX', 'XX', 'XXI', 'XXII', 'XXIII', 'XXIV', 'XXV', 'XXVI', 'XXVII', 'XXVIII', 'XXIX', 'XXX');
                    break;
                case 'A,B,C':
                    $aAuxNums = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
                    break;
                default:
                    if (strpos($value, ',') === false) {
                        if (is_numeric($value))
                            $aAuxNums = $value;
                        else
                            $aAuxNums = 1;
                    } else
                        $aAuxNums = explode(',', $value);
            }

            if (!isset($aNameCounts[$name])) {
                $aNameCounts[$name] = 0;
                if (is_array($aAuxNums))
                    $ret = $aAuxNums[$aNameCounts[$name]];
                else {
                    $aNameCounts[$name] += $aAuxNums;
                    $ret = $aNameCounts[$name];
                }
            } else {
                if (is_array($aAuxNums)) {
                    $aNameCounts[$name] ++;
                    $ret = $aAuxNums[$aNameCounts[$name] % count($aAuxNums)];
                } else {
                    $aNameCounts[$name] += $aAuxNums;
                    $ret = $aNameCounts[$name];
                }
            }
        }

        return($ret);
    }

    /**
     * Return template variables
     *
     * @access public
     * @return array
     */
    public function returnAllVariables()
    {
        $variables = array();

        $documentSymbol = explode(self::$_templateSymbol, self::$_document);
        $i = 0;
        foreach ($documentSymbol as $documentSymbolValue) {
            // avoid first and last values and even positions
            if ($i == 0 || $i == count($documentSymbol) || $i % 2 == 0) {
                $i++;
                continue;
            } else {
                $i++;
                $variables['document'][] = strip_tags($documentSymbolValue);
            }
        }

        foreach (self::$_header as $key => $header) {
            $documentSymbol = explode(self::$_templateSymbol, $header);
            $i = 0;
            foreach ($documentSymbol as $documentSymbolValue) {
                // avoid first and last values and even positions
                if ($i == 0 || $i == count($documentSymbol) || $i % 2 == 0) {
                    $i++;
                    continue;
                } else {
                    $variables['header'][] = strip_tags($documentSymbolValue);
                    $i++;
                }
            }
        }

        foreach (self::$_footer as $key => $footer) {
            $documentSymbol = explode(self::$_templateSymbol, $footer);
            $i = 0;
            foreach ($documentSymbol as $documentSymbolValue) {
                // avoid first and last values and even positions
                if ($i == 0 || $i == count($documentSymbol) || $i % 2 == 0) {
                    $i++;
                    continue;
                } else {
                    $variables['footer'][] = strip_tags($documentSymbolValue);
                    $i++;
                }
            }
        }

        return $variables;
    }

    /**
     * Return template variables. Only for legaldocx.
     *
     * @access public
     * @return array
     */
    public function returnVariables()
    {
        $vars['document'] = explode(self::$_templateSymbol, $this->_preprocessDocument());
        $aElementTypes = '(BLOCK|CHECKBOX|COMMENT|DATE|GROUP|HEADING|LIST|NUMBERING|ROW|SELECT|TAB|TEXT|TEXTAREA)';
        foreach ($vars['document'] as $key => $value) {
            if (!preg_match('/' . $aElementTypes . '_/', strip_tags($value)))
                unset($vars['document'][$key]);
        }
        $vars['document'] = array_values($vars['document']);

        foreach (self::$_footer as $footer) {
            $vars['footer'] = explode(self::$_templateSymbol, $footer);
        }
        if (!empty($vars['footer'])) {
            foreach ($vars['footer'] as $key => $value) {
                if (!preg_match('/' . $aElementTypes . '_/', strip_tags($value)))
                    unset($vars['footer'][$key]);
            }
            $vars['footer'] = array_values($vars['footer']);
        }

        foreach (self::$_header as $header) {
            $variables['header'] = explode(self::$_templateSymbol, $header);
        }
        if (!empty($vars['header'])) {
            foreach ($vars['header'] as $key => $value) {
                if (!preg_match('/' . $aElementTypes . '_/', strip_tags($value)))
                    unset($vars['header'][$key]);
            }
            $vars['header'] = array_values($vars['header']);
        }

        $this->_buildArray($vars);

        return $vars;
    }

    /**
     * Build array with given variables
     *
     * @param array $variables
     */
    private function _buildArray($variables)
    {
        $i = 0;
        $j = 0;
        foreach ($variables as $key => $section) {
            foreach ($section as $value) {
                $variableParts = $this->cleanExplode("_", $value);
                switch ($variableParts[0]) {
                    case 'BLOCK':
                    case 'GROUP':
                    case 'TAB':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[1]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableGroup[0];
                        if (!empty($variableGroup[1])) {
                            self::$templateVariables[$key][$j]['GROUPID'] = $variableGroup[1];
                        }
                        if (!empty($variableGroup[2])) {
                            //The group is nested inside other group
                            self::$templateVariables[$key][$j]['GROUP'] = $variableGroup[2];
                        }
                        break;

                    case 'HEADING':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[1]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableGroup[0];
                        break;

                    case 'COMMENT':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[1]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableGroup[0];
                        if (!empty($variableGroup[1])) {
                            self::$templateVariables[$key][$j]['GROUP'] = $variableGroup[1];
                        } elseif (!empty($variableParts[2])) {
                            self::$templateVariables[$key][$j]['GROUP'] = $variableParts[2];
                        }
                        break;

                    case 'NUMBERING':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[1]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableGroup[0];
                        if (!empty($variableGroup[1])) {
                            self::$templateVariables[$key][$j]['GROUP'] = $variableGroup[1];
                        } elseif (!empty($variableParts[2])) {
                            self::$templateVariables[$key][$j]['GROUP'] = $variableParts[2];
                        }
                        break;

                    case 'LIST':
                    case 'ROW':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[3]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableParts[2] . '_' . $variableParts[3];
                        if (!empty($variableParts[1])) {
                            self::$templateVariables[$key][$j]['GROUPID'] = $variableParts[1];
                        }
                        if (!empty($variableGroup[1])) {
                            //The group is nested inside other group
                            self::$templateVariables[$key][$j]['GROUP'] = $variableGroup[1];
                        }
                        break;

                    case 'CHECKBOX':
                    case 'TEXT':
                    case 'TEXTAREA':
                    case 'SELECT':
                    case 'DATE':
                        self::$templateVariables[$key][$j]['TAG'] = $variableParts[0];
                        $variableGroup = $this->cleanExplode(self::$_templateGroupSymbol, $variableParts[1]);
                        self::$templateVariables[$key][$j]['NAME'] = $variableGroup[0];
                        if (!empty($variableGroup[1])) {
                            self::$templateVariables[$key][$j]['GROUP'] = $variableGroup[1];
                        }
                        break;

                    default:
                        break;
                }
                $j++;
                $i++;
            }
        }
    }

    /**
     * clean the sections from the unused footers and headers
     *
     * @access private
     */
    private function cleanDocument($document)
    {
        $domDocument = new \DomDocument();
        $domDocument->loadXML($document);
        // check if there are footers
        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'headerReference');
        $length = $xmlWP->length;
        $itemsWP = array();
        for ($i = 0; $i < $length; $i++) {
            $itemsWP[] = $xmlWP->item($i);
        }
        foreach ($itemsWP as $aux) {
            if ($aux->attributes->getNamedItem("type")->nodeValue != 'default') {
                $padre = $aux->parentNode;
                $padre->removeChild($aux);
            }
        }
        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'footerReference');
        $length = $xmlWP->length;
        $itemsWP = array();
        for ($i = 0; $i < $length; $i++) {
            $itemsWP[] = $xmlWP->item($i);
        }
        foreach ($itemsWP as $aux) {
            if ($aux->attributes->getNamedItem("type")->nodeValue != 'default') {
                $padre = $aux->parentNode;
                $padre->removeChild($aux);
            }
        }
        return $domDocument->saveXML();
    }

    /**
     * Returns an array with clean exploded variables
     *
     * @param string $delimiter
     * @param string $string
     * @return array
     */
    public function cleanExplode($delimiter, $string)
    {
        $array = explode($delimiter, $string);
        foreach ($array as $key => $part) {
            $array[$key] = trim(strip_tags($part));
        }
        return $array;
    }

    /**
     * Returns the xml with bookmarks formatted $NAME$
     *
     * @return string
     */
    private function _preprocessDocument()
    {
        $xml = $this->getDocument();
        $xml = preg_replace('/<w:bookmarkStart w:id="[0-9]" w:name="([0-9 A-Z _]*)"/', self::$_templateSymbol . '${1}' . self::$_templateSymbol, $xml);
        return $xml;
    }

    /**
     * Get current rid
     *
     * @access private
     */
    private function getCurrentRID()
    {
        $rId = 0;
        $domRelsDocumentXMLRels = new \DomDocument();
        $domRelsDocumentXMLRels->loadXML(self::$_relsDocumentXMLRels);

        $xmlRelationship = $domRelsDocumentXMLRels->getElementsByTagName(
                'Relationship'
        );

        for ($i = 0; $i < $xmlRelationship->length; $i++) {
            if (
                    (int) substr(
                            $xmlRelationship->item($i)->getAttribute('Id'), 3
                    ) > $rId
            ) {
                $rId = (int) substr(
                                $xmlRelationship->item($i)->getAttribute('Id'), 3
                );
            }
        }

        CreateDocx::$intIdWord = $rId + 1;
        self::$ridInitTemplateCharts = $rId + 1;
    }

}
