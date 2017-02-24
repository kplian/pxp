<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
//parse styles of an external template
$docx->parseStyles('../../files/stylesTemplate.docx');

$docx->createDocx('example_parseStyles_3');
