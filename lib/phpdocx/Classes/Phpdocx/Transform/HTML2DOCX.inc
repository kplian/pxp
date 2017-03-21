<?php
namespace Phpdocx\Transform;
use Phpdocx\Create\CreateDocx;
/**
 * Transform HTML to DOCX
 *
 * @category   Phpdocx
 * @package    transform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
error_reporting(E_ERROR | E_USER_ERROR);
ini_set('display_errors', false);


require_once dirname(__FILE__) . '/..//..//../lib/VFXP.inc.php';
require_once dirname(__FILE__) . '/..//..//../lib/cssparser.php';

class HTML2DOCX
{

    /**
     *
     * @access private
     * @var array
     */
    private $_acceptedTags = array(
        '<a>' => 'a',
        '<address>' => 'address',
        '<b>' => 'b',
        '<br>' => 'br',
        '<body>' => 'body',
        '<cite>' => 'cite',
        '<dd>' => 'dd',
        '<div>' => 'div',
        '<dfn>' => 'dfn',
        '<dt>' => 'dt',
        '<em>' => 'em',
        '<font>' => 'font',
        '<h1>' => 'h1',
        '<h2>' => 'h2',
        '<h3>' => 'h3',
        '<h4>' => 'h4',
        '<h5>' => 'h5',
        '<h6>' => 'h6',
        '<hr>' => 'hr',
        '<i>' => 'i',
        '<img>' => 'img',
        '<li>' => 'li',
        '<ol>' => 'ol',
        '<p>' => 'p',
        '<span>' => 'span',
        '<strong>' => 'strong',
        '<table>' => 'table',
        '<tbody>' => 'tbody',
        '<td>' => 'td',
        '<th>' => 'th',
        '<tr>' => 'tr',
        '<title>' => 'title',
        '<u>' => 'u',
        '<ul>' => 'ul',
        '<var>' => 'var'
    );

    /**
     *
     * @access private
     * @var array
     */
    private $_cleanChars = array(
        '&Aacute;',
        '&Eacute;',
        '&Iacute;',
        '&Oacute;',
        '&Uacute;',
        '&Ntilde;',
        '&aacute;',
        '&eacute;',
        '&iacute;',
        '&oacute;',
        '&uacute;',
        'ntilde;',
        '&nbsp;',
        '&',
    );

    /**
     *
     * @access private
     * @var array
     */
    private $_cleanCharsTo = array(
        'Á',
        'É',
        'Í',
        'Ó',
        'Ú',
        'Ñ',
        'á',
        'é',
        'í',
        'ó',
        'ú',
        'ñ',
        ' ',
        '',
    );

    /**
     *
     * @access private
     * @var array
     */
    private $_preOptions = array(
        'b',
        'div',
        'i',
        'h1',
        'h2',
        'h3',
        'h4',
        'h5',
        'h6',
        'p',
        'span',
        'u',
    );

    /**
     *
     * @access private
     * @static
     * @var array
     */
    private static $_datsList;

    /**
     *
     * @access private
     * @static
     * @var array
     */
    private static $_datsTable;

    /**
     *
     * @access private
     * @static
     * @var array
     */
    private static $_datsText;

    /**
     *
     * @access private
     * @static
     * @var array
     */
    private static $_datsTextInline;

    /**
     *
     * @access private
     * @var int
     */
    private $_ind;

    /**
     *
     * @access private
     * @var CreateDocx
     */
    private $_docx;

    /**
     *
     * @access private
     * @var DOM
     */
    private $_rootXML;

    /**
     *
     * @access private
     * @var array
     */
    private $_css;

    /**
     *
     * @access private
     * @var array
     */
    private $_xml;

    /**
     *
     * @access private
     * @var string
     */
    private $_strCSS;

    /**
     *
     * @access private
     * @var string
     */
    private $_filename;

    /**
     *
     * @access private
     * @var string
     */
    private $_strHTML;

    /**
     * Construct
     *
     * @access public
     * @param string $html HTML
     */
    public function __construct($html = null)
    {
        $xmldoc = new \VFXP_Document();
        $this->_strHTML = $html;
        $this->_filename = 'documentHTML';
    }

    /**
     * Destruct
     *
     * @access private
     */
    public function __destruct()
    {
        
    }

    /**
     * Getter. CSS
     *
     * @access public
     * @return string
     */
    public function getCSS()
    {
        return $this->_strCSS;
    }

    /**
     * Getter. File name
     *
     * @access public
     * @return string
     */
    public function getFileName()
    {
        return $this->_filename;
    }

    /**
     * Getter. HTML
     *
     * @access public
     * @return string
     */
    public function getHTML()
    {
        return $this->_strHTML;
    }

    /**
     * Setter. CSS
     *
     * @access public
     * @param string $css
     */
    public function setCSS($css)
    {
        $this->_strCSS = str_replace(' ', '', $css);
    }

    /**
     * Setter. File name
     *
     * @access public
     * @param string $fileName
     */
    public function setFileName($fileName)
    {
        $this->_filename = $fileName;
    }

    /**
     * Setter. HTML
     *
     * @access public
     * @param string $html
     */
    public function setHTML($html)
    {
        $acceptedTags = array(
            '<address>' => 'address',
            '<b>' => 'b',
            '<br>' => 'br',
            '<cite>' => 'cite',
            '<dd>' => 'dd',
            '<div>' => 'div',
            '<dfn>' => 'dfn',
            '<dt>' => 'dt',
            '<em>' => 'em',
            '<font>' => 'font',
            '<h1>' => 'h1',
            '<h2>' => 'h2',
            '<h3>' => 'h3',
            '<h4>' => 'h4',
            '<h5>' => 'h5',
            '<h6>' => 'h6',
            '<hr>' => 'hr',
            '<i>' => 'i',
            '<img>' => 'img',
            '<li>' => 'li',
            '<ol>' => 'ol',
            '<p>' => 'p',
            '<span>' => 'span',
            '<strong>' => 'strong',
            '<table>' => 'table',
            '<tbody>' => 'tbody',
            '<td>' => 'td',
            '<th>' => 'th',
            '<tr>' => 'tr',
            '<title>' => 'title',
            '<u>' => 'u',
            '<ul>' => 'ul',
            '<var>' => 'var'
        );
        $html = str_replace('<br />', '</p><p>', $html);
        ob_start();
        echo $html;
        $html = ob_get_clean();
        $config = array(
            'indent' => true,
            'output-xhtml' => true,
            'wrap' => 200);
        $tidy = new tidy();
        $tidy->parseString($html, $config, 'utf8');
        $tidy->cleanRepair();
        $this->_strHTML = $tidy;
        $this->_strHTML = strip_tags(
                str_replace(
                        $this->_cleanChars, $this->_cleanCharsTo, $this->_strHTML
                ), implode(
                        '', array_keys($acceptedTags)
                )
        );
    }

    /**
     * Parse CSS styles
     *
     * @access private
     * @param cssparser $element
     * @param array $params
     */
    private function parserStylesCSS(&$element, &$params)
    {
        if ($element->attributeValue('class')) {
            $cssElement = $element->name() . '.' .
                    $element->attributeValue('class');
        } elseif ($element->attributeValue('id')) {
            $cssElement = $element->name() . '#' .
                    $element->attributeValue('id');
        } else {
            $cssElement = $element->name();
        }
        if ($this->_css->Get($cssElement, 'align')) {
            $params['jc'] = $this->_css->Get($cssElement, 'align');
        }
        if ($this->_css->Get($cssElement, 'border')) {
            $borderSize = preg_replace(
                    '/[px]|[em]|\%$/', '', $this->_css->Get($cssElement, 'border')
            );
            if ($borderSize == 0) {
                $params['border'] = 'none';
            } else {
                $propertiesBorder = explode(
                        ' ', $this->_css->Get($cssElement, 'border')
                );
                $params['border'] = 'single';
                $params['border_color'] = $propertiesBorder[2];
                $params['border_sz'] = $borderSize;
            }
        }
        if ($this->_css->Get($cssElement, 'color')) {
            $params['color'] = $this->_css->Get($cssElement, 'color');
        }
        if ($this->_css->Get($cssElement, 'font-size')) {
            $params['sz'] = $this->_css->Get($cssElement, 'font-size');
            if (
                    preg_match(
                            '/^\d+\%$/', $this->_css->Get($cssElement, 'font-size')
                    )
            ) {
                $params['sz'] = (float) preg_replace(
                                '/\%$/', '', $this->_css->Get($cssElement, 'font-size')
                        ) * 0.12;
            }
        }
        if ($this->_css->Get($cssElement, 'font-family')) {
            $params['font'] = $this->_css->Get(
                    $cssElement, 'font-family'
            );
        }
        if ($this->_css->Get($cssElement, 'height')) {
            $params['height'] = $this->_css->Get($cssElement, 'height');
            $params['sizeY'] = $this->_css->Get($cssElement, 'height');
        }
        if ($this->_css->Get($cssElement, 'width')) {
            $params['width'] = $this->_css->Get($cssElement, 'width');
            $params['sizeX'] = $this->_css->Get($cssElement, 'width');
        }
    }

    /**
     * Parse style tags
     *
     * @access private
     * @param string $styleTag
     * @param cssparser $element
     * @param array $params
     */
    private function parserStyleTag($styleTag, &$element, &$params)
    {
        $strFullStyleTag = $element->name() . '{' . $styleTag . '}';
        if ($styleTag) {
            $css = new \cssparser();
            $css->ParseStr($strFullStyleTag);
            foreach ($css->css as $key => $arrCSS) {
                if (count($arrCSS) > 0) {
                    foreach ($arrCSS as $keyStyle => $cssStyle) {
                        if ($keyStyle == 'align') {
                            $params['jc'] = $cssStyle;
                        }
                        if ($keyStyle == 'border') {
                            $borderSize = preg_replace(
                                    '/[px]|[em]|\%$/', '', $cssStyle
                            );
                            if ($borderSize == 0) {
                                $params['border'] = 'none';
                            } else {
                                $propertiesBorder = explode(' ', $cssStyle);
                                $params['border'] = 'single';
                                $params['border_color'] = $propertiesBorder[2];
                                $params['border_sz'] = $borderSize;
                            }
                        }
                        if ($keyStyle == 'color') {
                            $params['color'] = $cssStyle;
                        }
                        if ($keyStyle == 'font-size') {
                            $params['sz'] = $cssStyle;
                            if (preg_match('/^\d+\%$/', $cssStyle)) {
                                $params['sz'] = (float) preg_replace(
                                                '/\%$/', '', $cssStyle
                                        ) * 0.12;
                            }
                        }
                        if ($keyStyle == 'font-family') {
                            $params['font'] = $cssStyle;
                        }
                        if ($keyStyle == 'height') {
                            $params['height'] = $cssStyle;
                            $params['sizeY'] = $cssStyle;
                        }
                        if ($keyStyle == 'padding-left') {
                            $size = preg_replace(
                                    '/[px]|[em]|\%$/', '', $cssStyle
                            );
                            if ($size) {
                                $params[''] = $size;
                            }
                        }
                        if ($keyStyle == 'text-align') {
                            if ($cssStyle == 'justify') {
                                $cssStyle = 'both';
                            }
                            $params['jc'] = $cssStyle;
                        }
                        if ($keyStyle == 'text-decoration') {
                            if ($cssStyle == 'underline') {
                                $params['u'] = 'single';
                            }
                        }
                        if ($keyStyle == 'width') {
                            $params['width'] = $cssStyle;
                            $params['sizeX'] = $cssStyle;
                        }
                    }
                }
            }
        }
    }

    /**
     * Parse style tags
     *
     * @access private
     * @param VFXP_Document $element
     * @param int $level
     * @param string $preOption
     * @param array $params
     */
    private function recursiveElements(&$element, $level = 0, $preOption = null, $params = array())
    {
        if (in_array($element->name(), $this->_acceptedTags)) {
            switch ($element->name()) {
                case 'a':
                    if ($preOption == 'li') {
                        if ($element->attributeValue('title') != '') {
                            $params['title'] = $element->attributeValue('title');
                        } else {
                            $params['title'] = $element->value();
                        }
                        $params['link'] = $element->attributeValue('href');
                        $objLink = $this->_docx->addElement('addLink', $params);
                        array_push($this->arrDatsList, $objLink);
                    }
                    if ($preOption == 'td') {
                        if ($element->attributeValue('title') != '') {
                            $params['title'] = $element->attributeValue('title');
                        } else {
                            $params['title'] = $element->value();
                        }
                        $params['link'] = $element->attributeValue('href');
                        $objLink = $this->_docx->addElement('addLink', $params);
                        array_push($this->arrDatsTable[$this->_ind], $objLink);
                    }
                    if (
                            empty($preOption) ||
                            in_array($preOption, $this->_preOptions)
                    ) {
                        $this->_docx->addLink(
                                $element->value(), $element->attributeValue('href')
                        );
                    }
                    break;
                case 'b':
                case 'strong':
                    $finalTextTag = array();
                    $params['b'] = 'single';
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push(
                                    $this->datsTextInline, $arrParamsText
                            );
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace('/<.*>/', '', $textTag[$i]);
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'br':
                    $this->_docx->addBreak('line');
                    break;
                case 'dd':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    array_push($this->arrDatsList, $element->value());
                    break;
                case 'div':
                case 'p':
                    $this->datsText = array();
                    $finalTextTag = array();

                    if ($element->attributeValue('align')) {
                        $params['jc'] = $element->attributeValue('align');
                    }
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($element->value()) {
                        $params['text'] = $element->value();
                        array_push($this->datsText, $params);
                    }
                    if ($element->hasChildren()) {
                        foreach ($element->children() as $child) {
                            $this->recursiveElements($child, $level + 1, 'p');
                        }
                    }
                    if (!strstr($this->datsText[0]['text'], '__TAG__')) {
                        $this->_docx->addText($this->datsText);
                    } else {
                        $textTag = explode(
                                '__TAG__', $this->datsText[0]['text']
                        );
                        $i = 1;
                        if ($textTag[0]) {
                            $finalTextTag[]['text'] = $textTag[0];
                        }
                        while (
                        strstr(
                                $this->datsText[0]['text'], '__TAG__'
                        )
                        ) {
                            $this->datsText[0]['text'] = preg_replace(
                                    '/__TAG__/', '', $this->datsText[0]['text'], 1
                            );
                            $finalTextTag[] = $this->datsText[$i];
                            $textTag[$i] = preg_replace(
                                    '/<.*>/', '', $textTag[$i]
                            );
                            $finalTextTag[]['text'] = $textTag[$i];
                            $i++;
                        }
                        $this->_docx->addText($finalTextTag);
                    }
                    $this->_docx->addBreak($strParamsBreak);
                    break;
                case 'dl':
                    $this->arrDatsList = array();
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    $params['val'] = '0';
                    if ($element->hasChildren('dt')) {
                        foreach ($element->children('dt') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    $this->_docx->addList($this->arrDatsList, $params);
                    break;
                case 'dt':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    array_push($this->arrDatsList, $element->value());
                    break;
                case 'font':
                    $finalTextTag = array();
                    if ($element->attributeValue('size')) {
                        $params['sz'] = $element->attributeValue('size');
                    }
                    if ($element->attributeValue('face')) {
                        $params['font'] = $element->attributeValue('face');
                    }
                    if ($element->attributeValue('color')) {
                        $params['color'] = $element->attributeValue('color');
                    }
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push(
                                    $this->datsTextInline, $arrParamsText
                            );
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'h1':
                case 'h2':
                case 'h3':
                case 'h4':
                case 'h5':
                case 'h6':
                    $finalTextTag = array();
                    $params['b'] = 'single';
                    if ($element->name() == 'h1') {
                        $params['sz'] = '16';
                    } elseif ($element->name() == 'h2') {
                        $params['sz'] = '15';
                    } elseif ($element->name() == 'h3') {
                        $params['sz'] = '14';
                    } elseif ($element->name() == 'h4') {
                        $params['sz'] = '13';
                    } elseif ($element->name() == 'h5') {
                        $params['sz'] = '12';
                    } elseif ($element->name() == 'h6') {
                        $params['sz'] = '9';
                    }
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push(
                                    $this->datsTextInline, $arrParamsText
                            );
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push(
                                            $this->datsText, $arrPTextTag
                                    );
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'hr':
                    $this->_docx->addShape('line');
                    break;
                case 'address':
                case 'cite':
                case 'dfn':
                case 'em':
                case 'i':
                case 'var':
                    $finalTextTag = array();
                    $params['i'] = 'single';
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push($this->datsTextInline, $arrParamsText);
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr($this->datsTextInline[0]['text'], '__TAG__')
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'img':
                    if ($element->attributeValue('align')) {
                        $params['jc'] = $element->attributeValue('align');
                    }
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    $params['name'] = $element->attributeValue('src');
                    $this->_docx->addImage($params);
                    break;
                case 'li':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        $arrFinalDatsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements($child, $level + 1, 'li');
                        }
                        if (
                                !strstr($this->datsTextInline[0]['text'], '__TAG__')
                        ) {
                            array_push(
                                    $arrFinalDatsTextInline, $this->datsTextInline
                            );
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            foreach ($finalTextTag as $arrPTextTag) {
                                array_push(
                                        $arrFinalDatsTextInline, $arrPTextTag
                                );
                            }
                        }
                        $objText = $this->_docx->addElement(
                                'addText', $arrFinalDatsTextInline
                        );
                        array_push($this->arrDatsList, $objText);
                    } else {
                        array_push($this->arrDatsList, $element->value());
                    }
                    break;
                case 'ol':
                    $this->arrDatsList = array();
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($element->hasChildren('li')) {
                        foreach ($element->children('li') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    $params['val'] = '2';
                    $this->_docx->addList($this->arrDatsList, $params);
                    break;
                case 'span':
                    $finalTextTag = array();
                    if ($element->attributeValue('align')) {
                        $params['jc'] = $element->attributeValue('align');
                    }
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push($this->datsTextInline, $arrParamsText);
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr($this->datsTextInline[0]['text'], '__TAG__')
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'table':
                    $this->_ind = 0;
                    $this->arrDatsTable = array();
                    if ($element->attributeValue('align')) {
                        $params['jc'] = $element->attributeValue('align');
                    }
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    $params['TBLSTYLEval'] = 'Tablanormal';
                    if (
                            $element->hasChildren('tbody') ||
                            $element->hasChildren('tr') ||
                            $element->hasChildren('th')
                    ) {
                        foreach ($element->children('tbody') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                        foreach ($element->children('tr') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                        foreach ($element->children('th') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    $this->_docx->addTable($this->arrDatsTable, $params);
                    break;
                case 'tbody':
                    if ($element->hasChildren('tr')) {
                        foreach ($element->children('tr') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    break;
                case 'td':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($element->hasChildren()) {
                        foreach ($element->children() as $child) {
                            $this->recursiveElements($child, $level + 1, 'td');
                        }
                    } elseif (is_array($this->arrDatsTable[$this->_ind])) {
                        array_push(
                                $this->arrDatsTable[$this->_ind], $element->value()
                        );
                    }
                    break;
                case 'th':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if (is_array($this->arrDatsTable[$this->_ind])) {
                        array_push(
                                $this->arrDatsTable[$this->_ind], $element->value()
                        );
                    }
                    break;
                case 'title':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    $params['val'] = 1;
                    $this->_docx->addTitle($element->value(), $params);
                    break;
                case 'tr':
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    array_push($this->arrDatsTable, array());
                    if ($element->hasChildren('td')) {
                        foreach ($element->children('td') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    $this->_ind++;
                    break;
                case 'u':
                    $finalTextTag = array();
                    $params['u'] = 'single';
                    $this->parserStylesCSS($element, $params);
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($preOption == 'p') {
                        if ($element->hasChildren()) {
                            $this->datsTextInline = array();
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                        }
                    } elseif ($preOption == 'li') {
                        $params['text'] = $element->value();
                        if ($element->hasChildren()) {
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                        } else {
                            $arrParamsText = $params;
                            array_push($this->datsTextInline, $arrParamsText);
                        }
                    } elseif ($preOption == 'textInline') {
                        if ($element->hasChildren()) {
                            if ($element->value()) {
                                $params['text'] = $element->value();
                                array_push($this->datsTextInline, $params);
                            }
                            foreach ($element->children() as $child) {
                                $this->recursiveElements(
                                        $child, $level + 1, 'textInline', $params
                                );
                            }
                            if (
                                    !strstr(
                                            $this->datsTextInline[0]['text'], '__TAG__'
                                    )
                            ) {
                                array_push($this->datsText, $params);
                            } else {
                                $textTag = explode(
                                        '__TAG__', $this->datsTextInline[0]['text']
                                );
                                $i = 1;
                                if ($textTag[0]) {
                                    $finalTextTag[]['text'] = $textTag[0];
                                }
                                while (
                                strstr(
                                        $this->datsTextInline[0]['text'], '__TAG__'
                                )
                                ) {
                                    $this->datsTextInline[0]['text'] = preg_replace(
                                            '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                    );
                                    $finalTextTag[] = $this->datsTextInline[$i];
                                    $textTag[$i] = preg_replace(
                                            '/<.*>/', '', $textTag[$i]
                                    );
                                    $finalTextTag[]['text'] = $textTag[$i];
                                    $i++;
                                }
                                foreach ($finalTextTag as $arrPTextTag) {
                                    array_push($this->datsText, $arrPTextTag);
                                    array_push(
                                            $this->datsTextInline, $arrPTextTag
                                    );
                                }
                            }
                        } else {
                            $params['text'] = $element->value();
                            array_push($this->datsText, $params);
                            array_push($this->datsTextInline, $params);
                        }
                    } elseif ($element->hasChildren()) {
                        $this->datsTextInline = array();
                        if ($element->value()) {
                            $params['text'] = $element->value();
                            array_push($this->datsTextInline, $params);
                        }
                        foreach ($element->children() as $child) {
                            $this->recursiveElements(
                                    $child, $level + 1, 'textInline', $params
                            );
                        }
                        if (
                                !strstr($this->datsTextInline[0]['text'], '__TAG__')
                        ) {
                            $this->_docx->addText($this->datsTextInline);
                        } else {
                            $textTag = explode(
                                    '__TAG__', $this->datsTextInline[0]['text']
                            );
                            $i = 1;
                            if ($textTag[0]) {
                                $finalTextTag[]['text'] = $textTag[0];
                            }
                            while (
                            strstr(
                                    $this->datsTextInline[0]['text'], '__TAG__'
                            )
                            ) {
                                $this->datsTextInline[0]['text'] = preg_replace(
                                        '/__TAG__/', '', $this->datsTextInline[0]['text'], 1
                                );
                                $finalTextTag[] = $this->datsTextInline[$i];
                                $textTag[$i] = preg_replace(
                                        '/<.*>/', '', $textTag[$i]
                                );
                                $finalTextTag[]['text'] = $textTag[$i];
                                $i++;
                            }
                            $this->_docx->addText($finalTextTag);
                        }
                    } else {
                        $this->_docx->addText($element->value(), $params);
                    }
                    break;
                case 'ul':
                    $this->arrDatsList = array();
                    if ($element->attributeValue('style')) {
                        $this->parserStyleTag(
                                $element->attributeValue('style'), $element, $params
                        );
                    }
                    if ($element->hasChildren('li')) {
                        foreach ($element->children('li') as $child) {
                            $this->recursiveElements($child, $level + 1);
                        }
                    }
                    $params['val'] = '1';
                    $this->_docx->addList($this->arrDatsList, $params);
                    break;
                default:
                    break;
            }
        }
        if ($level == 0) {
            foreach ($element->children() as $child) {
                $this->recursiveElements($child, $level + 1);
            }
        }
    }

    /**
     * Generate XML
     *
     * @access public
     */
    public function generateXML()
    {
        $this->_xml = new \VFXP_Document();
        $this->_xml->parseFromString(
                '<content_xml_phpdocx>' . $this->_strHTML . '</content_xml_phpdocx>'
        );
        $this->_rootXML = $this->_xml->rootElement();
        $this->_css = new \cssparser();
        if ($this->_strCSS) {
            $this->_css->ParseStr($this->_strCSS);
        }
        $this->_docx = new CreateDocx();
        $this->recursiveElements($this->_rootXML);
    }

    /**
     * Generate and return XML
     *
     * @access public
     * @return string
     */
    public function returnXML()
    {
        $this->generateXML();
        return $this->_docx->getXmlWordDocumentContent();
    }

    /**
     * Create DOCX
     *
     * @access public
     */
    public function generateDOCX()
    {
        $this->generateXML();
        $this->_docx->createDocx($this->_filename);
    }

}
