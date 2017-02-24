<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/inputFields.docx');

$data = array(
	'textfield_1' => 'first',
	'textfield_2' => 'second',
	'sdt_1' => 'third',
	'sdt_2' => 'fourth'
	);

$docx->modifyInputFields($data);


$docx->createDocx('example_modifyInputFields_1');
