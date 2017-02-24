<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We will now add a dot scattered chart to the Word document:');

$data = array(
	array(10, 0),
	array(17, 2),
	array(18, 4),
	array(25, 6),
);

$paramsChart = array(
	'data'            => $data,
	'type'            => 'scatterChart',
	'border'          => 0,
	'color'           => 5,
	'jc'              => 'center',
	'legendPos'       => 'r',
	'legendOverlay'   => true,
	'haxLabel'        => 'vertical label',
	'vaxLabel'        => 'horizontal label',
	'haxLabelDisplay' => 'horizontal',
	'vaxLabelDisplay' => 'rotated',
	'hgrid'           => 2,
	'vgrid'           => 2,
	'symbol'          => 'dot', //dot, line
	'showTable'       => true
);
$docx->addChart($paramsChart);

$docx->createDocx('example_addChart_10');