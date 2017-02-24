<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('This example illustrates how to add a mergefield to a Word document.');
$mergeParameters = array('format' => 'Upper', 
	'textBefore' => 'A mergefield example: ', 
	'textAfter' => ' and some text afterwards.');
$options = array('color' => 'B70000');
$docx->addMergeField('MyMergeField example', $mergeParameters, $options);

//remove the shading from the mergeField data
$docx->docxSettings(array('doNotShadeFormData' => 0));

$docx->createDocx('example_addMergeField_1');
