<?php
namespace Phpdocx\Transform;
/**
 * Create charts as images using EzComponents
 *
 * @category   Phpdocx
 * @package    trasform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.07.03
 * @link       http://www.phpdocx.com
 */
class CreateChartImageEzComponents extends CreateChartImage
{
    /**
     * Create the new image
     */
    public function create()
    {
        for ($indexChart = 0; $indexChart < $this->chartIndex; $indexChart++) {
            if ($this->chartType[$indexChart] == 'barChart') {
                // if the subtype is bar, the bars are horizontal
                if ($this->chartSubtype[$indexChart] == 'bar') {
                    $this->image = new \ezcGraphHorizontalBarChart();
                    $this->image->renderer = new \ezcGraphHorizontalRenderer();
                } else {
                    $this->image = new \ezcGraphBarChart();
                }


                // data to be added to the chart
                $data = array();

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    $dataElements = array();
                    for ($i = 0; $i < count($chartData['elements']); $i++) {
                        $dataElements[(string)$chartData['elements'][$i]] = (string)$chartData['values'][$i];
                    }
                    $data[(string)$chartData['legend']] = $dataElements;
                }

                // add the data to the image
                foreach ($data as $key => $value) {
                    $this->image->data[$key] = new \ezcGraphArrayDataSet($value);
                }

                // set 3D mode
                if ($this->threeD) {
                    $this->image->renderer = new \ezcGraphRenderer3d();
                }

                // set the grouping type
                if ($this->groupingType[$indexChart] == 'stacked') {
                    $this->image->options->stackBars = true;
                }
            } elseif ($this->chartType[$indexChart] == 'pieChart' || $this->chartType[$indexChart] == 'doughnutChart') {
                $this->image = new \ezcGraphPieChart();

                // data to be added to the chart
                $data = array();

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    $dataElements = array();
                    for ($i = 0; $i < count($chartData['elements']); $i++) {
                        $dataElements[(string)$chartData['elements'][$i]] = (string)$chartData['values'][$i];
                    }
                    $data = $dataElements;
                }

                // add the data to the image
                $this->image->data[(string)$this->chartData[$indexChart][0]['legend']] = new \ezcGraphArrayDataSet($data);

                // set 3D mode
                if ($this->threeD) {
                    $this->image->renderer = new \ezcGraphRenderer3d();
                }

                // add the title. Word adds this title as a legend for pie charts
                if (isset($this->chartData[$indexChart][0]['legend'])) {
                    $this->image->title = $this->chartData[$indexChart][0]['legend'];
                }
            } elseif ($this->chartType[$indexChart] == 'lineChart' || $this->chartType[$indexChart] == 'bubbleChart' || $this->chartType[$indexChart] == 'areaChart') {
                $this->image = new \ezcGraphLineChart();

                // data to be added to the chart
                $data = array();

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    $dataElements = array();
                    for ($i = 0; $i < count($chartData['elements']); $i++) {
                        $dataElements[(string)$chartData['elements'][$i]] = (string)$chartData['values'][$i];
                    }
                    $data[(string)$chartData['legend']] = $dataElements;
                }

                // add the data to the image
                foreach ($data as $key => $value) {
                    $this->image->data[$key] = new \ezcGraphArrayDataSet($value);
                }

                // if it's a chart fill lines to the bottom
                if ($this->chartType[$indexChart] == 'areaChart') {
                    $this->image->options->fillLines = 210;
                }
            } elseif ($this->chartType[$indexChart] == 'radarChart') {
                $this->image = new \ezcGraphRadarChart();

                // data to be added to the chart
                $data = array();

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    $dataElements = array();
                    for ($i = 0; $i < count($chartData['elements']); $i++) {
                        $dataElements[(string)$chartData['elements'][$i]] = (string)$chartData['values'][$i];
                    }
                    $data[(string)$chartData['legend']] = $dataElements;
                }

                // add the data to the image
                foreach ($data as $key => $value) {
                    $this->image->data[$key] = new \ezcGraphArrayDataSet($value);
                    $this->image->data[$key][] = reset($value);
                }
            }
        }

        // set the legend
        if (isset($this->legend['show']) & $this->legend['show']) {
            if ($this->legend['position'] == 'r') {
                $this->image->legend->position = \ezcGraph::RIGHT;
            } elseif ($this->legend['position'] == 't') {
                $this->image->legend->position = \ezcGraph::TOP;
            }
            $this->image->legend->landscapeSize = .5;
        } else {
            $this->image->legend = false;
        }

        // set the font sizes
        $this->image->options->font->maxFontSize = 12;
    }

    /**
     * Save the image to a path
     *
     * @var string $path Path to save the image
     */
    public function save($path = 'image.svg')
    {
        $path = 'image_' . uniqid(mt_rand(999, 9999)) . '.svg';
        $this->image->render($this->width, $this->height, $path);

        return $path;
    }
}