<?php
namespace Phpdocx\Utilities;
use Phpdocx\Create\CreateDocx;
use Phpdocx\Charts\CreateChartFactory;
use Phpdocx\Elements\WordMLFragment;
use Phpdocx\Resources\OOXMLResources;
/**
 * This class offers some utilities to work with existing Word (.docx) documents
 * Among another useful options, it allows for the merging of two docx with certain 
 * configuration options, the replacement and highlighting of text as well as removing selected contents,
 * adding and removing watermarks, replace chart variables and add WordML content at the end of an existing Word file.
 * 
 * @category   Phpdocx
 * @package    utilities
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */

class DocxUtilities
{

    /**
     *
     * @var string
     * @access private
     */
    private $_background;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_checkDocx;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_checkDocxDocumentDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_checkDocxDocumentXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_checkDocXpath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_commentsDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_commentsXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_commentsXPath;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_contentTypesXPath;

    /**
     *
     * @var array
     * @access private
     */
    private $_coreFiles;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_documentDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_documentXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_documentXPath;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_docx;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_docXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_endnotesDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_endnotesXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_endnotesXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstCommentsDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstContentTypesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstDocumentDOM;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_firstDocx;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxCommentsXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxContentTypesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxDocumentXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxEndnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxFootnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxNumberingXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxRelsXML;

    /**
     *
     * @var array
     * @access private
     */
    private $_firstDocxStructuralData;

    /**
     *
     * @var string
     * @access private
     */
    private $_firstDocxStylesXML;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstEndnotesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstFootnotesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstNumberingDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstRelsDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_firstStylesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_footnotesDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_footnotesXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_footnotesXPath;

    /**
     *
     * @var array
     * @access private
     */
    private $_headersAndFootersXML;

    /**
     *
     * @var array
     * @access private
     */
    private $_headersAndFootersDOM;

    /**
     *
     * @var array
     * @access private
     */
    private $_headersAndFootersXPath;

    /**
     *
     * @var array
     * @access private
     */
    private $_implicitRelationships;

    /**
     *
     * @var string
     * @access private
     */
    private $_newCommentsXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newContentTypesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newDocumentXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newDocumentXMLContents;

    /**
     *
     * @var string
     * @access private
     */
    private $_newEndnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newFootnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newNumberingXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newRelsXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_newStylesXML;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_relsDOM;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_relsXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondCommentsDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondContentTypesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondDocumentDOM;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_secondDocx;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxCommentsXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxContentTypesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxDocumentXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxEndnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxFootnotesXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxNumberingXML;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxRelsXML;

    /**
     *
     * @var array
     * @access private
     */
    private $_secondDocxStructuralData;

    /**
     *
     * @var string
     * @access private
     */
    private $_secondDocxStylesXML;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondEndnotesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondFootnotesDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondNumberingDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondRelsDOM;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_secondStylesDOM;

    /**
     *
     * @var array
     * @access private
     */
    private $_sectionHeaders;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_stylesDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_stylesXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_stylesXPath;

    /**
     *
     * @var array
     * @access private
     */
    private $_takenBookmarksIds;

    /**
     *
     * @var array
     * @access private
     */
    private $_takenNumberingsIds;

    /**
     *
     * @var array
     * @access private
     */
    private $_takenFootnotesIds;

    /**
     *
     * @var array
     * @access private
     */
    private $_takenEndnotesIds;

    /**
     *
     * @var array
     * @access private
     */
    private $_takenCommentsIds;

    /**
     *
     * @var ZipArchive
     * @access private
     */
    private $_watermarkDocx;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_watermarkDocxContentTypesDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_watermarkDocxContentTypesXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_watermarkContentTypesXPath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_watermarkDocxDocumentDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_watermarkDocxDocumentXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_watermarkDocXpath;

    /**
     *
     * @var DOMDocument
     * @access private
     */
    private $_watermarkDocxRelsDOM;

    /**
     *
     * @var string
     * @access private
     */
    private $_watermarkDocxRelsXML;

    /**
     *
     * @var DOMXPath
     * @access private
     */
    private $_watermarkRelsXPath;

    /**
     *
     * @var string
     * @access private
     */
    private $_wordMLChunk;

    /**
     * Class constructor
     */
    public function __construct()
    {
        
    }

    /**
     * Class destructor
     */
    public function __destruct()
    {
        
    }

    /**
     * This method allows to insert WordML content generated by PHPDocX at the end of an existing Word document
     * @access public
     * @param string $document path to the document
     * @param CreateDocx $docx PHPDocX document object
     * @param WordMLFragment $fragment WordML fragment to append to the document
     * @return void
     */
    public function addWordMLContent($document, $docx, $fragment)
    {
        if ($docx instanceof CreateDocx && $fragment instanceof WordMLFragment) {
            $newDocumentPath = $this->getTempDir() . '/' . uniqid(mt_rand(999, 9999));
            $mergeDocumentPath = str_replace('.docx', '_merge.docx', $document);
            $docx->addRawWordML($fragment);
            $docx->createDocx($newDocumentPath);
            $this->mergeDocx($document, $newDocumentPath . '.docx', $mergeDocumentPath, array('mergeType' => 1));
            unlink($newDocumentPath . '.docx');
        } else {
            exit('The PHPDocX document object or the WordMLFragment you have passed as an argument do not exist.');
        }
    }

    /**
     * This is the main class method that does all the needed manipulation to merge
     * two docx documents
     * @access public
     * @param string $firstDocument path to the first document
     * @param string $secondDocument path to the second document
     * @param string $finalDocument path to the final merged document
     * @param array $options, 
     * Values:
     * 'enforceSectionPageBreak' (bool) if true enforces a page section break between documents even if the section type is of the continuous type,
     * 'mergeType' (0,1) that correspond to preserving or not the sections of the merged document respectively, 
     * 'numbering' (continue, restart)that allows to restart, for example, the page numbering in the merged document ($secondDocument).
     * 'lineBreaks' (int): insert the number of line breaks indicated between the contents of the merging files
     * @return void
     */
    public function mergeDocx($firstDocument, $secondDocument, $finalDocument, $options)
    {
        // init the main variables
        if (!isset($options['enforceSectionPageBreak'])) {
            $options['enforceSectionPageBreak'] = false;
        }
        if (!isset($options['mergeType'])) {
            $options['mergeType'] = 0;
        }
        if (!isset($options['numbering'])) {
            $options['numbering'] = 'continue';
        }
        if (!isset($options['lineBreaks'])) {
            $options['lineBreaks'] = 0;
        }
        //We initialize the required variables        
        $this->_background = '';
        $this->_wordMLChunk = '';
        if (isset($options['lineBreaks']) && $options['lineBreaks'] > 0) {
            $this->_wordMLChunk = '<w:p xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">';
            for ($k = 0; $k < $options['lineBreaks'] - 1; $k++) {
                $this->_wordMLChunk .= '<w:r><w:br /></w:r>';
            }
            $this->_wordMLChunk .= '</w:p>';
        }
        $this->_implicitRelationships = array('numbering.xml',
            'footnotes.xml',
            'endnotes.xml',
            'comments.xml',
            'settings.xml',
            'webSettings.xml',
            'fontTable.xml',
            'theme/theme1.xml',
            'styles.xml',
            'stylesWithEffects.xml'
        );
        $this->_coreFiles = array('settings.xml',
            'webSettings.xml',
            'fontTable.xml',
            'theme/theme1.xml',
            'stylesWithEffects.xml'
        );
        //This is the required data regarding the documents to be merged
        $this->_firstDocx = new \ZipArchive();
        $this->_firstDocxDocumentXML = '';
        $this->_firstDocxRelsXML = '';
        $this->_firstDocxStylesXML = '';
        $this->_firstDocxNumberingXML = '';
        $this->_firstDocxFootnotesXML = '';
        $this->_firstDocxEndnotesXML = '';
        $this->_firstDocxCommentsXML = '';
        $this->_firstDocxContentTypesXML = '';
        $this->_firstCommentsDOM = new \DOMDocument();
        $this->_firstContentTypesDOM = new \DOMDocument();
        $this->_firstDocumentDOM = new \DOMDocument();
        $this->_firstEndnotesDOM = new \DOMDocument();
        $this->_firstFootnotesDOM = new \DOMDocument();
        $this->_firstNumberingDOM = new \DOMDocument();
        $this->_firstRelsDOM = new \DOMDocument();
        $this->_firstStylesDOM = new \DOMDocument();
        $this->_firstDocxStructuralData = array();

        $this->_secondDocx = new \ZipArchive();
        $this->_secondDocxDocumentXML = '';
        $this->_secondDocxRelsXML = '';
        $this->_secondDocxStylesXML = '';
        $this->_secondDocxNumberingXML = '';
        $this->_secondDocxFootnotesXML = '';
        $this->_secondDocxEndnotesXML = '';
        $this->_secondDocxCommentsXML = '';
        $this->_secondDocxContentTypesXML = '';
        $this->_secondCommentsDOM = new \DOMDocument();
        $this->_secondContentTypesDOM = new \DOMDocument();
        $this->_secondDocumentDOM = new \DOMDocument();
        $this->_secondEndnotesDOM = new \DOMDocument();
        $this->_secondFootnotesDOM = new \DOMDocument();
        $this->_secondNumberingDOM = new \DOMDocument();
        $this->_secondRelsDOM = new \DOMDocument();
        $this->_secondStylesDOM = new \DOMDocument();
        $this->_secondDocxStructuralData = array();

        $this->_newCommentsXML = '';
        $this->_newContentTypesXML = '';
        $this->_newDocumentXML = '';
        $this->_newDocumentXMLContents = '';
        $this->_newEndnotesXML = '';
        $this->_newFootnotesXML = '';
        $this->_newNumberingXML = '';
        $this->_newRelsXML = '';
        $this->_newStylesXML = '';


        $this->_takenBookmarksIds;
        $this->_takenNumberingsIds;
        $this->_takenFootnotesIds;
        $this->_takenEndnotesIds;
        $this->_takenCommentsIds;

        //we make a copy of the first document into its final destination so we do not overwrite it
        copy($firstDocument, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        //WARNING: it seems that there is a known bug with certain versions of the zipArchive PHP module
        //and .odt (OpenOffice) files. For workarounds look at: https://bugs.php.net/bug.php?id=48763
        $this->_firstDocx->open($finalDocument);

        $this->_firstDocxDocumentXML = $this->_firstDocx->getFromName('word/document.xml');
        $this->_firstDocxRelsXML = $this->_firstDocx->getFromName('word/_rels/document.xml.rels');
        $this->_firstDocxStylesXML = $this->_firstDocx->getFromName('word/styles.xml');
        $this->_firstDocxNumberingXML = $this->_firstDocx->getFromName('word/numbering.xml');
        $this->_firstDocxFootnotesXML = $this->_firstDocx->getFromName('word/footnotes.xml');
        $this->_firstDocxEndnotesXML = $this->_firstDocx->getFromName('word/endnotes.xml');
        $this->_firstDocxCommentsXML = $this->_firstDocx->getFromName('word/comments.xml');
        $this->_firstDocxContentTypesXML = $this->_firstDocx->getFromName('[Content_Types].xml');


        $this->_firstContentTypesDOM->loadXML($this->_firstDocxContentTypesXML);
        $this->_firstDocumentDOM->loadXML($this->_firstDocxDocumentXML);
        $this->_firstRelsDOM->loadXML($this->_firstDocxRelsXML);
        $this->_firstStylesDOM->loadXML($this->_firstDocxStylesXML);

        //we extract (some) of the relevant files of the second document for manipulation
        $this->_secondDocx->open($secondDocument);
        $this->_secondDocxDocumentXML = $this->_secondDocx->getFromName('word/document.xml');
        $this->_secondDocxRelsXML = $this->_secondDocx->getFromName('word/_rels/document.xml.rels');
        $this->_secondDocxStylesXML = $this->_secondDocx->getFromName('word/styles.xml');
        $this->_secondDocxNumberingXML = $this->_secondDocx->getFromName('word/numbering.xml');
        $this->_secondDocxFootnotesXML = $this->_secondDocx->getFromName('word/footnotes.xml');
        $this->_secondDocxEndnotesXML = $this->_secondDocx->getFromName('word/endnotes.xml');
        $this->_secondDocxCommentsXML = $this->_secondDocx->getFromName('word/comments.xml');
        $this->_secondDocxContentTypesXML = $this->_secondDocx->getFromName('[Content_Types].xml');


        $this->_secondContentTypesDOM->loadXML($this->_secondDocxContentTypesXML);
        $this->_secondDocumentDOM->loadXML($this->_secondDocxDocumentXML);
        $this->_secondRelsDOM->loadXML($this->_secondDocxRelsXML);
        $this->_secondStylesDOM->loadXML($this->_secondDocxStylesXML);

        //We prepare $this->_secondContentTypesDOM for XPath searches
        $this->_contentTypesXPath = new \DOMXPath($this->_secondContentTypesDOM);
        $this->_contentTypesXPath->registerNamespace('ct', 'http://schemas.openxmlformats.org/package/2006/content-types');
        //We prepare $this->_secondDocxDocumentXML for XPath searches
        $this->_docXPath = new \DOMXPath($this->_secondDocumentDOM);
        $this->_docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $this->_docXPath->registerNamespace('wp', 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing');
        $this->_docXPath->registerNamespace('a', 'http://schemas.openxmlformats.org/drawingml/2006/main');
        $this->_docXPath->registerNamespace('pic', 'http://schemas.openxmlformats.org/drawingml/2006/picture');
        $this->_docXPath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
        $this->_docXPath->registerNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');
        //We prepare $this->_secondDocxRelsXML for XPath searches
        $this->_relsXPath = new \DOMXPath($this->_secondRelsDOM);
        $this->_relsXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');

        //Let us now get all structural data associated with both files to be merged        
        $this->_firstDocxStructuralData = $this->getDocxStructuralData($this->_firstDocumentDOM, $this->_firstRelsDOM, $this->_firstContentTypesDOM, false);
        $this->_secondDocxStructuralData = $this->getDocxStructuralData($this->_secondDocumentDOM, $this->_secondRelsDOM, $this->_secondContentTypesDOM, true);
        $this->_newDocumentXMLContents = $this->mergeDocuments($this->_firstDocxStructuralData, $this->_secondDocxStructuralData, $options);
        //we should wrap the results within the <document><body> tags
        //Let us first check if there is any background image in the first document
        $backgroundNodes = $this->_firstDocumentDOM->getElementsByTagName('background');
        if ($backgroundNodes->length > 0) {
            $backgroundNode = $backgroundNodes->item(0);
            $this->_background = $backgroundNode->ownerDocument->saveXML($backgroundNode);
        }
        //Now we may finally build the complete new document.xml
        $this->_newDocumentXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
                                    <w:document 
                                    xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" 
                                    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                    xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" 
                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                    xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" 
                                    xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" 
                                    xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" 
                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" 
                                    xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
                                    mc:Ignorable="w14 wp14" >';

        $this->_newDocumentXML .= $this->_background . '<w:body>' . $this->_newDocumentXMLContents . '</w:body></w:document>';

        //We insert the new document.xml in the merged docx
        $this->_firstDocx->addFromString('word/document.xml', $this->_newDocumentXML);

        //Images
        //we should copy the images of the merged docx
        for ($j = 1; $j <= count($this->_secondDocxStructuralData['images']); $j++) {
            foreach ($this->_secondDocxStructuralData['images'][$j] as $key => $value) {
                $tempImage = $this->_secondDocx->getFromName('word/' . $value['path']);
                $this->_firstDocx->addFromString('word/' . $value['newPath'], $tempImage);
            }
        }

        //Charts
        for ($j = 1; $j <= count($this->_secondDocxStructuralData['charts']); $j++) {
            foreach ($this->_secondDocxStructuralData['charts'][$j] as $key => $value) {
                //Now we should get and parse the corresponding charts rel files
                $chartNameArray = explode('/', $value['path']);
                $chartName = array_pop($chartNameArray);
                $chartRels = $this->_secondDocx->getFromName('word/charts/_rels/' . $chartName . '.rels');
                $chartRelsDOM = new \DOMDocument();
                $chartRelsDOM->loadXML($chartRels);
                $xlsxNode = $chartRelsDOM->documentElement->firstChild;
                $xlsxId = $xlsxNode->getAttribute('Id');
                $xlsxTarget = $xlsxNode->getAttribute('Target');
                //we get the original name of the xlsx file
                $xlsxNameArray = explode('/', $xlsxTarget);
                $xlsxName = array_pop($xlsxNameArray);
                $xlsxNewName = 'spreadsheet' . $value['newId'];
                $xlsxNode->setAttribute('Id', $value['newId']);
                $xlsxNode->setAttribute('Target', '../embeddings/' . $xlsxNewName . '.xlsx');
                //We also have to change the attribute r:id of the chart xml file
                $chartXML = $this->_secondDocx->getFromName('word/charts/' . $chartName);
                $chartDOM = new \DOMDocument();
                $chartDOM->loadXML($chartXML);
                $externalData = $chartDOM->getElementsByTagName('externalData')->item(0);
                $externalData->setAttribute('r:id', $value['newId']);

                //we start to insert the required files             
                $this->_firstDocx->addFromString('word/' . $value['newPath'], $chartDOM->saveXML());
                //Now we add the corresponding rels file
                $this->_firstDocx->addFromString('word/charts/_rels/' . $value['newName'] . '.rels', $chartRelsDOM->saveXML());
                //and the corresponding excel in the embeddings folder
                $tempChart = $this->_secondDocx->getFromName('word/embeddings/' . $xlsxName);
                $this->_firstDocx->addFromString('word/embeddings/' . $xlsxNewName . '.xlsx', $tempChart);
            }
        }

        //Numberings
        if ($this->checkData($this->_secondDocxStructuralData['numberings']) > 0) {
            if ($this->_firstDocxNumberingXML === false) {
                $this->_firstDocxNumberingXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                                <w:numbering xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                                </w:numbering>';
            }
            //We load the numberings into the DOM
            $this->_firstNumberingDOM->loadXML($this->_firstDocxNumberingXML);
            $this->_secondNumberingDOM->loadXML($this->_secondDocxNumberingXML);
            $this->newNumberingXML = $this->mergeNumberings($this->_firstNumberingDOM, $this->_secondNumberingDOM, $this->_secondDocxStructuralData['numberings']);
            $this->_firstDocx->addFromString('word/numbering.xml', $this->newNumberingXML);
            //In case there is no numberings.xml file in the original document we should change the Id of the merged
            //rels file for numbering
            $query = '//rels:Relationship[@Target="numbering.xml"]';
            $affectedNodes = $this->_relsXPath->query($query);
            $nodeToBeChanged = $affectedNodes->item(0);
            $nodeToBeChanged->setAttribute('Id', uniqid('rId' . mt_rand(999, 9999)));
        }

        //footnotes and endnotes
        if ($this->checkData($this->_secondDocxStructuralData['footnotes']) > 0 ||
                $this->checkData($this->_secondDocxStructuralData['footnotes']) > 0) {

            if ($this->_firstDocxFootnotesXML === false) {
                $this->_firstDocxFootnotesXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                                <w:footnotes xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                                <w:footnote w:type="separator" w:id="-1">
                                                <w:p w:rsidR="00B43F5E" w:rsidRDefault="00B43F5E" w:rsidP="00B43F5E">
                                                <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                <w:separator/>
                                                </w:r>
                                                </w:p>
                                                </w:footnote>
                                                <w:footnote w:type="continuationSeparator" w:id="0">
                                                <w:p w:rsidR="00B43F5E" w:rsidRDefault="00B43F5E" w:rsidP="00B43F5E">
                                                <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                <w:continuationSeparator/>
                                                </w:r>
                                                </w:p>
                                                </w:footnote>
                                                </w:footnotes>';
            }
            if ($this->_firstDocxEndnotesXML === false) {
                $this->_firstDocxEndnotesXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                                <w:endnotes xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                                <w:endnote w:type="separator" w:id="-1">
                                                <w:p w:rsidR="00B43F5E" w:rsidRDefault="00B43F5E" w:rsidP="00B43F5E">
                                                <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                <w:separator/>
                                                </w:r>
                                                </w:p>
                                                </w:endnote>
                                                <w:endnote w:type="continuationSeparator" w:id="0">
                                                <w:p w:rsidR="00B43F5E" w:rsidRDefault="00B43F5E" w:rsidP="00B43F5E">
                                                <w:pPr>
                                                <w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
                                                </w:pPr>
                                                <w:r>
                                                <w:continuationSeparator/>
                                                </w:r>
                                                </w:p>
                                                </w:endnote>
                                                </w:endnotes>';
            }
            //We now load the footnotes and endnotes in the DOM
            $this->_firstEndnotesDOM->loadXML($this->_firstDocxEndnotesXML);
            $this->_firstFootnotesDOM->loadXML($this->_firstDocxFootnotesXML);
            $this->_secondEndnotesDOM->loadXML($this->_secondDocxEndnotesXML);
            $this->_secondFootnotesDOM->loadXML($this->_secondDocxFootnotesXML);
            //We now deal with the footnotes
            $this->_newFootnotesXML = $this->mergeFootnotes($this->_firstFootnotesDOM, $this->_secondFootnotesDOM, $this->_secondDocxStructuralData['footnotes']);
            $this->_firstDocx->addFromString('word/footnotes.xml', $this->_newFootnotesXML);
            //In case there is no footnotes.xml file in the original document we should change the Id of the merged
            //rels file for footnotes
            $query = '//rels:Relationship[@Target="footnotes.xml"]';
            $affectedNodes = $this->_relsXPath->query($query);
            $nodeToBeChanged = $affectedNodes->item(0);
            $nodeToBeChanged->setAttribute('Id', uniqid('rId' . mt_rand(999, 9999)));
            //We now deal with the endnotes
            $this->_newEndnotesXML = $this->mergeEndnotes($this->_firstEndnotesDOM, $this->_secondEndnotesDOM, $this->_secondDocxStructuralData['endnotes']);
            $this->_firstDocx->addFromString('word/endnotes.xml', $this->_newEndnotesXML);
            //In case there is no endnotes.xml file in the original document we should change the Id of the merged
            //rels file for endnotes
            $query = '//rels:Relationship[@Target="endnotes.xml"]';
            $affectedNodes = $this->_relsXPath->query($query);
            $nodeToBeChanged = $affectedNodes->item(0);
            $nodeToBeChanged->setAttribute('Id', uniqid('rId' . mt_rand(999, 9999)));
        }

        //comments
        if ($this->checkData($this->_secondDocxStructuralData['comments']) > 0) {
            if ($this->_firstDocxCommentsXML === false) {
                $this->_firstDocxCommentsXML = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                                            <w:comments xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                                    xmlns:o="urn:schemas-microsoft-com:office:office" 
                                                    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                                    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                                    xmlns:v="urn:schemas-microsoft-com:vml" 
                                                    xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                                    xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                                    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                                    xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                            </w:comments>';
            }
            //we now load the comments in the DOM
            $this->_firstCommentsDOM->loadXML($this->_firstDocxCommentsXML);
            $this->_secondCommentsDOM->loadXML($this->_secondDocxCommentsXML);
            $this->_newCommentsXML = $this->mergeComments($this->_firstCommentsDOM, $this->_secondCommentsDOM, $this->_secondDocxStructuralData['comments']);
            $this->_firstDocx->addFromString('word/comments.xml', $this->_newCommentsXML);
            //In case there is no comments.xml file in the original document we should change the Id of the merged
            //rels file for comments
            $query = '//rels:Relationship[@Target="comments.xml"]';
            $affectedNodes = $this->_relsXPath->query($query);
            $nodeToBeChanged = $affectedNodes->item(0);
            $nodeToBeChanged->setAttribute('Id', uniqid('rId' . mt_rand(999, 9999)));
        }

        //afChunks
        for ($j = 1; $j <= count($this->_secondDocxStructuralData['afChunks']); $j++) {
            foreach ($this->_secondDocxStructuralData['afChunks'][$j] as $key => $value) {
                $tempAfChunk = $this->_secondDocx->getFromName('word/' . $value['fileName']);
                $this->_firstDocx->addFromString('word/' . $value['newName'], $tempAfChunk);
            }
        }
        //We now should check if we have to insert the new headers and footers
        if ($options['mergeType'] == 0) {

            //headers
            for ($j = 1; $j <= count($this->_secondDocxStructuralData['headers']); $j++) {
                foreach ($this->_secondDocxStructuralData['headers'][$j] as $key => $value) {
                    $tempHeader = $this->_secondDocx->getFromName('word/' . $value['name']);
                    $this->_firstDocx->addFromString('word/' . $value['newName'], $tempHeader);
                    //we will check now if there is any rels file associated with that header		
                    $relsHeader = $this->_secondDocx->getFromName('word/_rels/' . $value['name'] . '.rels');
                    if ($relsHeader !== false) {
                        $relsHeaderDOM = new \DOMDocument();
                        $relsHeaderDOM->loadXML($relsHeader);
                        //Now we parse for photos
                        $relsHeaderXPath = new \DOMXPath($relsHeaderDOM);
                        $relsHeaderXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
                        $query = '//rels:Relationship[@Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"]';
                        $affectedNodes = $relsHeaderXPath->query($query);
                        foreach ($affectedNodes as $node) {
                            $imageName = $node->getAttribute('Target');
                            $imageExtensionArray = explode('.', $imageName);
                            $extension = array_pop($imageExtensionArray);
                            $imageNewName = 'media/image' . uniqid(mt_rand(999, 9999)) . '.' . $extension;
                            $node->setAttribute('Target', $imageNewName);
                            //let us now copy the image in the final document
                            $tempImage = $this->_secondDocx->getFromName('word/' . $imageName);
                            $this->_firstDocx->addFromString('word/' . $imageNewName, $tempImage);
                        }
                        //let us insert now the rels part in the final document
                        $newRelsHeader = $relsHeaderDOM->saveXML();
                        $this->_firstDocx->addFromString('word/_rels/' . $value['newName'] . '.rels', $newRelsHeader);
                    }
                }
            }

            //footers
            for ($j = 1; $j <= count($this->_secondDocxStructuralData['footers']); $j++) {
                foreach ($this->_secondDocxStructuralData['footers'][$j] as $key => $value) {
                    $tempFooter = $this->_secondDocx->getFromName('word/' . $value['name']);
                    $this->_firstDocx->addFromString('word/' . $value['newName'], $tempFooter);
                    //we will check now if there is any rels file associated with that footer		
                    $relsFooter = $this->_secondDocx->getFromName('word/_rels/' . $value['name'] . '.rels');
                    if ($relsFooter !== false) {
                        $relsFooterDOM = new \DOMDocument();
                        $relsFooterDOM->loadXML($relsFooter);
                        //Now we parse for photos
                        $relsFooterXPath = new \DOMXPath($relsFooterDOM);
                        $relsFooterXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
                        $query = '//rels:Relationship[@Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"]';
                        $affectedNodes = $relsFooterXPath->query($query);
                        foreach ($affectedNodes as $node) {
                            $imageName = $node->getAttribute('Target');
                            $imageExtensionArray = explode('.', $imageName);
                            $extension = array_pop($imageExtensionArray);
                            $imageNewName = 'media/image' . uniqid(mt_rand(999, 9999)) . '.' . $extension;
                            $node->setAttribute('Target', $imageNewName);
                            //let us now copy the image in the final document
                            $tempImage = $this->_secondDocx->getFromName('word/' . $imageName);
                            $this->_firstDocx->addFromString('word/' . $imageNewName, $tempImage);
                        }
                        //let us insert now the rels part in the final document
                        $newRelsFooter = $relsFooterDOM->saveXML();
                        $this->_firstDocx->addFromString('word/_rels/' . $value['newName'] . '.rels', $newRelsFooter);
                    }
                }
            }
        }



        //We merge the styles files
        $this->_newStylesXML = $this->mergeStyles($this->_firstStylesDOM, $this->_secondStylesDOM);
        $this->_firstDocx->addFromString('word/styles.xml', $this->_newStylesXML);

        //We merge the contentTypes files
        $this->_newContentTypesXML = $this->mergeContentTypes($this->_firstContentTypesDOM, $this->_secondContentTypesDOM);
        $this->_firstDocx->addFromString('[Content_Types].xml', $this->_newContentTypesXML);

        //We merge the rels files
        $this->_newRelsXML = $this->mergeRels($this->_firstRelsDOM, $this->_secondRelsDOM);
        $this->_firstDocx->addFromString('word/_rels/document.xml.rels', $this->_newRelsXML);

        //Now we should do a final verification regarding specific files contained in $this->_coreFiles 
        //that sometimes are missing if the document is generated from openOffice
        foreach ($this->_coreFiles as $key => $file) {
            if ($this->_firstDocx->getFromName('word/' . $file) === false) {
                $tempfile = $this->_secondDocx->getFromName('word/' . $file);
                if ($tempfile !== false) {
                    $this->_firstDocx->addFromString('word/' . $file, $tempfile);
                }
            }
        }

        //we finally close the zip file
        $this->_firstDocx->close();
    }

    /**
     * Modifies de general settings of an existing Word document
     *
     * @access public
     * @param string $source path to the original Word document
     * @param string $target path to the resulting Word document
     * @param array settings
     * Keys and values:
     * 'view' (string): none(default), print, outline, masterPages, normal (draft view), web
     * 'zoom'(mixed): a percentage or none, fullPage (display one full page), bestFit (display page width), textFit (display text width)
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
    public function modifyDocxSettings($source, $target, $settingParameters)
    {
        $settingParams = array(
            'view',
            'zoom',
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
        //we make a copy of the source document into its final destination so we do not overwrite it
        copy($source, $target);
        //we extract the relevant files for the watermarking process
        $docx = new \ZipArchive();
        $docx->open($target);
        $settingsXML = $docx->getFromName('word/settings.xml');
        $docxSetting = new \DOMDocument();
        $docxSetting->loadXML($settingsXML);
        foreach ($settingParameters as $tag => $value) {
            if ((!in_array($tag, $settingParams))) {
                PhpdocxLogger::logger('That setting tag is not supported', 'info');
            } else {
                $settingIndex = array_search('w:' . $tag, OOXMLResources::$settings);
                $selectedElements = $docxSetting->documentElement->getElementsByTagName($tag);
                if ($selectedElements->length == 0) {
                    $settingsElement = $docxSetting->createDocumentFragment();
                    if ($tag == 'zoom') {
                        if (is_integer($value)) {
                            $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:percent = "' . $value . '"/>');
                        } else {
                            $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val = "' . $value . '"/>');
                        }
                    } else {
                        $settingsElement->appendXML('<w:' . $tag . ' xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val = "' . $value . '"/>');
                    }
                    $childNodes = $docxSetting->documentElement->childNodes;
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
                        $docxSetting->documentElement->appendChild($settingsElement);
                    }
                } else {//that setting is already present
                    if ($tag == 'zoom') {
                        $selectedElements->item(0)->removeAttribute('w:val');
                        $selectedElements->item(0)->removeAttribute('w:percent');
                        if (is_integer($value)) {
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
        $newSettings = $docxSetting->saveXML();
        $docx->addFromString('word/settings.xml', $newSettings);
        $docx->close();
    }

    /**
     * This method retrieves the document properties of a given docx document
     * @access public
     * @param string $document path to the document we want to parse its properties
     * @return array
     */
    public function getDocxProperties($document)
    {
        $corePropList = array('cp:category' => 'Category',
            'cp:contentStatus' => 'ContentStatus',
            'dcterms:created' => 'Created',
            'dc:creator' => 'Creator',
            'dc:description' => 'Description',
            'dc:identifier' => 'Identifier',
            'cp:keywords' => 'Keywords',
            'dc:language' => 'Language',
            'cp:lastModifiedBy' => 'LastModifiedBy',
            'cp:lastPrinted' => 'LastPrinted',
            'dcterms:modified' => 'Modified',
            'cp:revision' => 'Revision',
            'dc:subject' => 'Subject',
            'dc:title' => 'Title',
            'cp:version' => 'Version');

        $appPropList = array('Manager' => 'Manager',
            'Company' => 'Company',
            'Pages' => 'Pages',
            'Words' => 'Words',
            'Characters' => 'Characters',
            'CharactersWithSpaces' => 'CharactersWithSpaces',
            'Lines' => 'Lines',
            'Paragraphs' => 'Paragraphs');

        $docx = new \ZipArchive();
        $docx->open($document);
        $properties = array();

        $coreProps = $docx->getFromName('docProps/core.xml');
        $appProps = $docx->getFromName('docProps/app.xml');
        $customProps = $docx->getFromName('docProps/custom.xml');

        if (!empty($coreProps)) {
            $properties['Core Properties'] = array();
            $coreDOM = new \DOMDocument();
            $coreDOM->loadXML($coreProps);
            foreach ($corePropList as $key => $value) {
                $tagArray = explode(':', $key);
                $tag = array_pop($tagArray);
                $nodes = $coreDOM->documentElement->getElementsByTagName($tag);
                if ($nodes->length > 0) {
                    $nodes->item(0)->ownerDocument->saveXML($nodes->item(0));
                    $properties['Core Properties'][$value] = $nodes->item(0)->nodeValue;
                }
            }
        }

        if (!empty($coreProps)) {
            $properties['Extended Properties'] = array();
            $appDOM = new \DOMDocument();
            $appDOM->loadXML($appProps);
            foreach ($appPropList as $key => $value) {
                $nodes = $appDOM->documentElement->getElementsByTagName($key);
                if ($nodes->length > 0) {
                    $nodes->item(0)->ownerDocument->saveXML($nodes->item(0));
                    $properties['Extended Properties'][$value] = $nodes->item(0)->nodeValue;
                }
            }
        }

        if (!empty($customProps)) {
            $properties['Custom Properties'] = array();
            $customDOM = new \DOMDocument();
            $customDOM->loadXML($customProps);
            $nodes = $customDOM->documentElement->getElementsByTagName('property');
            if ($nodes->length > 0) {
                foreach ($nodes as $node) {
                    $key = $node->getAttribute('name');
                    $value = $node->nodeValue;
                    $properties['Custom Properties'][$key] = $value;
                }
            }
        }

        return $properties;
    }

    /**
     * This is the method that extracts all the sttructural info of a given docx
     * @access public
     * @param DOMDocument $docDOM
     * @param DOMDocument $relsDOM
     * @param DOMDocument $contentTypesDOM
     * @param string $relabel this variable controls if we have to reset the ids of the relevant DOMDocuments
     * @return array
     */
    public function getDocxStructuralData($docDOM, $relsDOM, $contentTypesDOM, $relabel = false)
    {
        //Let us  now define some auxiliary variables
        $section = array();
        $sectionProperties = array();
        $images = array();
        $charts = array();
        $links = array();
        $bookmarks = array();
        $numberings = array();
        $headers = array();
        $footers = array();
        $footnotes = array();
        $endnotes = array();
        $comments = array();
        $afChunks = array();
        $parsedHeaders = array();
        $parsedFooters = array();

        $baseNode = $docDOM->getElementsByTagName('body')->item(0);
        $childNodes = $baseNode->childNodes;

        $j = 1;
        $section[$j] = new \DOMDocument();
        $sectionProperties[$j] = new \DOMDocument();
        $images[$j] = array();
        $charts[$j] = array();
        $links[$j] = array();
        $bookmarks[$j] = array();
        $numberings[$j] = array();
        $headers[$j] = array();
        $footers[$j] = array();
        $footnotes[$j] = array();
        $endnotes[$j] = array();
        $comments[$j] = array();
        $afChunks[$j] = array();


        foreach ($childNodes as $node) {
            if ($node->nodeName == 'w:sectPr') {
                $importedNode = $sectionProperties[$j]->importNode($node, true);
                $sectionProperties[$j]->appendChild($importedNode);
            } else {
                $importedNode = $section[$j]->importNode($node, true);
                $section[$j]->appendChild($importedNode);
                $sectionNodes = $section[$j]->getElementsByTagName('sectPr');
                if ($sectionNodes->length == 0) {
                    continue;
                } else {
                    $sectionNode = $sectionNodes->item(0);
                    $importedNode = $sectionProperties[$j]->importNode($sectionNode, true);
                    $sectionProperties[$j]->appendChild($importedNode);
                    $sectionNode->parentNode->removeChild($sectionNode);
                    $j++;
                    $section[$j] = new \DOMDocument();
                    $sectionProperties[$j] = new \DOMDocument();
                    //we now create the auxiliary arrays
                    $images[$j] = array();
                    $charts[$j] = array();
                    $links[$j] = array();
                    $bookmarks[$j] = array();
                    $numberings[$j] = array();
                    $headers[$j] = array();
                    $footers[$j] = array();
                    $footnotes[$j] = array();
                    $endnotes[$j] = array();
                    $comments[$j] = array();
                    $afChunks[$j] = array();
                }
            }
        }

        //We get the number of sections and we start the parsing

        $numSections = count($section);
        //We define an array to hold the main relationships
        $relsArray = array();
        $relationship = $relsDOM->documentElement;
        $relsNodes = $relationship->childNodes;
        //We feed the reslArray array
        foreach ($relsNodes as $node) {
            if ($node->nodeName == 'Relationship') {
                $relsArray[$node->getAttribute('Id')] = $node->getAttribute('Target');
            }
        }

        //Let us do the parsing by section
        //If the option relabel is set to true we will have to
        //regenerate all ids so there will be no clashes when performing the merging


        $contentTypesXPath = new \DOMXPath($contentTypesDOM);
        $contentTypesXPath->registerNamespace('ct', 'http://schemas.openxmlformats.org/package/2006/content-types');

        $relsXPath = new \DOMXPath($relsDOM);
        $relsXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');


        //Main content
        for ($k = 1; $k <= $numSections; $k++) {
            $docXPath = new \DOMXPath($section[$k]);
            $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $docXPath->registerNamespace('wp', 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing');
            $docXPath->registerNamespace('a', 'http://schemas.openxmlformats.org/drawingml/2006/main');
            $docXPath->registerNamespace('pic', 'http://schemas.openxmlformats.org/drawingml/2006/picture');
            $docXPath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            $docXPath->registerNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');
            $docXPath->registerNamespace('v', 'urn:schemas-microsoft-com:vml');
            $docXPath->registerNamespace('o', 'urn:schemas-microsoft-com:office:office');
            //we look for images
            //They can come in two flavors as a pic or as a shape
            //Let us first deal with the pic tag
            $queryImage = '//pic:blipFill/a:blip';
            $imageNodes = $docXPath->query($queryImage);
            //we have to take into account that images can be used more than once
            $originalIds = array();
            foreach ($imageNodes as $node) {
                $attr = $node->getAttribute('r:embed');
                $extArray = explode('.', $relsArray[$attr]);
                $extension = array_pop($extArray);
                if (key_exists($attr, $originalIds)) {
                    $myId = $originalIds[$attr];
                    $newId = 'rId' . $myId;
                } else {
                    $myId = uniqid(mt_rand(999, 9999));
                    $newId = 'rId' . $myId;
                    $originalIds[$attr] = $myId;
                }
                $newPath = 'media/image' . $myId . '.' . $extension;
                $images[$k][$attr] = array(
                    'path' => $relsArray[$attr],
                    'newPath' => $newPath,
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:embed', $newId);
                    //we now update the document.xml.rels file
                    $query = '//rels:Relationship[@Id="' . $attr . '"]';
                    $affectedNodes = $relsXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    if (is_object($nodeToBeChanged)) {
                        $nodeToBeChanged->setAttribute('Target', $images[$k][$attr]['newPath']);
                        $nodeToBeChanged->setAttribute('Id', $images[$k][$attr]['newId']);
                    }
                }
            }
            //And now with shape tag
            $queryImage = '//v:imagedata';
            $imageNodes = $docXPath->query($queryImage);
            //we have to take into account that images can be used more than once
            $imageShapeIds = array();
            foreach ($imageNodes as $node) {
                $attr = $node->getAttribute('r:id');
                $extArray = explode('.', $relsArray[$attr]);
                $extension = array_pop($extArray);
                if (key_exists($attr, $imageShapeIds)) {
                    $myId = $imageShapeIds[$attr];
                    $newId = 'rId' . $myId;
                } else {
                    $myId = uniqid(mt_rand(999, 9999));
                    $newId = 'rId' . $myId;
                    $imageShapeIds[$attr] = $myId;
                }
                $newPath = 'media/image' . $myId . '.' . $extension;
                $images[$k][$attr] = array(
                    'path' => $relsArray[$attr],
                    'newPath' => $newPath,
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we now update the document.xml.rels file
                    $query = '//rels:Relationship[@Id="' . $attr . '"]';
                    $affectedNodes = $relsXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    if (is_object($nodeToBeChanged)) {
                        $nodeToBeChanged->setAttribute('Target', $images[$k][$attr]['newPath']);
                        $nodeToBeChanged->setAttribute('Id', $images[$k][$attr]['newId']);
                    }
                    //Like by the time being we are not parsing de OLE objects we should remove the o:OLEObject tags that may go with the image
                    $siblings = $node->parentNode->parentNode->childNodes;
                    foreach ($siblings as $sibling) {
                        if ($sibling->nodeName == 'o:OLEObject') {
                            $sibling->parentNode->removeChild($sibling);
                        }
                    }
                }
            }
            //charts
            $queryChart = '//c:chart'; //We probably have to get some more things
            $chartNodes = $docXPath->query($queryChart);
            foreach ($chartNodes as $node) {
                $attr = $node->getAttribute('r:id');
                $myId = uniqid(mt_rand(999, 9999));
                $newId = 'rId' . $myId;
                $newPath = 'charts/chart' . $myId . '.xml';
                $charts[$k][$attr] = array(
                    'path' => $relsArray[$attr],
                    'newPath' => $newPath,
                    'newId' => $newId,
                    'newName' => 'chart' . $myId . '.xml'
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we now update the Content_Types xml file
                    $query = '//ct:Override[@PartName="/word/' . $charts[$k][$attr]['path'] . '"]';
                    $affectedNodes = $contentTypesXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    $nodeToBeChanged->setAttribute('PartName', '/word/' . $charts[$k][$attr]['newPath']);
                    //and now the rels file
                    $query = '//rels:Relationship[@Id="' . $attr . '"]';
                    $affectedNodes = $relsXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    $nodeToBeChanged->setAttribute('Target', $charts[$k][$attr]['newPath']);
                    $nodeToBeChanged->setAttribute('Id', $charts[$k][$attr]['newId']);
                }
            }

            //links
            $queryLink = '//w:hyperlink[not(@w:anchor)]';
            $linkNodes = $docXPath->query($queryLink);
            foreach ($linkNodes as $node) {
                $attr = $node->getAttribute('r:id');
                $myId = uniqid(mt_rand(999, 9999));
                $newId = 'rId' . $myId;
                $links[$k][$attr] = array(
                    'path' => $relsArray[$attr],
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we update the rels file
                    $query = '//rels:Relationship[@Id="' . $attr . '"]';
                    $affectedNodes = $relsXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    $nodeToBeChanged->setAttribute('Id', $links[$k][$attr]['newId']);
                }
            }

            //bookmarks
            $queryBookmark = '//w:bookmarkStart';
            $bookmarkNodes = $docXPath->query($queryBookmark);
            foreach ($bookmarkNodes as $node) {
                $attr = $node->getAttribute('w:id');
                $this->_takenBookmarksIds[] = $attr;
                $newId = $this->uniqueDecimal($this->_takenBookmarksIds);
                $bookmarks[$k][$attr] = array(
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('w:id', $newId);
                    //Now we have to set the w:id attribute of the corresponding bookmarkStop tag to the same new value
                    $queryBookmarkEnd = '//w:bookmarkEnd[@w:id = "' . $attr . '"]';
                    $affectedNodes = $docXPath->query($queryBookmarkEnd);
                    //sometimes bookmarks may start and finish in different sections
                    //The standard allows that so we should make sure that if the bookmarkEnd tag is not found the script does not throw any error
                    if ($affectedNodes->length > 0) {
                        $nodeToBeChanged = $affectedNodes->item(0);
                        $nodeToBeChanged->setAttribute('w:id', $bookmarks[$k][$attr]['newId']);
                    }
                }
            }
            //numberings
            $queryNumbering = '//w:numId';
            $numberingNodes = $docXPath->query($queryNumbering);
            foreach ($numberingNodes as $node) {
                $attr = $node->getAttribute('w:val');
                if (empty($numberings[$k][$attr])) {
                    $this->_takenNumberingsIds[] = $attr;
                    $numberings[$k][$attr] = $this->uniqueDecimal($this->_takenNumberingsIds);
                }
                if ($relabel) {
                    $node->setAttribute('w:val', $numberings[$k][$attr]);
                }
            }

            //footnotes
            $queryFootnote = '//w:footnoteReference';
            $footnoteNodes = $docXPath->query($queryFootnote);
            foreach ($footnoteNodes as $node) {
                $attr = $node->getAttribute('w:id');
                $this->_takenFootnotesIds[] = $attr;
                $footnotes[$k][$attr] = $this->uniqueDecimal($this->_takenFootnotesIds, 1000, 32761);
                if ($relabel) {
                    $node->setAttribute('w:id', $footnotes[$k][$attr]);
                }
            }

            //endnotes
            $queryEndnote = '//w:endnoteReference';
            $endnoteNodes = $docXPath->query($queryEndnote);
            foreach ($endnoteNodes as $node) {
                $attr = $node->getAttribute('w:id');
                $this->_takenEndnotesIds[] = $attr;
                $endnotes[$k][$attr] = $this->uniqueDecimal($this->_takenEndnotesIds, 1000, 32761);
                if ($relabel) {
                    $node->setAttribute('w:id', $endnotes[$k][$attr]);
                }
            }

            //comments
            $queryComment = '//w:commentReference';
            $commentNodes = $docXPath->query($queryComment);
            foreach ($commentNodes as $node) {
                $attr = $node->getAttribute('w:id');
                $this->_takenCommentsIds[] = $attr;
                $comments[$k][$attr] = $this->uniqueDecimal($this->_takenCommentsIds, 1000, 32761);
                if ($relabel) {
                    $node->setAttribute('w:id', $comments[$k][$attr]);
                    //Now we have to set the w:id attribute of the corresponding w:commentRangeStart and w:commentRangeEnd tag to the same new value
                    $queryCommentStart = '//w:commentRangeStart[@w:id = "' . $attr . '"]';
                    $affectedNodes = $docXPath->query($queryCommentStart);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    $nodeToBeChanged->setAttribute('w:id', $comments[$k][$attr]);
                    //and now the end of the comment
                    $queryCommentEnd = '//w:commentRangeEnd[@w:id = "' . $attr . '"]';
                    $affectedNodes = $docXPath->query($queryCommentEnd);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    $nodeToBeChanged->setAttribute('w:id', $comments[$k][$attr]);
                }
            }

            //afChunk
            $queryAfChunk = '//w:altChunk';
            $afChunkNodes = $docXPath->query($queryAfChunk);
            foreach ($afChunkNodes as $node) {
                $attr = $node->getAttribute('r:id');
                $myId = uniqid(mt_rand(999, 9999));
                $newId = 'altChunk' . $myId;
                $afChunks[$k][$attr] = array(
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we update the rels file
                    $query = '//rels:Relationship[@Id="' . $attr . '"]';
                    $affectedNodes = $relsXPath->query($query);
                    $nodeToBeChanged = $affectedNodes->item(0);
                    //we first get the name of the file that is being linked
                    $fileName = $nodeToBeChanged->getAttribute('Target');
                    $afChunks[$k][$attr]['fileName'] = $fileName;
                    //we create a new and unique name for the file
                    $fileNameArray = explode(".", $fileName);
                    $fileExtension = array_pop($fileNameArray);
                    $fileNewName = $newId . '.' . $fileExtension;
                    $afChunks[$k][$attr]['newName'] = $fileNewName;
                    //now we change the Id and Target attributes in the rels file
                    $nodeToBeChanged->setAttribute('Target', $afChunks[$k][$attr]['newName']);
                    $nodeToBeChanged->setAttribute('Id', $afChunks[$k][$attr]['newId']);
                }
            }

            //Now we are going to regenerate all the "extra and otherwise useless ids" used in images and charts
            if ($relabel) {
                $queryDocPr = '//wp:docPr';
                $docPrNodes = $docXPath->query($queryDocPr);
                foreach ($docPrNodes as $node) {
                    $decimalNumber = $this->uniqueDecimal();
                    $node->setAttribute('id', $decimalNumber);
                    $node->setAttribute('name', uniqid(mt_rand(999, 9999)));
                }
                $queryPic = '//pic:cNvPr';
                $picNodes = $docXPath->query($queryPic);
                foreach ($picNodes as $node) {
                    $decimalNumber = $this->uniqueDecimal();
                    $node->setAttribute('id', $decimalNumber);
                }
            }


            //Section properties

            $docXPath = new \DOMXPath($sectionProperties[$k]);
            $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $docXPath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            //headers
            $queryHeader = '//w:headerReference ';
            $headerNodes = $docXPath->query($queryHeader);
            foreach ($headerNodes as $node) {
                $attr = $node->getAttribute('r:id');
                //Check if that header has been already parsed before
                if (array_key_exists($attr, $parsedHeaders)) {
                    $myId = $parsedHeaders[$attr];
                } else {
                    $myId = uniqid(mt_rand(999, 9999));
                    $parsedHeaders[$attr] = $myId;
                }
                $newName = 'header' . $myId . '.xml';
                $newId = 'rId' . $myId;
                $headers[$k][$attr] = array(
                    'type' => $node->getAttribute('w:type'),
                    'name' => $relsArray[$attr],
                    'newName' => $newName,
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we now update the Content_Types xml file
                    $query = '//ct:Override[@PartName="/word/' . $headers[$k][$attr]['name'] . '"]';
                    $affectedNodes = $contentTypesXPath->query($query);
                    if ($affectedNodes->length > 0) {//This check is needed because this header can be called from more than one section
                        $nodeToBeChanged = $affectedNodes->item(0);
                        $nodeToBeChanged->setAttribute('PartName', '/word/' . $headers[$k][$attr]['newName']);
                        //we now update the document.xml.rels file
                        $query = '//rels:Relationship[@Id="' . $attr . '"]';
                        $affectedNodes = $relsXPath->query($query);
                        $nodeToBeChanged = $affectedNodes->item(0);
                        $nodeToBeChanged->setAttribute('Target', $headers[$k][$attr]['newName']);
                        $nodeToBeChanged->setAttribute('Id', $headers[$k][$attr]['newId']);
                    }
                }
            }
            //footers
            $queryFooter = '//w:footerReference ';
            $footerNodes = $docXPath->query($queryFooter);
            foreach ($footerNodes as $node) {
                $attr = $node->getAttribute('r:id');
                //Check if that footer has been already parsed before
                if (array_key_exists($attr, $parsedFooters)) {
                    $myId = $parsedFooters[$attr];
                } else {
                    $myId = uniqid(mt_rand(999, 9999));
                    $parsedFooters[$attr] = $myId;
                }
                $newName = 'footer' . $myId . '.xml';
                $newId = 'rId' . $myId;
                $footers[$k][$attr] = array(
                    'type' => $node->getAttribute('w:type'),
                    'name' => $relsArray[$attr],
                    'newName' => $newName,
                    'newId' => $newId
                );
                if ($relabel) {
                    $node->setAttribute('r:id', $newId);
                    //we now update the Content_Types xml file
                    $query = '//ct:Override[@PartName="/word/' . $footers[$k][$attr]['name'] . '"]';
                    $affectedNodes = $contentTypesXPath->query($query);
                    if ($affectedNodes->length > 0) {//This check is needed because this footer can be called from more than one section
                        $nodeToBeChanged = $affectedNodes->item(0);
                        $nodeToBeChanged->setAttribute('PartName', '/word/' . $footers[$k][$attr]['newName']);
                        //we now update the document.xml.rels file
                        $query = '//rels:Relationship[@Id="' . $attr . '"]';
                        $affectedNodes = $relsXPath->query($query);
                        $nodeToBeChanged = $affectedNodes->item(0);
                        $nodeToBeChanged->setAttribute('Target', $footers[$k][$attr]['newName']);
                        $nodeToBeChanged->setAttribute('Id', $footers[$k][$attr]['newId']);
                    }
                }
            }
        }
        $structure = array('section' => $section,
            'sectionProperties' => $sectionProperties,
            'images' => $images,
            'charts' => $charts,
            'links' => $links,
            'bookmarks' => $bookmarks,
            'numberings' => $numberings,
            'headers' => $headers,
            'footers' => $footers,
            'footnotes' => $footnotes,
            'endnotes' => $endnotes,
            'comments' => $comments,
            'afChunks' => $afChunks);
        return $structure;
    }

    /**
     * This is the method that does all the needed manipulation to search
     * and higlight text in a Word document
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     * @param string $searchTerm string to be searched and replaced
     * @param array $options
     * Values: document (boolean), endnotes (boolean), footnotes (boolean), comments (boolean)
     * headerAndFooters (boolean)
     * highlightColor ('black', 'blue', 'cyan', 'green', 'magenta', 'red', 'yellow', 
     * 'white', 'darkBlue', 'darkCyan',	'darkGreen', 'darkMagenta', 'darkRed', 'darkYellow', 'darkGray', 'lightGray', 'none')
     * @return void
     */
    public function searchAndHighlight($document, $finalDocument, $searchTerm, $options = array('highlightColor' => 'yellow', 'document' => true))
    {
        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_footnotesXML = '';
        $this->_endnotesXML = '';
        $this->_commentsXML = '';
        $this->_commentsDOM = new \DOMDocument();
        $this->_documentDOM = new \DOMDocument();
        $this->_endnotesDOM = new \DOMDocument();
        $this->_footnotesDOM = new \DOMDocument();
        $this->_relsDOM = new \DOMDocument();

        if (!isset($options['highlightColor'])) {
            $options['highlightColor'] = 'yellow';
        }

        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);

        if (isset($options['document']) && $options['document'] == true) {
            $this->_documentXML = $this->_docx->getFromName('word/document.xml');
            $this->_documentDOM->loadXML($this->_documentXML);
            //We prepare the document for XPath
            $this->_documentXPath = new \DOMXPath($this->_documentDOM);
            $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $this->searchToHighlight($this->_documentXPath, $searchTerm);
            $this->highlightDocx($this->_documentDOM, $options['highlightColor']);
            $newDocumentXML = $this->_documentDOM->saveXML();
            $this->_docx->addFromString('word/document.xml', $newDocumentXML);
        }
        if (isset($options['footnotes']) && $options['footnotes'] == true) {
            $this->_footnotesXML = $this->_docx->getFromName('word/footnotes.xml');
            if ($this->_footnotesXML !== false) {
                $this->_footnotesDOM->loadXML($this->_footnotesXML);
                //We prepare the document for XPath
                $this->_footnotesXPath = new \DOMXPath($this->_footnotesDOM);
                $this->_footnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToHighlight($this->_footnotesXPath, $searchTerm);
                $this->highlightDocx($this->_footnotesDOM, $options['highlightColor']);
                $newFootnotesXML = $this->_footnotesDOM->saveXML();
                $this->_docx->addFromString('word/footnotes.xml', $newFootnotesXML);
            }
        }
        if (isset($options['endnotes']) && $options['endnotes'] == true) {
            $this->_endnotesXML = $this->_docx->getFromName('word/endnotes.xml');
            if ($this->_endnotesXML !== false) {
                $this->_endnotesDOM->loadXML($this->_endnotesXML);
                //We prepare the document for XPath
                $this->_endnotesXPath = new \DOMXPath($this->_endnotesDOM);
                $this->_endnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToHighlight($this->_endnotesXPath, $searchTerm);
                $this->highlightDocx($this->_endnotesDOM, $options['highlightColor']);
                $newEndnotesXML = $this->_endnotesDOM->saveXML();
                $this->_docx->addFromString('word/endnotes.xml', $newEndnotesXML);
            }
        }
        if (isset($options['comments']) && $options['comments'] == true) {
            $this->_commentsXML = $this->_docx->getFromName('word/comments.xml');
            if ($this->_commentsXML !== false) {
                $this->_commentsDOM->loadXML($this->_commentsXML);
                //We prepare the document for XPath
                $this->_commentsXPath = new \DOMXPath($this->_commentsDOM);
                $this->_commentsXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToHighlight($this->_commentsXPath, $searchTerm);
                $this->highlightDocx($this->_commentsDOM, $options['highlightColor']);
                $newCommentsXML = $this->_commentsDOM->saveXML();
                $this->_docx->addFromString('word/comments.xml', $newCommentsXML);
            }
        }
        if (isset($options['headersAndFooters']) && $options['headersAndFooters'] == true) {
            $this->_relsXML = $this->_docx->getFromName('word/_rels/document.xml.rels');
            $this->_relsDOM->loadXML($this->_relsXML);
            $relsNodes = $this->_relsDOM->documentElement->childNodes;
            $headersAndFooters = array();
            foreach ($relsNodes as $node) {
                if ($node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer' ||
                        $node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/header') {
                    $headersAndFooters[] = $node->getAttribute('Target');
                }
            }
            $this->_headersAndFootersXML = array();
            $this->_headersAndFootersDOM = array();
            $this->_headersAndFootersXPath = array();
            for ($k = 0; $k < count($headersAndFooters); $k++) {
                $this->_headersAndFootersXML[$k] = $this->_docx->getFromName('word/' . $headersAndFooters[$k]);
                $this->_headersAndFootersDOM[$k] = new \DOMDocument();
                $this->_headersAndFootersDOM[$k]->loadXML($this->_headersAndFootersXML[$k]);
                //We prepare the document for XPath
                $this->_headersAndFootersXPath[$k] = new \DOMXPath($this->_headersAndFootersDOM[$k]);
                $this->_headersAndFootersXPath[$k]->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToHighlight($this->_headersAndFootersXPath[$k], $searchTerm);
                $this->highlightDocx($this->_headersAndFootersDOM[$k], $options['highlightColor']);
                $newXML = $this->_headersAndFootersDOM[$k]->saveXML();
                $this->_docx->addFromString('word/' . $headersAndFooters[$k], $newXML);
            }
        }


        $this->_docx->addFromString('word/document.xml', $newDocumentXML);

        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * Modifies the line numbering configuration
     *
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     * @param array $options 
     * countBy (int) line number increments to display (default value is 1)
     * start (int) initial line number (default value is 1)
     * distance (int) separation in twentieths of a point between the number and the text (defaults to auto)
     * restart (string) could be:
     *      continuous (default value: the numbering does not get restarted anywhere in the document),     
     *      newPage (the numbering restarts at the beguinning of every page)
     *      newSection (the numbering restarts at the beguinning of every section)
     */
    public function setLineNumbering($document, $finalDocument, $options = array())
    {
        //Restart condition available types
        $restart_types = array('continuous', 'newPage', 'newSection');
        //Set defaults
        if (isset($options['countBy']) && is_int($options['countBy'])) {
            $increment = $options['countBy'];
        } else {
            $increment = 1;
        }
        if (isset($options['start']) && is_int($options['start'])) {
            $start = $options['start'];
        } else {
            $start = 0;
        }
        if (isset($options['distance']) && is_int($options['distance'])) {
            $distance = $options['distance'];
        }
        if (isset($options['restart']) && in_array($options['restart'], $restart_types)) {
            $condition = $options['restart'];
        } else {
            $condition = 'continuous';
        }

        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_stylesXML = '';
        $this->_documentDOM = new \DOMDocument();
        $this->_stylesDOM = new \DOMDocument();

        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);


        $this->_documentXML = $this->_docx->getFromName('word/document.xml');
        $this->_documentDOM->loadXML($this->_documentXML);
        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        $query = '//w:lnNumType';
        $numNodes = $this->_documentXPath->query($query);
        //Modify existing line numberings if there were any
        if ($numNodes->length > 0) {
            foreach ($numNodes as $node) {
                $node->setAttribute('w:countBy', $increment);
                $node->setAttribute('w:start', $start);
                $node->setAttribute('w:distance', $distance);
                $node->setAttribute('w:restart', $condition);
            }
        }
        //Search for sections with no numbering
        $query = '//w:sectPr[not(descendant::w:lnNumType)]';
        $lnNumNodes = $this->_documentXPath->query($query);
        if ($lnNumNodes->length > 0) {
            foreach ($lnNumNodes as $lnNumNodeBase) {
                $lnNumNode = $lnNumNodeBase->ownerDocument->createDocumentFragment();
                $strNode = '<w:lnNumType w:countBy="' . $increment . '" w:start="' . $start . '" ';
                if (isset($distance)) {
                    $strNode .= 'w:distance="' . $distance . '" ';
                }
                $strNode .='w:restart="' . $condition .
                        '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" />';
                $lnNumNode->appendXML($strNode);

                $propIndex = array_search('w:lnNumType', OOXMLResources::$sectionProperties);
                $childNodes = $lnNumNodeBase->childNodes;
                $index = false;
                foreach ($childNodes as $node) {
                    $name = $node->nodeName;
                    $index = array_search($node->nodeName, OOXMLResources::$sectionProperties);
                    if ($index > $propIndex) {
                        $node->parentNode->insertBefore($lnNumNode, $node);
                        break;
                    }
                }
                //in case no node was found (pretty unlikely) we should append the node
                if (!$index) {
                    $lnNumNodeBase->appendChild($lnNumNode);
                }
            }
        }

        $newDocumentXML = $this->_documentDOM->saveXML();
        $this->_docx->addFromString('word/document.xml', $newDocumentXML);

        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * This is the method that does all the needed manipulation to search
     * and replace text in a Word document
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     * @param string $searchTerm string to be searched and replaced
     * @param string $replaceTerm string with the replacement text
     * @param array $options
     * Values: document (boolean), endnotes (boolean), footnotes (boolean), comments (boolean)
     * headerAndFooters (boolean)
     * @return void
     */
    public function searchAndReplace($document, $finalDocument, $searchTerm, $replaceTerm, $options = array('document' => true))
    {

        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_footnotesXML = '';
        $this->_endnotesXML = '';
        $this->_commentsXML = '';
        $this->_commentsDOM = new \DOMDocument();
        $this->_documentDOM = new \DOMDocument();
        $this->_endnotesDOM = new \DOMDocument();
        $this->_footnotesDOM = new \DOMDocument();
        $this->_relsDOM = new \DOMDocument();

        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);

        if (isset($options['document']) && $options['document'] == true) {
            $this->_documentXML = $this->_docx->getFromName('word/document.xml');
            $this->_documentDOM->loadXML($this->_documentXML);
            //We prepare the document for XPath
            $this->_documentXPath = new \DOMXPath($this->_documentDOM);
            $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $this->searchToReplace($this->_documentXPath, $searchTerm, $replaceTerm);
            $newDocumentXML = $this->_documentDOM->saveXML();
            $this->_docx->addFromString('word/document.xml', $newDocumentXML);
        }
        if (isset($options['footnotes']) && $options['footnotes'] == true) {
            $this->_footnotesXML = $this->_docx->getFromName('word/footnotes.xml');
            if ($this->_footnotesXML !== false) {
                $this->_footnotesDOM->loadXML($this->_footnotesXML);
                //We prepare the document for XPath
                $this->_footnotesXPath = new \DOMXPath($this->_footnotesDOM);
                $this->_footnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToReplace($this->_footnotesXPath, $searchTerm, $replaceTerm);
                $newFootnotesXML = $this->_footnotesDOM->saveXML();
                $this->_docx->addFromString('word/footnotes.xml', $newFootnotesXML);
            }
        }
        if (isset($options['endnotes']) && $options['endnotes'] == true) {
            $this->_endnotesXML = $this->_docx->getFromName('word/endnotes.xml');
            if ($this->_endnotesXML !== false) {
                $this->_endnotesDOM->loadXML($this->_endnotesXML);
                //We prepare the document for XPath
                $this->_endnotesXPath = new \DOMXPath($this->_endnotesDOM);
                $this->_endnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToReplace($this->_endnotesXPath, $searchTerm, $replaceTerm);
                $newEndnotesXML = $this->_endnotesDOM->saveXML();
                $this->_docx->addFromString('word/endnotes.xml', $newEndnotesXML);
            }
        }
        if (isset($options['comments']) && $options['comments'] == true) {
            $this->_commentsXML = $this->_docx->getFromName('word/comments.xml');
            if ($this->_commentsXML !== false) {
                $this->_commentsDOM->loadXML($this->_commentsXML);
                //We prepare the document for XPath
                $this->_commentsXPath = new \DOMXPath($this->_commentsDOM);
                $this->_commentsXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToReplace($this->_commentsXPath, $searchTerm, $replaceTerm);
                $newCommentsXML = $this->_commentsDOM->saveXML();
                $this->_docx->addFromString('word/comments.xml', $newCommentsXML);
            }
        }
        if (isset($options['headersAndFooters']) && $options['headersAndFooters'] == true) {
            $this->_relsXML = $this->_docx->getFromName('word/_rels/document.xml.rels');
            $this->_relsDOM->preserveWhiteSpace = false;
            $this->_relsDOM->loadXML($this->_relsXML);
            $relsNodes = $this->_relsDOM->documentElement->childNodes;
            $headersAndFooters = array();
            foreach ($relsNodes as $node) {
                if ($node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer' ||
                        $node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/header') {
                    $headersAndFooters[] = $node->getAttribute('Target');
                }
            }
            $this->_headersAndFootersXML = array();
            $this->_headersAndFootersDOM = array();
            $this->_headersAndFootersXPath = array();
            for ($k = 0; $k < count($headersAndFooters); $k++) {
                $this->_headersAndFootersXML[$k] = $this->_docx->getFromName('word/' . $headersAndFooters[$k]);
                $this->_headersAndFootersDOM[$k] = new \DOMDocument();
                $this->_headersAndFootersDOM[$k]->loadXML($this->_headersAndFootersXML[$k]);
                //We prepare the document for XPath
                $this->_headersAndFootersXPath[$k] = new \DOMXPath($this->_headersAndFootersDOM[$k]);
                $this->_headersAndFootersXPath[$k]->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToReplace($this->_headersAndFootersXPath[$k], $searchTerm, $replaceTerm);
                $newXML = $this->_headersAndFootersDOM[$k]->saveXML();
                $this->_docx->addFromString('word/' . $headersAndFooters[$k], $newXML);
            }
        }


        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * This is the method that does all the needed manipulation to search
     * and remove a paragraph containing a string in a Word document
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     * @param string $searchTerm string to be searched and replaced
     * @param array $options
     * Values: document (boolean), endnotes (boolean), footnotes (boolean), comments (boolean)
     * headerAndFooters (boolean)
     * @return void
     */
    public function searchAndRemove($document, $finalDocument, $searchTerm, $options = array('document' => true))
    {
        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_footnotesXML = '';
        $this->_endnotesXML = '';
        $this->_commentsXML = '';
        $this->_commentsDOM = new \DOMDocument();
        $this->_documentDOM = new \DOMDocument();
        $this->_endnotesDOM = new \DOMDocument();
        $this->_footnotesDOM = new \DOMDocument();
        $this->_relsDOM = new \DOMDocument();

        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);

        if (isset($options['document']) && $options['document'] == true) {
            $this->_documentXML = $this->_docx->getFromName('word/document.xml');
            $this->_documentDOM->loadXML($this->_documentXML);
            //We prepare the document for XPath
            $this->_documentXPath = new \DOMXPath($this->_documentDOM);
            $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $this->searchToRemove($this->_documentXPath, $searchTerm);
            $newDocumentXML = $this->_documentDOM->saveXML();
            $this->_docx->addFromString('word/document.xml', $newDocumentXML);
        }
        if (isset($options['footnotes']) && $options['footnotes'] == true) {
            $this->_footnotesXML = $this->_docx->getFromName('word/footnotes.xml');
            if ($this->_footnotesXML !== false) {
                $this->_footnotesDOM->loadXML($this->_footnotesXML);
                //We prepare the document for XPath
                $this->_footnotesXPath = new \DOMXPath($this->_footnotesDOM);
                $this->_footnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToRemove($this->_footnotesXPath, $searchTerm);
                $newFootnotesXML = $this->_footnotesDOM->saveXML();
                $this->_docx->addFromString('word/footnotes.xml', $newFootnotesXML);
            }
        }
        if (isset($options['endnotes']) && $options['endnotes'] == true) {
            $this->_endnotesXML = $this->_docx->getFromName('word/endnotes.xml');
            if ($this->_endnotesXML !== false) {
                $this->_endnotesDOM->loadXML($this->_endnotesXML);
                //We prepare the document for XPath
                $this->_endnotesXPath = new \DOMXPath($this->_endnotesDOM);
                $this->_endnotesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToRemove($this->_endnotesXPath, $searchTerm);
                $newEndnotesXML = $this->_endnotesDOM->saveXML();
                $this->_docx->addFromString('word/endnotes.xml', $newEndnotesXML);
            }
        }
        if (isset($options['comments']) && $options['comments'] == true) {
            $this->_commentsXML = $this->_docx->getFromName('word/comments.xml');
            if ($this->_commentsXML !== false) {
                $this->_commentsDOM->loadXML($this->_commentsXML);
                //We prepare the document for XPath
                $this->_commentsXPath = new \DOMXPath($this->_commentsDOM);
                $this->_commentsXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToRemove($this->_commentsXPath, $searchTerm);
                $newCommentsXML = $this->_commentsDOM->saveXML();
                $this->_docx->addFromString('word/comments.xml', $newCommentsXML);
            }
        }
        if (isset($options['headersAndFooters']) && $options['headersAndFooters'] == true) {
            $this->_relsXML = $this->_docx->getFromName('word/_rels/document.xml.rels');
            $this->_relsDOM->loadXML($this->_relsXML);
            $relsNodes = $this->_relsDOM->documentElement->childNodes;
            $headersAndFooters = array();
            foreach ($relsNodes as $node) {
                if ($node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer' ||
                        $node->getAttribute('Type') == 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/header') {
                    $headersAndFooters[] = $node->getAttribute('Target');
                }
            }
            $this->_headersAndFootersXML = array();
            $this->_headersAndFootersDOM = array();
            $this->_headersAndFootersXPath = array();
            for ($k = 0; $k < count($headersAndFooters); $k++) {
                $this->_headersAndFootersXML[$k] = $this->_docx->getFromName('word/' . $headersAndFooters[$k]);
                $this->_headersAndFootersDOM[$k] = new \DOMDocument();
                $this->_headersAndFootersDOM[$k]->loadXML($this->_headersAndFootersXML[$k]);
                //We prepare the document for XPath
                $this->_headersAndFootersXPath[$k] = new \DOMXPath($this->_headersAndFootersDOM[$k]);
                $this->_headersAndFootersXPath[$k]->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                $this->searchToRemove($this->_headersAndFootersXPath[$k], $searchTerm);
                $newXML = $this->_headersAndFootersDOM[$k]->saveXML();
                $this->_docx->addFromString('word/' . $headersAndFooters[$k], $newXML);
            }
        }


        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * Ticks or unticks per order all checkboxes in a docx document
     * Warning: It only parses legacy checkboxes
     * @access public
     * @param string $source path to the docx
     * @param string $target path to the resulting parsed docx
     * @param array $checkboxes an array of 1's (checked) and 0's (unchecked)
     * @return boolean
     */
    public function parseCheckboxes($source, $target, $checkboxes)
    {
        //we make a copy of the source document into its final destination so we do not overwrite it
        copy($source, $target);
        //we extract the relevant files for the unwatermarking process
        $this->_checkDocx = new \ZipArchive();
        $this->_checkDocx->open($target);
        $this->_checkDocxDocumentXML = $this->_checkDocx->getFromName('word/document.xml');
        $this->_checkDocxDocumentDOM = new \DOMDocument();
        $this->_checkDocxDocumentDOM->loadXML($this->_checkDocxDocumentXML);


        $this->_checkDocXpath = new \DOMXPath($this->_checkDocxDocumentDOM);
        $this->_checkDocXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $this->_checkDocXpath->registerNamespace('w14', 'http://schemas.microsoft.com/office/word/2010/wordml');


        $queryCheckbox = '//w:checkBox/w:default | //w14:checkbox';
        $affectedNodes = $this->_checkDocXpath->query($queryCheckbox);
        $counter = 0;

        foreach ($affectedNodes as $node) {
            if (isset($checkboxes[$counter])) {
                if ($node->parentNode->nodeName != 'w:sdtPr') {
                    $node->setAttribute('w:val', $checkboxes[$counter]);
                } else {
                    $nodeVals = $node->getElementsByTagNameNS('http://schemas.microsoft.com/office/word/2010/wordml', 'checked');
                    $nodeVals->item(0)->setAttribute('w14:val', $checkboxes[$counter]);
                    //Now change the selected symbol for checked or unchecked
                    $sdt = $node->parentNode->parentNode;
                    $txt = $sdt->getElementsByTagNameNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 't');
                    if ($checkboxes[$counter] == 1) {
                        $txt->item(0)->nodeValue = '☒';
                    } else {
                        $txt->item(0)->nodeValue = '☐';
                    }
                }
            }
            $counter++;
        }
        $documentXML = $this->_checkDocxDocumentDOM->saveXML();
        $this->_checkDocx->addFromString('word/document.xml', $documentXML);
        //We close now the zip file
        return $this->_checkDocx->close();
    }

    /**
     * Removes a chapter or subchapter from a Word document
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     * @param string $searchTerm string to be searched in the chapter heading
     * @return void
     */
    public function removeChapter($document, $finalDocument, $searchTerm)
    {
        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_stylesXML = '';
        $this->_documentDOM = new \DOMDocument();
        $this->_stylesDOM = new \DOMDocument();


        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);


        $this->_documentXML = $this->_docx->getFromName('word/document.xml');
        $this->_documentDOM->loadXML($this->_documentXML);
        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        //We also need to load the Styles file
        $this->_stylesXML = $this->_docx->getFromName('word/styles.xml');
        $this->_stylesDOM->loadXML($this->_stylesXML);
        //We prepare the document for XPath
        $this->_stylesXPath = new \DOMXPath($this->_stylesDOM);
        $this->_stylesXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');


        //Let us know start to loop over child nodes of the body element
        $bodyElement = $this->_documentDOM->getElementsByTagName('body')->item(0);
        $bodyChilds = $bodyElement->childNodes;
        $found = false;
        $tocLevel = 1000;
        foreach ($bodyChilds as $node) {
            if (!$found && $node->nodeName == 'w:p') {
                $paragraphContents = $node->ownerDocument->saveXML($node);
                $paragraphText = strip_tags($paragraphContents);
                if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                    //We start all the processing to get the TOC level
                    $tocLevel = $this->getTOCLevel($node);
                    //if a TOC level has been found
                    if ($tocLevel < 8) {
                        $found = true;
                        $node->setAttribute('remove', 1);
                    }
                }
            } else if ($found) {
                $newTocLevel = $this->getTOCLevel($node);
                if ($newTocLevel <= $tocLevel) {
                    break;
                } else {
                    if ($node->nodeName != 'w:sectPr') {
                        $node->setAttribute('remove', 1);
                    }
                }
            }
        }
        //Now we have to remove all nodes that have an attribute of remove="1"
        $query = '//*[@remove="1"]';
        $removedNodes = $this->_documentXPath->query($query);
        for ($n = ($removedNodes->length - 1); $n >= 0; $n--) {
            $removedNodes->item($n)->parentNode->removeChild($removedNodes->item($n));
        }
        $newDocumentXML = $this->_documentDOM->saveXML();
        $this->_docx->addFromString('word/document.xml', $newDocumentXML);




        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * Removes the line numbering of an existing Word document
     *
     * @access public
     * @param string $document path to the document
     * @param string $finalDocument path to the resulting document
     */
    public function removeLineNumbering($document, $finalDocument)
    {

        $this->_docx = new \ZipArchive();
        $this->_documentXML = '';
        $this->_stylesXML = '';
        $this->_documentDOM = new \DOMDocument();
        $this->_stylesDOM = new \DOMDocument();

        //we make a copy of the the document into its final destination so we do not overwrite it
        copy($document, $finalDocument);
        //we extract (some) of the relevant files of the copy of the first document for manipulation
        $this->_docx->open($finalDocument);


        $this->_documentXML = $this->_docx->getFromName('word/document.xml');
        $this->_documentDOM->loadXML($this->_documentXML);
        //We prepare the document for XPath
        $this->_documentXPath = new \DOMXPath($this->_documentDOM);
        $this->_documentXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        $query = '//w:lnNumType';
        $numNodes = $this->_documentXPath->query($query);
        //Modify existing line numberings if there are any
        if ($numNodes->length > 0) {
            for ($j = ($numNodes->length - 1); $j > -1; $j--) {
                $numNodes->item($j)->parentNode->removeChild($numNodes->item($j));
            }
        }

        $newDocumentXML = $this->_documentDOM->saveXML();
        $this->_docx->addFromString('word/document.xml', $newDocumentXML);

        //we finally close the zip file
        $this->_docx->close();
    }

    /**
     * This is the method that carry out the final highlightiong of the document
     * @access private
     * @param DOMDocument $docDOM the node to be changed
     * @param string $highlightColor
     * @return void
     */
    public function highlightDocx($docDOM, $highlightColor)
    {
        //At this point we have got the DOM Document prepared for the final higlighting
        //We should select all runs with attribute highlight = 1 and include the higligthing
        $query = '//w:r[@highlight="1"]';
        $docXPath = new \DOMXPath($docDOM);
        $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $affectedRs = $docXPath->query($query);
        foreach ($affectedRs as $node) {
            $firstChild = $node->firstChild;
            $highlight = $docDOM->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'highlight');
            $highlight->setAttribute('w:val', $highlightColor);

            if ($firstChild->nodeName == 'w:rPr') {
                $firstChild->appendChild($highlight);
            } else {
                $rPrNode = $docDOM->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'rPr');
                $node->insertBefore($rPrNode, $firstChild);
                $rPrNode->appendChild($highlight);
            }
            $node->removeAttribute('highlight');
        }
    }

    /**
     * This method counts the number of w:p childs of a node
     * @access private
     * @param DOMNode $myNode 
     * @return int
     */
    private function getNumberPChilds($myNode)
    {
        $childs = $myNode->childNodes;
        $number = 0;
        foreach ($childs as $node) {
            if ($node->nodeName == 'w:p') {
                $number++;
            }
        }
        return $number;
    }

    /**
     * This is the method that replaces the search term.
     * It takes into account that the text may be split among different runs of text
     * @access private
     * @param DOMNode $paragraph the node to be changed
     * @param string $searchTerm string to be searched and highlighted
     * @param array $options for highlighting
     * @return void
     */
    private function highlightString($paragraph, $xPath, $searchTerm)
    {
        $lengthSearchTerm = strlen($searchTerm);
        $replaceTerm = $searchTerm;
        $lengthReplaceTerm = strlen($replaceTerm) + 16; //we have added the length of wrapper _$_highlight__$_
        $paragraphText = '';
        $textChilds = $paragraph->getElementsByTagName('t');
        foreach ($textChilds as $node) {
            $paragraphText .= $node->nodeValue;
        }
        $results = array();
        $results = $this->getIndexOf($paragraphText, $searchTerm);



        $position = 0;
        foreach ($textChilds as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            $numChars = strlen($text);
            $offset = 0;
            $affectedNode = 0;
            for ($j = 0; $j < count($results); $j++) {
                //We first check if that particular run may be affected by the replacement
                if (($position + $numChars) > $results[$j] && $position < ($results[$j] + $lengthSearchTerm)) {
                    $affectedNode = 1;
                    if ($position <= $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the string to be highlighted falls completely within the scope of this run
                        //The we will extract that ocurrence of the searchTerm and replace it directly by the replaceTerm
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $secondTextChunk = substr($text, $results[$j] - $position + $lengthSearchTerm + $offset);
                        $text = $firstTextChunk . '_$_highlight_' . $replaceTerm . '_$_' . $secondTextChunk;
                        //Whenever we make a substitution we have to take into account that the length of the text has changed
                        $offset += $lengthReplaceTerm - $lengthSearchTerm;
                    } else if ($position <= $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced starts in this run but continues in next one
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $text = $firstTextChunk . '_$_highlight_' . substr($searchTerm, 0, ($position + $numChars - $results[$j])) . '_$_';
                    } else if ($position > $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and continue in other run
                        $text = '_$_highlight_' . $text . '_$_';
                    } else if ($position > $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and finish in this run
                        $text = '_$_highlight_' . substr($text, 0, $results[$j] + $lengthSearchTerm - $position) . '_$_' . substr($text, $results[$j] + $lengthSearchTerm - $position);
                        $offset = $results[$j] + $lengthSearchTerm - $position;
                    }
                    $node->nodeValue = $text;
                }
            }
            $position += $numChars;
        }

        //Now we are going to run again all child nodes to separate the runs for the highlighted content

        $query = $paragraph->getNodePath() . '//w:r';
        $affectedRs = $xPath->query($query);

        foreach ($affectedRs as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            if (($pos = strpos($text, '_$_highlight', 0)) !== false) {
                $textArray = explode('_$_', $text);
                for ($k = 0; $k < count($textArray); $k++) {
                    $baseNode = $node->cloneNode(true);
                    //we have to be careful to remove some tags that may
                    //interfere with the formatting like tabs and line breaks
                    if ($k == 0) {
                        //in this case we want to remove other siblings than rPr and t
                        //unless is a tab tag
                        $baseNodeChilds = $baseNode->childNodes;
                        foreach ($baseNodeChilds as $tSibling) {
                            if ($tSibling->nodeName != 'w:rPr' && $tSibling->nodeName != 'w:t' && $tSibling->nodeName != 'w:tab') {
                                $tSibling->parentNode->removeChild($tSibling);
                            }
                        }
                    } else if ($k > 0 && $k < (count($textArray) - 1)) {
                        //in this case we want to remove other siblings than rPr and t 
                        $baseNodeChilds = $baseNode->childNodes;
                        foreach ($baseNodeChilds as $tSibling) {
                            if ($tSibling->nodeName != 'w:rPr' && $tSibling->nodeName != 'w:t') {
                                $tSibling->parentNode->removeChild($tSibling);
                            }
                        }
                    } else {
                        //in this case we want to remove tabs 
                        $baseNodeChilds = $baseNode->childNodes;
                        foreach ($baseNodeChilds as $tSibling) {
                            if ($tSibling->nodeName == 'w:tab') {
                                $tSibling->parentNode->removeChild($tSibling);
                            }
                        }
                    }
                    $textNode = $baseNode->getElementsByTagName('t')->item(0);
                    if (($pos = strpos($textArray[$k], 'highlight_', 0)) !== false) {
                        $textArray[$k] = substr($textArray[$k], 10);
                        $baseNode->setAttribute('highlight', 1);
                    }
                    $textNode->nodeValue = $textArray[$k];
                    $textNode->setAttribute('xml:space', 'preserve');

                    $node->parentNode->insertBefore($baseNode, $node);
                }
                $node->setAttribute('remove', 1);
            }
        }


        $query = $paragraph->getNodePath() . '//w:r';
        $affectedRs = $xPath->query($query);
        for ($n = ($affectedRs->length - 1); $n >= 0; $n--) {
            $toRemove = $affectedRs->item($n)->getAttribute('remove');
            if ($toRemove == 1) {
                $affectedRs->item($n)->parentNode->removeChild($affectedRs->item($n));
            }
        }
    }

    /**
     * Checks if there are contents in a given array of data like images, bookmarks, ...
     * @access private
     * @param array $dataArray
     * @return int
     */
    private function checkData($dataArray)
    {
        $num = 0;
        for ($j = 0; $j <= count($dataArray); $j++) {
            if (isset($dataArray[$j])) {
                $num += count($dataArray[$j]);
            }
        }
        return $num;
    }

    /**
     * It returns the indexes of all ocurrences of a needdle in a string
     * @access private
     * @param string $myString the string to be searched
     * @param string $search the text to be searched
     * @return array
     */
    private function getIndexOf($myString, $search)
    {
        $initialChar = 0;
        $charIndexes = array();
        $lengthSearchTerm = strlen($search);
        while (($pos = strpos($myString, $search, $initialChar)) !== false) {
            $charIndexes[] = $pos;
            $initialChar = $pos + $lengthSearchTerm;
        }
        return $charIndexes;
    }

    /**
     * It returns the TOC level, if any, of a given paragraph node
     * @access private
     * @param DOMNode $node the string to be searched
     * @return int
     */
    private function getTOCLevel($node)
    {
        $tocLevel = 1000;
        $pPr = $node->firstChild;
        if ($pPr->nodeName == 'w:pPr') {
            //We first look if the TOC level is defined in the style used
            $query = $pPr->getNodePath() . '/w:pStyle';
            $affectedNodes = $this->_documentXPath->query($query);
            if ($affectedNodes->length > 0) {
                $styleId = $affectedNodes->item(0)->getAttribute('w:val');
                //we now have to look for that styles toc level (if any)
                $query = '//w:style[@w:styleId ="' . $styleId . '"]/w:pPr/w:outlineLvl';
                $styleNodes = $this->_stylesXPath->query($query);
                if ($styleNodes->length > 0) {
                    $tocLevel = $styleNodes->item(0)->getAttribute('w:val');
                }
            }
            //We now check if it has been set specifically
            $query = $pPr->getNodePath() . '/w:outlineLvl';
            $affectedNodes = $this->_documentXPath->query($query);
            if ($affectedNodes->length > 0) {
                $tocLevel = $affectedNodes - item(0)->getAttribute('val');
            }
        }

        return $tocLevel;
    }

    /**
     * Merges the required numbering styles into a single file
     * @access private
     * @param DOMDocument $myOriginalNumbering
     * @param DOMDocument $myMergedNumbering
     * @param array $numberings structural info about the lists
     * @return string
     */
    private function mergeNumberings(&$myOriginalNumbering, &$myMergedNumbering, $numberings)
    {
        //Prepare $myMergedNumbering for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedNumbering);
        $mergedXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        //we have to remove the w:nsid and w:tmpl elements to avoid conflicts when merging twice the same template
        $nsidNumbering = '//w:nsid | //w:tmpl';
        $nsidNodes = $mergedXPath->query($nsidNumbering);
        foreach ($nsidNodes as $node) {
            $node->parentNode->removeChild($node);
        }
        //We now create an auxiliary array to avoid the relabeling of numberings that are used multiple times in different sections
        $refNumberings = array();
        for ($j = 1; $j <= count($numberings); $j++) {
            foreach ($numberings[$j] as $key => $value) {
                if (!in_array($key, $refNumberings)) {
                    $query = '//w:num[@w:numId="' . $key . '"]';
                    $numNodes = $mergedXPath->query($query);
                    //we now get the associated numbering style but we should first check that $numNodes is not empty
                    if ($numNodes->length > 0) {
                        $absNum = $numNodes->item(0)->firstChild->getAttribute('w:val');
                        $query = '//w:abstractNum[@w:abstractNumId="' . $absNum . '"]';
                        $absNumNodes = $mergedXPath->query($query);
                        if ($absNumNodes->length > 0) {
                            //we have to check if there are results because we may have already
                            //redefined that numbering because it was used by other list
                            $absNumNode = $absNumNodes->item(0);
                            //we create a new abstractNumId (we use the same number to simplify debugging)
                            $newAbstractNumId = $value;
                            $absNumNode->setAttribute('w:abstractNumId', $newAbstractNumId);
                            $base = $myOriginalNumbering->documentElement->firstChild;
                            $newNumNode = $myOriginalNumbering->importNode($absNumNode, true);
                            $base->parentNode->insertBefore($newNumNode, $base);

                            //Now we include the relationship
                            $newNum = '<w:num w:numId="' . $value . '" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:abstractNumId w:val="' . $newAbstractNumId . '" /></w:num>';
                            $numFragment = $myOriginalNumbering->createDocumentFragment();
                            $numFragment->appendXML($newNum);
                            $myOriginalNumbering->documentElement->appendChild($numFragment);
                        }
                    }
                }
                $refNumberings[] = $key;
            }
        }
        return $myOriginalNumbering->saveXML();
    }

    /**
     * Merges the required styles into a single file
     * @access private
     * @param DOMDocument $myOriginalStyles
     * @param DOMDocument $myMergedStyles
     * @return string
     */
    private function mergeStyles($myOriginalStyles, $myMergedStyles)
    {
        //Prepare $myMergedStyles and $myOriginalStyles for XPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedStyles);
        $mergedXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $originalXPath = new \DOMXPath($myOriginalStyles);
        $originalXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        //we now extract the style nodes from the file to be merged
        $query = '//w:style';
        $mergedStyleNodes = $mergedXPath->query($query);
        foreach ($mergedStyleNodes as $node) {
            $styleId = $node->getAttribute('w:styleId');
            //Let us check if that style already exists in the original file
            $query = '//w:style[@w:styleId="' . $styleId . '"]';
            $foundNodes = $originalXPath->query($query);
            if ($foundNodes->length == 0) {
                $newStyleNode = $myOriginalStyles->importNode($node, true);
                $myOriginalStyles->documentElement->appendChild($newStyleNode);
            }
        }
        return $myOriginalStyles->saveXML();
    }

    /**
     * Merges the required footnotes files into a single file
     * @access private
     * @param DOMDocument $myOriginalFootnotes
     * @param DOMDocument $myMergedFootnotes
     * @param array $footnotes structural info about the footnotes
     * @return string
     */
    private function mergeFootnotes($myOriginalFootnotes, $myMergedFootnotes, $footnotes)
    {
        //Prepare $myMergedFootnotes for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedFootnotes);
        $mergedXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        for ($j = 1; $j <= count($footnotes); $j++) {
            foreach ($footnotes[$j] as $key => $value) {
                $query = '//w:footnote[@w:id=' . $key . ']';
                $footnoteNodes = $mergedXPath->query($query);
                //we now get the associated footnote
                $nodeFootnote = $footnoteNodes->item(0);
                $nodeFootnote->setAttribute('w:id', $value);
                $newFootnoteNode = $myOriginalFootnotes->importNode($nodeFootnote, true);
                $base = $myOriginalFootnotes->documentElement;
                $base->appendChild($newFootnoteNode);
            }
        }
        return $myOriginalFootnotes->saveXML();
    }

    /**
     * Merges the required endnotes files into a single file
     * @access private
     * @param DOMDocument $myOriginalEndnotes
     * @param DOMDocument $myMergedEndnotes
     * @param array $endnotes structural info about the endnotes
     * @return string
     */
    private function mergeEndnotes($myOriginalEndnotes, $myMergedEndnotes, $endnotes)
    {
        //Prepare $myMergedEndnotes for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedEndnotes);
        $mergedXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        for ($j = 1; $j <= count($endnotes); $j++) {
            foreach ($endnotes[$j] as $key => $value) {
                $query = '//w:endnote[@w:id=' . $key . ']';
                $endnoteNodes = $mergedXPath->query($query);
                //we now get the associated endnote
                $nodeEndnote = $endnoteNodes->item(0);
                $nodeEndnote->setAttribute('w:id', $value);
                $newEndnoteNode = $myOriginalEndnotes->importNode($nodeEndnote, true);
                $base = $myOriginalEndnotes->documentElement;
                $base->appendChild($newEndnoteNode);
            }
        }
        return $myOriginalEndnotes->saveXML();
    }

    /**
     * Merges the required comments files into a single file
     * @access private
     * @param DOMDocument $myOriginalComments
     * @param DOMDocument $myMergedComments
     * @param array comments structural info about the comments
     * @return string
     */
    private function mergeComments($myOriginalComments, $myMergedComments, $comments)
    {
        //Prepare $myMergedComments for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedComments);
        $mergedXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        for ($j = 1; $j <= count($comments); $j++) {
            foreach ($comments[$j] as $key => $value) {
                $query = '//w:comment[@w:id=' . $key . ']';
                $commentNodes = $mergedXPath->query($query);
                //we now get the associated comment
                $nodeComment = $commentNodes->item(0);
                $nodeComment->setAttribute('w:id', $value);
                $newCommentNode = $myOriginalComments->importNode($nodeComment, true);
                $base = $myOriginalComments->documentElement;
                $base->appendChild($newCommentNode);
            }
        }
        return $myOriginalComments->saveXML();
    }

    /**
     * Merges the required [Content_Types].xml into a single file
     * @access private
     * @param DOMDocument $myOriginalContentTypes
     * @param DOMDocument $myMergedContentTypes
     * @return string
     */
    private function mergeContentTypes($myOriginalContentTypes, $myMergedContentTypes)
    {
        //Prepare $myMergedContentTypes and $myOriginalContentTypes for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedContentTypes);
        $mergedXPath->registerNamespace('ct', 'http://schemas.openxmlformats.org/package/2006/content-types');
        $originalXPath = new \DOMXPath($myOriginalContentTypes);
        $originalXPath->registerNamespace('ct', 'http://schemas.openxmlformats.org/package/2006/content-types');
        //we now extract the Override nodes from the file to be merged
        $query = '//ct:Override';
        $mergedContentTypeNodes = $mergedXPath->query($query);
        foreach ($mergedContentTypeNodes as $node) {
            $partName = $node->getAttribute('PartName');
            //Let us check if that PartName already exists in the original file
            $query = '//ct:Override[@PartName="' . $partName . '"]';
            $foundNodes = $originalXPath->query($query);
            if ($foundNodes->length == 0) {
                $newOverrideNode = $myOriginalContentTypes->importNode($node, true);
                $myOriginalContentTypes->documentElement->appendChild($newOverrideNode);
            }
        }
        //we now extract the Default nodes from the file to be merged
        $query = '//ct:Default';
        $mergedContentTypeNodes = $mergedXPath->query($query);
        foreach ($mergedContentTypeNodes as $node) {
            $extension = $node->getAttribute('Extension');
            //Let us check if that Extension already exists in the original file
            $query = '//ct:Default[@Extension="' . $extension . '"]';
            $foundNodes = $originalXPath->query($query);
            if ($foundNodes->length == 0) {
                $newDefaultNode = $myOriginalContentTypes->importNode($node, true);
                $myOriginalContentTypes->documentElement->appendChild($newDefaultNode);
            }
        }

        return $myOriginalContentTypes->saveXML();
    }

    /**
     * Merges the required sections into a single file
     * @access private
     * @param array $firstDocx
     * @param array $secondDocx
     * @param array $options
     * @return string
     */
    private function mergeDocuments($firstDocx, $secondDocx, $options)
    {
        $firstNumSections = count($firstDocx['section']);
        $secondNumSections = count($secondDocx['section']);
        //Before starting the merging we should take into account the numbering
        //option (restart or continue numbering in the merged document)
        if (isset($options['numbering']) && $options['numbering'] == 'restart') {
            $numberingNodes = $secondDocx['sectionProperties'][1]->documentElement->getElementsByTagName('pgNumType');
            if ($numberingNodes->length > 0) {
                $numberingNode = $numberingNodes->item(0);
                $numberingNode->setAttribute('w:start', 1);
            } else {
                $pgNumType = $secondDocx['sectionProperties'][1]->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'pgNumType');
                $pgNumType->setAttribute('w:start', 1);
                //insert the node
                $tagIndex = array_search('w:pgNumType', OOXMLResources::$sectionProperties);
                $childNodes = $secondDocx['sectionProperties'][1]->documentElement->childNodes;
                $index = false;
                foreach ($childNodes as $node) {
                    $name = $node->nodeName;
                    $index = array_search($node->nodeName, OOXMLResources::$sectionProperties);
                    if ($index > $tagIndex) {
                        $node->parentNode->insertBefore($pgNumType, $node);
                        break;
                    }
                }
                //in case no node was found (pretty unlikely)we should append the node
                if (!$index) {
                    $secondDocx['sectionProperties'][1]->documentElement->appendChild($pgNumType);
                }
            }
        } else if (isset($options['numbering']) && $options['numbering'] == 'continue') {
            $numberingNodes = $secondDocx['sectionProperties'][1]->documentElement->getElementsByTagName('pgNumType');
            if ($numberingNodes->length > 0) {
                $numberingNode = $numberingNodes->item(0);
                $numberingNode->removeAttribute('w:start');
            }
        }
        //Check if the option enforceSectionPageBreak is set to true
        if ($options['enforceSectionPageBreak']) {
            $typeNodes = $secondDocx['sectionProperties'][1]->documentElement->getElementsByTagName('type');
            if ($typeNodes->length > 0) {
                $typeNodes->item(0)->setAttribute('w:val', 'nextPage');
            } else {
                $sectType = $secondDocx['sectionProperties'][1]->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'type');
                $sectType->setAttribute('w:val', 'nextPage');
                //insert the node
                $tagIndex = array_search('w:type', OOXMLResources::$sectionProperties);
                $childNodes = $secondDocx['sectionProperties'][1]->documentElement->childNodes;
                $index = false;
                foreach ($childNodes as $node) {
                    $name = $node->nodeName;
                    $index = array_search($node->nodeName, OOXMLResources::$sectionProperties);
                    if ($index > $tagIndex) {
                        $node->parentNode->insertBefore($sectType, $node);
                        break;
                    }
                }
                //in case no node was found (pretty unlikely)we should append the node
                if (!$index) {
                    $secondDocx['sectionProperties'][1]->documentElement->appendChild($sectType);
                }
            }
        }
        //We create a new array that will set together the sections of both documents             
        $newSections = $firstDocx['section'];
        $newSectionProperties = $firstDocx['sectionProperties'];
        //We should first check if we need to insert line breaks between documents
        if ($this->_wordMLChunk != '') {
            $fragment = $firstDocx['section'][$firstNumSections]->createDocumentFragment();
            $fragment->appendXML($this->_wordMLChunk);
            $firstDocx['section'][$firstNumSections]->appendChild($fragment);
        }
        if (empty($options['mergeType']) || $options['mergeType'] == 0) {
            //this is the default case where sections are preserved in both documents 
            for ($k = 1; $k <= $secondNumSections; $k++) {
                $newSections[] = $secondDocx['section'][$k];
                $newSectionProperties[] = $secondDocx['sectionProperties'][$k];
            }
        } else if ($options['mergeType'] == 1) {
            //In this case we just get the contents of the file to be merged and we
            //keep it as an string for later use
            if ($this->_wordMLChunk == '') {
                $secondDocumentToString = '';
            } else {
                $secondDocumentToString = $this->_wordMLChunk;
            }
            for ($k = 1; $k <= $secondNumSections; $k++) {
                $secondDocumentToString .= $secondDocx['section'][$k]->saveXML();
            }
        }
        //Now we can proceed to generate the new document.xml file contents
        $numSections = count($newSections);
        $mergedDocumentAsString = '';
        for ($k = 1; $k < $numSections; $k++) {
            $sectNode = $newSections[$k]->importNode($newSectionProperties[$k]->documentElement, true);
            $lastNode = $newSections[$k]->lastChild;
            if ($lastNode->nodeName == 'w:p') {
                //check now if there is a pPr child
                if (is_object($lastNode->firstChild) && $lastNode->firstChild->nodeName == 'w:pPr') {
                    //check the name of the last child
                    if (is_object($lastNode->firstChild->lastChild) && $lastNode->firstChild->lastChild->nodeName == 'w:pPrChange') {
                        $lastNode->firstChild->lastChild->parentNode->insertBefore($sectNode, $lastParagraph->firstChild->lastChild);
                    } else {
                        $lastNode->firstChild->appendChild($sectNode);
                    }
                } else {
                    $sectFragment = $newSections[$k]->createDocumentFragment();
                    $sectFragment->appendXML('<w:pPr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">' . $newSectionProperties[$k]->documentElement->ownerDocument->saveXML($newSectionProperties[$k]->documentElement) . '</w:pPr>');
                    if ($lastNode->hasChildNodes()) {
                        //if it has child nodes we insert it before the first one
                        $lastNode->insertBefore($sectFragment, $lastNode->firstChild);
                    } else {
                        //if it does not have child nodes we simply append it
                        $lastNode->appendChild($sectFragment);
                    }
                }
            } else {
                $sectFragment = $newSections[$k]->createDocumentFragment();
                $sectFragment->appendXML('<w:p xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:pPr>' . $newSectionProperties[$k]->documentElement->ownerDocument->saveXML($newSectionProperties[$k]->documentElement) . '</w:pPr></w:p>');
                //we insert a p node just before it
                //$lastNode->parentNode->insertBefore($sectFragment,$node);
                $lastNode->parentNode->appendChild($sectFragment);
            }
            //we now concatenate the resulting document
            $mergedDocumentAsString .= $newSections[$k]->saveXML();
        }
        //We now concatenate the last section and sectPr               
        $mergedDocumentAsString .= $newSections[$numSections]->saveXML();
        if ($options['mergeType'] == 1) {
            $mergedDocumentAsString .= $secondDocumentToString;
        }
        $mergedDocumentAsString .= $newSectionProperties[$numSections]->saveXML();
        //we now remove the xml headers
        $mergedDocumentAsString = str_replace('<?xml version="1.0"?>', '', $mergedDocumentAsString);



        return $mergedDocumentAsString;
    }

    /**
     * Merges the required document.xml.rels into a single file
     * @access private
     * @param DOMDocument $myOriginalRels
     * @param DOMDocument $myMergedrels
     * @return string
     */
    private function mergeRels($myOriginalRels, $myMergedRels)
    {
        //Prepare $myMergedRels and $myOriginalRels for xPath searches of the required nodes
        $mergedXPath = new \DOMXPath($myMergedRels);
        $mergedXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
        $originalXPath = new \DOMXPath($myOriginalRels);
        $originalXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
        //we now extract the Relationship nodes from the file to be merged without TargetMode
        $query = '//rels:Relationship[not(@TargetMode)]';
        $mergedRelsNodes = $mergedXPath->query($query);
        foreach ($mergedRelsNodes as $node) {
            $target = $node->getAttribute('Target');
            $currentId = $node->getAttribute('Id');
            //We are going to filter the CustomXML, glossary and .bin files that we are not going to import by the time being
            if (strstr($target, 'customXml') === false &&
                    strstr($target, 'glossary') === false &&
                    strstr($target, '.bin') === false) {
                //$targetMode = $node->getAttribute('TargetMode');
                //Let us check if that Target already exists in the original file
                $query = '//rels:Relationship[@Target="' . $target . '"]';
                $foundNodes = $originalXPath->query($query);
                if ($foundNodes->length == 0) {
                    if (in_array($target, $this->_implicitRelationships)) {
                        $node->setAttribute('Id', 'Id' . uniqid(mt_rand(999, 9999)));
                        $newRelationshipNode = $myOriginalRels->importNode($node, true);
                        $myOriginalRels->documentElement->appendChild($newRelationshipNode);
                    } else {
                        //Check that the id does not conflict with an existing Id in the original rels file
                        $queryId = '//rels:Relationship[@Id="' . $currentId . '"]';
                        $currentIdNodes = $originalXPath->query($queryId);
                        if ($currentIdNodes->length == 0) {
                            $newRelationshipNode = $myOriginalRels->importNode($node, true);
                            $myOriginalRels->documentElement->appendChild($newRelationshipNode);
                        }
                    }
                }
            }
        }
        $query = '//rels:Relationship[@TargetMode]';
        $mergedRelsNodes = $mergedXPath->query($query);
        foreach ($mergedRelsNodes as $node) {
            $currentId = $node->getAttribute('Id');
            //Check that the id does not conflict with an existing Id in the original rels file
            $queryId = '//rels:Relationship[@Id="' . $currentId . '"]';
            $currentIdNodes = $originalXPath->query($queryId);
            if ($currentIdNodes->length == 0) {
                $queryId = '//rels:Relationship[@Id="' . $curentId . '"]';
                $newRelationshipNode = $myOriginalRels->importNode($node, true);
                $myOriginalRels->documentElement->appendChild($newRelationshipNode);
            }
        }
        return $myOriginalRels->saveXML();
    }

    /**
     * This is the method that replaces the search term.
     * It takes into account that the text may be split among different runs
     * @access private
     * @param DOMNode $paragraph the node to be changed
     * @param string $searchTerm string to be searched and replaced
     * @param string $replaceTerm the replacement text
     * @param array $options for highlighting
     * @return void
     */
    private function replaceString($paragraph, $searchTerm, $replaceTerm)
    {
        $lengthSearchTerm = strlen($searchTerm);
        $lengthReplaceTerm = strlen($replaceTerm);
        $paragraphText = '';
        $textChilds = $paragraph->getElementsByTagName('t');
        foreach ($textChilds as $node) {
            $paragraphText .= $node->nodeValue;
        }
        $results = array();
        $paragraphText = htmlspecialchars($paragraphText);
        $results = $this->getIndexOf($paragraphText, $searchTerm);

        $position = 0;
        foreach ($textChilds as $node) {
            $text = strip_tags($node->ownerDocument->saveXML($node));
            $numChars = strlen($text);
            $offset = 0;
            $affectedNode = 0;
            for ($j = 0; $j < count($results); $j++) {
                //We first check if that particular run may be affected by the replacement
                if (($position + $numChars) > $results[$j] && $position < ($results[$j] + $lengthSearchTerm)) {
                    $affectedNode = 1;
                    if ($position <= $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the string to be replaced falls completely within the scope of this run
                        //The we will extract that ocurrence of the searchTerm and replace it directly by the replaceTerm
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $secondTextChunk = substr($text, $results[$j] - $position + $lengthSearchTerm + $offset);
                        $text = $firstTextChunk . $replaceTerm . $secondTextChunk;
                        //Whenever we make a substitution we have to take into account that the length of the text has changed
                        $offset += $lengthReplaceTerm - $lengthSearchTerm;
                    } else if ($position <= $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced starts in this run but continues in next one
                        $firstTextChunk = substr($text, 0, $results[$j] - $position + $offset);
                        $text = $firstTextChunk . $replaceTerm;
                    } else if ($position > $results[$j] && ($position + $numChars) < ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and continue in other run
                        $text = '';
                    } else if ($position > $results[$j] && ($position + $numChars) >= ($results[$j] + $lengthSearchTerm)) {
                        //In this case the text to be replaced has started in a previous run and finish in this run
                        $text = substr($text, $results[$j] + $lengthSearchTerm - $position);
                        $offset = $results[$j] + $lengthSearchTerm - $position;
                    }
                    $node->nodeValue = $text;
                }
            }
            $position += $numChars;
        }
    }

    /**
     * This is the method that selects the nodes that need to be removed
     * @access private
     * @param XPath $DOMXPath the node to be changed
     * @return void
     */
    private function searchToRemove($xPath, $searchTerm)
    {
        $query = '//w:p';
        $docPs = $xPath->query($query);

        foreach ($docPs as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                if ($node->parentNode->nodeName == 'w:tc') {
                    if ($this->getNumberPChilds($node) < 2) {
                        $emptyP = $node->ownerDocument->createElementNS('http://schemas.openxmlformats.org/wordprocessingml/2006/main', 'w:p');
                        $node->parentNode->appendChild($emptyP);
                    }
                    $node->parentNode->removeChild($node);
                } else {
                    $node->parentNode->removeChild($node);
                }
            }
        }
    }

    /**
     * This is the method that selects the nodes that need to be manipulated
     * and call to the replaceString method
     * @access private
     * @param XPath $DOMXPath the node to be changed
     * @return void
     */
    private function searchToReplace($xPath, $searchTerm, $replaceTerm)
    {
        $query = '//w:p';
        $docPs = $xPath->query($query);
        $searchTerm = htmlspecialchars($searchTerm);
        $replaceTerm = htmlspecialchars($replaceTerm);

        foreach ($docPs as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                $this->replaceString($node, $searchTerm, $replaceTerm);
            }
        }
    }

    /**
     * This is the method that selects the nodes that need to be manipulated
     * and call to the highlightString method
     * @access private
     * @param XPath $DOMXPath the node to be changed
     * @return void
     */
    private function searchToHighlight($xPath, $searchTerm)
    {
        $query = '//w:p';
        $docPs = $xPath->query($query);

        foreach ($docPs as $node) {
            $paragraphContents = $node->ownerDocument->saveXML($node);
            $paragraphText = strip_tags($paragraphContents);
            if (($pos = strpos($paragraphText, $searchTerm, 0)) !== false) {
                $this->highlightString($node, $xPath, $searchTerm);
            }
        }
    }

    /**
     * Generates a unique Decimal number
     * @access public
     * @param int $min
     * @param int $max
     * @return int
     */
    public function uniqueDecimal(&$takenIds = array(), $min = 9999, $max = 0)
    {
        if ($max == 0) {
            $max = mt_getrandmax();
        }
        $proposedId = mt_rand($min, $max);
        if (in_array($proposedId, $takenIds)) {
            $proposedId = $this->uniqueDecimal($takenIds, $min, $max);
        }
        $takenIds[] = $proposedId;
        return $proposedId;
    }

    /**
     * Adds a watermark to an existing Word document
     * @access public
     * @param string $source path to the docx
     * @param string $target path to the resulting watermarked docx
     * @param string $type
     * Values: text, image
     * @param array $options
     * If type equals image
     * Values: string 'image' path to the watermark image
     * string 'height' watermark image height in pixels (optional)
     * string 'width' watermark image widht in pixels (optional)
     * boolean 'decolorate' if true (default) decolorates the image
     * string 'gain' hexadecimal value (optional)
     * string 'blacklevel' hexadecimal value (optional)
     * boolean 'remove_previous_watermarks' if true (default value) removes previous existing watermarks (optional)    
     * If type equals text
     * Values: string 'text' text used for the watermark
     * string 'text_orientation' (diagonal, horizontal) if not set defaults to diagonal
     * string 'height' watermark image height in pixels (optional)
     * string 'width' watermark image widht in pixels (optional)
     * string 'font' font-family (optional) if not set defaults to Calibri
     * string 'color' hexadecimal value or color name (optional)
     * decimal 'opacity' decimal number between 0 and 1(optional), if not set defaults to 0.5
     * boolean 'remove_previous_watermarks' if true (default value) removes previous existing watermarks (optional)
     * @return boolean
     */
    public function watermarkDocx($source, $target, $type = 'text', $options = array())
    {
        //we make a copy of the source document into its final destination so we do not overwrite it
        copy($source, $target);
        //we extract the relevant files for the watermarking process
        $this->_watermarkDocx = new \ZipArchive();
        $this->_watermarkDocx->open($target);

        $this->_watermarkDocxDocumentXML = $this->_watermarkDocx->getFromName('word/document.xml');
        $this->_watermarkDocxRelsXML = $this->_watermarkDocx->getFromName('word/_rels/document.xml.rels');
        $this->_watermarkDocxContentTypesXML = $this->_watermarkDocx->getFromName('[Content_Types].xml');

        $this->_watermarkDocxContentTypesDOM = new \DOMDocument();
        $this->_watermarkDocxDocumentDOM = new \DOMDocument();
        $this->_watermarkDocxRelsDOM = new \DOMDocument();

        $this->_watermarkDocxContentTypesDOM->loadXML($this->_watermarkDocxContentTypesXML);
        $this->_watermarkDocxDocumentDOM->loadXML($this->_watermarkDocxDocumentXML);
        $this->_watermarkDocxRelsDOM->loadXML($this->_watermarkDocxRelsXML);

        $this->_sectionHeaders = array();

        //We parse the sections of the document.xml to get all section info and headers
        //we also need to parse the _rels and content types 
        $this->_watermarkRelsXPath = new \DOMXPath($this->_watermarkDocxRelsDOM);
        $this->_watermarkRelsXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');

        $this->_watermarkDocXpath = new \DOMXPath($this->_watermarkDocxDocumentDOM);
        $this->_watermarkDocXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $this->_watermarkDocXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');

        $this->_watermarkContentTypesXPath = new \DOMXPath($this->_watermarkDocxContentTypesDOM);
        $this->_watermarkContentTypesXPath->registerNamespace('ct', 'http://schemas.openxmlformats.org/package/2006/content-types');

        //If the watermark is an image we need to copy it in the media folder with a unique name
        //We have also to make sure that the Default type for the image extension exists
        if ($type == 'image') {
            $imageId = uniqid(mt_rand(999, 9999));
            $ext = array('jpg', 'jpeg', 'gif', 'png', 'bmp', 'wmf');
            $image = $options['image'];
            $imageArray = explode('.', $image);
            $extension = array_pop($imageArray);
            if (!in_array($extension, $ext)) {
                exit('Invalid image extension');
            }
            if (strpos($this->_watermarkDocxContentTypesXML, 'Extension="' . $extension . '"') === false) {
                $default = '<Default Extension="' . $extension . '" ContentType="image/' . $extension . '" />';
                $ctFragment = $this->_watermarkDocxContentTypesDOM->createDocumentFragment();
                $ctFragment->appendXML($default);
                $this->_watermarkDocxContentTypesDOM->documentElement->appendChild($ctFragment);
            }
            //We copy the image in the media folder
            $imageData = file_get_contents($options['image']);
            $this->_watermarkDocx->addFromString('word/media/image' . $imageId . '.' . $extension, $imageData);
        }
        //Extract section properties nodes
        $query = '//w:sectPr';
        $sectNodes = $this->_watermarkDocXpath->query($query);
        $mumSects = $sectNodes->length;
        $counter = 0;
        foreach ($sectNodes as $node) {
            $headerNodes = $node->getElementsByTagName('headerReference');
            if ($headerNodes->length > 0) {
                foreach ($headerNodes as $header) {
                    $id = $header->getAttribute('r:id');
                    $query = '//rels:Relationship[@Id="' . $id . '"]';
                    $target = $this->_watermarkRelsXPath->query($query)->item(0)->getAttribute('Target');
                    //We call the method that does the inserions in the header files
                    if ($type == 'text') {
                        $this->watermarkInsertText($this->_watermarkDocx, $options, $target, '');
                    } else if ($type == 'image') {
                        $this->watermarkInsertImage($this->_watermarkDocx, $options, $target, '', $imageId);
                    } else {
                        exit('Unknown watermark type');
                    }
                }
            } else {//we have to create the header and the corresponding headerReferenceNode
                //First we include the corresponding node in the section properties
                $newId = uniqid(mt_rand(999, 9999));
                $rId = 'rId' . $newId;
                $refString = '<w:headerReference xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" w:type="default" r:id="' . $rId . '" />';
                $headerRefFragment = $this->_watermarkDocxDocumentDOM->createDocumentFragment();
                $headerRefFragment->appendXML($refString);
                $node->insertBefore($headerRefFragment, $node->firstChild);
                //We now create the header file
                $headerFile = 'header' . $newId . '.xml';
                $headerContents = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?> 
                                       <w:hdr xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006" 
                                              xmlns:o="urn:schemas-microsoft-com:office:office" 
                                              xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" 
                                              xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" 
                                              xmlns:v="urn:schemas-microsoft-com:vml" 
                                              xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" 
                                              xmlns:w10="urn:schemas-microsoft-com:office:word" 
                                              xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" 
                                              xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
                                       </w:hdr>';
                //In this case we need to insert this new header in the rels file
                $relation = '<Relationship Id="' . $rId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header" Target="header' . $newId . '.xml" />';
                $relsFragment = $this->_watermarkDocxRelsDOM->createDocumentFragment();
                $relsFragment->appendXML($relation);
                $this->_watermarkDocxRelsDOM->documentElement->appendChild($relsFragment);
                $target = 'header' . $newId . '.xml';
                //We should now add that header to [ContentTypes].xml         
                $override = '<Override PartName="/word/header' . $newId . '.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml" />';
                $ctFragment = $this->_watermarkDocxContentTypesDOM->createDocumentFragment();
                $ctFragment->appendXML($override);
                $this->_watermarkDocxContentTypesDOM->documentElement->appendChild($ctFragment);

                //We call the method that does the inserions in the header files
                if ($type == 'text') {
                    $this->watermarkInsertText($this->_watermarkDocx, $options, $target, $headerContents);
                } else if ($type == 'image') {
                    $this->watermarkInsertImage($this->_watermarkDocx, $options, $target, $headerContents, $imageId);
                } else {
                    exit('Unknown watermark type');
                }
            }
        }

        //We insert the document.xml, document.xml.rels and [Content_Types].xml into the zip
        $this->_watermarkDocx->addFromString('word/document.xml', $this->_watermarkDocxDocumentDOM->saveXML());
        $this->_watermarkDocx->addFromString('word/_rels/document.xml.rels', $this->_watermarkDocxRelsDOM->saveXML());
        $this->_watermarkDocx->addFromString('[Content_Types].xml', $this->_watermarkDocxContentTypesDOM->saveXML());

        //We close now the zip file
        return $this->_watermarkDocx->close();
    }

    /**
     * Inserts the watermark image in a header.xml 
     * @access private
     * @param ZipArchive $zip 
     * @param array $options
     * Values: string 'image' path to the watermark image
     * string 'height' watermark image height in pixels (optional)
     * string 'width' watermark image widht in pixels (optional)
     * boolean 'decolorate' if true (default) decolorates the image
     * string 'gain' hexadecimal value (optional)
     * string 'blacklevel' hexadecimal value (optional)
     * boolean 'remove_previous_watermarks' if true (default value) removes previous existing watermarks (optional)
     * @param string $headerFile
     * @param string $headerContents
     * @param string $imageId
     */
    private function watermarkInsertImage($zip, $options, $headerFile, $headerContents, $imageId)
    {
        //We get the contents of the header file
        if ($headerContents == '') {
            $headerContents = $zip->getFromName('word/' . $headerFile);
        }
        $headerDOM = new \DOMDocument();
        $headerDOM->loadXML($headerContents);
        //set up options
        //text to be inserted
        if (isset($options['image'])) {
            $image = $options['image'];
            $imageArray = explode('.', $image);
            $extension = array_pop($imageArray);
        } else {
            exit('There is no image path');
        }
        //height and width
        if (isset($options['height'])) {
            $height = $options['height'];
        } else {
            $size = getimagesize($options['image']);
            $height = round($size[1] * 0.75) . 'pt';
        }
        if (isset($options['width'])) {
            $width = $options['width'];
        } else {
            $size = getimagesize($options['image']);
            $width = round($size[0] * 0.75) . 'pt';
        }
        //decolorate
        if (isset($options['decolorate'])) {
            $decolorate = $options['decolorate'];
        } else {
            $decolorate = true;
        }
        //gain
        if (isset($options['gain'])) {
            $gain = $options['gain'];
        } else {
            $gain = '19661f';
        }
        //blacklevel
        if (isset($options['blacklevel'])) {
            $blacklevel = $options['blacklevel'];
        } else {
            $blacklevel = '22938f';
        }
        //remove existing watermarks
        if (isset($options['remove_previous_watermarks'])) {
            $remove_previous_watermarks = $options['remove_previous_watermarks'];
        } else {
            $remove_previous_watermarks = true;
        }

        //Construct the required XML nodes for the watermark image
        $rId = 'rId' . $imageId;
        if ($decolorate) {
            $waterImage = '<v:imagedata r:id="' . $rId . '" o:title="' . uniqid(mt_rand(999, 9999)) . '" gain="' . $gain . '" blacklevel="' . $blacklevel . '" />';
        } else {
            $waterImage = '<v:imagedata r:id="' . $rId . '" o:title="' . uniqid(mt_rand(999, 9999)) . '" />';
        }
        $xmlWatermark = '<w:p xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:o="urn:schemas-microsoft-com:office:office" >
                            <w:r>
                                <w:rPr>
                                    <w:noProof/>
                                </w:rPr>
                                <w:pict>
                                  <v:shape id="WordPictureWatermark' . $imageId . '" type="#_x0000_t75" style="position:absolute;margin-left:0;margin-top:0;width:' . $width . ';height:' . $height . ';z-index:-251656192;mso-position-horizontal:center;mso-position-horizontal-relative:margin;mso-position-vertical:center;mso-position-vertical-relative:margin" o:allowincell="f">'
                . $waterImage .
                '</v:shape>
                                </w:pict>
                              </w:r>
                            </w:p>';

        $watermarkFragment = $headerDOM->createDocumentFragment();
        $watermarkFragment->appendXML($xmlWatermark);
        if ($remove_previous_watermarks) {
            $headerXpath = new \DOMXPath($headerDOM);
            $headerXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            $headerXpath->registerNamespace('ve', 'http://schemas.openxmlformats.org/markup-compatibility/2006');
            $headerXpath->registerNamespace('o', 'urn:schemas-microsoft-com:office:office');
            $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            $headerXpath->registerNamespace('m', 'http://schemas.openxmlformats.org/officeDocument/2006/math');
            $headerXpath->registerNamespace('wne', 'http://schemas.microsoft.com/office/word/2006/wordml');
            $headerXpath->registerNamespace('v', 'urn:schemas-microsoft-com:vml');
            $headerXpath->registerNamespace('wp', 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing');
            $headerXpath->registerNamespace('w10', 'urn:schemas-microsoft-com:office:word');
            $query = '//v:shape[@type="#_x0000_t136"] | //v:shape[@type="#_x0000_t75"]';
            $watermarkNodes = $headerXpath->query($query);
            foreach ($watermarkNodes as $waterNode) {
                $waterNode->parentNode->parentNode->parentNode->parentNode->removeChild($waterNode->parentNode->parentNode->parentNode);
            }
        }
        $headerDOM->documentElement->appendChild($watermarkFragment);
        //We add the header file to the docx
        $zip->addFromString('word/' . $headerFile, $headerDOM->saveXML());

        //We update the corresponding rels file
        $headerRels = $zip->getFromName('word/_rels/' . $headerFile . '.rels');
        //If there is no rels file we create it
        if (!$headerRels) {
            $headerRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?> 
                             <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
                             </Relationships>';
        }
        $relsDOM = new \DOMDocument();
        $relsDOM->loadXML($headerRels);
        $relsString = '<Relationship Id="' . $rId . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/image' . $imageId . '.' . $extension . '" />';
        $relsFragment = $relsDOM->createDocumentFragment();
        $relsFragment->appendXML($relsString);
        $relsDOM->documentElement->appendChild($relsFragment);
        $zip->addFromString('word/_rels/' . $headerFile . '.rels', $relsDOM->saveXML());
    }

    /**
     * Inserts the watermark text in a header.xml file
     * @access private
     * @param ZipArchive $zip 
     * @param array $options
     * Values: string 'text' text used for the watermark
     * string 'text_orientation' (diagonal, horizontal) if not set defaults to diagonal
     * string 'height' watermark image height in pixels (optional)
     * string 'width' watermark image widht in pixels (optional)
     * string 'font' font-family (optional) if not set defaults to Calibri
     * string 'color' hexadecimal value or color name (optional)
     * decimal 'opacity' decimal number between 0 and 1(optional), if not set defaults to 0.5
     * boolean 'remove_previous_watermarks' if true (default value) removes previous existing watermarks (optional)
     * @param string $headerFile
     * @param string $headerContents
     */
    private function watermarkInsertText($zip, $options, $headerFile, $headerContents)
    {
        //We get the contents of the header file
        if ($headerContents == '') {
            $headerContents = $zip->getFromName('word/' . $headerFile);
        }
        $headerDOM = new \DOMDocument();
        $headerDOM->loadXML($headerContents);
        //set up options
        //text to be inserted
        if (isset($options['text'])) {
            $text = $options['text'];
        } else {
            $text = 'DRAFT';
        }
        //Text orientation
        if (isset($options['text_orientation']) &&
                $options['text_orientation'] == 'horizontal') {
            $orientation = 0;
        } else {
            $orientation = 315;
        }
        //height and width
        if (isset($options['height'])) {
            $height = $options['height'] . 'pt';
        } else {
            $height = '247pt';
        }
        if (isset($options['width'])) {
            $width = $options['width'] . 'pt';
        } else {
            $width = '412pt';
        }
        //font family
        if (isset($options['font'])) {
            $font = $options['font'];
        } else {
            $font = 'Calibri';
        }
        //color
        if (isset($options['color'])) {
            $color = $options['color'];
        } else {
            $color = 'silver';
        }
        //opacity
        if (isset($options['opacity'])) {
            $opacity = $options['opacity'];
        } else {
            $opacity = '0.5';
        }
        //remove existing watermarks
        if (isset($options['remove_previous_watermarks'])) {
            $remove_previous_watermarks = $options['remove_previous_watermarks'];
        } else {
            $remove_previous_watermarks = true;
        }

        //Construct the required XML nodes for the watermark text
        $xmlWatermark = '<w:p xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:o="urn:schemas-microsoft-com:office:office" >
                            <w:r>
                                <w:rPr>
                                    <w:noProof/>
                                </w:rPr>
                                <w:pict>
                                  <v:shape id="PowerPlusWaterMarkObject' . uniqid(mt_rand(999, 9999)) . '" type="#_x0000_t136" style="position:absolute;margin-left:0;margin-top:0;width:' . $width . ';height:' . $height . ';rotation:' . $orientation . ';z-index:-251656192;mso-position-horizontal:center;mso-position-horizontal-relative:margin;mso-position-vertical:center;mso-position-vertical-relative:margin" o:allowincell="f" fillcolor="' . $color . '" stroked="f">
                                    <v:fill opacity="' . $opacity . '"/>
                                    <v:textpath string="' . $text . '" style="font-family:&quot;' . $font . '&quot;;font-size:1pt"/>
                                  </v:shape>
                                </w:pict>
                              </w:r>
                            </w:p>';

        $watermarkFragment = $headerDOM->createDocumentFragment();
        $watermarkFragment->appendXML($xmlWatermark);
        if ($remove_previous_watermarks) {
            $headerXpath = new \DOMXPath($headerDOM);
            $headerXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            $headerXpath->registerNamespace('ve', 'http://schemas.openxmlformats.org/markup-compatibility/2006');
            $headerXpath->registerNamespace('o', 'urn:schemas-microsoft-com:office:office');
            $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
            $headerXpath->registerNamespace('m', 'http://schemas.openxmlformats.org/officeDocument/2006/math');
            $headerXpath->registerNamespace('wne', 'http://schemas.microsoft.com/office/word/2006/wordml');
            $headerXpath->registerNamespace('v', 'urn:schemas-microsoft-com:vml');
            $headerXpath->registerNamespace('wp', 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing');
            $headerXpath->registerNamespace('w10', 'urn:schemas-microsoft-com:office:word');
            $query = '//v:shape[@type="#_x0000_t136"] | //v:shape[@type="#_x0000_t75"]';
            $watermarkNodes = $headerXpath->query($query);
            foreach ($watermarkNodes as $waterNode) {
                $waterNode->parentNode->parentNode->parentNode->parentNode->removeChild($waterNode->parentNode->parentNode->parentNode);
            }
        }
        $headerDOM->documentElement->appendChild($watermarkFragment);
        //We add the header file to the docx
        $zip->addFromString('word/' . $headerFile, $headerDOM->saveXML());
    }

    /**
     * Removes all watermark from an existing Word document
     * @access public
     * @param string $source path to the docx
     * @param string $target path to the resulting unwatermarked docx
     * @return boolean
     */
    public function watermarkRemove($source, $target)
    {
        //we make a copy of the source document into its final destination so we do not overwrite it
        copy($source, $target);
        //we extract the relevant files for the unwatermarking process
        $this->_watermarkDocx = new \ZipArchive();
        $this->_watermarkDocx->open($target);

        $this->_watermarkDocxDocumentXML = $this->_watermarkDocx->getFromName('word/document.xml');
        $this->_watermarkDocxRelsXML = $this->_watermarkDocx->getFromName('word/_rels/document.xml.rels');

        $this->_watermarkDocxDocumentDOM = new \DOMDocument();
        $this->_watermarkDocxRelsDOM = new \DOMDocument();

        $this->_watermarkDocxDocumentDOM->loadXML($this->_watermarkDocxDocumentXML);
        $this->_watermarkDocxRelsDOM->loadXML($this->_watermarkDocxRelsXML);

        $this->_sectionHeaders = array();

        //We parse the sections of the document.xml to get all section info and headers
        //we also need to parse the _rels 
        $this->_watermarkRelsXPath = new \DOMXPath($this->_watermarkDocxRelsDOM);
        $this->_watermarkRelsXPath->registerNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');

        $this->_watermarkDocXpath = new \DOMXPath($this->_watermarkDocxDocumentDOM);
        $this->_watermarkDocXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
        $this->_watermarkDocXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');

        //Extract section properties nodes
        $query = '//w:sectPr';
        $sectNodes = $this->_watermarkDocXpath->query($query);
        $mumSects = $sectNodes->length;
        $counter = 0;
        foreach ($sectNodes as $node) {
            $headerNodes = $node->getElementsByTagName('headerReference');
            if ($headerNodes->length > 0) {
                foreach ($headerNodes as $header) {
                    $id = $header->getAttribute('r:id');
                    $query = '//rels:Relationship[@Id="' . $id . '"]';
                    $target = $this->_watermarkRelsXPath->query($query)->item(0)->getAttribute('Target');
                    //We now open the corresponding header.xml 
                    $headerContents = $this->_watermarkDocx->getFromName('word/' . $target);
                    $headerDOM = new \DOMDocument();
                    $headerDOM->loadXML($headerContents);
                    $headerXpath = new \DOMXPath($headerDOM);
                    $headerXpath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
                    $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
                    $headerXpath->registerNamespace('ve', 'http://schemas.openxmlformats.org/markup-compatibility/2006');
                    $headerXpath->registerNamespace('o', 'urn:schemas-microsoft-com:office:office');
                    $headerXpath->registerNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships');
                    $headerXpath->registerNamespace('m', 'http://schemas.openxmlformats.org/officeDocument/2006/math');
                    $headerXpath->registerNamespace('wne', 'http://schemas.microsoft.com/office/word/2006/wordml');
                    $headerXpath->registerNamespace('v', 'urn:schemas-microsoft-com:vml');
                    $headerXpath->registerNamespace('wp', 'http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing');
                    $headerXpath->registerNamespace('w10', 'urn:schemas-microsoft-com:office:word');
                    $query = '//v:shape[@type="#_x0000_t136"] | //v:shape[@type="#_x0000_t75"]';
                    $watermarkNodes = $headerXpath->query($query);
                    foreach ($watermarkNodes as $waterNode) {
                        $waterNode->parentNode->parentNode->parentNode->parentNode->removeChild($waterNode->parentNode->parentNode->parentNode);
                    }
                    $this->_watermarkDocx->addFromString('word/' . $target, $headerDOM->saveXML());
                }
            }
        }

        //We close now the zip file
        return $this->_watermarkDocx->close();
    }

    /**
     * Replaces chart data from an existing Word document
     * @access public
     * @param string $source path to the docx
     * @param string $target path to the resulting docx
     * @param array which key is the number of the chart to replace and the value is an array of chart values
     * @return boolean
     */
    public function replaceChartData($source, $target, $chartData)
    {
        //we make a copy of the source document into its final destination so we do not overwrite it
        copy($source, $target);

        $zip = new \ZipArchive();
        $zip->open($target);

        $document = $zip->getFromName('word/document.xml');

        $domDocument = new \DomDocument();
        $domDocument->loadXML($document);

        $relsDocument = $zip->getFromName('word/_rels/document.xml.rels');

        $relsDomDocument = new \DomDocument();
        $relsDomDocument->loadXML($relsDocument);
        $relsXPath = new \DOMXPath($relsDomDocument);
        $relsXPath->registerNamespace('rel', 'http://schemas.openxmlformats.org/package/2006/relationships');


        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/drawingml/2006/chart', 'chart'
        );
        $idCharts = array();
        for ($i = 0; $i < $xmlWP->length; $i++) {
            $idCharts[] = $xmlWP->item($i)->attributes->getNamedItemNS("http://schemas.openxmlformats.org/officeDocument/2006/relationships", 'id')->nodeValue;
        }

        foreach ($chartData as $idChart => $data) {
            if (!isset($idCharts[$idChart])) {
                echo "The " . $idChart . " index does not exist\n";
                exit();
            }
            $query = '//rel:Relationship[@Id="' . $idCharts[$idChart] . '"]';
            $chartNode = $relsXPath->query($query)->item(0)->getAttribute('Target');
            $chartName = 'word/' . $chartNode;
            $chartXml = $zip->getFromName($chartName);

            $domChart = new \DomDocument();
            $domChart->loadXML($chartXml);

            $xmlWP = $domChart->getElementsByTagNameNS(
                    'http://schemas.openxmlformats.org/drawingml/2006/chart', 'plotArea'
            );
            $nodePlotArea = $xmlWP->item(0);

            foreach ($nodePlotArea->childNodes as $node) {
                if (strpos($node->nodeName, 'Chart') !== false) {
                    list($namespace, $type) = explode(':', $node->nodeName);
                    break;
                }
            }
            $graphic = CreateChartFactory::createObject($type);
            $onlyData = $graphic->prepareData($data);

            $tags = $graphic->dataTag();

            $xpath = new \DOMXPath($domChart);
            $xpath->registerNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');
            $i = 0;
            foreach ($tags as $tag) {
                $query = '//c:' . $tag . '/c:numRef/c:numCache/c:pt/c:v';
                $xmlGraphics = $xpath->query($query, $domChart);
                foreach ($xmlGraphics as $entry) {
                    $entry->nodeValue = $onlyData[$i];
                    $i++;
                }
            }
            $chartXml = $domChart->saveXML();
            $zip->addFromString($chartName, $chartXml);
            //prepare the new excel file
            $excel = $graphic->getXlsxType();

            if ($excel->createXlsx('datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx', $data)) {
                $zip->addFile(
                        'datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx', 'word/embeddings/datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx'
                );
            }
        }
        $zip->close();
        foreach ($chartData as $idChart => $data) {
            unlink('datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx');
        }
    }

    /**
     * To add support of sys_get_temp_dir for PHP versions under 5.2.1
     * 
     * @access private
     * @return string
     */
    public function getTempDir()
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

}
