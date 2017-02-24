<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$source = '../../files/Text.docx';
$target = 'example_watermarkText.docx';
$docx->watermarkDocx($source, $target, $type = 'text', $options = array('text' => 'PHPDocX'));