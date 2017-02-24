<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
$text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, '.
'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '.
'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut'.
'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit '.
'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '.
'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '.
'officia deserunt mollit anim id est laborum.';

$docx->addText($text);

$paramsText = array(
	'b' => true
);

$docx->addText($text, $paramsText);

$docx->addSection('nextPage', 'A3');

$docx->addText($text);

$paramsText = array(
	'b' => true
);

$docx->addText($text, $paramsText);

$docx->createDocx('example_addSection_1');