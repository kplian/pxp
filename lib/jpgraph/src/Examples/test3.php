<?php
require_once ('jpgraph/jpgraph.php');
require_once ('jpgraph/jpgraph_bar.php');
require_once ('jpgraph/jpgraph_line.php');
require_once ('jpgraph/jpgraph_date.php');

$graph_sdh = new Graph(1024, 450);
$graph_sdh->SetMargin(50, 30, 50, 50);
$graph_sdh->SetMarginColor('white');
$graph_sdh->SetScale('dateint');
$graph_sdh->title->Set('OBSERVATIONS');

// Setup the y-axis to show currency values
$graph_sdh->yaxis->SetLabelFormatCallback('number_format');
$graph_sdh->yaxis->SetLabelFormat('%s');

//Use hour:minute format for the labels
$graph_sdh->xaxis->scale->SetDateFormat('H:i');
$graph_sdh->xgrid->Show();
$graph_sdh->xaxis->SetLabelAngle(90);

// Force labels to only be displayed every 10 minutes
$graph_sdh->xaxis->scale->ticks->Set(INTERVAL * 10);

// Adjust the start time for an "even" 5 minute, i.e. 5,10,15,20,25, ...
$graph_sdh->xaxis->scale->SetTimeAlign(MINADJ_10);

$line_systolic = new LinePlot($systolic, $time);
$line_systolic->SetLegend('SYSTOLIC');
$line_diastolic = new LinePlot($diastolic, $time);
$line_diastolic->SetLegend('DIASTOLIC');
$line_heartrate = new LinePlot($heartrate, $time);
$line_heartrate->SetLegend('HEART RATE');
$line_temperature = new LinePlot($temperature, $time);
$line_temperature->SetLegend('TEMPERATURE');

$graph_sdh->Add($line_systolic);
$graph_sdh->Add($line_diastolic);
$graph_sdh->Add($line_heartrate);
$graph_sdh->Add($line_temperature);
$line_systolic->mark->SetType(MARK_DTRIANGLE);
$line_diastolic->mark->SetType(MARK_UTRIANGLE);
$line_heartrate->mark->SetType(MARK_CIRCLE);
$line_temperature->mark->SetType(MARK_DIAMOND);
$graph_sdh->legend->SetAbsPos(20, 0, 'right', 'top');
$graph_sdh->Stroke();

?>
