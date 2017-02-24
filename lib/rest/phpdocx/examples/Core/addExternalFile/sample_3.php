<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('We are going to insert now a RTF document. Beware that this method is not compatible with legacy versions of Word running the docx compatibility pack.');
$docx->addExternalFile(array('src' => '../../files/Test.rtf'));
$docx->addText('A new paragraph.');


$docx->createDocx('example_addRTF');