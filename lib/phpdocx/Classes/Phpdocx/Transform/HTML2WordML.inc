<?php
namespace Phpdocx\Transform;
use Phpdocx\Create\CreateDocx;
use Phpdocx\Logger\PhpdocxLogger;
/**
 * Embedd HTML as WordML
 *
 * @category   Phpdocx
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class HTML2WordML
{

    /**
     *
     * @access public
     * @static
     * @var aray
     */
    public static $borderRow;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $colors;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $currentCustomList;

    /**
     *
     * @access public
     * @static
     * @var array 
     */
    public static $customLists;

    /**
     *
     * @access public
     * @var string
     */
    public $customListStyles;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $linkImages;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $linkTargets;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $borders;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $borderStyles;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $imageBorderStyles;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $imageVertAlignProps;

    /**
     *
     * @access public
     * @static
     * @var int
     */
    public static $openBookmark;

    /**
     *
     * @access public
     * @static
     * @var int
     */
    public static $openBr;

    /**
     *
     * @access public
     * @static
     * @var boolean
     */
    public static $openLinks;

    /**
     *
     * @access public
     * @static
     * @var boolean
     */
    public static $openPs;

    /**
     *
     * @access public
     * @static
     * @var boolean
     */
    public static $openSelect;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $openScript;

    /**
     *
     * @access public
     * @static
     * @var integer
     */
    public static $openTable;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $openTags;

    /**
     *
     * @access public
     * @static
     * @var boolean
     */
    public static $openTextArea;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $orderedLists;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $rowColor;

    /**
     *
     * @access public
     * @static
     * @var boolean
     */
    public static $selectedOption;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $selectOptions;

    /**
     *
     * @access public
     * @var boolean
     */
    public $strictWordStyles;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $tableGrid;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $text_align;

    /**
     *
     * @access public
     * @static
     * @var array
     */
    public static $text_direction;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $textArea;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $WordML;

    /**
     *
     * @access public
     * @static
     * @var string
     */
    public static $zipDocx;

    /**
     *
     * @access private
     * @var Logger
     */
    private $log;

    /**
     * Class constructor
     */
    public function __construct($zipDocx)
    {
        self::$zipDocx = $zipDocx;
        self::$openBookmark = 0;
        self::$openBr = 0;
        self::$openTags = array();
        self::$openPs = false;
        self::$openSelect = false;
        self::$selectOptions = array();
        self::$openTextArea = false;
        self::$textArea = '';
        self::$tableGrid = array();
        self::$openScript = '';
        self::$currentCustomList = NULL;
        self::$customLists = array();
        self::$orderedLists = array();
        self::$openTable = 0;
        self::$openLinks = false;
        self::$WordML = '';
        self::$linkTargets = array();
        self::$linkImages = array();
        self::$borderRow = array();
        self::$borders = array('top', 'left', 'bottom', 'right');
        self::$colors = array(
            'AliceBlue' => 'F0F8FF',
            'AntiqueWhite' => 'FAEBD7',
            'Aqua' => '00FFFF',
            'Aquamarine' => '7FFFD4',
            'Azure' => 'F0FFFF',
            'Beige' => 'F5F5DC',
            'Bisque' => 'FFE4C4',
            'Black' => '000000',
            'BlanchedAlmond' => 'FFEBCD',
            'Blue' => '0000FF',
            'BlueViolet' => '8A2BE2',
            'Brown' => 'A52A2A',
            'BurlyWood' => 'DEB887',
            'CadetBlue' => '5F9EA0',
            'Chartreuse' => '7FFF00',
            'Chocolate' => 'D2691E',
            'Coral' => 'FF7F50',
            'CornflowerBlue' => '6495ED',
            'Cornsilk' => 'FFF8DC',
            'Crimson' => 'DC143C',
            'Cyan' => '00FFFF',
            'DarkBlue' => '00008B',
            'DarkCyan' => '008B8B',
            'DarkGoldenRod' => 'B8860B',
            'DarkGray' => 'A9A9A9',
            'DarkGrey' => 'A9A9A9',
            'DarkGreen' => '006400',
            'DarkKhaki' => 'BDB76B',
            'DarkMagenta' => '8B008B',
            'DarkOliveGreen' => '556B2F',
            'Darkorange' => 'FF8C00',
            'DarkOrchid' => '9932CC',
            'DarkRed' => '8B0000',
            'DarkSalmon' => 'E9967A',
            'DarkSeaGreen' => '8FBC8F',
            'DarkSlateBlue' => '483D8B',
            'DarkSlateGray' => '2F4F4F',
            'DarkSlateGrey' => '2F4F4F',
            'DarkTurquoise' => '00CED1',
            'DarkViolet' => '9400D3',
            'DeepPink' => 'FF1493',
            'DeepSkyBlue' => '00BFFF',
            'DimGray' => '696969',
            'DimGrey' => '696969',
            'DodgerBlue' => '1E90FF',
            'FireBrick' => 'B22222',
            'FloralWhite' => 'FFFAF0',
            'ForestGreen' => '228B22',
            'Fuchsia' => 'FF00FF',
            'Gainsboro' => 'DCDCDC',
            'GhostWhite' => 'F8F8FF',
            'Gold' => 'FFD700',
            'GoldenRod' => 'DAA520',
            'Gray' => '808080',
            'Grey' => '808080',
            'Green' => '008000',
            'GreenYellow' => 'ADFF2F',
            'HoneyDew' => 'F0FFF0',
            'HotPink' => 'FF69B4',
            'IndianRed' => 'CD5C5C',
            'Indigo' => '4B0082',
            'Ivory' => 'FFFFF0',
            'Khaki' => 'F0E68C',
            'Lavender' => 'E6E6FA',
            'LavenderBlush' => 'FFF0F5',
            'LawnGreen' => '7CFC00',
            'LemonChiffon' => 'FFFACD',
            'LightBlue' => 'ADD8E6',
            'LightCoral' => 'F08080',
            'LightCyan' => 'E0FFFF',
            'LightGoldenRodYellow' => 'FAFAD2',
            'LightGray' => 'D3D3D3',
            'LightGrey' => 'D3D3D3',
            'LightGreen' => '90EE90',
            'LightPink' => 'FFB6C1',
            'LightSalmon' => 'FFA07A',
            'LightSeaGreen' => '20B2AA',
            'LightSkyBlue' => '87CEFA',
            'LightSlateGray' => '778899',
            'LightSlateGrey' => '778899',
            'LightSteelBlue' => 'B0C4DE',
            'LightYellow' => 'FFFFE0',
            'Lime' => '00FF00',
            'LimeGreen' => '32CD32',
            'Linen' => 'FAF0E6',
            'Magenta' => 'FF00FF',
            'Maroon' => '800000',
            'MediumAquaMarine' => '66CDAA',
            'MediumBlue' => '0000CD',
            'MediumOrchid' => 'BA55D3',
            'MediumPurple' => '9370D8',
            'MediumSeaGreen' => '3CB371',
            'MediumSlateBlue' => '7B68EE',
            'MediumSpringGreen' => '00FA9A',
            'MediumTurquoise' => '48D1CC',
            'MediumVioletRed' => 'C71585',
            'MidnightBlue' => '191970',
            'MintCream' => 'F5FFFA',
            'MistyRose' => 'FFE4E1',
            'Moccasin' => 'FFE4B5',
            'NavajoWhite' => 'FFDEAD',
            'Navy' => '000080',
            'OldLace' => 'FDF5E6',
            'Olive' => '808000',
            'OliveDrab' => '6B8E23',
            'Orange' => 'FFA500',
            'OrangeRed' => 'FF4500',
            'Orchid' => 'DA70D6',
            'PaleGoldenRod' => 'EEE8AA',
            'PaleGreen' => '98FB98',
            'PaleTurquoise' => 'AFEEEE',
            'PaleVioletRed' => 'D87093',
            'PapayaWhip' => 'FFEFD5',
            'PeachPuff' => 'FFDAB9',
            'Peru' => 'CD853F',
            'Pink' => 'FFC0CB',
            'Plum' => 'DDA0DD',
            'PowderBlue' => 'B0E0E6',
            'Purple' => '800080',
            'Red' => 'FF0000',
            'RosyBrown' => 'BC8F8F',
            'RoyalBlue' => '4169E1',
            'SaddleBrown' => '8B4513',
            'Salmon' => 'FA8072',
            'SandyBrown' => 'F4A460',
            'SeaGreen' => '2E8B57',
            'SeaShell' => 'FFF5EE',
            'Sienna' => 'A0522D',
            'Silver' => 'C0C0C0',
            'SkyBlue' => '87CEEB',
            'SlateBlue' => '6A5ACD',
            'SlateGray' => '708090',
            'SlateGrey' => '708090',
            'Snow' => 'FFFAFA',
            'SpringGreen' => '00FF7F',
            'SteelBlue' => '4682B4',
            'Tan' => 'D2B48C',
            'Teal' => '008080',
            'Thistle' => 'D8BFD8',
            'Tomato' => 'FF6347',
            'Turquoise' => '40E0D0',
            'Violet' => 'EE82EE',
            'Wheat' => 'F5DEB3',
            'White' => 'FFFFFF',
            'WhiteSmoke' => 'F5F5F5',
            'Yellow' => 'FFFF00',
            'YellowGreen' => '9ACD32'
        );

        self::$borderStyles = array(
            'none' => 'nil',
            'dotted' => 'dotted',
            'dashed' => 'dashed',
            'solid' => 'single',
            'double' => 'double',
            'groove' => 'threeDEngrave',
            'ridge' => 'single', //threeDEmboss: we have overriden this border style that is the one by default in HTML tables
            'inset' => 'inset',
            'outset' => 'outset'
        );
        self::$imageBorderStyles = array(
            'none' => 'nil',
            'dotted' => 'dot',
            'dashed' => 'dash',
            'solid' => 'solid',
            //By the time being we parse all other types as solid
            'double' => 'solid',
            'groove' => 'solid',
            'ridge' => 'solid',
            'inset' => 'solid',
            'outset' => 'solid'
        );
        self::$imageVertAlignProps = array(
            'top' => 'top',
            'text-top' => 'top',
            'middle' => 'center'
        );

        self::$text_align = array(
            'left' => 'left',
            'center' => 'center',
            'right' => 'right',
            'justify' => 'both'
        );

        self::$text_direction = array(
            'ltr' => 'lrTb', //Left to Right, Top to Bottom
            'rtl' => 'tbRl', //Right to Left, Top to Bottom
            'lrTb' => 'lrTb', //Left to Right, Top to Bottom
            'tbRl' => 'tbRl', //	Top to Bottom, Right to Left
            'btLr' => 'btLr', //	Bottom to Top, Left to Right
            'lrTbV' => 'lrTbV', //Left to Right, Top to Bottom Rotated
            'tbRlV' => 'tbRlV', //Top to Bottom, Right to Left Rotated
            'tbLrV' => 'tbLrV', //Top to Bottom, Left to Right Rotated  
            'lrtb' => 'lrTb', //Left to Right, Top to Bottom
            'tbrl' => 'tbRl', //	Top to Bottom, Right to Left
            'btlr' => 'btLr', //	Bottom to Top, Left to Right
            'lrtbv' => 'lrTbV', //Left to Right, Top to Bottom Rotated
            'tbrlv' => 'tbRlV', //Top to Bottom, Right to Left Rotated
            'tblrv' => 'tbLrV', //Top to Bottom, Left to Right Rotated 
        );

        $this->isFile = false;
        $this->baseURL = '';
        $this->context = '';
        $this->customListStyles = false;
        $this->parseDivs = false;
        $this->parseFloats = false;
        $this->wordStyles = array();
        $this->tableStyle = ''; //FIXME deprecated
        $this->paragraphStyle = ''; //FIXME deprecated
        $this->downloadImages = false;
        $this->parseAnchors = false;
        $this->strictWordStyles = false;
    }

    /**
     * Class destructor
     */
    public function __destruct()
    {
        
    }

    /**
     * This is the function that launches the HTML parsing
     *
     * @access public
     * @param string $html
     * @param array $options
     * @param mixed $filter
     * @return array
     */
    public function render($html, $options)
    {
        if (isset($options['isFile'])) {
            $this->isFile = $options['isFile'];
        }
        if (isset($options['baseURL'])) {
            $this->baseURL = $options['baseURL'];
        } else if (!empty($options['isFile'])) {
            if ($html[strlen($html) - 1] == '/') {
                $this->baseURL = $html;
            } else {
                $parsedURL = parse_url($html);
                $pathParts = @explode('/', $parsedURL['path']); //TODO bad parsing if "http://domain.tld" or if "http://domain.tld/path/path.with.point"
                $last = array_pop($pathParts);
                if (strpos($last, '.') > 0) {
                    //Do nothing
                } else {
                    $pathParts[] = $last;
                }
                $newPath = implode('/', $pathParts);
                $this->baseURL = $parsedURL['scheme'] . '://' . $parsedURL['host'] . $newPath . '/';
            }
        }
        if (isset($options['context'])) {
            $this->context = $options['context'];
        }
        if (isset($options['customListStyles'])) {
            $this->customListStyles = $options['customListStyles'];
        }
        if (isset($options['parseAnchors'])) {
            $this->parseAnchors = $options['parseAnchors'];
        }
        if (isset($options['parseDivsAsPs']) && $options['parseDivsAsPs']) {//For backwards compatibility with v2.7
            $options['parseDivs'] = 'paragraph';
        }
        if (isset($options['parseDivs'])) {
            if ($options['parseDivs'] == 'table' || $options['parseDivs'] == 'paragraph')
                $this->parseDivs = $options['parseDivs'];
            else
                $this->parseDivs = false;
        }
        if (isset($options['parseFloats'])) {
            $this->parseFloats = empty($options['parseFloats']) ? false : true;
        }
        if (isset($options['tableStyle'])) { //FIXME deprecated
            //$this->tableStyle = $options['tableStyle'];
            $this->wordStyles['<table>'] = $options['tableStyle'];
            PhpdocxLogger::logger('"tableStyle" option is DEPRECATED, use "wordStyles" instead. ', 'info');
        }
        if (isset($options['paragraphStyle'])) { //FIXME deprecated
            //$this->paragraphStyle = $options['paragraphStyle'];
            $this->wordStyles['<p>'] = $options['paragraphStyle'];
            PhpdocxLogger::logger('"paragraphStyle" option is DEPRECATED, use "wordStyles" instead. ', 'info');
        }
        if (isset($options['strictWordStyles'])) {
            $this->strictWordStyles = $options['strictWordStyles'];
        }
        if (isset($options['wordStyles']) && is_array($options['wordStyles'])) {
            if (empty($this->wordStyles)) {
                $this->wordStyles = $options['wordStyles'];
            } else { //FIXME change this when "tableStyle" and "paragraphStyle" dissapears
                foreach ($options['wordStyles'] as $key => $value) {
                    $this->wordStyles[$key] = $value;
                }
            }
        }
        if (isset($options['downloadImages'])) {
            $this->downloadImages = $options['downloadImages'];
        }

        $filter = isset($options['filter']) ? $options['filter'] : '*';
        $dompdfTree = $this->renderDompdf($html, $this->isFile, $filter, $this->parseDivs, $this->baseURL);
        $this->_render($dompdfTree);

        if (self::$openPs) {
            self::$WordML .= '</w:p>';
        }

        self::$WordML = $this->repairWordML(self::$WordML);

        return(array(self::$WordML, self::$linkTargets, self::$linkImages, self::$orderedLists, self::$customLists));
    }

    /**
     * Get the HTML DOM tree from DOMPDF
     *
     * @access private
     * @param string $html
     * @param boolean $isFile
     * @param string $filter
     * @return array
     */
    private function renderDompdf($html, $isFile = false, $filter = '*', $parseDivs = false, $baseURL = '')
    {
        /* require_once(DIR_DOMPDF . "/dompdf_config.inc.php");
          require_once(DOMPDF_INC_DIR . '/dompdf_treeOut.php');
          $dompdf = new dompdf_treeOut(); */
        require_once PHPDOCX_DIR_PARSER . '/parserhtml_config.inc.php';
        $dompdf = new \PARSERHTML();
        $aTemp = $dompdf->getDompdfTree($html, $isFile, $filter, $parseDivs, $baseURL);
        return($aTemp);
    }

    /**
     * This function renders the HTML DOM elements recursively
     *
     * @access private
     * @param array $nodo
     * @param integer $depth
     * @return array
     */
    private function _render($nodo, $depth = 0)
    {
        $this->_level = $depth;
        if (isset($nodo['attributes']['id']) && $this->parseAnchors) {
            $bookmarkId = rand(999999, 99999999);
            self::$WordML .= '<w:bookmarkStart w:id="' . $bookmarkId . '" w:name="' . $nodo['attributes']['id'] . '" /><w:bookmarkEnd w:id="' . $bookmarkId . '" />';
        }
        $properties = isset($nodo['properties']) ? $nodo['properties'] : array();
        switch ($nodo['nodeName']) {
            case 'div':
                if (!$this->parseDivs) {
                    self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                    self::$openTags[$depth] = $nodo['nodeName'];
                    //Test if the page_break_before property is set up
                    if (isset($properties['page_break_before']) && $properties['page_break_before'] == 'always') {
                        //Take care of open p tags
                        if (self::$openPs) {
                            if (self::$openLinks) {
                                self::$WordML .= '</w:hyperlink>';
                                self::$openLinks = false;
                            }
                            if (self::$openBookmark > 0) {
                                $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                                self::$openBookmark = 0;
                            }
                            self::$WordML .= '<w:r><w:br w:type="page"/></w:r></w:p>';
                            self::$openPs = false;
                        } else {
                            //insert a page break within a paragraph
                            self::$WordML .= '<w:p><w:pPr><w:pageBreakBefore w:val="on" /></w:pPr><w:r></w:r></w:p>';
                        }
                    }
                    break;
                }
            case 'h1':
            case 'h2':
            case 'h3':
            case 'h4':
            case 'h5':
            case 'h6':
            case 'p':
            case 'dt':
            case 'dd':
                // extract the heading level
                $level = substr($nodo['nodeName'], 1, 1);
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (self::$openPs) {
                    if (self::$openLinks) {
                        self::$WordML .= '</w:hyperlink>';
                        self::$openLinks = false;
                    }
                    if (self::$openBookmark > 0) {
                        $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                        self::$openBookmark = 0;
                    }
                    self::$WordML .= '</w:p><w:p>';
                } else {
                    self::$WordML .= '<w:p>';
                    self::$openPs = true;
                }
                self::$WordML .= $this->generatePPr($properties, $level, $nodo['attributes'], $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'dl':
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'ol':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);

                $this->countTags = array_count_values(self::$openTags);
                $listLevel = max((@$this->countTags['ul'] + @$this->countTags['ol']), 0);

                if ($listLevel == 0) {
                    createDocx::$numOL++;
                    self::$orderedLists[] = createDocx::$numOL;
                    self::$currentCustomList = NULL;
                }
            case 'ul':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if ($this->customListStyles) {
                    //Check if it is the first list or is nested within a existing list
                    //and if custom list styles are to be used
                    $this->countTags = array_count_values(self::$openTags);
                    $listLevel = max((@$this->countTags['ul'] + @$this->countTags['ol']), 0);
                    if ($listLevel == 0) {
                        if (isset($nodo['attributes']) && isset($nodo['attributes']['class'])) {
                            $currentListStyle = NULL;
                            foreach ($nodo['attributes']['class'] as $value) {
                                if (!empty(CreateDocx::$customLists[$value])) {
                                    $currentListStyle = $value;
                                }
                            }
                        }
                        if (!empty($currentListStyle)) {
                            self::$currentCustomList = rand(9999, 999999999);
                            self::$customLists[] = array('name' => $currentListStyle . '_' . self::$currentCustomList, 'id' => self::$currentCustomList);
                        } else {
                            self::$currentCustomList = NULL;
                        }
                    }
                }
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'li':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (self::$openPs) {
                    if (self::$openLinks) {
                        self::$WordML .= '</w:hyperlink>';
                        self::$openLinks = false;
                    }
                    if (self::$openBookmark > 0) {
                        $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                        self::$openBookmark = 0;
                    }
                    self::$WordML .= '</w:p><w:p>';
                } else {
                    self::$WordML .= '<w:p>';
                    self::$openPs = true;
                }
                self::$openTags[$depth] = $nodo['nodeName'];
                self::$WordML .= $this->generateListPr($properties);
                break;
            case 'table':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTable++;
                self::$tableGrid[self::$openTable] = array();
                if (self::$openPs) {
                    if (self::$openLinks) {
                        self::$WordML .= '</w:hyperlink>';
                        self::$openLinks = false;
                    }
                    if (self::$openBookmark > 0) {
                        $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                        self::$openBookmark = 0;
                    }
                    if (self::$openBr) {
                        self::$WordML .= '<w:r>';
                        for ($j = 0; $j < self::$openBr; $j++) {
                            self::$WordML .= '<w:br />';
                        }
                        self::$WordML .= '</w:r>';
                        self::$openBr = 0;
                    }
                    self::$WordML .= '</w:p><w:tbl>';
                    self::$openPs = false;
                } else {
                    self::$WordML .= '<w:tbl>';
                }
                self::$WordML .= $this->generateTblPr($properties, $nodo['attributes']);
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'tr':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                array_push(self::$tableGrid[self::$openTable], array());
                self::$WordML .= '<w:tr>';
                self::$WordML .= $this->generateTrPr($properties);
                self::$openTags[$depth] = $nodo['nodeName'];
                // Hack to circumvent the fact that in WordML it is not posible to give a background color to a whole row
                self::$rowColor = $properties['background_color'];
                // Hack to circumvent the fact that in WordML w:trPr has no border property, although it can be set trough table style
                if (!isset($properties['border_top_color'])) {
                    $properties['border_top_color'] = '';
                }
                if (!isset($properties['border_top_width'])) {
                    $properties['border_top_width'] = '';
                }
                if (!isset($properties['border_top_style'])) {
                    $properties['border_top_style'] = '';
                }
                if (!isset($properties['border_bottom_color'])) {
                    $properties['border_bottom_color'] = '';
                }
                if (!isset($properties['border_bottom_width'])) {
                    $properties['border_bottom_width'] = '';
                }
                if (!isset($properties['border_bottom_style'])) {
                    $properties['border_bottom_style'] = '';
                }
                self::$borderRow = array('top' => array('color' => $properties['border_top_color'],
                        'width' => $properties['border_top_width'],
                        'style' => $properties['border_top_style']),
                    'bottom' => array('color' => $properties['border_bottom_color'],
                        'width' => $properties['border_bottom_width'],
                        'style' => $properties['border_bottom_style']),
                );

                break;
            case 'th':
            case 'td':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                $firstRow = $nodo['nodeName'] == 'th' ? true : false;

                //Now we have to deal with posible rowspans coming from previous rows
                $row = count(self::$tableGrid[self::$openTable]) - 1;
                $column = count(self::$tableGrid[self::$openTable][$row]);
                $this->countEmptyColumns($row, $column);

                //Now we have to deal with the current td
                $colspan = (int) $nodo['attributes']['colspan'];
                $rowspan = (int) $nodo['attributes']['rowspan'];
                self::$WordML .= '<w:tc>';
                for ($k = 0; $k < $colspan; $k++) {
                    array_push(self::$tableGrid[self::$openTable][count(self::$tableGrid[self::$openTable]) - 1], array($rowspan, $colspan - $k, $properties));
                }
                self::$WordML .= $this->generateTcPr($properties, $nodo['attributes'], $colspan, $rowspan, $firstRow);
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'a':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (isset($nodo['attributes']['href']) && $nodo['attributes']['href'] != '') {//FIXME: by the time being we do not parse anchors
                    $aId = 'rId' . uniqid(mt_rand(999, 9999));
                    if (self::$openPs) {
                        if ($nodo['attributes']['href'][0] != '#') {
                            self::$openLinks = true;
                            self::$WordML .= '<w:hyperlink r:id="' . $aId . '" w:history="1">';
                            self::$linkTargets[$aId] = htmlspecialchars($this->parseURL($nodo['attributes']['href']));
                        } else if ($nodo['attributes']['href'][0] == '#' && $this->parseAnchors) {
                            self::$openLinks = true;
                            self::$WordML .= '<w:hyperlink w:anchor="' . substr($nodo['attributes']['href'], 1) . '" w:history="1">';
                        }
                    } else {
                        if ($nodo['attributes']['href'][0] != '#') {
                            self::$openLinks = true;
                            self::$WordML .= '<w:p>';
                            self::$WordML .= $this->generatePPr($properties);
                            self::$WordML .= '<w:hyperlink r:id="' . $aId . '" w:history="1">';
                            self::$linkTargets[$aId] = htmlspecialchars($this->parseURL($nodo['attributes']['href']));
                            self::$openPs = true;
                        } else if ($nodo['attributes']['href'][0] == '#' && $this->parseAnchors) {
                            self::$openLinks = true;
                            self::$WordML .= '<w:hyperlink w:anchor="' . substr($nodo['attributes']['href'], 1) . '" w:history="1">';
                            self::$openPs = true;
                        }
                    }
                } else if (isset($nodo['attributes']['name']) && $nodo['attributes']['name'] != '' && $this->parseAnchors) {
                    $tempId = rand(999999999, 9999999999999);
                    self::$WordML .= '<w:bookmarkStart w:id="' . $tempId . '" w:name="' . $nodo['attributes']['name'] . '" />';
                    self::$openBookmark = $tempId;
                }
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'sub':
                if ($nodo['nodeName'] == 'sub') {
                    self::$openScript = 'subscript';
                }
            case 'sup':
                if ($nodo['nodeName'] == 'sup') {
                    self::$openScript = 'superscript';
                }
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case '#text':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (self::$openSelect) {
                    if (count(self::$selectOptions) < 25) {
                        if (self::$selectedOption) {
                            array_unshift(self::$selectOptions, htmlspecialchars($nodo['nodeValue']));
                        } else {
                            self::$selectOptions[] = htmlspecialchars($nodo['nodeValue']);
                        }
                    } else {
                        echo 'The 25 limit of items that Word has stablished for a dropdown list has been exceeded' . PHP_EOL;
                    }
                } else if (self::$openTextArea) {
                    self::$textArea = htmlspecialchars($nodo['nodeValue']);
                } else {
                    if (self::$openPs) {
                        self::$WordML .= '<w:r>';
                    } else {
                        self::$WordML .= '<w:p>';
                        // if we are creating the paragraph by hand we have to take care of certain styles
                        // that are important to keep like inherited justification
                        $style = array();
                        if (@$properties['text_align'] != '' || @$properties['text_align'] != 'left') {
                            $style['text_align'] = $properties['text_align'];
                        }
                        if (isset($properties['direction']) && strtolower($properties['direction']) == 'rtl') {
                            $style['direction'] = 'rtl';
                        }
                        if (!empty($style))
                            self::$WordML .= $this->generatePPr($style);
                        self::$WordML .= '<w:r>';
                        self::$openPs = true;
                    }
                    self::$WordML .= $this->generateRPr($properties);
                    if (self::$openBr) {
                        for ($j = 0; $j < self::$openBr; $j++) {
                            self::$WordML .= '<w:br />';
                        }
                        self::$openBr = 0;
                    }
                    self::$WordML .= '<w:t xml:space="preserve">' . htmlspecialchars($nodo['nodeValue']) . '</w:t>';
                    self::$WordML .= '</w:r>';
                }
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
            case 'br':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (self::$openPs) {
                    self::$openBr++;
                } else {
                    self::$WordML .= '<w:p />';
                }
                break;
            case 'img':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                //We first check if the image has an allowed extension
                $descrArray = explode('/', $nodo['attributes']['src']);
                $arrayExtension = explode('.', $this->parseURL($nodo['attributes']['src']));
                $descr = array_pop($descrArray);
                $descr = array_shift(explode('?', $descr));
                $extension = strtolower(array_pop($arrayExtension));
                $extension = array_shift(explode('?', $extension));
                $predefinedExtensions = explode(',', PHPDOCX_ALLOWED_IMAGE_EXT);
                $hiddenExtension = '';
                if (!in_array($extension, $predefinedExtensions)) {
                    $extensionId = exif_imagetype($this->parseURL($nodo['attributes']['src']));
                    $extensionArray = array();
                    $extensionArray[1] = 'gif';
                    $extensionArray[2] = 'jpg';
                    $extensionArray[3] = 'png';
                    $extensionArray[6] = 'bmp';
                    $extension = $extensionArray[$extensionId];
                    $hiddenExtension = $extension;
                }


                if (!in_array($extension, $predefinedExtensions)) {
                    continue;
                }
                $photo = @file_get_contents($this->parseURL($nodo['attributes']['src']));
                if (!$photo)
                    continue;

                if (self::$openPs) {
                    self::$WordML .= '<w:r>';
                } else {
                    self::$WordML .= '<w:p>';
                    self::$WordML .= '<w:r>';
                    self::$openPs = true;
                }
                $imgId = 'rId' . uniqid(mt_rand(999, 9999));
                $tempName = 'name' . uniqid(mt_rand(999, 9999));
                //We get the photos to parse their properties
                //$size = getimagesizefromstring($photo); only works for > 5.4
                $tempDir = CreateDocx::getTempDir();
                $photoHandle = fopen($tempDir . '/img' . $imgId . '.' . $extension, "w+");
                $contents = fwrite($photoHandle, $photo);
                fclose($photoHandle);
                $size = getimagesize($tempDir . '/img' . $imgId . '.' . $extension);
                unlink($tempDir . '/img' . $imgId . '.' . $extension);
                if ($this->downloadImages) {
                    self::$zipDocx->addFromString('word/media/img' . $imgId . '.' . $extension, $photo);
                }
                //Check if the size is defined in the attributes or in the CSS styles
                $imageSize = array();
                if (isset($nodo['attributes']['width'])) {
                    $imageSize['width'] = $nodo['attributes']['width'];
                }
                if (isset($nodo['attributes']['height'])) {
                    $imageSize['height'] = $nodo['attributes']['height'];
                }
                if (isset($properties['width']) && $properties['width'] != 'auto') {
                    $properties['width'] = str_replace(' ', '', $properties['width']);
                    $imageSize['width'] = $this->CSSUnits2Pixels($properties['width'], $properties['font_size']);
                }
                if (isset($properties['height']) && $properties['height'] != 'auto') {
                    $properties['height'] = str_replace(' ', '', $properties['height']);
                    $imageSize['height'] = $this->CSSUnits2Pixels($properties['height'], $properties['font_size']);
                }

                $c = $this->getImageDimensions($size, $imageSize);
                $cx = $c[0];
                $cy = $c[1];
                self::$WordML .= $this->generateImageRPr($properties, $cy);

                self::$openTags[$depth] = $nodo['nodeName'];



                //Now we will manage the image borders if any
                if (isset($properties['border_top_style']) && $properties['border_top_style'] != 'none') {
                    $imageBorderWidth = $properties['border_top_width'] * 9600;
                    $imageBorderStyle = self::$imageBorderStyles[$properties['border_top_style']];
                    $imageBorderColor = $this->wordMLColor($properties['border_top_color']);
                } else {
                    $imageBorderWidth = 0;
                    $imageBorderStyle = '';
                    $imageBorderColor = '';
                }
                //We now take care of paddings and margins
                $distance = array();
                foreach (self::$borders as $key => $value) {
                    $distance[$value] = $this->imageMargins($properties['margin_' . $value], $properties['padding_' . $value], $properties['font_size']);
                }
                //Positioning
                if (isset($properties['float']) && ($properties['float'] == 'left' || $properties['float'] == 'right')) {
                    $docPr = rand(99999, 99999999);
                    self::$WordML .= '<w:drawing><wp:anchor distT="' . $distance['top'] . '" distB="' . $distance['bottom'] . '" distL="' . $distance['left'] . '" distR="' . $distance['right'] . '" simplePos="0" relativeHeight="251658240" behindDoc="0" locked="0" layoutInCell="1" allowOverlap="0"><wp:simplePos x="0" y="0" />';
                    self::$WordML .= '<wp:positionH relativeFrom="column"><wp:align>' . $properties['float'] . '</wp:align></wp:positionH>';
                    self::$WordML .= '<wp:positionV relativeFrom="line"><wp:posOffset>40000</wp:posOffset></wp:positionV>';
                    self::$WordML .= '<wp:extent cx="' . $cx . '" cy="' . $cy . '" /><wp:wrapSquare wrapText="bothSides" /><wp:docPr id="' . $docPr . '" name="' . $tempName . '" descr="' . rawurlencode($descr) . '" />';
                    self::$WordML .= '<wp:cNvGraphicFramePr><a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1" /></wp:cNvGraphicFramePr><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">';
                    self::$WordML .= '<a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:nvPicPr><pic:cNvPr id="0" name="' . rawurlencode($descr) . '"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill>';
                    if ($this->downloadImages) {
                        self::$WordML .= '<a:blip r:embed="' . $imgId . '" cstate="print"/>';
                    } else {
                        self::$WordML .= '<a:blip r:link="' . $imgId . '" cstate="print"/>';
                    }
                    self::$WordML .= '<a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' . $cx . '" cy="' . $cy . '" /></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom>';
                    self::$WordML .= $this->imageBorders($imageBorderWidth, $imageBorderStyle, $imageBorderColor);
                    self::$WordML .= '</pic:spPr></pic:pic></a:graphicData></a:graphic></wp:anchor></w:drawing>';
                } else {
                    self::$WordML .= '<w:drawing><wp:inline distT="' . $distance['top'] . '" distB="' . $distance['bottom'] . '" distL="' . $distance['left'] . '" distR="' . $distance['right'] . '"><wp:extent cx="' . $cx . '" cy="' . $cy . '" />';
                    self::$WordML .= '<wp:docPr id="' . rand(99999, 99999999) . '" name="' . $tempName . '" descr="' . rawurlencode($descr) . '" /><wp:cNvGraphicFramePr><a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1" /></wp:cNvGraphicFramePr>';
                    self::$WordML .= '<a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">';
                    self::$WordML .= '<pic:nvPicPr><pic:cNvPr id="0" name="' . rawurlencode($descr) . '"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill>';
                    if ($this->downloadImages) {
                        self::$WordML .= '<a:blip r:embed="' . $imgId . '" cstate="print"/>';
                    } else {
                        self::$WordML .= '<a:blip r:link="' . $imgId . '" cstate="print"/>';
                    }
                    self::$WordML .= '<a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="' . $cx . '" cy="' . $cy . '" /></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom>';
                    self::$WordML .= $this->imageBorders($imageBorderWidth, $imageBorderStyle, $imageBorderColor);
                    self::$WordML .= '</pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing>';
                }
                self::$WordML .= '</w:r>';
                if (empty($hiddenExtension)) {
                    self::$linkImages[$imgId] = $this->parseURL($nodo['attributes']['src']);
                } else {
                    self::$linkImages[$imgId] = $this->parseURL($nodo['attributes']['src']) . '.' . $hiddenExtension;
                }
                break;
            case 'hr':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (self::$openPs) {
                    self::$WordML .= '<w:r><w:pict><v:rect id="_x0000_i1026" style="width:0;height:1.5pt" o:hralign="center" o:hrstd="t" o:hr="t" fillcolor="#aca899" stroked="f" /></w:pict></w:r>';
                } else {
                    self::$WordML .= '<w:p><w:r><w:pict><v:rect id="_x0000_i1026" style="width:0;height:1.5pt" o:hralign="center" o:hrstd="t" o:hr="t" fillcolor="#aca899" stroked="f" /></w:pict></w:r></w:p>';
                }
                break;
            case 'input':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                if (isset($nodo['attributes']['type']) && $nodo['attributes']['type'] == 'text') {
                    if (self::$openPs) {
                        //do not do anything
                    } else {
                        self::$WordML .= '<w:p>';
                        // if we are creating the paragraph by hand we have to take care of certain styles
                        // that are important to keep like inherited justification
                        $style = array();
                        if (@$properties['text_align'] != '' || @$properties['text_align'] != 'left') {
                            $style['text_align'] = $properties['text_align'];
                        }
                        if (!empty($style))
                            self::$WordML .= $this->generatePPr($style);
                        self::$openPs = true;
                    }
                    //we check if there is a br open
                    if (self::$openBr) {
                        self::$WordML .= '<w:rPr>';
                        for ($j = 0; $j < self::$openBr; $j++) {
                            self::$WordML .= '<w:br />';
                        }
                        self::$openBr = 0;
                        self::$WordML .= '</w:rPr>';
                    }
                    //Now we insert the corresponding XML
                    $bookmarkId = rand(99999, 9999999);
                    $uniqueName = uniqid(mt_rand(999, 9999));
                    self::$WordML .= '<w:r><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="Texto' . $uniqueName . '"/><w:enabled/><w:calcOnExit w:val="0"/><w:textInput/></w:ffData></w:fldChar></w:r><w:bookmarkStart w:id="' . $bookmarkId . '" w:name="Texto' . $uniqueName . '"/><w:r><w:instrText xml:space="preserve"> FORMTEXT </w:instrText></w:r><w:r><w:fldChar w:fldCharType="separate"/></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve">';
                    if (isset($nodo['attributes']['value']) && $nodo['attributes']['value'] != '') {
                        self::$WordML .= $nodo['attributes']['value'];
                    } else {
                        if (isset($nodo['attributes']['size']) && $nodo['attributes']['size'] > 0) {
                            $size = $nodo['attributes']['size'];
                        } else {
                            $size = 18;
                        }
                        for ($k = 0; $k <= $size; $k++) {
                            self::$WordML .=' '; //blank characters for Word
                        }
                    }
                    self::$WordML .='</w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:fldChar w:fldCharType="end"/></w:r><w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
                } else if (isset($nodo['attributes']['type']) && ($nodo['attributes']['type'] == 'checkbox' || $nodo['attributes']['type'] == 'radio')) {
                    if (self::$openPs) {
                        //do not do anything
                    } else {
                        self::$WordML .= '<w:p>';
                        // if we are creating the paragraph by hand we have to take care of certain styles
                        // that are important to keep like inherited justification
                        $style = array();
                        if (@$properties['text_align'] != '' || @$properties['text_align'] != 'left') {
                            $style['text_align'] = $properties['text_align'];
                        }
                        if (!empty($style))
                            self::$WordML .= $this->generatePPr($style);
                        self::$openPs = true;
                    }
                    //Now we insert the corresponding XML
                    $bookmarkId = rand(99999, 9999999);
                    $uniqueName = uniqid(mt_rand(999, 9999));
                    if (isset($nodo['attributes']['checked']) && $nodo['attributes']['checked']) {
                        $selected = 1;
                    } else {
                        $selected = 0;
                    }
                    //we check if there is a br open
                    if (self::$openBr) {
                        self::$WordML .= '<w:rPr>';
                        for ($j = 0; $j < self::$openBr; $j++) {
                            self::$WordML .= '<w:br />';
                        }
                        self::$openBr = 0;
                        self::$WordML .= '</w:rPr>';
                    }
                    self::$WordML .= '<w:r><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="cbox' . $uniqueName . '"/><w:enabled/><w:calcOnExit w:val="0"/><w:checkBox><w:sizeAuto/><w:default w:val="' . $selected . '"/></w:checkBox></w:ffData></w:fldChar></w:r><w:bookmarkStart w:id="' . $bookmarkId . '" w:name="cbox' . $uniqueName . '"/><w:r><w:instrText xml:space="preserve"> FORMCHECKBOX </w:instrText></w:r><w:r><w:fldChar w:fldCharType="separate"/></w:r><w:r><w:fldChar w:fldCharType="end"/></w:r><w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
                }
                break;
            case 'select':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                self::$selectOptions = array();
                if (self::$openPs) {
                    //do not do anything
                } else {
                    self::$WordML .= '<w:p>';
                    // if we are creating the paragraph by hand we have to take care of certain styles
                    // that are important to keep like inherited justification
                    $style = array();
                    if (@$properties['text_align'] != '' || @$properties['text_align'] != 'left') {
                        $style['text_align'] = $properties['text_align'];
                    }
                    if (!empty($style))
                        self::$WordML .= $this->generatePPr($style);
                    self::$openPs = true;
                }
                break;
            case 'option':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                self::$openSelect = true;
                if (isset($nodo['attributes']['selected']) && $nodo['attributes']['selected']) {
                    self::$selectedOption = 1;
                } else {
                    self::$selectedOption = 0;
                }
                break;
            case 'textarea':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                self::$openTextArea = true;
                if (self::$openPs) {
                    //do not do anything
                } else {
                    self::$WordML .= '<w:p>';
                    // if we are creating the paragraph by hand we have to take care of certain styles
                    // that are important to keep like inherited justification
                    $style = array();
                    if (@$properties['text_align'] != '' || @$properties['text_align'] != 'left') {
                        $style['text_align'] = $properties['text_align'];
                    }
                    if (!empty($style))
                        self::$WordML .= $this->generatePPr($style);
                    self::$openPs = true;
                }
                break;
            case 'samp':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                //we use this tag also for Word footnotes if the attribute title has the
                //structure phpdocx_footnote_number or phpdocx_endnote_number
                $title = $nodo['attributes']['title'];
                $titArray = explode('_', $title);
                if ($titArray[0] == 'phpdocx') {
                    if ($titArray[1] == 'footnote') {
                        self::$WordML .= '<w:r><w:rPr>';
                        if (isset($properties['font_family']) && $properties['font_family'] != 'serif' && $properties['font_family'] != 'fixed') {
                            $arrayCSSFonts = explode(',', $properties['font_family']);
                            $font = trim($arrayCSSFonts[0]);
                            $font = str_replace('"', '', $font);
                            self::$WordML .= '<w:rFonts w:ascii="' . $font . '" w:hAnsi="' . $font . '" w:eastAsia="' . $font . '" w:cs="' . $font . '" /> ';
                        }
                        if (@$properties['color'] != '' && is_array($properties['color'])) {
                            $color = $properties['color'];
                            $color = $this->wordMLColor($color);
                            self::$WordML .='<w:color w:val="' . $color . '" />';
                        }
                        self::$WordML .='<w:vertAlign w:val="superscript" /></w:rPr><w:footnoteReference w:id="' . $titArray[2] . '" /></w:r>';
                    } else if ($titArray[1] == 'endnote') {
                        self::$WordML .= '<w:r><w:rPr>';
                        if (isset($properties['font_family']) && $properties['font_family'] != 'serif') {
                            $arrayCSSFonts = explode(',', $properties['font_family']);
                            $font = trim($arrayCSSFonts[0]);
                            $font = str_replace('"', '', $font);
                            self::$WordML .= '<w:rFonts w:ascii="' . $font . '" w:hAnsi="' . $font .'" w:eastAsia="' . $font . '" w:cs="' . $font . '" /> ';
                        }
                        if (@$properties['color'] != '' && is_array($properties['color'])) {
                            $color = $properties['color'];
                            $color = $this->wordMLColor($color);
                            self::$WordML .='<w:color w:val="' . $color . '" />';
                        }
                        self::$WordML .='<w:vertAlign w:val="superscript" /></w:rPr><w:endnoteReference w:id="' . $titArray[2] . ' " /></w:r>';
                    }
                }
                break;
            case 'close':
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                break;
            default:
                self::$WordML .= $this->closePreviousTags($depth, $nodo['nodeName']);
                self::$openTags[$depth] = $nodo['nodeName'];
                break;
        }
        ++$depth;
        /* if($nodo['nodeName'] == 'table'){
          var_dump($properties);
          var_dump($nodo['attributes']);
          } */
        if (isset($properties['display']) && $properties['display'] == 'none') {
            //do not render that subtree
        } else {

            if (!empty($nodo['children'])) {
                foreach ($nodo['children'] as $child) {
                    $this->_render($child, $depth);
                }
            }
        }
    }

    /**
     * This function takes care that all nodes are properly closed
     *
     * @access private
     * @param integer $depth
     * @param string $currentTag
     */
    private function closePreviousTags($depth, $currentTag = '')
    {
        $sRet = '';

        $counter = count(self::$openTags);
        for ($j = $counter; $j >= $depth - 1; $j--) {
            $tag = array_pop(self::$openTags);

            switch ($tag) {
                case 'div':
                    if (!$this->parseDivs)
                        break;
                case 'h1':
                case 'h2':
                case 'h3':
                case 'h4':
                case 'h5':
                case 'h6':
                case 'p':
                case 'dt':
                case 'dd':
                case 'li':
                    if (self::$openPs) {
                        if (self::$openLinks) {
                            $sRet.= '</w:hyperlink>';
                            self::$openLinks = false;
                        }
                        if (self::$openBookmark > 0) {
                            $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                            self::$openBookmark = 0;
                        }
                        $sRet .= '</w:p>';
                        self::$openPs = false;
                    }
                    break;
                case 'table':
                    if (self::$openPs) {
                        if (self::$openLinks) {
                            $sRet.= '</w:hyperlink>';
                            self::$openLinks = false;
                        }
                        if (self::$openBookmark > 0) {
                            $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                            self::$openBookmark = 0;
                        }
                        $sRet .= '</w:p></w:tbl>';
                        self::$openPs = false;
                    } else {
                        if (self::$openTable > 1) {
                            //This is to fix a Word bug that does not allow to close a table and write just after a </w:tc>
                            $sRet .= '</w:tbl><w:p />';
                        } else {
                            $sRet .= '</w:tbl>';
                        }
                    }
                    self::$openTable--;
                    break;
                case 'tr':
                    //Before closing a row we should make sure that there are no lacking cells due to a previous rowspan
                    $row = count(self::$tableGrid[self::$openTable]) - 1;
                    $column = count(self::$tableGrid[self::$openTable][$row]);
                    $sRet .= $this->closeTr($row, $column);
                    if (strpos(self::$WordML, '#<w:gridCol/>#') !== false) {
                        self::$WordML = str_replace('#<w:gridCol/>#', str_repeat('<w:gridCol w:w="1"/>', $column), self::$WordML);
                    }
                    //We now may close the tr tag
                    $sRet .= '</w:tr>';
                    break;
                case 'td':
                case 'th':
                    if (self::$openPs) {
                        if (self::$openLinks) {
                            $sRet.= '</w:hyperlink>';
                            self::$openLinks = false;
                        }
                        if (self::$openBookmark > 0) {
                            $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                            self::$openBookmark = 0;
                        }
                        $sRet .= '</w:p>';
                        if (self::$openBr) {
                            for ($p = 0; $p < self::$openBr; $p++) {
                                $sRet .= '<w:p />';
                            }
                            self::$openBr = 0;
                        }
                        $sRet .= '</w:tc>';
                        self::$openPs = false;
                    } else {
                        if (self::$openBr) {
                            for ($p = 0; $p < self::$openBr; $p++) {
                                $sRet .= '<w:p />';
                            }
                            self::$openBr = 0;
                        }
                        $sRet .= '</w:tc>';
                    }
                    break;
                case 'a':
                    if (self::$openLinks) {
                        $sRet.= '</w:hyperlink>';
                        self::$openLinks = false;
                    }
                    if (self::$openBookmark > 0) {
                        $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                        self::$openBookmark = 0;
                    }
                    break;
                case 'sub':
                case 'sup':
                    self::$openScript = '';
                    break;
                case '#text':
                    if ($currentTag == 'close' && !self::$openSelect && !self::$openTextArea) {
                        if (self::$openLinks) {
                            $sRet.= '</w:hyperlink>';
                            self::$openLinks = false;
                        }
                        if (self::$openBookmark > 0) {
                            $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                            self::$openBookmark = 0;
                        }
                        $sRet .= '</w:p>';
                        self::$openPs = false;
                    }
                    break;
                case 'select':
                    self::$openSelect = false;
                    $dropdownId = uniqid(mt_rand(999, 9999));
                    $bookmarkId = rand(99999, 99999999);
                    //Now we have to write the whole wordML
                    $sRet .= '<w:bookmarkStart w:id="' . $bookmarkId . '" w:name="d_' . $dropdownId . '"/><w:r><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="d_' . $dropdownId . '"/><w:enabled/><w:calcOnExit w:val="0"/><w:ddList>';
                    foreach (self::$selectOptions as $key => $value) {
                        $sRet .= '<w:listEntry w:val="' . $value . '"/>';
                    }
                    $sRet .= '</w:ddList></w:ffData></w:fldChar></w:r><w:r><w:instrText xml:space="preserve"> FORMDROPDOWN </w:instrText></w:r><w:r><w:fldChar w:fldCharType="end"/></w:r><w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
                    if ($currentTag == 'close' && self::$openPs) {
                        $sRet .= '</w:p>';
                        self::$openPs = false;
                    }
                    break;
                case 'option':
                    self::$openSelect = false;
                    break;
                case 'textarea':
                    self::$openTextArea = false;
                    $bookmarkId = rand(99999, 9999999);
                    $uniqueName = uniqid(mt_rand(999, 9999));
                    $sRet .= '<w:r><w:fldChar w:fldCharType="begin"><w:ffData><w:name w:val="Texto' . $uniqueName . '"/><w:enabled/><w:calcOnExit w:val="0"/><w:textInput/></w:ffData></w:fldChar></w:r><w:bookmarkStart w:id="' . $bookmarkId . '" w:name="Texto' . $uniqueName . '"/><w:r><w:instrText xml:space="preserve"> FORMTEXT </w:instrText></w:r><w:r><w:fldChar w:fldCharType="separate"/></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve">';
                    if (self::$textArea != '') {
                        $sRet .= self::$textArea;
                    } else {
                        if (isset($nodo['attributes']['size']) && $nodo['attributes']['size'] > 0) {
                            $size = $nodo['attributes']['size'];
                        } else {
                            $size = 18;
                        }
                        for ($k = 0; $k <= $size; $k++) {
                            $sRet .= ' '; //blank characters for Word
                        }
                    }
                    $sRet .= '</w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:rPr><w:noProof/></w:rPr><w:t xml:space="preserve"> </w:t></w:r><w:r><w:fldChar w:fldCharType="end"/></w:r><w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
                    if ($currentTag == 'close' && self::$openPs) {
                        $sRet .= '</w:p>';
                        self::$openPs = false;
                    }
                    break;
                default:
                    if ($currentTag == 'close') {
                        if (self::$openLinks) {
                            $sRet.= '</w:hyperlink>';
                            self::$openLinks = false;
                        }
                        if (self::$openBookmark > 0) {
                            $sRet.= '<w:bookmarkEnd w:id="' . self::$openBookmark . '" />';
                            self::$openBookmark = 0;
                        }
                        if (self::$openPs) {
                            $sRet .= '</w:p >';
                            if (self::$openBr) {
                                $sRet .= '<w:p />';
                                self::$openBr = false;
                            }
                            self::$openPs = false;
                        }
                    }
            }
        }

        return($sRet);
    }

    /**
     * This function returns the default style for paragraphs inside a list
     *
     * @access private
     * @return string
     */
    private function listStyle()
    {
        return 'ListParagraphPHPDOCX';
    }

    /**
     * This function returns the default types of lists
     *
     * @access private
     * @param array $tipo
     * @return string
     */
    private function listType($tipo = array(1, 2))
    {
        $counter = count(self::$openTags);
        for ($j = $counter; $j >= ($this->_level - 1); $j--) {
            if (@self::$openTags[$j] == 'ul') {
                $num = $tipo[0];
                break;
            } else if (@self::$openTags[$j] == 'ol') {
                $num = $tipo[1];
                break;
            }
        }
        if (isset($num)) {
            return $num;
        } else {
            return $tipo[0];
        }
    }

    /**
     * This function returns the WordML formatting for a paragraph
     * Support:
     * w:pStyle,
     * w:keepNext (page-break-after="avoid"),
     * w:keepLines (page-break-inside="avoid"),
     * w:pageBreakBefore (page-break-before="always"),
     * w:widowControl (page-break-before="avoid"),
     * w:pBdr (border-[top|left|bottom|right]-style!="none")(border-[top|left|bottom|right]-color)(border-[top|left|bottom|right]-width)(border!="none"),
     * w:shd (background-color)(background),
     * w:bidi (attribute dir="rtl"),
     * w:spacing ([margin|padding]-top)([margin|padding]-bottom)(font-size)(line-height),
     * w:ind ([margin|padding]-left)([margin|padding]-right)(font-size)(text-indent),
     * w:jc (text-align),
     * w:textDirection (attribute dir="rtl"),
     * w:textAlignment (vertical-align!="baseline")(font-size),
     * w:outlineLvl
     *
     * @access private
     * @param array $properties
     * @param array $level
     * @return string
     */
    private function generatePPr($properties, $level = '', $attributes = array(), $nodeName = false)
    {
        $stringPPr = '<w:pPr>';
        $sTempStyle = $this->generateWordStyle($nodeName, $attributes);
        if ($sTempStyle) {
            $stringPPr .= '<w:pStyle w:val="' . $sTempStyle . '"/>';
        }

        if (isset($properties['page_break_after']) && $properties['page_break_after'] == 'avoid') {
            $stringPPr .= '<w:keepNext w:val="on" />';
        }
        if (isset($properties['page_break_inside']) && $properties['page_break_inside'] == 'avoid') {
            $stringPPr .= '<w:keepLines w:val="on" />';
        }
        if (isset($properties['page_break_before']) && $properties['page_break_before'] == 'always') {
            $stringPPr .= '<w:pageBreakBefore w:val="on" />';
        }
        if (isset($properties['float']) && ($properties['float'] == 'left' || $properties['float'] == 'right') && $this->parseFloats) {
            $distance = array();
            foreach (self::$borders as $key => $value) {
                $distance[$value] = $this->imageMargins($properties['margin_' . $value], $properties['padding_' . $value], $properties['font_size']);
            }
            $stringPPr .= '<w:framePr w:w="' . ($distance['right'] - $distance['left']) . '" w:h="' . ($distance['top'] - $distance['bottom']) . '" w:vSpace="' . $distance['top'] . '" w:hSpace="' . $distance['right'] . '" w:wrap="around" w:hAnchor="text" w:vAnchor="text" w:xAlign="' . $properties['float'] . '" w:yAlign="inside" />';
        }
        if (isset($properties['page_break_before']) && $properties['page_break_before'] == 'avoid') {
            $stringPPr .= '<w:widowControl w:val="off" />';
        } else {
            $stringPPr .= '<w:widowControl w:val="on" />';
        }
        if (!$this->strictWordStyles) {
            $stringPPr .= '<w:pBdr>';
            foreach (self::$borders as $key => $value) {
                if (isset($properties['border_' . $value . '_style']) && $properties['border_' . $value . '_style'] != 'none') {
                    $stringPPr .= '<w:' . $value . ' w:val="' . $this->getBorderStyles($properties['border_' . $value . '_style']) . '"  w:color="' . $this->wordMLColor($properties['border_' . $value . '_color']) . '" w:sz="' . $this->wordMLLineWidth(isset($properties['border_' . $value . '_width']) ? $properties['border_' . $value . '_width'] : '') . '" />';
                }
            }
            $stringPPr .= '</w:pBdr>';
            if (isset($properties['background_color']) && is_array($properties['background_color'])) {
                $color = $properties['background_color'];
                $color = $this->wordMLColor($color);
                $stringPPr .='<w:shd w:val="clear"  w:color="auto" w:fill="' . $color . '" />';
            }
        }
        //w:wordWrap //css3
        if ((isset($attributes['dir']) && strtolower($attributes['dir']) == 'rtl') ||
                (isset($properties['direction']) && strtolower($properties['direction']) == 'rtl')) {
            $stringPPr .= '<w:bidi w:val="1" />';
        }
        if (!$this->strictWordStyles) {
            $stringPPr .= $this->pPrSpacing($properties);
            $stringPPr .= $this->pPrIndent($properties);

            if (isset($properties['text_align'])) {
                $textAlign = self::$text_align[$properties['text_align']];
                if (empty($textAlign)) {
                    $textAlign = 'left';
                }
                $stringPPr .= '<w:jc w:val="' . $textAlign . '" />';
            }
        }
        if (isset($attributes['dir']) && array_key_exists($attributes['dir'], self::$text_direction)) {
            $stringPPr .= '<w:textDirection w:val="' . self::$text_direction[$attributes['dir']] . '" />';
        }
        if (!$this->strictWordStyles) {
            if (isset($properties['vertical_align']) && $properties['vertical_align'] != 'baseline') {
                $stringPPr .='<w:textAlignment w:val="' . $this->_verticalAlign($properties['vertical_align']) . '" />';
            }
        }
        if (is_numeric($level)) {
            $stringPPr .= $this->setHeading($level);
        }

        $stringPPr .= '</w:pPr>';
        return $stringPPr;
    }

    /**
     * This function returns the WordML formatting for a run of text
     * Support:
     * w:rFonts (font-family!="serif"),
     * w:b (font-weight="[bold|bolder]"),
     * w:i (font-style=["italic|oblique"),
     * w:caps (text-transform="uppercase"),
     * w:smallCaps (font-variant="small-caps"),
     * w:strike (text-decoration="line-through"),
     * w:color (color),
     * w:position (vertical-align!="baseline")(font-size),
     * w:sz (font-size),
     * w:u (text-decoration="underline")
     *
     * @access private
     * @param array $properties
     * @return string
     */
    private function generateRPr($properties, $level = '', $attributes = array(), $nodeName = false)
    {
        $stringRPr = '<w:rPr>';
        $sTempStyle = $this->generateWordStyle($nodeName, $attributes);
        if ($sTempStyle) {
            $stringRPr .= '<w:rStyle w:val="' . $sTempStyle . '"/>';
        }
        if (!$this->strictWordStyles) {
            if (isset($properties['font_family']) && $properties['font_family'] != 'serif') {
                $arrayCSSFonts = explode(',', $properties['font_family']);
                $font = trim($arrayCSSFonts[0]);
                $font = str_replace('"', '', $font);
                $stringRPr .= '<w:rFonts w:ascii="' . $font . '" w:hAnsi="' . $font . '" w:eastAsia="' . $font . '" w:cs="' . $font . '" /> ';
            }
        }
        if (@$properties['font_weight'] == 'bold' || @$properties['font_weight'] == 'bolder') {
            $stringRPr .='<w:b /><w:bCs />';
        }
        if (@$properties['font_style'] == 'italic' || @$properties['font_style'] == 'oblique') {
            $stringRPr .='<w:i /><w:iCs />';
        }
        if (isset($properties['text_transform']) && $properties['text_transform'] == 'uppercase') {
            $stringRPr .='<w:caps />';
        }
        if (isset($properties['font_variant']) && $properties['font_variant'] == 'small-caps') {
            $stringRPr .='<w:smallCaps />';
        }
        if (isset($properties['text_decoration']) && $properties['text_decoration'] == 'line-through') {
            $stringRPr .='<w:strike />';
        }
        if (!$this->strictWordStyles) {
            if (@$properties['color'] != '' && is_array($properties['color'])) {
                $color = $properties['color'];
                $color = $this->wordMLColor($color);
                $stringRPr .='<w:color w:val="' . $color . '" />';
            }
            if (isset($properties['vertical_align']) && $properties['vertical_align'] != 'baseline') {
                $stringRPr .='<w:position w:val="' . $this->_rprPosition($properties['vertical_align'], $properties['font_size']) . '" />';
            }
            if (@$properties['font_size'] != '') {
                $stringRPr .='<w:sz w:val="' . (int) round($properties['font_size'] * 2) . '" />';
                $stringRPr .='<w:szCs w:val="' . (int) round($properties['font_size'] * 2) . '" />';
            }
            /* The higlights in Word have their own simple type: ST_HighlightColor
             * if (isset($properties['background_color']) && is_array($properties['background_color'])) {
             * $color = $this->wordMLNamedColor($properties['background_color']);
             * $stringRPr .='<w:highlight w:val="' . $color . '" />';
              } */
        }
        if ((self::$openLinks && @$properties['text_decoration'] != 'none') || @$properties['text_decoration'] == 'underline') {
            $stringRPr .='<w:u w:val="single" />';
        }
        if (!$this->strictWordStyles) {
            //w:bdr
            if (@$properties['background_color'] != '' && is_array($properties['background_color'])) {
                $color = $properties['background_color'];
                $color = $this->wordMLColor($color);
                $stringRPr .='<w:shd w:val="clear" w:color="auto" w:fill="' . $color . '" />';
            }
        }
        if (self::$openScript != '') {
            $stringRPr .='<w:vertAlign w:val="' . self::$openScript . '" />';
        }
        //w:rtl
        if (isset($properties['direction']) && strtolower($properties['direction']) == 'rtl') {
            $stringRPr .='<w:rtl w:val="1" />';
        }
        //w:em //text-emphasis (css 3)
        //w:oMath
        $stringRPr .= '</w:rPr>';
        return $stringRPr;
    }

    /**
     * This function returns the WordML formatting for a table
     * Support:
     * w:tblStyle (border),
     * w:bidiVisual (attribute dir="rtl"),
     * w:tblW (width),
     * w:jc (attribute align),
     * w:tblCellSpacing ([attribute cellspacing|border-spacing]),
     * w:tblInd (text-indent),
     * w:tblBorders (border_width)(border-[top|left|bottom|right]-style)(border-[top|left|bottom|right]-color)(border-[top|left|bottom|right]-width),
     * w:shd (background)(background-color),
     *
     * @access private
     * @param array $properties
     * @param integer $border
     * @return string
     */
    private function generateTblPr($properties, $attributes)
    {
        $stringTblPr = '<w:tblPr>';
        $sTempStyle = $this->generateWordStyle('table', $attributes);
        if (empty($sTempStyle)) {
            if (isset($attributes['border']) && ((int) $attributes['border']) >= 1) {
                $stringTblPr .= '<w:tblStyle w:val="TableGridPHPDOCX" />';
            } else {
                $stringTblPr .= '<w:tblStyle w:val="NormalTablePHPDOCX" />';
            }
        } else {
            $stringTblPr .= '<w:tblStyle w:val="' . $sTempStyle . '"/>';
        }
        if (isset($properties['float']) && ($properties['float'] == 'left' || $properties['float'] == 'right') && $this->parseFloats) {
            $distance = array();
            foreach (self::$borders as $key => $value) {
                $distance[$value] = $this->imageMargins($properties['margin_' . $value], $properties['padding_' . $value], $properties['font_size']);
            }
            $stringTblPr .= '<w:tblpPr w:leftFromText="' . $distance['left'] . '" w:rightFromText="' . $distance['right'] . '" w:topFromText="' . $distance['top'] . '" w:bottomFromText="' . $distance['bottom'] . '" w:horzAnchor="text" w:vertAnchor="text" w:tblpXSpec="' . $properties['float'] . '" w:tblpYSpec="inside" />';
        }
        if ((isset($attributes['dir']) && strtolower($attributes['dir']) == 'rtl') ||
                (isset($properties['direction']) && strtolower($properties['direction']) == 'rtl')) {
            $stringTblPr .= '<w:bidiVisual w:val="1" />';
        }

        //TODO OpenOffice needs $tableWidth > 0; else paints a table with double page width; don't work <w:tblW w:w="0" w:type="auto"/>
        if (!empty($properties['width'])) {
            list($tableWidth, $tableWidthType) = $this->_wordMLUnits($properties['width']);
            $stringTblPr .= '<w:tblW w:w="' . (int) ceil($tableWidth) . '" w:type="' . (empty($tableWidth) ? 'auto' : $tableWidthType) . '" />';
        }
        if (!$this->strictWordStyles) {
            if (!empty($attributes['align'])) {
                $stringTblPr .= '<w:jc w:val="' . $attributes['align'] . '" />';
            }
            if ((!empty($attributes['cellspacing']) || !empty($properties['border_spacing'])) && isset($properties['border_collapse']) && $properties['border_collapse'] != 'collapse') {
                $temp = trim(empty($properties['border_spacing']) ? (empty($attributes['cellspacing']) ? 0 : $attributes['cellspacing']) : $properties['border_spacing']);
                //border_spacing -> 1 or 2 values (horizontal, vertical); using only first (horizontal) //TODO calculate media (border_spacing="30px 10%")
                if (strpos($temp, ' ') !== false)
                    $temp = substr($temp, 0, strpos($temp, ' '));
                $temp = $this->_wordMLUnits($temp);
                $stringTblPr .= '<w:tblCellSpacing w:w="' . $temp[0] . '" w:type="' . (empty($temp[0]) ? 'auto' : $temp[1]) . '" />';
            }
            if (isset($properties['margin_left'])) {
                $temp = $this->_wordMLUnits($properties['margin_left']);
                $stringTblPr .= '<w:tblInd w:w="' . $temp[0] . '" w:type="' . (empty($temp[0]) ? 'auto' : $temp[1]) . '" />';
            }
            if ($this->tableStyle == '') {
                if (!empty($properties['border_width']) ||
                        !empty($properties['border_top_width']) ||
                        !empty($properties['border_right_width']) ||
                        !empty($properties['border_bottom_width']) ||
                        !empty($properties['border_left_width'])) {
                    $stringTblPr .= '<w:tblBorders>';
                    foreach (self::$borders as $key => $value) {
                        if (isset($properties['border_' . $value . '_style']) && $properties['border_' . $value . '_color'] != 'none' && $properties['border_' . $value . '_width'] != NULL) {
                            $stringTblPr .= '<w:' . $value . ' w:val="' . $this->getBorderStyles($properties['border_' . $value . '_style']) . '"  w:color="' . $this->wordMLColor($properties['border_' . $value . '_color']) . '" w:sz="' . $this->wordMLLineWidth(isset($properties['border_' . $value . '_width']) ? $properties['border_' . $value . '_width'] : '') . '" />';
                        }
                    }
                    $stringTblPr .= '</w:tblBorders>';
                }
                if (isset($properties['background_color']) && is_array($properties['background_color'])) {
                    $color = $properties['background_color'];
                    $color = $this->wordMLColor($color);
                    $stringTblPr .='<w:shd w:val="clear" w:color="auto" w:fill="' . $color . '" />';
                } else if (isset(self::$rowColor) && is_array(self::$rowColor)) {
                    $color = self::$rowColor;
                    $color = $this->wordMLColor($color);
                    $stringTblPr .='<w:shd w:val="clear" w:color="auto" w:fill="' . $color . '" />';
                }
            }
            //w:tblLayout
            //w:tblCellMar
        }
        $stringTblPr .= '</w:tblPr>';
        $stringTblPr .= '<w:tblGrid>#<w:gridCol/>#</w:tblGrid>';
        return $stringTblPr;
    }

    /**
     * This function returns the WordML formatting for a table row
     * Support:
     * w:trHeight (height),
     * w:tblHeader (display="table-header-group"),
     * w:jc (text_align)
     *
     * @access private
     * @param array $properties
     * @return string
     */
    private function generateTrPr($properties)
    {
        $stringTrPr = '<w:trPr>';
        //w:gridBefore
        //w:gridAfter
        //w:wBefore
        //w:wAfter
        if (isset($properties['page_break_inside']) && $properties['page_break_inside'] == 'avoid') {
            $stringTrPr .= '<w:cantSplit />';
        }
        if (!empty($properties['height'])) {
            $temp = $this->_wordMLUnits($properties['height']);
            $stringTrPr .= '<w:trHeight w:val="' . $temp[0] . '" w:hRule="atLeast" />';
        }
        if (isset($properties['display']) && $properties['display'] == 'table-header-group') {
            $stringTrPr .='<w:tblHeader />';
        }
        //the trPr jc property is commented because it overrides the global table align properties!!!
        /* if (!$this->strictWordStyles) {
          //w:tblCellSpacing
          if (isset($properties['text_align'])) {
          $textAlign = self::$text_align[$properties['text_align']];
          if (empty($textAlign)) {
          $textAlign = 'left';
          }
          $stringTrPr .= '<w:jc w:val="' . $textAlign . '" />';
          }
          } */
        $stringTrPr .= '</w:trPr>';
        return $stringTrPr;
    }

    /**
     * This function returns the WordML formatting for a table cell
     * Support:
     * w:tcW (width),
     * w:gridSpan (attribute colspan),
     * w:vMerge (attribute rowspan),
     * w:tcBorders (border-[top|left|bottom|right]-style!="none")(border-[top|left|bottom|right]-color)(border-[top|left|bottom|right]-width)(border),
     * w:shd (background-color)(background),
     * w:vAlign (vertical-align)
     *
     * @access private
     * @param array $properties
     * @param integer $colspan
     * @param integer $rowspan
     * @param boolean $firstRow
     * @return string
     */
    private function generateTcPr($properties, $attributes, $colspan, $rowspan, $firstRow)
    {
        $stringTcPr = '<w:tcPr>';
        if (@$properties['width'] != '') {
            list($cellWidth, $cellWidthType) = $this->_wordMLUnits($properties['width']);
            if ($cellWidth != 0 || $cellWidth != '') {
                $stringTcPr .= '<w:tcW w:w="' . $cellWidth . '" w:type="' . (empty($cellWidth) ? 'auto' : $cellWidthType) . '" />';
            }
        }
        if ($colspan > 1) {
            $stringTcPr .= '<w:gridSpan w:val="' . $colspan . '" />';
        }
        //w:hMerge
        if ($rowspan > 1) {
            $stringTcPr .= '<w:vMerge w:val="restart" />';
        }
        if (!$this->strictWordStyles) {
            if ($this->tableStyle == '') {
                $sTemp = '';
                foreach (self::$borders as $key => $value) {
                    if (!empty($properties['border_' . $value . '_width']) && @$properties['border_' . $value . '_style'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset($properties['border_' . $value . '_style']) ? $properties['border_' . $value . '_style'] : false) . '"  w:color="' . (isset($properties['border_' . $value . '_color']) ? $this->wordMLColor($properties['border_' . $value . '_color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset($properties['border_' . $value . '_width']) ? $properties['border_' . $value . '_width'] : false) . '" />';
                    } else if (!empty(self::$borderRow[$value]['width']) && @self::$borderRow[$value]['width'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset(self::$borderRow[$value]['style']) ? self::$borderRow[$value]['style'] : false) . '"  w:color="' . (isset(self::$borderRow[$value]['color']) ? $this->wordMLColor(self::$borderRow[$value]['color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset(self::$borderRow[$value]['width']) ? self::$borderRow[$value]['width'] : false) . '" />';
                    }
                }
                if (!empty($sTemp))
                    $stringTcPr .= '<w:tcBorders>' . $sTemp . '</w:tcBorders>';

                if (isset($properties['background_color']) && is_array($properties['background_color'])) {
                    $color = $properties['background_color'];
                    $color = $this->wordMLColor($color);
                    $stringTcPr .='<w:shd w:val="clear" w:color="auto" w:fill="' . $color . '" />';
                } else if (isset(self::$rowColor) && is_array(self::$rowColor)) {
                    $color = self::$rowColor;
                    $color = $this->wordMLColor($color);
                    $stringTcPr .='<w:shd w:val="clear" w:color="auto" w:fill="' . $color . '" />';
                }
            }
            //w:noWrap
            $stringTcPr .= $this->tcPrSpacing($properties);
            if (isset($attributes['dir']) && array_key_exists($attributes['dir'], self::$text_direction)) {
                $stringTcPr .= '<w:textDirection w:val="' . self::$text_direction[$attributes['dir']] . '" />';
            }
            //w:tcFitText
            if (isset($properties['vertical_align']) && $properties['vertical_align'] != 'baseline') {
                $stringTcPr .= '<w:vAlign w:val="' . $this->_verticalAlign($properties['vertical_align']) . '"/>';
            }
        }
        $stringTcPr .= '</w:tcPr>';
        return $stringTcPr;
    }

    /**
     * This function returns the WordML formatting for a list
     * Support:
     * w:pStyle,
     * w:numPr (tag [ol|ul]),
     * w:shd (background-color)(background),
     * w:spacing ([margin|padding]-top)([margin|padding]-bottom)(font-size)(line-height),
     * w:contextualSpacing,
     * w:jc (text-align)
     *
     * @todo openoffice don't change bullets size
     * @access private
     * @param array $properties
     * @return string
     */
    private function generateListPr($properties)
    {
        $stringListPr = '<w:pPr>';
        if (isset($properties['list_style_type']) && $properties['list_style_type'] == 'none') {
            //We do not include numberings
        } else {
            // $stringListPr .= '<w:pStyle w:val="'.$this->listStyle().'"/>'; It does not seem necessary because the spacing is properly handled by the parser
            $stringListPr .= '<w:numPr><w:ilvl w:val="';
            $this->countTags = array_count_values(self::$openTags);
            $stringListPr .= max((@$this->countTags['ul'] + @$this->countTags['ol'] - 1), 0);
            $stringListPr .= '"/><w:numId w:val="';
            if (!empty(self::$currentCustomList)) {
                $stringListPr .= self::$currentCustomList;
            } else {
                $stringListPr .= $this->listType(array(CreateDocx::$numUL, CreateDocx::$numOL));
            }
            $stringListPr .= '"/></w:numPr>';
        }
        if (!$this->strictWordStyles) {
            if (isset($properties['background_color']) && is_array($properties['background_color'])) {
                $color = $properties['background_color'];
                $color = $this->wordMLColor($color);
                $stringListPr .='<w:shd w:val="clear"  w:color="auto" w:fill="' . $color . '" />';
            }
            $stringListPr .= $this->pPrSpacing($properties);
        }
        if (isset($properties['list_style_type']) && $properties['list_style_type'] == 'none') {
            $stringListPr .= $this->pPrIndent($properties);
        }
        //$stringListPr .= '<w:contextualSpacing />'; It does not seem necessary because the spacing is properly handled by the parser
        if (!$this->strictWordStyles) {
            if (isset($properties['text_align'])) {
                $textAlign = self::$text_align[$properties['text_align']];
                if (empty($textAlign)) {
                    $textAlign = 'left';
                }
                $stringListPr .= '<w:jc w:val="' . $textAlign . '" />';
            }
        }
        $stringListPr .= '<w:rPr>';

        if (!$this->strictWordStyles) {
            if (isset($properties['font_family']) && $properties['font_family'] != 'serif') {
                $arrayCSSFonts = explode(',', $properties['font_family']);
                $font = trim($arrayCSSFonts[0]);
                $font = str_replace('"', '', $font);
                $stringListPr .= '<w:rFonts w:ascii="' . $font . '" w:hAnsi="' . $font . '" w:eastAsia="' . $font . '" w:cs="' . $font . '" /> ';
            }
        }
        if (@$properties['font_weight'] == 'bold' || @$properties['font_weight'] == 'bolder') {
            $stringListPr .='<w:b /><w:bCs />';
        }
        if (@$properties['font_style'] == 'italic' || @$properties['font_style'] == 'oblique') {
            $stringListPr .='<w:i /><w:iCs />';
        }
        if (!$this->strictWordStyles) {
            if (@$properties['color'] != '' && is_array($properties['color'])) {
                $color = $properties['color'];
                $color = $this->wordMLColor($color);
                $stringListPr .='<w:color w:val="' . $color . '" />';
            }
            if (@$properties['font_size'] != '') {
                $stringListPr .='<w:sz w:val="' . (int) round($properties['font_size'] * 2) . '" />';
                $stringListPr .='<w:szCs w:val="' . (int) round($properties['font_size'] * 2) . '" />';
            }
            if (isset($properties['background_color']) && is_array($properties['background_color'])) {
                $color = $this->wordMLNamedColor($properties['background_color']);
                $stringListPr .='<w:highlight w:val="' . $color . '" />';
            }
        }
        $stringListPr .= '</w:rPr>';

        $stringListPr .= '</w:pPr>';
        return $stringListPr;
    }

    /**
     * This function returns the applicable Word style if any
     * wordStyles = array('#id|.class|<tag>' => 'style1', '#id|.class|<tag>' => 'style2', [...])
     * @access private
     * @param string $tag
     * @param array $attributes
     * @return string
     */
    private function generateWordStyle($tag, $attributes)
    {
        $sTempStyle = false;
        if (!empty($this->wordStyles)) {
            $attId = empty($attributes['id']) ? '' : $attributes['id'];
            $attClass = empty($attributes['class']) ? array() : $attributes['class'];
            $attTag = $tag;
            //First we check if there is a Word Style for the tag
            if (!empty($this->wordStyles['<' . $attTag . '>'])) {
                $sTempStyle = $this->wordStyles['<' . $attTag . '>'];
            }
            //Now we check for the classes
            foreach ($attClass as $key => $value) {
                if (!empty($this->wordStyles['.' . $value])) {
                    $sTempStyle = $this->wordStyles['.' . $value];
                }
            }
            //And now for the id
            if (!empty($this->wordStyles['#' . $attId])) {
                $sTempStyle = $this->wordStyles['#' . $attId];
            }
        }
        return $sTempStyle;
    }

    /**
     * This function is used to take care of rowspans and colspans
     *
     * @access private
     * @param integer $row
     * @param integer $column
     * @return integer
     */
    private function countEmptyColumns($row, $column)
    {
        if (isset(self::$tableGrid[self::$openTable][$row - 1][$column]) && self::$tableGrid[self::$openTable][$row - 1][$column][0] > 1) {
            $merge = array(self::$tableGrid[self::$openTable][$row - 1][$column][0], self::$tableGrid[self::$openTable][$row - 1][$column][1]);
            if ($merge[0] > 1) {
                self::$WordML .= '<w:tc><w:tcPr><w:gridSpan  w:val="' . $merge[1] . '" /><w:vMerge w:val="continue" />';
                //Now we have to take care of inherited tc borders
                $properties = self::$tableGrid[self::$openTable][$row - 1][$column][2];
                $sTemp = '';
                foreach (self::$borders as $key => $value) {
                    if (!empty($properties['border_' . $value . '_width']) && @$properties['border_' . $value . '_style'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset($properties['border_' . $value . '_style']) ? $properties['border_' . $value . '_style'] : false) . '"  w:color="' . (isset($properties['border_' . $value . '_color']) ? $this->wordMLColor($properties['border_' . $value . '_color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset($properties['border_' . $value . '_width']) ? $properties['border_' . $value . '_width'] : false) . '" />';
                    } else if (!empty(self::$borderRow[$value]['width']) && @self::$borderRow[$value]['width'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset(self::$borderRow[$value]['style']) ? self::$borderRow[$value]['style'] : false) . '"  w:color="' . (isset(self::$borderRow[$value]['color']) ? $this->wordMLColor(self::$borderRow[$value]['color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset(self::$borderRow[$value]['width']) ? self::$borderRow[$value]['width'] : false) . '" />';
                    }
                }
                if (!empty($sTemp))
                    self::$WordML .= '<w:tcBorders>' . $sTemp . '</w:tcBorders>';
                self::$WordML .= '</w:tcPr><w:p /></w:tc>';
                for ($k = 0; $k < $merge[1]; $k++) {
                    array_push(self::$tableGrid[self::$openTable][count(self::$tableGrid[self::$openTable]) - 1], array(self::$tableGrid[self::$openTable][$row - 1][$column][0] - 1, $merge[1] - $k, $properties));
                }
            }
            $this->countEmptyColumns($row, $column + $merge[1]);
        }
    }

    /**
     * This function is used to make sure that all table rows have the same grid
     *
     * @access private
     * @param integer $row
     * @param integer $column
     * @return integer
     */
    private function closeTr($row, $column, $colString = '')
    {
        if (isset(self::$tableGrid[self::$openTable][$row - 1][$column]) && self::$tableGrid[self::$openTable][$row - 1][$column][0] > 1) {
            $merge = array(self::$tableGrid[self::$openTable][$row - 1][$column][0], self::$tableGrid[self::$openTable][$row - 1][$column][1]);
            if ($merge[0] > 1) {
                $colString .= '<w:tc><w:tcPr><w:gridSpan  w:val="' . $merge[1] . '" /><w:vMerge w:val="continue" />';
                //Now we have to take care of inherited tc borders
                $properties = self::$tableGrid[self::$openTable][$row - 1][$column][2];
                $sTemp = '';
                foreach (self::$borders as $key => $value) {
                    if (!empty($properties['border_' . $value . '_width']) && @$properties['border_' . $value . '_style'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset($properties['border_' . $value . '_style']) ? $properties['border_' . $value . '_style'] : false) . '"  w:color="' . (isset($properties['border_' . $value . '_color']) ? $this->wordMLColor($properties['border_' . $value . '_color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset($properties['border_' . $value . '_width']) ? $properties['border_' . $value . '_width'] : false) . '" />';
                    } else if (!empty(self::$borderRow[$value]['width']) && @self::$borderRow[$value]['width'] != 'none') {
                        $sTemp .= '<w:' . $value . ' w:val="' . $this->getBorderStyles(isset(self::$borderRow[$value]['style']) ? self::$borderRow[$value]['style'] : false) . '"  w:color="' . (isset(self::$borderRow[$value]['color']) ? $this->wordMLColor(self::$borderRow[$value]['color']) : 0) . '" w:sz="' . $this->wordMLLineWidth(isset(self::$borderRow[$value]['width']) ? self::$borderRow[$value]['width'] : false) . '" />';
                    }
                }
                if (!empty($sTemp))
                    $colString .= '<w:tcBorders>' . $sTemp . '</w:tcBorders>';
                $colString .= '</w:tcPr><w:p /></w:tc>';
                for ($k = 0; $k < $merge[1]; $k++) {
                    array_push(self::$tableGrid[self::$openTable][count(self::$tableGrid[self::$openTable]) - 1], array(self::$tableGrid[self::$openTable][$row - 1][$column][0] - 1, $merge[1] - $k, $properties));
                }
            }

            $colString = $this->closeTr($row, $column + $merge[1], $colString);
        }
        return $colString;
    }

    /**
     * This function is used to make sure that the url has the desired format
     *
     * @access private
     * @param string $url
     * @return string
     */
    private function parseURL($url)
    {
        $urlParts = explode('//', $url);
        if ($urlParts[0] == 'http:' || $urlParts[0] == 'https:' || $urlParts[0] == 'file:') {
            return $url;
        } else if (($urlParts[0] == '' && count($urlParts) > 0)) {
            return 'http:' . $url;
        } else {
            if ($url[0] == '/') {
                $url = substr($url, 1);
            }
        }
        return $this->baseURL . $url;
    }

    /**
     * This function returns the parent element HTML tag
     *
     * @access private
     * @return string
     */
    private function getParentHTMLElementTag($depth)
    {
        if (isset(self::$openTags[$depth - 1])) {
            $HTMLTag = self::$openTags[$depth - 1];
        } else {
            $HTMLTag = '';
        }
        return $HTMLTag;
    }

    /**
     * This function is used to determine the spacing before and after a paragraph
     *
     * @access private
     * @return string
     */
    private function pPrSpacing($properties)
    {
        $before = 0;
        $after = 0;
        $line = 240;
        //let us look at the margin top
        if (!empty($properties['margin_top'])) {
            $temp = $this->_wordMLUnits($properties['margin_top'], $properties['font_size']);
            $before += (int) round($temp[0]);
        }
        //let us look now at the padding top
        if (!empty($properties['padding_top'])) {
            $temp = $this->_wordMLUnits($properties['padding_top'], $properties['font_size']);
            $before += (int) round($temp[0]);
        }
        //let us look at the margin bottom
        if (!empty($properties['margin_bottom'])) {
            $temp = $this->_wordMLUnits($properties['margin_bottom'], $properties['font_size']);
            $after += (int) round($temp[0]);
        }
        //let us look now at the padding bottom
        if (!empty($properties['padding_bottom'])) {
            $temp = $this->_wordMLUnits($properties['padding_bottom'], $properties['font_size']);
            $after += (int) round($temp[0]);
        }

        $before = max(0, $before);
        $after = max(0, $after);

        //we now check the line height property

        if (isset($properties['line_height'])) {
            if (isset($properties['font_size']) && $properties['font_size'] != 0) {
                $lineHeight = ( (float) $properties['line_height']) / ((float) $properties['font_size']);
                $line = (int) round($lineHeight * 200);
            } else {
                $lineHeight = ( (float) $properties['line_height']) / 12;
                $line = (int) round($lineHeight * 200);
            }
        }

        $spacing = '<w:spacing w:before="' . $before . '" w:after="' . $after . '" ';
        $spacing .= 'w:line="' . $line . '" w:lineRule="auto"';
        $spacing .= ' />';
        return $spacing;
    }

    /**
     * This function is used to determine the spacing before and after a cell
     *
     * @access private
     * @return string
     */
    private function tcPrSpacing($properties)
    {
        $top = $left = $bottom = $right = array(0, 'auto');

        if (!empty($properties['margin_top'])) {
            $top = $this->_wordMLUnits($properties['margin_top'], $properties['font_size']);
        }
        if (!empty($properties['padding_top'])) {
            $temp = $this->_wordMLUnits($properties['padding_top'], $properties['font_size']);
            if ($temp[0] > $top[0])
                $top = $temp;
        }

        if (!empty($properties['margin_bottom'])) {
            $bottom = $this->_wordMLUnits($properties['margin_bottom'], $properties['font_size']);
        }
        //let us look now at the padding bottom
        if (!empty($properties['padding_bottom'])) {
            $temp = $this->_wordMLUnits($properties['padding_bottom'], $properties['font_size']);
            if ($temp[0] > $bottom[0])
                $bottom = $temp;
        }

        $spacing = '<w:tcMar>';
        $spacing .= '<w:top w:w="' . $top[0] . '" w:type="' . $top[1] . '"/>';
        //$spacing .= '<w:left w:w="" w:type=""/>';
        $spacing .= '<w:bottom w:w="' . $bottom[0] . '" w:type="' . $bottom[1] . '"/>';
        //$spacing .= '<w:right w:w="" w:type=""/>';
        $spacing .= '</w:tcMar>';
        return $spacing;
    }

    /**
     * This function is used to determine the left and right indent of the paragraph
     *
     * @access private
     * @return string
     */
    private function pPrIndent($properties)
    {
        $left = 0;
        $right = 0;
        $firstLineIndent = 0;
        //let us look at the margin left
        if (!empty($properties['margin_left'])) {
            $temp = $this->_wordMLUnits($properties['margin_left'], $properties['font_size']);
            $left += (int) round($temp[0]);
        }
        //let us look now at the padding left
        if (!empty($properties['padding_left'])) {
            $temp = $this->_wordMLUnits($properties['padding_left'], $properties['font_size']);
            $left += (int) round($temp[0]);
        }
        //let us look at the margin right
        if (!empty($properties['margin_right'])) {
            $temp = $this->_wordMLUnits($properties['margin_right'], $properties['font_size']);
            $right += (int) round($temp[0]);
        }
        //let us look now at the padding right
        if (!empty($properties['padding_right'])) {
            $temp = $this->_wordMLUnits($properties['padding_right'], $properties['font_size']);
            $right += (int) round($temp[0]);
        }
        if (!empty($properties['text_indent'])) {
            $temp = $this->_wordMLUnits($properties['text_indent'], $properties['font_size']);
            $firstLineIndent = (int) round($temp[0]);
        }

        $indent = '<w:ind w:left="' . $left . '" w:right="' . $right . '" ';
        if ($firstLineIndent != 0) {
            $indent .= 'w:firstLine="' . $firstLineIndent . '" ';
        }
        $indent .= '/>';
        return $indent;
    }

    /**
     * This function converts the paragraph into a heading
     *
     * @access private
     * @return string
     */
    private function setHeading($level)
    {
        $heading = '<w:outlineLvl w:val="' . ($level - 1) . '"/>';
        return $heading;
    }

    /**
     * This function returns the width of a line in eigths of a point (the measure used in WordML)
     *
     * @access private
     * @param integer $size
     * @return integer
     */
    private function wordMLLineWidth($size)
    {
        return (int) round($size * 5 / 0.75);
    }

    /**
     * This function returns the colour as is used by WordML
     *
     * @access private
     * @param array $color
     * @return string
     */
    private function wordMLColor($color)
    {
        if (strtolower($color['hex']) == 'transparent') {
            return '';
        } else {
            return strtoupper(str_replace('#', '', $color['hex']));
        }
    }

    /**
     * This function returns the colour name as is used by WordML in highlighted text
      black	Black Highlighting Color
      blue	Blue Highlighting Color
      cyan	Cyan Highlighting Color
      green	Green Highlighting Color
      magenta	Magenta Highlighting Color
      red	Red Highlighting Color
      yellow	Yellow Highlighting Color
      white	White Highlighting Color
      darkBlue	Dark Blue Highlighting Color
      darkCyan	Dark Cyan Highlighting Color
      darkGreen	Dark Green Highlighting Color
      darkMagenta	Dark Magenta Highlighting Color
      darkRed	Dark Red Highlighting Color
      darkYellow	Dark Yellow Highlighting Color
      darkGray	Dark Gray Highlighting Color
      lightGray	Light Gray Highlighting Color
      none	No Text Highlighting
     *
     * @access private
     * @param string $color
     * @return string
     */
    private function wordMLNamedColor($color)
    {
        $color = strtoupper(str_replace('#', '', $color["hex"]));
        $wordMLColors = array('000000' => 'black', '0000ff' => 'blue', '00ffff' => 'cyan', '00ff00' => 'green', 'ff00ff' => 'magenta', 'ff0000' => 'red',
            'ffff00' => 'yellow', 'ffffff' => 'white', '00008b' => 'darkBlue', '008b8b' => 'darkCyan', '006400' => 'darkGreen', '8b008b' => 'darkMagenta',
            '8b0000' => 'darkRed', '808000' => 'darkYellow', 'a9a9a9' => 'darkGray', 'd3d3d3' => 'lightGray', '' => 'none');

        if (isset($wordMLColors[$color]))
            return($wordMLColors[$color]); //exact color



            
//return closest color
        $hex24 = 16777215;
        $retCol = '000000';
        $red_color = hexdec(substr($color, 0, 2));
        $green_color = hexdec(substr($color, 2, 4));
        $blue_color = hexdec(substr($color, 4));
        foreach ($wordMLColors as $key => $val) {
            $red = $red_color - hexdec(substr($key, 0, 2));
            $green = $green_color - hexdec(substr($key, 2, 4));
            $blue = $blue_color - hexdec(substr($key, 4));

            $dist = $red * $red + $green * $green + $blue * $blue; //distance between colors

            if ($dist <= $hex24) {
                $hex24 = $dist;
                $retCol = $key;
            }
        }

        return $wordMLColors[$retCol];



        //return strtoupper(str_replace('#', '', $color["hex"]));
    }

    /**
     * This function returns the border style if it is correct CSS, else it returns nil
     *
     * @access private
     * @param string $borderStyle
     * @return string
     */
    private function getBorderStyles($borderStyle)
    {
        if (!empty($borderStyle) && array_key_exists($borderStyle, self::$borderStyles)) {
            return self::$borderStyles[$borderStyle];
        } else {
            return 'nil';
        }
    }

    /**
     * This function returns the border style of an embeded image
     *
     * @access private
     * @param int $borderWidth
     * @param string $borderStyle
     * @return string
     */
    private function imageBorders($borderWidth, $borderStyle, $borderColor)
    {

        if ($borderWidth == 0) {
            $borderXML = '<a:ln w="0"><a:noFill/></a:ln>';
        } else {
            $borderXML = '<a:ln w="' . $borderWidth . '">
                            <a:solidFill>
                                <a:srgbClr val="' . $borderColor . '" />
                            </a:solidFill>
                            <a:prstDash val="' . self::$imageBorderStyles[$borderStyle] . '" />
                        </a:ln>';
        }

        return $borderXML;
    }

    /**
     * This function returns the image dimensions
     *
     * @access private
     * @param array $size
     * @param array $attributes
     * @return array
     */
    private function getImageDimensions($size, $attributes)
    {
        $width = $size[0];
        $height = $size[1];
        if (isset($attributes['width']) && is_numeric($attributes['width']) && $attributes['width'] > 1) {
            $cx = $attributes['width'] * 7200;
        } else if (empty($attributes['width']) && isset($attributes['height']) && is_numeric($attributes['height']) && $attributes['height'] > 1) {
            $cx = (int) ceil($width * $attributes['height'] / $height) * 7200;
        } else {
            $cx = $width * 7200;
        }
        if (isset($attributes['height']) && is_numeric($attributes['height']) && $attributes['height'] > 1) {
            $cy = $attributes['height'] * 7200;
        } else if (empty($attributes['height']) && isset($attributes['width']) && is_numeric($attributes['width']) && $attributes['width'] > 1) {
            $cy = (int) ceil($height * $attributes['width'] / $width) * 7200;
        } else {
            $cy = $height * 7200;
        }

        return array($cx, $cy);
    }

    /**
     * This function returns the margin for the image
     *
     * @access private
     * @param string $margin
     * @param string $padding
     * @return string
     */
    private function imageMargins($margin, $padding, $fontSize)
    {

        $distance = 0;

        //let us look at the margin
        if ($margin != 0) {
            $temp = $this->_wordMLUnits($margin, $fontSize);
            $distance += (int) round($temp[0]);
        }

        //let us look at the padding
        if ($padding != 0) {
            $temp = $this->_wordMLUnits($padding, $fontSize);
            $distance += (int) round($temp[0]);
        }

        return (int) round($distance * 635 * 0.75); //we are multypling by the scaling factor between twips and emus. The factor of 0.75 is ours to keep the extra scaling ratio we use on images
    }

    /**
     * This function repairs the problem of empty cells in a table
     *
     * @access private
     * @return string
     */
    private function repairWordML($data)
    {
        //This is to fix the problem with empty cells in a table (a Word bug)
        $data = str_replace('</w:tcPr></w:tc>', '</w:tcPr><w:p /></w:tc>', $data);
        //We also clean extra line feeds generated by the parser after <br /> tags that may give problems with the rendering of WordML
        $data = preg_replace('/<w:br \/><w:t xml:space="preserve">[\n\r]+/', '<w:br /><w:t xml:space="preserve">', $data);
        //can not put two tables together
        $data = preg_replace('/<\/w:tbl><w:tbl>/i', '</w:tbl><w:p /><w:tbl>', $data);
        return $data;
    }

    /**
     * Translates HTML units to Word ML units
     *
     * @access private
     * @param string $sHtmlUnit Units in HTML format
     * @param string $fontSize Font size, if applicable
     * @return array
     */
    private function _wordMLUnits($sHtmlUnit, $fontSize = false)
    {
        if (!preg_match('/^(-?\d*\.?\d*)(%|em|pt|px)?$/i', trim($sHtmlUnit), $match))
            return(array(0, 'dxa'));

        $match[1] = (strpos($match[1], '.') === 0 ? '0' : '') . $match[1];
        $match[2] = empty($match[2]) ? '' : $match[2];

        //if($match[2] != 'em' && $match[2] != 'px' && !empty($fontSize)) $match[2] = 'pt';

        switch ($match[2]) {
            case '%': //in WordML the precentage is given in fiftieths of a percent
                $widthType = 'pct';
                $width = 50 * $match[1];
                break;
            case 'em':
                $widthType = 'dxa';
                $width = 20 * $match[1] * $fontSize;
                break;
            case 'pt': //in WordML the width is given in twentieths of a point
                $widthType = 'dxa';
                $width = 20 * $match[1];
                break;
            case 'px': //a pixel is around 3/4 of a point
            default: //if no unit we asume is given in pixels
                $widthType = 'dxa';
                $width = 15 * $match[1];
        }

        return(array($width, $widthType));
    }

    /**
     * Translates CSS units to pixels
     *
     * @access private
     * @param string $value CSS property value
     * @param string $fontSize 
     * @return array
     */
    private function CSSUnits2Pixels($value, $fontSize = 12)
    {
        if (!preg_match('/^(-?\d*\.?\d*)(%|em|pt|px)?$/i', trim($value), $match))
            return;

        $match[1] = (strpos($match[1], '.') === 0 ? '0' : '') . $match[1];
        $match[2] = empty($match[2]) ? '' : $match[2];

        switch ($match[2]) {
            case '%':
                return;
            case 'em':
                $pixels = ceil($match[1] / 0.75) * $fontSize;
                break;
            case 'pt': //in WordML the width is given in twentieths of a point
                $pixels = ceil($match[1] / 0.75);
                break;
            case 'px': //a pixel is around 3/4 of a point
            default: //if no unit we asume is given in pixels
                $pixels = $match[1];
        }

        return $pixels;
    }

    /**
     * Parse image vertical align property
     *
     * @access private
     * @param array $properties
     * @return array
     */
    private function generateImageRPr($properties, $height = 0)
    {
        //Notice: the position is given in half-points
        //get the height of the image in points
        $ptHeight = ceil(0.58 * $height / 7200);
        if (preg_match('/^(-?\d*\.?\d*)(%|em|pt|px)?$/i', trim($properties['vertical_align']), $match)) {
            $match[1] = (strpos($match[1], '.') === 0 ? '0' : '') . $match[1];
            $match[2] = empty($match[2]) ? '' : $match[2];

            switch ($match[2]) {
                case '%':
                    $position = ceil(2 * $match[1] * $ptHeight / 100);
                case 'em':
                    $position = ceil(2 * $match[1] * $properties['font_size']);
                    break;
                case 'pt':
                    $position = ceil(2 * $match[1]);
                    break;
                case 'px': //a pixel is around 3/4 of a point
                default: //if no unit we asume is given in pixels
                    $position = ceil(2 * $match[1] * 0.75);
            }
        } else if (array_key_exists($properties['vertical_align'], self::$imageVertAlignProps)) {
            if ($properties['vertical_align'] == 'middle') {
                $position = - 1 * ceil($ptHeight - 0.75 * $properties['font_size']);
            } else {
                $position = - 2 * ceil($ptHeight - 0.75 * $properties['font_size']);
            }
        } else {
            return;
        }
        return '<w:rPr><w:position w:val="' . $position . '"/></w:rPr>';
    }

    /**
     * Vertical position
     *
     * @access private
     * @param string $valign Vertical align
     * @param string $fontSize Font size, if applicable
     * @return array
     */
    private function _rprPosition($valign, $font_size)
    {
        $measureUnit = substr($valign, -2);
        $quantity = (int) substr($valign, 0, -2); //TODO: parse other posible non-numerical values like top.
        if ($valign == 'middle') {
            $measureUnit = 'em';
            $quantity = -0.5;
        }
        if ($valign == 'super') {
            $measureUnit = 'em';
            $quantity = 0.75;
        }
        if ($valign == 'sub') {
            $measureUnit = 'em';
            $quantity = -0.75;
        }
        if ($measureUnit == 'em') {
            $vertDisplacement = (int) round($quantity * 0.5 * $font_size);
        } else if ($measureUnit == 'px') {
            $vertDisplacement = (int) round($quantity * 0.5 * 0.75);
        } else {
            $vertDisplacement = (int) round($quantity * 0.5);
        }
        return($vertDisplacement);
    }

    /**
     * Vertical align
     *
     * @access private
     * @param string $valign Vertical align
     * @return string
     */
    private function _verticalAlign($valign = 'baseline')
    {
        $temp = $valign;
        switch ($temp) {
            case 'super':
            case 'top':
            case 'text-top':
                $temp = 'top';
                break;
            case 'middle':
                $temp = 'center';
                break;
            case 'sub':
            case 'baseline':
            case 'bottom':
            case 'text-bottom':
            default:
                $temp = 'bottom';
        }

        return($temp);
    }

}
