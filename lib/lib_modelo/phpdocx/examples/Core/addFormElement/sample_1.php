<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

//Add a Text field
$textFieldOptions = array('fontSize' => 12, 
	'italic' => true, 
	'color' => '0000CC', 
	'bold' => true, 
	'font' => 'Arial', 
	'defaultValue' => 'This is a test');
$docx->addFormElement('textfield', $textFieldOptions);
//Add a Checkbox
$checkboxOptions = array('fontSize' => 12, 	'defaultValue' => true);
$docx->addFormElement('checkbox', $checkboxOptions);
//Add a Select
$selectOptions = array('selectOptions' => array('One', 'Two (selected)', 'Three', 'Four'), 
	'fontSize' => 14,
	'color' => 'C90000', 
	'bold' => true, 
	'underline' => 'double', 
	'font' => 'Algerian', 
	'defaultValue' => 1);//0-based array
$docx->addFormElement('select', $selectOptions);


$docx->createDocx('example_addFormElement_1');