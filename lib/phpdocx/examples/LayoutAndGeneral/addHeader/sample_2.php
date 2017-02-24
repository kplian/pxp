<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//create a Word fragment with an image to be inserted in the header of the document
$imageOptions = array(
	'src' => '../../img/image.png',
	'dpi' => 600,
);

$headerImage = new Phpdocx\Elements\WordFragment($docx, 'defaultHeader');
$headerImage->addImage($imageOptions);

//create a Word Fragment with a text
$textOptions = array(
	'fontSize' => 13,
	'b'        => 'on',
	'color'    => '567899',
);
$headerText = new Phpdocx\Elements\WordFragment($docx, 'defaultHeader');
$headerText->addText('PHPDocX Header Title', $textOptions);

//create a Word Fragment with page numbering
$pageNumberOptions = array(
	'textAlign' => 'right',
	'fontSize'  => 11,
);
$headerPageNumber = new Phpdocx\Elements\WordFragment($docx, 'defaultHeader');
$headerPageNumber->addPageNumber('numerical', $pageNumberOptions);

//create a Word Fragment with a table that will hold all elements
//Warning: we include an additional border none property to the table cells to improve
//PDF rendering
$valuesTable = array(
	array(
		array('value' => $headerImage, 'vAlign' => 'center'),
		array('value' => $headerText, 'vAlign' => 'center'),
		array('value' => $headerPageNumber, 'vAlign' => 'center'),
	),
);
$widthTableCols = array(
	700,
	7500,
	500,
);
$paramsTable = array(
	'border'       => 'nil',
	'columnWidths' => $widthTableCols,
);
$headerTable = new Phpdocx\Elements\WordFragment($docx, 'defaultHeader');
$headerTable->addTable($valuesTable, $paramsTable);

//add some text to the body of the document
$docx->addHeader(array('default' => $headerTable));

//add some text in the first page of the document
$docx->addText('This document has a header with an image, some text and page numbering.');
//add a page break so we see the numbering at work
$docx->addBreak(array('type' => 'page'));
//add some text in the first page of the document
$docx->addText('Now some text in the second page.');

$docx->createDocx('example_addHeader_2');