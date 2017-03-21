<?php
namespace Phpdocx\Create;

use Phpdocx;
use Phpdocx\AutoLoader;
use Phpdocx\BatchProcessing;
use Phpdocx\Charts\CreateChartFactory;
use Phpdocx\Clean;
use Phpdocx\Config;
use Phpdocx\Converters\MSWordInterface;
use Phpdocx\Crypto;
use Phpdocx\Elements\CreateChartRels;
use Phpdocx\Elements\CreateFormElement;
use Phpdocx\Elements\CreateImage;
use Phpdocx\Elements\CreateList;
use Phpdocx\Elements\CreateListStyle;
use Phpdocx\Elements\CreateMath;
use Phpdocx\Elements\CreatePage;
use Phpdocx\Elements\CreateParagraphStyle;
use Phpdocx\Elements\CreateProperties;
use Phpdocx\Elements\CreateShape;
use Phpdocx\Elements\CreateStructuredDocumentTag;
use Phpdocx\Elements\CreateTable;
use Phpdocx\Elements\CreateTableContents;
use Phpdocx\Elements\CreateText;
use Phpdocx\Elements\CreateTextBox;
use Phpdocx\Elements\EmbedDOCX;
use Phpdocx\Elements\EmbedHTML;
use Phpdocx\Elements\EmbedMHT;
use Phpdocx\Elements\EmbedRTF;
use Phpdocx\Elements\WordFragment;
use Phpdocx\Factory;
use Phpdocx\License\GenerateDocx;
use Phpdocx\Logger\PhpdocxLogger;
use Phpdocx\Parse\Repair;
use Phpdocx\Parse\RepairPDF;
use Phpdocx\Processing;
use Phpdocx\Resources\OOXMLResources;
use Phpdocx\Sign\Sign;
use Phpdocx\Sign\SignDocx;
use Phpdocx\Sign\SignPDF;
use Phpdocx\Sign\SignUtilities;
use Phpdocx\Transform\Docx2Text;
use Phpdocx\Transform\HTML2WordML;
use Phpdocx\Transform\Text2Docx;
use Phpdocx\Transform\TransformDocAdvLibreOffice;
use Phpdocx\Transform\TransformDocAdvOpenOffice;
use Phpdocx\Utilities\PhpdocxUtilities;


/**
 * Generate a DOCX file 
 *
 * @category   Phpdocx
 * @package    create
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.08.01
 * @link       http://www.phpdocx.com
 */
error_reporting(E_ALL & ~E_STRICT & ~E_NOTICE);

require_once dirname(__FILE__).'/../AutoLoader.inc';
AutoLoader::load();
require_once dirname(__FILE__) . '/../Config/Phpdocx_config.inc';

class CreateDocx extends CreateDocument
{

    const NAMESPACEWORD = 'w';
    const SCHEMA_IMAGEDOCUMENT = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image';
    const SCHEMA_OFFICEDOCUMENT = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument';

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $bookmarksIds;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $_encodeUTF;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsHeaderFooterImage;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsHeaderFooterExternalImage;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsHeaderFooterLink;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsNotesExternalImage;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsNotesImage;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $_relsNotesLink;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $bidi;

    /**
     *
     * @access public
     * @var array
     * @static
     */
    public static $rtl;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $customLists;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $generateCustomRels;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $insertNameSpaces;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $nameSpaces;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $propsCore;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $propsApp;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $propsCustom;

    /**
     *
     * @var array
     * @access public
     * @static
     */
    public static $relsRels;

    /**
     *
     * @access public
     * @static
     * @var integer
     */
    public static $numUL;

    /**
     *
     * @access public
     * @static
     * @var integer
     */
    public static $numOL;

    /**
     *
     * @access public
     * @static
     * @var int
     */
    public static $intIdWord;

    /**
     *
     * @access public
     * @static
     * @var Logger
     */
    public static $log;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $unlinkFiles;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_background;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_backgroundColor;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_baseTemplateFilesPath;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_baseTemplatePath;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_baseTemplateZip;

    /**
     *
     * @access protected
     * @var boolean
     */
    protected $_compatibilityMode;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_contentTypeC;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_defaultFont;

    /**
     *
     * @access private
     * @var boolean
     */
    private $_defaultTemplate;

    /**
     *
     * @access private
     * @var boolean
     */
    private $_docm;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_documentXMLElement;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_docxTemplate;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_extension;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_idWords;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_language;

    /**
     *
     * @access protected
     * @var boolean
     */
    protected $_macro;

    /**
     *
     * @access protected
     * @var int
     */
    protected $_markAsFinal;

    /**
     *
     * @access protected
     * @var int
     */
    protected $_modifiedDocxProperties;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_modifiedHeadersFooters;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_modifiedRels;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_parsedStyles;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_phpdocxconfig;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_relsHeader;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_relsFooter;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_relsRelsC;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_relsRelsT;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_sectPr;

    /**
     * Directory path used for temporary files
     *
     * @access protected
     * @var string
     */
    protected $_tempDir;

    /**
     * Temporary document DOM 
     *
     * @access protected
     * @var DocumentDOM
     */
    protected $_tempDocumentDOM;

    /**
     * Path of temp file to use as DOCX file
     *
     * @access protected
     * @var string
     */
    protected $_tempFile;

    /**
     * Paths of temps files to use as DOCX file
     *
     * @access protected
     * @var array
     */
    protected $_tempFileXLSX;

    /**
     * Unique id for the insertion of new elements
     *
     * @access protected
     * @var string
     */
    protected $_uniqid;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordCommentsT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordCommentsRelsT;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_wordDocumentC;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_wordDocumentT;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_wordDocumentStyles;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordEndnotesT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordEndnotesRelsT;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_wordFooterC;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_wordFooterT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordFootnotesT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordFootnotesRelsT;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_wordHeaderC;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_wordHeaderT;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_wordNumberingT;

    /**
     *
     * @access protected
     * @var string
     */
    protected $_wordRelsDocumentRelsC;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordRelsDocumentRelsT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordSettingsT;

    /**
     *
     * @access protected
     * @var DOMDocument
     */
    protected $_wordStylesT;

    /**
     *
     * @access protected
     * @var ZipArchive
     */
    protected $_zipDocx;

    /**
     * Construct
     *
     * @access public
     * @param string $baseTemplatePath. Optional, basicTemplate.docx as default
     * @param $docxTemplatePath. User custom template (preserves Word content)
     */
    public function __construct($baseTemplatePath = PHPDOCX_BASE_TEMPLATE, $docxTemplatePath = '')
    {
       
        // general settings
        $this->_phpdocxconfig = PhpdocxUtilities::parseConfig();

        $this->_docxTemplate = false;
        if ($baseTemplatePath == 'docm') {
            $this->_baseTemplatePath = PHPDOCX_BASE_FOLDER . 'phpdocxBaseTemplate.docm'; // base template path
            $this->_docm = true;
            $this->_defaultTemplate = true;
            $this->_extension = 'docm';
        } else if ($baseTemplatePath == 'docx') {
            $this->_baseTemplatePath = PHPDOCX_BASE_FOLDER . 'phpdocxBaseTemplate.docx'; // base template path
            $this->_docm = false;
            $this->_defaultTemplate = true;
            $this->_extension = 'docx';
        } else if (!empty($docxTemplatePath)) {
            $this->_defaultTemplate = false;
            $this->_docxTemplate = true;
            $this->_baseTemplatePath = $docxTemplatePath; // external template path
            $extension = pathinfo($this->_baseTemplatePath, PATHINFO_EXTENSION);
            $this->_extension = $extension;
            if ($extension == 'docm') {
                $this->_docm = true;
            } else if ($extension == 'docx') {
                $this->_docm = false;
            } else {
                PhpdocxLogger::logger('Invalid template extension', 'fatal');
            }
        } else {
            if ($baseTemplatePath == PHPDOCX_BASE_TEMPLATE) {
                $this->_defaultTemplate = true;
            } else {
                $this->_defaultTemplate = false;
            }
            $this->_baseTemplatePath = $baseTemplatePath; //base template path
            $extension = pathinfo($this->_baseTemplatePath, PATHINFO_EXTENSION);
            $this->_extension = $extension;
            if ($extension == 'docm') {
                $this->_docm = true;
            } else if ($extension == 'docx') {
                $this->_docm = false;
            } else {
                PhpdocxLogger::logger('Invalid base template extension', 'fatal');
            }
        }
        // make a copy of the template or the base template that we want to work with so we
        // do not overwrite it
        if ($this->_phpdocxconfig['settings']['temp_path']) {
            $this->_tempDir = $this->_phpdocxconfig['settings']['temp_path'];
        } else {
            $this->_tempDir = self::getTempDir();
        }
        $this->_tempFile = tempnam($this->_tempDir, 'document');
        copy($this->_baseTemplatePath, $this->_tempFile);
        $this->_zipDocx = new \ZipArchive();
        try {
            $openZip = $this->_zipDocx->open($this->_tempFile);
            if ($openZip !== true) {
                throw new \Exception('Error while trying to open the (base) template as a zip file');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }

        // initialize some required variables
        $this->_background = ''; // w:background OOXML element
        $this->_backgroundColor = 'FFFFFF'; // docx background color
        self::$bookmarksIds = array();
        $this->_idWords = array();
        self::$intIdWord = rand(9999999, 99999999);
        self::$_encodeUTF = 0;
        $this->_language = 'en-US';
        $this->_markAsFinal = 0;
        $this->_compatibilityMode = false;
        $this->_relsRelsC = '';
        $this->_relsRelsT = '';
        $this->_contentTypeC = '';
        $this->_contentTypeT = NULL;
        $this->_defaultFont = '';
        $this->_macro = 0;
        $this->_modifiedDocxProperties = false;
        $this->_modifiedHeadersFooters= array();
        $this->_relsHeader = array();
        $this->_relsFooter = array();
        $this->_parsedStyles = array();
        self::$_relsHeaderFooterImage = array();
        self::$_relsHeaderFooterExternalImage = array();
        self::$_relsHeaderFooterLink = array();
        self::$_relsNotesExternalImage = array();
        self::$_relsNotesImage = array();
        self::$_relsNotesLink = array();
        $this->_sectPr = NULL;
        $this->_tempDocumentDOM = NULL;
        $this->_tempFileXLSX = array();
        $this->_uniqid = 'phpdocx_' . uniqid(mt_rand(999, 9999));
        $this->_wordCommentsT = new \DOMDocument();
        $this->_wordCommentsRelsT = new \DOMDocument();
        $this->_wordDocumentT = '';
        $this->_wordDocumentC = '';
        $this->_wordDocumentStyles = '';
        $this->_wordEndnotesT = new \DOMDocument();
        $this->_wordEndnotesRelsT = new \DOMDocument();
        $this->_wordFooterC = array();
        $this->_wordFooterT = array();
        $this->_wordFootnotesT = new \DOMDocument();
        $this->_wordFootnotesRelsT = new \DOMDocument();
        $this->_wordHeaderC = array();
        $this->_wordHeaderT = array();
        $this->_wordNumberingT;
        $this->_wordRelsDocumentRelsT = NULL;
        $this->_wordSettingsT = '';
        $this->_wordStylesT = NULL;
        //
        self::$customLists = array();
        self::$insertNameSpaces = array();
        self::$nameSpaces = array();
        self::$unlinkFiles = array();

        $baseTemplateDocumentT = $this->getFromZip('word/document.xml');

        // extract the w:document tag with its namespaces and atributes and the 
        // w:background element if it exists
        $bodySplit = explode('<w:body>', $baseTemplateDocumentT);
        $tempDocumentXMLElement = $bodySplit[0];
        $backgroundSplit = explode('<w:background', $tempDocumentXMLElement);
        $this->_documentXMLElement = $backgroundSplit[0];
        if (!empty($backgroundSplit[1])) {
            $this->_background = '<w:background' . $backgroundSplit[1];
        }
        // do some manipulations with the DOM to get or not the file contents
        $baseDocument = new \DOMDocument();
        $baseDocument->loadXML($baseTemplateDocumentT);
        // parse for front page
        $docXpath = new \DOMXPath($baseDocument);
        $docXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        // extract namespaces
        $NSQuery = '//w:document/namespace::*';
        $xmlnsNodes = $docXpath->query($NSQuery);
        foreach ($xmlnsNodes as $node) {
            self::$nameSpaces[$node->nodeName] = $node->nodeValue;
        }
        $documentQuery = '//w:document';
        $documentElement = $docXpath->query($documentQuery)->item(0);
        foreach ($documentElement->attributes as $attribute_name => $attribute_node) {
            self::$nameSpaces[$attribute_name] = $attribute_node->nodeValue;
        }
        if (!$this->_docxTemplate) {
            $queryDoc = '//w:body/w:sdt';
            $docNodes = $docXpath->query($queryDoc);

            if ($docNodes->length > 0) {
                if ($docNodes->item(0)->nodeName == 'w:sdt') {
                    $tempDoc = new \DomDocument();
                    $sdt = $tempDoc->importNode($docNodes->item(0), true);
                    $newNode = $tempDoc->appendChild($sdt);
                    $frontPage = $tempDoc->saveXML($newNode);
                    $this->_wordDocumentC .= $frontPage;
                }
            }
        } else {
            // get the contents of the file
            $queryBody = '//w:body';
            $bodyNodes = $docXpath->query($queryBody);
            $bodyNode = $bodyNodes->item(0);
            $bodyChilds = $bodyNode->childNodes;
            foreach ($bodyChilds as $node) {
                if ($node->nodeName != 'w:sectPr') {
                    $this->_wordDocumentC .= $baseDocument->saveXML($node);
                }
            }
        }
        // create the a tempDocumentDOM for further manipulation
        $this->_tempDocumentDOM = $this->getDOMDocx();
        $querySectPr = '//w:body/w:sectPr';
        $sectPrNodes = $docXpath->query($querySectPr);
        $sectPr = $sectPrNodes->item(0);
        $this->_sectPr = new \DOMDocument();
        $sectNode = $this->_sectPr->importNode($sectPr, true);
        $this->_sectPr->appendChild($sectNode);

        $this->_contentTypeT = $this->getFromZip('[Content_Types].xml', 'DOMDocument');

        // include the standard image defaults
        $this->generateDEFAULT('gif', 'image/gif');
        $this->generateDEFAULT('jpg', 'image/jpg');
        $this->generateDEFAULT('png', 'image/png');
        $this->generateDEFAULT('jpeg', 'image/jpeg');
        $this->generateDEFAULT('bmp', 'image/bmp');

        // get the rels file
        $this->_wordRelsDocumentRelsT = $this->getFromZip('word/_rels/document.xml.rels', 'DOMDocument');
        $relationships = $this->_wordRelsDocumentRelsT->getElementsByTagName('Relationship');

        // get the styles
        $this->_wordStylesT = $this->getFromZip('word/styles.xml', 'DOMDocument');
        // get the settings
        $this->_wordSettingsT = $this->getFromZip('word/settings.xml', 'DOMDocument');

        // use some default styles, for example, in the creation of lists, footnotes, titles, ...
        // So we should make sure that it is included in the styles.xml document
        if (!$this->_defaultTemplate || $this->_docxTemplate) {
            $this->importStyles(PHPDOCX_BASE_TEMPLATE, 'PHPDOCXStyles');
        }

        // get the numbering
        // if it does not exist it will return false
        $this->_wordNumberingT = $this->getFromZip('word/numbering.xml');

        // manage the numbering.xml and style.xml files
        // first check if the base template file has a numbering.xml file
        $numRef = rand(9999999, 99999999);
        self::$numUL = $numRef;
        self::$numOL = $numRef + 1;
        if ($this->_wordNumberingT !== false) {
            $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$unorderedListStyle, self::$numUL);
            $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$orderedListStyle, self::$numOL);
        } else {
            $this->_wordNumberingT = $this->generateBaseWordNumbering();
            $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$unorderedListStyle, self::$numUL);
            $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$orderedListStyle, self::$numOL);
            //Now we should include the corresponding relationshipand Override
            $this->generateRELATIONSHIP(
                    'rId' . rand(99999999, 999999999), 'numbering', 'numbering.xml'
            );
            $this->generateOVERRIDE('/word/numbering.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml');
        }
        // make sure that there are the corresponding xmls, with all their relationships for endnotes and footnotes
        // footnotes
        if ($this->getFromZip('word/footnotes.xml') === false) {
            $this->_wordFootnotesT->loadXML(OOXMLResources::$footnotesXML);
            // include the corresponding relationshipand Override
            $this->generateRELATIONSHIP(
                    'rId' . rand(99999999, 999999999), 'footnotes', 'footnotes.xml'
            );
            $this->generateOVERRIDE('/word/footnotes.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.footnotes+xml');
        } else {
            $this->_wordFootnotesT = $this->getFromZip('word/footnotes.xml', 'DOMDocument');
        }
        if ($this->getFromZip('word/_rels/footnotes.xml.rels') === false) {
            $this->_wordFootnotesRelsT->loadXML(OOXMLResources::$notesXMLRels);
        } else {
            $this->_wordFootnotesRelsT = $this->getFromZip('word/_rels/footnotes.xml.rels', 'DOMDocument');
        }
        // endnotes
        if ($this->getFromZip('word/endnotes.xml') === false) {
            $this->_wordEndnotesT->loadXML(OOXMLResources::$endnotesXML);
            //Now we should include the corresponding relationshipand Override
            $this->generateRELATIONSHIP(
                    'rId' . rand(99999999, 999999999), 'endnotes', 'endnotes.xml'
            );
            $this->generateOVERRIDE('/word/endnotes.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.endnotes+xml');
        } else {
            $this->_wordEndnotesT = $this->getFromZip('word/endnotes.xml', 'DOMDocument');
        }
        if ($this->getFromZip('word/_rels/endnotes.xml.rels') === false) {
            $this->_wordEndnotesRelsT->loadXML(OOXMLResources::$notesXMLRels);
        } else {
            $this->_wordEndnotesRelsT = $this->getFromZip('word/_rels/endnotes.xml.rels', 'DOMDocument');
        }
        // comments
        if ($this->getFromZip('word/comments.xml') === false) {
            $this->_wordCommentsT->loadXML(OOXMLResources::$commentsXML);
            //Now we should include the corresponding relationshipand Override
            $this->generateRELATIONSHIP(
                    'rId' . rand(99999999, 999999999), 'comments', 'comments.xml'
            );
            $this->generateOVERRIDE('/word/comments.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.comments+xml');
        } else {
            $this->_wordCommentsT = $this->getFromZip('word/comments.xml', 'DOMDocument');
        }
        if ($this->getFromZip('word/_rels/comments.xml.rels') === false) {
            $this->_wordCommentsRelsT->loadXML(OOXMLResources::$notesXMLRels);
        } else {
            $this->_wordCommentsRelsT = $this->getFromZip('word/_rels/comments.xml.rels', 'DOMDocument');
        }

        // take care of the case that the template used is not one of the default preprocessed templates

        if ($this->_defaultTemplate) {
            self::$numUL = 1;
            self::$numOL = rand(9999, 999999999);
        } else {
            if (!$this->_docxTemplate) {
                // do some cleaning of the files from the base template zip
                // first look at the document.xml.rels file to analyze the contents
                // analyze its structure
                // in order to do that parse word/_rels/document.xml.rels
                $counter = $relationships->length - 1;

                for ($j = $counter; $j > -1; $j--) {
                    $completeType = $relationships->item($j)->getAttribute('Type');
                    $target = $relationships->item($j)->getAttribute('Target');
                    $tempArray = explode('/', $completeType);
                    $type = array_pop($tempArray);
                    // this array holds the data that has to be changed
                    $arrayCleaner = array();

                    switch ($type) {
                        case 'header':
                            array_push($this->_relsHeader, $target);
                            break;
                        case 'footer':
                            array_push($this->_relsFooter, $target);
                            break;
                        case 'chart':
                            $this->recursiveDelete($this->_baseTemplateFilesPath . '/word/charts');
                            $this->_wordRelsDocumentRelsT->documentElement->removeChild($relationships->item($j));
                            break;
                        case 'embeddings':
                            $this->recursiveDelete($this->_baseTemplateFilesPath . '/word/embeddings');
                            $this->_wordRelsDocumentRelsT->documentElement->removeChild($relationships->item($j));
                            break;
                    }
                }
            } else {
                // parse word/_rels/document.xml.rels
                $counter = $relationships->length - 1;

                for ($j = $counter; $j > -1; $j--) {
                    $completeType = $relationships->item($j)->getAttribute('Type');
                    $target = $relationships->item($j)->getAttribute('Target');
                    $tempArray = explode('/', $completeType);
                    $type = array_pop($tempArray);
                    // this array holds the data that has to be changed
                    $arrayCleaner = array();

                    switch ($type) {
                        case 'header':
                            array_push($this->_relsHeader, $target);
                            break;
                        case 'footer':
                            array_push($this->_relsFooter, $target);
                            break;
                    }
                }
            }
        }
        //make sure that we are using the default paper size and the default language
        if (!$this->_docxTemplate) {
            $this->modifyPageLayout($this->_phpdocxconfig['settings']['paper_size']);
            $this->setLanguage($this->_phpdocxconfig['settings']['language']);
        }
        //set bidi and rtl static variables
        if (isset($this->_phpdocxconfig['settings']['bidi'])) {
            self::$bidi = $this->_phpdocxconfig['settings']['bidi'];
        } else {
            self::$bidi = false;
        }
        if (isset($this->_phpdocxconfig['settings']['rtl'])) {
            self::$rtl = $this->_phpdocxconfig['settings']['rtl'];
        } else {
            self::$rtl = false;
        }
        if (self::$bidi || self::$rtl) {
            $this->setRTL(array('bidi' => self::$bidi, 'rtl' => self::$rtl));
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
     * Magic method, returns current word XML
     *
     * @access public
     * @return string Return current word
     */
    public function __toString()
    {
        $this->generateTemplateWordDocument();
        PhpdocxLogger::logger('Get document template content.', 'debug');
        return $this->_wordDocumentT;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setXmlWordDocument($domDocument)
    {
        $stringDoc = $domDocument->saveXML();
        $bodyTag = explode('<w:body>', $stringDoc);
        $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getDOMDocx()
    {
        $loadContent = $this->_documentXMLElement . '<w:body>' .
                $this->_wordDocumentC . '</w:body></w:document>';
        $domDocument = new \DomDocument();
        $domDocument->loadXML($loadContent);
        return $domDocument;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getDOMComments()
    {
        return $this->_wordCommentsT;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getDOMEndnotes()
    {
        return $this->_wordEndnotesT;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getDOMFootnotes()
    {
        return $this->_wordFootnotesT;
    }

    /**
     * Adds a background image to the document
     *
     * @access public
     * @param string $src
     */
    public function addBackgroundImage($src)
    {
        // extract some basic info about the background image
        $image = pathinfo($src);
        $extension = $image['extension'];
        $imageName = $image['filename'];
        // define an unique identifier
        $tempId = uniqid(mt_rand(999, 9999));
        $identifier = 'rId' . $tempId;

        // construct the background WordML code
        $this->_background = '<w:background w:color="' . $this->_backgroundColor . '">
                      <v:background id="id_' . uniqid(mt_rand(999, 9999)) . '" o:bwmode="white" o:targetscreensize="800,600">
                      <v:fill r:id="' . $identifier . '" o:title="tit_' . uniqid(mt_rand(999, 9999)) . '" recolor="t" type="frame" />
                      </v:background></w:background>';
        // make sure that there exists the corresponding content type
        $this->generateDEFAULT($extension, 'image/' . $extension);
        // copy the image in the media folder
        $this->saveToZip($src, 'word/media/img' . $tempId . '.' . $extension);
        // insert the relationship
        $relsImage = '<Relationship Id="' . $identifier . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $tempId . '.' . $extension . '" />';
        $relsNodeImage = $this->_wordRelsDocumentRelsT->createDocumentFragment();
        $relsNodeImage->appendXML($relsImage);
        $this->_wordRelsDocumentRelsT->documentElement->appendChild($relsNodeImage);
        // modify the settings to display the background image
        $this->docxSettings(array('displayBackgroundShape' => true));
    }

    /**
     * Adds a bookmart start or end tag
     *
     * @access public
     * @param array $options
     * Values:
     * 'type' (start, end)
     * 'name' (string)
     */
    public function addBookmark($options = array('type' => null, 'name' => null))
    {
        $class = get_class($this);
        $type = $options['type'];
        $name = $options['name'];
        // first check for the requested parameters
        if (empty($type) || empty($name)) {
            PhpdocxLogger::logger('The addBookmark method is lacking at least one required parameter', 'fatal');
        }
        if ($type == 'start') {
            $bookmarkId = rand(9999999, 999999999);
            $bookmark = '<w:bookmarkStart w:id="' . $bookmarkId . '" w:name="' . $name . '" />';
            CreateDocx::$bookmarksIds[$name] = $bookmarkId;
        } else if ($type == 'end') {
            if (empty(CreateDocx::$bookmarksIds[$name])) {
                PhpdocxLogger::logger('You are trying to end a nonexisting bookmark', 'fatal');
            }
            $bookmark = '<w:bookmarkEnd w:id="' . CreateDocx::$bookmarksIds[$name] . '" />';
            unset(CreateDocx::$bookmarksIds[$name]);
        } else {
            PhpdocxLogger::logger('The addBookmark type is incorrect', 'fatal');
        }
        PhpdocxLogger::logger('Adds a bookmark' . $type . ' to the Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $bookmark;
        } else {
            $this->_wordDocumentC .= (string) $bookmark;
        }
    }

    /**
     * Add a break
     *
     * @access public
     * @param array $options
     *  Values:
     * 'type' (line, page, column)
     * 'number' (int) the number of breaks that we want to include
     */
    public function addBreak($options = array('type' => 'line', 'number' => 1))
    {
        if (!isset($options['type'])) {
            $options['type'] = 'line';
        }
        if (!isset($options['number'])) {
            $options['number'] = 1;
        }

        $class = get_class($this);
        $break = CreatePage::getInstance();
        $break->generatePageBreak($options);
        PhpdocxLogger::logger('Add break to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $break;
        } else {
            $this->_wordDocumentC .= (string) $break;
        }
    }

    /**
     * Add a chart
     *
     * @access public
     * @param array $options
     *  Values: 'color' (1, 2, 3...) color scheme,
     *  'perspective' (20, 30...),
     *  'rotX' (20, 30...),
     *  'rotY' (20, 30...),
     *  'data' (array of values),
     *  'float' (left, right, center) floating chart. It only applies if textWrap is not inline (default value).
     *  'font' (Arial, Times New Roman...),
     *  'groupBar' (clustered, stacked, percentStacked),
     *  'horizontalOffset' (int) given in emus (1cm = 360000 emus)
     *  'chartAlign' (center, left, right),
     *  'showPercent' (0, 1),
     *  'sizeX' (10, 11, 12...),
     *  'sizeY' (10, 11, 12...),
     *  'textWrap' (0 (inline), 1 (square), 2 (front), 3 (back), 4 (up and bottom)),
     *  'verticalOffset' (int) given in emus (1cm = 360000 emus)
     *  'title',
     *  'type' (barChart, bar3DChart, bar3DChartCylinder, bar3DChartCone,  bar3DChartPyramid, colChart, col3DChart,
     *          col3DChartCylinder,  col3DChartCone, bar3DChartPyramid, pieChart, pie3DChart, lineChart, line3DChart,
     *          areaChart, area3DChart, radar, scatterChart, surfaceChart,ofpiechar, doughnut, bublechart)
     *  'legendPos' (r, l, t, b, none),
     *  'legendOverlay' (0, 1),
     *  'border' (0, 1),
     *  'haxLabel' horizontal axis label,
     *  'vaxLabel' vertical axis label,
     *  'showTable' (0, 1) shows the table of values,
     *  'vaxLabelDisplay' (rotated, vertical, horizontal),
     *  'haxLabelDisplay' (rotated, vertical, horizontal),
     *  'hgrid' (0, 1, 2, 3),
     *  'vgrid' (0, 1, 2, 3),
     *  'style' this work only in radar charts.
     *  'gapWidth' distance between the pie and the second chart(ofpiechart)
     *  'secondPieSize' : size of the second chart(ofpiechart)
     *  'splitType' how decide to split the values :auto(Default Split), cust(Custom Split), percent(Split by Percentage), pos(Split by Position), val(Split by Value)
     *  'splitPos' split position , integer or float
     *  'custSplit' array of index to split
     *  'subtype' type of the second chart pie or bar
     *  'explosion' distance between the diferents values
     *  'holeSize' size of the hole in doughnut type
     *  'symbol'  array of symbols(scatter chart)
     *  'symbolSize' the size of the simbols
     *  'smooth' smooth the line (scatter chart)
     *  'wireframe' boolean(surface chart)to remove content color and only leave the border colors
     *  'showValue' (0,1) shows the values inside the chart
     *  'showCategory' (0,1) shows the category inside the chart
     */
    public function addChart($options = array())
    {
        PhpdocxLogger::logger('Create chart.', 'debug');
        $class = get_class($this);

        $options = self::translateChartOptions2StandardFormat($options);
        try {
            if (isset($options['data']) && isset($options['type'])) {
                self::$intIdWord++;
                PhpdocxLogger::logger('New ID ' . self::$intIdWord . ' . Chart.', 'debug');
                $type = $options['type'];
                if (strpos($type, 'Chart') === false)
                    $type .= 'Chart';

                $graphic = CreateChartFactory::createObject($type);

                if ($graphic->createGraphic(self::$intIdWord, $options) != false) {
                    PhpdocxLogger::logger('Add chart word/charts/chart' . self::$intIdWord .
                            '.xml to DOCX.', 'info');
                    $this->_zipDocx->addFromString(
                            'word/charts/chart' . self::$intIdWord . '.xml', $graphic->getXmlChart()
                    );
                    $this->generateRELATIONSHIP(
                            'rId' . self::$intIdWord, 'chart', 'charts/chart' . self::$intIdWord . '.xml'
                    );
                    $this->generateDEFAULT('xlsx', 'application/octet-stream');
                    $this->generateOVERRIDE(
                            '/word/charts/chart' . self::$intIdWord . '.xml', 'application/vnd.openxmlformats-officedocument.' .
                            'drawingml.chart+xml'
                    );
                } else {
                    throw new \Exception(
                    'There was an error related to the chart.'
                    );
                }
                $excel = $graphic->getXlsxType();

                $this->_tempFileXLSX[self::$intIdWord] = tempnam($this->_tempDir, 'documentxlsx');
                if (
                        $excel->createXlsx(
                                $this->_tempFileXLSX[self::$intIdWord], $options['data']
                        ) != false
                ) {
                    $this->_zipDocx->addFile(
                            $this->_tempFileXLSX[self::$intIdWord], 'word/embeddings/datos' . self::$intIdWord . '.xlsx'
                    );

                    $chartRels = CreateChartRels::getInstance();
                    $chartRels->createRelationship(self::$intIdWord);
                    $this->_zipDocx->addFromString(
                            'word/charts/_rels/chart' . self::$intIdWord .
                            '.xml.rels', (string) $chartRels
                    );
                }
                if ($this instanceof WordFragment) {
                    $this->wordML .= (string) $graphic;
                } else {
                    $this->_wordDocumentC .= (string) $graphic;
                }
            } else {
                throw new \Exception(
                'Charts must have data and type values.'
                );
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }

    /**
     * Adds a comment
     *
     * @access public
     * @param array $options
     *  Values:
     * 'textDocument'(mixed) a string of text to appear in the document body as anchor for the comment or an array with the text and associated text options
     * 'textComment' (mixed) a string of text to be used as the comment text or a Word fragment
     * 'initials' (string)
     * 'author' (string)
     * 'date' (string)
     */
    public function addComment($options = array())
    {
        $class = get_class($this);
        $id = rand(9999, 32766); //this number can not be bigger or equal than 32767
        $idBookmark = uniqid(mt_rand(999, 9999));
        if ($options['textComment'] instanceof WordFragment) {
            $commentBase = '<w:comment w:id="' . $id . '"';
            if (isset($options['initials'])) {
                $commentBase .= ' w:initials="' . $options['initials'] . '"';
            }
            if (isset($options['author'])) {
                $commentBase .= ' w:author="' . $options['author'] . '"';
            }
            if (isset($options['date'])) {
                $commentBase .= ' w:date="' . date("Y-m-d\TH:i:s\Z", strtotime($options['date'])) . '"';
            }
            $commentBase .= ' xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
                xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
                xmlns:v="urn:schemas-microsoft-com:vml"
                xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
                xmlns:w10="urn:schemas-microsoft-com:office:word"
                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
                >';
            $commentBase .= $this->parseWordMLNote('comment', $options['textComment'], array(), array());
            $commentbase .= '<w:bookmarkStart w:id="' . $idBookmark . '" w:name="_GoBack"/><w:bookmarkEnd w:id="' . $idBookmark . '"/>';
            $commentBase .= '</w:comment>';
        } else {
            $commentBase = '<w:comment w:id="' . $id . '"';
            if (isset($options['initials'])) {
                $commentBase .= ' w:initials="' . $options['initials'] . '"';
            }
            if (isset($options['author'])) {
                $commentBase .= ' w:author="' . $options['author'] . '"';
            }
            if (isset($options['date']) && ($options['date'] instanceof date )) {
                $commentBase .= ' w:date="' . date("Y-m-d\TH:i:s\Z", strtotime($options['date'])) . '"';
            }
            $commentBase .= ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" ><w:p>
                <w:pPr><w:pStyle w:val="commentTextPHPDOCX"/>';
            if (self::$bidi) {
                $commentBase .= '<w:bidi />';
            }
            $commentBase .= '</w:pPr>';
            $commentBase .= '<w:r><w:rPr><w:rStyle w:val="commentReferencePHPDOCX"/>';
            if (self::$rtl) {
                $commentBase .= '<w:rtl />';
            }
            $commentBase .= '</w:rPr><w:annotationRef/></w:r>';
            $commentBase .= '<w:r>';
            if (self::$rtl) {
                $commentBase .= '<w:rPr><w:rtl /></w:rPr>';
            }
            $commentBase .= '<w:t xml:space="preserve">' . $options['textComment'] . '</w:t></w:r></w:p>';
            $commentbase .= '<w:bookmarkStart w:id="' . $idBookmark . '" w:name="_GoBack"/><w:bookmarkEnd w:id="' . $idBookmark . '"/>';
            $commentBase .= '</w:comment>';
        }
        if (!is_array($options['textDocument'])) {
            $options['textDocument'] = array('text' => $options['textDocument']);
        }
        $textOptions = $options['textDocument'];
        $text = $textOptions['text'];
        $commentDocument = new WordFragment();
        $textOptions = self::setRTLOptions($textOptions);
        $commentDocument->addText($text, $textOptions);
        $commentStart = '</w:pPr><w:commentRangeStart w:id="' . $id . '"/>';
        $commentEnd .= '<w:commentRangeEnd w:id="' . $id . '"/>
                         <w:r><w:rPr><w:rStyle w:val="CommentReference"/>';
        if (self::$rtl) {
            $commentEnd .= '<w.rtl />';
        }
        $commentEnd .= '</w:rPr><w:commentReference w:id="' . $id . '"/></w:r></w:p>';
        // clean the commentDocument from auxilairy variable
        $commentDocument = preg_replace('/__[A-Z]+__/', '', $commentDocument);
        // pPrepare the data
        $commentDocument = str_replace('</w:pPr>', $commentStart, $commentDocument);
        $commentDocument = str_replace('</w:p>', $commentEnd, $commentDocument);


        $tempNode = $this->_wordCommentsT->createDocumentFragment();
        $tempNode->appendXML($commentBase);
        $this->_wordCommentsT->documentElement->appendChild($tempNode);


        PhpdocxLogger::logger('Add comment to word document.', 'info');

        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $commentDocument;
        } else {
            $this->_wordDocumentC .= (string) $commentDocument;
        }
    }

    /**
     * Adds date and hour to the Word document
     *
     * @access public
     * @param array $options Style options to apply to the date
     *  Values:
     * 'bidi' (boolean) set to true for right to left languages
     * 'bold' (boolean)
     * 'color' (ffffff, ff0000...)
     * 'dateFormat (string) dd/MM/yyyy H:mm:ss (default value) One may define a
     * customised format like dd' of 'MMMM' of 'yyyy' at 'H:mm (resulting in 20 of December of 2012 at 9:30)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (int)
     * 'italic' (boolean)
     * 'lineSpacing' 120, 240 (standard), 480...
     * 'indentLeft' (int) in twentieths of a point (twips)
     * 'indentRight' (int) in twentieths of a point (twips)
     * 'pageBreakBefore' (on, off)
     * 'textAlign' (both, center, distribute, left, right)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (boolean)
     * 'wordWrap' (boolean)     
     *
     */
    public function addDateAndHour($options = array('dateFormat' => 'dd/MM/yyyy H:mm:ss'))
    {
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        if (!isset($options['dateFormat'])) {
            $options['dateFormat'] = 'dd/MM/yyyy H:mm:ss';
        }
        $date = new WordFragment();
        $date->addText('date', $options);
        $date = preg_replace('/__[A-Z]+__/', '', $date);
        $dateRef = '<?xml version="1.0" encoding="UTF-8" ?>' . $date;
        $dateRef = str_replace('<w:p>', '<w:p xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">', $dateRef);
        $dateDOM = new \DOMDocument();

        $dateDOM->loadXML($dateRef);
        $pPrNodes = $dateDOM->getElementsByTagName('pPr');
        if ($pPrNodes->length > 0) {
            $pPrContent = $dateDOM->saveXML($pPrNodes->item(0));
        } else {
            $pPrContent = '';
        }
        $rPrNodes = $dateDOM->getElementsByTagName('rPr');
        if ($rPrNodes->length > 0) {
            $rPrContent = $dateDOM->saveXML($rPrNodes->item(0));
        } else {
            $rPrContent = '';
        }
        if ($pPrContent != '') {
            $pPrContent = str_replace('</w:pPr>', $rPrContent . '</w:pPr>', $pPrContent);
        } else {
            $pPrContent = '<w:pPr>' . $rPrContent . '</w:pPr>';
        }
        $runs = '<w:r>' . $rPrContent . '<w:fldChar w:fldCharType="begin" /></w:r>';
        $runs .= '<w:r>' . $rPrContent . '<w:instrText xml:space="preserve">TIME \@ &quot;' . $options['dateFormat'] . '&quot;</w:instrText></w:r>';
        $runs .= '<w:r>' . $rPrContent . '<w:fldChar w:fldCharType="separate" /></w:r>';
        $runs .= '<w:r>' . $rPrContent . '<w:t>date</w:t></w:r>';
        $runs .= '<w:r>' . $rPrContent . '<w:fldChar w:fldCharType="end" /></w:r>';

        $date = '<w:p>' . $pPrContent . $runs . '</w:p>';
        PhpdocxLogger::logger('Add a date to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $date;
        } else {
            $this->_wordDocumentC .= (string) $date;
        }
    }

    /**
     * Adds an endnote
     *
     * @access public
     * @param array $options.
     * Values:
     * 'textDocument'(mixed) a string of text to appear in the document body or an array with the text and associated text options
     * 'textEndnote' (mixed) a string of text to be used as the endnote text or a WordML fragment
     * 'endnoteMark' (array) bidi, customMark, font, fontSize, bold, italic, color, rtl
     * 'referenceMark' (array) bidi, font, fontSize, bold, italic, color, rtl
     */
    public function addEndnote($options = array())
    {
        $options['endnoteMark'] = self::translateTextOptions2StandardFormat($options['endnoteMark']);
        $options['endnoteMark'] = self::setRTLOptions($options['endnoteMark']);
        $options['referenceMark'] = self::translateTextOptions2StandardFormat($options['referenceMark']);
        $options['referenceMark'] = self::setRTLOptions($options['referenceMark']);
        $class = get_class($this);
        $id = rand(9999, 32766); //this number can not be bigger or equal than 32767
        if ($options['textEndnote'] instanceof WordFragment) {
            $endnoteBase = '<w:endnote w:id="' . $id . '"
                xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
                xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
                xmlns:v="urn:schemas-microsoft-com:vml"
                xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
                xmlns:w10="urn:schemas-microsoft-com:office:word"
                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
                >';
            $endnoteBase .= $this->parseWordMLNote('endnote', $options['textEndnote'], $options['endnoteMark'], $options['referenceMark']);
            $endnoteBase .= '</w:endnote>';
        } else {
            $endnoteBase = '<w:endnote w:id="' . $id . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:p>
                <w:pPr><w:pStyle w:val="endnoteTextPHPDOCX"/>';
            if (self::$bidi) {
                $endnoteBase .= '<w:bidi />';
            }
            $endnoteBase .= '</w:pPr><w:r><w:rPr><w:rStyle w:val="endnoteReferencePHPDOCX"/>';

            //Parse the referenceMark options
            if (isset($options['referenceMark']['font'])) {
                $endnoteBase .= '<w:rFonts w:ascii="' . $options['referenceMark']['font'] .
                        '" w:hAnsi="' . $options['referenceMark']['font'] .
                        '" w:cs="' . $options['referenceMark']['font'] . '"/>';
            }
            if (isset($options['referenceMark']['b'])) {
                $endnoteBase .= '<w:b w:val="' . $options['referenceMark']['b'] . '"/>';
                $endnoteBase .= '<w:bCs w:val="' . $options['referenceMark']['b'] . '"/>';
            }
            if (isset($options['referenceMark']['i'])) {
                $endnoteBase .= '<w:i w:val="' . $options['referenceMark']['i'] . '"/>';
                $endnoteBase .= '<w:iCs w:val="' . $options['referenceMark']['i'] . '"/>';
            }
            if (isset($options['referenceMark']['color'])) {
                $endnoteBase .= '<w:color w:val="' . $options['referenceMark']['color'] . '"/>';
            }
            if (isset($options['referenceMark']['sz'])) {
                $endnoteBase .= '<w:sz w:val="' . (2 * $options['referenceMark']['sz']) . '"/>';
                $endnoteBase .= '<w:szCs w:val="' . (2 * $options['referenceMark']['sz']) . '"/>';
            }
            if (isset($options['referenceMark']['rtl']) && $options['referenceMark']['rtl']) {
                $endnoteBase .= '<w:rtl />';
            }
            $endnoteBase .= '</w:rPr>';
            if (isset($options['endnoteMark']['customMark'])) {
                $endnoteBase .= '<w:t>' . $options['endnoteMark']['customMark'] . '</w:t>';
            } else {
                $endnoteBase .= '<w:endnoteRef/>';
            }
            $endnoteBase .= '</w:r>';
            if (self::$rtl) {
                $endnoteBase .= '<w:rPr><w:rtl /></w:rPr>';
            }
            $endnoteBase .= '<w:r><w:t xml:space="preserve">' . $options['textEndnote'] . '</w:t></w:r></w:p>
                </w:endnote>';
        }
        if (!is_array($options['textDocument'])) {
            $options['textDocument'] = array('text' => $options['textDocument']);
        }
        $textOptions = $options['textDocument'];
        $textOptions = self::setRTLOptions($textOptions);
        $text = $textOptions['text'];
        $endnoteDocument = new WordFragment();
        $endnoteDocument->addText($text, $textOptions);
        $endnoteMark = '<w:r><w:rPr><w:rStyle w:val="endnoteReferencePHPDOCX" />';
        //Parse the endnoteMark options
        if (isset($options['endnoteMark']['font'])) {
            $endnoteMark .= '<w:rFonts w:ascii="' . $options['endnoteMark']['font'] .
                    '" w:hAnsi="' . $options['endnoteMark']['font'] .
                    '" w:cs="' . $options['endnoteMark']['font'] . '"/>';
        }
        if (isset($options['endnoteMark']['b'])) {
            $endnoteMark .= '<w:b w:val="' . $options['endnoteMark']['b'] . '"/>';
            $endnoteMark .= '<w:bCs w:val="' . $options['endnoteMark']['b'] . '"/>';
        }
        if (isset($options['endnoteMark']['i'])) {
            $endnoteMark .= '<w:i w:val="' . $options['endnoteMark']['i'] . '"/>';
            $endnoteMark .= '<w:iCs w:val="' . $options['endnoteMark']['i'] . '"/>';
        }
        if (isset($options['endnoteMark']['color'])) {
            $endnoteMark .= '<w:color w:val="' . $options['endnoteMark']['color'] . '"/>';
        }
        if (isset($options['endnoteMark']['sz'])) {
            $endnoteMark .= '<w:sz w:val="' . (2 * $options['endnoteMark']['sz']) . '"/>';
            $endnoteMark .= '<w:szCs w:val="' . (2 * $options['endnoteMark']['sz']) . '"/>';
        }
        if (isset($options['endnoteMark']['rtl']) && $options['endnoteMark']['rtl']) {
            $endnoteMark .= '<w:rtl />';
        }
        $endnoteMark .= '</w:rPr><w:endnoteReference w:id="' . $id . '" ';
        if (isset($options['endnoteMark']['customMark'])) {
            $endnoteMark .= 'w:customMarkFollows="1"/><w:t>' . $options['endnoteMark']['customMark'] . '</w:t>';
        } else {
            $endnoteMark .= '/>';
        }
        $endnoteMark .= '</w:r></w:p>';
        $endnoteDocument = str_replace('</w:p>', $endnoteMark, $endnoteDocument);
        //Clean the endnoteDocument from auxilairy variable
        $endnoteDocument = preg_replace('/__[A-Z]+__/', '', $endnoteDocument);

        $tempNode = $this->_wordEndnotesT->createDocumentFragment();
        $tempNode->appendXML($endnoteBase);
        $this->_wordEndnotesT->documentElement->appendChild($tempNode);


        PhpdocxLogger::logger('Add endnote to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $endnoteDocument;
        } else {
            $this->_wordDocumentC .= (string) $endnoteDocument;
        }
    }
    
    /**
     * Embeds a external DOCX, HTML, MHT or RTF file
     *
     * @access public
     * @param array $options
     * 'src' (string) path to the external file
     * 'firstMatch (boolean) if true it only replaces the first variable match. Default is set to false.
     * 'matchSource' (boolean) if true (default value)tries to preserve as much as posible the styles of the docx to be included
     * 'preprocess' (boolean) if true does some preprocessing on the docx file to add
     * @return void
     */
    public function addExternalFile($options)
    {
       if (file_exists($options['src'])) {
            $extension = pathinfo($options['src'], PATHINFO_EXTENSION);
            if ($extension == 'docx') {
                $this->addDOCX($options);
            } elseif ($extension == 'html') {
                $this->addHTML($options);
            } elseif ($extension == 'mht') {
                $this->addMHT($options);
            } elseif ($extension == 'rtf') {
                $this->addRTF($options);
            } else {
                PhpdocxLogger::logger('Invalid file extension', 'fatal');
            }
        } else {
            PhpdocxLogger::logger('The file does not exist', 'fatal');
        }
    }

    /**
     * Add a footer
     *
     * @access public
     * @param array $footer
     * @param array
     *  Values:
     * 'default'(object) WordFragment
     * 'even' (object) WordFragment
     * 'first' (object) WordFragment
     */
    public function addFooter($footers)
    {
        $this->removeFooters();
        foreach ($footers as $key => $value) {
            if ($value instanceof WordFragment) {
                $this->_wordFooterT[$key] = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
                                            <w:ftr
                                                xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
                                                xmlns:o="urn:schemas-microsoft-com:office:office"
                                                xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
                                                xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
                                                xmlns:v="urn:schemas-microsoft-com:vml"
                                                xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
                                                xmlns:w10="urn:schemas-microsoft-com:office:word"
                                                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                                                xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">';
                $this->_wordFooterT[$key] .= (string) $value;
                $this->_wordFooterT[$key] .= '</w:ftr>';
                $this->_wordFooterT[$key] = preg_replace('/__[A-Z]+__/', '', $this->_wordFooterT[$key]);
                // first insert image rels
                // then insert external images rels
                // then insert link rels
                $relationships = '';
                if (isset(CreateDocx::$_relsHeaderFooterImage[$key . 'Footer'])) {
                    foreach (CreateDocx::$_relsHeaderFooterImage[$key . 'Footer'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $value2['rId'] . '.' . $value2['extension'] . '" />';
                    }
                }
                if (isset(CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Footer'])) {
                    foreach (CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Footer'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' . $value2['url'] . '" TargetMode="External" />';
                    }
                }
                if (isset(CreateDocx::$_relsHeaderFooterLink[$key . 'Footer'])) {
                    foreach (CreateDocx::$_relsHeaderFooterLink[$key . 'Footer'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="' . $value2['url'] . '" TargetMode="External" />';
                    }
                }
                // create the complete rels file relative to that footer
                if ($relationships != '') {
                    $rels = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">';
                    $rels .= $relationships;
                    $rels .= '</Relationships>';
                }
                // include the footer xml files
                $this->saveToZip($this->_wordFooterT[$key], 'word/' . $key . 'Footer.xml');
                // include the footer rels files
                if (isset($rels)) {
                    $this->saveToZip($rels, 'word/_rels/' . $key . 'Footer.xml.rels');
                }
                // modify the document.xml.rels file
                $newId = uniqid(mt_rand(999, 9999));
                $newFooterNode = '<Relationship Id="rId';
                $newFooterNode .= $newId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer"';
                $newFooterNode .= ' Target="' . $key . 'Footer.xml" />';
                $newNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $newNode->appendXML($newFooterNode);
                $baseNode = $this->_wordRelsDocumentRelsT->documentElement;
                $baseNode->appendChild($newNode);
                //7. modify accordingly the sectPr node
                $newSectNode = '<w:footerReference w:type="' . $key . '" r:id="rId' . $newId . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>';
                $sectNode = $this->_sectPr->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $this->_sectPr->documentElement->childNodes->item(0);
                $refNode->parentNode->insertBefore($sectNode, $refNode);
                if ($key == 'first') {
                    $this->generateTitlePg(false);
                } else if ($key == 'even') {
                    $this->generateSetting('w:evenAndOddHeaders');
                }
                // generate the corresponding Override element in [Content_Types].xml
                $this->generateOVERRIDE(
                        '/word/' . $key . 'Footer.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.' .
                        'footer+xml'
                );
                // refresh the _relsFooter array
                $this->_relsFooter[] = $key . 'Footer.xml';
                // refresh the arrays used to hold the image and link data
                CreateDocx::$_relsHeaderFooterImage[$key . 'Footer'] = array();
                CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Footer'] = array();
                CreateDocx::$_relsHeaderFooterLink[$key . 'Footer'] = array();
            } else {
                PhpdocxLogger::logger('The footer contents must be WordML fragments', 'fatal');
            }
        }
    }

    /**
     * Adds a footnote
     *
     * @access public
     * @param array $options
     *  Values:
     * 'textDocument'(mixed) a string of text to appear in the document body or an array with the text and associated text options
     * 'textFootnote' (mixed) a string of text to be used as the footnote text or a WordML fragment
     * 'footnoteMark' (array) bidi, customMark, font, fontSize, bold, italic, color, rtl
     * 'referenceMark' (array) bidi, font, fontSize, bold, italic, color, rtl
     */
    public function addFootnote($options = array())
    {
        $options['footnoteMark'] = self::translateTextOptions2StandardFormat($options['footnoteMark']);
        $options['footnoteMark'] = self::setRTLOptions($options['footnoteMark']);
        $options['referenceMark'] = self::translateTextOptions2StandardFormat($options['referenceMark']);
        $options['referenceMark'] = self::setRTLOptions($options['referenceMark']);
        $class = get_class($this);
        $id = rand(9999, 32766); //this number can not be bigger or equal than 32767
        if ($options['textFootnote'] instanceof WordFragment) {
            $footnoteBase = '<w:footnote w:id="' . $id . '"
                xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
                xmlns:o="urn:schemas-microsoft-com:office:office"
                xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
                xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
                xmlns:v="urn:schemas-microsoft-com:vml"
                xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
                xmlns:w10="urn:schemas-microsoft-com:office:word"
                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
                >';
            $footnoteBase .= $this->parseWordMLNote('footnote', $options['textFootnote'], $options['footnoteMark'], $options['referenceMark']);
            $footnoteBase .= '</w:footnote>';
        } else {
            $footnoteBase = '<w:footnote w:id="' . $id . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:p>
                <w:pPr><w:pStyle w:val="footnoteTextPHPDOCX"/>';
            if (self::$bidi) {
                $footnoteBase .= '<w:bidi />';
            }
            $footnoteBase .= '</w:pPr><w:r><w:rPr><w:rStyle w:val="footnoteReferencePHPDOCX"/>';
            // parse the referenceMark options
            if (isset($options['referenceMark']['font'])) {
                $footnoteBase .= '<w:rFonts w:ascii="' . $options['referenceMark']['font'] .
                        '" w:hAnsi="' . $options['referenceMark']['font'] .
                        '" w:cs="' . $options['referenceMark']['font'] . '"/>';
            }
            if (isset($options['referenceMark']['b'])) {
                $footnoteBase .= '<w:b w:val="' . $options['referenceMark']['b'] . '"/>';
                $footnoteBase .= '<w:bCs w:val="' . $options['referenceMark']['b'] . '"/>';
            }
            if (isset($options['referenceMark']['i'])) {
                $footnoteBase .= '<w:i w:val="' . $options['referenceMark']['i'] . '"/>';
                $footnoteBase .= '<w:iCs w:val="' . $options['referenceMark']['i'] . '"/>';
            }
            if (isset($options['referenceMark']['color'])) {
                $footnoteBase .= '<w:color w:val="' . $options['referenceMark']['color'] . '"/>';
            }
            if (isset($options['referenceMark']['sz'])) {
                $footnoteBase .= '<w:sz w:val="' . (2 * $options['referenceMark']['sz']) . '"/>';
                $footnoteBase .= '<w:szCs w:val="' . (2 * $options['referenceMark']['sz']) . '"/>';
            }
            if (isset($options['referenceMark']['rtl']) && $options['referenceMark']['rtl']) {
                $footnoteBase .= '<w:rtl />';
            }
            $footnoteBase .= '</w:rPr>';
            if (isset($options['footnoteMark']['customMark'])) {
                $footnoteBase .= '<w:t>' . $options['footnoteMark']['customMark'] . '</w:t>';
            } else {
                $footnoteBase .= '<w:footnoteRef/>';
            }
            $footnoteBase .= '</w:r>';
            if (self::$rtl) {
                $footnoteBase .= '<w:rPr><w:rtl /></w:rPr>';
            }
            $footnoteBase .= '<w:r><w:t xml:space="preserve">' . $options['textFootnote'] . '</w:t></w:r></w:p>
                </w:footnote>';
        }
        if (!is_array($options['textDocument'])) {
            $options['textDocument'] = array('text' => $options['textDocument']);
        }
        $textOptions = $options['textDocument'];
        $textOptions = self::setRTLOptions($textOptions);
        $text = $textOptions['text'];
        $footnoteDocument = new WordFragment();
        $footnoteDocument->addText($text, $textOptions);
        $footnoteMark = '<w:r><w:rPr><w:rStyle w:val="footnoteReferencePHPDOCX" />';
        // parse the footnoteMark options
        if (isset($options['footnoteMark']['font'])) {
            $footnoteMark .= '<w:rFonts w:ascii="' . $options['footnoteMark']['font'] .
                    '" w:hAnsi="' . $options['footnoteMark']['font'] .
                    '" w:cs="' . $options['footnoteMark']['font'] . '"/>';
        }
        if (isset($options['footnoteMark']['b'])) {
            $footnoteMark .= '<w:b w:val="' . $options['footnoteMark']['b'] . '"/>';
            $footnoteMark .= '<w:bCs w:val="' . $options['footnoteMark']['b'] . '"/>';
        }
        if (isset($options['footnoteMark']['i'])) {
            $footnoteMark .= '<w:i w:val="' . $options['footnoteMark']['i'] . '"/>';
            $footnoteMark .= '<w:iCs w:val="' . $options['footnoteMark']['i'] . '"/>';
        }
        if (isset($options['footnoteMark']['color'])) {
            $footnoteMark .= '<w:color w:val="' . $options['footnoteMark']['color'] . '"/>';
        }
        if (isset($options['footnoteMark']['sz'])) {
            $footnoteMark .= '<w:sz w:val="' . (2 * $options['footnoteMark']['sz']) . '"/>';
            $footnoteMark .= '<w:szCs w:val="' . (2 * $options['footnoteMark']['sz']) . '"/>';
        }
        if (isset($options['footnoteMark']['rtl']) && $options['footnoteMark']['rtl']) {
            $footnoteMark .= '<w:rtl />';
        }
        $footnoteMark .= '</w:rPr><w:footnoteReference w:id="' . $id . '" ';
        if (isset($options['footnoteMark']['customMark'])) {
            $footnoteMark .= 'w:customMarkFollows="1"/><w:t>' . $options['footnoteMark']['customMark'] . '</w:t>';
        } else {
            $footnoteMark .= '/>';
        }
        $footnoteMark .= '</w:r></w:p>';
        $footnoteDocument = str_replace('</w:p>', $footnoteMark, $footnoteDocument);
        // clean the footnoteDocument from auxilairy variable
        $footnoteDocument = preg_replace('/__[A-Z]+__/', '', $footnoteDocument);

        $tempNode = $this->_wordFootnotesT->createDocumentFragment();
        $tempNode->appendXML($footnoteBase);
        $this->_wordFootnotesT->documentElement->appendChild($tempNode);

        PhpdocxLogger::logger('Add footnote to word document.', 'info');

        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $footnoteDocument;
        } else {
            $this->_wordDocumentC .= (string) $footnoteDocument;
        }
    }

    /**
     * Add a Form element (text field, select or checkbox)
     *
     * @access public
     * @param mixed $type it can be 'textfield', 'checkbox' or 'select'
     * @param array $options Style options to apply to the text
     *  Values:
     * 'bidi' (bool)
     * 'bold' (bool)
     * 'color' (ffffff, ff0000...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (int)
     * 'italic' (bool)
     * 'textAlign' (both, center, distribute, left, right)
     * 'lineBreak' (before, after, both)
     * 'columnBreak' (before, after, both)
     * 'pageBreakBefore' (on, off)
     * 'rtl' (bool)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (bool)
     * 'wordWrap' (bool)
     * 'lineSpacing' 120, 240 (standard), 480...,
     * 'indentLeft' 100...,
     * 'indentRight' 100...
     * 'defaultValue' (mixed) a string of text for the textfield type,
     * a boolean value for the checkbox type or an integer representing the index (0 based)
     * for the options of a select form element
     * 'selectOptions' (array) an array of options for the dropdown menu
     */
    public function addFormElement($type, $options = array())
    {
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        $formElementTypes = array('textfield', 'checkbox', 'select');
        if (!in_array($type, $formElementTypes)) {
            PhpdocxLogger::logger('The chosen form element type is not available', 'fatal');
        }
        $formElementBase = CreateText::getInstance();
        $ParagraphOptions = $options;
        $formElementBase = new WordFragment();
        $formElementBase->addText(array(array('text' => '__formElement__')), $ParagraphOptions);
        $formElement = CreateFormElement::getInstance();
        $formElement->createFormElement($type, $options, (string) $formElementBase);
        PhpdocxLogger::logger('Add form element to Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $formElement;
        } else {
            $this->_wordDocumentC .= (string) $formElement;
        }
    }

    /**
     * Add a header
     *
     * @access public
     * @param array $headers
     *  Values:
     * 'default'(object) WordFragment
     * 'even' (object) WordFragment
     * 'first' (object) WordFragment
     */
    public function addHeader($headers)
    {
        $this->removeHeaders();
        foreach ($headers as $key => $value) {
            if ($value instanceof WordFragment) {
                $this->_wordHeaderT[$key] = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
                                            <w:hdr
                                                xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
                                                xmlns:o="urn:schemas-microsoft-com:office:office"
                                                xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
                                                xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
                                                xmlns:v="urn:schemas-microsoft-com:vml"
                                                xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
                                                xmlns:w10="urn:schemas-microsoft-com:office:word"
                                                xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
                                                xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">';
                $this->_wordHeaderT[$key] .= (string) $value;
                $this->_wordHeaderT[$key] .= '</w:hdr>';
                $this->_wordHeaderT[$key] = preg_replace('/__[A-Z]+__/', '', $this->_wordHeaderT[$key]);
                // first insert image Rels
                // then insert external images rels
                // then insert Link rels
                $relationships = '';
                if (isset(CreateDocx::$_relsHeaderFooterImage[$key . 'Header'])) {
                    foreach (CreateDocx::$_relsHeaderFooterImage[$key . 'Header'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $value2['rId'] . '.' . $value2['extension'] . '" />';
                    }
                }
                if (isset(CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Header'])) {
                    foreach (CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Header'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' . $value2['url'] . '" TargetMode="External" />';
                    }
                }
                if (isset(CreateDocx::$_relsHeaderFooterLink[$key . 'Header'])) {
                    foreach (CreateDocx::$_relsHeaderFooterLink[$key . 'Header'] as $key2 => $value2) {
                        $relationships .= '<Relationship Id="' . $value2['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="' . $value2['url'] . '" TargetMode="External" />';
                    }
                }
                // create the complete rels file relative to that header
                if ($relationships != '') {
                    $rels = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">';
                    $rels .= $relationships;
                    $rels .= '</Relationships>';
                }
                // include the header xml files
                $this->saveToZip($this->_wordHeaderT[$key], 'word/' . $key . 'Header.xml');
                // include the header rels files
                if (isset($rels)) {
                    $this->saveToZip($rels, 'word/_rels/' . $key . 'Header.xml.rels');
                }
                // modify the document.xml.rels file
                $newId = uniqid(mt_rand(999, 9999));
                $newHeaderNode = '<Relationship Id="rId';
                $newHeaderNode .= $newId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header"';
                $newHeaderNode .= ' Target="' . $key . 'Header.xml" />';
                $newNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $newNode->appendXML($newHeaderNode);
                $baseNode = $this->_wordRelsDocumentRelsT->documentElement;
                $baseNode->appendChild($newNode);
                // modify accordingly the sectPr node
                $newSectNode = '<w:headerReference w:type="' . $key . '" r:id="rId' . $newId . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>';
                $sectNode = $this->_sectPr->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $this->_sectPr->documentElement->childNodes->item(0);
                $refNode->parentNode->insertBefore($sectNode, $refNode);
                if ($key == 'first') {
                    $this->generateTitlePg(false);
                } else if ($key == 'even') {
                    $this->generateSetting('w:evenAndOddHeaders');
                }
                // generate the corresponding Override element in [Content_Types].xml
                $this->generateOVERRIDE(
                        '/word/' . $key . 'Header.xml', 'application/vnd.openxmlformats-officedocument.wordprocessingml.' .
                        'header+xml'
                );
                // refresh the _relsHeader array
                $this->_relsHeader[] = $key . 'Header.xml';
                //8.Refresh the arrays used to hold the image and link data
                CreateDocx::$_relsHeaderFooterImage[$key . 'Header'] = array();
                CreateDocx::$_relsHeaderFooterExternalImage[$key . 'Header'] = array();
                CreateDocx::$_relsHeaderFooterLink[$key . 'Header'] = array();
            } else {
                PhpdocxLogger::logger('The header contents must be WordML fragments', 'fatal');
            }
        }
    }

    /**
     * Adds a heading to the Word document
     *
     * @access public
     * @param string $text the heading text
     * @param int $level can be 1 (default), 2,3, ...
     * @param array $options Style options to apply to the heading
     *  Values:
     * 'bidi' (bool)
     * 'bold' (bool)
     * 'caps' (bool) display text in capital letters
     * 'color' (ffffff, ff0000...)
     * 'font' (Cambria (default), Arial, Times New Roman...)
     * 'fontSize' (int) size in points
     * 'italic' (bool)
     * 'indentLeft' (int) distange in twentieths of a point (twips)
     * 'indentRight' (int) distange in twentieths of a point (twips)
     * 'textAlign' (both, center, distribute, left, right)
     * 'keepLines' (bool) keep all paragraph lines on the same page
     * 'keepNext' (bool) keep in the same page the current paragraph with next paragraph
     * 'lineSpacing' 120, 240 (standard), 360, 480, ...
     * 'pageBreakBefore' (on, off)
     * 'spacingBottom' (int) bottom margin in twentieths of a point
     * 'spacingTop' (int) top margin in twentieths of a point
     * 'underline' (none, dash, dotted, double, single, wave, words)
     * 'widowControl' (on, off)
     * 'wordWrap' (on, off)
     */
    public function addHeading($text, $level = 1, $options = array())
    {
        $options = self::translateTextOptions2StandardFormat($options);
        $options = self::setRTLOptions($options);
        $class = get_class($this);

        if (!isset($options['b'])) {
            $options['b'] = 'on';
        }
        if (!isset($options['keepLines'])) {
            $options['keepLines'] = 'on';
        }
        if (!isset($options['keepNext'])) {
            $options['keepNext'] = 'on';
        }
        if (!isset($options['widowControl'])) {
            $options['widowControl'] = 'on';
        }
        if (!isset($options['sz'])) {
            $options['sz'] = max(15 - $level, 10);
        }
        if (!isset($options['font'])) {
            $options['font'] = 'Cambria';
        }

        $options['headingLevel'] = $level;
        $heading = CreateText::getInstance();
        $heading->createText($text, $options);
        PhpdocxLogger::logger('Adds a heading of level ' . $level . 'to the Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $heading;
        } else {
            $this->_wordDocumentC .= (string) $heading;
        }
    }

    /**
     * Add an image
     *
     * @access public
     * @param array $data
     * Values:
     * 'borderColor' (string)
     * 'borderStyle'(string) can be solid, dot, dash, lgDash, dashDot, lgDashDot, lgDashDotDot, sysDash, sysDot, sysDashDot, sysDashDotDot
     * 'borderWidth' (int) given in emus (1cm = 360000 emus)
     * 'float' (left, right, center) floating image. It only applies if textWrap is not inline (default value).
     * 'horizontalOffset' (int) given in emus (1cm = 360000 emus). Only applies if there is the image is not floating
     * 'imageAlign' (center, left, right, inside, outside)
     * 'src' (string) path to a local image
     * 'scaling' (int) a pecentage: 50, 100, ..
     * 'width' (int) in pixels
     * 'height' (int) in pixels
     * 'dpi' (int) dots per inch
     * 'spacingTop' (int) in pixels
     * 'spacingBottom' (int) in pixels
     * 'spacingLeft' (int) in pixels
     * 'spacingRight' (int) in pixels
     * 'textWrap' 0 (inline), 1 (square), 2 (front), 3 (back), 4 (up and bottom))
     * 'verticalOffset' (int) given in emus (1cm = 360000 emus)
     */
    public function addImage($data = '')
    {
        if (isset($data['width'])) {
            $data['sizeX'] = $data['width'];
        }
        if (isset($data['height'])) {
            $data['sizeY'] = $data['height'];
        }
        $class = get_class($this);
        if ($class != 'CreateDocx') {
            $data['target'] = $this->target;
        } else {
            $data['target'] = 'document';
        }
        PhpdocxLogger::logger('Create image.', 'debug');
        try {
            if (isset($data['src']) && file_exists($data['src']) == 'true') {
                $attrImage = getimagesize($data['src']);
                try {
                    if ($attrImage['mime'] == 'image/jpg' ||
                            $attrImage['mime'] == 'image/jpeg' ||
                            $attrImage['mime'] == 'image/png' ||
                            $attrImage['mime'] == 'image/gif'
                    ) {
                        self::$intIdWord++;
                        PhpdocxLogger::logger('New ID rId' . self::$intIdWord . ' . Image.', 'debug');
                        $image = CreateImage::getInstance();
                        $data['rId'] = self::$intIdWord;
                        $image->createImage($data);
                        $dir = $this->parsePath($data['src']);
                        PhpdocxLogger::logger('Add image word/media/imgrId' .
                                self::$intIdWord . '.' . $dir['extension'] .
                                '.xml to DOCX.', 'info');
                        $this->_zipDocx->addFile(
                                $data['src'], 'word/media/imgrId' .
                                self::$intIdWord . '.' .
                                $dir['extension']
                        );
                        $this->generateDEFAULT(
                                $dir['extension'], $attrImage['mime']
                        );
                        if ((string) $image != '') {
                            // consider the case where the image will be included in a header or footer
                            if ($data['target'] == 'defaultHeader' ||
                                    $data['target'] == 'firstHeader' ||
                                    $data['target'] == 'evenHeader' ||
                                    $data['target'] == 'defaultFooter' ||
                                    $data['target'] == 'firstFooter' ||
                                    $data['target'] == 'evenFooter') {
                                createDocx::$_relsHeaderFooterImage[$data['target']][] = array('rId' => 'rId' . self::$intIdWord, 'extension' => $dir['extension']);
                            } else if ($data['target'] == 'footnote' ||
                                    $data['target'] == 'endnote' ||
                                    $data['target'] == 'comment') {
                                CreateDocx::$_relsNotesImage[$data['target']][] = array('rId' => 'rId' . self::$intIdWord, 'extension' => $dir['extension']);
                            } else {
                                $this->generateRELATIONSHIP(
                                        'rId' . self::$intIdWord, 'image', 'media/imgrId' . self::$intIdWord . '.'
                                        . $dir['extension']
                                );
                            }
                        }
                        if ($this instanceof WordFragment) {
                            $this->wordML .= (string) $image;
                        } else {
                            $this->_wordDocumentC .= (string) $image;
                        }
                    } else {
                        throw new \Exception('Image format is not supported.');
                    }
                } catch (\Exception $e) {
                    PhpdocxLogger::logger($e->getMessage(), 'fatal');
                }
            } else {
                throw new \Exception('Image does not exist.');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }

    /**
     * Adds line numbering
     *
     * @access public
     * @param array $options
     * countBy (int) line number increments to display (default value is 1)
     * start (int) initial line number (default value is 1)
     * distance (int) separation in twentieths of a point between the number and the text (defaults to auto)
     * restart (string) could be:
     *      continuous (default value: the numbering does not get restarted anywhere in the document),
     *      newPage (the numbering restarts at the beginning of every page)
     *      newSection (the numbering restarts at the beginning of every section)
     * sectionNumbers (array) if empty it will apply to all sections
     */
    public function addLineNumbering($options = array())
    {
        // restart condition available types
        $restart_types = array('continuous', 'newPage', 'newSection');
        $lineNumberOptions = array();
        // set defaults
        if (isset($options['countBy']) && is_int($options['countBy'])) {
            $lineNumberOptions['countBy'] = $options['countBy'];
        } else {
            $lineNumberOptions['countBy'] = 1;
        }
        if (isset($options['start']) && is_int($options['start'])) {
            $lineNumberOptions['start'] = $options['start'];
        } else {
            $lineNumberOptions['start'] = 0;
        }
        if (isset($options['distance']) && is_int($options['distance'])) {
            $lineNumberOptions['distance'] = $options['distance'];
        }
        if (isset($options['restart']) && in_array($options['restart'], $restart_types)) {
            $lineNumberOptions['restart'] = $options['restart'];
        } else {
            $lineNumberOptions['restart'] = 'continuous';
        }
        if (!isset($options['sectionNumbers'])) {
            $options['sectionNumbers'] = NULL;
        }
        // get the current sectPr nodes
        $sectPrNodes = $this->getSectionNodes($options['sectionNumbers']);
        // modify them
        foreach ($sectPrNodes as $sectionNode) {
            $this->modifySingleSectionProperty($sectionNode, 'lnNumType', $lineNumberOptions);
        }
        $this->restoreDocumentXML();
    }

    /**
     * Add a link
     *
     * @access public
     * @param array $options
     * @see addText
     * additional parameter:
     * 'url' (string) URL or #bookmarkName
     *
     */
    public function addLink($text, $options = array())
    {
        if (!isset($options['color'])) {
            $options['color'] = '0000ff';
        }
        if (!isset($options['u']) && !isset($options['underline'])) {
            $options['underline'] = 'single';
        }
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        if (substr($options['url'], 0, 1) == '#') {
            $url = 'HYPERLINK \l "' . substr($options['url'], 1) . '"';
        } else {
            $url = 'HYPERLINK "' . $options['url'] . '"';
        }
        if ($text == '') {
            PhpdocxLogger::logger('The linked text is missing', 'fatal');
        } else if ($options['url'] == '') {
            PhpdocxLogger::logger('The URL is missing', 'fatal');
        }
        if (isset($options['color'])) {
            $color = $options['color'];
        } else {
            $color = '0000ff';
        }
        if (isset($options['u'])) {
            $u = $options['u'];
        } else {
            $u = 'single';
        }
        $textOptions = $options;
        $link = new WordFragment();
        $link->addText($text, $textOptions);
        $link = preg_replace('/__[A-Z]+__/', '', $link);
        $startNodes = '<w:r><w:fldChar w:fldCharType="begin" /></w:r><w:r>
        <w:instrText xml:space="preserve">' . $url . '</w:instrText>
        </w:r><w:r><w:fldChar w:fldCharType="separate" /></w:r>';
        if (strstr($link, '</w:pPr>')) {
            $link = preg_replace('/<\/w:pPr>/', '</w:pPr>' . $startNodes, $link);
        } else {
            $link = preg_replace('/<w:p>/', '<w:p>' . $startNodes, $link);
        }
        $endNode = '<w:r><w:fldChar w:fldCharType="end" /></w:r>';
        $link = preg_replace('/<\/w:p>/', $endNode . '</w:p>', $link);
        PhpdocxLogger::logger('Add link to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $link;
        } else {
            $this->_wordDocumentC .= (string) $link;
        }
    }

    /**
     * Add a list
     *
     * @access public
     * @param array $data Values of the list
     * @param string $styleType (mixed), 0 (clear), 1 (inordinate), 2(numerical) or the name of the created list
     * @param array $options formatting parameters for the text of all list items
     *  Values:
     * 'bold' (boolean)
     * 'caps' (boolean) display text in capital letters
     * 'color' (ffffff, ff0000, ...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (8, 9, 10, ...) size in points
     * 'highlightColor' (string) available highlighting colors are: black, blue, cyan, green, magenta, red, yellow, white, darkBlue, darkCyan, darkGreen, darkMagenta, darkRed,	darkYellow, darkGray, lightGray, none.
     * 'italic' (boolean)
     * 'smallCaps' (boolean)displays text in small capital letters
     * 'underline' (none, dash, dotted, double, single, wave, words)
     * 
     */
    public function addList($data, $styleType = 1, $options = array())
    {
        $options['val'] = (int) $styleType;
        $class = get_class($this);
        $list = CreateList::getInstance();

        if ($options['val'] == 2) {
            self::$numOL++;
            $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$orderedListStyle, self::$numOL);
        }
        if (is_string($styleType)) {
            $options['val'] = self::$customLists[$styleType]['id'];
        }
        $list->createList($data, $options);
        PhpdocxLogger::logger('Add list to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $list;
        } else {
            $this->_wordDocumentC .= (string) $list;
        }
    }

    /**
     * Add a macro from a DOC
     *
     * @access public
     * @param string $path Path to a file with macro
     */
    public function addMacroFromDoc($path)
    {

        if (!$this->_docm) {
            PhpdocxLogger::logger('The base template should be a docm to include a macro in your document', 'fatal');
            exit();
        }
        try {
            $package = new \ZipArchive();
            $openZip = $package->open($path);
            if ($openZip !== true) {
                throw new \Exception('Error while trying to open the given .docm');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        PhpdocxLogger::logger('Open document with a macro.', 'info');
        // copy the contents of vbaData
        $vbaData = $package->getFromName('word/vbaData.xml');
        $vbaBin = $package->getFromName('word/vbaProject.bin');
        PhpdocxLogger::logger('Add macro files to DOCX file.', 'info');
        // copy the contents
        $this->saveToZip($vbaData, 'word/vbaData.xml');
        $this->saveToZip($vbaBin, 'word/vbaProject.bin');
        $package->close();
    }

    /**
     * Add an existing math equation to DOCX
     *
     * @access public
     * @param string $equation DOCX file with an equation, OMML equation string or MML
     * @param string $type Type of equation: docx, omml, mathml
     */
    public function addMathEquation($equation, $type)
    {
        if ($type == 'docx') {
            $package = new \ZipArchive();
            PhpdocxLogger::logger('Open document with an existing math eq.', 'info');
            $package->open($equation);
            $document = $package->getFromName('word/document.xml');
            $eqs = preg_split('/<[\/]*m:oMathPara>/', $document);
            PhpdocxLogger::logger('Add math eq to word document.', 'info');
            $this->_wordDocumentC .= '<' . CreateDocx::NAMESPACEWORD . ':p>' .
                        '<m:oMathPara>' . $eqs[1] . '</m:oMathPara>' .
                        '</' . CreateDocx::NAMESPACEWORD . ':p>';
            $package->close();
        } elseif ($type == 'omml') {
            $class = get_class($this);
            PhpdocxLogger::logger('Add existing math eq to word document.', 'info');
            if ($this instanceof WordFragment) {
                $this->wordML .= (string) $equation;
            } else {
                $this->_wordDocumentC .= '<' . CreateDocx::NAMESPACEWORD . ':p>' .
                        (string) $equation . '</' . CreateDocx::NAMESPACEWORD . ':p>';
            }
        } elseif ($type == 'mathml') {
            $class = get_class($this);
            $math = CreateMath::getInstance();
            PhpdocxLogger::logger('Convert MathMML eq.', 'debug');
            $math->createMath($equation);
            PhpdocxLogger::logger('Add converted MathMML eq to word document.', 'info');
            if ($this instanceof WordFragment) {
                $this->wordML .= $transformedEquation;
            } else {
                $this->_wordDocumentC .= '<' . CreateDocx::NAMESPACEWORD . ':p>' .
                        '<m:oMathPara>' . (string) $math . '</m:oMathPara>' .
                        '</' . CreateDocx::NAMESPACEWORD . ':p>';
            }
        }
    }

    /**
     * Adds a merge field to the Word document
     *
     * @access public
     * @param string $name
     * @param array $mergeParameters
     * Keys and values:
     * 'format' (Caps, FirstCap, Lower, Upper)
     * 'mappedField' (boolean)
     * 'preserveFormat' (boolean)
     * 'textAfter' string of text to include after the merge field
     * 'textBefore' string of text to include before the merge field
     * 'verticalFormat' (boolean)
     * @param string $format
     * @param array $options style options to apply to the field
     * Fot the avalaible options @see addText
     *
     */
    public function addMergeField($name, $mergeParameters = array(), $options = array())
    {
        $options = self::setRTLOptions($options);
        if (!isset($mergeParameters['preserveFormat'])) {
            $mergeParameters['preserveFormat'] = true;
        }

        $fieldName = '';
        if (isset($mergeParameters['textBefore'])) {
            $fieldName .= $mergeParameters['textBefore'];
        }
        $fieldName .= '«' . $name . '»';
        if (isset($mergeParameters['textAfter'])) {
            $fieldName .= $mergeParameters['textAfter'];
        }

        $simpleField = new WordFragment();
        $simpleField->addText($fieldName, $options);

        $data = 'MERGEFIELD &quot;' . $name . '&quot; ';
        foreach ($mergeParameters as $key => $value) {
            switch ($key) {
                case 'textBefore':
                    $data .= '\b &quot;' . $value . '&quot; ';
                    break;
                case 'textAfter':
                    $data .= '\f &quot;' . $value . '&quot; ';
                    break;
                case 'mappedField':
                    if ($value) {
                        $data .= '\m ';
                    }
                    break;
                case 'verticalFormat':
                    if ($value) {
                        $data .= '\v ';
                    }
                    break;
                case 'preserveFormat':
                    if ($value) {
                        $data .= '\* MERGEFORMAT';
                    }
                    break;
            }
        }

        $beguin = '<w:fldSimple w:instr=" ' . $data . ' ">';
        $end = '</w:fldSimple>';

        $simpleField = str_replace('<w:r>', $beguin . '<w:r>', $simpleField);
        $simpleField = str_replace('</w:r>', '</w:r>' . $end, $simpleField);

        PhpdocxLogger::logger('Adding a merge field to the Word document.', 'info');

        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $simpleField;
        } else {
            $this->_wordDocumentC .= (string) $simpleField;
        }
    }

    /**
     * Adds page borders
     *
     * @access public
     * @param array $options (<side> stands for top, right, bootom or left)
     * 'zOrder' (int)
     * 'display' (string) posible values are:allPages (display page border on all pages, default value),
     *  firstPage(display page border on first page), notFirstPage (display page border on all pages except first)
     * 'offsetFrom' (string) posible values are: page or text
     * 'border' (nil, single, double, dashed, threeDEngrave, threeDEmboss, outset, inset, ...)
     *       this value can be override for each side with 'borderTop', 'borderRight', 'borderBottom' and 'borderLeft'
     * 'borderColor' (ffffff, ff0000)
     *      this value can be override for each side with 'borderTopColor', 'borderRightColor', 'borderBottomColor' and 'borderLeftColor'
     * 'borderSpacing' (0, 1, 2...)
     *      this value can be override for each side with 'borderTopSpacing', 'borderRightSpacing', 'borderBottomSpacing' and 'borderLeftSpacing'
     * 'borderWidth' (10, 11...) in eights of a point
     *      this value can be override for each side with 'borderTopWidth', 'borderRightWidth', 'borderBottomWidth' and 'borderLeftWidth'
     * sectionNumbers (array)
     */
    public function addPageBorders($options = array())
    {
        if (!isset($options['sectionNumbers'])) {
            $options['sectionNumbers'] = NULL;
        }

        $options = CreateDocx::translateTableOptions2StandardFormat($options);

        //Get the current sectPr nodes
        $sectPrNodes = $this->getSectionNodes($options['sectionNumbers']);
        //Modify them
        foreach ($sectPrNodes as $sectionNode) {
            $this->modifyPageBordersSectionProperty($sectionNode, $options);
        }
        $this->restoreDocumentXML();
    }

    /**
     * Adds a page number to the document
     * WARNING: if the page number is not added to a header or footer the user may
     * need to press F9 in the MS Word interface to update its value to the current page
     *
     * @access public
     * @param mixed $type (String): numerical, alphabetical.
     * @param array $options Style options to apply to the numbering
     *  Values:
     * 'bidi' (bool)
     * 'bold' (on, off)
     * 'color' (ffffff, ff0000...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (int) size in half points
     * 'italic' (on, off)
     * 'indentLeft' (int) distange in twentieths of a point (twips)
     * 'indentRight' (int) distange in twentieths of a point (twips)
     * 'pageBreakBefore' (bool)
     * 'textAlign' (both, center, distribute, left, right)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (bool)
     * 'wordWrap' (bool)
     * 'lineSpacing' 120, 240 (standard), 480...,
     * 'defaultValue' (int)
     *
     */
    public function addPageNumber($type = 'numerical', $options = array('defaultValue' => 1))
    {
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        if (!isset($options['defaultValue'])) {
            if ($type == 'numerical') {
                $options['defaultValue'] = '1';
            } else if ($type == 'alphabetical') {
                $options['defaultValue'] = 'a';
            }
        }
        $pageNumber = new WordFragment();
        $pageNumber->addText($options['defaultValue'], $options);
        if ($type == 'alphabetical') {
            $beguin = '<w:fldSimple w:instr="PAGE \* alphabetic \* MERGEFORMAT">';
        } else {
            $beguin = '<w:fldSimple w:instr="PAGE \* MERGEFORMAT">';
        }
        $end = '</w:fldSimple>';
        $pageNumber = str_replace('<w:r>', $beguin . '<w:r>', (string) $pageNumber);
        $pageNumber = str_replace('</w:r>', '</w:r>' . $end, (string) $pageNumber);
        PhpdocxLogger::logger('Add page number to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $pageNumber;
        } else {
            $this->_wordDocumentC .= (string) $pageNumber;
        }
    }

    /**
     * Add properties to document
     *
     * @access public
     * @param array $values Parameters to use
     *  Values: 'title', 'subject', 'creator', 'keywords', 'description',
     *  'category', 'contentStatus', 'Manager','Company', 'custom' ('name' => array('type' => 'value'))
     */
    public function addProperties($values)
    {
        $this->_modifiedDocxProperties = true;
        self::$propsCore = $this->getFromZip('docProps/core.xml', 'DOMDocument');
        self::$propsApp = $this->getFromZip('docProps/app.xml', 'DOMDocument');
        self::$propsCustom = $this->getFromZip('docProps/custom.xml', 'DOMDocument');
        if (self::$propsCustom === false) {
            self::$generateCustomRels = true;
            self::$propsCustom = new \DOMDocument();
            self::$propsCustom->loadXML(OOXMLResources::$customProperties);
            // write the new Override node associated to the new custon.xml file en [Content_Types].xml
            $this->generateOVERRIDE(
                    '/docProps/custom.xml', 'application/vnd.openxmlformats-officedocument.' .
                    'custom-properties+xml'
            );
        }
        self::$relsRels = $this->getFromZip('_rels/.rels', 'DOMDocument');


        $prop = CreateProperties::getInstance();
        if (!empty($values['title']) || !empty($values['subject']) || !empty($values['creator']) || !empty($values['keywords']) || !empty($values['description']) || !empty($values['category']) || !empty($values['contentStatus'])) {
            self::$propsCore = $prop->createProperties($values, self::$propsCore);
        }
        if (isset($values['contentStatus']) && $values['contentStatus'] == 'Final') {
            self::$propsCustom = $prop->createPropertiesCustom(array('_MarkAsFinal' => array('boolean' => 'true')), self::$propsCustom);
        }
        if (!empty($values['Manager']) || !empty($values['Company'])) {
            self::$propsApp = $prop->createPropertiesApp($values, self::$propsApp);
        }
        if (!empty($values['custom']) && is_array($values['custom'])) {
            self::$propsCustom = $prop->createPropertiesCustom($values['custom'], self::$propsCustom);
            // write the new Override node associated to the new custon.xml file en [Content_Types].xml
            $this->generateOVERRIDE(
                    '/docProps/custom.xml', 'application/vnd.openxmlformats-officedocument.' .
                    'custom-properties+xml'
            );
        }
        if (self::$generateCustomRels) {
            $this->generateCUSTOMRELS();
        }
        PhpdocxLogger::logger('Adding properties to word document.', 'info');
    }
    
    /**
     * Adds a section
     *
     * @access public
     * @param string sectionType (string): nextPage, nextColumn, continuous, evenPage, oddPage
     * @param array paperType (string): A4, A3, letter, legal, A4-landscape, A3-landscape, letter-landscape, legal-landscape, custom
     * @param array options
     * Values:
     * width (int): measurement in twips (twentieths of a point)
     * height (int): measurement in twips (twentieths of a point)
     * numberCols (int): number of columns
     * orient (string): portrait, landscape
     * marginTop (int): measurement in twips (twentieths of a point)
     * marginRight (int): measurement in twips (twentieths of a point)
     * marginBottom (int): measurement in twips (twentieths of a point)
     * marginLeft (int): measurement in twips (twentieths of a point)
     * marginHeader (int): measurement in twips (twentieths of a point)
     * marginFooter (int): measurement in twips (twentieths of a point)
     * gutter (int): measurement in twips (twentieths of a point)
     * bidi (bool)
     * rtl (bool)
     */
    public function addSection($sectionType = 'nextPage', $paperType = '', $options = array())
    {
        $options = self::translateTextOptions2StandardFormat($options);
        $options = self::setRTLOptions($options);
        if (empty($paperType)) {
            $paperType = $this->_phpdocxconfig['settings']['paper_size'];
        }
        $previousSectionPr = '<w:p><w:pPr>' . $this->_sectPr->saveXML() . '</w:pPr></w:p>';
        $previousSectionPr = str_replace('<?xml version="1.0"?>', '', $previousSectionPr);
        $this->_wordDocumentC .= (string) $previousSectionPr;
        $options['onlyLastSection'] = true;
        $this->modifyPageLayout($paperType, $options);
        $nodeSz = $this->_sectPr->getElementsByTagName('pgSz')->item(0);
        $typeNode = $this->_sectPr->createDocumentFragment();
        $typeNode->appendXML('<w:type xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val="' . $sectionType . '" />');
        $nodeSz->parentNode->insertBefore($typeNode, $nodeSz);
    }
    
    /**
     * Add a shape
     *
     * @access public
     * @param string $type Type of shape to draw
     *  Values:arc, curve, line, polyline, rect, roundrect, shape, oval
     * @param array $options
     * General options:
     * 'width' in points
     * 'height' in points
     * 'position' (absolute, relative)
     * 'marginTop' in points
     * 'marginLeft' in points
     * 'z-index' integer
     * 'strokecolor' (#ff0000, #00ffff, ...)
     * 'strokeweight' (1.0pt, 3.5pt, ...)
     * 'fillcolor' (#ff0000, #00ffff, ...)
     * Options for especific type:
     * arc: 'startAngle' (0, 45, 90, ...), 'endAngle' (0, 45, 90, ...)
     * line and curve: 'from' and 'to' (initial and final points in x,y format)
     * curve: 'control1' (x,y), 'control2' (x,y)
     * polyline: 'points' (x1,y1 x2,y2 ....)
     * roundrect: 'arcsize' (0.5, 1.8, ...)
     * shape: 'path' (VML path), 'coordsize' (x,y)
     */
    public function addShape($type, $options = array())
    {
        if (!empty($options['marginTop'])) {
            $options['margin-top'] = $options['marginTop'];
        }
        if (!empty($options['marginLeft'])) {
            $options['margin-left'] = $options['marginLeft'];
        }
        $class = get_class($this);
        $shape = new CreateShape();
        $shapeData = $shape->createShape($type, $options);
        PhpdocxLogger::logger('Add a ' . $type . 'to the Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= '<w:p><w:r>' . $shapeData . '</w:r></w:p>';
        } else {
            $paragraphShape = '<w:p><w:r>' . $shapeData . '</w:r></w:p>';
            $this->_wordDocumentC .= $paragraphShape;
        }
    }

    /**
     * Adds a simple field to the Word document
     * WARNING: if the page number is not added to a header or footer the user may
     * need to press F9 in the MS Word interface to update its value to the current page
     *
     * @access public
     * @param $fieldName the field value. Available fields are:
     * AUTHOR, COMMENTS, DOCPROPERTY, FILENAME, FILESIZE, KEYWORDS,
     * LASTSAVEDBY, NUMCHARS, NUMPAGES, NUMWORDS, SUBJECT, TEMPLATE, TITLE
     * @param string $type: date, numeric or general.
     * @param string $format
     * @param array $options style options to apply to the field
     * Values:
     * 'bidi' (bool)
     * 'bold' (bool)
     * 'color' (ffffff, ff0000...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize (int)
     * 'indentLeft' (int) distange in twentieths of a point (twips)
     * 'indentRight' (int) distange in twentieths of a point (twips)
     * 'italic' (bool)
     * 'lineSpacing' 120, 240 (standard), 480...,
     * 'pageBreakBefore' (bool)
     * 'textAlign' (both, center, distribute, left, right)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (bool)
     * 'wordWrap' (bool)
     * 'defaultValue' (mixed)
     * 'doNotShadeFormData' (bool)
     * 'updateFields' (bool)
     *
     */
    public function addSimpleField($fieldName, $type = 'general', $format = '', $options = array())
    {
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        $availableTypes = array('date' => '\@', 'numeric' => '\#', 'general' => '\*');
        $fieldOptions = array();
        if (isset($options['doNotShadeFormData']) && $options['doNotShadeFormData']) {
            $fieldOptions['doNotShadeFormData'] = true;
        }
        if (isset($options['updateFields']) && $options['updateFields']) {
            $fieldOptions['updateFields'] = true;
        }
        if (count($fieldOptions) > 0) {
            $this->docxSettings($fieldOptions);
        }
        $simpleField = new WordFragment();
        $simpleField->addText($fieldName, $options);

        $data = $fieldName . ' ';
        if (!empty($format)) {
            $data .= $availableTypes[$type] . ' ' . $format . ' ';
        }
        $data .= '\* MERGEFORMAT';
        $beguin = '<w:fldSimple w:instr=" ' . $data . ' ">';

        $end = '</w:fldSimple>';
        $simpleField = str_replace('<w:r>', $beguin . '<w:r>', (string) $simpleField);
        $simpleField = str_replace('</w:r>', '</w:r>' . $end, (string) $simpleField);

        PhpdocxLogger::logger('Adding a simple field to the Word document.', 'info');
        // in order to preserve the run styles insert them within the <w:pPr> tag
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $simpleField;
        } else {
            $this->_wordDocumentC .= (string) $simpleField;
        }
    }

    /**
     * Add a Structured Document Tag
     *
     * @access public
     * @param mixed $type it can be 'comboBox', 'date', 'dropDownList' or 'richText'
     * @param array $options Style options to apply to the text
     *  Values:
     * 'bidi' (bool)
     * 'bold' (bool)
     * 'color' (ffffff, ff0000...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSi`ze (int)
     * 'indentLeft' (int) distange in twentieths of a point (twips)
     * 'indentRight' (int) distange in twentieths of a point (twips)
     * 'italic' (bool)
     * 'lineSpacing' 120, 240 (standard), 480...,
     * 'pageBreakBefore' (bool)
     * 'textAlign' (both, center, distribute, left, right)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (bool)
     * 'wordWrap' (bool)
     * 'placeholderText (string) text to be shown by default
     * 'alias' (string) the label that will be shown by the structured document tag
     * 'lock' (string) locking properties: sdtLocked (cannot be deleted),
     * contentLocked (contents can not be edited directly), unlocked (default value: no locking) and sdtContentLocked (contents can not be directyly edited or the structured tag removed)
     * 'tag' (string) a programmatic tag
     * 'temporary (boolean) if true the structured tag is removed after editing
     * 'listItems' (array) an array of arrays each one of them containing the text to show and value
     */
    public function addStructuredDocumentTag($type, $options = array())
    {
        $options = self::setRTLOptions($options);
        $class = get_class($this);
        $sdtTypes = array('comboBox', 'date', 'dropDownList', 'richText');
        if (!in_array($type, $sdtTypes)) {
            PhpdocxLogger::logger('The chosen Structured Document Tag type is not available', 'fatal');
            exit();
        }
        $sdtBase = CreateText::getInstance();
        $ParagraphOptions = $options;
        $ParagraphOptions['text'] = $options['placeholderText'];
        $sdtBase->createText(array($ParagraphOptions), $ParagraphOptions);
        $sdt = CreateStructuredDocumentTag::getInstance();
        $sdt->createStructuredDocumentTag($type, $options, (string) $sdtBase);
        PhpdocxLogger::logger('Add Structured Document Tag to Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $sdt;
        } else {
            $this->_wordDocumentC .= (string) $sdt;
        }
    }

    /**
     * Add a table.
     *
     * @access public
     * @param array $tableData an array of arrays with the table data organized by rows
     * Each cell content may be a string, WordFragment or array.
     * If the cell contents are in the form of an array its keys and posible values are:
     *      'value' (mixed) a string or WordFragment
     *      'rowspan' (int)
     *      'colspan' (int)
     *      'width' (int) in twentieths of a point
     *      'border' (nil, single, double, dashed, threeDEngrave, threeDEmboss, outset, inset, ...)
     *          this value can be override for each side with 'borderTop', 'borderRight', 'borderBottom' and 'borderLeft'
     *      'borderColor' (ffffff, ff0000)
     *          this value can be override for each side with 'borderTopColor', 'borderRightColor', 'borderBottomColor' and 'borderLeftColor'
     *      'borderSpacing' (0, 1, 2...)
     *          this value can be override for each side with 'borderTopSpacing', 'borderRightSpacing', 'borderBottomSpacing' and 'borderLeftSpacing'
     *      'borderWidth' (10, 11...) in eights of a point
     *          this value can be override for each side with 'borderTopWidth', 'borderRightWidth', 'borderBottomWidth' and 'borderLeftWidth'
     *      'background_color' (ffffff, ff0000)
     *      'noWrap' (boolean)
     *      'cellMargin' (mixed) an integer value or an array:
     *          'top' (int) in twentieths of a point
     *          'right' (int) in twentieths of a point
     *          'bottom' (int) in twentieths of a point
     *          'left' (int) in twentieths of a point
     *      'textDirection' (string) available values are: tbRl and btLr
     *      'fitText' (boolean) if true fits the text to the size of the cell
     *      'vAlign' (string) vertical align of text: top, center, both or bottom
     *
     * @param array $tableProperties Parameters to use
     *  Values:
     *  'bidi' (boolean) set to true for right to left languages
     *  'border' (nil, single, double, dashed, threeDEngrave, threeDEmboss, outset, inset, ...)
     *  'borderColor' (ffffff, ff0000)
     *  'borderSpacing' (0, 1, 2...)
     *  'borderWidth' (10, 11...) in eights of a point
     *  'borderSettings' (all, outside, inside) if all (default value) the border styles apply to all table borders.
     *  If the value is set to outside or inside the border styles will only apply to the outside or inside boreders respectively.
     *  'cantSplitRows' (boolean) set global row split properties (can be overriden by rowProperties)
     *  'cellMargin' (array) the keys are top, right, bottom and left and the values is given in twips (twentieths of a point)
     *  'cellSpacing' (int) given in twips (twentieths of a point)
     *  'columnWidths': column width fix (int)
     *              column width variable (array)
     *  'conditionalFormating' (array) with the following keys and values:
     *      'firstRow' (boolean) first table row conditional formatting
     *      'lastRow' (boolean) last table row conditional formatting
     *      'firstCol' (boolean) first table column conditional formatting
     *      'lastCol' (boolean) last table column conditional formatting
     *      'noHBand' (boolean) do not apply row banding conditional formatting
     *      'noVBand' (boolean) do not apply column banding conditional formatting
     *  The default values are: firstRow (true), firstCol(true), noVBand (true) and all other false
     *  'float' (array) with the following keys and values:
     *      'textMarginTop' (int) in twentieths of a point
     *      'textMarginRight' (int) in twentieths of a point
     *      'textMarginBottom' (int) in twentieths of a point
     *      'textMarginLeft' (int) in twentieths of a point
     *      'align' (string) posible values are: left, center, right, outside, inside
     *  'font' (Arial, Times New Roman...)
     *  'indent' (int) given in twips (twentieths of a point)
     *  'tableAlign' (center, left, right)
     *  'tableLayout' (fixed, autofit) set to 'fixed' only if you do not want Word to handle the best possible width fit
     *  'tableStyle' (string) Word table style
     *  'tableWidth' (array) its posible keys and values are:
     *      'type' (pct, dxa) pct if the value refers to percentage and dxa if the value is given in twentieths of a point (twips)
     *      'value' (int)
     *  'textProperties' (array) it may include any of the paragraph properties of the addText method
     *
     * @param array $rowProperties (array) a cero based array. Each entry is an array with keys and values:
     *      'cantSplit' (boolean)
     *      'minHeight' (int) in twentieths of a point
     *      'height' (int) in twentieths of a point
     *      'tableHeader' (boolean) if true this row repeats at the beguinning of each new page
     */
    public function addTable($tableData, $tableProperties = array(), $rowProperties = array())
    {
        $tableProperties = CreateDocx::translateTableOptions2StandardFormat($tableProperties);
        $tableProperties = self::setRTLOptions($tableProperties);
        $class = get_class($this);
        $table = CreateTable::getInstance();
        $table->createTable($tableData, $tableProperties, $rowProperties);
        PhpdocxLogger::logger('Add table to Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $table;
        } else {
            $this->_wordDocumentC .= (string) $table;
        }
    }

    /**
     * Add a table of contents (TOC)
     *
     * @access public
     * @param array $options
     *  Values:
     * 'autoUpdate' (boolean) if true it will try to update the TOC when first opened
     * 'displayLevels' (string) must be of the form '1-3' where the first number is
     * the start level an the second the end level. If not defined all existing levels are shown
     * @param (array) $legend
     * Values:
     * 'pStyle' (string) Word style to be used. Run parseStyles() to check all available paragraph styles
     * 'bidi' (bool)
     * 'bold' (bool)
     * 'color' (ffffff, ff0000...)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize (int)
     * 'indentLeft' (int) distange in twentieths of a point (twips)
     * 'indentRight' (int) distange in twentieths of a point (twips)
     * 'italic' (bool)
     * 'lineSpacing' 120, 240 (standard), 480...,
     * 'pageBreakBefore' (bool)
     * 'textAlign' (both, center, distribute, left, right)
     * 'underline' (dash, dotted, double, single, wave, words)
     * 'widowControl' (bool)
     * 'wordWrap' (bool)
     * @param (string) $stylesTOC path to the docx with the required styles for the Table of Contents
     */
    public function addTableContents($options = array(), $legend = array(), $stylesTOC = '')
    {
        $legend = self::translateTextOptions2StandardFormat($legend);
        $legend = self::setRTLOptions($legend);
        if (!empty($stylesTOC)) {
            $this->importStyles($stylesTOC, 'merge', array('TDC1', 'TDC2', 'TDC3', 'TDC4', 'TDC5', 'TDC6', 'TDC7', 'TDC8', 'TDC9'), 'styleID');
        }
        if (empty($legend['text'])) {
            $legend['text'] = 'Click here to update the Table of Contents';
        }
        $legendOptions = $legend;
        unset($legendOptions['text']);
        $legendData = new WordFragment();
        $legendData->addText(array($legend), $legendOptions);
        $tableContents = CreateTableContents::getInstance();
        $tableContents->createTableContents($options, $legendData);
        if ($options['autoUpdate']) {
            $this->generateSetting('w:updateFields');
        }
        PhpdocxLogger::logger('Add table of contents to word document.', 'info');
        $this->_wordDocumentC .= (string) $tableContents;
    }

    /**
     * Adds a text paragraph
     *
     * @access public
     * @param mixed $textParams if a string just the text to be included, if an
     * array is or an array of arrays with each element containing
     * the text to be inserted and their formatting properties or a an instance of WordFragment
     * Array values:
     * 'text' (string) the run of text to be inserted
     * 'bold' (boolean)
     * 'caps' (boolean) display text in capital letters
     * 'color' (ffffff, ff0000, ...)
     * 'columnBreak' (before, after, both) inserts a column break before, after or both, a run of text
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (8, 9, 10, ...) size in points
     * 'highlightColor' (string) available highlighting colors are: black, blue, cyan, green, magenta, red, yellow, white, darkBlue, darkCyan, darkGreen, darkMagenta, darkRed,	darkYellow, darkGray, lightGray, none.
     * 'italic' (boolean)
     * 'lineBreak' (before, after, both) inserts a line break before, after or both, a run of text
     * 'rtl' (boolean) if true sets right to left text orientation
     * 'smallCaps' (boolean)displays text in small capital letters
     * 'tab' (boolean) inserts a tab. Default value is false
     * 'spaces': number of spaces at the beguinning of the run of text
     * 'underline' (none, dash, dotted, double, single, wave, words)
     * @param array $paragraphParams Style options to apply to the whole paragraph
     *  Values:
     * 'pStyle' (string) Word style to be used. Run parseStyles() to check all available paragraph styles
     * 'backgroundColor' (string) hexadecimal value (FFFF00, CCCCCC, ...)
     * 'bidi' (boolean) if true sets right to left paragraph orientation
     * 'bold' (boolean)
     * 'border' (none, single, double, dashed, threeDEngrave, threeDEmboss, outset, inset, ...)
     *      this value can be override for each side with 'borderTop', 'borderRight', 'borderBottom' and 'borderLeft'
     * 'borderColor' (ffffff, ff0000)
     *      this value can be override for each side with 'borderTopColor', 'borderRightColor', 'borderBottomColor' and 'borderLeftColor'
     * 'borderSpacing' (0, 1, 2...)
     *      this value can be override for each side with 'borderTopSpacing', 'borderRightSpacing', 'borderBottomSpacing' and 'borderLeftSpacing'
     * 'borderWidth' (10, 11...) in eights of a point
     *      this value can be override for each side with 'borderTopWidth', 'borderRightWidth', 'borderBottomWidth' and 'borderLeftWidth'
     *      
     * 'caps' (boolean) display text in capital letters
     * 'color' (ffffff, ff0000...)
     * 'contextualSpacing' (on, off) ignore spacing above and below when using identical styles
     * 'firstLineIndent' 1first line indent in twentieths of a point (twips)
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (8, 9, 10, ...) size in points
     * 'hanging' 100, 200, ...
     * 'headingLevel' (int) the heading level, if any.
     * 'italic' (on, off)
     * 'indentLeft' 100...,
     * 'indentRight' 100...
     * 'textAlign' (both, center, distribute, left, right)
     * 'keepLines' (boolean) keep all paragraph lines on the same page
     * 'keepNext' (boolean) keep in the same page the current paragraph with next paragraph
     * 'lineSpacing' 120, 240 (standard), 360, 480...  in twentieths of a point (twips)
     * 'pageBreakBefore' (boolean)
     * 'rtl' (boolean) if true sets right to left text orientation
     * 'smallCaps' (boolean)displays text in small capital letters
     * 'spacingBottom' (int) bottom margin in twentieths of a point
     * 'spacingTop' (int) top margin in twentieths of a point
     * 'tabPositions' (array) each entry is an associative array with the following keys and values
     *      'type' (string) can be clear, left (default), center, right, decimal, bar and num
     *      'leader' (string) can be none (default), dot, hyphen, underscore, heavy and middleDot
     *      'position' (int) given in twentieths of a point
     *  if there is a tab and the tabPositions array is not defined the standard tab position (default of 708) will be used
     * 'textDirection' (lrTb, tbRl, btLr, lrTbV, tbRlV, tbLrV) text flow direction
     * 'underline' (none, dash, dotted, double, single, wave, words)
     * 'widowControl' (boolean)
     * 'wordWrap' (boolean)
     */
    public function addText($textParams, $paragraphParams = array())
    {
        $paragraphParams = self::setRTLOptions($paragraphParams);
        $textParams = self::translateTextOptions2StandardFormat($textParams);
        $paragraphParams = self::translateTextOptions2StandardFormat($paragraphParams);
        $class = get_class($this);
        $text = CreateText::getInstance();
        $text->createText($textParams, $paragraphParams);
        PhpdocxLogger::logger('Add text to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $text;
        } else {
            $this->_wordDocumentC .= (string) $text;
        }
    }

    /**
     * Add a textbox
     *
     * @access public
     * @param mixed $content it may be a Word fragment, a plain text string or an array with same parameters used in the addText method
     * The first array entry is the text to be included in the text box, the second one
     * is itself another array with all the standard text formatting options
     * @param array $options includes the specific textbox options
     *  Values:
     * 'border' (bool) default value is true
     * 'borderColor' (string) hexadecimal value (#ff0000, #0000ff, ...)
     * 'borderWidth' (float) value in points
     * 'align' (left, center, right) default value is left
     * 'contentVerticalAlign' (top, center, bottom) default value is top
     * 'fillColor' (string)hexadecimal value (#ff0000, #0000ff, ...)
     * 'width' (float) width in points
     * 'height' (mixed) height in points or 'auto' (default value)
     * 'textWrap' (tight, square, through) default value is square
     * 'paddingBottom' (float) distance in mm (default is 1.3)
     * 'paddingLeft' (float) distance in mm (default is 2.5)
     * 'paddingRight' (float) distance in mm (default is 2.5)
     * 'paddingTop' (float) distance in mm (default is 1.3)
     */
    public function addTextBox($content, $options = array())
    {
        $class = get_class($this);
        $textBox = CreateTextBox::getInstance();
        if ($content instanceof WordFragment) {
            $textBoxContent = (string) $content;
        } else if (is_array($content)) {
            $textBoxParagraph = new WordFragment();
            $textBoxParagraph->addText($content[0], $content[1]);
            $textBoxContent = (string) $textBoxParagraph;
        } else {
            $textBoxParagraph = new WordFragment();
            $textBoxParagraph->addText($content);
            $textBoxContent = (string) $textBoxParagraph;
        }
        $textBox->createTextBox($textBoxContent, $options);
        PhpdocxLogger::logger('Add textbox to word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $textBox;
            $this->textBox = true;
        } else {
            $this->_wordDocumentC .= (string) $textBox;
        }
    }

    /**
     * Add a raw WordML chunk of code
     *
     * @access public
     * @param string $wordML
     */
    public function addWordML($wordML)
    {
        $class = get_class($this);
        PhpdocxLogger::logger('Add raw WordML to the Word document.', 'info');
        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $wordML;
        } else {
            $this->_wordDocumentC .= $wordML;
        }
    }

    /**
     * Appends nodes selected via a DOCXPath query
     *
     * @access public
     * @param mixed $wordFragment the WordML fragment that we wish to insert. 
     * it can be an instance of the WordFragment class or the result of a DOCXPath expression
     */
    public function appendWordFragment($wordFragment)
    {
        if ($wordFragment instanceof WordFragment) {
            PhpdocxLogger::logger('Insertion of a WordFragment into the Word document', 'info');
            $this->_wordDocumentC .= (string) $wordFragment;
        } else if ($wordFragment instanceof DOCXPathresult) {
            PhpdocxLogger::logger('Insertion of a DOCXPath query result into the Word document', 'info');
            $appendXML = '';
            foreach ($wordFragment as $node) {
                $node = Repair::repairDOCXPath($node);
                $appendXML .= $node->ownerDocument->saveXML($node);
            }
            $this->_wordDocumentC .= (string) $appendXML;
        } else if (empty($WordFragment)) {
            PhpdocxLogger::logger('There was no content to insert', 'info');
        } else {
            PhpdocxLogger::logger('You can only insert a WordFragment or the result of a DOCXPath query', 'fatal');
        }
    }

    /**
     * Eliminates all block type elements from a WordML string
     *
     * @access public
     */
    public function cleanWordMLBlockElements($wordML)
    {
        $wordMLChunk = new \DOMDocument();
        $namespaces = 'xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" ';
        $wordML = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><w:root ' . $namespaces . '>' . $wordML;
        $wordML = $wordML . '</w:root>';
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

    /**
     * Generates the new DOCX file
     *
     * @access public
     * @param string $fileName path to the resulting docx
     */
    public function createDocx($fileName = 'document')
    {
        try {
            GenerateDocx::beginDocx();
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }

        PhpdocxLogger::logger('Set DOCX name to: ' . $fileName . '.', 'info');
        //Check if there are openbookmars and if so throw an error
        if (count(CreateDocx::$bookmarksIds) > 0) {
            PhpdocxLogger::logger('There are unclosed bookmarks. Please, check that all open bookmarks tags are properly closed.', 'fatal');
        }

        PhpdocxLogger::logger('Set DOCX name to: ' . $fileName . '.', 'info');

        $this->saveToZip($this->_contentTypeT, '[Content_Types].xml');
        $this->saveToZip($this->_wordRelsDocumentRelsT, 'word/_rels/document.xml.rels');
        $this->saveToZip($this->_wordStylesT, 'word/styles.xml');
        $this->saveToZip($this->_wordSettingsT, 'word/settings.xml');
        $this->saveToZip($this->_wordFootnotesT, 'word/footnotes.xml');
        $this->saveToZip($this->_wordEndnotesT, 'word/endnotes.xml');
        $this->saveToZip($this->_wordCommentsT, 'word/comments.xml');

        if ($this->_modifiedDocxProperties) {
            $this->saveToZip(self::$propsCore, 'docProps/core.xml');
            $this->saveToZip(self::$propsApp, 'docProps/app.xml');
            $this->saveToZip(self::$propsCustom, 'docProps/custom.xml');
            $this->saveToZip(self::$relsRels, '_rels/.rels');
        }

        $this->generateTemplateWordDocument();

        PhpdocxLogger::logger('Add word/document.xml content to DOCX file.', 'info');

        if (self::$_encodeUTF) {
            $contentDocumentXML = utf8_encode($this->_wordDocumentT);
        } else {
            if ($this->_phpdocxconfig['settings']['encode_to_UTF8'] == 'true' && !PhpdocxUtilities::isUtf8($this->_wordDocumentT)) {
                $contentDocumentXML = utf8_encode($this->_wordDocumentT);
            } else {
                $contentDocumentXML = $this->_wordDocumentT;
            }
        }

        // repair document.xml to make sure there is no invalid markup
        $repair = Repair::getInstance();
        $repair->setXML($contentDocumentXML);
        $repair->addParapraphEmptyTablesTags();
        $contentRepair = (string) $repair;
        if (file_exists(dirname(__FILE__) . '/RepairPDF.inc')) {
            if ($this->_compatibilityMode) {
                $contentRepair = RepairPDF::repairPDFConversion($contentRepair, '', array());
            }
        }

        $this->saveToZip($contentRepair, 'word/document.xml');
        $this->saveToZip($this->_wordNumberingT, 'word/numbering.xml');
        //Check if there are rels for footnotes, endnotes and comments
        if (!empty(CreateDocx::$_relsNotesImage['footnote']) ||
                !empty(CreateDocx::$_relsNotesExternalImage['footnote']) ||
                !empty(CreateDocx::$_relsNotesLink['footnote'])) {
            $this->generateRelsNotes('footnote');
            $this->saveToZip($this->_wordFootnotesRelsT, 'word/_rels/footnotes.xml.rels');
        }
        if (!empty(CreateDocx::$_relsNotesImage['endnote']) ||
                !empty(CreateDocx::$_relsNotesExternalImage['endnote']) ||
                !empty(CreateDocx::$_relsNotesLink['endnote'])) {
            $this->generateRelsNotes('endnote');
            $this->saveToZip($this->_wordEndnotesRelsT, 'word/_rels/endnotes.xml.rels');
        }
        if (!empty(CreateDocx::$_relsNotesImage['comment']) ||
                !empty(CreateDocx::$_relsNotesExternalImage['comment']) ||
                !empty(CreateDocx::$_relsNotesLink['comment'])) {
            $this->generateRelsNotes('comment');
            $this->saveToZip($this->_wordCommentsRelsT, 'word/_rels/comments.xml.rels');
        }
        PhpdocxLogger::logger('Close ZIP file', 'info');
        $this->_zipDocx->close();

        PhpdocxLogger::logger('Copy DOCX file using a new name.', 'info');
        copy(
                $this->_tempFile, $fileName . '.' . $this->_extension
        );

        // delete temp file
        if (is_file($this->_tempFile) && is_writable($this->_tempFile)) {
            unlink($this->_tempFile);
        }

        // delete additional tempfles
        foreach (self::$unlinkFiles as $file) {
            unlink($file);
        }
    }

    /**
     * Generate and download a new DOCX file
     *
     * @access public
     * @param string $args[0] File name
     * @param string $args[1] Page style
     *  Values: 'bottom' (4000, 4001...), 'left' (4000, 4001...),
     *  'orient' (landscape), 'right' (4000, 4001), 'titlePage' (1),
     *  'top' (4000, 4001)
     * @param string $args[0] Download file name
     */
    public function createDocxAndDownload()
    {
        $args = func_get_args();

        try {
            if (isset($args[1])) {
                $this->createDocx($args[0], $args[1]);
            } else {
                $this->createDocx($args[0]);
            }
        } catch (Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }

        if (!empty($args[0])) {
            $fileName = $args[0];
            $completeName = explode("/", $args[0]);
            $fileNameDownload = array_pop($completeName);
        } else {
            $fileName = 'document';
            $fileNameDownload = 'document';
        }

        PhpdocxLogger::logger('Download file ' . $fileNameDownload . '.' . $this->_extension . '.', 'info');
        header(
                'Content-Type: application/vnd.openxmlformats-officedocument.' .
                'wordprocessingml.document'
        );
        header(
                'Content-Disposition: attachment; filename="' . $fileNameDownload .
                '.' . $this->_extension . '"'
        );
        header('Content-Transfer-Encoding: binary');
        header('Content-Length: ' . filesize($fileName . '.' . $this->_extension));
        readfile($fileName . '.' . $this->_extension);
    }
    
    /**
     * Create a new style to use in your Word document.
     *
     * @access public
     * @param string $name the name we want to give to the created list
     * @param array $listOptions an array with the different styling options for each level:
     *  'type' can be decimal, lowerLetter, bullet, ....
     *  'font' Symbol, Courier new, Wingdings, ...
     *  'fontSize' in points
     *  'format' the default one is '%1.' for firs level, '%2.' for second level and so long so forth
     *  'hanging' the extra space for the numbering, should be big enough to accomodate it, the default is 360
     *  'left' the left indent. The default value is 720 times the list level
     */
    public function createListStyle($name, $listOptions = array())
    {
        $newStyle = new CreateListStyle();
        $style = $newStyle->addListStyle($name, $listOptions);
        $listId = rand(9999, 999999999);
        $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, $style, $listId);
        self::$customLists[$name]['id'] = $listId;
        self::$customLists[$name]['wordML'] = $style;
    }

    /**
     * Create a new paragraph style and linked char style to be used in your Word document.
     *
     * @access public
     * @param string $name the name we want to give to the created style
     * @param mixed $styleOptions it includes the required style options
     * Array values:
     * 'bold' (on, off)
     * 'border' (none, single, double, dashed, threeDEngrave, threeDEmboss, outset, inset, ...)
     *      this value can be override for each side with 'borderTop', 'borderRight', 'borderBottom' and 'borderLeft'
     * 'borderColor' (ffffff, ff0000)
     *      this value can be override for each side with 'borderTopColor', 'borderRightColor', 'borderBottomColor' and 'borderLeftColor'
     * 'borderSpacing' (0, 1, 2...)
     *      this value can be override for each side with 'borderTopSpacing', 'borderRightSpacing', 'borderBottomSpacing' and 'borderLeftSpacing'
     * 'borderWidth' (10, 11...) in eights of a point
     *      this value can be override for each side with 'borderTopWidth', 'borderRightWidth', 'borderBottomWidth' and 'borderLeftWidth'
     * 'caps' (on, off) display text in capital letters
     * 'color' (ffffff, ff0000...)
     * 'contextualSpacing' (on, off) ignore spacing above and below when using identical styles
     * 'font' (Arial, Times New Roman...)
     * 'fontSize' (8, 9, 10, ...) size in points
     * 'hanging' 100, ....
     * 'italic' (on, off)
     * 'indentLeft' 100...,
     * 'indentRight' 100...
     * 'indent_firstLine' 100, ...
     * 'jc' (both, center, distribute, left, right)
     * 'keepLines' (on, off) keep all paragraph lines on the same page
     * 'keepNext' (on, off) keep in the same page the current paragraph with next paragraph
     * 'lineSpacing' 120, 240 (standard), 360, 480, ...
     * 'outlineLvl' (int) heading level (1-9)
     * 'pageBreakBefore' (on, off)
     * 'pStyle' id of the style this paragraph style is based on (it may be retrieved with the parseStyles method)
     * 'spacingBottom' (int) bottom margin in twentieths of a point
     * 'spacingTop' (int) top margin in twentieths of a point
     * 'smallCaps' (on, off) display text in small caps
     * 'tabPositions' (array) each entry is an associative array with the following keys and values
     *      'type' (string) can be clear, left (default), center, right, decimal, bar and num
     *      'leader' (string) can be none (default), dot, hyphen, underscore, heavy and middleDot
     *      'position' (int) given in twentieths of a point
     * 'textDirection' (lrTb, tbRl, btLr, lrTbV, tbRlV, tbLrV) text flow direction
     * 'u' (none, dash, dotted, double, single, wave, words)
     * 'widowControl' (on, off)
     * 'wordWrap' (on, off)
     */
    public function createParagraphStyle($name, $styleOptions = array())
    {
        $styleOptions = self::translateTextOptions2StandardFormat($styleOptions);
        $newStyle = new CreateParagraphStyle();
        $style = $newStyle->addParagraphStyle($name, $styleOptions);
        //Let's get the original styles
        $styleXML = $this->_wordStylesT->saveXML();
        //append the new styles as a string at the end of the styles file
        $styleXML = str_replace('</w:styles>', $style[0] . '</w:styles>', $styleXML);
        $styleXML = str_replace('</w:styles>', $style[1] . '</w:styles>', $styleXML);
        $this->_wordStylesT->loadXML($styleXML);
    }

    /**
     * Stablish the general docx settings in settings.xml
     *
     * @access public
     * @param array settings
     * Keys and values:
     * 'view' (string): none(default), print, outline, masterPages, normal (draft view), web
     * 'zoom'(mixed): a percentage or none, fullPage (display one full page), bestFit (display page width), textFit (display text width)
     * 'mirrorMargins' (bool) if true interchanges inside and outside margins in odd and even pages
     * 'bordersDoNotSurroundHeader' (bool)
     * 'bordersDoNotSurroundFooter' (bool)
     * 'gutterAtTop' (bool)
     * 'hideSpellingErrors' (bool)
     * 'hideGrammaticalErrors' (bool)
     * 'documentType' (string): notSpecified (default), letter, eMail
     * 'trackRevisions' (bool)
     * 'defaultTabStop'(int) in twips (twentieths of a point)
     * 'autoHyphenation' (bool)
     * 'consecutiveHyphenLimit'(int): maximum number of consecutively hyphenated lines
     * 'hyphenationZone' (int) distance in twips (twentieths of a point)
     * 'doNotHyphenateCaps' (bool): do not hyphenate capital letters
     * 'defaultTableStyle' (string): the table style to be used by default
     * 'bookFoldRevPrinting' (bool): reverse book fold printing
     * 'bookFoldPrinting' (bool): book fold printing
     * 'bookFoldPrintingSheets' (int): number of pages per booklet
     * 'doNotShadeFormData' (bool)
     * 'noPunctuationKerning' (bool): never kern punctuation characters
     * 'printTwoOnOne' (bool): print two pages per sheet
     * 'savePreviewPicture' (bool): generate thumbnail for document on save
     * 'updateFields' (bool): automatically recalculate fields on open
     *
     * @return void
     */
    public function docxSettings($settingParameters)
    {
        $settingParams = array(
            'view',
            'zoom',
            'displayBackgroundShape',
            'mirrorMargins',
            'bordersDoNotSurroundHeader',
            'bordersDoNotSurroundFooter',
            'gutterAtTop',
            'hideSpellingErrors',
            'hideGrammaticalErrors',
            'documentType',
            'trackRevisions',
            'defaultTabStop',
            'autoHyphenation',
            'consecutiveHyphenLimit',
            'hyphenationZone',
            'doNotHyphenateCaps',
            'defaultTableStyle',
            'bookFoldRevPrinting',
            'bookFoldPrinting',
            'bookFoldPrintingSheets',
            'doNotShadeFormData',
            'noPunctuationKerning',
            'printTwoOnOne',
            'savePreviewPicture',
            'updateFields'
        );
        foreach ($settingParameters as $tag => $value) {
            if ((!in_array($tag, $settingParams))) {
                PhpdocxLogger::logger('That setting tag is not supported.', 'info');
            } else {
                $settingIndex = array_search('w:' . $tag, OOXMLResources::$settings);
                $selectedElements = $this->_wordSettingsT->documentElement->getElementsByTagName($tag);
                if ($selectedElements->length == 0) {
                    $settingsElement = $this->_wordSettingsT->createDocumentFragment();
                    if ($tag == 'zoom') {
                        if (is_numeric($value)) {
                            $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:percent = "' . $value . '"/>');
                        } else {
                            $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val = "' . $value . '"/>');
                        }
                    } else {
                        $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val = "' . $value . '"/>');
                    }
                    $childNodes = $this->_wordSettingsT->documentElement->childNodes;
                    $index = false;
                    foreach ($childNodes as $node) {
                        $name = $node->nodeName;
                        $index = array_search($node->nodeName, OOXMLResources::$settings);
                        if ($index > $settingIndex) {
                            $node->parentNode->insertBefore($settingsElement, $node);
                            break;
                        }
                    }
                    //in case no node was found (pretty unlikely)we should append the node
                    if (!$index) {
                        $this->_wordSettingsT->documentElement->appendChild($settingsElement);
                    }
                } else {//that setting is already present
                    if ($tag == 'zoom') {
                        $selectedElements->item(0)->removeAttribute('w:val');
                        $selectedElements->item(0)->removeAttribute('w:percent');
                        if (is_numeric($value)) {
                            $selectedElements->item(0)->setAttribute('w:percent', $value);
                        } else {
                            $selectedElements->item(0)->setAttribute('w:val', $value);
                        }
                    } else {
                        $selectedElements->item(0)->setAttribute('w:val', $value);
                    }
                }
            }
        }
    }

    /**
     *
     * Transform a word document to a text file
     *
     * @param string $path. Path to the docx from which we wish to import the content
     * @param string $path. Path to the text file output
     * @param array styles.
     * keys: table => true/false,list => true/false, paragraph => true/false, footnote => true/false, endnote => true/false, chart => (0=false,1=array,2=table)
     */
    public static function docx2txt($from, $to, $options = array())
    {
        $text = new Docx2Text($options);
        $text->setDocx($from);
        $text->extract($to);
    }

    /**
     * Embed HTML into the Word document by parsing the HTML code and converting it into WordML
     * It preserves many CSS styles
     *
     * @access public
     * @param string $html HTML to add. Must be a valid XHTML
     * @param array $options:
     * isFile (boolean),
     * baseURL (string),
     * customListStyles (bool) if true try to use the predefined custom lists
     * downloadImages (boolean),
     * filter (string) could be an string denoting the id, class or tag to be filtered.
     * If you want only a class introduce .classname, #idName for an id or <htmlTag> for a particular tag. One can also use
     * standard XPath expresions supported by PHP.
     * 'parseAnchors' (boolean),
     * 'parseDivs' (paragraph, table): parses divs as paragraphs or tables,
     * 'parseFloats' (boolean),
     * 'strictWordStyles' (boolean) if true ignores all CSS styles and uses the styles set via the wordStyles option (see next)
     * 'wordStyles' (array) associates a particular class, id or HTML tag to a Word style
     */
    public function embedHTML($html = '<html><body></body></html>', $options = array())
    {
        $class = get_class($this);
        if ($class != 'CreateDocx') {
            $options['target'] = $this->target;
        } else {
            $options['target'] = 'document';
        }
        $htmlDOCX = new HTML2WordML($this->_zipDocx);
        $sFinalDocX = $htmlDOCX->render($html, $options);
        PhpdocxLogger::logger('Add converted HTML to word document.', 'info');

        $this->HTMLRels($sFinalDocX, $options);
        // take care of the ordered lsit if they exist
        if (is_array($sFinalDocX[3])) {
            foreach ($sFinalDocX[3] as $value) {
                $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, OOXMLResources::$orderedListStyle, $value);
            }
        }
        // take care of the custom lists if they exist
        if (is_array($sFinalDocX[4])) {
            foreach ($sFinalDocX[4] as $value) {
                //We have to remove from the name the random indentifier
                $realNameArray = explode('_', $value['name']);
                $value['name'] = $realNameArray[0];
                $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, self::$customLists[$value['name']]['wordML'], $value['id']);
            }
        }

        if ($this instanceof WordFragment) {
            $this->wordML .= (string) $sFinalDocX[0];
        } else {
            $this->_wordDocumentC .= (string) $sFinalDocX[0];
        }
    }

    /**
     * Enable compatibility mode for OpenOffice and MS Office 2003 CP. Avoid using unsupported methods
     *
     * @access public
     */
    public function enableCompatibilityMode()
    {
        PhpdocxLogger::logger('Enable compatibility mode.', 'info');
        $this->_compatibilityMode = true;
    }
    
    /**
     * Creates an empty word numbering base string
     */
    public function generateBaseWordNumbering()
    {
        // copy the numbering.xml file from the standard PHPDocX template into the new base template
        $numZip = new \ZipArchive();
        try {
            $openNumZip = $numZip->open(PHPDOCX_BASE_TEMPLATE);
            if ($openNumZip !== true) {
                throw new \Exception('Error while opening the standard base template to extract the word/numbering.xml file');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        $baseWordNumbering = $numZip->getFromName('word/numbering.xml');

        return $baseWordNumbering;
    }
    
    /**
     * To add support of sys_get_temp_dir for PHP versions under 5.2.1
     *
     * @access private
     * @return string
     */
    public static function getTempDir()
    {
        if (!function_exists('sys_get_temp_dir')) {

            function sys_get_temp_dir()
            {
                if ($temp = getenv('TMP')) {
                    return $temp;
                }
                if ($temp = getenv('TEMP')) {
                    return $temp;
                }
                if ($temp = getenv('TMPDIR')) {
                    return $temp;
                }
                $temp = tempnam(__FILE__, '');
                if (file_exists($temp)) {
                    unlink($temp);
                    return dirname($temp);
                }
                return null;
            }

        } else {
            return sys_get_temp_dir();
        }
    }
    
    /**
     * Inserts new headers and/or footers from a word file.
     *
     * @param string $path. Path to the docx from which we wish to import the header and/or footer
     * @param string $type. Declares if we want to import only the header, only the footer or both.
     * Values: header, footer, headerAndFooter (default value)
     */
    public function importHeadersAndFooters($path, $type = 'headerAndFooter')
    {
        switch ($type) {
            case 'headerAndFooter':
                $this->removeHeadersAndFooters();
                break;
            case 'header':
                $this->removeHeaders();
                break;
            case 'footer':
                $this->removeFooters();
                break;
        }
        // get, parse and extract the relevant files from the docx with the new headers/footers
        try {
            $baseHeadersFooters = new \ZipArchive();
            $openHeadersFooters = $baseHeadersFooters->open($path);
            if ($openHeadersFooters !== true) {
                throw new \Exception('Error while opening the docx to extract the header and/or footer');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }

        // extract the different roles: default, even or first played by the different headers and footers.
        // In order to do that we should first parse the node sectPr from the document.xml file
        $docHeadersFootersContent = $this->getFromZip('word/document.xml', 'DOMDocument', $baseHeadersFooters);

        //We now extract the first sectPr element in the document
        //We are assuming there is only one section
        $docSectPr = $docHeadersFootersContent->getElementsByTagName('sectPr')->item(0);

        $headerTypes = array();
        $footerTypes = array();
        $titlePg = false;
        $extraSections = false;
        foreach ($docSectPr->childNodes as $value) {
            if ($value->nodeName == 'w:headerReference') {
                $headerTypes[$value->getAttribute('r:id')] = $value->getAttribute('w:type');
            } else if ($value->nodeName == 'w:footerReference') {
                $footerTypes[$value->getAttribute('r:id')] = $value->getAttribute('w:type');
            }
        }
        // check if the first and even headers and footers are shown in the original Word document
        $titlePg = false;
        if ($docHeadersFootersContent->getElementsByTagName('titlePg')->length > 0) {
            $titlePg = true;
        }

        $settingsHeadersFootersContent = $this->getFromZip('word/settings.xml', 'DOMDocument', $baseHeadersFooters);

        if ($settingsHeadersFootersContent->getElementsByTagName('evenAndOddHeaders')->length > 0) {
            $this->generateSetting('w:evenAndOddHeaders');
        }

        // parse word/_rels/document.xml.rels
        $wordHeadersFootersRelsT = $this->getFromZip('word/_rels/document.xml.rels', 'DOMDocument', $baseHeadersFooters);
        $relationships = $wordHeadersFootersRelsT->getElementsByTagName('Relationship');

        $counter = $relationships->length - 1;

        for ($j = $counter; $j > -1; $j--) {
            $rId = $relationships->item($j)->getAttribute('Id');
            $completeType = $relationships->item($j)->getAttribute('Type');
            $target = $relationships->item($j)->getAttribute('Target');
            $myType = array_pop(explode('/', $completeType));

            switch ($myType) {
                case 'header':
                    $relsHeader[$rId] = $target;
                    break;
                case 'footer':
                    $relsFooter[$rId] = $target;
                    break;
            }
        }
        // in case there are more sectPr within $this->documentC include the corresponding elements
        $domDocument = $this->getDOMDocx();
        $sections = $domDocument->getElementsByTagName('sectPr');

        // start the looping over the $relsHeader and/or $relsFooter arrays
        if ($type == 'headerAndFooter' || $type == 'header') {
            foreach ($relsHeader as $key => $value) {
                // first check if there is a rels file for each header
                if ($this->getFromZip('word/_rels/' . $value . '.rels', 'DOMDocument', $baseHeadersFooters)) {
                    // parse the corresponding rels file to copy and rename the images included in the header
                    $wordHeadersRelsT = $this->getFromZip('word/_rels/' . $value . '.rels', 'DOMDocument', $baseHeadersFooters);
                    $relations = $wordHeadersRelsT->getElementsByTagName('Relationship');

                    $countrels = $relations->length - 1;

                    for ($j = $countrels; $j > -1; $j--) {
                        $completeType = $relations->item($j)->getAttribute('Type');
                        $target = $relations->item($j)->getAttribute('Target');
                        $myType = array_pop(explode('/', $completeType));

                        switch ($myType) {
                            case 'image':
                                $refExtension = array_pop(explode('.', $target));
                                $refImage = 'media/image' . uniqid(mt_rand(999, 9999)) . '.' . $refExtension;
                                // change the attibute to the new name
                                $relations->item($j)->setAttribute('Target', $refImage);
                                // copy the image in the base template with the new name
                                $image = $this->getFromZip('word/' . $target, 'string', $baseHeadersFooters);
                                $this->saveToZip($image, 'word/' . $refImage);
                                // copy the associated rels file
                                $this->saveToZip($wordHeadersRelsT, 'word/_rels/' . $value . '.rels');
                                // make sure that the corresponding image types are included in [Content_Types].xml
                                $imageTypeFound = false;
                                foreach ($this->_contentTypeT->documentElement->childNodes as $node) {
                                    if ($node->nodeName == 'Default' && $node->getAttribute('Extension') == $refExtension) {
                                        $imageTypeFound = true;
                                    }
                                }
                                if (!$imageTypeFound) {
                                    $newDefaultNode = '<Default Extension="' . $refExtension . '" ContentType="image/' . $refExtension . '" />';
                                    $newDefault = $this->_contentTypeT->createDocumentFragment();
                                    $newDefault->appendXML($newDefaultNode);
                                    $baseDefaultNode = $this->_contentTypeT->documentElement;
                                    $baseDefaultNode->appendChild($newDefault);
                                }
                                break;
                        }
                    }
                }

                // copy the corresponding header xml files
                $file = $this->getFromZip('word/' . $value, 'string', $baseHeadersFooters);
                $this->saveToZip($file, 'word/' . $value);
                // modify the /_rels/document.xml.rels of the base template to include the new element
                $newId = uniqid(mt_rand(999, 9999));
                $newHeaderNode = '<Relationship Id="rId';
                $newHeaderNode .= $newId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header"';
                $newHeaderNode .= ' Target="' . $value . '" />';
                $newNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $newNode->appendXML($newHeaderNode);
                $baseNode = $this->_wordRelsDocumentRelsT->documentElement;
                $baseNode->appendChild($newNode);

                // as well as the section DOMNode
                $newSectNode = '<w:headerReference w:type="' . $headerTypes[$key] . '" r:id="rId' . $newId . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>';
                $sectNode = $this->_sectPr->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $this->_sectPr->documentElement->childNodes->item(0);
                $refNode->parentNode->insertBefore($sectNode, $refNode);
                // and include the corresponding <Override> in [Content_Types].xml
                $newOverrideNode = '<Override PartName="/word/' . $value . '" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml" />';
                $newOverride = $this->_contentTypeT->createDocumentFragment();
                $newOverride->appendXML($newOverrideNode);
                $baseOverrideNode = $this->_contentTypeT->documentElement;
                $baseOverrideNode->appendChild($newOverride);


                foreach ($sections as $section) {
                    $extraSections = true;
                    $refNode = $section->childNodes->item(0);
                    $sectNode = $domDocument->createDocumentFragment();
                    $sectNode->appendXML($newSectNode);
                    $refNode->parentNode->insertBefore($sectNode, $refNode);
                }
            }
        }
        if ($type == 'headerAndFooter' || $type == 'footer') {
            foreach ($relsFooter as $key => $value) {
                // check if there is a rels file for each footer
                if ($this->getFromZip('word/_rels/' . $value . '.rels', 'DOMDocument', $baseHeadersFooters)) {
                    // parse the corresponding rels file to copy and rename the images included in the footer
                    $wordFootersRelsT = $this->getFromZip('word/_rels/' . $value . '.rels', 'DOMDocument', $baseHeadersFooters);
                    $relations = $wordFootersRelsT->getElementsByTagName('Relationship');

                    $countrels = $relations->length - 1;

                    for ($j = $countrels; $j > -1; $j--) {
                        $completeType = $relations->item($j)->getAttribute('Type');
                        $target = $relations->item($j)->getAttribute('Target');
                        $myType = array_pop(explode('/', $completeType));

                        switch ($myType) {
                            case 'image':
                                $refExtension = array_pop(explode('.', $target));
                                $refImage = 'media/image' . uniqid(mt_rand(999, 9999)) . '.' . $refExtension;
                                // change the attibute to the new name
                                $relations->item($j)->setAttribute('Target', $refImage);
                                // copy the image in the base template with the new name
                                $image = $this->getFromZip('word/' . $target, 'string', $baseHeadersFooters);
                                $this->saveToZip($image, 'word/' . $refImage);
                                // copy the associated rels file
                                $this->saveToZip($wordFootersRelsT, 'word/_rels/' . $value . '.rels');
                                // make sure that the corresponding image types are included in [Content_Types].xml
                                $imageTypeFound = false;
                                foreach ($this->_contentTypeT->documentElement->childNodes as $node) {
                                    if ($node->nodeName == 'Default' && $node->getAttribute('Extension') == $refExtension) {
                                        $imageTypeFound = true;
                                    }
                                }
                                if (!$imageTypeFound) {
                                    $newDefaultNode = '<Default Extension="' . $refExtension . '" ContentType="image/' . $refExtension . '" />';
                                    $newDefault = $this->_contentTypeT->createDocumentFragment();
                                    $newDefault->appendXML($newDefaultNode);
                                    $baseDefaultNode = $this->_contentTypeT->documentElement;
                                    $baseDefaultNode->appendChild($newDefault);
                                }
                                break;
                        }
                    }
                }

                // copy the corresponding footer xml files
                $file = $this->getFromZip('word/' . $value, 'string', $baseHeadersFooters);
                $this->saveToZip($file, 'word/' . $value);
                // modify the /_rels/document.xml.rels of the base template to include the new element
                $newId = uniqid(mt_rand(999, 9999));
                $newFooterNode = '<Relationship Id="rId';
                $newFooterNode .= $newId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer"';
                $newFooterNode .= ' Target="' . $value . '" />';
                $newNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $newNode->appendXML($newFooterNode);
                $baseNode = $this->_wordRelsDocumentRelsT->documentElement;
                $baseNode->appendChild($newNode);

                // as well as the section DOMNode
                $newSectNode = '<w:footerReference w:type="' . $footerTypes[$key] . '" r:id="rId' . $newId . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"/>';
                $sectNode = $this->_sectPr->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $this->_sectPr->documentElement->childNodes->item(0);
                $refNode->parentNode->insertBefore($sectNode, $refNode);

                // include the corresponding <Override> in [Content_Types].xml
                $newOverrideNode = '<Override PartName="/word/' . $value . '" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml" />';
                $newOverride = $this->_contentTypeT->createDocumentFragment();
                $newOverride->appendXML($newOverrideNode);
                $baseOverrideNode = $this->_contentTypeT->documentElement;
                $baseOverrideNode->appendChild($newOverride);

                foreach ($sections as $section) {
                    $extraSections = true;
                    $refNode = $section->childNodes->item(0);
                    $sectNode = $domDocument->createDocumentFragment();
                    $sectNode->appendXML($newSectNode);
                    $refNode->parentNode->insertBefore($sectNode, $refNode);
                }
            }
        }
        $stringDoc = $domDocument->saveXML();
        $bodyTag = explode('<w:body>', $stringDoc);
        $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);

        if ($titlePg) {
            $this->generateTitlePg($extraSections);
        }
    }

    /**
     * Imports an existing list style  from an existing docx document.
     *
     * @access public
     * @param string $path. Must be a valid path to an existing .docx, .dotx o .docm document
     * @param int $id. The id of the style you want to import. You may obtain the id with the help of the parseStyle method
     */
    public function importListStyle($path, $id, $name)
    {
        $listStyles = new \ZipArchive();
        try {
            $openStyle = $zipStyles->open($path);
            if ($openStyle !== true) {
                throw new \Exception('Error while opening the Style Template: please, check the path');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        $externalNumbering = $this->getFromZip('word/numbering.xml', 'DOMDocument', $listStyles);
        $numXPath = new \DOMXPath($externalNumbering);
        $numXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:num[@w:numId = "' . $id . '"]';
        $numbering = $numXPath->query($query);
        if ($numbering->length > 0) {
            $abstractNumId = $numbering->item(0)->getElementsByTagName('abstractNumId')->item(0)->getAttribute('w:val');
        } else {
            PhpdocxLogger::logger('The requested list style could not be found.', 'fatal');
        }
        $query2 = '//w:abstractNum[@w:abstractNumId = "' . $abstractNumId . '"]';
        $listStyleNode = $numXPath->query($query2)->item(0);
        $listStyleXML = $listStyleNode->ownerDocument->saveXML($listStyleNode);
        $listId = rand(9999, 999999999);
        $this->_wordNumberingT = $this->importSingleNumbering($this->_wordNumberingT, $listStyleXML, $listId);
        self::$customLists[$name]['id'] = $listId;
        self::$customLists[$name]['wordML'] = $listStyleXML;
    }
    
    /**
     *
     * Inserts a new numbering style.
     *
     * @param string $numberingsXML the numberings.xml that we wish to modify
     * @param string $newNumbering the new numbering style we wish to add.
     * @param string $numberId a unique integer tha determines the numbering id
     * and the abstract numbering id
     */
    public function importSingleNumbering($numberingsXML, $newNumbering, $numberId, $originalAbstractNumId = '')
    {
        // insert the $newNumbering into $numberingsXML
        $myNumbering = new \DOMDocument();
        $myNumbering->loadXML($numberingsXML);

        // check if there's content in the numbering. Add a base it there's no child
        if ($myNumbering->documentElement->firstChild === null) {
            $this->_wordNumberingT = $this->generateBaseWordNumbering();

            $myNumbering->loadXML($this->_wordNumberingT);
        }

        // modify the w:abstractNumId atribute
        $newNumbering = str_replace('<w:abstractNum w:abstractNumId="' . $originalAbstractNumId . '"', '<w:abstractNum w:abstractNumId="' . $numberId . '"', $newNumbering);
        $newNumbering = str_replace('w:tplc=""', 'w:tplc="' . rand(10000000, 99999999) . '"', $newNumbering);
        $new = $myNumbering->createDocumentFragment();
        $new->appendXML($newNumbering);
        $base = $myNumbering->documentElement->firstChild;
        $base->parentNode->insertBefore($new, $base);
        $numberingsXML = $myNumbering->saveXML();

        // include the relationshiop
        $newNum = '<w:num w:numId="' . $numberId . '"><w:abstractNumId w:val="' . $numberId . '" /></w:num>';
        // check if there is a w:numIdMacAtCleanup element
        if (strpos($numberingsXML, 'w:numIdMacAtCleanup') !== false) {
            $numberingsXML = str_replace('<w:numIdMacAtCleanup', $newNum . '<w:numIdMacAtCleanup', $numberingsXML);
        } else {
            $numberingsXML = str_replace('</w:numbering>', $newNum . '</w:numbering>', $numberingsXML);
        }

        return $numberingsXML;
    }

    /**
     * Imports an existing style sheet from an existing docx document.
     *
     * @access public
     * @param string $path. Must be a valid path to an existing .docx, .dotx o .docm document
     * @param string $type. You may choose 'replace' (overwrites the current styles) or 'merge' (adds the selected styles)
     * @param array $myStyles. A list of specific styles to be merged. If it is empty or the choosen type is 'replace' it will be ignored.
     * @param string $styleIdentifier can be styleName or styleID
     */
    public function importStyles($path, $type = 'replace', $myStyles = array(), $styleIdentifier = 'styleName')
    {

        $zipStyles = new \ZipArchive();
        try {
            $openStyle = $zipStyles->open($path);
            if ($openStyle !== true) {
                throw new \Exception('Error while opening the Style Template: please, check the path');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        if ($type == 'replace') {
            // overwrite the original styles file
            $extractingStyleFile = $this->getFromZip('word/styles.xml');
            // in order not to loose certain styles needed for certain PHPDOCX methods, merge them
            $this->importStyles(PHPDOCX_BASE_TEMPLATE, 'PHPDOCXStyles');
        } else {
            if ($type == 'PHPDOCXStyles') {
                $newStyles = OOXMLResources::$PHPDOCXStyles;
            } else {
                // first extract the new styles from the external docx
                try {
                    $newStyles = $zipStyles->getFromName('word/styles.xml');
                    if ($newStyles == '') {
                        throw new \Exception('Error while extracting the styles from the external docx');
                    }
                } catch (\Exception $e) {
                    PhpdocxLogger::logger($e->getMessage(), 'fatal');
                }
            }

            // parse the different styles via XPath
            $newStylesDoc = new \DOMDocument();
            $newStylesDoc->loadXML($newStyles);
            $stylesXpath = new \DOMXPath($newStylesDoc);
            $stylesXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $queryStyle = '//w:style';
            $styleNodes = $stylesXpath->query($queryStyle);

            //search for linked styles and basedOn styles
            if ($type == 'merge' && count($myStyles) > 0) {
                foreach ($myStyles as $singleStyle) {
                    if ($styleIdentifier == 'styleID') {
                        $query = '//w:style[@w:styleId="' . $singleStyle . '"]/w:basedOn | //w:style[@w:styleId="' . $singleStyle . '"]/w:link';
                        $linkedNodes = $stylesXpath->query($query);
                        foreach ($linkedNodes as $linked) {
                            $myStyles[] = $linked->getAttribute('w:val');
                        }
                    } else if ($styleIdentifier == 'styleName') {
                        $query = '//w:style[w:name[@w:val="' . $singleStyle . '"]]/w:basedOn | //w:style[w:name[@w:val="' . $singleStyle . '"]]/w:link';
                        $linkedNodes = $stylesXpath->query($query);
                        foreach ($linkedNodes as $linked) {
                            $linkedID = $linked->getAttribute('w:val');
                            $query = '//w:style[@w:styleId="' . $linkedID . '"]/w:name';
                            $nodeNames = $stylesXpath->query($query);
                            if ($nodeNames->length > 0) {
                                $myStyles[] = $nodeNames->item(0)->getAttribute('w:val');
                            }
                        }
                    }
                }
            }
            // get the original styles as a DOMDocument
            $baseNode = $this->_wordStylesT->documentElement;
            $stylesDocumentXPath = new \DOMXPath($this->_wordStylesT);
            $stylesDocumentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $query = '//w:style';
            $originalNodes = $stylesDocumentXPath->query($query);

            // insert the new styles at the end of the styles.xml
            foreach ($styleNodes as $node) {
                // in order to avoid duplicated Ids we first remove from the
                // original styles.xml any duplicity with the new ones
                // TODO: check performance
                foreach ($originalNodes as $oldNode) {
                    if ($styleIdentifier == 'styleID') {
                        if ($oldNode->getAttribute('w:styleId') == $node->getAttribute('w:styleId') && in_array($oldNode->getAttribute('w:styleId'), $myStyles)) {
                            $oldNode->parentNode->removeChild($oldNode);
                        }
                    } else {
                        $oldName = $oldNode->getElementsByTagName('name');
                        foreach ($oldName as $myNode) {
                            $myName = $myNode->getAttribute('w:val');
                            if ($oldNode->getAttribute('w:styleId') == $node->getAttribute('w:styleId') && in_array($myName, $myStyles)) {
                                $oldNode->parentNode->removeChild($oldNode);
                            }
                        }
                    }
                }
                if (count($myStyles) > 0) {
                    // insert the selected styles
                    if ($styleIdentifier == 'styleID') {
                        if (in_array($node->getAttribute('w:styleId'), $myStyles)) {
                            $insertNode = $this->_wordStylesT->importNode($node, true);
                            $baseNode->appendChild($insertNode);
                        }
                    } else {
                        $nodeChilds = $node->childNodes;
                        foreach ($nodeChilds as $child) {
                            if ($child->nodeName == 'w:name') {
                                $styleName = $child->getAttribute('w:val');
                                if (in_array($styleName, $myStyles)) {
                                    $insertNode = $this->_wordStylesT->importNode($node, true);
                                    $baseNode->appendChild($insertNode);
                                }
                            }
                        }
                    }
                } else {
                    $insertNode = $this->_wordStylesT->importNode($node, true);
                    $baseNode->appendChild($insertNode);
                }
            }
        }
        PhpdocxLogger::logger('Importing styles from an external docx.', 'info');
    }

    /**
     * Inserts a Word fragment before a certain node.
     *
     * @access public
     * @param mixed $wordFragment the WordML fragment that we wish to insert. 
     * it can be an instance of the WordFragment class or the result of a DOCXPath expression
     * @param DOMDocument $domDocument
     * @param string $source possible values are WordFragment or DocxPath
     * @param DOMNode $refNode
     * @return void
     */
    private function insertWordContent($wordFragment, $domDocument, $source, $refNode)
    {
        if ($source == 'WordFragment') {
            $cursor = $domDocument->createElement('cursor', 'WordFragment');
            $refNode->parentNode->insertBefore($cursor, $refNode);
            $stringDoc = $domDocument->saveXML();
            $bodyTag = explode('<w:body>', $stringDoc);
            $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);
            $this->_wordDocumentC = str_replace('<cursor>WordFragment</cursor>', (string) $wordFragment, $this->_wordDocumentC);
        } else if ($source == 'DocxPath') {
            foreach ($wordFragment as $node) {
                $node = Repair::repairDOCXPath($node);
                $insert = $domDocument->importNode($node, true);
                $refNode->parentNode->insertBefore($insert, $refNode);
            }

            $stringDoc = $domDocument->saveXML();
            $bodyTag = explode('<w:body>', $stringDoc);
            $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);
        }
    }

    /**
     * Inserts a Word fragment after a certain node.
     *
     * @access public
     * @param mixed $wordFragment the WordML fragment that we wish to insert. 
     * it can be an instance of the WordFragment class or the result of a DOCXPath expression
     * @param array $referenceNode
     * Keys and values:
     * 'type' (string) can be * (all, default value), paragraph, table
     * 'section' (int) 
     * 'contains' (string) 
     * 'position' (int) (include first and last sintax?)
     * 'ocurrence' (int)
     * @return void
     */
    public function insertWordFragmentAfter($wordFragment, $referenceNode)
    {
        if ($wordFragment instanceof WordFragment) {
            PhpdocxLogger::logger('Insertion of a WordML fragment into the Word document', 'info');
            $source = 'WordFragment';
        } else if ($wordFragment instanceof DOCXPathResult) {
            PhpdocxLogger::logger('Insertion of a DOCXPath result into the Word document', 'info');
            $source = 'DocxPath';
        } else {
            PhpdocxLogger::logger('You are trying to insert a non-valid object', 'fatal');
        }
        // choose the reference node based on content
        if (isset($referenceNode['type'])) {
            $type = $referenceNode['type'];
        } else {
            $type = '*';
        }
        $domDocument = $this->getDOMDocx();
        $domXpath = new \DOMXPath($domDocument);
        $domXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        $query = DOCXPath::xpathContentQuery($type, $referenceNode);

        $contentNodes = $domXpath->query($query);

        if ($contentNodes->length > 0) {
            $referenceNode = $contentNodes->item(0)->nextSibling;
            if (!($referenceNode instanceof \DOMNode) || $referenceNode->nodeName == 'w:sectPr') {
                $this->appendWordFragment($wordFragment);
                return;
            }
        } else {
            PhpdocxLogger::logger('The reference node could not be found. The selection will be appended', 'info');
            $this->appendWordFragment($wordFragment);
            return;
        }
        $this->insertWordContent($wordFragment, $domDocument, $source, $referenceNode);
    }

    /**
     * Inserts a Word fragment before a certain node.
     *
     * @access public
     * @param mixed $wordFragment the WordML fragment that we wish to insert. 
     * it can be an instance of the WordFragment class or the result of a DOCXPath expression
     * @param array $referenceNode
     * Keys and values:
     * 'type' (string) can be * (all, default value), paragraph, table
     * 'section' (int) 
     * 'contains' (string) 
     * 'position' (int) (include first and last sintax?)
     * 'ocurrence' (int)
     * @return void
     */
    public function insertWordFragmentBefore($wordFragment, $referenceNode)
    {
        if ($wordFragment instanceof WordFragment) {
            PhpdocxLogger::logger('Insertion of a WordML fragment into the Word document', 'info');
            $source = 'WordFragment';
        } else if ($wordFragment instanceof DOCXPathResult) {
            PhpdocxLogger::logger('Insertion of a DOCXPath result into the Word document', 'info');
            $source = 'DocxPath';
        } else {
            PhpdocxLogger::logger('You are trying to insert a non-valid object', 'fatal');
        }
        // choose the reference node based on content
        if (isset($referenceNode['type'])) {
            $type = $referenceNode['type'];
        } else {
            $type = '*';
        }
        $domDocument = $this->getDOMDocx();
        $domXpath = new \DOMXPath($domDocument);
        $domXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        $query = DOCXPath::xpathContentQuery($type, $referenceNode);

        $contentNodes = $domXpath->query($query);

        if ($contentNodes->length > 0) {
            $referenceNode = $contentNodes->item(0);
        } else {
            PhpdocxLogger::logger('The reference node could not be found. The selection will be appended', 'info');
            $this->appendWordFragment($wordFragment);
            return;
        }
        $this->insertWordContent($wordFragment, $domDocument, $source, $referenceNode);
    }
    
    /**
     * Modify page layout
     *
     * @access public
     * @param array paperType (string): A4, A3, letter, legal, A4-landscape, A3-landscape, letter-landscape, legal-landscape, custom
     * @param array options
     * Values:
     * width (int): measuremt in twips (twentieths of a point)
     * height (int): measuremt in twips (twentieths of a point)
     * numberCols (int): integer
     * orient (string): portrait, landscape
     * marginTop (int): measuremt in twips (twentieths of a point)
     * marginRight (int): measuremt in twips (twentieths of a point)
     * marginBottom (int): measuremt in twips (twentieths of a point)
     * marginLeft (int): measuremt in twips (twentieths of a point)
     * marginHeader (int): measuremt in twips (twentieths of a point)
     * marginFooter (int): measuremt in twips (twentieths of a point)
     * gutter (int): measurement in twips (twentieths of a point)
     * bidi (bool): set to true for right to left languages
     * rtlGutter (bool): set to true for right to left languages
     * onlyLastSection (boolean): if true it only modifies the last section (default value is false)
     * sectionNumbers (array): an array with the sections that we want to modify
     */
    public function modifyPageLayout($paperType = 'letter', $options = array())
    {
        $options = $options = self::setRTLOptions($options);
        if (empty($options['onlyLastSection'])) {
            $options['onlyLastSection'] = false;
        }
        $paperTypes = array('A4',
            'A3',
            'letter',
            'legal',
            'A4-landscape',
            'A3-landscape',
            'letter-landscape',
            'legal-landscape',
            'custom');

        $layoutOptions = array('width',
            'height',
            'numberCols',
            'orient',
            'code',
            'marginTop',
            'marginRight',
            'marginBottom',
            'marginLeft',
            'marginHeader',
            'marginFooter',
            'gutter',
            'bidi',
            'rtlGutter');
        $referenceSizes = array(
            'A4' => array(
                'width' => '11906',
                'height' => '16838',
                'numberCols' => '1',
                'orient' => 'portrait',
                'code' => '9',
                'marginTop' => '1417',
                'marginRight' => '1701',
                'marginBottom' => '1417',
                'marginLeft' => '1701',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'A4-landscape' => array(
                'width' => '16838',
                'height' => '11906',
                'numberCols' => '1',
                'orient' => 'landscape',
                'code' => '9',
                'marginTop' => '1701',
                'marginRight' => '1417',
                'marginBottom' => '1701',
                'marginLeft' => '1417',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'A3' => array(
                'width' => '16839',
                'height' => '23814',
                'numberCols' => '1',
                'orient' => 'portrait',
                'code' => '8',
                'marginTop' => '1417',
                'marginRight' => '1701',
                'marginBottom' => '1417',
                'marginLeft' => '1701',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'A3-landscape' => array(
                'width' => '23814',
                'height' => '16839',
                'numberCols' => '1',
                'orient' => 'landscape',
                'code' => '8',
                'marginTop' => '1701',
                'marginRight' => '1417',
                'marginBottom' => '1701',
                'marginLeft' => '1417',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'letter' => array(
                'width' => '12240',
                'height' => '15840',
                'numberCols' => '1',
                'orient' => 'portrait',
                'code' => '1',
                'marginTop' => '1417',
                'marginRight' => '1701',
                'marginBottom' => '1417',
                'marginLeft' => '1701',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'letter-landscape' => array(
                'width' => '15840',
                'height' => '12240',
                'numberCols' => '1',
                'orient' => 'landscape',
                'code' => '1',
                'marginTop' => '1701',
                'marginRight' => '1417',
                'marginBottom' => '1701',
                'marginLeft' => '1417',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'legal' => array(
                'width' => '12240',
                'height' => '20160',
                'numberCols' => '1',
                'orient' => 'portrait',
                'code' => '5',
                'marginTop' => '1417',
                'marginRight' => '1701',
                'marginBottom' => '1417',
                'marginLeft' => '1701',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
            'legal-landscape' => array(
                'width' => '20160',
                'height' => '12240',
                'numberCols' => '1',
                'orient' => 'landscape',
                'code' => '5',
                'marginTop' => '1701',
                'marginRight' => '1417',
                'marginBottom' => '1701',
                'marginLeft' => '1417',
                'marginHeader' => '708',
                'marginFooter' => '708',
                'gutter' => '0'
            ),
        );

        try {
            if (!in_array($paperType, $paperTypes)) {
                throw new \Exception('You have used an invalid paper size');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }


        $layout = array();
        foreach ($layoutOptions as $opt) {
            if (isset($referenceSizes[$paperType][$opt])) {
                $layout[$opt] = $referenceSizes[$paperType][$opt];
            }
        }
        foreach ($layoutOptions as $opt) {
            if (isset($options[$opt])) {
                $layout[$opt] = $options[$opt];
            }
        }

        if (!isset($options['sectionNumbers'])) {
            $options['sectionNumbers'] = NULL;
        }
        // get the current sectPr nodes
        if ($options['onlyLastSection']) {
            $sectPrNodes = array();
            $sectPrNodes[] = $this->_sectPr->documentElement;
        } else {
            $sectPrNodes = $this->getSectionNodes($options['sectionNumbers']);
        }
        // modify them
        foreach ($sectPrNodes as $sectionNode) {
            if (isset($layout['width'])) {
                $sectionNode->getElementsByTagName('pgSz')->item(0)->setAttribute('w:w', $layout['width']);
            }
            if (isset($layout['height'])) {
                $sectionNode->getElementsByTagName('pgSz')->item(0)->setAttribute('w:h', $layout['height']);
            }
            if (isset($layout['orient'])) {
                $this->_sectPr->getElementsByTagName('pgSz')->item(0)->setAttribute('w:orient', $layout['orient']);
            }
            if (isset($layout['code'])) {
                $sectionNode->getElementsByTagName('pgSz')->item(0)->setAttribute('w:code', $layout['code']);
            }
            if (isset($layout['marginTop'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:top', $layout['marginTop']);
            }
            if (isset($layout['marginRight'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:right', $layout['marginRight']);
            }
            if (isset($layout['marginBottom'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:bottom', $layout['marginBottom']);
            }
            if (isset($layout['marginLeft'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:left', $layout['marginLeft']);
            }
            if (isset($layout['marginHeader'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:header', $layout['marginHeader']);
            }
            if (isset($layout[$paperType]['marginFooter'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:footer', $layout['marginFooter']);
            }
            if (isset($layout['gutter'])) {
                $sectionNode->getElementsByTagName('pgMar')->item(0)->setAttribute('w:gutter', $layout['gutter']);
            }
            if (isset($layout['bidi'])) {
                $this->modifySingleSectionProperty($sectionNode, 'bidi', array('val' => $layout['bidi']));
            }
            if (isset($layout['rtlGutter'])) {
                $this->modifySingleSectionProperty($sectionNode, 'rtlGutter', array('val' => $layout['rtlGutter']));
            }

            //Now we look at the case of numberCols
            if (isset($layout['numberCols'])) {
                if ($sectionNode->getElementsByTagName('cols')->length > 0) {
                    $sectionNode->getElementsByTagName('cols')->item(0)->setAttribute('w:num', $layout['numberCols']);
                } else {
                    $colsNode = $sectionNode->ownerDocument->createDocumentFragment();
                    $colsNode->appendXML('<w:cols w:num="' . $layout['numberCols'] . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" />');
                    $sectionNode->appendChild($colsNode);
                }
            }
        }
        $this->restoreDocumentXML();
    }
    
    /**
     * Gets the Ids associated with the different styles in the current document or an external docx.
     * It returns a docx with all the avalaible paragraph, list and table styles.
     *
     * @access public
     * @param string $path. Optional, if empty lists the styles of the current style sheet
     */
    public function parseStyles($path = '')
    {
        if ($path != '') {
            $tempTitle = explode('/', $path);
            $title = array_pop($tempTitle);
            $parseStyles = new \ZipArchive();
            try {
                $openParseStyle = $parseStyles->open($path);
                if ($openParseStyle !== true) {
                    throw new \Exception('Error while opening the Style sheet to be tested: please, check the path');
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }

            try {
                $parsedStyles = $parseStyles->getFromName('word/styles.xml');
                if ($parsedStyles == '') {
                    throw new \Exception('Error while extracting the styles to be parsed from the external docx');
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }

            try {
                $parsedNumberings = $parseStyles->getFromName('word/numbering.xml');
                if ($parsedNumberings == '') {
                    throw new \Exception('Error while extracting the numberings to be parsed from the external docx');
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }
        } else {
            if ($this->_docxTemplate == true) {
                $tempTitle = explode('/', $this->_baseTemplatePath);
            } else {
                $tempTitle = explode('/', PHPDOCX_BASE_TEMPLATE);
            }
            $title = array_pop($tempTitle);
            $this->_wordDocumentC = '';
            $parsedStyles = $this->_wordStylesT->saveXML();
            $parsedNumberings = $this->_wordNumberingT;
        }


        // include certain sample content to create the resulting style docx

        $myParagraph = 'This is some sample paragraph test';
        $myList = array('item 1', 'item 2', array('subitem 2_1', 'subitem 2_2'), 'item 3', array('subitem 3_1', 'subitem 3_2', array('sub_subitem 3_2_1', 'sub_subitem 3_2_1')), 'item 4');
        $myTable = array(
            array(
                'Title A',
                'Title B',
                'Title C'
            ),
            array(
                'First row A',
                'First row B',
                'First row C'
            ),
            array(
                'Second row A',
                'Second row B',
                'Second row C'
            )
        );

        // parse the different list numberings from
        $this->addText('List styles: ' . $title, array('jc' => 'center', 'color' => 'b90000', 'b' => 'single', 'sz' => '18', 'u' => 'double'));

        $wordListChunk = '<w:p><w:pPr><w:rPr><w:b/></w:rPr></w:pPr>
        <w:r><w:rPr><w:b/></w:rPr><w:t>SAMPLE CODE:</w:t></w:r>
        </w:p><w:tbl><w:tblPr><w:tblW w:w="0" w:type="auto"/>
        <w:shd w:val="clear" w:color="auto" w:fill="DDD9C3"/>
        <w:tblLook w:val="04A0"/></w:tblPr><w:tblGrid>
        <w:gridCol w:w="8644"/></w:tblGrid><w:tr><w:tc>
        <w:tcPr><w:tcW w:w="8644" w:type="dxa"/>
        <w:shd w:val="clear" w:color="auto" w:fill="DCDAC4"/>
        </w:tcPr><w:p><w:pPr><w:spacing w:before="200"/></w:pPr>
        <w:r><w:t>$</w:t></w:r><w:r>
        <w:t>myList</w:t></w:r><w:r>
        <w:t xml:space="preserve"> = array(\'item 1\', </w:t>
        </w:r><w:r>
        <w:br/>
        <w:t xml:space="preserve">                             </w:t>
        </w:r><w:r>
        <w:t xml:space="preserve">\'item 2\', </w:t>
        </w:r><w:r><w:br/>
        <w:t xml:space="preserve">                             </w:t>
        </w:r><w:r><w:t>array(\'</w:t></w:r><w:r><w:t>subitem</w:t>
        </w:r><w:r>
        <w:t xml:space="preserve"> 2_1\', </w:t></w:r><w:r><w:br/>
        <w:t xml:space="preserve">                                        </w:t>
        </w:r><w:r><w:t>\'</w:t>
        </w:r><w:r><w:t>subitem</w:t></w:r><w:r>
        <w:t xml:space="preserve"> 2_2\'), </w:t></w:r><w:r><w:br/>
        <w:t xml:space="preserve">                             </w:t>
        </w:r><w:r><w:t xml:space="preserve">\'item 3\', </w:t></w:r>
        <w:r><w:br/>
        <w:t xml:space="preserve">                             </w:t>
        </w:r><w:r><w:t>array(\'</w:t></w:r><w:r><w:t>subitem</w:t>
        </w:r><w:r><w:t xml:space="preserve"> 3_1\', </w:t></w:r>
        <w:r><w:br/>
        <w:t xml:space="preserve">                                        </w:t>
        </w:r><w:r><w:t>\'</w:t></w:r><w:r><w:t>subitem</w:t></w:r>
        <w:r><w:t xml:space="preserve"> 3_2\', </w:t></w:r><w:r><w:br/>
        <w:t xml:space="preserve">                                        </w:t>
        </w:r><w:r><w:t>array(\'</w:t></w:r><w:r><w:t>sub_subitem</w:t></w:r><w:r>
        <w:t xml:space="preserve"> 3_2_1\', </w:t></w:r><w:r><w:br/>
        <w:t xml:space="preserve">                                                   </w:t>
        </w:r><w:r><w:t>\'</w:t></w:r><w:r><w:t>sub_subitem</w:t></w:r><w:r>
        <w:t xml:space="preserve"> 3_2_1\')),</w:t></w:r><w:r><w:br/>
        <w:t xml:space="preserve">                             </w:t>
        </w:r><w:r><w:t xml:space="preserve"> \'item 4\');</w:t></w:r></w:p>
        <w:p><w:pPr><w:spacing w:before="200"/></w:pPr>
        <w:r><w:t>addList</w:t></w:r><w:r><w:t>($</w:t></w:r>
        <w:r><w:t>myList</w:t></w:r><w:r><w:t>, NUMID</w:t></w:r>
        <w:r><w:t>))</w:t></w:r></w:p></w:tc></w:tr></w:tbl><w:p><w:pPr></w:pPr>
        </w:p>
        <w:p><w:pPr><w:rPr><w:b/></w:rPr></w:pPr>
        <w:r><w:rPr><w:b/></w:rPr><w:t>SAMPLE RESULT:</w:t></w:r>
        </w:p>';
        $NumberingsDoc = new \DOMDocument();
        $NumberingsDoc->loadXML($parsedNumberings);
        $numberXpath = new \DOMXPath($NumberingsDoc);
        $numberXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $queryNumber = '//w:num';
        $numberingsNodes = $numberXpath->query($queryNumber);
        foreach ($numberingsNodes as $node) {
            $wordListChunkTemp = str_replace('NUMID', $node->getAttribute('w:numId'), $wordListChunk);
            $this->_wordDocumentC .= $wordListChunkTemp;
            $this->addList($myList, (int) $node->getAttribute('w:numId'));
            $this->addBreak(array('type' => 'page'));
        }

        $this->addText('Paragraph and Table styles: ' . $title, array('jc' => 'center', 'color' => 'b90000', 'b' => 'single', 'sz' => '18', 'u' => 'double'));

        // parse the different styles using XPath
        $StylesDoc = new \DOMDocument();
        $StylesDoc->loadXML($parsedStyles);
        $parseStylesXpath = new \DOMXPath($StylesDoc);
        $parseStylesXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:style';
        $parsedNodes = $parseStylesXpath->query($query);
        // list the present styles and their respective Ids
        $count = 1;
        foreach ($parsedNodes as $node) {
            $styleId = $node->getAttribute('w:styleId');
            $styleType = $node->getAttribute('w:type');
            $styleDefault = $node->getAttribute('w:default');
            $styleCustom = $node->getAttribute('w:custom');
            $nodeChilds = $node->childNodes;
            foreach ($nodeChilds as $child) {
                if ($child->nodeName == 'w:name') {
                    $styleName = $child->getAttribute('w:val');
                }
            }
            $this->parsedStyles[$count] = array('id' => $styleId, 'name' => $styleName, 'type' => $styleType, 'default' => $styleDefault, 'custom' => $styleCustom);

            $default = ($styleDefault == 1) ? 'true' : 'false';
            $custom = ($styleCustom == 1) ? 'true' : 'false';

            $wordMLChunk = '<w:tbl><w:tblPr><w:tblW w:w="0" w:type="auto"/>
                </w:tblPr><w:tblGrid><w:gridCol w:w="4322"/><w:gridCol w:w="4322"/>
                </w:tblGrid><w:tr><w:tc><w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="BD1503"/>
                </w:tcPr><w:p><w:pPr><w:spacing w:after="0"/><w:rPr>
                <w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r><w:rPr>
                <w:color w:val="FFFFFF"/></w:rPr><w:t>NAME:</w:t></w:r></w:p>
                </w:tc><w:tc><w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="BD1503"/></w:tcPr>
                <w:p><w:pPr><w:spacing w:after="0"/><w:rPr><w:color w:val="FFFFFF"/>
                </w:rPr></w:pPr><w:r><w:rPr><w:color w:val="FFFFFF"/>
                </w:rPr><w:t>' . $styleName . '</w:t></w:r></w:p></w:tc>
                </w:tr><w:tr><w:tc><w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr><w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr><w:t>Type</w:t>
                </w:r><w:r><w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>:</w:t></w:r></w:p></w:tc><w:tc><w:tcPr>
                <w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>' . $styleType . '</w:t></w:r></w:p></w:tc></w:tr>
                <w:tr><w:tc><w:tcPr>
                <w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>ID:</w:t></w:r></w:p></w:tc><w:tc>
                <w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>' . $styleId . '</w:t></w:r></w:p></w:tc></w:tr><w:tr><w:tc><w:tcPr>
                <w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/></w:tcPr>
                <w:p><w:pPr><w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr><w:t>Default:</w:t></w:r>
                </w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr>
                <w:r><w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>' . $default . '</w:t></w:r></w:p></w:tc></w:tr><w:tr>
                <w:tc><w:tcPr><w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr>
                <w:r><w:rPr><w:color w:val="FFFFFF"/></w:rPr><w:t>Custom</w:t>
                </w:r><w:r><w:rPr><w:color w:val="FFFFFF"/></w:rPr>
                <w:t>:</w:t></w:r></w:p></w:tc><w:tc><w:tcPr>
                <w:tcW w:w="4322" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="3E3E42"/>
                </w:tcPr><w:p><w:pPr>
                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr></w:pPr><w:r>
                <w:rPr><w:color w:val="FFFFFF"/></w:rPr><w:t>' . $custom . '</w:t>
                </w:r></w:p></w:tc></w:tr></w:tbl>
                <w:p w:rsidR="000F6147" w:rsidRDefault="000F6147" w:rsidP="00B42E7D">
                <w:pPr><w:spacing w:after="0"/></w:pPr></w:p>
                <w:p w:rsidR="00DC3ACE" w:rsidRDefault="00DC3ACE">
                <w:pPr><w:rPr><w:b/></w:rPr></w:pPr><w:r>
                <w:rPr><w:b/></w:rPr><w:t>SAMPLE CODE:</w:t></w:r></w:p>
                <w:tbl><w:tblPr><w:tblW w:w="0" w:type="auto"/>
                <w:shd w:val="clear" w:color="auto" w:fill="DDD9C3"/>
                </w:tblPr><w:tblGrid><w:gridCol w:w="8644"/>
                </w:tblGrid><w:tr><w:tc><w:tcPr><w:tcW w:w="8644" w:type="dxa"/>
                <w:shd w:val="clear" w:color="auto" w:fill="DCDAC4"/></w:tcPr>
                <w:p w:rsidR="00DC3ACE" w:rsidRDefault="00DC3ACE">
                <w:pPr><w:spacing w:before="200" /></w:pPr><w:r>
                <w:t>CODEX</w:t></w:r></w:p></w:tc></w:tr></w:tbl><w:p/><w:p>
                <w:pPr><w:rPr><w:b/></w:rPr></w:pPr><w:r><w:rPr><w:b/>
                </w:rPr><w:t>SAMPLE RESULT:</w:t></w:r></w:p>
                ';

            switch ($styleType) {
                case 'table':
                    $wordMLChunk = str_replace('CODEX', "addTable(array(array('Title A','Title B','Title C'),array('First row A','First row B','First row C'),array('Second row A','Second row B','Second row C')), array('tableStyle'=> '$styleId'), 'columnWidths' => array(1800, 1800, 1800))", $wordMLChunk);
                    $this->_wordDocumentC .= $wordMLChunk;
                    $params = array('tableStyle' => $styleId, 'columnWidths' => array(1800, 1800, 1800));
                    $this->addTable($myTable, $params);
                    if ($count % 2 == 0) {
                        $this->_wordDocumentC .= '<w:p><w:r><w:br w:type="page"/></w:r></w:p>';
                    } else {
                        $this->_wordDocumentC .= '<w:p /><w:p />';
                    }
                    $count++;
                    break;
                case 'paragraph':
                    $myPCode = "addText('This is some sample paragraph test', array('pStyle' => '" . $styleId . "'))";
                    $wordMLChunk = str_replace('CODEX', $myPCode, $wordMLChunk);
                    $this->_wordDocumentC .= $wordMLChunk;
                    $params = array('pStyle' => $styleId);
                    $this->addText($myParagraph, $params);
                    if ($count % 2 == 0) {
                        $this->_wordDocumentC .= '<w:p><w:r><w:br w:type="page"/></w:r></w:p>';
                    } else {
                        $this->_wordDocumentC .= '<w:p /><w:p />';
                    }
                    $count++;
                    break;
            }
        }
    }
    
    /**
     *
     * Removes existing headers.
     *
     */
    private function removeHeaders()
    {

        foreach ($this->_relsHeader as $key => $value) {
            // first remove the actual header files
            $this->_zipDocx->deleteName('word/' . $value);
            $this->_zipDocx->deleteName('word/_rels/' . $value . '.rels');

            // modify the rels file
            $relationships = $this->_wordRelsDocumentRelsT->getElementsByTagName('Relationship');
            $counter = $relationships->length - 1;
            for ($j = $counter; $j > -1; $j--) {
                $target = $relationships->item($j)->getAttribute('Target');
                if ($target == $value) {
                    $this->_wordRelsDocumentRelsT->documentElement->removeChild($relationships->item($j));
                }
            }

            // remove the corresponding override tags from [Content_Types].xml
            $overrides = $this->_contentTypeT->getElementsByTagName('Override');
            $counter = $overrides->length - 1;
            for ($j = $counter; $j > -1; $j--) {
                $target = $overrides->item($j)->getAttribute('PartName');
                if ($target == '/word/' . $value) {
                    $this->_contentTypeT->documentElement->removeChild($overrides->item($j));
                }
            }
        }

        // change the section properties
        $headers = $this->_sectPr->getElementsByTagName('headerReference');
        $counter = $headers->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $this->_sectPr->documentElement->removeChild($headers->item($j));
        }
        $titlePage = $this->_sectPr->getElementsByTagName('titlePg');
        $counter = $titlePage->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $this->_sectPr->documentElement->removeChild($titlePage->item($j));
        }
        // remove the header references that may exist
        // within $this->_wordDocumentC
        $domDocument = $this->getDOMDocx();
        $headers = $domDocument->getElementsByTagName('headerReference');
        $counter = $headers->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $headers->item($j)->parentNode->removeChild($headers->item($j));
        }
        $titlePage = $domDocument->getElementsByTagName('titlePg');
        $counter = $titlePage->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $titlePage->item($j)->parentNode->removeChild($titlePage->item($j));
        }
        $this->_tempDocumentDOM = $domDocument;
        $this->restoreDocumentXML();

        // finally, if it exists, the evenAndOddHeader element from settings
        $this->removeSetting('w:evenAndOddHeaders');
    }
    
    /**
     *
     * Removes headers and footers.
     *
     */
    private function removeHeadersAndFooters()
    {
        $this->removeHeaders();
        $this->removeFooters();
    }

    /**
     *
     * Removes existing footers
     *
     */
    private function removeFooters()
    {
        foreach ($this->_relsFooter as $key => $value) {
            // first remove the actual header files
            $this->_zipDocx->deleteName('word/' . $value);
            $this->_zipDocx->deleteName('word/_rels/' . $value . '.rels');

            // modify the rels file
            $relationships = $this->_wordRelsDocumentRelsT->getElementsByTagName('Relationship');
            $counter = $relationships->length - 1;
            for ($j = $counter; $j > -1; $j--) {
                $target = $relationships->item($j)->getAttribute('Target');
                if ($target == $value) {
                    $this->_wordRelsDocumentRelsT->documentElement->removeChild($relationships->item($j));
                }
            }
            // remove the corresponding override tags from [Content_Types].xml
            $overrides = $this->_contentTypeT->getElementsByTagName('Override');
            $counter = $overrides->length - 1;
            for ($j = $counter; $j > -1; $j--) {
                $target = $overrides->item($j)->getAttribute('PartName');
                if ($target == '/word/' . $value) {
                    $this->_contentTypeT->documentElement->removeChild($overrides->item($j));
                }
            }
        }
        // change the section properties
        $footers = $this->_sectPr->getElementsByTagName('footerReference');
        $counter = $footers->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $this->_sectPr->documentElement->removeChild($footers->item($j));
        }
        $titlePage = $this->_sectPr->getElementsByTagName('titlePg');
        $counter = $titlePage->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $this->_sectPr->documentElement->removeChild($titlePage->item($j));
        }
        // remove the header references that may exist
        // within $this->_wordDocumentC
        $domDocument = $this->getDOMDocx();
        $footers = $domDocument->getElementsByTagName('footerReference');
        $counter = $footers->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $footers->item($j)->parentNode->removeChild($footers->item($j));
        }
        $titlePage = $domDocument->getElementsByTagName('titlePg');
        $counter = $titlePage->length - 1;
        for ($j = $counter; $j > -1; $j--) {
            $titlePage->item($j)->parentNode->removeChild($titlePage->item($j));
        }
        $this->_tempDocumentDOM = $domDocument;
        $this->restoreDocumentXML();
        // finally, if it exists, the evenAndOddHeader element from settings
        $this->removeSetting('w:evenAndOddHeaders');
    }

    /**
     * Changes the background color of the document
     *
     * @access public
     * @param string $color
     * Values: hexadecimal color value without # (ffff00, 0000ff, ...)
     */
    public function setBackgroundColor($color)
    {
        $this->_backgroundColor = $color;
        // construct the background WordML code
        if ($this->_background == '') {
            $this->_background = '<w:background w:color="' . $color . '" />';
            // modify the settings.xml file
            $this->docxSettings(array('displayBackgroundShape' => true));
        } else {
            $this->_background = str_replace('w:color="FFFFFF"', 'w:color="' . $color . '"', $this->_background);
        }
    }

    /**
     * Change the decimal symbol
     *
     * @access public
     * @param string $symbol
     *  Values: '.', ',',...
     */
    public function setDecimalSymbol($symbol)
    {
        $decimalNodes = $this->_wordSettingsT->getElementsByTagName('decimalSymbol');
        if ($decimalNodes->length > 0) {
            $decimalNode = $decimalNodes->item(0);
            $decimalNode->setAttribute('w:val', $symbol);
        }
        PhpdocxLogger::logger('Change decimal symbol.', 'info');
    }

    /**
     * Change the default font
     *
     * @access public
     * @param string $font The new font
     *  Values: 'Arial', 'Times New Roman'...
     */
    public function setDefaultFont($font)
    {
        $this->_defaultFont = $font;
        // get the original theme as a DOMdocument
        $themeDocument = $this->getFromZip('word/theme/theme1.xml', 'DOMDocument');
        $latinNode = $themeDocument->getElementsByTagName('latin');
        $latinNode->item(0)->setAttribute('typeface', $font);
        $latinNode->item(1)->setAttribute('typeface', $font);
        $this->saveToZip($themeDocument, 'word/theme/theme1.xml');
        //To preserve the default font for PDF conversion make sure the $font is
        //defined in the fontTable.xml file
        $fontDocument = $this->getFromZip('word/fontTable.xml', 'DOMDocument');
        $fontXPath = new \DOMXPath($fontDocument);
        $fontXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $query = '//w:font[@w:name="' . $font . '"]';
        $fonts = $fontXPath->query($query);
        //If the font is not found append a w:font node to fontTable.xml
        if ($fonts->length == 0) {
            $newNode = $fontDocument->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'w:font');
            $newNode->setAttributeNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'w:name', $font);
            $fontDocument->documentElement->appendChild($newNode);
            $this->saveToZip($fontDocument, 'word/fontTable.xml');
        }
        PhpdocxLogger::logger('The default font was changed to' . $font, 'info');
    }

    /**
     * Transform to UTF-8 charset
     *
     * @access public
     */
    public function setEncodeUTF8()
    {
        self::$_encodeUTF = 1;
    }

    /**
     * Change default language.
     * @param $lang Locale: en-US, es-ES...
     * @access public
     */
    public function setLanguage($lang = null)
    {
        if (!$lang) {
            $lang = 'en-US';
        }
        // get the original styles as a DOMdocument
        $langNode = $this->_wordStylesT->getElementsByTagName('lang');
        if ($langNode->length > 0) {
            $langNode->item(0)->setAttribute('w:val', $lang);
            $langNode->item(0)->setAttribute('w:eastAsia', $lang);
        }
        // check also if tehre is a themeFontlanfg entry in the settings file
        $themeFontLangNode = $this->_wordSettingsT->getElementsByTagName('themeFontLang');
        if ($themeFontLangNode->length > 0) {
            $themeFontLangNode->item(0)->setAttribute('w:val', $lang);
        }

        PhpdocxLogger::logger('Set language: ' . $lang, 'info');
    }

    /**
     * Mark the document as final
     *
     * @access public
     *
     */
    public function setMarkAsFinal()
    {
        $this->_markAsFinal = 1;
        $this->addProperties(array('contentStatus' => 'Final'));
        $this->generateOVERRIDE(
                '/docProps/custom.xml', 'application/vnd.openxmlformats-officedocument.' .
                'custom-properties+xml'
        );
    }

    /**
     * sets global right to left options
     * @access public
     * @param array $options
     * values:
     *  'bidi' (bool)
     *  'rtl' (bool)
     * @return void
     */
    public function setRTL($options = array('bidi' => true, 'rtl' => true))
    {
        if (isset($options['bidi']) && $options['bidi']) {
            self::$bidi = true;
        }
        if (isset($options['rtl']) && $options['rtl']) {
            self::$rtl = true;
        }
        $this->modifyPageLayout('custom', array('bidi' => $options['bidi'], 'rtlGutter' => $options['rtl']));
        //set footnotes and endnotes separators for bidi and rtl
        $notesArray = array('footnote' => $this->_wordFootnotesT, 'endnote' => $this->_wordEndnotesT);
        foreach ($notesArray as $note => $value) {
            $noteXPath = new \DOMXPath($value);
            $noteXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $query = '//w:' . $note . '[@w:type="separator"] | //w:' . $note . '[@w:type="continuationSeparator"]';
            $selectedNodes = $noteXPath->query($query);
            foreach ($selectedNodes as $node) {
                $pPrNode = $node->getElementsbyTagName('pPr')->item(0);
                $bidiNodes = $node->getElementsbyTagName('bidi');
                if ($bidiNodes->length > 0) {
                    $bidiNodes->item(0)->setAttribute('w:val', $options['bidi']);
                } else {
                    $bidi = $pPrNode->ownerDocument->createElement('w:bidi');
                    $bidi->setAttribute('w:val', $options['bidi']);
                    $pPrNode->appendChild($bidi);
                }
                $rtlNodes = $node->getElementsbyTagName('rtl');
                if ($rtlNodes->length > 0) {
                    $rtlNodes->item(0)->setAttribute('w:val', $options['rtl']);
                } else {
                    $rtl = $pPrNode->ownerDocument->createElement('w:rtl');
                    $rtl->setAttribute('w:val', $options['rtl']);
                    $pPrNode->appendChild($rtl);
                }
            }
        }
    }

    /**
     * sets global right to left options for the different methods
     * @access public
     * @static
     * @param array $options
     * @return array
     */
    public static function setRTLOptions($options)
    {
        if (!isset($options['bidi']) && CreateDocx::$bidi) {
            $options['bidi'] = true;
        }
        if (!isset($options['rtl']) && CreateDocx::$rtl) {
            $options['rtl'] = true;
        }
        return $options;
    }

    /**
     * Transform DOCX to PDF, ODT, SXW, RTF, DOC, TXT, HTML or WIKI
     * Transforms all documents supported by OpenOffice
     *
     * @access public
     * @param string $docSource
     * @param string $docDestination
     * @param string $tempDir
     * @param array $options :
     *      · method : 'direct' (default), 'script' ; 'direct' method uses
     *                  passthru and 'script' uses a external script.
     *                  If you're using Apache and 'direct' doesn't work use 'script'
     *      · 'odfconverter' : true (default) or false. Use odf-converter.
     *      · 'debug' : false (default) or true. It shows debug information about the plugin conversion
     * @param string $version 32, 64 or null (default). If null autodetect
     * @return void
     */
    public function transformDocument($docSource, $docDestination, $tempDir = null, $options = array(), $version = null)
    {
        if (file_exists(dirname(__FILE__) . '/../Transform/TransformDocAdv.inc')) {
            try {
                if (!$this->_compatibilityMode) {
                    throw new \Exception('Running in compatibility mode. Unsupported method.');
                }
                if ($this->_phpdocxconfig['transform']['method'] == 'libreoffice') {
                    $convert = new Phpdocx\Transform\TransformDocAdvLibreOffice();
                    $convert->transformDocument($docSource, $docDestination, $tempDir, $options);
                } else {
                    $convert = new Phpdocx\Transform\TransformDocAdvOpenOffice();
                    $convert->transformDocument($docSource, $docDestination, $tempDir, $options, $version);
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }
        }
    }

    /**
     * If PHPDocX is installed in a server with a working copy of Word 2007 or newer you may
     * use it to do format conversions.
     * Supported formats, DOCX and DOC to PDF, RTF, HTML and DOC
     * @access public
     * @static
     * @param $docSource you should use the full Windows path to the docx (remember to escape backslashes)
     * @param $docDestination you should use the full Windows path to the docx (remember to escape backslashes)
     * @return void
     */
    public function transformDocxUsingMSWord($docSource, $docDestination)
    {
        $convert = new MSWordInterface();
        $convert->transformFormat($docSource, $docDestination);
    }

    /**
     * Translate chart option arrays to a predefined format
     * @param array $options
     * @access public
     * @static
     */
    public static function translateChartOptions2StandardFormat($options)
    {
        foreach ($options as $key => $value) {
            $options[strtolower($key)] = $value;
        }
        if (isset($options['chartAlign'])) {
            $options['jc'] = $options['chartAlign'];
        }
        return $options;
    }

    /**
     * Translate table option arrays to a predefined format
     * @param array $options
     * @access public
     * @static
     */
    public static function translateTableOptions2StandardFormat($options)
    {
        // general border options
        if (isset($options['borderColor'])) {
            $options['border_color'] = $options['borderColor'];
        }
        if (isset($options['borderSpacing'])) {
            $options['border_spacing'] = $options['borderSpacing'];
        }
        if (isset($options['borderWidth'])) {
            $options['border_sz'] = $options['borderWidth'];
            $options['border_width'] = $options['borderWidth'];
        }
        if (isset($options['borderSettings'])) {
            $options['border_settings'] = $options['borderSettings'];
        }
        // individual side options
        if (isset($options['borderTop'])) {
            $options['border_top'] = $options['borderTop'];
            $options['border_top_style'] = $options['borderTop'];
        }
        if (isset($options['borderRight'])) {
            $options['border_right'] = $options['borderRight'];
            $options['border_right_style'] = $options['borderRight'];
        }
        if (isset($options['borderBottom'])) {
            $options['border_bottom'] = $options['borderBottom'];
            $options['border_bottom_style'] = $options['borderBottom'];
        }
        if (isset($options['borderLeft'])) {
            $options['border_left'] = $options['borderLeft'];
            $options['border_left_style'] = $options['borderLeft'];
        }
        if (isset($options['borderTopWidth'])) {
            $options['border_top_sz'] = $options['borderTopWidth'];
            $options['border_top_width'] = $options['borderTopWidth'];
        }
        if (isset($options['borderRightWidth'])) {
            $options['border_right_sz'] = $options['borderRightWidth'];
            $options['border_right_width'] = $options['borderRightWidth'];
        }
        if (isset($options['borderBottomWidth'])) {
            $options['border_bottom_sz'] = $options['borderBottomWidth'];
            $options['border_bottom_width'] = $options['borderBottomWidth'];
        }
        if (isset($options['borderLeftWidth'])) {
            $options['border_left_sz'] = $options['borderLeftWidth'];
            $options['border_left_width'] = $options['borderLeftWidth'];
        }
        if (isset($options['borderTopColor'])) {
            $options['border_top_color'] = $options['borderTopColor'];
        }
        if (isset($options['borderRightColor'])) {
            $options['border_right_color'] = $options['borderRightColor'];
        }
        if (isset($options['borderBottomColor'])) {
            $options['border_bottom_color'] = $options['borderBottomColor'];
        }
        if (isset($options['borderLeftColor'])) {
            $options['border_left_color'] = $options['borderLeftColor'];
        }
        if (isset($options['borderTopSpacing'])) {
            $options['border_top_spacing'] = $options['borderTopSpacing'];
        }
        if (isset($options['borderRightSpacing'])) {
            $options['border_right_spacing'] = $options['borderRightSpacing'];
        }
        if (isset($options['borderBottomSpacing'])) {
            $options['border_bottom_spacing'] = $options['borderBottomSpacing'];
        }
        if (isset($options['borderLeftSpacing'])) {
            $options['border_left_spacing'] = $options['borderLeftSpacing'];
        }
        // column sizes
        if (isset($options['columnWidths'])) {
            $options['size_col'] = $options['columnWidths'];
        }
        // text margins
        if (isset($options['float']['tableMarginTop'])) {
            $options['float']['textMargin_top'] = $options['float']['tableMarginTop'];
        }
        if (isset($options['float']['tableMarginRight'])) {
            $options['float']['textMargin_right'] = $options['float']['tableMarginRight'];
        }
        if (isset($options['float']['tableMarginBottom'])) {
            $options['float']['textMargin_bottom'] = $options['float']['tableMarginBottom'];
        }
        if (isset($options['float']['tableMarginLeft'])) {
            $options['float']['textMargin_left'] = $options['float']['tableMarginLeft'];
        }
        // styles
        if (isset($options['tableAlign'])) {
            $options['jc'] = $options['tableAlign'];
        }
        if (isset($options['tableStyle'])) {
            $options['TBLSTYLEval'] = $options['tableStyle'];
        }
        if (isset($options['backgroundColor'])) {
            $options['background_color'] = $options['backgroundColor'];
        }
        return $options;
    }

    /**
     * Translate table option arrays to a predefined format
     * @param array $options
     * @access public
     * @static
     */
    public static function translateTextOptions2StandardFormat($options)
    {
        if (is_array($options)) {
            // general border options
            if (isset($options['border']) && $options['border'] == 'none') {
                $options['border'] = 'nil';
            }
            if (isset($options['borderColor'])) {
                $options['border_color'] = $options['borderColor'];
            }
            if (isset($options['borderSpacing'])) {
                $options['border_spacing'] = $options['borderSpacing'];
            }
            if (isset($options['borderWidth'])) {
                $options['border_sz'] = $options['borderWidth'];
            }
            if (isset($options['borderSettings'])) {
                $options['border_settings'] = $options['borderSettings'];
            }
            // individual side options
            if (isset($options['borderTop'])) {
                $options['border_top'] = $options['borderTop'];
                $options['border_top_style'] = $options['borderTop'];
            }
            if (isset($options['borderRight'])) {
                $options['border_right'] = $options['borderRight'];
                $options['border_right_style'] = $options['borderRight'];
            }
            if (isset($options['borderBottom'])) {
                $options['border_bottom'] = $options['borderBottom'];
                $options['border_bottom_style'] = $options['borderBottom'];
            }
            if (isset($options['borderLeft'])) {
                $options['border_left'] = $options['borderLeft'];
                $options['border_left_style'] = $options['borderLeft'];
            }
            if (isset($options['borderTopWidth'])) {
                $options['border_top_sz'] = $options['borderTopWidth'];
            }
            if (isset($options['borderRightWidth'])) {
                $options['border_right_sz'] = $options['borderRightWidth'];
            }
            if (isset($options['borderBottomWidth'])) {
                $options['border_bottom_sz'] = $options['borderBottomWidth'];
            }
            if (isset($options['borderLeftWidth'])) {
                $options['border_left_sz'] = $options['borderLeftWidth'];
            }
            if (isset($options['borderTopColor'])) {
                $options['border_top_color'] = $options['borderTopColor'];
            }
            if (isset($options['borderRightColor'])) {
                $options['border_right_color'] = $options['borderRightColor'];
            }
            if (isset($options['borderBottomColor'])) {
                $options['border_bottom_color'] = $options['borderBottomColor'];
            }
            if (isset($options['borderLeftColor'])) {
                $options['border_left_color'] = $options['borderLeftColor'];
            }
            if (isset($options['borderTopSpacing'])) {
                $options['border_top_spacing'] = $options['borderTopSpacing'];
            }
            if (isset($options['borderRightSpacing'])) {
                $options['border_right_spacing'] = $options['borderRightSpacing'];
            }
            if (isset($options['borderBottomSpacing'])) {
                $options['border_bottom_spacing'] = $options['borderBottomSpacing'];
            }
            if (isset($options['borderLeftSpacing'])) {
                $options['border_left_spacing'] = $options['borderLeftSpacing'];
            }
            // reassigned variables
            if (isset($options['indentLeft'])) {
                $options['indent_left'] = $options['indentLeft'];
            }
            if (isset($options['indentRight'])) {
                $options['indent_right'] = $options['indentRight'];
            }
            if (!empty($options['bold'])) {
                $options['b'] = 'on';
            }
            if (!empty($options['italic'])) {
                $options['i'] = 'on';
            }
            if (!empty($options['lineSpacing'])) {
                //$options['lineSpacing'] = ceil($options['lineSpacing'] * 240);
            }

            if (isset($options['fontSize'])) {
                $options['sz'] = $options['fontSize'];
            }
            if (isset($options['underline'])) {
                $options['u'] = $options['underline'];
            }
            if (isset($options['textAlign'])) {
                $options['jc'] = $options['textAlign'];
            }
            // translate to boolean
            if (!empty($options['bidi'])) {
                $options['bidi'] = 'on';
            }
            if (!empty($options['caps'])) {
                $options['caps'] = 'on';
            }
            if (!empty($options['keepLines'])) {
                $options['keepLines'] = 'on';
            }
            if (!empty($options['keepNext'])) {
                $options['keepNext'] = 'on';
            }
            if (!empty($options['pageBreakBefore'])) {
                $options['pageBreakBefore'] = 'on';
            }
            if (!empty($options['smallCaps'])) {
                $options['smallCaps'] = 'on';
            }
            if (!empty($options['widowControl'])) {
                $options['widowControl'] = 'on';
            }
            if (!empty($options['wordWrap'])) {
                $options['wordWrap'] = 'on';
            }
        }
        return $options;
    }

    /**
     *
     * Insert the content of a text file into a word document trying to hold the styles
     *
     * @param string $path. Path to the text file from which we insert into docx document
     * @param array of style values
     * keys: styleTbl, styleLst, styleP
     */
    public function txt2docx($text_filename, $options = array())
    {
        $text = new Text2Docx($text_filename, $options);
        PhpdocxLogger::logger('Add text from text file.', 'info');
        $this->_wordDocumentC .= (string) $text;
    }
    
    /**
     * Embeds a DOCX
     *
     * @access public
     * @param array $options
     * Values:
     * 'src' (string) path to DOCX
     * 'matchSource' (bool) if true (default value)tries to preserve as much as posible the styles of the docx to be included
     * 'preprocess' (boolean) if true does some preprocessing on the docx file to add
     *  WARNING: beware that the docx to insert gets modified so please make a safeguard copy first
     */
    protected function addDOCX($options)
    {
        if (!isset($options['matchSource'])) {
            $options['matchSource'] = true;
        }
        if (!isset($options['preprocess'])) {
            $options['preprocess'] = false;
        }
        $class = get_class($this);
        try {
            if ($this->_compatibilityMode) {
                throw new \Exception('Running in compatibility mode. Unsupported method.');
            }
            if (file_exists($options['src'])) {
                // if preprocess is true we do certain previous manipulation on the docx to embed
                if ($options['preprocess']) {
                    $this->preprocessDocx($options['src']);
                }
                $wordDOCX = EmbedDOCX::getInstance();
                if (isset($options['matchSource']) && $options['matchSource'] === false) {
                    $wordDOCX->embed(false);
                } else {
                    $wordDOCX->embed(true);
                }
                PhpdocxLogger::logger('Add DOCX file to word document.', 'info');

                $this->_zipDocx->addFile($options['src'], 'word/docx' . $wordDOCX->getId() .
                        '.zip');
                $this->generateRELATIONSHIP(
                        'rDOCXId' . $wordDOCX->getId(), 'aFChunk', 'docx' .
                        $wordDOCX->getId() . '.zip', 'TargetMode="Internal"');
                $this->generateDEFAULT('zip', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml');
                if ($this instanceof WordFragment) {
                    $this->wordML .= (string) $wordDOCX . '<w:p />';
                } else {
                    $this->_wordDocumentC .= (string) $wordDOCX;
                }
            } else {
                throw new \Exception('File does not exist.');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }
    
    /**
     * Inserts HTML into a document as alternative content (altChunk).
     * This method IS NOT compatible with PDF conversion or Open Office (use embedHTML instead).
     *
     * @access private
     * @param array $options
     * Values:
     * 'html' (string)
     */
    protected function addHTML($options)
    {
        $class = get_class($this);
        try {
            if ($this->_compatibilityMode) {
                throw new \Exception('Running in compatibility mode. Unsupported method.');
            }
            $wordHTML = EmbedHTML::getInstance();
            $wordHTML->embed();
            PhpdocxLogger::logger('Embed HTML to word document.', 'info');
            $this->_zipDocx->addFromString('word/html' . $wordHTML->getId() .
                    '.htm', '<html>' . file_get_contents($options['src']) . '</html>');
            $this->generateRELATIONSHIP(
                    'rHTMLId' . $wordHTML->getId(), 'aFChunk', 'html' .
                    $wordHTML->getId() . '.htm', 'TargetMode="Internal"');
            $this->generateDEFAULT('htm', 'application/xhtml+xml');
            if ($this instanceof WordFragment) {
                $this->wordML .= (string) $wordHTML . '<w:p/>';
            } else {
                $this->_wordDocumentC .= (string) $wordHTML;
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }
    
    /**
     * Add a MHT file
     *
     * @access private
     * @param array $options
     * Values:
     * 'src' (string) path to the MHT file
     */
    protected function addMHT($options)
    {
        $class = get_class($this);
        try {
            if ($this->_compatibilityMode) {
                throw new \Exception('Running in compatibility mode. Unsupported method.');
            }
            if (file_exists($options['src'])) {
                $wordMHT = EmbedMHT::getInstance();
                $wordMHT->embed();
                PhpdocxLogger::logger('Add MHT file to word document.', 'info');
                $this->_zipDocx->addFile($options['src'], 'word/mht' . $wordMHT->getId() .
                        '.mht');
                $this->generateRELATIONSHIP(
                        'rMHTId' . $wordMHT->getId(), 'aFChunk', 'mht' .
                        $wordMHT->getId() . '.mht', 'TargetMode="Internal"');
                $this->generateDEFAULT('mht', 'message/rfc822');
                if ($this instanceof WordFragment) {
                    $this->wordML .= (string) $wordMHT . '<w:p />';
                } else {
                    $this->_wordDocumentC .= (string) $wordMHT;
                }
            } else {
                throw new \Exception('File does not exist.');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }
    
    /**
     * Add a RTF file. Keep content and styles
     *
     * @access public
     * @param array $options
     * Values:
     * 'src' (string) path to the RTF file
     */
    protected function addRTF($options = array())
    {
        $class = get_class($this);
        try {
            if ($this->_compatibilityMode) {
                throw new \Exception('Running in compatibility mode. Unsupported method.');
            }
            if (file_exists($options['src'])) {
                $wordRTF = EmbedRTF::getInstance();
                $wordRTF->embed();
                PhpdocxLogger::logger('Add RTF file to word document.', 'info');
                $this->saveToZip($options['src'], 'word/rtf' . $wordRTF->getId() .
                        '.rtf');
                $this->generateRELATIONSHIP(
                        'rRTFId' . $wordRTF->getId(), 'aFChunk', 'rtf' .
                        $wordRTF->getId() . '.rtf', 'TargetMode="Internal"');
                $this->generateDEFAULT('rtf', 'application/rtf');
                if ($this instanceof WordFragment) {
                    $this->wordML .= (string) $wordRTF . '<w:p/>';
                } else {
                    $this->_wordDocumentC .= (string) $wordRTF;
                }
            } else {
                throw new \Exception('File does not exist.');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }
    
    /**
     * Generates a relationship entry for the custom properties XML file
     *
     * @access protected
     */
    protected function generateCUSTOMRELS()
    {
        // write the new Relationship node
        $strCustom = '<Relationship Id="rId' . rand(999, 9999) . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/custom-properties" Target="docProps/custom.xml" />';
        $tempNode = self::$relsRels->createDocumentFragment();
        $tempNode->appendXML($strCustom);
        self::$relsRels->documentElement->appendChild($tempNode);
    }

    /**
     * Generate DEFAULT
     *
     * @access protected
     */
    protected function generateDEFAULT($extension, $contentType)
    {
        $strContent = $this->_contentTypeT->saveXML();
        if (
                strpos($strContent, 'Extension="' . $extension) === false
        ) {
            $strContentTypes = '<Default Extension="' . $extension . '" ContentType="' . $contentType . '"> </Default>';
            $tempNode = $this->_contentTypeT->createDocumentFragment();
            $tempNode->appendXML($strContentTypes);
            $this->_contentTypeT->documentElement->appendChild($tempNode);
        }
    }

    /**
     * Generate OVERRIDE
     *
     * @access protected
     * @param string $partName
     * @param string $contentType
     */
    protected function generateOVERRIDE($partName, $contentType)
    {
        $strContent = $this->_contentTypeT->saveXML();
        if (
                strpos($strContent, 'PartName="' . $partName . '"') === false
        ) {
            $strContentTypes = '<Override PartName="' . $partName . '" ContentType="' . $contentType . '" />';
            $tempNode = $this->_contentTypeT->createDocumentFragment();
            $tempNode->appendXML($strContentTypes);
            $this->_contentTypeT->documentElement->appendChild($tempNode);
        }
    }

    /**
     * Generate RELATIONSHIP
     *
     * @access protected
     */
    protected function generateRELATIONSHIP()
    {
        $arrArgs = func_get_args();

        if ($arrArgs[1] == 'vbaProject') {
            $type = 'http://schemas.microsoft.com/office/2006/relationships/vbaProject';
        } else {
            $type = 'http://schemas.openxmlformats.org/officeDocument/2006/' .
                    'relationships/' . $arrArgs[1];
        }

        if (!isset($arrArgs[3])) {
            $nodeWML = '<Relationship Id="' . $arrArgs[0] . '" Type="' . $type .
                    '" Target="' . $arrArgs[2] . '"></Relationship>';
        } else {
            $nodeWML = '<Relationship Id="' . $arrArgs[0] . '" Type="' . $type .
                    '" Target="' . $arrArgs[2] . '" ' . $arrArgs[3] .
                    '></Relationship>';
        }
        $relsNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
        $relsNode->appendXML($nodeWML);
        $this->_wordRelsDocumentRelsT->documentElement->appendChild($relsNode);
    }

    /**
     * Extracts a file from the template docx zip and returns it as an string or a DOMDocument/SimpleXMLElement object
     * 
     * @access protected
     * @param string $src the path of the file to be retrieved
     * @param string $type string, DOMDocument or SimpleXMLElement
     * @param \ZipArchive object $zip
     * $return mixed
     */
    protected function getFromZip($src, $type = 'string', $zip = '')
    {
        if ($zip == '') {
            $zip = $this->_zipDocx;
        } else if ($zip instanceof \ZipArchive) {
            // use $zip as the data source
        } else {
            PhpdocxLogger::logger('The private method getFromZip is trying to extract data from a non\ZipArchive object', 'fatal');
        }
        // extract the src contents from the zip

        $XMLData = $zip->getFromName($src);

        // return the data in the requested format
        if ($type == 'string') {
            return $XMLData;
        } else if ($type == 'DOMDocument') {
            if ($XMLData !== false) {
                $domDocument = new \DOMDocument();
                $domDocument->loadXML($XMLData);
                return $domDocument;
            } else {
                return false;
            }
        } else if ($type == 'SimpleXMLElement') {
            if ($XMLData !== false) {
                $simpleXML = simplexml_load_string($XMLData);
            } else {
                return false;
            }
        } else {
            PhpdocxLogger::logger('getFromZip: The chosen type is not recognized', 'fatal');
        }
    }
    
    /**
     * Gets all section nodes present in the docx
     *
     * @access protected
     * @param array $sectionNumbers
     * @return string
     */
    protected function getSectionNodes($sectionNumbers)
    {
        $sectNodes = array();
        // get all sectPr sections that may exist
        // within $this->_wordDocumentC
        $this->_tempDocumentDOM = $this->getDOMDocx();
        $sections = $this->_tempDocumentDOM->getElementsByTagName('sectPr');
        foreach ($sections as $section) {
            $sectNodes[] = $section;
        }
        $sectNodes[] = $this->_sectPr->documentElement;

        $finalSectNodes = array();
        if (empty($sectionNumbers)) {
            $finalSectNodes = $sectNodes;
        } else {
            foreach ($sectionNumbers as $key => $value) {
                if (isset($sectNodes[$value - 1])) {
                    $finalSectNodes[] = $sectNodes[$value - 1];
                }
            }
        }
        return $finalSectNodes;
    }
    
    /**
     * Modify the w:PageBorders sectPr property
     * 
     * @access protected
     * @param DOMNode $sectionNode
     * @param array $options 
     */
    protected function modifyPageBordersSectionProperty($sectionNode, $options)
    {
        // restart condition available types
        $display_types = array('allPages', 'firstPage', 'notFirstPage');
        $offset_types = array('page', 'text');
        $sides = array('top', 'left', 'bottom', 'right');
        $type = array('width' => 4, 'color' => '000000', 'style' => 'single', 'space' => 24);

        // set default values
        if (isset($options['zOrder'])) {
            $zOrder = $options['zOrder'];
        } else {
            $zOrder = 1000;
        }
        if (isset($options['display']) && in_array($options['display'], $display_types)) {
            $display = $options['display'];
        } else {
            $display = 'allPages';
        }
        if (isset($options['offsetFrom']) && in_array($options['offsetFrom'], $offset_types)) {
            $offsetFrom = $options['offsetFrom'];
        } else {
            $offsetFrom = 'page';
        }
        foreach ($type as $key => $value) {
            foreach ($sides as $side) {
                if (isset($options['border_' . $side . '_' . $key])) {
                    $opt['border_' . $side . '_' . $key] = $options['border_' . $side . '_' . $key];
                } else if (isset($options['border_' . $key])) {
                    $opt['border_' . $side . '_' . $key] = $options['border_' . $key];
                } else {
                    $opt['border_' . $side . '_' . $key] = $value;
                }
            }
        }

        // if there is any previous pgBorders tag remove it
        if ($sectionNode->getElementsByTagName('pgBorders')->length > 0) {
            $pgBorder = $sectionNode->getElementsByTagName('pgBorders')->item(0);
            $pgBorder->parentNode->removeChild($pgBorder);
        }
        // insert the requested page borders
        $pgBordersNode = $sectionNode->ownerDocument->createDocumentFragment();
        $strNode = '<w:pgBorders ';
        $strNode .= 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" ';
        $strNode .= 'w:zOrder="' . $zOrder . '" w:display="' . $display . '" w:offsetFrom="' . $offsetFrom . '" >';
        foreach ($sides as $side) {
            $strNode .='<w:' . $side . ' w:val="' . $opt['border_' . $side . '_style'] . '" ';
            $strNode .= 'w:color="' . $opt['border_' . $side . '_color'] . '" ';
            $strNode .= 'w:sz="' . $opt['border_' . $side . '_width'] . '" ';
            $strNode .= 'w:space="' . $opt['border_' . $side . '_space'] . '" />';
        }
        $strNode .= '</w:pgBorders>';
        $pgBordersNode->appendXML($strNode);

        $propIndex = array_search('w:pgBorders', OOXMLResources::$sectionProperties);
        $childNodes = $sectionNode->childNodes;
        $index = false;
        foreach ($childNodes as $node) {
            $index = array_search($node->nodeName, OOXMLResources::$sectionProperties);
            if ($index > $propIndex) {
                $node->parentNode->insertBefore($pgBordersNode, $node);
                break;
            }
        }
        // in case no node was found we should append the node
        if (!$index) {
            $sectionNode->appendChild($pgBordersNode);
        }
    }
    
    /**
     * Recovers as a well formatted string the $_wordDocumentC variable
     *
     * @access protected
     */
    protected function restoreDocumentXML()
    {
        $stringDoc = $this->_tempDocumentDOM->saveXML();
        $bodyTag = explode('<w:body>', $stringDoc);
        if (isset($bodyTag[1])) {
            $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);
        }
    }

    /**
     * Inserts data in different format into the docx template zip
     * 
     * @access protected
     * @param mixed $src it can be a string, a DOMDocument object or a SimpleXMLElement object
     * @param string $target  path for the created file
     * @param \ZipArchive object $zip
     * $return mixed
     */
    protected function saveToZip($src, $target, &$zip = '')
    {
        if ($zip == '') {
            $zip = $this->_zipDocx;
        } else if ($zip instanceof \ZipArchive) {
            // use $zip as the data source
        } else {
            PhpdocxLogger::logger('saveToZip: trying to insert data into a non\ZipArchive object', 'fatal');
        }
        if (!is_object($src) && @is_file($src)) {
            // insert file into the zip
            try {
                $inserted = $zip->addFile($src, $target);
                if ($inserted === false) {
                    throw new Exception('Error while inserting the ' . $target . 'into the zip');
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }
        } else {
            if (is_string($src)) {
                $XMLData = $src;
            } else if ($src instanceof \DOMDocument) {
                $XMLData = $src->saveXML();
            } else if ($src instanceof \SimpleXMLElement) {
                $XMLData = $src->asXML();
            } else {
                $XMLData = $src;
                //PhpdocxLogger::logger('saveToZip: invalid data source', 'fatal');
            }
            // insert the data into the zip
            try {
                $inserted = $zip->addFromString($target, $XMLData);
                if ($inserted === false) {
                    throw new \Exception('Error while inserting the ' . $target . 'into the zip');
                }
            } catch (\Exception $e) {
                PhpdocxLogger::logger($e->getMessage(), 'fatal');
            }
        }
    }

    /**
     * Clean template
     *
     * @access private
     */
    private function cleanTemplate()
    {
        PhpdocxLogger::logger('Remove existing template tags.', 'debug');
        $this->_wordDocumentT = preg_replace(
                '/__[A-Z]+__/', '', $this->_wordDocumentT
        );
    }

    /**
     * Modify/create the rels files for footnotes, endnotes and comments
     * @param string $type can be footnote, endnote or comment
     * @access private
     */
    private function generateRelsNotes($type)
    {
        if ($type == 'footnote') {
            $relsDOM = $this->_wordFootnotesRelsT;
        } else if ($type == 'endnote') {
            $relsDOM = $this->_wordEndnotesRelsT;
        } else if ($type == 'comment') {
            $relsDOM = $this->_wordCommentsRelsT;
        } else {
            PhpdocxLogger::logger('Wrong note type', 'fatal');
        }
        if (!empty(CreateDocx::$_relsNotesImage[$type])) {
            foreach (CreateDocx::$_relsNotesImage[$type] as $key => $value) {
                if (empty($value['name'])) {
                    $value['name'] = $value['rId'];
                }
                $nodeWML = '<Relationship Id="' . $value['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $value['name'] . '.' . $value['extension'] . '" ></Relationship>';
                $relsNode = $relsDOM->createDocumentFragment();
                $relsNode->appendXML($nodeWML);
                $relsDOM->documentElement->appendChild($relsNode);
            }
        }
        if (!empty(CreateDocx::$_relsNotesExternalImage[$type])) {
            foreach (CreateDocx::$_relsNotesExternalImage[$type] as $key => $value) {
                $nodeWML = '<Relationship Id="' . $value['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' . $value['url'] . '" TargetMode="External" ></Relationship>';
                $relsNode = $relsDOM->createDocumentFragment();
                $relsNode->appendXML($nodeWML);
                $relsDOM->documentElement->appendChild($relsNode);
            }
        }
        if (!empty(CreateDocx::$_relsNotesLink[$type])) {
            foreach (CreateDocx::$_relsNotesLink[$type] as $key => $value) {
                $nodeWML = '<Relationship Id="' . $value['rId'] . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="' . $value['url'] . '" TargetMode="External" ></Relationship>';
                $relsNode = $relsDOM->createDocumentFragment();
                $relsNode->appendXML($nodeWML);
                $relsDOM->documentElement->appendChild($relsNode);
            }
        }

        if ($type == 'footnote') {
            $this->_wordFootnotesRelsT = $relsDOM;
        } else if ($type == 'endnote') {
            $this->_wordEndnotesRelsT = $relsDOM;
        } else if ($type == 'comment') {
            $this->_wordCommentsRelsT = $relsDOM;
        }
    }

    /**
     * Generate SECTPR
     *
     * @access private
     * @param array $args Section style
     */
    private function generateSECTPR($args = '')
    {
        $page = CreatePage::getInstance();
        $page->createSECTPR($args);
        $this->_wordDocumentC .= (string) $page;
    }

    /**
     * Generates an element in settings.xml
     *
     * @access private
     */
    private function generateSetting($tag)
    {
        if ((!in_array($tag, OOXMLResources::$settings))) {
            PhpdocxLogger::logger('Incorrect setting tag', 'fatal');
        }
        $settingIndex = array_search($tag, OOXMLResources::$settings);
        $selectedElements = $this->_wordSettingsT->documentElement->getElementsByTagName($tag);
        if ($selectedElements->length == 0) {
            $settingsElement = $this->_wordSettingsT->createDocumentFragment();
            $settingsElement->appendXML('<' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" />');
            $childNodes = $this->_wordSettingsT->documentElement->childNodes;
            $index = false;
            foreach ($childNodes as $node) {
                $index = array_search($node->nodeName, OOXMLResources::$settings);
                if ($index > $settingIndex) {
                    $node->parentNode->insertBefore($settingsElement, $node);
                    break;
                }
            }
            // in case no node was found (pretty unlikely)we should append the node
            if (!$index) {
                $this->_wordSettingsT->documentElement->appendChild($settingsElement);
            }
        }
    }

    /**
     * Generate WordDocument XML template
     *
     * @access private
     */
    private function generateTemplateWordDocument()
    {
        if (count(CreateDocx::$insertNameSpaces) > 0) {
            $strxmlns = '';
            foreach (CreateDocx::$insertNameSpaces as $key => $value) {
                $strxmlns .= $key . '="' . $value . '" ';
            }
            $this->_documentXMLElement = str_replace('<w:document', '<w:document ' . $strxmlns, $this->_documentXMLElement);
        }
        $this->_wordDocumentC .= $this->_sectPr->saveXML($this->_sectPr->documentElement); //FIXME: I am insertying by hand the sections of the base template
        if (!empty($this->_wordHeaderC)) {
            $this->_wordDocumentC = str_replace(
                    '__GENERATEHEADERREFERENCE__', '<' . CreateDocx::NAMESPACEWORD . ':headerReference ' .
                    CreateDocx::NAMESPACEWORD . ':type="default" r:id="rId' .
                    $this->_idWords['header'] . '"></' .
                    CreateDocx::NAMESPACEWORD . ':headerReference>', $this->_wordDocumentC
            );
        }
        if (!empty($this->_wordFooterC)) {
            $this->_wordDocumentC = str_replace(
                    '__GENERATEFOOTERREFERENCE__', '<' . CreateDocx::NAMESPACEWORD . ':footerReference ' .
                    CreateDocx::NAMESPACEWORD . ':type="default" r:id="rId' .
                    $this->_idWords['footer'] . '"></' .
                    CreateDocx::NAMESPACEWORD . ':footerReference>', $this->_wordDocumentC
            );
        }
        $this->_wordDocumentT = $this->_documentXMLElement .
                $this->_background .
                '<' . CreateDocx::NAMESPACEWORD . ':body>' .
                $this->_wordDocumentC .
                '</' . CreateDocx::NAMESPACEWORD . ':body>' .
                '</' . CreateDocx::NAMESPACEWORD . ':document>';
        $this->cleanTemplate();
    }

    /**
     * Generates a TitlePg element in SectPr
     *
     * @access private
     * @param boolean $extraSections if true there is more than one section
     */
    private function generateTitlePg($extraSections)
    {
        if ($extraSections) {
            $domDocument = $this->getDOMDocx();
            $sections = $domDocument->getElementsByTagName('sectPr');
            $firstSection = $sections->item(0);
            $foundNodes = $firstSection->getElementsByTagName('TitlePg');
            if ($foundNodes->length == 0) {
                $newSectNode = '<w:titlePg xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" />';
                $sectNode = $domDocument->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $firstSection->appendChild($sectNode);
            } else {
                $foundNodes->item(0)->setAttribute('val', 1);
            }
            $stringDoc = $domDocument->saveXML();
            $bodyTag = explode('<w:body>', $stringDoc);
            $this->_wordDocumentC = str_replace('</w:body></w:document>', '', $bodyTag[1]);
        } else {

            $foundNodes = $this->_sectPr->documentElement->getElementsByTagName('TitlePg');
            if ($foundNodes->length == 0) {
                $newSectNode = '<w:titlePg xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" />';
                $sectNode = $this->_sectPr->createDocumentFragment();
                $sectNode->appendXML($newSectNode);
                $refNode = $this->_sectPr->documentElement->appendChild($sectNode);
            } else {
                $foundNodes->item(0)->setAttribute('val', 1);
            }
        }
    }

    /**
     * Takes care of the links and images asociated with an HTML chunck processed
     * by the embedHTML 
     *
     * @access private
     * @param array $sFinalDocX an arry with the required link and image data
     */
    private function HTMLRels($sFinalDocX, $options)
    {
        $relsLinks = '';
        if ($options['target'] == 'defaultHeader' ||
                $options['target'] == 'firstHeader' ||
                $options['target'] == 'evenHeader' ||
                $options['target'] == 'defaultFooter' ||
                $options['target'] == 'firstFooter' ||
                $options['target'] == 'evenFooter') {
            foreach ($sFinalDocX[1] as $key => $value) {
                CreateDocx::$_relsHeaderFooterLink[$options['target']][] = array('rId' => $key, 'url' => $value);
            }
        } else if ($options['target'] == 'footnote' ||
                $options['target'] == 'endnote' ||
                $options['target'] == 'comment') {
            foreach ($sFinalDocX[1] as $key => $value) {
                CreateDocx::$_relsNotesLink[$options['target']][] = array('rId' => $key, 'url' => $value);
            }
        } else {
            foreach ($sFinalDocX[1] as $key => $value) {
                $relsLinks .= '<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="' . $value . '" TargetMode="External" />';
            }
            if ($relsLinks != '') {
                $relsNode = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $relsNode->appendXML($relsLinks);
                $this->_wordRelsDocumentRelsT->documentElement->appendChild($relsNode);
            }
        }

        $relsImages = '';

        if ($options['target'] == 'defaultHeader' ||
                $options['target'] == 'firstHeader' ||
                $options['target'] == 'evenHeader' ||
                $options['target'] == 'defaultFooter' ||
                $options['target'] == 'firstFooter' ||
                $options['target'] == 'evenFooter') {
            foreach ($sFinalDocX[2] as $key => $value) {
                // remove the first three 'rId' characters in this case
                $value = array_shift(explode('?', $value));
                if (isset($options['downloadImages']) && $options['downloadImages']) {
                    $arrayExtension = explode('.', $value);
                    $extension = strtolower(array_pop($arrayExtension));
                    $predefinedExtensions = array('gif', 'png', 'jpg', 'jpeg', 'bmp');
                    if (!in_array($extension, $predefinedExtensions)) {
                        $this->generateDEFAULT($extension, 'image/' . $extension);
                    }

                    createDocx::$_relsHeaderFooterImage[$options['target']][] = array('rId' => $key, 'extension' => $extension);
                } else {
                    createDocx::$_relsHeaderFooterExternalImage[$options['target']][] = array('rId' => $key, 'url' => $value);
                }
            }
        } else if ($options['target'] == 'footnote' ||
                $options['target'] == 'endnote' ||
                $options['target'] == 'comment') {
            foreach ($sFinalDocX[2] as $key => $value) {
                // remove the first three 'rId' characters in this case
                $value = array_shift(explode('?', $value));
                if (isset($options['downloadImages']) && $options['downloadImages']) {
                    $arrayExtension = explode('.', $value);
                    $extension = strtolower(array_pop($arrayExtension));
                    $predefinedExtensions = array('gif', 'png', 'jpg', 'jpeg', 'bmp');
                    if (!in_array($extension, $predefinedExtensions)) {
                        $this->generateDEFAULT($extension, 'image/' . $extension);
                    }

                    CreateDocx::$_relsNotesImage[$options['target']][] = array('rId' => $key, 'extension' => $extension);
                } else {
                    CreateDocx::$_relsNotesExternalImage[$options['target']][] = array('rId' => $key, 'url' => $value);
                }
            }
        } else {
            foreach ($sFinalDocX[2] as $key => $value) {
                $valueArray = explode('?', $value);
                $value = array_shift($valueArray);
                if (isset($options['downloadImages']) && $options['downloadImages']) {
                    $arrayExtension = explode('.', $value);
                    $extension = strtolower(array_pop($arrayExtension));
                    $predefinedExtensions = array('gif', 'png', 'jpg', 'jpeg', 'bmp');
                    if (!in_array($extension, $predefinedExtensions)) {
                        $this->generateDEFAULT($extension, 'image/' . $extension);
                    }
                    $relsImages .= '<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/img' . $key . '.' . $extension . '" />';
                } else {
                    $relsImages .= '<Relationship Id="' . $key . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="' . $value . '" TargetMode="External" />';
                }
            }

            if ($relsImages != '') {
                $relsNodeImages = $this->_wordRelsDocumentRelsT->createDocumentFragment();
                $relsNodeImages->appendXML($relsImages);
                $this->_wordRelsDocumentRelsT->documentElement->appendChild($relsNodeImages);
            }
        }
    }
    
    /**
     * Modify a single sectPr property with no XML childs
     * 
     * @access private
     * @param DOMNode $sectionNode
     * @param string $tag name of the property we want to modify
     * @param array $options the corresponding attribute values
     */
    private function modifySingleSectionProperty($sectionNode, $tag, $options, $nameSpace = 'w')
    {
        if ($sectionNode->getElementsByTagName($tag)->length > 0) {
            // node exists
            $node = $sectionNode->getElementsByTagName($tag);
            foreach ($options as $key => $value) {
                $node->item(0)->setAttribute($nameSpace . ':' . $key, $value);
            }
        } else {
            // otherwise create it
            $newNode = $sectionNode->ownerDocument->createDocumentFragment();
            $strNode = '<' . $nameSpace . ':' . $tag . ' ';
            foreach ($options as $key => $value) {
                $strNode .= $nameSpace . ':' . $key . '="' . $value . '" ';
            }
            if ($nameSpace == 'w') {
                $strNode .=' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" ';
            }
            $strNode .='/>';
            $newNode->appendXML($strNode);

            $propIndex = array_search($nameSpace . ':' . $tag, OOXMLResources::$sectionProperties);
            $childNodes = $sectionNode->childNodes;
            $index = false;
            foreach ($childNodes as $node) {
                $name = $node->nodeName;
                $index = array_search($node->nodeName, OOXMLResources::$sectionProperties);
                if ($index > $propIndex) {
                    $node->parentNode->insertBefore($newNode, $node);
                    break;
                }
            }
            // in case no node was found we should append the node
            if (!$index) {
                $sectionNode->appendChild($newNode);
            }
        }
    }
    
    /**
     * Parse path dir
     *
     * @access private
     * @param string $dir Directory path
     */
    private function parsePath($dir)
    {
        $slash = 0;
        $path = '';
        if (($slash = strrpos($dir, '/')) !== false) {
            $slash += 1;
            $path = substr($dir, 0, $slash);
        }
        $punto = strpos(substr($dir, $slash), '.');

        $nombre = substr($dir, $slash, $punto);
        $extension = substr($dir, $punto + $slash + 1);
        return array(
            'path' => $path, 'nombre' => $nombre, 'extension' => $extension
        );
    }
    
    /**
     * Parses a WordML fragment to be inserted as a footnote or endnote
     *
     * @access private
     * @param string $type it can be footnote, endnote or comment
     * @param WordFragment object $wordFragment
     * @param array $markOptions the note mark options
     * @param array $referenceOptions the note reference options
     * @return string
     */
    private function parseWordMLNote($type, $wordFragment, $markOptions = array(), $referenceOptions = array())
    {
        $referenceOptions = self::translateTextOptions2StandardFormat($referenceOptions);
        $referenceOptions = self::setRTLOptions($referenceOptions);

        $strFrag = (string) $wordFragment;
        $basePIni = '<w:p><w:pPr><w:pStyle w:val="' . $type . 'TextPHPDOCX"/>';
        if (isset($referenceOptions['bidi']) && $referenceOptions['bidi']) {
            $basePIni .= '<w:bidi />';
        }
        $basePIni .= '</w:pPr>';
        $run .= '<w:r><w:rPr><w:rStyle w:val="' . $type . 'ReferencePHPDOCX"/>';
        // parse the referenceMark options
        if (isset($referenceOptions['font'])) {
            $run .= '<w:rFonts w:ascii="' . $referenceOptions['font'] .
                    '" w:hAnsi="' . $referenceOptions['font'] .
                    '" w:cs="' . $referenceOptions['font'] . '"/>';
        }
        if (isset($referenceOptions['b'])) {
            $run .= '<w:b w:val="' . $referenceOptions['b'] . '"/>';
            $run .= '<w:bCs w:val="' . $referenceOptions['b'] . '"/>';
        }
        if (isset($referenceOptions['i'])) {
            $run .= '<w:i w:val="' . $referenceOptions['i'] . '"/>';
            $run .= '<w:iCs w:val="' . $referenceOptions['i'] . '"/>';
        }
        if (isset($referenceOptions['color'])) {
            $run .= '<w:color w:val="' . $referenceOptions['color'] . '"/>';
        }
        if (isset($referenceOptions['sz'])) {
            $run .= '<w:sz w:val="' . (2 * $referenceOptions['sz']) . '"/>';
            $run .= '<w:szCs w:val="' . (2 * $referenceOptions['sz']) . '"/>';
        }
        if (isset($referenceOptions['rtl']) && $referenceOptions['rtl']) {
            $basePIni .= '<w:rtl />';
        }
        $run .= '</w:rPr>';
        if (isset($markOptions['customMark'])) {
            $run .= '<w:t>' . $markOptions['customMark'] . '</w:t>';
        } else {
            if ($type != 'comment') {
                $run .= '<w:' . $type . 'Ref/>';
            }
        }
        $run .= '</w:r>';
        $basePEnd = '</w:p>';
        // check if the WordML fragment starts with a paragraph
        $startFrag = substr($strFrag, 0, 5);
        if ($startFrag == '<w:p>') {
            $strFrag = preg_replace('/<\/w:pPr>/', '</w:pPr>' . $run, $strFrag, 1);
        } else {
            $strFrag = $basePIni . $run . $basePEnd . $strFrag;
        }
        return $strFrag;
    }

    /**
     * Preprocess a docx for the addDOCX method
     * By the time being we only remove the w:nsid and w:tmpl nodes from the
     * numbering.xml file
     *
     * @param string $path path to file
     */
    private function preprocessDocx($pathDOCX)
    {
        PhpdocxLogger::logger('Preprocess a docx for embeding with the addDOCX method.', 'debug');
        try {
            $embedZip = new \ZipArchive();
            if ($embedZip->open($pathDOCX) === true) {
                // the docx was succesfully unzipped
            } else {
                throw new \Exception(
                'it was not posible to unzip the docx file.'
                );
            }
            $numberingXML = $embedZip->getFromName('word/numbering.xml');
            $numberingDOM = new \DOMDocument();
            $numberingDOM->loadXML($numberingXML);
            $numberingXPath = new \DOMXPath($numberingDOM);
            $numberingXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            // remove the w:nsid and w:tmpl elements to avoid conflicts
            $nsidQuery = '//w:nsid | //w:tmpl';
            $nsidNodes = $numberingXPath->query($nsidQuery);
            foreach ($nsidNodes as $node) {
                $node->parentNode->removeChild($node);
            }
            $newNumbering = $numberingDOM->saveXML();
            $embedZip->addFromString('word/numbering.xml', $newNumbering);
            $embedZip->close();
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
    }

    /**
     * Removes an element from settings.xml
     *
     * @access private
     */
    private function removeSetting($tag)
    {
        $settingsHeader = $this->_wordSettingsT->documentElement->getElementsByTagName($tag);
        if ($settingsHeader->length > 0) {
            $this->_wordSettingsT->documentElement->removeChild($settingsHeader->item(0));
        }
    }

}
