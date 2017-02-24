<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx('docm');

$docx->addMacroFromDoc('../../files/fileMacros.docm');

$docx->createDocx('example_addMacroFromDoc_1');