<?php
namespace Phpdocx\Transform;
use Phpdocx\Clean\CleanTemp;
use Phpdocx\Create\CreateDocx;
use Phpdocx\Logger\PhpdocxLogger;
use Phpdocx\Parse\RepairPDF;
use Phpdocx\Utilities\PhpdocxUtilities;


/**
 * Transform DOCX to PDF, ODT, SXW, RTF, DOC, TXT, HTML or WIKI
 *
 * @category   Phpdocx
 * @package    trasform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.08.04
 * @link       http://www.phpdocx.com
 */

abstract class TransformDocAdv
{

    /**
     *
     * @access protected
     * @var ZipArchive
     */
    protected $_allowedExtensions;

    /**
     *
     * @access protected
     * @var array
     */
    protected $_phpdocxconfig;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        $this->_phpdocxconfig = PhpdocxUtilities::parseConfig();
        $this->_allowedExtensions = array('docx', 'pdf', 'odt', 'sxw', 'rtf', 'doc', 'txt', 'html', 'htm', 'wiki');
    }

    /**
     * Prepare docx before pdf transformation
     *
     * @access public
     * @param $docSource
     * @param $temdir
     * @return string
     */
    public function prepareDocx($docSource, $tempDir = null, $options)
    {
        if ($tempDir === null) {
            $tempDir = $this->getTempDirPath();
            $tempName = $tempDir . '/tempDocX_' . uniqid() . '.docx';
        } else {
            $tempName = $tempDir . '/tempDocX_' . uniqid() . '.docx';
        }
        copy($docSource, $tempName);


        if (file_exists(dirname(__FILE__) . '/../Parse/RepairPDF.inc')) {
            $originalDocx = new \ZipArchive();
            $originalDocx->open($tempName);
            $docXML = $originalDocx->getFromName('word/document.xml');
            $numberingXML = $originalDocx->getFromName('word/numbering.xml');
            $repairedXML = \Phpdocx\Parse\RepairPDF::repairPDFConversion($docXML, $numberingXML, $options);
            $originalDocx->addFromString('word/document.xml', $repairedXML);
            //close the zip
            $originalDocx->close();
        }

        return $tempName;
    }

    /**
     * Replace charts as images
     *
     * @access public
     * @param $docSource
     */
    public function replaceChartsWithImages($docSource){
        $sourceDocx = new \ZipArchive();
        $sourceDocx->open($docSource);

        // if jpgraph exists use it, instead use ezComponents
        if (file_exists(dirname(__FILE__) . '/../../../lib/jpgraph/')) {
            $image = new CreateChartImageJpgraph();
        } else {
            $image = new CreateChartImageEzComponents();
        }

        // get the images
        $image->getChartsDocx($docSource);
        $image->parseCharts();
        $listChartImages = $image->getListImages();
        if (!is_array($listChartImages)) {
            $listChartImages = array();
        }

        // parse de docx and add the images
        $contentTypesXML = $sourceDocx->getFromName('[Content_Types].xml');

        // get the document.xml.rels file from the DOCX
        $documentRelsXML = $sourceDocx->getFromName('word/_rels/document.xml.rels');
        $documentRelsDOM = new \SimpleXMLElement($documentRelsXML);
        $documentRelsDOM->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/relationships');

        // get the document.xml file from the DOCX
        $documentXML = $sourceDocx->getFromName('word/document.xml');
        $documentDOM = new \SimpleXMLElement($documentXML);

        // get the chart elements of the DOM
        $contentTypesDOM = new \SimpleXMLElement($contentTypesXML);
        $contentTypesDOM->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/content-types');
        $elementsCharts = $contentTypesDOM->xpath('ns:Override[@ContentType="application/vnd.openxmlformats-officedocument.drawingml.chart+xml"]');

        // as some nodes are removed, iterate the charts in reverse order
        //$elementsCharts = array_reverse($elementsCharts);

        // index of the image to be added to the ZIP
        $indexImage = 0;
        foreach ($elementsCharts as $value) {
            // get the attributes of the element
            $attributes = $value->attributes();

            // get the width and height and add them to the charts array
            // get the rId of the chart from the documentRels
            $relationshipChart = $documentRelsDOM->xpath('ns:Relationship[@Target="'.substr($attributes['PartName'], 6).'"]');
            $documentDOM->registerXPathNamespace('a', 'http://schemas.openxmlformats.org/drawingml/2006/main');
            $documentDOM->registerXPathNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');

            // get the a:graphicData element of the chart
            $elementAGraphicData = $documentDOM->xpath('//a:graphicData[c:chart[@r:id="'. $relationshipChart[0]->attributes()->Id . '"]]');
            $elementAGraphicData[0]['uri'] = 'http://schemas.openxmlformats.org/drawingml/2006/picture';

            //get and remove the c:chart child
            $elementAGraphicData[0]->registerXPathNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');
            $elementCChart = $elementAGraphicData[0]->xpath('//c:chart');
            //unset($elementCChart[0][0]);

            // remove the chart content keeping w:drawing tag
            $domElementAGraphicData = dom_import_simplexml($elementAGraphicData[0]);
            $picture = $this->getTemplateImage(uniqid(), $relationshipChart[0]->attributes()->Id);
            $pictureFragment = $domElementAGraphicData->ownerDocument->createDocumentFragment();
            $pictureFragment->appendXML($picture);
            $domElementAGraphicData->appendChild($pictureFragment);
            $sourceDocx->addFile($listChartImages[$indexImage], 'word/media/' . $listChartImages[$indexImage]);
             
            //Modify the Type attribute of document.xml.rels to http://schemas.openxmlformats.org/officeDocument/2006/relationships/image
            //and the Target to media/'.$listChartImages[$indexImage]
            $relsImage = $documentRelsDOM->xpath('//ns:Relationship[@Id="'. $relationshipChart[0]->attributes()->Id.'"]');
            $relsImage[0]['Type'] = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/image';
            $relsImage[0]['Target'] = 'media/' . $listChartImages[$indexImage];
            
            $indexImage++; 
        }

        // save the modified document.xml.rels file
        $docXML = $documentDOM->asXML();
        $docXML = str_replace('<pic:pic xmlns:r="http://schemas.openxmlformats.org/package/2006/relationships" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">', '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">', $docXML);
        $docXML = str_replace('<pic:pic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">', '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">', $docXML);
        $docXML = str_replace('<pic:pic xmlns:r="http://schemas.openxmlformats.org/package/2006/relationships" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"', '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">', $docXML);
        $sourceDocx->addFromString('word/document.xml', $docXML);
        
        // save the modified document.xml.rels file
        $relsDoc = $documentRelsDOM->asXML();
        $sourceDocx->addFromString('word/_rels/document.xml.rels', $relsDoc);
               
        // make sure that there is the associated content type "png"
        $position = strpos('Extension="png"', $contentTypesXML);
        if($position === false){
            $contentTypesXML = str_replace('</Types>',  '<Default Extension="png" ContentType="image/png"/></Types>', $contentTypesXML);
            $sourceDocx->addFromString('[Content_Types].xml', $contentTypesXML);
        }
        // close the zip
        $sourceDocx->close();

        // remove the generated images
        foreach ($listChartImages as $listChartImage) {
            unlink($listChartImage);
        }
    }

    /**
     * Transform DOCX to PDF, ODT, SXW, RTF, DOC, TXT, HTML or WIKI
     *
     * @access public
     * @param $docSource
     * @param $docDestination
     * @param string $tempDir
     * @param array $options
     * @param string $version 32, 64 or null (default). If null autodetect
     * @return void
     */
    abstract public function transformDocument($docSource, $docDestination, $tempDir = null, $options = array(), $version = null);

    /**
     * To add support of sys_get_temp_dir for PHP versions under 5.2.1
     *
     * @access protected
     * @return string
     */
    protected function getTempDirPath()
    {
        if ($this->_phpdocxconfig['settings']['temp_path']) {
            return $this->_phpdocxconfig['settings']['temp_path'];
        }
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
     * 
     */
    protected function getTemplateImage($name, $id)
    {
        $templateImage = '<pic:pic xmlns:r="http://schemas.openxmlformats.org/package/2006/relationships" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
                    <pic:nvPicPr>
                        <pic:cNvPr id="0" name="' . $name .'"/>
                        <pic:cNvPicPr/>
                    </pic:nvPicPr>
                    <pic:blipFill>
                        <a:blip r:embed="' . $id . '"/>
                        <a:stretch>
                            <a:fillRect/>
                        </a:stretch>
                    </pic:blipFill>
                    <pic:spPr>
                        <a:xfrm>
                            <a:off x="0" y="0"/>
                            <a:ext cx="4876800" cy="3657600"/>
                        </a:xfrm>
                        <a:prstGeom prst="rect">
                            <a:avLst/>
                        </a:prstGeom>
                    </pic:spPr>
                </pic:pic>';
        return $templateImage;
    }

}
