<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Transform\TransformDocAdv();

$docx->transformDocument('../../files/example_area_chart.docx', 'example_2.pdf');