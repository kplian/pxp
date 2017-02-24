<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/Checkbox.docx');

$variables = array('check1' => 1, 'check2' => 0, 'check3' => 1);
$docx->tickCheckboxes ($variables);

$docx->createDocx('example_tickCheckboxes_1');
