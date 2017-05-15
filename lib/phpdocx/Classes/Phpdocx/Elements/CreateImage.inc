<?php
namespace Phpdocx\Elements;
/**
 * Create images
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateImage extends CreateElement
{

    const NAMESPACEWORD = 'wp';
    const NAMESPACEWORD1 = 'a';
    const NAMESPACEWORD2 = 'pic';
    const CONSTWORD = 360000;
    const TAMBORDER = 12700;
    const PNG_SCALE_FACTOR = 29.5;

    /**
     * @access private
     * @var CreateImage
     * @static
     */
    private static $_instance = NULL;

    /**
     *
     * @access private
     * @var string
     */
    private $_name;

    /**
     *
     * @access private
     * @var int
     */
    private $_rId;

    /**
     *
     * @access private
     * @var string
     */
    private $_ajusteTexto;

    /**
     *
     * @access private
     * @var int
     */
    private $_sizeX;

    /**
     *
     * @access private
     * @var int
     */
    private $_sizeY;

    /**
     *
     * @access private
     * @var int
     */
    private $_dpi;

    /**
     *
     * @access private
     * @var int
     */
    private $_dpiCustom;

    /**
     *
     * @access private
     * @var int
     */
    private $_spacingTop;

    /**
     *
     * @access private
     * @var int
     */
    private $_spacingBottom;

    /**
     *
     * @access private
     * @var int
     */
    private $_spacingLeft;

    /**
     *
     * @access private
     * @var int
     */
    private $_spacingRight;

    /**
     *
     * @access private
     * @var int
     */
    private $_jc;

    /**
     *
     * @access private
     * @var string
     */
    private $_border;

    /**
     *
     * @access private
     * @var string
     */
    private $_borderDiscontinuo;

    /**
     *
     * @access private
     * @var int
     */
    private $_scaling;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        $this->_name = '';
        $this->_rId = '';
        $this->_ajusteTexto = '';
        $this->_sizeX = '';
        $this->_sizeY = '';
        $this->_spacingTop = '';
        $this->_spacingBottom = '';
        $this->_spacingLeft = '';
        $this->_spacingRight = '';
        $this->_jc = '';
        $this->_border = '';
        $this->_borderDiscontinuo = '';
        $this->_scaling = '';
        $this->_dpiCustom = 0;
        $this->_dpi = 96;
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
     * @return string
     * @access public
     */
    public function __toString()
    {
        return $this->_xml;
    }

    /**
     *
     * @return CreateImage
     * @access public
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateImage();
        }
        return self::$_instance;
    }

    /**
     * Setter. Name
     *
     * @access public
     * @param string $name
     */
    public function setName($name)
    {
        $this->_name = $name;
    }

    /**
     * Getter. Name
     *
     * @access public
     * @return <type>
     */
    public function getName()
    {
        return $this->_name;
    }

    /**
     * Setter. Rid
     *
     * @access public
     * @param string $rId
     */
    public function setRId($rId)
    {
        $this->_rId = $rId;
    }

    /**
     * Getter. Rid
     *
     * @access public
     * @return <type>
     */
    public function getRId()
    {
        return $this->_rId;
    }

    /**
     * Create image
     *
     * @access public
     * @param array $args[0]
     */
    public function createImage()
    {
        $this->_xml = '';
        $this->_name = '';
        $this->_rId = '';
        $this->_ajusteTexto = '';
        $this->_sizeX = '';
        $this->_sizeY = '';
        $this->_spacingTop = '';
        $this->_spacingBottom = '';
        $this->_spacingLeft = '';
        $this->_spacingRight = '';
        $this->_jc = '';
        $this->_border = '';
        $this->_borderDiscontinuo = '';
        $this->_scaling = '';
        $this->_dpiCustom = 0;
        $this->_dpi = 96;
        $args = func_get_args();

        if (isset($args[0]['rId']) && (isset($args[0]['src']))) {
            $attributes = getimagesize($args[0]['src']);

            if (!isset($args[0]['textWrap']) || $args[0]['textWrap'] < 0 ||
                    $args[0]['textWrap'] > 5
            ) {
                $ajusteTexto = 0;
            } else {
                $ajusteTexto = $args[0]['textWrap'];
            }

            if (isset($args[0]['sizeX'])) {
                $tamPxX = $args[0]['sizeX'];
            } elseif (isset($args[0]['scaling'])) {
                $tamPxX = $attributes[0] * $args[0]['scaling'] / 100;
            } else {
                $tamPxX = $attributes[0];
            }

            if (isset($args[0]['scaling'])) {
                $tamPxY = $attributes[1] * $args[0]['scaling'] / 100;
            } elseif (isset($args[0]['sizeY'])) {
                $tamPxY = $args[0]['sizeY'];
            } else {
                $tamPxY = $attributes[1];
            }
            if (isset($args[0]['dpi'])) {
                $this->_dpiCustom = $args[0]['dpi'];
            }
            $this->setName($args[0]['src']);
            $this->setRId($args[0]['rId']);
            $top = '0';
            $bottom = '0';
            $left = '0';
            $right = '0';

            switch ($attributes['mime']) {
                case 'image/png':
                    list($dpiX, $dpiY) = $this->getDpiPng($args[0]['src']);
                    $tamWordX = round($tamPxX * 2.54 / $dpiX * CreateImage::CONSTWORD);
                    $tamWordY = round($tamPxY * 2.54 / $dpiY * CreateImage::CONSTWORD);

                    if (isset($args[0]['spacingTop'])) {
                        $top = round(
                                $args[0]['spacingTop'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingBottom'])) {
                        $bottom = round(
                                $args[0]['spacingBottom'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingLeft'])) {
                        $left = round(
                                $args[0]['spacingLeft'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingRight'])) {
                        $right = round(
                                $args[0]['spacingRight'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    break;
                case 'image/jpg':
                case 'image/jpeg':
                    list($dpiX, $dpiY) = $this->getDpiJpg($args[0]['src']);
                    $tamWordX = round(
                            $tamPxX * 2.54 /
                            $dpiX * CreateImage::CONSTWORD
                    );
                    $tamWordY = round(
                            $tamPxY * 2.54 /
                            $dpiY * CreateImage::CONSTWORD
                    );
                    if (isset($args[0]['spacingTop'])) {
                        $top = round(
                                $args[0]['spacingTop'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingBottom'])) {
                        $bottom = round(
                                $args[0]['spacingBottom'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingLeft'])) {
                        $left = round(
                                $args[0]['spacingLeft'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingRight'])) {
                        $right = round(
                                $args[0]['spacingRight'] * 2.54 /
                                $dpiX * CreateImage::CONSTWORD
                        );
                    }
                    break;
                case 'image/gif':
                    if ($this->_dpiCustom > 0) {
                        $this->_dpi = $this->_dpiCustom;
                    }
                    $tamWordX = round(
                            $tamPxX * 2.54 /
                            $this->_dpi * CreateImage::CONSTWORD
                    );
                    $tamWordY = round(
                            $tamPxY * 2.54 /
                            $this->_dpi * CreateImage::CONSTWORD
                    );
                    if (isset($args[0]['spacingTop'])) {
                        $top = round(
                                $args[0]['spacingTop'] * 2.54 /
                                $this->_dpi * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingBottom'])) {
                        $bottom = round(
                                $args[0]['spacingBottom'] * 2.54 /
                                $this->_dpi * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingLeft'])) {
                        $left = round(
                                $args[0]['spacingLeft'] * 2.54 /
                                $this->_dpi * CreateImage::CONSTWORD
                        );
                    }
                    if (isset($args[0]['spacingRight'])) {
                        $right = round(
                                $args[0]['spacingRight'] * 2.54 /
                                $this->_dpi * CreateImage::CONSTWORD
                        );
                    }
                    break;
            }

            $this->generateP();
            if (isset($args[0]['imageAlign'])) {
                $this->generatePPR();
                $this->generateJC($args[0]['imageAlign']);
            }
            $this->generateR();
            $this->generateRPR();
            $this->generateNOPROOF();
            $this->generateDRAWING();
            if ($ajusteTexto == 0) {
                $this->generateINLINE();
            } else {
                if ($ajusteTexto == 3) {
                    $this->generateANCHOR(1);
                } else {
                    $this->generateANCHOR();
                }
                $this->generateSIMPLEPOS();
                $this->generatePOSITIONH();
                if (isset($args[0]['float']) && ($args[0]['float'] == 'left' || $args[0]['float'] == 'right' || $args[0]['float'] == 'center')) {
                    $this->generateALIGN($args[0]['float']);
                }
                if (isset($args[0]['horizontalOffset']) && is_numeric($args[0]['horizontalOffset'])) {
                    $this->generatePOSOFFSET($args[0]['horizontalOffset']);
                } else {
                    $this->generatePOSOFFSET(0);
                }
                $this->generatePOSITIONV();
                if (isset($args[0]['verticalOffset']) && is_numeric($args[0]['verticalOffset'])) {
                    $this->generatePOSOFFSET($args[0]['verticalOffset']);
                } else {
                    $this->generatePOSOFFSET(0);
                }
            }

            $this->generateEXTENT($tamWordX, $tamWordY);
            $this->generateEFFECTEXTENT($left, $top, $right, $bottom);

            switch ($ajusteTexto) {
                case 1:
                    $this->generateWRAPSQUARE();
                    break;
                case 2:
                case 3:
                    $this->generateWRAPNONE();
                    break;
                case 4:
                    $this->generateWRAPTOPANDBOTTOM();
                    break;
                case 5:
                    $this->generateWRAPTHROUGH();
                    $this->generateWRAPPOLYGON();
                    $this->generateSTART();
                    $this->generateLINETO();
                    break;
                default:
                    break;
            }
            $this->generateDOCPR();
            $this->generateCNVGRAPHICFRAMEPR();
            $this->generateGRAPHICPRAMELOCKS(1);
            $this->generateGRAPHIC();
            $this->generateGRAPHICDATA();
            $this->generatePIC();
            $this->generateNVPICPR();
            $this->generateCNVPR();
            $this->generateCNVPICPR();
            $this->generateBLIPFILL();
            $this->generateBLIP();
            $this->generateSTRETCH();
            $this->generateFILLRECT();
            $this->generateSPPR();
            $this->generateXFRM();
            $this->generateOFF();
            $this->generateEXT($tamWordX, $tamWordY);
            $this->generatePRSTGEOM();
            $this->generateAVLST();
            if (isset($args[0]['borderStyle']) ||
                    isset($args[0]['borderWidth']) ||
                    isset($args[0]['borderColor'])) {
                //width
                if (isset($args[0]['borderWidth'])) {
                    $this->generateLN($args[0]['borderWidth'] * CreateImage::TAMBORDER);
                } else {
                    $this->generateLN(CreateImage::TAMBORDER);
                }
                //color
                if (isset($args[0]['borderColor'])) {
                    $this->generateSOLIDFILL($args[0]['borderColor']);
                } else {
                    $this->generateSOLIDFILL('000000');
                }
                //style
                if (isset($args[0]['borderStyle'])) {
                    $this->generatePRSTDASH($args[0]['borderStyle']);
                } else {
                    $this->generatePRSTDASH('solid');
                }
            }

            $this->cleanTemplate();
        } else {
            echo 'There was an error adding the image';
        }
    }

    /**
     * Init image
     *
     * @access public
     * @param array $args[0]
     */
    public function initImage()
    {
        $args = func_get_args();

        if (!isset($args[0]['src'])) {
            $args[0]['src'] = '';
        }
        if (!isset($args[0]['textWrap'])) {
            $args[0]['textWrap'] = '';
        }
        if (!isset($args[0]['sizeX'])) {
            $args[0]['sizeX'] = '';
        }
        if (!isset($args[0]['sizeY'])) {
            $args[0]['sizeY'] = '';
        }
        if (!isset($args[0]['spacingTop'])) {
            $args[0]['spacingTop'] = '';
        }
        if (!isset($args[0]['spacingBottom'])) {
            $args[0]['spacingBottom'] = '';
        }
        if (!isset($args[0]['spacingLeft'])) {
            $args[0]['spacingLeft'] = '';
        }
        if (!isset($args[0]['spacingRight'])) {
            $args[0]['spacingRight'] = '';
        }
        if (!isset($args[0]['imageAlign'])) {
            $args[0]['imageAlign'] = '';
        }
        if (!isset($args[0]['border'])) {
            $args[0]['border'] = '';
        }
        if (!isset($args[0]['borderDiscontinuous'])) {
            $args[0]['borderDiscontinuous'] = '';
        }
        if (!isset($args[0]['scaling'])) {
            $args[0]['scaling'] = '';
        }
        if (!isset($args[0]['dpi'])) {
            $args[0]['dpi'] = '';
        }



        $this->_name = $args[0]['src'];
        $this->_ajusteTexto = $args[0]['textWrap'];
        $this->_sizeX = $args[0]['sizeX'];
        $this->_sizeY = $args[0]['sizeY'];
        $this->_spacingTop = $args[0]['spacingTop'];
        $this->_spacingBottom = $args[0]['spacingBottom'];
        $this->_spacingLeft = $args[0]['spacingLeft'];
        $this->_spacingRight = $args[0]['spacingRight'];
        $this->_jc = $args[0]['imageAlign'];
        $this->_border = $args[0]['border'];
        $this->_borderDiscontinuo = $args[0]['borderDiscontinuous'];
        $this->_scaling = $args[0]['scaling'];
        $this->_dpiCustom = $args[0]['dpi'];
    }

    /**
     * Get image jpg dpi
     *
     * @access private
     * @param string $filename
     * @return array
     */
    private function getDpiJpg($filename)
    {
        if ($this->_dpiCustom > 0) {
            return array($this->_dpiCustom, $this->_dpiCustom);
        }
        $a = fopen($filename, 'r');
        $string = fread($a, 20);
        fclose($a);
        $type = hexdec(bin2hex(substr($string, 13, 1)));
        $data = bin2hex(substr($string, 14, 4));
        if ($type == 1) {
            $x = substr($data, 0, 4);
            $y = substr($data, 4, 4);
            return array(hexdec($x), hexdec($y));
        } else if ($type == 2) {
            $x = floor(hexdec(substr($data, 0, 4)) / 2.54);
            $y = floor(hexdec(substr($data, 4, 4)) / 2.54);
            return array($x, $y);
        } else {
            return array($this->_dpi, $this->_dpi);
        }
    }

    /**
     * Get image png dpi
     *
     * @access private
     * @param string $filename
     * @return array
     */
    private function getDpiPng($filename)
    {
        if ($this->_dpiCustom > 0) {
            return array($this->_dpiCustom, $this->_dpiCustom);
        }
        $a = fopen($filename, 'r');
        $string = fread($a, 1000);
        $aux = strpos($string, 'pHYs');
        if ($aux > 0) {
            $type = hexdec(bin2hex(substr($string, $aux + strlen('pHYs') + 16, 1)));
        }
        if ($aux > 0 && $type = 1) {
            $data = bin2hex(substr($string, $aux + strlen('pHYs'), 16));
            fclose($a);
            $x = substr($data, 0, 8);
            $y = substr($data, 8, 8);
            return array(round(hexdec($x) / CreateImage::PNG_SCALE_FACTOR), round(hexdec($y) / CreateImage::PNG_SCALE_FACTOR));
        } else {
            return array($this->_dpi, $this->_dpi);
        }
    }

}
