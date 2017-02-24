<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//Create a Word fragment with an image to be inserted in the header of the document
$imageOptions = array(
	'src' => '../../img/image.png',
	'dpi' => 300,
);

$default = new Phpdocx\Elements\WordFragment($docx, 'defaultFooter');
$default->addImage($imageOptions);
$first = new Phpdocx\Elements\WordFragment($docx, 'firstFooter');
$first->addText('first page footer.');
$even = new Phpdocx\Elements\WordFragment($docx, 'evenFooter');
$even->addText('even page footer.');

$docx->addFooter(array('default' => $default, 'first' => $first, 'even' => $even));
//add some text
$docx->addText('This is the first page of a document with different footers for the first and even pages.');
$docx->addBreak(array('type' => 'page'));
$docx->addText('This is the second page.');
$docx->addBreak(array('type' => 'page'));
$docx->addText('This is the third page.');

$docx->createDocx('example_addFooter_2');