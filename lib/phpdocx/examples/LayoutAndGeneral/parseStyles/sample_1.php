<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//parse styles of the default template
$docx->parseStyles();

$docx->createDocx('example_parseStyles_1');
