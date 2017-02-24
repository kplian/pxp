<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$values = array (0,1,1);
$docx->parseCheckboxes('../../files/Checkbox.docx', 'example_parsecheckboxes.docx', $values);