<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/TemplateBlocks.docx');


$docx->clearBlocks();


$docx->createDocx('example_clearBlocks_1');
