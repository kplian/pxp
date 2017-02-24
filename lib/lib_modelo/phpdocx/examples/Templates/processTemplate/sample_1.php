<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocxFromTemplate('../../files/TemplateVariables.docx');

//You may include manually the list of variables that should be preprocessed or use
//the getTemplateVariables method for an automatic listing
$variables = $docx->getTemplateVariables();
$docx->processTemplate($variables);

$docx->createDocx('example_processTemplate_1');
