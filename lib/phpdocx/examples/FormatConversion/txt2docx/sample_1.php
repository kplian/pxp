<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->txt2docx('../../files/Text.txt');

$docx->createDocx('example_txt2docx');