<?php
namespace Phpdocx\Transform;
use Phpdocx\Elements\CreateList;
use Phpdocx\Elements\CreateTable;
use Phpdocx\Elements\CreateText;
/**
 * Text 2 docx
 *
 * @category   Phpdocx
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */


class Text2Docx
{

    /**
     * variable where we save the content of the document.xml
     * @var string
     * @access private
     */
    private $document;

    /**
     * default style to the list
     * @var array
     * @access private
     */
    private $styleLst;

    /**
     * default style to the paragraph
     * @var array
     * @access private
     */
    private $styleP;

    /**
     * default style to the table
     * @var array
     * @access private
     */
    private $styleTbl;

    /**
     * 	the symbol that will determine that a line of text belongs to a list
     * @var string
     * @access private
     */
    private $symbolList;

    /**
     * the content from the text file named filename
     * @var string
     * @access private
     */
    private $text;

    /**
     * filename of a text file
     * @var string
     * @access private
     */
    private $txt;

    /**
     * boolean variable to know if we transform from text to list
     * @var boolean
     * @access private
     */
    private $txt2Lst;

    /**
     * boolean variable to know if transform from text to paragraph
     * @var boolean
     * @access private
     */
    private $txt2P;

    /**
     * boolean variable to know if we transform from text to table
     * @var boolean
     * @access private
     */
    private $txt2Tbl;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct($txt = null, $styles = array())
    {

        $this->text = '';
        $this->listSeparator = "\t";
        $this->tableSeparator = "\t";

        $this->txt2Tbl = true;
        $this->txt2Lst = true;
        $this->txt2P = true;
        //initialize the default array of styles
        $this->styleTbl = array('TBLSTYLEval' => 'TableGridPHPDOCX');
        if (!empty($styles['styleTbl']))
            $this->styleTbl = $styles['styleTbl'];

        $this->styleLst = array('val' => 1);
        if (!empty($styles['styleLst']))
            $this->styleLst = $styles['styleLst'];

        $this->styleP = array();
        if (!empty($styles['styleP']))
            $this->styleP = $styles['styleP'];


        $this->txt = $txt;
        $this->document = '';
        //read the text file document to extract it
        $this->readFile($txt);
        //insert the text like as phpdocx into a docx file
        $this->insertText();
    }

    /**
     * 
     * Magic method
     * 
     */
    public function __toString()
    {
        return $this->document;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setStyleTbl($styles)
    {
        $this->styleTbl = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getStyleTbl()
    {
        return $this->styleTbl;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setStyleLst($styles)
    {
        $this->styleLst = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getStyleLst()
    {
        return $this->styleLst;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setStyleP($styles)
    {
        $this->styleP = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getStyleP()
    {
        return $this->styleP;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setTxt2Tbl($styles)
    {
        $this->txt2Tbl = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getTxt2Tbl()
    {
        return $this->txt2Tbl;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setTxt2Lst($styles)
    {
        $this->txt2Lst = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getTxt2Lst()
    {
        return $this->txt2Lst;
    }

    /**
     * Setter
     *
     * @access public
     */
    public function setTxt2P($styles)
    {
        $this->txt2P = $styles;
    }

    /**
     * Getter
     *
     * @access public
     */
    public function getTxt2P()
    {
        return $this->txt2P;
    }

    /**
     * 
     * Method as in phpdocx
     * 
     * @access public
     * @param the data to the list. 
     * 
     */
    public function addList($data)
    {
        $oList = CreateList::getInstance();
        $oList->createList($data, $this->styleLst);
        $this->document .= (string) $oList;
    }

    /**
     * Msethod as in phpdocx
     * 
     * @access public
     * @param the data to the table
     * 
     */
    public function addTable($data)
    {
        $table = CreateTable::getInstance();
        $table->createTable($data, $this->styleTbl);
        $this->document .= (string) $table;
    }

    /**
     * Insert the content of the text file as phpdocx into a word document
     * 
     * @access public
     */
    public function insertText()
    {
        $this->text = str_replace("\n\r", '"\n"', $this->text); //replace the end of line from windows and replace with linux end of line
        $paragraphs = explode("\n", $this->text); //split the document with the end of line, so get line by line
        $now = 'p'; //assume that we start with a paragraph
        $data = array();
        $subdata = array();
        foreach ($paragraphs as $p) {
            //split the line with  by default tabs or the specific separator
            $tabs = explode($this->tableSeparator, $p);
            switch (count($tabs)) {
                case 0:
                    continue;
                case 1://text
                    //there is no tab o specific separator, so it means that is only text or it is a list which start with the specific separate simbol
                    if (substr(trim($tabs[0]), 0, 1) === $this->symbolList) {//it is a list started with the specific separate simbol
                        if (($now == 't' || $now == 't2') && $this->txt2Tbl) {//if the previous line was a table, we have to create a table with the data glued
                            $this->addTable($data); //add table method as phpdocx add table method
                        }
                        $data[] = substr(trim($tabs[0]), 1);
                        $now = 'l';
                    } else {
                        //only text
                        //if the previous line was a table or list, we have to insert the code with the data glued
                        if ($now != 'p' && ($this->txt2Tbl || $this->txt2Lst)) {
                            if (($now == 't' || $now == 't2') && $this->txt2Tbl) {
                                $this->addTable($data);
                            } elseif ($this->txt2Lst && $now == 'l') {
                                $this->addList($data);
                            }
                            $data = array();
                        }
                        //insert text data
                        $text = CreateText::getInstance();
                        $text->createText($tabs[0], array());
                        $this->document .= (string) $text;
                        $now = 'p';
                    }
                    break;
                case 2://list or table of two columns
                    if (empty($tabs[0])) {//if first is empty, it means that line start with a tab o table separator
                        if ($now == 'sl') {//if the line before was nested list, create a sub array
                            $data[] = $subdata;
                            $subdata = array();
                            $now = 'l';
                        }
                        if (!in_array($now, array('l', 'p')) && $this->txt2Tbl) {//if the line before was a table, we write the table in the document
                            $this->addTable($data);
                            $data = array();
                        }
                        $data[] = $tabs[1];
                        $now = 'l';
                    } else {//table of 2 columns
                        if ($now != 't2' && $now != 'p') {//insert the data as table or list
                            if ($now == 't') {
                                $this->addTable($data);
                            } else {
                                $this->addList($data);
                            }
                            $data = array();
                        }
                        $data[] = $tabs;
                        $now = 't2';
                    }
                    break;
                case 3://list or table of two columns or sublist
                    if (empty($tabs[0]) && empty($tabs[1]) && $this->txt2Lst && in_array($now, array('l', 'sl'))) {//sublist
                        $subdata[] = $tabs[2];
                        $now = 'sl';
                    } else {//table 
                        if ($now == 't2') {
                            $this->addList($data);
                            $data = array();
                        } elseif ($now == 'l') {
                            $this->addTable($data);
                            $data = array();
                        }
                        $data[] = $tabs;
                        $now = 't';
                    }
                    break;
                default://table of more than 2 columns
                    if ($now == 't2') {
                        $this->addList($data);
                        $data = array();
                    } elseif ($now == 'l') {
                        $this->addTable($data);
                        $data = array();
                    }
                    $data[] = $tabs;
                    $now = 't';
                    break;
            }
        }
        //if the last line was not a paragraph, insert the data which is not inserted
        if ($now != 'p') {
            if ($now == 'l') {
                $this->addList($data);
            } else {
                $this->addTable($data);
            }
        }
    }

    /**
     * 
     * Read the file and save in the class variable named filename
     * 
     * @access public
     * @param string $filename of the text document. 
     */
    public function readFile($filename)
    {
        $gestor = fopen($filename, "rb");
        $this->text = stream_get_contents($gestor);
        fclose($gestor);
    }

}
