<?php
namespace Phpdocx\Elements;
/**
 * Create shape
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateShape extends CreateElement
{

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
     * Create shape
     *
     * @access public
     * @param string 'type'
     * @param array 'options'
     */
    public function createShape($type = 'line', $options = array())
    {
        $VMLdata = '';
        switch ($type) {
            case 'arc':
                $VMLdata .= $this->generateArc($options);
                break;
            case 'curve':
                $VMLdata .= $this->generateCurve($options);
                break;
            case 'line':
                $VMLdata .= $this->generateLine($options);
                break;
            case 'polyline':
                $VMLdata .= $this->generatePolyline($options);
                break;
            case 'rect':
                $VMLdata .= $this->generateRect($options);
                break;
            case 'roundrect':
                $VMLdata .= $this->generateRoundrect($options);
                break;
            case 'shape':
                $VMLdata .= $this->generateShape($options);
                break;
            case 'oval':
                $VMLdata .= $this->generateOval($options);
                break;
        }

        $VMLdata = '<w:pict>' . $VMLdata . '</w:pict>';
        return $VMLdata;
    }

    /**
     * Generates an arc shape
     *
     * @access protected
     * @param string $options
     */
    protected function generateArc($options)
    {
        $VML = '<v:arc style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['startAngle'])) {
            $VML .= 'startangle="' . $options['startAngle'] . '" ';
        }
        if (isset($options['endAngle'])) {
            $VML .= 'endangle="' . $options['endAngle'] . '" ';
        }
        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates a curve with two control points
     *
     * @access protected
     * @param string $options
     */
    protected function generateCurve($options)
    {
        $VML = '<v:curve style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['from'])) {
            $VML .= 'from="' . $options['from'] . '" ';
        }
        if (isset($options['control1'])) {
            $VML .= 'control1="' . $options['control1'] . '" ';
        }
        if (isset($options['control2'])) {
            $VML .= 'control2="' . $options['control2'] . '" ';
        }
        if (isset($options['to'])) {
            $VML .= 'to="' . $options['to'] . '" ';
        }
        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates a line between two points
     *
     * @access protected
     * @param string $options
     */
    protected function generateLine($options)
    {
        $VML = '<v:line style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['from'])) {
            $VML .= 'from="' . $options['from'] . '" ';
        }
        if (isset($options['to'])) {
            $VML .= 'to="' . $options['to'] . '" ';
        }

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates a polyline
     *
     * @access protected
     * @param string $options
     */
    protected function generatePolyline($options)
    {
        $VML = '<v:polyline style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['points'])) {
            $VML .= 'points="' . $options['points'] . '" ';
        }

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates a rectangle
     *
     * @access protected
     * @param string $options
     */
    protected function generateRect($options)
    {
        $VML = '<v:rect style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates a rectangle with rounded corners
     *
     * @access protected
     * @param string $options
     */
    protected function generateRoundrect($options)
    {
        $VML = '<v:roundrect style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['arcsize'])) {
            $VML .= 'arcsize="' . $options['arcsize'] . '" ';
        }

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates an arbitrary shape
     *
     * @access protected
     * @param string $options
     */
    protected function generateShape($options)
    {
        $VML = '<v:shape style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        if (isset($options['path'])) {
            $VML .= 'path="' . $options['path'] . '" ';
        }

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates an oval
     *
     * @access protected
     * @param string $options
     */
    protected function generateOval($options)
    {
        $VML = '<v:oval style="';
        $VML .= $this->generateVMLStyle($options) . '" ';

        $VML .= $this->generateGeneralVMLOptions($options) . ' ';

        $VML .= '/>';

        return $VML;
    }

    /**
     * Generates the VML styles
     *
     * @access private
     * @param string $options
     */
    private function generateVMLStyle($options)
    {
        $VMLstyle = '';

        if (isset($options['position'])) {
            $VMLstyle .= 'position:' . $options['position'] . ';';
        }
        if (isset($options['margin-top'])) {
            $VMLstyle .= 'margin-top:' . $options['margin-top'] . 'pt;';
        }
        /*
          if(isset($options['margin-right'])){
          $VMLstyle .= 'margin-right:' . $options['margin-right'] . 'pt;';
          }
          if(isset($options['margin-bottom'])){
          $VMLstyle .= 'margin-bottom:' . $options['margin-bottom'] . 'pt;';
          }
         */
        if (isset($options['margin-left'])) {
            $VMLstyle .= 'margin-left:' . $options['margin-left'] . 'pt;';
        }
        if (isset($options['width'])) {
            $VMLstyle .= 'width:' . $options['width'] . 'pt;';
        }
        if (isset($options['height'])) {
            $VMLstyle .= 'height:' . $options['height'] . 'pt;';
        }
        if (isset($options['z-index'])) {
            $VMLstyle .= 'z-index:' . $options['z-index'] . ';';
        } else {
            $VMLstyle .= 'z-index:' . rand(999, 99999) . ';';
        }

        return $VMLstyle;
    }

    /**
     * Generates general VML options
     *
     * @access private
     * @param string $options
     */
    private function generateGeneralVMLOptions($options)
    {
        $VML = '';
        if (isset($options['coordsize'])) {
            $VML .= 'coordsize="' . $options['coordsize'] . '" ';
        }
        if (isset($options['fillcolor'])) {
            $VML .= 'fillcolor="' . $options['fillcolor'] . '" ';
        }
        if (isset($options['strokecolor'])) {
            $VML .= 'strokecolor="' . $options['strokecolor'] . '" ';
        }
        if (isset($options['strokeweight'])) {
            $VML .= 'strokeweight="' . $options['strokeweight'] . 'pt" ';
        }

        return $VML;
    }

}
