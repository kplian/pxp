<?php
namespace Phpdocx\Parse;
use Phpdocx\Logger\PhpdocxLogger;
/**
 * Repair docx files cleaning, removing or adding content
 *
 * @category   Phpdocx
 * @package    parser
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class Repair
{

    /**
     *
     * @access private
     * @var string
     */
    private static $_instance = NULL;

    /**
     *
     * @access private
     * @var array
     */
    private $_xml = array();

    /**
     * Construct
     *
     * @access private
     */
    private function __construct()
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
            self::$_instance = new Repair();
        }
        return self::$_instance;
    }

    /**
     * Getter XML
     *
     * @access public
     */
    public function getXML()
    {
        return $this->_xml;
    }

    /**
     * Setter XML
     *
     * @access public
     */
    public function setXML($xml)
    {
        $this->_xml = $xml;
    }

    /**
     * Add a paragraph to each element in a table that needs it and betweeen
     * tables
     * 
     * @access public
     * @param  $path File path
     */
    public function addParapraphEmptyTablesTags()
    {
        // add parapraph to <w:tc></w:tc>
        $this->_xml = preg_replace('/<w:tc>[\s]*?<\/w:tc>/', '<w:tc><w:p /></w:tc>', $this->_xml);

        // add parapraph to </w:tbl></w:tc>
        $this->_xml = preg_replace('/<\/w:tbl>[\s]*?<\/w:tc>/', '</w:tbl><w:p /></w:tc>', $this->_xml);

        // add parapraph to </w:tbl><w:tbl>
        $this->_xml = preg_replace('/<\/w:tbl>[\s]*?<w:tbl>/', '</w:tbl><w:p /><w:tbl>', $this->_xml);
    }

    /**
     * Add a paragraph to each element in a table that needs it and betweeen
     * tables
     * 
     * @access public
     * @param  $docXML string
     * @static
     */
    public static function repairTablesPDFConversion($docXML)
    {
        $docDOM = new \DOMDocument();
        $docDOM->loadXML($docXML);
        $tblNodes = $docDOM->getElementsByTagName('tbl');
        foreach ($tblNodes as $tblNode) {
            //0. Check if there is a table grid element with well defined vals
            $repairTable = false;
            $tblGridNodes = $tblNode->getElementsByTagName('tblGrid');
            if ($tblGridNodes->length > 0) {
                $gridColNodes = $tblGridNodes->item(0)->getElementsByTagName('gridCol');
                foreach ($gridColNodes as $gridNode) {
                    $wAttribute = $gridNode->getAttribute('w:w');
                    if (empty($wAttribute)) {
                        $repairTable = true;
                    }
                }
            } else {
                $repairTable = true;
            }
            //1. Determine the total table width
            $tblWNodes = $tblNode->getElementsByTagName('tblW');
            if ($tblWNodes->length > 0) {
                //check if the width is given in twips
                $widthUnits = $tblWNodes->item(0)->getAttribute('w:type');
                if ($widthUnits == 'dxa') {
                    $tableWidth = $tblWNodes->item(0)->getAttribute('w:w');
                } else {
                    $tableWidth = false;
                    PhpdocxLogger::logger('For proper conversion to PDF, tables may not have their width set in percentage.', 'info');
                }
            } else {
                $tableWidth = false;
                PhpdocxLogger::logger('For proper conversion to PDF, tables have to have their width set.', 'info');
            }
            if (!empty($tableWidth) && $repairTable) {
                //2. Extract the rows
                $tableRows = $tblNode->getElementsByTagName('tr');
                $rowNumber = 0;
                $grid = array();
                foreach ($tableRows as $row) {
                    $grid[$rowNumber] = array();
                    $weights[$rowNumber] = array();
                    //3. Extract the cells of each row
                    $cellNodes = $row->getElementsByTagName('tc');
                    foreach ($cellNodes as $cellNode) {
                        $gridSpan = 1;
                        $spanNodes = $cellNode->getElementsByTagName('gridSpan');
                        if ($spanNodes->length > 0) {
                            $span = $spanNodes->item(0)->getAttribute('w:val');
                            if (isset($span) && $span > 1) {
                                $gridSpan = $span;
                            }
                        }
                        $tcWidths = $cellNode->getElementsByTagName('tcW');
                        if ($tcWidths->length > 0) {
                            $widthData = $tcWidths->item(0)->getAttribute('w:w');
                            $widthUnits = $tcWidths->item(0)->getAttribute('w:type');
                            if ($widthUnits == 'dxa') {
                                $cellWidth = $widthData;
                            } else if ($widthUnits == 'pct') {
                                //the width is given in fitieths of a percent
                                $cellWidth = floor($widthData * $tableWidth / 5000);
                            } else {
                                $cellWidth = 0;
                            }
                        } else {
                            $cellWidth = 0;
                        }
                        //let us build the grid and weight arrays for this cell
                        if ($gridSpan > 1) {
                            $cellWidth = floor($cellWidth / $gridSpan);
                            for ($j = 0; $j < $gridSpan; $j++) {
                                $grid[$rowNumber][] = $cellWidth;
                                $weights[$rowNumber][] = 0;
                            }
                        } else {
                            $grid[$rowNumber][] = $cellWidth;
                            $weights[$rowNumber][] = 1;
                        }
                    }
                    $rowNumber++;
                }
                //we have now all the required info to build the gridCol array
                $gridCol = array();
                $rowPos = 0;
                foreach ($grid as $row) {
                    $cellPos = 0;
                    foreach ($row as $cell) {
                        if ($weights[$rowPos][$cellPos] == 1 && !empty($grid[$rowPos][$cellPos])) {
                            $gridCol[$cellPos] = $grid[$rowPos][$cellPos];
                        } else if ($weights[$rowPos][$cellPos] == 0 && !empty($grid[$rowPos][$cellPos]) && empty($gridCol[$cellPos])) {
                            $gridCol[$cellPos] = $grid[$rowPos][$cellPos];
                        }
                        $cellPos++;
                    }
                    $rowPos++;
                }
                //create the tblGrid node node and insert it
                $gridColXML = '<w:tblGrid xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">';
                foreach ($gridCol as $col) {
                    $gridColXML .= '<w:gridCol w:w="' . $col . '"/>';
                }
                $gridColXML .= '</w:tblGrid>';
                //remove any previous tblGrid elements if any
                $tblGridNodes = $tblNode->getElementsByTagName('tblGrid');
                if ($tblGridNodes->length > 0) {
                    $tblGridNodes->item(0)->parentNode->removeChild($tblGridNodes->item(0));
                }
                //insert this node just before the first tr node
                $firstRow = $tblNode->getElementsByTagName('tr')->item(0);
                $gridFragment = $docDOM->createDocumentFragment();
                $gridFragment->appendXML($gridColXML);
                $tblNode->insertBefore($gridFragment, $firstRow);
            }
        }
        return $docDOM->saveXML();
    }

    /**
     * Modifies the DOCXPath selections to avoid validation issues
     * 
     * @access public
     * @param  DOMNode $node
     * @static
     */
    public static function repairDOCXPath($node)
    {
        //modifies the id attribute of the wp:docPr tag to avoid potential conflicts
        $docPrNodes = $node->getElementsByTagName('docPr');
        foreach ($docPrNodes as $docPrNode) {
            $docPrNode->setAttribute('id', rand(999999, 99999999));
        }
        return $node;
    }

}
