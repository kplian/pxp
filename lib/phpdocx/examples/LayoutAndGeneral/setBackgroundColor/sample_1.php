<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//Set the background color of the document
$docx->setBackgroundColor('FFFFCC');
//Include a paragraph of plain text
$docx->addText('This document should have a pale yellow background color.');

$docx->createDocx('example_setBackgroundColor_1');