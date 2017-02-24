<?php
namespace Phpdocx\Elements;
/**
 * Create endnotes
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateEndnote extends CreateElement
{

    /**
     *
     * @var bool
     * @access public
     * @static
     */
    public static $init = 0;

    /**
     *
     * @var CreateEndnote
     * @access private
     * @static
     */
    private static $_instance = NULL;

    /**
     *
     * @var int
     * @access private
     * @static
     */
    private static $_id;

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
        return $this->_xml;
    }

    /**
     *
     * @return CreateEndnote
     * @access public
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateEndnote();
        }
        return self::$_instance;
    }

    /**
     * Create document endnote
     *
     * @access public
     */
    public function createDocumentEndnote()
    {
        $this->_xml = '';
        $args = func_get_args();
        parent::generateP();
        $this->generateR();
        if ($args[0]['font'] != '') {
            $this->generateRPR();
            $this->generateRFONTS($args[0]['font']);
        }
        $this->_xml = str_replace('__GENERATERPR__', '', $this->_xml);
        $this->generateT($args[0]['textDocument']);
        $this->generateR();
        $this->generateRPR();
        $this->generateRSTYLE();
        $this->generateENDNOTEREFERENCE(self::$_id - 2);
        $this->cleanTemplate();
    }

    /**
     * Create endnote
     *
     * @access public
     */
    public function createEndnote()
    {
        $this->_xml = '';
        $args = func_get_args();
        $this->generateENDNOTE('');
        $this->generateP();
        $this->generatePPR();
        $this->generatePSTYLE();
        $this->generateR();
        $this->generateRPR();
        $this->generateRSTYLE();
        $this->generateENDNOTEREF();
        $this->generateR();
        if ($args[0]['font'] != '') {
            $this->generateRPR();
            $this->generateRFONTS($args[0]['font']);
        }
        $this->generateT($args[0]['textEndNote']);
        $this->cleanTemplate();
    }

    /**
     * Create init endnote
     *
     * @access public
     */
    public function createInitEndnote()
    {
        $this->_xml = '';
        $arrArgs = func_get_args();
        $this->generateENDNOTE($arrArgs[0]['type']);
        $this->generateP();
        $this->generatePPR();
        $this->generateSPACING();
        $this->generateR();
        $this->generateSEPARATOR($arrArgs[0]['type']);
        $this->cleanTemplate();
    }

    /**
     * Generate w:endnote
     *
     * @param string $type
     * @access protected
     */
    protected function generateENDNOTE($type)
    {
        self::$init = 1;

        if (empty(self::$_id)) {
            self::$_id = 1;
        } else {
            self::$_id++;
        }

        $xmlAux = '<' . CreateElement::NAMESPACEWORD . ':endnote';
        if ($type != '') {
            $xmlAux .= ' ' . CreateElement::NAMESPACEWORD .
                    ':type="' . $type . '"';
        }
        
        $this->_xml = $xmlAux . ' ' . CreateElement::NAMESPACEWORD .
                ':id="' . (self::$_id - 2) . '">__GENERATEENDNOTE__</' .
                CreateElement::NAMESPACEWORD . ':endnote>';
    }

    /**
     * Generate w:endnoteref
     *
     * @access protected
     */
    protected function generateENDNOTEREF()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':endnoteRef></' . CreateElement::NAMESPACEWORD .
                ':endnoteRef>';

        $this->_xml = str_replace('__GENERATER__', $xml, $this->_xml);
    }

    /**
     * Generate w:endnotereference
     *
     * @param <type> $id
     * @access protected
     */
    protected function generateENDNOTEREFERENCE($id = '')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':endnoteReference ' . CreateElement::NAMESPACEWORD .
                ':id="' . $id . '"></' . CreateElement::NAMESPACEWORD .
                ':endnoteReference>';

        $this->_xml = str_replace('__GENERATER__', $xml, $this->_xml);
    }

    /**
     * Generate w:p
     *
     * @param string $rsidR
     * @param string $rsidRDefault
     * @param string $rsidP
     * @access protected
     */
    protected function generateP($rsidR = '005F02E5', $rsidRDefault = '005F02E5', $rsidP = '005F02E5')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':p>__GENERATEP__</' . CreateElement::NAMESPACEWORD . ':p>';

        $this->_xml = str_replace('__GENERATEENDNOTE__', $xml, $this->_xml);
    }

    /**
     * Generate w:ppr
     *
     * @access protected
     */
    protected function generatePPR()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':pPr>__GENERATEPPR__</' . CreateElement::NAMESPACEWORD .
                ':pPr>__GENERATEP__';

        $this->_xml = str_replace('__GENERATEP__', $xml, $this->_xml);
    }

    /**
     * Generate w:r
     *
     * @access protected
     */
    protected function generateR()
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':r>__GENERATER__</' . CreateElement::NAMESPACEWORD .
                ':r>__GENERATEP__';

        $this->_xml = str_replace('__GENERATEP__', $xml, $this->_xml);
    }

    /**
     * Generate w:separator
     *
     * @param string $type Optional, 'separator' as default.
     * @access protected
     */
    protected function generateSEPARATOR($type = 'separator')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':' . $type . '></' . CreateElement::NAMESPACEWORD .
                ':' . $type . '>';

        $this->_xml = str_replace('__GENERATER__', $xml, $this->_xml);
    }

    /**
     * Generate w:spacing
     *
     * @param int $after
     * @param int $line
     * @param string $lineRule
     * @access protected
     */
    protected function generateSPACING($after = '0', $line = '240', $lineRule = 'auto')
    {
        $xml = '<' . CreateElement::NAMESPACEWORD .
                ':spacing w:after="' . $after .
                '" ' . CreateElement::NAMESPACEWORD .
                ':line="' . $line . '" ' . CreateElement::NAMESPACEWORD .
                ':lineRule="' . $lineRule . '"></' .
                CreateElement::NAMESPACEWORD . ':spacing>';

        $this->_xml = str_replace('__GENERATEPPR__', $xml, $this->_xml);
    }

}
