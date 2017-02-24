<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We will now add a composite pie chart to the Word document:');

$data = array(
	'data 1' => array('10'),
	'data 2' => array('20'),
	'data 3' => array('50'),
	'data 4' => array('25'),
	'data 5' => array('55'),
	'data 6' => array('75'),
	'data 7' => array('60'),
	'data 8' => array('25'),
);

$paramsChart = array(
	'data'          => $data,
	'type'          => 'ofPieChart',
	'title'         => 'Pie of pie chart',
	'color'         => '26',
	'showPercent'   => 1,
	'sizeX'         => 15,
	'sizeY'         => 10,
	'chartAlign'    => 'center',
	'font'          => 'Times New Roman',
	'gapWidth'      => 150,
	'secondPieSize' => 75,
	'splitType'     => 'val',
	'splitPos'      => 30.0,
);
$docx->addChart($paramsChart);

$docx->addText('And now the same chart but with a bar subgraph:');

$data = array(
	'data 1' => array('10'),
	'data 2' => array('20'),
	'data 3' => array('50'),
	'data 4' => array('25'),
	'data 5' => array('55'),
	'data 6' => array('75'),
	'data 7' => array('60'),
	'data 8' => array('25'),
);

$paramsChart = array(
	'data'          => $data,
	'type'          => 'ofPieChart',
	'subtype'       => 'bar',
	'title'         => 'Bar of pie chart',
	'color'         => '2',
	'showPercent'   => 1,
	'sizeX'         => 15,
	'sizeY'         => 10,
	'chartAlign'    => 'center',
	'font'          => 'Times New Roman',
	'gapWidth'      => 150,
	'secondPieSize' => 75,
	'splitType'     => 'val',
	'splitPos'      => 30.0,
);
$docx->addChart($paramsChart);

$docx->createDocx('example_addChart_7');