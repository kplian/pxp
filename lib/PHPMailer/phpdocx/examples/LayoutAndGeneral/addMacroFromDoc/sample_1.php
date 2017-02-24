<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx('docm');

$docx->addMacroFromDoc('../../files/fileMacros.docm');

$docx->createDocx('example_addMacroFromDoc_1');