<?php
namespace Phpdocx\Parse;
use Phpdocx\Logger\PhpdocxLogger;
use Phpdocx\Resources\OOXMLResources;
/**
 * Repair docx files cleaning, removing or addind content
 *
 * @category   Phpdocx
 * @package    parser
 * @copyright  Copyright (c) 2009-2013 Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class RepairPDF
{

    /**
     * @access public
     * @var array
     * @static
     */
    public static $numberings = array('none',
        'bullet',
        'decimal',
        'upperRoman',
        'lowerRoman',
        'upperLetter',
        'lowerLetter',
        'ordinal'
    );

    /**
     * Repair tables for PDF conversion
     *
     * @access public
     * @param  string $docXML
     * @param string $numXML
     * @param array $options possible keys an values are:
     * 'repairTables' (boolean)
     * 'repairLists (boolean)
     * @static
     */
    public static function repairPDFConversion($docXML, $numXML, $options)
    {
        $repairTables = true;
        if (isset($options['repairTables'])) {
            $repairTables = $options['repairTables'];
        }
        $repairLists = true;
        if (isset($options['repairLists'])) {
            $repairLists = $options['repairLists'];
        }
        $repairBreaks = true;
        if (isset($options['repairBreaks'])) {
            $repairBreaks = $options['repairBreaks'];
        }
        $repairLists = true;
        if (isset($options['repairLists'])) {
            $repairLists = $options['repairLists'];
        }
        $docDOM = new \DOMDocument();
        $docDOM->loadXML($docXML);
        $docXPath = new \DOMXPath($docDOM);
        $docXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');

        if ($numXML == '') {
            $repairLists = false;
        } else {
            $numDOM = new \DOMDocument();
            $numDOM->loadXML($numXML);
            $numXPath = new \DOMXPath($numDOM);
            $numXPath->registerNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main');
            $query = '//w:lvl[w:rPr/w:rFonts[@w:ascii="Symbol"]]';
            $affectedNodes = $numXPath->query($query);
            foreach ($affectedNodes as $node) {
                $childs = $node->childNodes;
                foreach ($childs as $myChildNode) {
                    if ($myChildNode->nodeName == 'w:lvlText') {
                        $myChildNode->setAttribute('w:val', '•');
                    } else if ($myChildNode->nodeName == 'w:rPr') {
                        $rPrChilds = $myChildNode->childNodes;
                        foreach ($rPrChilds as $myRPrNode) {
                            if ($myRPrNode->nodeName == 'w:rFonts') {
                                $myRPrNode->setAttribute('w:ascii', 'Arial');
                                $myRPrNode->setAttribute('w:hAnsi', 'Arial');
                            }
                        }
                    }
                }
            }
        }

        if ($repairLists) {
            //1. parse numDOM and get relationships between numIds and abstractNumIds
            //Warning: by the time being we are ignoring the lever override definitions
            $listPairs = array();
            $numNodes = $numDOM->getElementsByTagName('num');
            foreach ($numNodes as $node) {
                $numId = $node->getAttribute('w:numId');
                $listPairs[$numId] = $node->firstChild->getAttribute('w:val');
            }
            //2. extract the relevant information for the list flattening process
            $listStyles = array();
            $listPosition = array();
            foreach ($listPairs as $key => $value) {
                //2.1 initialize an array to hold the current list levels
                for ($j = 0; $j < 9; $j++) {
                    $listPosition[$key][$j] = 0;
                }
                $listStyles[$value] = array();
                //fetch with XPath each level node
                $query = '//w:abstractNum[@w:abstractNumId="' . $value . '"]/w:lvl';
                $lvlNodes = $numXPath->query($query);
                foreach ($lvlNodes as $lvl) {
                    $index = $lvl->getAttribute('w:ilvl');
                    $lvlChilds = $lvl->childNodes;
                    //parse level properties
                    foreach ($lvlChilds as $child) {
                        $nodeName = $child->nodeName;
                        switch ($nodeName) {
                            case 'w:start':
                                $listStyles[$value][$index]['start'] = $child->getAttribute('w:val');
                                break;
                            case 'w:numFmt':
                                $listStyles[$value][$index]['numFmt'] = $child->getAttribute('w:val');
                                break;
                            case 'w:lvlRestart':
                                $listStyles[$value][$index]['restart'] = $child->getAttribute('w:val');
                                break;
                            case 'w:pPr':
                                $listStyles[$value][$index]['pPr'] = $child;
                                break;
                            case 'w:lvlText':
                                $listStyles[$value][$index]['text'] = $child->getAttribute('w:val');
                                break;
                            case 'w:rPr':
                                $listStyles[$value][$index]['rPr'] = $child;
                                break;
                        }
                    }
                }
            }
            //3. start the parsing of the document.xml file to transform lists into tabbed paragraphs
            $numQuery = '//w:p[descendant::w:numPr]';
            $pNodes = $docXPath->query($numQuery);
            foreach ($pNodes as $item) {
                //3.1 get the id of the used list and the outline level
                $listIds = $item->getElementsByTagName('numId');
                if($listIds->length > 0){
                    $listId = $listIds->item(0)->getAttribute('w:val');
                    $outlineLevel = $item->getElementsByTagName('ilvl')->item(0)->getAttribute('w:val');
                    //add a new postion to the current list
                    @$listPosition[$listId][$outlineLevel]++;
                    //3.2 generate the required runs for the bullet or numbering
                    $tmpXML = '<w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">';
                    //extract the w:rPr child of the w:pPr node
                    unset($pPrNodes);
                    unset($pPrNode);
                    unset($rPrPPrNodes);
                    unset($rPrPPrNode);
                    $pPrNodes = $item->getElementsByTagName('pPr');
                    if ($pPrNodes->length > 0) {
                        $rPrPPrNodes = $pPrNodes->item(0)->getElementsByTagName('rPr');
                        if ($rPrPPrNodes->length > 0) {
                            $rPrPPrNode = $rPrPPrNodes->item(0);
                        }
                    }
                    //we have to handle all the possible scenarios
                    if (isset($rPrPPrNode) && !empty($listStyles[$listPairs[$listId]][$outlineLevel]['rPr'])) {
                        //TODO explore the best option: false or true
                        OOXMLResources::mergeXMLNodes($rPrPPrNode, $listStyles[$listPairs[$listId]][$outlineLevel]['rPr'], OOXMLResources::$runProperties, true);
                        //clean the unwanted w:u tags that are not properly rendered by Open Office
                        RepairPDF::fixNumbering($rPrPPrNode);
                        $tmpXML .= $rPrPPrNode->ownerDocument->saveXML($rPrPPrNode);
                    } else if (!isset($rPrPPrNode) && !empty($listStyles[$listPairs[$listId]][$outlineLevel]['rPr'])) {
                        //clean the unwanted w:u tags that are not properly rendered by Open Office
                        RepairPDF::fixNumbering($listStyles[$listPairs[$listId]][$outlineLevel]['rPr']);
                        $tmpXML .= $listStyles[$listPairs[$listId]][$outlineLevel]['rPr']->ownerDocument->saveXML($listStyles[$listPairs[$listId]][$outlineLevel]['rPr']);
                    } else if (isset($rPrPPrNode) && empty($listStyles[$listPairs[$listId]][$outlineLevel]['rPr'])) {
                        //clean the unwanted w:u tags that are not properly rendered by Open Office
                        RepairPDF::fixNumbering($rPrPPrNode);
                        $tmpXML .= $rPrPPrNode->ownerDocument->saveXML($rPrPPrNode);
                    }
                    $numFmt = $listStyles[$listPairs[$listId]][$outlineLevel]['numFmt'];
                    $text = $listStyles[$listPairs[$listId]][$outlineLevel]['text'];
                    if ($numFmt == 'none') {
                        $tmpXML .= '</w:r>';
                    } else if ($numFmt == 'bullet') {
                        $tmpXML .= '<w:t>' . $text . '</w:t></w:r>';
                    } else {
                        $tmpXML .= '<w:t>' . RepairPDF::formatNumbering($text, $numFmt, $listPosition[$listId]) . '</w:t></w:r>';
                    }
                    $tmpXML .= '<w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:rPr><w:u w:val="none"/></w:rPr><w:tab w:leader="none"/></w:r>';
                    $runs = $docDOM->createDocumentFragment();
                    $runs->appendXML($tmpXML);
                    //3.3 choose the first run of the paragraph
                    $queryRun = './/w:r[1]';
                    $firstRun = $docXPath->query($queryRun, $item);
                    if ($firstRun->length > 0) {
                        $first = $firstRun->item(0);
                        $first->parentNode->insertBefore($runs, $first);
                    } else {
                        $item->appendChild($runs);
                    }
                    //3.4 clean the w:numPr element
                    $numPr = $item->getElementsByTagName('numPr')->item(0);
                    $removedNode = $numPr->parentNode->removeChild($numPr);
                    //3.5 merge the paragraph styles
                    if ($pPrNodes->length > 0 && !empty($listStyles[$listPairs[$listId]][$outlineLevel]['pPr'])) {
                        //TODO explore the best option: false or true
                        OOXMLResources::mergeXMLNodes($pPrNodes->item(0), $listStyles[$listPairs[$listId]][$outlineLevel]['pPr'], OOXMLResources::$paragraphProperties, true);
                    } else if ($pPrNodes->length == 0 && !empty($listStyles[$listPairs[$listId]][$outlineLevel]['pPr'])) {
                        $pPr = $docDOM->importNode($pPrNodes->length > 0 && !empty($listStyles[$listPairs[$listId]][$outlineLevel]['pPr']));
                        $item->insertBefore($pPr, $item->firstChild);
                    }
                }
            }
        }

        if ($repairTables) {
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
        }
        if ($repairBreaks) {
            $query = '//w:p[w:pPr/w:pageBreakBefore[@w:val="on"]]';
            $breaks = $docXPath->query($query);
            foreach($breaks as $break){
                //insert a page break before the first w:t node
                $ts = $break->getElementsByTagName('t');
                if ($ts->length > 0) {
                    $t = $ts->item(0);
                    $br = $t->ownerDocument->createElement('w:br');
                    $br->setAttribute('w:type', 'page');
                    $t->parentNode->insertBefore($br, $t);
                    //remove the w:pageBreakBeforeElement
                    $pBB = $break->getElementsByTagName('pageBreakBefore')->item(0);
                    $pBB->parentNode->removeChild($pBB);
                }
            }
        }
        //return the resulting XML string
        $repairedXML = $docDOM->saveXML();
        $repairedXML = str_replace('<w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">', '<w:r>', $repairedXML);
        $repairedXML = str_replace('<w:u xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"', '<w:u', $repairedXML);
        return $repairedXML;
    }

    /**
     * Fixes some problems with numbering run properties
     *
     * @access public
     * @static
     * @param  DOMNode $rPr
     * @param array $currentLevels
     */
    public static function fixNumbering($rPr)
    {
        $u = '<w:u xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" w:val="none" />';
        $uNode = $rPr->ownerDocument->createDocumentFragment();
        $uNode->appendXML($u);
        OOXMLResources::insertNodeIntoSequence($rPr, $uNode, OOXMLResources::$runProperties, $type = 'replace');
    }

    /**
     * Gives format to the numbering
     *
     * @access public
     * @static
     * @param  string $text
     * @param  string $numFmt
     * @param array $currentLevels
     */
    public static function formatNumbering($text = '', $numFmt = 'decimal', $currentLevels)
    {
        if (!in_array($numFmt, RepairPDF::$numberings)) {
            $numFmt = 'decimal';
        }
        switch ($numFmt) {
            case 'decimal':
                break;
            case 'lowerRoman':
                foreach ($currentLevels as $key => $value) {
                    $currentLevels[$key] = OOXMLResources::integer2RomanNumeral($value, false);
                }
                break;
            case 'upperRoman':
                foreach ($currentLevels as $key => $value) {
                    $currentLevels[$key] = OOXMLResources::integer2RomanNumeral($value, true);
                }
                break;
            case 'lowerLetter':
                foreach ($currentLevels as $key => $value) {
                    $currentLevels[$key] = OOXMLResources::integer2Letter($value, false);
                }
                break;
            case 'upperLetter':
                foreach ($currentLevels as $key => $value) {
                    $currentLevels[$key] = OOXMLResources::integer2Letter($value, true);
                }
                break;
            case 'ordinal':
                foreach ($currentLevels as $key => $value) {
                    $currentLevels[$key] = $value . 'º';
                }
                break;
        }
        $search = array('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9');
        $replace = array($currentLevels[0], $currentLevels[1], $currentLevels[2], $currentLevels[3], $currentLevels[4], $currentLevels[5], $currentLevels[6], $currentLevels[7], $currentLevels[8]);
        $text = str_replace($search, $replace, $text);
        return $text;
    }

}
