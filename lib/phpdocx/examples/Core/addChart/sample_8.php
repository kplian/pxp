<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We will now add a bubble chart to the Word document:');

$data = array(
	'legend' => array('', 'values', ''),
	'data 1' => array(10, 8, 6),
	'data 2' => array(15, 2, 2),
	'data 3' => array(20, 10, 5),
	'data 4' => array(25, 6, 4)
);

$paramsChart = array(
	'data'         => $data,
	'type'         => 'bubbleChart',
	'legendPos'    => 't',
	'color'        => 28,
	'chartAlign'   => 'center',
	'sizeX'        => '13',
	'sizeY'        => '8',
	'showtable'    => 1,
	'hgrid'        => '1',
	'vgrid'        => '1',
	'showValue'    => true,
	'showCategory' => true,
);
$docx->addChart($paramsChart);

$docx->createDocx('example_addChart_8');