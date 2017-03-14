<?php
namespace Phpdocx\Elements;
/**
 * Create xlsx for scatter charts
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateScatterXlsx extends CreateXlsx
{

    /**
     * @access private
     * @var CreateFooter
     * @static
     */
    private static $_instance = NULL;

    /**
     *
     * @access public
     * @return CreateXlsx
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateScatterXlsx();
        }
        return self::$_instance;
    }

    /**
     * Create excel sheet
     *
     * @access public
     * @param string $args[0]
     * @param array $args[1]
     */
    public function createExcelSheet($dats)
    {
        $this->_xml = '';
        $sizeDats = count($dats);
        $sizeCols = 2;
        $this->generateWORKSHEET();
        $this->generateDIMENSION($sizeDats + 1, $sizeCols);
        $this->generateSHEETVIEWS();
        $this->generateSHEETVIEW();
        $this->generateSELECTION($sizeDats + $sizeCols - 1);
        $this->generateSHEETFORMATPR();
        $this->generateCOLS();
        $this->generateCOL();
        $this->generateSHEETDATA();
        $row = 1;
        $col = 1;
        $letter = 'A';
        $this->generateROW($row, $sizeCols - 1);
        for ($num = 0; $num < $sizeCols; $num++) {
            $this->generateC($letter . $row, '1', 's');
            $this->generateV($num);
            $letter++;
            $col++;
        }
        $this->cleanTemplateROW();
        $row++;

        foreach ($dats as $ind => $val) {
            $this->generateROW($row, $sizeCols - 1);
            $col = 1;
            $letter = 'A';
            foreach ($val as $values) {
                $this->generateC($letter . $row, '', 'n');
                $this->generateV($values);
                $col++;
                $letter++;
            }
            $row++;
            $this->cleanTemplateROW();
        }
        $this->generateROW($row + 1, $sizeCols);
        $row++;
        $this->generateC('B' . $row, 2, 's');
        $this->generateV($num + 1);
        $this->generatePAGEMARGINS();
        $this->generateTABLEPARTS();
        $this->generateTABLEPART(1);
        $this->cleanTemplate();
        return $this->_xml;
    }

    /**
     * Create excel shared strings
     *
     * @param string $args[0]
     * @param string $args[1]
     * @access public
     */
    public function createExcelSharedStrings($dats)
    {
        $this->_xml = '';
        $szDats = count($dats);
        $szCols = 2;
        $this->generateSST($szCols + 2);
        $legends = array('X Values', 'Y Values');
        for ($i = 0; $i < $szCols; $i++) {
            $this->generateSI();
            $this->generateT($legends[$i]);
        }

        $this->generateSI();
        $this->generateT(' ', 'preserve');

        $msg = 'To change the range size of values,' .
                'drag the bottom right corner';
        $this->generateSI();
        $this->generateT($msg);

        $this->cleanTemplate();
        return $this->_xml;
    }

    /**
     * Create excel table
     *
     * @access public
     * @param string args[0]
     * @param string args[1]
     */
    public function createExcelTable($dats)
    {
        $this->_xml = '';
        $szDats = count($dats);
        $szCols = 2;
        $this->generateTABLE($szDats, $szCols - 1);
        $this->generateTABLECOLUMNS($szCols);
        $legends = array('X Values', 'Y Values');
        for ($i = 0; $i < $szCols; $i++) {
            $this->generateTABLECOLUMN($i + 1, $legends[$i]);
        }
        $this->generateTABLESTYLEINFO();
        $this->cleanTemplate();
        return $this->_xml;
    }

    /**
     * Generate dimension
     *
     * @param int $sizeX
     * @param int $sizeY
     * @access protected
     */
    protected function generateDIMENSION($sizeX, $sizeY)
    {
        $char = 'A';
        for ($i = 0; $i < $sizeY - 1; $i++) {
            $char++;
        }
        $sizeX += $sizeY;
        $xml = '<dimension ref="A1:' . $char . $sizeX .
                '"></dimension>__GENERATEWORKSHEET__';

        $this->_xml = str_replace('__GENERATEWORKSHEET__', $xml, $this->_xml);
    }

}
