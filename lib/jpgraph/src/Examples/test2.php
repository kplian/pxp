<?php // content="text/plain; charset=utf-8"
require_once ('jpgraph/jpgraph.php');
require_once ('jpgraph/jpgraph_line.php');
require_once ('jpgraph/jpgraph_plotline.php');

// Create a graph instance
$graph = new Graph(500, 500);
// Slightly bigger margins than default to make room for titles
$graph->SetMargin(100, 100, 50, 100);

// Specify what scale we want to use,
// int = integer scale for the X-axis
// int = integer scale for the Y-axis
$graph->SetScale('textlin');
$graph->SetY2Scale('int', 0, 100); // Y2 axis
// Setup a title for the graph
$graph->title->Set('Buggy');
$graph->title->SetMargin(5);
$graph->subtitle->Set('M??eno ka?d?ch 15 min.');
// Setup titles and X-axis labels
$graph->xaxis->title->Set('?as');
$graph->xaxis->title->SetMargin(5);
$graph->xaxis->SetTickLabels(array(
    '03:45', '04:45', '05:45', '06:45', '07:45'
));
// Only draw labels on every 2nd tick mark
$graph->xaxis->SetTextLabelInterval(2);
$graph->xaxis->SetLabelAngle(90);
$graph->xaxis->SetPos('min');

// Setup Y-axis title
$graph->yaxis->title->Set('Teplota [?C]');
$graph->yaxis->title->SetMargin(20);
$graph->yaxis->title->SetColor('red');

$graph->y2axis->title->Set('Vlhkost [%]');
$graph->y2axis->title->SetMargin(20);
$graph->y2axis->title->SetColor('blue');

// popis po deseti, ??re?ka po p?ti
$graph->y2scale->ticks->Set(10, 5);

$temp1 = -4.84444;
$humi1 = 82.44444;

$gr_t1 = array(
    -3, -3.3, -4.5, -2.1, -5.3
);

$gr_h1 = array(
    72, 80, 65, 78, 63
);

// Create the linear plot
$line1 = new LinePlot($gr_t1);
$graph->Add($line1);
$line1->SetColor("red");
$line1->SetLegend('Teplota (' . round($temp1, 1) . ' ?C)');

$line2 = new LinePlot($gr_h1);
$graph->AddY2($line2);
$line2->SetColor("#99f");
$line2->SetFillColor('#00f@0.8');
$line2->SetLegend('Vlhkost (' . round($humi1, 1) . ' %)');

$graph->legend->SetColumns(2);
$graph->legend->Pos(0.5, 0.96, 'center', 'bottom');

// zv?razn?n? nulov? hodnoty
$xline = new PlotLine(HORIZONTAL, 0, '#666', 1);
$graph->AddLine($xline);

// Display the graph
$graph->Stroke();

?>
