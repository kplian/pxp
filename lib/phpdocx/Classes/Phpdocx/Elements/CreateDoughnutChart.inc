<?php
namespace Phpdocx\Elements;
/**
 * Create Doughnuts Chart
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateDoughnutChart extends CreateGraphic implements InterfaceGraphic
{

    /**
     * Create embedded xml chart
     *
     * @access public
     */
    public function createEmbeddedXmlChart()
    {
        $this->_xmlChart = '';
        $this->generateCHARTSPACE();
        $this->generateDATE1904(1);
        $this->generateLANG();
        $this->generateROUNDEDCORNERS($this->_roundedCorners);
        $color = 2;
        if ($this->_color) {
            $color = $this->_color;
        }
        $this->generateSTYLE($color);
        $this->generateCHART();
        if ($this->_title != '') {
            $this->generateTITLE();
            $this->generateTITLETX();
            $this->generateRICH();
            $this->generateBODYPR();
            $this->generateLSTSTYLE();
            $this->generateTITLEP();
            $this->generateTITLEPPR();
            $this->generateDEFRPR();

            $this->generateTITLER();
            $this->generateTITLERPR();

            $this->generateTITLET($this->_title);
            $this->cleanTemplateFonts();
        } else {
            $this->generateAUTOTITLEDELETED();
            $title = '';
        }
        if (strpos($this->_type, '3D') !== false) {
            $this->generateVIEW3D();
            $rotX = 30;
            $rotY = 30;
            $perspective = 30;
            if ($this->_rotX != '') {
                $rotX = $this->_rotX;
            }
            if ($this->_rotY != '') {
                $rotY = $this->_rotY;
            }
            if ($this->_perspective != '') {
                $perspective = $this->_perspective;
            }
            $this->generateROTX($rotX);
            $this->generateROTY($rotY);
            $this->generateRANGAX($this->_rAngAx);
            $this->generatePERSPECTIVE($perspective);
        }
        if ($this->values == '') {
            exit('You haven`t added data');
        }
        $this->generatePLOTAREA();
        $this->generateLAYOUT();

        $this->generateDOUGHNUTCHART();
        $this->generateVARYCOLORS();
        if (isset($this->values['legend'])) {
            $legends = array($this->_title);
            $numValues = count($this->values) - 1;
        } else {
            $legends = array($this->_title);
            $numValues = count($this->values);
        }
        $letter = 'A';
        for ($i = 0; $i < count($legends); $i++) {
            $this->generateSER();
            $this->generateIDX($i);
            $this->generateORDER($i);
            $letter++;

            $this->generateTX();
            $this->generateSTRREF();
            $this->generateF('Sheet1!$' . $letter . '$1');
            $this->generateSTRCACHE();
            $this->generatePTCOUNT();
            $this->generatePT();
            $this->generateV($legends[$i]);

            if (!empty($this->_explosion) && is_numeric($this->_explosion)) {
                $this->generateEXPLOSION($this->_explosion);
            }
            $this->cleanTemplate2();

            $this->generateCAT();
            $this->generateSTRREF();
            $this->generateF('Sheet1!$A$2:$A$' . ($numValues + 1));
            $this->generateSTRCACHE();
            $this->generatePTCOUNT($numValues);

            $num = 0;
            foreach ($this->values as $legend => $value) {
                if ($legend == 'legend') {
                    continue;
                }
                $this->generatePT($num);
                $this->generateV($legend);
                $num++;
            }
            $this->cleanTemplate2();
            if ($this->_type == 'radar' && $style == 'marker' && $marker == false) {
                $this->generateMARKER();
            }
            $this->generateVAL();
            $this->generateNUMREF();
            $this->generateF('Sheet1!$' . $letter . '$2:$' . $letter . '$' . ($numValues + 1));
            $this->generateNUMCACHE();
            $this->generateFORMATCODE();
            $this->generatePTCOUNT($numValues);
            $num = 0;
            foreach ($this->values as $legend => $value) {
                if ($legend == 'legend') {
                    continue;
                }
                $this->generatePT($num);
                $this->generateV($value[$i]);
                $num++;
            }
            $this->cleanTemplate3();
        }

        //Generate labels
        $this->generateSERDLBLS();
        $this->generateSHOWLEGENDKEY($this->_showLegendKey);
        $this->generateSHOWVAL($this->_showValue);
        $this->generateSHOWCATNAME($this->_showCategory);
        $this->generateSHOWSERNAME($this->_showSeries);
        $this->generateSHOWPERCENT($this->_showPercent);
        $this->generateSHOWBUBBLESIZE($this->_showBubbleSize);
        $this->generateFIRSTSLICEANG();
        if (!empty($this->_holeSize) && is_numeric($this->_holeSize)) {
            $this->generateHOLESIZE($this->_holeSize);
        } else {
            $this->generateHOLESIZE();
        }

        $this->generateLEGEND();
        $this->generateLEGENDPOS($this->_legendPos);
        $this->generateLEGENDOVERLAY($this->_legendOverlay);
        $this->generatePLOTVISONLY();

        if ((!isset($this->_border) || $this->_border == 0 || !is_numeric($this->_border))
        ) {
            $this->generateSPPR();
            $this->generateLN();
            $this->generateNOFILL();
        } else {
            $this->generateSPPR();
            $this->generateLN($this->_border);
        }

        if ($this->_font != '') {
            $this->generateTXPR();
            $this->generateLEGENDBODYPR();
            $this->generateLSTSTYLE();
            $this->generateAP();
            $this->generateAPPR();
            $this->generateDEFRPR();
            $this->generateRFONTS($this->_font);
            $this->generateENDPARARPR();
        }

        $this->generateEXTERNALDATA();
        $this->cleanTemplateDocument();
        return $this->_xmlChart;
    }

    /**
     * Return the tag
     *
     * @access public
     * @return array
     */
    public function dataTag()
    {
        return array('val');
    }

    /**
     * Return the type of the xlsx object
     *
     * @access public
     */
    public function getXlsxType()
    {
        return CreateCompletedXlsx::getInstance();
    }

}
