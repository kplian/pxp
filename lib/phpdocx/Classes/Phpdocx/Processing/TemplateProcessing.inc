<?php
namespace Phpdocx\Processing;
use Phpdocx\Factory\CreateChartFactory;
use Phpdocx\Logger\PhpdocxLogger;

/**
 * This class allows for the processing of templates prioritizing performance
 * 
 * @category   Phpdocx
 * @package    processing
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class TemplateProcessing
{

    /**
     * @var array
     * @access private
     */
    private $_parsedContent;

    /**
     * @var array
     * @access private
     */
    private $_parsedXML;

    /**
     * @var array
     * @access private
     */
    private $_parsedXMLDOM;

    /**
     * @var array
     * @access private
     */
    private $_templateContent;

    /**
     * @var SimpleXML
     * @access private
     */
    private $_templateRels;

    /**
     * @access private
     * @var string
     * @static
     */
    private static $_templateSymbol = '$';

    /**
     * @var ZipArchive
     * @access private
     */
    private $_templateZip;

    /**
     * @var array
     * @access private
     */
    private $_variableArray;

    /**
     * @var array
     * @access private
     */
    private $_xmlDocuments;

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
     * Performs the substitution of an array of simple text variables by an array of values
     * It only applies to variables within the main document (no headers, footers, footnotes, etcetera)
     * The emphasis is in performance not generality
     *
     * @param array $vars associative array with index the name of the variable
     * @return void
     */
    public function replaceMultiTextVariable($vars)
    {
        $docXML = $this->_parsedXMLDOM['word/document.xml']->asXML();
        foreach ($vars as $key => $value) {
            $search = self::$_templateSymbol . $key . self::$_templateSymbol;
            $docXML = str_replace($search, $value, $docXML);
        }
        $this->_parsedXMLDOM['word/document.xml'] = simplexml_load_string($docXML);
    }

    /**
     * Generates the resulting docx document out from the template
     * @access public
     * @example ../examples/easy/ProcessTemplate.php
     * @param string $fileName name of the target file
     * @return void
     */
    public function generateDocxFromTemplate($fileName)
    {
        // replace the original XML files by the parsed ones
        foreach ($this->_parsedXMLDOM as $path => $xml) {
            $this->_parsedContent[$path] = $xml->saveXML();
        }
        if (!empty($fileName)) {
            $this->generateDocx($this->_parsedContent, $fileName . '.docx');
        } else {
            PhpdocxLogger::logger('You must introduce a name for the target docx file', 'fatal');
        }
    }

    /**
     * This is the main class method that does all the needed previous manipulation to
     * replace all variables in the template
     * @access public
     * @example ../examples/easy/ProcessTemplate.php
     * @param string $template path to the template
     * @param array $variables path to the csv file with the data
     * @param array $options, 
     * Values:
     * 'variables' (array) list of the template PHPDocX variables
     * 'templateSymbol' (string)
     * @return void
     */
    public function processTemplate($template, $options = array())
    {
        if (isset($options['templateSymbol'])) {
            self::$_templateSymbol = $options['templateSymbol'];
        }

        // extract the contents of the template into memory for parsing
        $this->extractTemplateFiles($template);
        $this->_templateRels = simplexml_load_string($this->_templateContent['word/_rels/document.xml.rels']);
        // create the array with all the XML documents that should be parsed
        $this->_xmlDocuments = array();
        $this->_xmlDocuments['word/document.xml'] = $this->_templateContent['word/document.xml'];
        // check if there are headers and footers that should be parsed
        $this->_templateRels->registerXPathNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
        $query = '//rels:Relationship[@Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/header"] | //rels:Relationship[@Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer"]';
        $hfNodes = $this->_templateRels->xpath($query);
        // insert them in the _xmlDocuments array
        for ($j = 0; $j < count($hfNodes); $j++) {
            $this->_xmlDocuments['word/' . (string) $hfNodes[$j]['Target']] = $this->_templateContent['word/' . (string) $hfNodes[$j]['Target']];
        }
        // prepare the PHPDocX variables for replacement
        if (!empty($options['variables'])) {
            $this->repairTemplateVariables($options['variables']);
        }

        // make a copy of the documents we have to insert/modify
        $this->_parsedContent = $this->_templateContent;
        $this->_parsedXML = array();
        $this->_parsedXML = $this->_xmlDocuments;
        //Load the document on SimpleXML
        $this->_parsedXMLDOM = array();
        foreach ($this->_parsedXML as $key => $value) {
            $this->_parsedXMLDOM[$key] = simplexml_load_string($value);
        }
    }

    /**
     * Extracts all the contents from the template file
     *
     * @param string $template
     * @return void
     */
    private function extractTemplateFiles($template)
    {
        $this->_templateZip = new \ZipArchive();
        try {
            $openTemplate = $this->_templateZip->open($template);
            if ($openTemplate !== true) {
                throw new \Exception('Error while opening the template: please, check the path');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        // read each file and create a new array of contents
        for ($i = 0; $i < $this->_templateZip->numFiles; $i++) {
            $this->_templateContent[$this->_templateZip->getNameIndex($i)] = $this->_templateZip->getFromName($this->_templateZip->getNameIndex($i));
        }
    }

    /**
     * Generates a docx out of the parsed files
     *
     * @param array $docxContents
     * @param string $path
     * @return void
     */
    private function generateDocx($docxContents, $path)
    {
        if (file_exists($path)) {
            PhpdocxLogger::logger('You are trying to overwrite an existing file', 'info');
        }
        try {
            $zipDocx = new \ZipArchive();
            $createZip = $zipDocx->open($path, \ZipArchive::CREATE);
            if ($createZip !== true) {
                throw new \Exception('Error trying to generate a docx form template: please, check the path and/or writting permissions');
            }
        } catch (\Exception $e) {
            PhpdocxLogger::logger($e->getMessage(), 'fatal');
        }
        // insert all files in zip
        foreach ($this->_parsedContent as $key => $value) {
            $zipDocx->addFromString($key, $value);
        }
        // close zip
        $zipDocx->close();
    }

    /**
     * Prepares a single PHPDocX variable for substitution
     *
     * @param string $var
     * @param string $content
     * @return string
     */
    private function repairSingleVariable($var, $content)
    {
        $documentSymbol = explode(self::$_templateSymbol, $content);
        foreach ($documentSymbol as $documentSymbolValue) {
            $tempSearch = trim(strip_tags($documentSymbolValue));
            if ($tempSearch == $var) {
                $pos = strpos($content, $documentSymbolValue);
                if ($pos !== false) {
                    $content = substr_replace($content, $var, $pos, strlen($documentSymbolValue));
                }
            }
            if (strpos($documentSymbolValue, 'xml:space="preserve"')) {
                $preserve = true;
            }
        }
        if (isset($preserve) && $preserve) {
            $query = '//w:t[text()[contains(., "' . self::$_templateSymbol . $var . self::$_templateSymbol . '")]]';
            $docDOM = new \DOMDocument();
            $docDOM->loadXML($content);
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
            $content = $docDOM->saveXML($docDOM->documentElement);
        }
        return $content;
    }

    /**
     * Run over the PHPDocX variables array to repair them in case they are broken in the WordML code
     *
     * @param array $varArray
     * @param string $content
     * @return void
     */
    private function repairTemplateVariables($varArray)
    {
        foreach ($varArray as $key => $var) {
            foreach ($this->_xmlDocuments as $file => $content) {
                $this->_xmlDocuments[$file] = $this->repairSingleVariable($var, $content);
            }
        }
    }

    /**
     * Replaces chart data
     * @access public
     * @param array $chartData which key is the number of the chart to replace and the value is an array of chart values
     * @param array $options The posible keys and values are
     *  'modifyLegends'(bool)
     * @return boolean
     */
    public function replaceChartData($chartData, $options = array())
    {
        $relsDOM = new \DOMDocument();
        $relsDOM->loadXML($this->_parsedContent['word/_rels/document.xml.rels']);
        $relsXPath = new \DOMXPath($relsDOM);
        $relsXPath->registerNamespace('rel', 'http://schemas.openxmlformats.org/package/2006/relationships');

        $domDocument = new \DOMDocument();
        $domDocument->loadXML($this->_parsedContent['word/document.xml']);
        $xmlWP = $domDocument->getElementsByTagNameNS(
                'http://schemas.openxmlformats.org/drawingml/2006/chart', 'chart'
        );
        $idCharts = array();
        for ($i = 0; $i < $xmlWP->length; $i++) {
            $idCharts[] = $xmlWP->item($i)->attributes->getNamedItemNS("http://schemas.openxmlformats.org/officeDocument/2006/relationships", 'id')->nodeValue;
        }

        foreach ($chartData as $idChart => $data) {
            if (!isset($idCharts[$idChart])) {
                PhpdocxLogger::logger('The ' . $idChart . ' index does not exist\n', 'fatal');
            }
            $query = '//rel:Relationship[@Id="' . $idCharts[$idChart] . '"]';
            $chartNode = $relsXPath->query($query)->item(0)->getAttribute('Target');
            $chartName = 'word/' . $chartNode;

            $domChart = new \DomDocument();
            $domChart->loadXML($this->_parsedContent[$chartName]);

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

            if ($options['modifyLegends']) {
                $i = 0;
                $arrayLegends = array_keys($data);
                $query = '//c:cat/c:strRef/c:strCache/c:pt/c:v';
                $xmlGraphics = $xpath->query($query, $domChart);
                foreach ($xmlGraphics as $entry) {
                    $entry->nodeValue = $arrayLegends[$i];
                    $i++;
                }
            }
            $this->_parsedContent[$chartName] = $domChart->saveXML();
            $chartNameArray = explode('/', $chartName);
            $shortChartName = substr(array_pop($chartNameArray), 0, -4);
            $charRelsDOM = simplexml_load_string($this->_parsedContent['word/charts/_rels/' . $shortChartName . '.xml.rels']);
            $charRelsDOM->registerXPathNamespace('rels', 'http://schemas.openxmlformats.org/package/2006/relationships');
            $query = '//rels:Relationship[@Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/package"]';
            $xslxNodes = $charRelsDOM->xpath($query);
            $originalXSLX = (string) $xslxNodes[0]['Target'];
            $originalXSLX = substr($originalXSLX, 3);
            unset($this->_parsedContent['word/' . $originalXSLX]);
            $xslxNodes[0]['Target'] = '../embeddings/datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx';
            $this->_parsedContent['word/charts/_rels/' . $shortChartName . '.xml.rels'] = $charRelsDOM->asXML();

            //prepare the new excel file
            $excel = $graphic->getXlsxType();
            if ($excel->createXlsx('datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx', $data)) {
                $this->_parsedContent['word/embeddings/datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx'] = file_get_contents('datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx');
            }
            unlink('datos' . str_replace('rId', '', $idCharts[$idChart]) . '.xlsx');
        }
    }

    /**
     * Do the actual substitution of an image for other image
     * By the time being only in the main document (it may be easily extended)
     * @param string $var
     * @param string $src new image path
     * @return void
     */
    public function replaceImageVariable($var, $src)
    {
        $search = self::$_templateSymbol . $var . self::$_templateSymbol;
        $query = '//wp:docPr[@descr="' . $search . '"]';
        $imageNodes = $this->_parsedXMLDOM['word/document.xml']->xpath($query);
        if (is_array($imageNodes) && count($imageNodes) > 0) {
            $image = dom_import_simplexml($imageNodes[0]);
            $blip = $image->parentNode->getElementsByTagNameNS('http://schemas.openxmlformats.org/drawingml/2006/main', 'blip')->item(0);
            $id = $blip->getAttribute('r:embed');
            $query = '//rels:Relationship[@Id="' . $id . '"]';
            $imagePath = $this->_templateRels->xpath($query);
            $this->_parsedContent['word/' . (string) $imagePath[0]['Target']] = file_get_contents($src);
        }
    }

    /**
     * Do the actual substitution of the list variable by a list of items
     *
     * @param string $var
     * @param array $varValues
     * @return void
     */
    public function replaceListVariable($var, $varValues)
    {
        $search = self::$_templateSymbol . $var . self::$_templateSymbol;
        foreach ($this->_parsedXMLDOM as $key => $dom) {
            $query = '//w:p[w:r/w:t[text()[contains(., "' . $search . '")]]]';
            $foundNodes = $dom->xpath($query);
            foreach ($foundNodes as $node) {
                $domNode = dom_import_simplexml($node);
                foreach ($varValues as $key => $value) {
                    $newNode = $domNode->cloneNode(true);
                    $textNodes = $newNode->getElementsBytagName('t');
                    foreach ($textNodes as $text) {
                        $sxText = simplexml_import_dom($text);
                        $strNode = (string) $sxText;
                        $strNode = str_replace($search, $value, $strNode);
                        $sxText[0] = $strNode;
                    }
                    $domNode->parentNode->insertBefore($newNode, $domNode);
                }
                $domNode->parentNode->removeChild($domNode);
            }
        }
    }

    /**
     * Do the actual substitution of the variables in a 'table set of rows'
     *
     * @param array $vars
     * @return void
     */
    public function replaceTableVariable($vars)
    {
        $varKeys = array_keys($vars[0]);
        $search = array();
        for ($j = 0; $j < count($varKeys); $j++) {
            $search[$j] = self::$_templateSymbol . $varKeys[$j] . self::$_templateSymbol;
        }
        $queryArray = array();
        for ($j = 0; $j < count($search); $j++) {
            $queryArray[$j] = '//w:tr[w:tc/w:p/w:r/w:t[text()[contains(., "' . $search[$j] . '")]]]';
        }
        $query = join(' | ', $queryArray);
        $foundNodes = $this->_parsedXMLDOM['word/document.xml']->xpath($query);
        foreach ($vars as $key => $rowValue) {
            foreach ($foundNodes as $node) {
                $domNode = dom_import_simplexml($node);
                if (!is_object($referenceNode) || !$domNode->parentNode->isSameNode($parentNode)) {
                    $referenceNode = $domNode;
                    $parentNode = $domNode->parentNode;
                }
                $newNode = $domNode->cloneNode(true);
                $textNodes = $newNode->getElementsBytagName('t');
                foreach ($textNodes as $text) {
                    for ($k = 0; $k < count($search); $k++) {
                        $sxText = simplexml_import_dom($text);
                        $strNode = (string) $sxText;
                        if (!empty($rowValue[$varKeys[$k]]) ||
                                $rowValue[$varKeys[$k]] === 0 ||
                                $rowValue[$varKeys[$k]] === "0") {
                            $strNode = str_replace($search[$k], $rowValue[$varKeys[$k]], $strNode);
                        } else {
                            $strNode = str_replace($search[$k], '', $strNode);
                        }
                        $sxText[0] = $strNode;
                    }
                }
                $parentNode->insertBefore($newNode, $referenceNode);
            }
        }
        // remove the original nodes
        foreach ($foundNodes as $node) {
            $domNode = dom_import_simplexml($node);
            $domNode->parentNode->removeChild($domNode);
        }
    }

    /**
     * Do the actual substitution of the variable for its corresponding text
     *
     * @param string $var
     * @param string $val
     * @return void
     */
    public function replaceTextVariable($var, $val)
    {
        $search = self::$_templateSymbol . $var . self::$_templateSymbol;
        foreach ($this->_parsedXMLDOM as $key => $dom) {
            $query = '//w:t[text()[contains(., "' . $search . '")]]';
            $foundNodes = $dom->xpath($query);
            foreach ($foundNodes as $node) {
                $strNode = (string) $node;
                $strNode = str_replace($search, $val, $strNode);
                $node[0] = $strNode;
            }
        }
        // in order to take into account data binding in structured document tags 
        // we should also include docProps/core.xml
        $this->_parsedContent['docProps/core.xml'] = str_replace($search, $val, $this->_parsedContent['docProps/core.xml']);
    }

    /**
     * Checks or unchecks a template checkbox
     *
     * @access public
     * @param array $variables the key is the variable name and the posible values arevalue is 1 (checked) or 0 (unchecked)
     * @param int $value
     */
    public function tickCheckbox($variables)
    {
        $domDoc = $this->_parsedXMLDOM['word/document.xml'];
        $domElement = dom_import_simplexml($domDoc);
        $dom = $domElement->ownerDocument;
        $docXPath = new \DOMXPath($dom);
        foreach ($variables as $var => $value) {
            $searchTerm = self::$_templateSymbol . $var . self::$_templateSymbol;
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
        }
    }

}
