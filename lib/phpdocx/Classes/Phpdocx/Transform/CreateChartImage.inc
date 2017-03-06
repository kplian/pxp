<?php
namespace Phpdocx\Transform;
if (file_exists(dirname(__FILE__) . '/../../../lib/jpgraph/')) {
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_bar.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_iconplot.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_line.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_pie.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_pie3d.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_radar.php';
    require_once dirname(__FILE__) . '/../../../lib/jpgraph/src/jpgraph_scatter.php';
}
if (file_exists(dirname(__FILE__) . '/../../../lib/ezcomponents')) {
    require dirname(__FILE__) . '/../../../lib/ezcomponents/Base/src/base.php';
}

/**
 * Abstract class to set a common methods to parse charts
 *
 * @category   Phpdocx
 * @package    trasform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.07.03
 * @link       http://www.phpdocx.com
 */
abstract class CreateChartImage
{
    /**
     * The charts
     * @var array of SimpleXMLElement
     */
    protected $charts;

    /**
     * Chart data. It contains the title, the labels, the elements and the values
     * @var array
     */
    protected $chartData;

    /**
     * Index to iterate over all the charts in a
     * @var int
     */
    protected $chartIndex;

    /**
     * Chart type. It contains the type of the chart
     * @var array
     */
    protected $chartType;

    /**
     * Chart subtype. It contains the subtype of the chart; ex: col or bar for barChart
     * @var array
     */
    protected $chartSubtype;

    /**
     * Chart grouping type: null, stacked, clustered...
     * @var array
     */
    protected $groupingType;

    /**
     * Height of the output image
     * @var int
     */
    protected $height;

    /**
     * The new image
     * @var mixed
     */
    protected $image;

    /**
     * The axis labels
     * @var array
     */
    protected $labelAxis;

    /**
     * The legend properties
     * @var array
     */
    protected $legend;

    /**
     * List of generated images
     * @var array
     */
    protected $listImages;

    /**
     * Check if the chart is 3D
     * @var bool
     */
    protected $threeD;

    /**
     * Width of the output image
     * @var int
     */
    protected $width;

    /**
     * Create the new image
     */
    abstract public function create();

    /**
     * Save the image to a path
     *
     * @var string $path Path to save the image
     */
    abstract public function save($path = null);

    /**
     * Getter $this->height
     *
     * @return int
     */
    public function getHeight()
    {
        return $this->height;
    }

    /**
     * Getter $this->width
     *
     * @return int
     */
    public function getWidth()
    {
        return $this->width;
    }

    /**
     * Setter $this->height
     *
     * @var int $height
     */
    public function setHeight($height)
    {
        $this->height = $height;
    }

    /**
     * Setter $this->width
     *
     * @var int $width
     */
    public function setWidth($width)
    {
        $this->width = $width;
    }

    /**
     * Getter $this->listImages
     *
     * @return array
     */
    public function getListImages()
    {
        return $this->listImages;
    }

    public function __construct()
    {
        $this->width = 400;
        $this->height = 250;
        $this->charts = array();
    }

    /**
     * Gets the charts of a DOCX
     *
     * @param string $chart The chart to be parsed
     */
    public function getChartsDocx($docxPath)
    {
        if (!file_exists($docxPath)) {
            throw new \Exception('The file ' . $docxPath . 'not exists.', 1);
        }

        // get the Content_Types.xml file from the DOCX
        $docx = new \ZipArchive();
        $docx->open($docxPath);
        $contentTypesXML = $docx->getFromName('[Content_Types].xml');

        // get the document.xml.rels file from the DOCX
        $documentRelsXML = $docx->getFromName('word/_rels/document.xml.rels');
        $documentRelsDOM = new \SimpleXMLElement($documentRelsXML);
        $documentRelsDOM->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/relationships');

        // get the document.xml file from the DOCX
        $documentXML = $docx->getFromName('word/document.xml');
        $documentDOM = new \SimpleXMLElement($documentXML);

        // get the chart elements of the DOM
        $contentTypesDOM = new \SimpleXMLElement($contentTypesXML);
        $contentTypesDOM->registerXPathNamespace('ns', 'http://schemas.openxmlformats.org/package/2006/content-types');
        $elementsCharts = $contentTypesDOM->xpath('ns:Override[@ContentType="application/vnd.openxmlformats-officedocument.drawingml.chart+xml"]');
        foreach ($elementsCharts as $value) {
            // get the attributes of the element
            $attributes = $value->attributes();

            // as the attributes return an absolute path remove the first '/' to get the content of the XML
            // add the realite path of the chart as the key

            // get the content
            $this->charts[substr($attributes['PartName'], 6)]['content'] = $docx->getFromName(substr($attributes['PartName'], 1));

            // get the width and height and add them to the charts array
            // get the rId of the chart from the documentRels
            $relationshipChart = $documentRelsDOM->xpath('ns:Relationship[@Target="'.substr($attributes['PartName'], 6).'"]');
            $documentDOM->registerXPathNamespace('c', 'http://schemas.openxmlformats.org/drawingml/2006/chart');

            // get the size from the document by the previous rId
            $elementDocumentExtent = $documentDOM->xpath('//c:chart[@r:id="'.$relationshipChart[0]->attributes()->Id.'"]/parent::*/parent::*/parent::*/wp:extent');

            // get the width
            $this->charts[substr($attributes['PartName'], 6)]['sizeX'] = (string)$elementDocumentExtent[0]->attributes()->{'cx'} / 360000 * 120.5;
            // get the height
            $this->charts[substr($attributes['PartName'], 6)]['sizeY'] = (string)$elementDocumentExtent[0]->attributes()->{'cy'} / 360000 * 120.5;
        }

    }

    /**
     * Parse the charts. Do not use elseif do get all embedded charts.
     */
    public function parseCharts()
    {
        // this is index is used to get as many charts as there's in the XML.
        // This is useful for charts like that ones that combines cols and line
        $this->chartIndex = 0;
        foreach ($this->charts as $chartContent) {
            // init the chart arrays
            $this->chartData = array();
            $this->chartType = array();
            $this->legend = array();
            $this->groupingType = array();
            $this->chartSubtype = array();

            // parse the chart
            $chart = new \SimpleXMLElement($chartContent['content']);
            // get the children with ns 'c'
            $contentChartXML = $chart->children('c', TRUE);

            // get if the chart is 3D
            if ($contentChartXML->chart->view3D) {
                $this->threeD = true;
            } else {
                $this->threeD = false;
            }

            // get the legend properties
            if ($contentChartXML->chart->legend) {
                $this->legend['show'] = true;
                $this->legend['position'] = (string)$contentChartXML->chart->legend->legendPos->attributes()->{'val'};
            } else {
                $this->legend['show'] = false;
            }

            // get the content based on the chart type and save in
            // into the $this->charData variable
            if (!empty($contentChartXML->chart->plotArea->barChart) || !empty($contentChartXML->chart->plotArea->bar3DChart)) {
                // barChart

                // save the chart type
                $this->chartType[$this->chartIndex] = 'barChart';

                // iterate over each content of the graph and add it to $this->chartData
                // This attribute will be used in the create method of each class
                // that extends CreateChartImage
                $i = 0;
                if ($contentChartXML->chart->plotArea->barChart) {
                    // save the grouping type
                    $this->groupingType[$this->chartIndex] = $contentChartXML->chart->plotArea->barChart->grouping->attributes()->{'val'};

                    // save the subtype of the chart
                    $this->chartSubtype[$this->chartIndex] = $contentChartXML->chart->plotArea->barChart->barDir->attributes()->{'val'};

                    foreach ($contentChartXML->chart->plotArea->barChart->ser as $data) {
                        // get the legend
                        $legend = $data->xpath('c:tx//c:v');
                        $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                        // get the elements
                        $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                        // get the values
                        $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                        // get the colors
                        $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                        if ($color[0]) {
                            $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                        }

                        $i++;
                    }
                } elseif ($contentChartXML->chart->plotArea->bar3DChart) {
                    // save the grouping type
                    $this->groupingType[$this->chartIndex] = $contentChartXML->chart->plotArea->bar3DChart->grouping->attributes()->{'val'};

                    foreach ($contentChartXML->chart->plotArea->bar3DChart->ser as $data) {
                        // get the legend
                        $legend = $data->xpath('c:tx//c:v');
                        $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                        // get the elements
                        $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                        // get the values
                        $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                        // get the colors
                        $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                        if ($color[0]) {
                            $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                        }

                        $i++;
                    }
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->lineChart)) {
                // lineChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'lineChart';

                // iterate over each content of the graph and add it to $this->chartData
                // This attribute will be used in the create method of each class
                // that extends CreateChartImage
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->lineChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the elements
                    $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                    // get the values
                    $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->pieChart) || !empty($contentChartXML->chart->plotArea->pie3DChart)) {
                // pieChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'pieChart';

                // iterate over each content of the graph and add it to $this->chartData
                $i = 0;
                if ($contentChartXML->chart->plotArea->pieChart) {
                    foreach ($contentChartXML->chart->plotArea->pieChart->ser as $data) {
                        // get the legend
                        $legend = $data->xpath('c:tx//c:v');
                        $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                        // get the elements
                        $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                        // get the values
                        $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                        // get the colors
                        $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                        if ($color[0]) {
                            $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                        }

                        $i++;
                    }
                } elseif ($contentChartXML->chart->plotArea->pie3DChart) {
                    foreach ($contentChartXML->chart->plotArea->pie3DChart->ser as $data) {
                        // get the legend
                        $legend = $data->xpath('c:tx//c:v');
                        $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                        // get the elements
                        $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                        // get the values
                        $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                        // get the colors
                        $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                        if ($color[0]) {
                            $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                        }

                        $i++;
                    }
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->radarChart)) {
                // radarChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'radarChart';

                // iterate over each content of the graph and add it to $this->chartData
                // This attribute will be used in the create method of each class
                // that extends CreateChartImage
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->radarChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the elements
                    $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                    // get the values
                    $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->doughnutChart)) {
                // doughnutChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'doughnutChart';

                // iterate over each content of the graph and add it to $this->chartData
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->doughnutChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the elements
                    $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                    // get the values
                    $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->bubbleChart)) {
                // bubbleChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'bubbleChart';

                // iterate over each content of the graph and add it to $this->chartData
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->bubbleChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the values X
                    $this->chartData[$this->chartIndex][$i]['valuesX'] = $data->xpath('c:xVal//c:v');

                    // get the values Y
                    $this->chartData[$this->chartIndex][$i]['valuesY'] = $data->xpath('c:yVal//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->areaChart)) {
                // areaChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'areaChart';

                // iterate over each content of the graph and add it to $this->chartData
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->areaChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the elements
                    $this->chartData[$this->chartIndex][$i]['elements'] = $data->xpath('c:cat//c:v');

                    // get the values
                    $this->chartData[$this->chartIndex][$i]['values'] = $data->xpath('c:val//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            if (!empty($contentChartXML->chart->plotArea->scatterChart)) {
                // scatterChart

                // save the type of the chart
                $this->chartType[$this->chartIndex] = 'scatterChart';

                // iterate over each content of the graph and add it to $this->chartData
                $i = 0;
                foreach ($contentChartXML->chart->plotArea->scatterChart->ser as $data) {
                    // get the legend
                    $legend = $data->xpath('c:tx//c:v');
                    $this->chartData[$this->chartIndex][$i]['legend'] = $legend[0];

                    // get the valuesX
                    $this->chartData[$this->chartIndex][$i]['valuesX'] = $data->xpath('c:xVal//c:v');

                    // get the valuesY
                    $this->chartData[$this->chartIndex][$i]['valuesY'] = $data->xpath('c:yVal//c:v');

                    // get the sizes
                    $this->chartData[$this->chartIndex][$i]['sizes'] = $data->xpath('c:bubbleSize//c:v');

                    // get the colors
                    $color = $data->xpath('c:spPr//a:solidFill//a:srgbClr');
                    if ($color[0]) {
                        $this->chartData[$this->chartIndex][$i]['color'] = $color[0]->attributes()->{'val'};
                    }

                    $i++;
                }

                $this->chartIndex++;
            }

            // set the width and height
            $this->width = $chartContent['sizeX'] / 2;
            $this->height = $chartContent['sizeY'] / 2;
            $this->create();
            $this->listImages[] = $this->save();
        }
    }
}