<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We will now add a radar chart to the Word document:');

$data = array(
	'legend' => array('Series 1', 'Series 2', 'Series 3'),
	'data 1' => array(10, 7, 5),
	'data 2' => array(20, 60, 3),
	'data 3' => array(50, 33, 7),
	'data 4' => array(25, 0, 14)
);

$paramsChart = array(
	'data'          => $data,
	'type'          => 'radar',
	'style'         => 'radar',
	'color'         => '2',
	'chartAlign'    => 'center',
	'sizeX'         => '12',
	'sizeY'         => '10',
	'legendPos'     => 'r',
	'legendOverlay' => '0',
	'hgrid'         => '1',
	'vgrid'         => '1',
);
$docx->addChart($paramsChart);

$docx->addText('And now the same radar chart but with filled style:');

$data = array(
	'legend' => array('Series 1', 'Series 2', 'Series 3'),
	'data 1' => array(10, 7, 5),
	'data 2' => array(20, 60, 3),
	'data 3' => array(50, 33, 7),
	'data 4' => array(25, 0, 14)
);
$paramsChart = array(
	'data'          => $data,
	'type'          => 'radar',
	'style'         => 'filled',
	'color'         => '2',
	'chartAlign'    => 'center',
	'sizeX'         => '12',
	'sizeY'         => '10',
	'legendPos'     => 'r',
	'legendOverlay' => '0',
	'hgrid'         => '1',
	'vgrid'         => '1',
);
$docx->addChart($paramsChart);

$docx->createDocx('example_addChart_6');