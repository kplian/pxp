<?php
namespace Phpdocx\Elements;
/**
 * Create text box
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateTextBox extends CreateElement
{

    const NAMESPACEWORD = 'v';
    const NAMESPACETEXTBOX = 'w10';

    /**
     *
     * @access private
     * @var string
     */
    private $_align;

    /**
     *
     * @access private
     * @var string
     */
    private $_b;

    /**
     *
     * @access private
     * @var int
     */
    private $_border;

    /**
     *
     * @access private
     * @var string
     */
    private $_border_color;

    /**
     *
     * @access private
     * @var string
     */
    private $_color;

    /**
     *
     * @access private
     * @var string
     */
    private $_fillColor;

    /**
     *
     * @access private
     * @var string
     */
    private $_font;

    /**
     *
     * @access private
     * @var string
     */
    private $_height;

    /**
     *
     * @access private
     * @var string
     */
    private $_i;

    /**
     *
     * @access private
     * @static
     * @var CreateTextBox
     */
    private static $_instance = NULL;

    /**
     *
     * @access private
     * @var string
     */
    private $_jc;

    /**
     *
     * @access private
     * @var string
     */
    private $_marginBottom;

    /**
     *
     * @access private
     * @var string
     */
    private $_marginLeft;

    /**
     *
     * @access private
     * @var string
     */
    private $_marginRight;

    /**
     *
     * @access private
     * @var string
     */
    private $_marginTop;

    /**
     *
     * @access private
     * @var string
     */
    private $_pageBreakBefore;

    /**
     *
     * @access private
     * @var string
     */
    private $_sz;

    /**
     *
     * @access private
     * @var string
     */
    private $_text;

    /**
     *
     * @access private
     * @var string
     */
    private $_textJc;

    /**
     *
     * @access private
     * @var string
     */
    private $_u;

    /**
     *
     * @access private
     * @var string
     */
    private $_widowControl;

    /**
     *
     * @access private
     * @var string
     */
    private $_width;

    /**
     *
     * @access private
     * @var string
     */
    private $_wordWrap;

    /**
     *
     * @access private
     * @var string
     */
    private $_padding_top;

    /**
     *
     * @access private
     * @var string
     */
    private $_padding_right;

    /**
     *
     * @access private
     * @var string
     */
    private $_padding_bottom;

    /**
     *
     * @access private
     * @var string
     */
    private $_padding_left;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        $this->_text = '';
        $this->_marginTop = '';
        $this->_marginBottom = '';
        $this->_marginRight = '';
        $this->_marginLeft = '';
        $this->_width = '';
        $this->_height = '';
        $this->_align = '';
        $this->_fillColor = '';
        $this->_jc = '';
        $this->_textJc = '';
        $this->_b = '';
        $this->_color = '';
        $this->_i = '';
        $this->_sz = '';
        $this->_u = '';
        $this->_pageBreakBefore = '';
        $this->_widowControl = '';
        $this->_wordWrap = '';
        $this->_font = '';
        $this->_border = 1;
        $this->_border_color = '#000000';
        $this->_padding_top = "";
        $this->_padding_right = "";
        $this->_padding_bottom = "";
        $this->_padding_left = "";
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
     * @return CreateTextBox
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateTextBox();
        }
        return self::$_instance;
    }

    /**
     * Create textbox
     *
     * @access public
     * @param array $textboxContent
     * @param array $options
     */
    public function createTextBox($textboxContent, $options = array())
    {
        //set default values
        if (!isset($options['border'])) {
            $options['border'] = true;
        }
        if (!isset($options['textWrap'])) {
            $options['textWrap'] = 'square';
        }
        if (!isset($options['align'])) {
            $options['align'] = 'left';
        }
        if (isset($options['paddingBottom'])) {
            $paddingBottom = $options['paddingBottom'] . 'mm';
        } else {
            $paddingBottom = '1.3mm';
        }
        if (isset($options['paddingTop'])) {
            $paddingTop = $options['paddingTop'] . 'mm';
        } else {
            $paddingTop = '1.3mm';
        }
        if (isset($options['paddingLeft'])) {
            $paddingLeft = $options['paddingLeft'] . 'mm';
        } else {
            $paddingLeft = '2.5mm';
        }
        if (isset($options['paddingRight'])) {
            $paddingRight = $options['paddingRight'] . 'mm';
        } else {
            $paddingRight = '2.5mm';
        }
        if (isset($options['width'])) {
            $width = $options['width'] . 'pt';
        } else {
            $width = '180pt';
        }
        if (isset($options['height']) && $options['height'] != 'auto') {
            $height = $options['height'] . 'pt';
        } else if (isset($options['height']) && $options['height'] == 'auto') {
            $height = '140pt';
        } else if (!isset($options['height'])) {
            $height = '140pt';
            $options['height'] = 'auto';
        }
        $inset = $paddingLeft . ',' . $paddingTop . ',' . $paddingRight . ',' . $paddingBottom;
        $this->_xml = '<w:p><w:r><w:pict>';
        $this->_xml .= $this->generateSHAPE($options, $width, $height);
        $this->_xml .= '<v:textbox inset="' . $inset . '"';
        if ($options['height'] == 'auto') {
            $this->_xml .= ' style="mso-fit-shape-to-text:t"';
        }
        $this->_xml .= ' >';
        $this->_xml .= '<w:txbxContent>';
        $this->_xml .= $textboxContent;
        $this->_xml .= '</w:txbxContent></v:textbox>';
        $this->_xml .= $this->generateWRAP($options['textWrap']);
        $this->_xml .= '</v:shape></w:pict></w:r></w:p>';

        return $this->_xml;
    }

    /**
     * Generate w.shap tag
     *
     * @access private
     * @param array $options
     * @param string $width
     * @param string $height
     * @return string
     */
    private function generateSHAPE($options, $width, $height)
    {
        $align = array('left', 'center', 'right');
        $vAlign = array('top', 'center', 'bottom');
        $shape = '<v:shape id="_x0000_s' . rand(1000, 999999) . '" type="#_x0000_t202" style="';
        if (in_array($options['align'], $align)) {
            $shape .= 'position:absolute;';
            $shape .= 'mso-position-horizontal:' . $options['align'] . ';';
        }
        
        if (isset($options['margin_top']) && !empty($options['margin_top'])) {
            $shape .= 'margin-top:' . $options['margin_top'] * 28.3464567 . 'pt;';
        }
        if (isset($options['margin_left']) && !empty($options['margin_left'])) {
            $shape .= 'margin-left:' . $options['margin_left'] * 28.3464567 . 'pt;';
        }
        if (isset($options['margin_bottom']) && !empty($options['margin_bottom'])) {
            $shape .= 'margin-bottom:' . $options['margin_bottom'] * 28.3464567 . 'pt;';
        }
        if (isset($options['margin_right']) && !empty($options['margin_right'])) {
            $shape .= 'margin-right:' . $options['margin_right'] * 28.3464567 . 'pt;';
        }

        $shape .= 'width:' . $width . ';height:' . $height . ';';
        $shape .= 'z-index:' . rand(11111111, 999999999) . ';';
        if (in_array($options['contentVerticalAlign'], $vAlign)) {
            $shape .= 'v-text-anchor:' . $options['contentVerticalAlign'] . ';';
        }
        $shape .= '" '; //close the style attribute
        if (isset($options['fillColor'])) {
            $shape .= 'fillcolor="' . $options['fillColor'] . '" ';
        }
        if (isset($options['borderColor'])) {
            $shape .= 'strokecolor="' . $options['borderColor'] . '" ';
        }
        if (isset($options['borderWidth'])) {
            $shape .= 'strokeweight="' . $options['borderWidth'] . 'pt" ';
        }
        if (empty($options['border'])) {
            $shape .= 'stroked="false" ';
        }
        $shape .= ' >';

        return $shape;
    }

    /**
     * Generate w10:wrap tag
     *
     * @access private
     * @param string $textWrap
     * @return string
     */
    private function generateWRAP($textWrap = 'square')
    {
        return '<w10:wrap type="' . $textWrap . '" />';
    }

}
