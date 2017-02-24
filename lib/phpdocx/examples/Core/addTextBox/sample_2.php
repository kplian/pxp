<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$txtbx = new Phpdocx\Elements\WordFragment($docx);

$text= 'Some text content for the textbox. Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' .
    'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut' .
    'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' .
    'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

$textBoxOptions = array(
	'align' => 'left', 
	'paddingLeft' => 5, 
	'border' => false, 
	'fillColor' => '#ddddff', 
	'width' => 200
	);

$txtbx->addTextBox($text, $textBoxOptions);

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


$docx->createDocx('example_addTextBox_2');