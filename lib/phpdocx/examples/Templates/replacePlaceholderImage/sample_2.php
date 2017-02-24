<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/placeholderImageFootnote.docx');

$image_1 = array(
	'height' => 2,
	'width' => 2,
	'target' => 'footnote'
	);

$docx->replacePlaceholderImage('FOOTNOTEIMG','../../img/logo_header.jpg', $image_1);


$docx->createDocx('example_replacePlaceholderImages_2');
