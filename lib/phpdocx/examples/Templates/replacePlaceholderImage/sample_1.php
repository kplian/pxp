<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/placeholderImage.docx');

$image_1 = array(
	'height' => 3,
	'width' => 3,
	'target' => 'header'
	);

$docx->replacePlaceholderImage('HEADERIMG','../../img/logo_header.jpg', $image_1);
$docx->replacePlaceholderImage('LOGO','../../img/imageP3.png');


$docx->createDocx('example_replacePlaceholderImages_1');
