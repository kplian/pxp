<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//Combo box
$list = array(array('First Choice', 1),
	array('second choice', 2),
	array('Third choice', 3),
	);
$options = array('listItems' => $list, 
	'placeholderText' => 'Choose a value or write it down', 
	'alias' => 'Combo Box', 
	'fontSize' => 12, 
	'italic' => true, 
	'color' => 'FF0000', 
	'bold' => true, 
	'underline' => 'single', 
	'font' => 'Algerian');
$docx->addStructuredDocumentTag('comboBox', $options );
//date
$options = array('placeholderText' => 'Choose a date', 
	'alias' => 'Date picker', 
	'fontSize' => 14, 
	'italic' => true, 
	'color' => '777777', 
	'bold' => true, 
	'font' => 'Calibri');
$docx->addStructuredDocumentTag('date', $options);
//dropdown
$list = array(array('One', 1),
	array('Two', 2),
	array('Three', 3)
	);
$options = array('listItems' => $list, 
	'placeholderText' => 'Choose a value', 
	'alias' => 'Dropdown menu', 
	'fontSize' => 12
	);
$docx->addStructuredDocumentTag('comboBox', $options);
//richText
$options = array('placeholderText' => 'This text is locked', 
	'alias' => 'Rich text',
	'lock' => 'contentLocked'
	);
$docx->addStructuredDocumentTag('richText', $options );



$docx->createDocx('example_addStructuredDocumentTag_1');
