<?php
namespace Phpdocx\Elements;
/**
 * Create form element
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateFormElement
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
     * @var string
     */
    private $_xml;

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
            self::$_instance = new CreateFormElement();
        }
        return self::$_instance;
    }

    /**
     * Create form element
     *
     * @access public
     * @param mixed $args[0]
     */
    public function createFormElement()
    {
        $args = func_get_args();
        $this->_xml = $args[2];
        $DOM = new \DOMDocument();
        $xmlBase = '<root xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">' . $this->_xml . '</root>';
        $DOM->loadXML($xmlBase);
        $rPrNodes = $DOM->getElementsByTagName('rPr');
        if ($rPrNodes->length > 0) {
            $count = $rPrNodes->length - 1;
            $node = $rPrNodes->item($count); //the last one is the one we should remove for substitution
            $rPr = $DOM->saveXML($node);
            $node->parentNode->removeChild($node);
            $this->_xml = $DOM->saveXML($DOM->documentElement->firstChild);
        } else {
            $rPr = '';
        }

        $bookmarkId = rand(99999, 9999999);
        $uniqueName = uniqid(mt_rand(999, 9999));

        if ($args[0] == 'textfield') {
            $inputValue = '<w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="begin">
                                <w:ffData>
                                <w:name w:val="Texto' . $uniqueName . '"/>
                                <w:enabled/>
                                <w:calcOnExit w:val="0"/>
                                <w:textInput/>
                                </w:ffData>
                             </w:fldChar>
                        </w:r>
                        <w:bookmarkStart w:id="' . $bookmarkId . '" w:name="Textfield_' . $uniqueName . '"/>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:instrText xml:space="preserve"> FORMTEXT </w:instrText>
                        </w:r>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="separate"/>
                        </w:r>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:t xml:space="preserve"> </w:t>
                        </w:r>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:t xml:space="preserve">';
            if (isset($args[1]['defaultValue']) && $args[1]['defaultValue'] != '') {
                $inputValue .= $args[1]['defaultValue'];
            } else {
                if (isset($args[1]['size']) && $args[1]['size'] > 0) {
                    $size = $args[1]['size'];
                } else {
                    $size = 18;
                }
                for ($k = 0; $k <= $size; $k++) {
                    $inputValue .=' '; //blank characters for Word
                }
            }
            $inputValue .='</w:t></w:r><w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:t xml:space="preserve"> </w:t></w:r><w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:t xml:space="preserve"> </w:t></w:r>
                        <w:r>
                            <w:fldChar w:fldCharType="end"/>
                        </w:r>
                        <w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
        } else if ($args[0] == 'checkbox') {
            if (isset($args[1]['defaultValue']) && $args[1]['defaultValue']) {
                $selected = 1;
            } else {
                $selected = 0;
            }

            $inputValue = '<w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="begin">
                                <w:ffData>
                                    <w:name w:val="cbox' . $uniqueName . '"/>
                                    <w:enabled/>
                                    <w:calcOnExit w:val="0"/>
                                    <w:checkBox>
                                        <w:sizeAuto/>
                                        <w:default w:val="' . $selected . '"/>
                                    </w:checkBox>
                                </w:ffData>
                            </w:fldChar>
                        </w:r>
                        <w:bookmarkStart w:id="' . $bookmarkId . '" w:name="cbox' . $uniqueName . '"/>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:instrText xml:space="preserve"> FORMCHECKBOX </w:instrText>
                        </w:r>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="separate"/>
                        </w:r>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="end"/>
                        </w:r>
                        <w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
        } else if ($args[0] == 'select') {
            if (isset($args[1]['defaultValue']) &&
                    is_int($args[1]['defaultValue']) &&
                    isset($args[1]['selectOptions']) &&
                    is_array($args[1]['selectOptions'])) {
                $numEntries = count($args[1]['selectOptions']);
                if ($args[1]['defaultValue'] < $numEntries) {
                    //Reorder the select options array
                    $selected = $args[1]['selectOptions'][$args[1]['defaultValue']];
                    unset($args[1]['selectOptions'][$args[1]['defaultValue']]);
                    array_unshift($args[1]['selectOptions'], $selected);
                }
            }
            $inputValue = '<w:bookmarkStart w:id="' . $bookmarkId . '" w:name="dropdown_' . $uniqueName . '"/>
                        <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="begin">
                                <w:ffData>
                                    <w:name w:val="dropdown_' . $uniqueName . '"/>
                                    <w:enabled/>
                                    <w:calcOnExit w:val="0"/>
                                    <w:ddList>';
            if (isset($args[1]['selectOptions']) && is_array($args[1]['selectOptions']) && count($args[1]['selectOptions']) > 0) {
                foreach ($args[1]['selectOptions'] as $key => $value) {
                    $inputValue .= '<w:listEntry w:val="' . $value . '"/>';
                }
            }
            $inputValue .= '</w:ddList>
                    </w:ffData>
                </w:fldChar>
            </w:r>
            <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:instrText xml:space="preserve"> FORMDROPDOWN </w:instrText>
            </w:r>
            <w:r>';
            $inputValue .= $rPr;
            $inputValue .= '<w:fldChar w:fldCharType="end"/>
            </w:r>
            <w:bookmarkEnd w:id="' . $bookmarkId . '"/>';
        }

        $this->_xml = str_replace('<w:r><w:t xml:space="preserve">__formElement__</w:t></w:r>', $inputValue, $this->_xml);
    }

}
