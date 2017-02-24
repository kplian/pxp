<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$text= 'Some text content for the textbox. Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' .
    'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut' .
    'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' .
    'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

$textBoxOptions = array(
	'align' => 'right', 
	'paddingLeft' => 10, 
	'borderColor' => '#b70000', 
	'borderWidth' => 4, 
	'fillColor' => '#dddddd', 
	'width' => 240
	);

$docx->addTextBox($text, $textBoxOptions);

$docx->createDocx('example_addTextBox_1');