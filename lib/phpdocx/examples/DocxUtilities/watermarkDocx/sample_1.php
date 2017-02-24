<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$source = '../../files/Text.docx';
$target = 'example_watermarkImage.docx';
$docx->watermarkDocx($source, $target, $type = 'image', $options = array('image' => '../../files/image.png', 'decolorate' => false));