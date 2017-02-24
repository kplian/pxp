<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('This is just a simple text to help illustrate how to mark a document as final.');
$docx->addText('Beware that this \'protection\' can be easily removed by an expert user.');

$docx->setMarkAsFinal();

$docx->createDocx('example_setMarkAsFinal_1');