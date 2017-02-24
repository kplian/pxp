<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//Date in the header
$options_1 = array('bold' => true,
	'fontSize'               => 12,
	'color'                  => 'b70000',
	'dateFormat'             => 'dd/MM/yyyy H:mm:ss',
);
$date = new Phpdocx\Elements\WordFragment($docx);

$date->addDateAndHour($options_1);

$docx->addHeader(array('default' => $date));

$docx->addText('Let us include now different examples of the addDateAndHour with different date formatting:');

$options_2 = array('textAlign' => 'center',
	'bold'                        => true,
	'fontSize'                    => 14,
	'color'                       => '333333',
	'dateFormat'                  => "dd' of 'MMMM' of 'yyyy' at 'H:mm");

$docx->addDateAndHour($options_2);

$options_3 = array('bold' => true,
	'fontSize'               => 11,
	'color'                  => '0000FF',
	'dateFormat'             => "MM'-'dd'-'yy");

$docx->addDateAndHour($options_3);

$docx->createDocx('example_addDateAndHour_1');