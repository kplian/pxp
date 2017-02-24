<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
$settings = array(
    'view' => 'outline',
    'zoom' => 70
    );
$text = 'In this case we set the view mode as "outline" and ' .
    'the default zoom on openning to 70%.';
$docx->addText($text);

$docx->docxSettings($settings);

$docx->createDocx('example_docxSettings_1');