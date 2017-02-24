<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
//Set the background color of the document
$docx->setBackgroundColor('FFFFCC');
//Include a paragraph of plain text
$docx->addText('This document should have a pale yellow background color.');

$docx->createDocx('example_setBackgroundColor_1');