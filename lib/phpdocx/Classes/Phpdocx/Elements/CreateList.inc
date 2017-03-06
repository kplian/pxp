<?php
namespace Phpdocx\Elements;
use Phpdocx\Create\CreateDocx;
/**
 * Create lists
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateList extends CreateElement
{

    /**
     * Max depth
     */
    const MAXDEPTH = 8;

    /**
     *
     * @var mixed
     * @access public
     */
    public $list;

    /**
     *
     * @var array
     * @access public
     */
    public $val;

    /**
     *
     * @var string
     * @access public
     */
    public $font;

    /**
     *
     * @var array
     * @access public
     */
    public $data;

    /**
     * @access private
     * @var CreateList
     * @static
     */
    private static $_instance = NULL;

    /**
     *
     * @access private
     * @var int
     * @static
     */
    private static $_numericList = -1;

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
     * @return string
     */
    public function __toString()
    {
        $this->cleanTemplate();
        return $this->_xml;
    }

    /**
     *
     * @access public
     * @return CreateList
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateList();
        }
        return self::$_instance;
    }

    /**
     * Create list
     *
     * @access public
     * @param array args[0]
     * @param array args[1]
     */
    public function createList()
    {
        $this->_xml = '';
        $args = func_get_args();
        $this->list = '';
        if (!isset($args[1]['font'])) {
            $args[1]['font'] = '';
        }
        if ($args[1]['val'] == 2) {
            self::$_numericList++;
            $this->runArray(
                    $args[0], $args[1]['val'], 0, //before it was 1: changed
                    $args[1]
            );
        } else {
            $this->runArray($args[0], $args[1]['val'], 0, $args[1]);
        }

        $this->_xml = $this->list;
    }

    /**
     * Init list
     *
     * @access public
     * @param array $args[0]
     */
    public function initList()
    {
        $args = func_get_args();
        $this->val = $args[0][1]['val'];
        $this->data = $args[0][0];
    }

    /**
     * Add list
     *
     * @param string $list
     * @access protected
     */
    protected function add2List($list)
    {
        $this->_xml = str_replace('__GENERATER__', $list, $this->_xml);
    }

    /**
     * Generate w:ilfo
     *
     * @param int $val
     * @access protected
     */
    protected function generateILFO($val = 0)
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':ilfo ' . CreateElement::NAMESPACEWORD .
                ':val="' . $val .
                '"></' . CreateElement::NAMESPACEWORD .
                ':ilfo>';
        $this->_xml = str_replace('__GENERATEILFO__', $xml, $this->_xml);
    }

    /**
     * Generate w:ilvl
     *
     * @param string $val
     * @access protected
     */
    protected function generateILVL($val = '')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':ilvl ' . CreateElement::NAMESPACEWORD .
                ':val="' . $val . '"></' . CreateElement::NAMESPACEWORD .
                ':ilvl>__GENERATEPSTYLE__';
        $this->_xml = str_replace('__GENERATEPSTYLE__', $xml, $this->_xml);
    }

    /**
     * Generate w:ind
     *
     * @access protected
     */
    protected function generateIND($left = '720')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':ind w:left="' . $left . '" w:hanging="360"/>';

        $this->_xml = str_replace('__GENERATEIND__', $xml, $this->_xml);
    }

    /**
     * Generate w:listpr
     *
     * @access protected
     */
    protected function generateLISTPR()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':listPr>__GENERATEILVL____GENERATEILFO__</' .
                CreateElement::NAMESPACEWORD . ':listPr>__GENERATER__';
        $this->_xml = str_replace('__GENERATER__', $xml, $this->_xml);
    }

    /**
     * Generate w:lvl
     *
     * @access protected
     */
    protected function generateLVL($current)
    {
        $this->_xml = '<' . CreateElement::NAMESPACEWORD . ':lvl
                w:ilvl="' . $current . '" w:tplc="0C0A0001">__GENERATESTART__</' .
                CreateElement::NAMESPACEWORD . ':lvl>';
    }

    /**
     * Generate w:lvlJc
     *
     * @access protected
     */
    protected function generateLVLJC()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':lvlJc w:val="left"/>__generatePPRS__';

        $this->_xml = str_replace('__GENERATELVLJC__', $xml, $this->_xml);
    }

    /**
     * Generate w:lvlText
     *
     * @access protected
     */
    protected function generateLVLTEXT($bullet = '')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':lvlText w:val="' . $bullet . '"/>__GENERATELVLJC__';

        $this->_xml = str_replace('__GENERATELVLTEXT__', $xml, $this->_xml);
    }

    /**
     * Generate w:numFmt
     *
     * @access protected
     */
    protected function generateNUMFMT()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD . ':numFmt ' .
                CreateElement::NAMESPACEWORD .
                ':val="bullet"/>__GENERATELVLTEXT__';

        $this->_xml = str_replace('__GENERATENUMFMT__', $xml, $this->_xml);
    }

    /**
     * Generate w:numid
     *
     * @param int $val
     * @access protected
     */
    protected function generateNUMID($val)
    {
        if ($val == 2) {
            $val = CreateDocx::$numOL;
        } else if ($val === 0) {
            $val = '';
        } else if ($val == 1) {
            $val = CreateDocx::$numUL;
        }

        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':numId ' . CreateElement::NAMESPACEWORD .
                ':val="' . $val . '"></' . CreateElement::NAMESPACEWORD .
                ':numId>';
        $this->_xml = str_replace('__GENERATEPSTYLE__', $xml, $this->_xml);
    }

    /**
     * Generate w:numpr
     *
     * @access protected
     */
    protected function generateNUMPR()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':numPr>__GENERATEPSTYLE__</' . CreateElement::NAMESPACEWORD .
                ':numPr>';
        $this->_xml = str_replace('__GENERATEPSTYLE__', $xml, $this->_xml);
    }

    /**
     * Generate w:ppr
     *
     * @access protected
     */
    protected function generatePPRS()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD . ':pPr>__GENERATEIND__</' .
                CreateElement::NAMESPACEWORD . ':pPr>__GENERATRPR__';

        $this->_xml = str_replace('__generatePPRS__', $xml, $this->_xml);
    }

    /**
     * Generate w:pstyle
     *
     * @param string $val
     * @access protected
     */
    protected function generatePSTYLE($val)
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':pStyle ' . CreateElement::NAMESPACEWORD . ':val="' . $val .
                '"/>__GENERATEPSTYLE__';
        $this->_xml = str_replace('__GENERATEPPR__', $xml, $this->_xml);
    }

    /**
     * Generate w:rfonts
     *
     * @param string $font
     * @access protected
     */
    protected function generateRFONTSTYLE($font = 'Symbol')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':rFonts ' . CreateElement::NAMESPACEWORD .
                ':ascii="' . $font . '" ' . CreateElement::NAMESPACEWORD .
                ':hAnsi="' . $font . '" ' . CreateElement::NAMESPACEWORD .
                ':hint="default"/>';

        $this->_xml = str_replace('__GENERATERFONTS__', $xml, $this->_xml);
    }

    /**
     * Generate w:rpr
     *
     * @access protected
     */
    protected function generateRPRS()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD . ':rPr>__GENERATERFONTS__</' .
                CreateElement::NAMESPACEWORD . ':rPr>';

        $this->_xml = str_replace('__GENERATRPR__', $xml, $this->_xml);
    }

    /**
     * Recursive generation of lists
     *
     * @param array $dat
     * @param string $val
     * @param int $depth
     * @param string $font
     * @access protected
     */
    protected function runArray($dat, $val, $depth, $options = array())
    {
        foreach ($dat as $cont) {
            if (is_array($cont)) {
                $newDepth = $depth + 1;
                $this->runArray($cont, $val, $newDepth, $options);
            } else {
                $this->generateP();
                $this->generatePPR();
                $this->generatePSTYLE('ListParagraphPHPDOCX');
                $this->generateNUMPR();
                //$this->generateLISTPR();
                $this->generateILFO();
                $this->generateILVL($depth);
                $this->generateNUMID($val);
                if ($cont instanceof \DOCXPathResult) {
                    $runContent = $cont->inlineXML();
                    $this->add2List((string) $runContent);
                    $this->list .= $this->_xml;
                } else if ($cont instanceof WordFragment) {
                    $runContent = $cont->inlineWordML();
                    $this->add2List((string) $runContent);
                    $this->list .= $this->_xml;
                } else {
                    if (count($options) == 1) {
                        $this->generateR();
                        $this->generateT($cont);

                        $this->list .= $this->_xml;
                    } else {
                        $wf = new WordFragment();
                        $wf->addText($cont, $options);
                        $runContent = $wf->inlineWordML();
                        $this->add2List((string) $runContent);
                        $this->list .= $this->_xml;
                    }
                }
            }
        }
    }

    /**
     * Generate w:start
     *
     * @access protected
     */
    protected function generateSTART()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD . ':start ' .
                CreateElement::NAMESPACEWORD . ':val="1"/>__GENERATENUMFMT__';

        $this->_xml = str_replace('__GENERATESTART__', $xml, $this->_xml);
    }

}
