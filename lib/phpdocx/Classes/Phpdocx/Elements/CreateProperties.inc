<?php
namespace Phpdocx\Elements;
/**
 * Create properties
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateProperties extends CreateElement
{

    /**
     *
     * @access private
     * @var string
     */
    private static $_instance = NULL;

    /**
     * Destruct
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
            self::$_instance = new CreateProperties();
        }
        return self::$_instance;
    }

    /**
     * Create properties
     *
     * @access public
     * @param mixed $args[0], $args[1]
     */
    public function CreateProperties()
    {
        $generalProperties = array('title', 'subject', 'creator', 'keywords', 'description', 'category', 'contentStatus');
        $nameSpaces = array('title' => 'dc', 'subject' => 'dc', 'creator' => 'dc', 'keywords' => 'cp', 'description' => 'dc', 'category' => 'cp', 'contentStatus' => 'cp');
        $nameSpacesURI = array(
            'dc' => 'http://purl.org/dc/elements/1.1/',
            'cp' => 'http://schemas.openxmlformats.org/package/2006/metadata/core-properties',
            'dcterms' => 'http://purl.org/dc/terms/'
        );
        $args = func_get_args();

        //Let us load the contents of the file in a DOMDocument
        $coreDocument = $args[1];

        foreach ($args[0] as $key => $value) {
            if (in_array($key, $generalProperties)) {
                $coreNodes = $coreDocument->getElementsByTagName($key);
                if ($coreNodes->length > 0) {
                    $coreNodes->item(0)->nodeValue = $value;
                } else {
                    $strNode = '<' . $nameSpaces[$key] . ':' . $key . ' xmlns:' . $nameSpaces[$key] . '="' . $nameSpacesURI[$nameSpaces[$key]] . '">' . $value . '</' . $nameSpaces[$key] . ':' . $key . '>';
                    $tempNode = $coreDocument->createDocumentFragment();
                    $tempNode->appendXML($strNode);
                    $coreDocument->documentElement->appendChild($tempNode);
                }
            }
        }
        return $coreDocument;
    }

    /**
     * Create properties
     *
     * @access public
     * @param mixed $args[0], $args[1]
     */
    public function createPropertiesApp()
    {
        $appProperties = array('Manager', 'Company');

        $args = func_get_args();

        //Let us load the contents of the file in a DOMDocument    
        $appDocument = $args[1];

        foreach ($args[0] as $key => $value) {
            if (in_array($key, $appProperties)) {
                $appNodes = $appDocument->getElementsByTagName($key);
                if ($appNodes->length > 0) {
                    $appNodes->item(0)->nodeValue = $value;
                } else {
                    $strNode = '<' . $key . '>' . $value . '</' . $key . '>';
                    $tempNode = $appDocument->createDocumentFragment();
                    $tempNode->appendXML($strNode);
                    $appDocument->documentElement->appendChild($tempNode);
                }
            }
        }
        return $appDocument;
    }

    /**
     * Create custom properties
     *
     * @access public
     * @param mixed $args[0], $args[1]
     */
    public function createPropertiesCustom()
    {
        $tagName = array('text' => 'lpwstr', 'date' => 'filetime', 'number' => 'r8', 'boolean' => 'bool');

        $args = func_get_args();
        $customDocument = $args[1];

        //Now we begin the insertion of the custom properties       
        foreach ($args[0] as $key => $value) {

            $myKey = array_keys($value);
            $myValue = array_values($value);

            if (array_key_exists($myKey[0], $tagName)) {

                $customNodes = $customDocument->getElementsByTagName('property');
                $numberNodes = $customNodes->length;
                if ($myValue[0] === true) {
                    $myValue[0] = 1;
                } else if ($myValue[0] === false) {
                    $myValue[0] = 0;
                }
                if ($numberNodes > 0) {
                    for ($j = 0; $j < $numberNodes; $j++) {
                        if ($customNodes->item($j)->getAttribute('name') == $key) {
                            $customNodes->item($j)->firstChild->nodeValue = $myValue[0];
                        } else {
                            $strNode = '<property fmtid="{D5CDD505-2E9C-101B-9397-08002B2CF9AE}" pid="' . rand(999, 99999999) . '" name="' . $key . '"><vt:' . $tagName[$myKey[0]] . ' xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes" temp="xxx">' . (string) $myValue[0] . '</vt:' . $tagName[$myKey[0]] . '></property>';
                        }
                    }
                } else {
                    $strNode = '<property fmtid="{D5CDD505-2E9C-101B-9397-08002B2CF9AE}" pid="' . rand(999, 99999999) . '" name="' . $key . '"><vt:' . $tagName[$myKey[0]] . ' xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"  temp="xxx">' . (string) $myValue[0] . '</vt:' . $tagName[$myKey[0]] . '></property>';
                }
                if ($strNode != '') {
                    $tempNode = $customDocument->createDocumentFragment();
                    $tempNode->appendXML($strNode);
                    $customDocument->documentElement->appendChild($tempNode);
                }
            }
        }
        $propData = str_replace('xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes" temp="xxx">', '>', $customDocument->saveXML());
        return $propData;
    }

}
