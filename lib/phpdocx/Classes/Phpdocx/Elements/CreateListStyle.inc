<?php
namespace Phpdocx\Elements;
/**
 * Create list styles
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateListStyle
{

    /**
     * @access protected
     * @var string
     */
    protected $_xml;

    /**
     * @access private
     * @var CreateStyle
     * @static
     */
    private static $_instance = NULL;

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
     * @access public
     * @param string $name
     * @param array $styleOptions
     * @return string
     */
    public function addListStyle($name, $styleOptions)
    {
        $defaultBullets = array('', 'o', '', '', 'o', '', '', 'o', '');
        $defaultFont = array('Symbol', 'Courier New', 'Wingdings', 'Symbol', 'Courier New', 'Wingdings', 'Symbol', 'Courier New', 'Wingdings');
        //Set default
        foreach ($styleOptions as $index => $value) {
            if (empty($value['type'])) {
                $styleOptions[$index]['type'] = 'decimal';
            }
            if (empty($value['format']) && $styleOptions[$index]['type'] != 'bullet') {
                $styleOptions[$index]['format'] = '%' . ($index + 1) . '.';
            } else if (empty($value['format']) && $styleOptions[$index]['type'] == 'bullet') {
                $styleOptions[$index]['format'] = $defaultBullets[$index];
                $styleOptions[$index]['font'] = $defaultFont[$index];
            }
            if (empty($value['hanging'])) {
                $styleOptions[$index]['hanging'] = 360;
            }
            if (empty($value['left'])) {
                $styleOptions[$index]['left'] = 720 * ($index + 1);
            }
        }


        //Repeat ciclically if not defined up to level 9
        $entries = count($styleOptions);
        if ($entries < 9) {
            for ($k = $entries; $k < 9; $k++) {
                $styleOptions[$k]['type'] = $styleOptions[$k % $entries]['type'];
                if ($styleOptions[$k]['type'] == 'bullet') {
                    $styleOptions[$k]['format'] = $defaultBullets[$k];
                    $styleOptions[$k]['font'] = $defaultFont[$k];
                } else {
                    $styleOptions[$k]['format'] = '%' . ($k + 1) . '.';
                }
                $styleOptions[$k]['hanging'] = 360;
                $styleOptions[$k]['left'] = 720 * ($k + 1);
            }
        }
        $baseList = '<w:abstractNum w:abstractNumId="" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" >
                        <w:multiLevelType w:val="hybridMultilevel"/>';

        for ($k = 0; $k < 9; $k++) {
            $baseList .= '<w:lvl w:ilvl="' . $k . '">';
            $baseList .= '<w:start w:val="1"/>';
            $baseList .= '<w:numFmt w:val="' . $styleOptions[$k]['type'] . '"/>';
            $baseList .= '<w:lvlText w:val="' . $styleOptions[$k]['format'] . '"/>';
            $baseList .= '<w:lvlJc w:val="left"/>';
            $baseList .= '<w:pPr><w:ind w:left="' . $styleOptions[$k]['left'] . '" w:hanging="' . $styleOptions[$k]['hanging'] . '"/></w:pPr>';
            $baseList .= '<w:rPr>';
            if (isset($styleOptions[$k]['font'])) {
                $baseList .= '<w:rFonts w:ascii="' . $styleOptions[$k]['font'] . '" w:hAnsi="' . $styleOptions[$k]['font'] . '" w:cs="' . $styleOptions[$k]['font'] . '" w:hint="default"/>';
            }
            if (isset($styleOptions[$k]['fontSize'])) {
                $baseList .= '<w:sz w:val="' . ($styleOptions[$k]['fontSize'] * 2) . '" />';
                $baseList .= '<w:szCs w:val="' . ($styleOptions[$k]['fontSize'] * 2) . '" />';
            }
            $baseList .= '</w:rPr>';
            $baseList .= '</w:lvl>';
        }

        $baseList .= '</w:abstractNum>';

        return $baseList;
    }

}
