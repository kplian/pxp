<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//Set the default font for the document
$docx->setDefaultFont('Arial Narrow');
//Include some paragraphs of plain text
$docx->addText('This text is going to show in Arial Narrow font because it is the chosen default font.');
$docx->addText('The standard default font is usually Calibri.');

$docx->createDocx('example_setDefaultFont_1');