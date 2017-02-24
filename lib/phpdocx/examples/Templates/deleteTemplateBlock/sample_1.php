<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateBlocks.docx');


$docx->deleteTemplateBlock('FIRST');


$docx->createDocx('example_deleteTemplateBlock_1');
