<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$source = '../../files/example_area_chart.docx';
$target = 'example_area_chart_replace_data.docx';

$simpleData = array(
    array(25, 10, 5),
    array(20, 5, 4),
    array(15, 0, 3),
    array(10, 15, 2)
);

$completedData = array(
    array(25, 10, 5),
    array(20, 5, 4),
    array(15, 0, 3),
    array(10, 15, 2)
);

$data = array(
    0 => $simpleData,
    1 => $completedData,
);
$docx->replaceChartData($source, $target, $data);