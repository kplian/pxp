<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateBlocks.docx');


$docx->clearBlocks();


$docx->createDocx('example_clearBlocks_1');
