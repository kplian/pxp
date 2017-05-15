<?php
namespace Phpdocx\Elements;
/**
 * Create image graphics (charts)
 *
 * @category   Phpdocx
 * @package    elements
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.04.09
 * @link       http://www.phpdocx.com
 */
class CreateGraphicImg
{

    /**
     *
     * @access private
     * @var CreateDocx
     */
    private $_docx;

    /**
     * @access private
     * @var CreateGraphic
     * @static
     */
    private static $_instance = null;

    /**
     * Construct
     *
     * @access public
     */
    public function __construct()
    {
        $this->_color = '';
        $this->_rotX = '';
        $this->_data = '';
        $this->_font = '';
        $this->_sizeX = '';
        $this->_sizeY = '';
        $this->_title = '';
        $this->_type = '';
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
     * @return CreateGraphic
     * @static
     */
    public static function getInstance()
    {
        if (self::$_instance == NULL) {
            self::$_instance = new CreateGraphicImg();
        }
        return self::$_instance;
    }

    /**
     * Create graphic image
     *
     * @access public
     * @param array $args[0]
     * @param array $args[1]
     * @return boolean
     */
    public function createGraphicImg()
    {
        $this->_docx = new CreateDocx();
        $tempFile = tempnam($this->_docx->getTemporaryDirectory(), 'docXGraph');

        $args = func_get_args();

        $data = $args[0]['data'];
        $font = dirname(__FILE__) .
                '/../../../lib/zetacomponents/Graph/docs/tutorial/tutorial_font.ttf';
        $sizeX = $args[0]['sizeX'] ? $args[0]['sizeX'] : 320;
        $sizeY = $args[0]['sizeY'] ? $args[0]['sizeY'] : 300;
        $type = $args[0]['type'];
        $title = $args[0]['title'];

        $color = $args[0]['color'];
        switch ($color) {
            case 1:
                $palette = 'ezcGraphPaletteBlack';
                break;
            case 2:
                $palette = 'ezcGraphPaletteTango';
                break;
            case 3:
                $palette = 'ezcGraphPaletteEzBlue';
                break;
            case 4:
                $palette = 'ezcGraphPaletteEzRed';
                break;
            case 5:
                $palette = 'ezcGraphPaletteEzGreen';
                break;
            default:
                $palette = 'ezcGraphPaletteTango';
                break;
        }

        switch ($type) {
            case 'barChart':
                $graph = new \ezcGraphHorizontalBarChart();
                $graph->palette = new $palette();
                foreach ($data as $language => $value) {
                    $graph->data[$language] = new \ezcGraphArrayDataSet($value);
                }

                $graph->renderer = new \ezcGraphHorizontalRenderer();
                break;

            case 'bar3DChart':
                $graph = new \ezcGraphHorizontalBarChart();
                $graph->palette = new $palette();
                foreach ($data as $language => $value) {
                    $graph->data[$language] = new \ezcGraphArrayDataSet($value);
                }

                $graph->renderer = new \ezcGraphRenderer3d();
                $graph->renderer->options->legendSymbolGleam = .5;
                $graph->renderer->options->barChartGleam = .5;

                break;

            case 'colChart':
                $graph = new \ezcGraphBarChart();
                $graph->palette = new $palette();
                foreach ($data as $language => $value) {
                    $graph->data[$language] = new \ezcGraphArrayDataSet($value);
                }

                break;

            case 'col3DChart':
                $graph = new \ezcGraphBarChart();
                $graph->palette = new $palette();
                foreach ($data as $language => $value) {
                    $graph->data[$language] = new \ezcGraphArrayDataSet($value);
                }

                $graph->renderer = new \ezcGraphRenderer3d();
                $graph->renderer->options->legendSymbolGleam = .5;
                $graph->renderer->options->barChartGleam = .5;

                break;

            case 'pieChart':
                $graph = new \ezcGraphPieChart();
                $graph->legend = false;
                $graph->palette = new $palette();
                $graph->data['Access statistics'] =
                        new \ezcGraphArrayDataSet($data);
                break;

            case 'pie3DChart':
                $graph = new \ezcGraphPieChart();
                $graph->options->label = '%2$d (%3$.1f%%)';

                $graph->palette = new $palette();
                $graph->data['Access statistics'] =
                        new \ezcGraphArrayDataSet($data);

                $graph->renderer = new \ezcGraphRenderer3d();

                $graph->renderer->options->moveOut = .2;

                $graph->renderer->options->pieChartOffset = 63;

                $graph->renderer->options->pieChartSymbolColor = '#FF0000';

                $graph->renderer->options->pieChartHeight = 20;
                if (isset($args[0]['rotX']) && is_numeric($args[0]['rotX'])
                ) {
                    $graph->renderer->options->pieChartRotation =
                            $args[0]['rotX'] / 100;
                } else {
                    $graph->renderer->options->pieChartRotation = .6;
                }
                break;

            default:
                return false;
                break;
        }

        $graph->title = $title;
        $graph->options->font = $font;
        $graph->driver = new \ezcGraphGdDriver();
        $graph->driver->options->supersampling = 1;
        $graph->driver->options->jpegQuality = 100;
        $graph->driver->options->imageFormat = IMG_JPEG;
        $graph->render($sizeX, $sizeY, $tempFile);
        return true;
    }

}
