<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//create a simple Word fragment with formatted text to be include in the textbox
$txtboxContent =new Phpdocx\Elements\WordFragment($docx);

$runs = array();

$runs[] = array('text' => 'This text is normal.');
$runs[] = array('text' => ' And this text is red.', 'color' => 'FF0000');

$txtboxContent->addText($runs);

$textBoxOptions = array(
	'align' => 'right', 
	'paddingLeft' => 5, 
	'width' => 140,
    'height' => 140,
    'contentVerticalAlign' => 'bottom'
	);

$txtbx = new Phpdocx\Elements\WordFragment($docx);

$txtbx->addTextBox($txtboxContent, $textBoxOptions);

$documentText = 'Text in the main document flow. Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' .
    'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut' .
    'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' .
    'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut' .
    'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' .
    'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';


$textRuns = array();

$textRuns[] = $txtbx;
$textRuns[] = array('text' => $documentText);

$docx->addText($textRuns);


$docx->createDocx('example_addTextBox_3');