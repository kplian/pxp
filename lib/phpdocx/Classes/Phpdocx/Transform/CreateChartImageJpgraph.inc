<?php
namespace Phpdocx\Transform;
/**
 * Create charts as images using JpGraph
 *
 * @category   Phpdocx
 * @package    trasform
 * @copyright  Copyright (c) Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    2014.07.03
 * @link       http://www.phpdocx.com
 */
class CreateChartImageJpgraph extends CreateChartImage
{
    /**
     * Create the new image
     */
    public function create()
    {
        $this->image = null;
        for ($indexChart = 0; $indexChart < $this->chartIndex; $indexChart++) {
            if ($this->chartType[$indexChart] == 'barChart') {
                // data to be added to the chart
                $data = array();
                // new chart
                if (!$this->image) {
                    var_dump("entro1");
                    $this->image = new \Graph($this->width, $this->height, 'auto');
                }
                // set the scale
                $this->image->SetScale('textint');
                // labels array
                $labels = array();
                // legend array
                $legend = array();
                $i = 0;

                if ($this->chartSubtype[$indexChart] == 'bar') {
                    $this->chartData[$indexChart] = array_reverse($this->chartData[$indexChart]);
                }

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    // get the data axys
                    $dataXAxis = array();
                    foreach ($chartData['values'] as $value) {
                        $dataXAxis[] = (string)$value;
                    }
                    $plot = new \BarPlot($dataXAxis);
                    // add the legend only is it's in the chart
                    if (isset($this->legend['show']) && $this->legend['show']) {
                        $plot->setLegend($chartData['legend']);
                    }

                    // add the color
                    if (isset($chartData['color']) && $chartData['color']) {
                        $this->image->graph_theme = null;
                        $plot->SetColor('#' . $chartData['color']);
                        $plot->SetFillColor('#' . $chartData['color']);
                    }

                    $data[] = $plot;
                }

                // iterate the first chart data and add the labels
                foreach ($this->chartData[$indexChart][0]['elements'] as $chartElement) {
                    $labels[] = (string)$chartElement;
                }

                // set the grouping type
                if ($this->groupingType[$indexChart] == 'clustered') {
                    $dataBar = new \GroupBarPlot($data);
                } else {
                    $dataBar = new \AccBarPlot($data);
                }

                // if the subtype is bar, the bars are horizontal
                if ($this->chartSubtype[$indexChart] == 'bar') {
                    $this->image->Set90AndMargin();
                    $this->image->xaxis->HideLabels();
                }

                // add the labels
                $this->image->xaxis->SetTickLabels($labels);

                // add the data to the image
                $this->image->Add($dataBar);
            } elseif ($this->chartType[$indexChart] == 'pieChart') {
                // data to be added to the chart
                $data = array();
                $dataLegend = array();
                $colors = array();
                // new chart
                if (!$this->image) {
                    var_dump("entro2");
                    $this->image = new \PieGraph($this->width, $this->height);
                }
                // set the scale
                $this->image->SetScale('intlin');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    foreach ($chartData['values'] as $value) {
                        $data[] = (string)$value;
                    }
                    foreach ($chartData['elements'] as $value) {
                        $dataLegend[] = (string)$value;
                    }
                    if (isset($chartData['color']) && $chartData['color']) {
                        $colors[] = '#' . $chartData['color'];
                    }
                    
                }

                // set 3D mode
                if ($this->threeD) {
                    $pieChart = new \PiePlot3D($data);
                } else {
                    $pieChart = new \PiePlot($data);
                }
                $pieChart->SetLegends($dataLegend);

                // set the colors
                if (count($colors) > 0) {
                    $this->image->graph_theme = null;
                    $pieChart->SetSliceColors($colors);
                }

                // add the title. Word adds this title as a legend for pie charts
                if (isset($this->chartData[$indexChart][0]['legend'])) {
                    $this->image->title->Set($this->chartData[$indexChart][0]['legend']);
                }

                // add the data to the image
                $this->image->Add($pieChart);
            } elseif ($this->chartType[$indexChart] == 'lineChart') {
                // data to be added to the chart
                $data = array();
                // new chart
                if (!$this->image) {
                    var_dump("entro3");
                    $this->image = new \Graph($this->width, $this->height, 'auto');
                }
                // set the scale
                $this->image->SetScale('intlin');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    // get the data axys
                    $dataXAxis = array();
                    foreach ($chartData['values'] as $value) {
                        $dataXAxis[] = (string)$value;
                    }
                    $plot = new \LinePlot($dataXAxis);
                    // add the legend only is it's in the chart
                    if (isset($this->legend['show']) & $this->legend['show']) {
                        $plot->setLegend($chartData['legend']);
                    }

                    // add the color
                    if (isset($chartData['color']) && $chartData['color']) {
                        $plot->SetColor('#' . $chartData['color']);
                        $plot->SetFillColor('#' . $chartData['color']);
                        $this->image->graph_theme = null;
                    }

                    $data[] = $plot;
                }

                // iterate the first chart data and add the labels
                foreach ($this->chartData[$indexChart][0]['elements'] as $chartElement) {
                    $labels[] = (string)$chartElement;
                }

                // add the labels
                $this->image->xaxis->SetTickLabels($labels);

                // add the data to the image
                $this->image->Add($data);
            }  elseif ($this->chartType[$indexChart] == 'radarChart') {
                // data to be added to the chart
                $data = array();
                // new chart
                if (!$this->image) {
                    $this->image = new \RadarGraph($this->width, $this->height);
                }

                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    // get the data axys
                    $dataAxis = array();
                    foreach ($chartData['values'] as $value) {
                        $dataAxis[] = (string)$value;
                    }
                    $plot = new \RadarPlot($dataAxis);

                    // add the color
                    if (isset($chartData['color']) && $chartData['color']) {
                        $plot->SetColor('#' . $chartData['color']);
                        $plot->SetFillColor('#' . $chartData['color']);
                        $this->image->graph_theme = null;
                    }

                    // add grid lines
                    $this->image->grid->Show();
                    $this->image->grid->SetLineStyle('dashed');

                    // add the legend only is it's in the chart
                    if (isset($this->legend['show']) & $this->legend['show']) {
                        $plot->setLegend($chartData['legend']);
                    }

                    // add the data to the image
                    $this->image->Add($plot);
                }
            } elseif ($this->chartType[$indexChart] == 'doughnutChart') {
                // data to be added to the chart
                $data = array();
                $dataLegend = array();
                $colors = array();

                // new chart
                if (!$this->image) {
                    var_dump("entro4");
                    $this->image = new \PieGraph($this->width, $this->height, 'auto');
                }
                // set the scale
                $this->image->SetScale('intlin');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    foreach ($chartData['values'] as $value) {
                        $data[] = (string)$value;
                    }
                    foreach ($chartData['elements'] as $value) {
                        $dataLegend[] = (string)$value;
                    }
                    if (isset($chartData['color']) && $chartData['color']) {
                        $colors[] = '#' . $chartData['color'];
                    }
                }

                $pieChart = new \PiePlotC($data);
                $pieChart->SetLegends($dataLegend);

                // set the colors
                if (count($colors) > 0) {
                    $this->image->graph_theme = null;
                    $pieChart->SetSliceColors($colors);
                }

                // add the title. Word adds this title as a legend for doughnut charts
                if (isset($this->chartData[$indexChart][0]['legend'])) {
                    $this->image->title->Set($this->chartData[$indexChart][0]['legend']);
                }

                // add the data to the image
                $this->image->Add($pieChart);
            } elseif ($this->chartType[$indexChart] == 'areaChart') {
                // data to be added to the chart
                $data = array();
                // new chart
                if (!$this->image) {
                    var_dump("entro5");
                    $this->image = new \Graph($this->width, $this->height, 'auto');
                }
                // set the scale
                $this->image->SetScale('textlin');

                $colors = array('red' => 'red', 'blue' => 'blue', 'green' => 'green');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    // get the data axys
                    $dataAxis = array();
                    foreach ($chartData['values'] as $value) {
                        $dataAxis[] = (string)$value;
                    }

                    if (isset($chartData['color']) && $chartData['color']) {
                        $color = '#' . $chartData['color'];
                    }

                    $plot = new \LinePlot($dataAxis);

                    // add the legend only is it's in the chart
                    if (isset($this->legend['show']) & $this->legend['show']) {
                        $plot->setLegend($chartData['legend']);
                    }

                    // if there's a previous plot in the image, use a transparent color
                    if ($indexChart > 0) {
                        $this->image->graph_theme = null;
                        $plot->SetFillColor($color.'@0.5');
                    } else {
                        $this->image->graph_theme = null;
                        $plot->SetFillColor($color);
                    }

                    $data[] = $plot;
                }

                // create the accumulated graph
                $accplot = new \AccLinePlot($data);

                // add the data to the image
                $this->image->Add($accplot);
            } elseif ($this->chartType[$indexChart] == 'bubbleChart') {
                // data to be added to the chart
                $dataX = array();
                $dataY = array();

                // new chart
                if (!$this->image) {
                    var_dump($entro6);
                    $this->image = new \Graph($this->width, $this->height, 'auto');
                }
                // set the scale
                $this->image->SetScale('linlin');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    foreach ($chartData['valuesX'] as $value) {
                        $dataX[] = (string)$value;
                    }
                    foreach ($chartData['valuesY'] as $value) {
                        $dataY[] = (string)$value;
                    }
                }
                // create the plot
                $data = new \ScatterPlot($dataX, $dataY);
                $data->mark->SetType(MARK_FILLEDCIRCLE);

                // add the data to the image
                $this->image->Add($data);
            } elseif ($this->chartType[$indexChart] == 'scatterChart') {
                // data to be added to the chart
                $dataX = array();
                $dataY = array();
                // new chart
                if (!$this->image) {
                    var_dump("entro7");
                    $this->image = new \Graph($this->width, $this->height, 'auto');
                }

                // set the scale
                $this->image->SetScale('intlin');
                // iterate the chart data and add it to $data
                foreach ($this->chartData[$indexChart] as $chartData) {
                    foreach ($chartData['valuesX'] as $value) {
                        $dataX[] = (string)$value;
                    }
                    foreach ($chartData['valuesY'] as $value) {
                        $dataY[] = (string)$value;
                    }
                }
                // create the plot
                $data = new \ScatterPlot($dataX, $dataY);
                // add the data to the image
                $this->image->Add($data);
            }
        }

        // set the legend
        if (isset($this->legend['show']) & $this->legend['show']) {
            if ($this->legend['position'] == 'r') {
                $this->image->legend->SetPos(0.05, 0.5, 'right', 'center');
                $this->image->legend->SetLayout(LEGEND_VERT);
            } elseif ($this->legend['position'] == 't') {
                $this->image->legend->SetPos(0.5, 0.01, 'center', 'top');
            } elseif ($this->legend['position'] == 'b') {
                $this->image->legend->SetPos(0.5, 0.97, 'center', 'bottom');
            }
        }

        $this->image->SetMargin(100, 20, 60, 20);
    }

    /**
     * Save the image to a path
     *
     * @var string $path Path to save the image
     */
    public function save($path = 'image.png')
    {
        $path = 'image_' . uniqid(mt_rand(999, 9999)) . '.png';
        $this->image->Stroke($path);

        return $path;
    }
}