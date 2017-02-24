<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('We will now add a 3D pie chart to the Word document:');

$data = array(
    'Legend 1' => array(20),
    'Legend 2' => array(30),
    'Legend 3' => array(40)
);

$paramsChart = array(
    'data' => $data,
    'type' => 'pie3DChart',
    'rotX' => 20,
    'rotY' => 20,
    'perspective' => 30,
    'color' => 2,
    'sizeX' => 10,
    'sizeY' => 5,
    'chartAlign' => 'center',
    'showPercent' => 1,
);
$docx->addChart($paramsChart);

$docx->addText('And now the same chart in 2D with a different color scheme and without the percentages:');

$data = array(
    'Legend 1' => array(20),
    'Legend 2' => array(30),
    'Legend 3' => array(40)
);

$paramsChart = array(
    'data' => $data,
    'type' => 'pieChart',
    'color' => 3,
    'sizeX' => 10,
    'sizeY' => 5,
    'chartAlign' => 'center',
);
$docx->addChart($paramsChart);


$docx->createDocx('example_addChart_1');