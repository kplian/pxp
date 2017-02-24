<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/Checkbox.docx');

$variables = array('check1' => 1, 'check2' => 0, 'check3' => 1);
$docx->tickCheckboxes ($variables);

$docx->createDocx('example_tickCheckboxes_1');
