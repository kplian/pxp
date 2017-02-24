<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

for ($j = 0; $j < 50; $j++) {

	$text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, '.
	'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '.
	'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut'.
	'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit '.
	'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '.
	'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '.
	'officia deserunt mollit anim id est laborum.';

	$docx->addText($text);
}

$docx->modifyPageLayout('A3-landscape', array('numberCols' => '3'));

$docx->createDocx('example_modifyPageLayout_1');