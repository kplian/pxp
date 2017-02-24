<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/placeholderImageFootnote.docx');

$image_1 = array(
	'height' => 2,
	'width' => 2,
	'target' => 'footnote'
	);

$docx->replacePlaceholderImage('FOOTNOTEIMG','../../img/logo_header.jpg', $image_1);


$docx->createDocx('example_replacePlaceholderImages_2');
