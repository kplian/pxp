<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx     = new Phpdocx\Create\CreateDocx();
$settings = array(
	'view' => 'outline',
	'zoom' => 70,
);
$text = 'In this case we set the view mode as "outline" and '.
'the default zoom on openning to 70%.';
$docx->addText($text);

$docx->docxSettings($settings);

$docx->createDocx('example_docxSettings_1');