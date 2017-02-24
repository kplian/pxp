<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/TemplateSimpleTable.docx');


$data = array(
	        array(
	            'ITEM' => 'Product A',
	            'REFERENCE' => '107AW3',
	        ),
	        array(
	            'ITEM' => 'Product B',
	            'REFERENCE' => '204RS67O',
	        ),
	        array(
	            'ITEM' => 'Product C',
	            'REFERENCE' => '25GTR56',
	        )
        );

$docx->replaceTableVariable($data);


$docx->createDocx('example_replaceTableVariable_1');
