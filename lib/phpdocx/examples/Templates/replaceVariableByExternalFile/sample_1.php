<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocxFromTemplate('../../files/TemplateExternalFile.docx');


$docx->replaceVariableByExternalFile(array('EXTERNAL' => '../../files/External.docx'), array('matchSource' => true));


$docx->createDocx('example_replaceVariableByExternalFile_1');
