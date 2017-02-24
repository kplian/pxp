<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We will now add a doughnut chart to the Word document:');

$data = array(
	'data 1' => array(20),
	'data 2' => array(20),
	'data 3' => array(50),
	'data 4' => array(25),
	'data 5' => array(5),
);

$paramsChart = array(
	'data'          => $data,
	'type'          => 'doughnutChart',
	'showPercent'   => true,
	'explosion'     => 10,
	'holeSize'      => 25,
	'sizeX'         => 12,
	'sizeY'         => 10,
	'chartAlign'    => 'center',
	'color'         => '2',
	'legendPos'     => 'r',
	'legendOverlay' => true,
	'showTable'     => true,
);
$docx->addChart($paramsChart);

$docx->createDocx('example_addChart_9');