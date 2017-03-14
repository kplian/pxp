<?php
namespace Phpdocx\Elements;
/**
 * Use DOCX as templates
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateXML
{

    /**
     * @access private
     * @var CreateTemplate
     * @static
     */
    private static $_instance = NULL;

    /**
     * @access private
     * @var string
     */
    private $_xml;

    /**
     * Construct
     *
     * @access public
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
     * Magic method, returns current word XML
     *
     * @access public
     * @return string Return current word
     */
    public function __toString()
    {
        return $this->_xml;
    }

    /**
     *
     * @access public
     * @return CreateTemplate
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateXML();
        }
        return self::$_instance;
    }

    /**
     *
     */
    public function getXML()
    {
        return $this->_xml;
    }

    /**
     *
     */
    public function setXML($xml)
    {
        $this->_xml = $xml;
    }

    /**
     * Returns an array with clean exploded variables
     *
     * @param string $delimiter
     * @param string $string
     * @return array
     */
    public function cleanExplode($delimiter, $string)
    {
        $array = explode($delimiter, $string);
        foreach ($array as $key => $part) {
            $array[$key] = trim(strip_tags($part));
        }
        return $array;
    }

    /**
     * Returns CRC (16) of $data
     *
     * @access private
     * @param string $data Data tu calculate CRC16
     * @return string
     */
    private function crc16($data)
    {
        $crc = 0xFFFF;
        for ($i = 0; $i < strlen($data); $i++) {
            $x = (($crc >> 8) ^ ord($data[$i])) & 0xFF;
            $x ^= $x >> 4;
            $crc = (($crc << 8) ^ ($x << 12) ^ ($x << 5) ^ $x) & 0xFFFF;
        }
        return $crc;
    }

    /**
     * Return XML
     *
     * @access public
     * @return array
     */
    public function XML()
    {
        $templateVariables = CreateTemplate::getTemplateVariables();

        if (!empty($templateVariables) && is_array($templateVariables)) {
            $dom = new \DOMDocument('1.0', 'UTF-8');
            $dom->formatOutput = true;
            $forms = $dom->createElement("forms");
            $attr = $forms->setAttribute('id', 'frm' . $this->crc16(serialize($templateVariables))); //form id
            $dom->appendChild($forms);

            //new elements type list or row
            $aTemp = array();
            $aTempElCount = array(); //saves elements list and counts occurrences
            foreach ($templateVariables as $key => $section) {
                if (!empty($templateVariables[$key]) && is_array($templateVariables[$key])) {
                    foreach ($section as $variable) {
                        switch ($variable['TAG']) {
                            case 'LIST': //repeated regions as list
                            case 'ROW': //repeated regions as table
                                if (isset($aTempElCount[$variable['GROUPID']])) { //gets only first occurrence
                                    $aTempElCount[$variable['GROUPID']] ++;
                                    //continue;
                                } else {
                                    $aTempElCount[$variable['GROUPID']] = 1;
                                    $aTemp[$key][] = array('TAG' => $variable['TAG'], 'NAME' => $variable['GROUPID'], 'GROUPID' => $variable['GROUPID']); //repeated region
                                }
                                $variableParts = $this->cleanExplode("_", $variable['NAME']);
                                if (isset($aTempElCount[$variableParts[1]])) { //gets only first occurrence
                                    $aTempElCount[$variableParts[1]] ++;
                                    continue;
                                }
                                $aTempElCount[$variableParts[1]] = 1;
                                $aTemp[$key][] = array('TAG' => $variableParts[0], 'NAME' => $variableParts[1], 'GROUP' => $variable['GROUPID']); //repeated field
                                break;
                            case 'BLOCK':
                            case 'GROUP':
                            case 'TAB':
                                if (isset($aTempElCount[$variable['NAME']])) { //gets only first occurrence
                                    $aTempElCount[$variable['NAME']] ++;
                                    continue;
                                }
                                $aTempElCount[$variable['GROUPID']] = 1;
                                $aTemp[$key][] = $variable;
                                $aTemp[$key][count($aTemp[$key]) - 1]['GROUPID'] = $variable['NAME'];
                                break;
                            default:
                                if (isset($aTempElCount[$variable['NAME']])) { //gets only first occurrence
                                    $aTempElCount[$variable['NAME']] ++;
                                    continue;
                                }
                                $aTempElCount[$variable['NAME']] = 1;
                                $aTemp[$key][] = $variable;
                        }
                    }
                }
            }
            $templateVariables = $aTemp;

            foreach ($templateVariables as $key => $section) {
                if (!empty($templateVariables[$key]) && is_array($templateVariables[$key])) {
                    $aBlockOpen = array(); //lifo stack, control groups like $TYPE_name$[...]$TYPE_name$
                    foreach ($section as $variable) {

                        switch ($variable['TAG']) {

                            case 'IMAGE':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME']);
                                $element = $this->createElement(
                                        $dom, strtolower($variable['TAG']), NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Select (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $element->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($element);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP']) {
                                        array_pop($aBlockOpen);
                                    }
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($element);
                                } else {
                                    $forms->appendChild($element);
                                }
                                break;

                            case 'NUMBERING':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME']);
                                $element = $this->createElement(
                                        $dom, strtolower($variable['TAG']), NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Numbering (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $element->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($element);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP']) {
                                        array_pop($aBlockOpen);
                                    }
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($element);
                                } else {
                                    $forms->appendChild($element);
                                }
                                break;

                            case 'BLOCK':
                            case 'GROUP':
                            case 'TAB':
                                if (count($aBlockOpen) && $aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUPID']) {
                                    array_pop($aBlockOpen);
                                    break;
                                } else {
                                    $aBlockOpen[] = $variable['GROUPID'];
                                }

                                $attr = array('ref' => '',
                                    'id' => $variable['NAME'],
                                    'mode' => strtolower($variable['TAG']));
                                $group[$variable['GROUPID']] = $this->createElement(
                                        $dom, "group", NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Group (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $group[$variable['GROUPID']]->appendChild($label);
                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($group[$variable['GROUPID']]);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP'])
                                        array_pop($aBlockOpen);
                                } elseif (count($aBlockOpen) > 1) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 2]]->appendChild($group[$variable['GROUPID']]);
                                } else {
                                    $forms->appendChild($group[$variable['GROUPID']]);
                                }
                                break;
                            case 'CHECKBOX':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME']);
                                $checkbox = $this->createElement(
                                        $dom, "checkbox", NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Checkbox (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $checkbox->appendChild($label);

                                if (!empty($variable['GROUP']) && isset($group[$variable['GROUP']])) {
                                    $group[$variable['GROUP']]->appendChild($checkbox);
                                    if (isset($aBlockOpen[count($aBlockOpen) - 1]) && $aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP'])
                                        array_pop($aBlockOpen);
                                } elseif (!empty($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($checkbox);
                                } else {
                                    $forms->appendChild($checkbox);
                                }
                                break;
                            case 'COMMENT':
                            case 'HEADING':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME'],
                                    'mode' => strtolower($variable['TAG']),
                                    'length' => 255);
                                if ($attr['mode'] == 'comment') {
                                    $attr['length'] = 65534;
                                }
                                $heading = $this->createElement(
                                        $dom, "heading", NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Heading (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $heading->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($heading);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP'])
                                        array_pop($aBlockOpen);
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($heading);
                                } else {
                                    $forms->appendChild($heading);
                                }
                                break;

                            case 'LIST': //repeated regions as list
                            case 'ROW': //repeated regions as table
                                if (!isset($group[$variable['GROUPID']])) {
                                    $attr = array('ref' => '',
                                        'id' => $variable['GROUPID'],
                                        'mode' => strtolower($variable['TAG']));
                                    $group[$variable['GROUPID']] = $this->createElement($dom, "repeat", NULL, $attr);
                                    $label = $this->createElement($dom, "label");
                                    $cdata = $dom->createCDATASection("Group (" . $variable['GROUPID'] . ')');

                                    $group[$variable['GROUPID']]->appendChild($label);
                                    if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                        $group[$variable['GROUP']]->appendChild($group[$variable['GROUPID']]);
                                        if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP']) {
                                            array_pop($aBlockOpen);
                                        }
                                    } elseif (count($aBlockOpen)) {
                                        $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($group[$variable['GROUPID']]);
                                    } else {
                                        $forms->appendChild($group[$variable['GROUPID']]);
                                    }
                                }
                                break;

                            case 'SELECT':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME']);
                                $element = $this->createElement(
                                        $dom, strtolower($variable['TAG']), NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Select (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $element->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($element);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP']) {
                                        array_pop($aBlockOpen);
                                    }
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($element);
                                } else {
                                    $forms->appendChild($element);
                                }
                                break;

                            case 'DATE':
                            case 'TEXT':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME'],
                                    'length' => 255);
                                if ($variable['TAG'] == 'DATE') {
                                    $attr['validation'] = 'fecha';
                                }
                                $text = $this->createElement(
                                        $dom, "text", NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Text box (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $text->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($text);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP'])
                                        array_pop($aBlockOpen);
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($text);
                                } else {
                                    $forms->appendChild($text);
                                }
                                break;

                            case 'TEXTAREA':
                                $attr = array('ref' => '',
                                    'id' => $variable['NAME'],
                                    'length' => 65534);
                                $textarea = $this->createElement(
                                        $dom, "textarea", NULL, $attr);
                                $label = $this->createElement($dom, "label");
                                $cdata = $dom->createCDATASection("Textarea (" . $variable['NAME'] . ')');

                                $label->appendChild($cdata);
                                $textarea->appendChild($label);

                                if (isset($group[$variable['GROUP']]) && !empty($variable['GROUP'])) {
                                    $group[$variable['GROUP']]->appendChild($textarea);
                                    if ($aBlockOpen[count($aBlockOpen) - 1] == $variable['GROUP']) {
                                        array_pop($aBlockOpen);
                                    }
                                } elseif (count($aBlockOpen)) {
                                    $group[$aBlockOpen[count($aBlockOpen) - 1]]->appendChild($textarea);
                                } else {
                                    $forms->appendChild($textarea);
                                }
                                break;

                            default:
                                //unknown tag, TODO
                                break;
                        }
                    }
                }
            }
            $this->_xml = $dom->saveXML(); //returns false on error
        }
    }

    function createElement($domObj, $tag_name, $value = NULL, $attributes = NULL)
    {
        $element = ($value != NULL ) ? $domObj->createElement($tag_name, $value) : $domObj->createElement($tag_name);

        if ($attributes != NULL) {
            foreach ($attributes as $attr => $val) {
                $element->setAttribute($attr, $val);
            }
        }

        $domObj->appendChild($element);

        return $element;
    }

}
