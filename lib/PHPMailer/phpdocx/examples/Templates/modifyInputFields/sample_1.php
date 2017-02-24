<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/inputFields.docx');

$data = array(
	'textfield_1' => 'first',
	'textfield_2' => 'second',
	'sdt_1' => 'third',
	'sdt_2' => 'fourth'
	);

$docx->modifyInputFields($data);


$docx->createDocx('example_modifyInputFields_1');
