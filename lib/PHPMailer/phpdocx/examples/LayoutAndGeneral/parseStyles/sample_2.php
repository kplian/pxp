<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/simpleTemplate.docx');
//parse styles of the current template
//notice that besides the original template styles PHPDocX has included additional useful styles
$docx->parseStyles();

$docx->createDocx('example_parseStyles_2');
