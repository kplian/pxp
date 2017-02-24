<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//include the date in the middle of a text run
$dateOptions = array('bold' => true,
	'color'                    => 'b70000',
	'dateFormat'               => "dd' of 'MMMM' of 'yyyy",
);

$date = new Phpdocx\Elements\WordFragment($docx);
$date->addDateAndHour($dateOptions);

$text   = array();
$text[] = array('text' => 'Today is the ');
$text[] = $date;
$text[] = array('text' => ' and it is a beautiful day.');

$docx->addText($text);

$docx->createDocx('example_addDateAndHour_2');