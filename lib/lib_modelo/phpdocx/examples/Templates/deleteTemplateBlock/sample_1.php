<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/TemplateBlocks.docx');


$docx->deleteTemplateBlock('FIRST');


$docx->createDocx('example_deleteTemplateBlock_1');
