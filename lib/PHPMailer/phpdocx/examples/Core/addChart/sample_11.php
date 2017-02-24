<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('We will now add a surface chart to the Word document:');

$data = array(
    'legend' => array('Series 1', 'Series 2', 'Series 3'),
    'Value1' => array(4.3, 2.4, 2),
    'Value2' => array(2.5, 4.4, 2),
    'Value3' => array(3.5, 1.8, 3),
    'Value4' => array(4.5, 2.8, 5),
    'Value5' => array(5, 2, 3)
);

$paramsChart = array(
    'data' => $data,
    'type' => 'surfaceChart',
    'legendpos' => 't',
    'legendoverlay' => false,
    'sizeX' => 12,
    'sizeY' => 8,
    'chartAlign' => 'center',
    'color' => 2,
);
$docx->addChart($paramsChart);



$docx->createDocx('example_addChart_11');