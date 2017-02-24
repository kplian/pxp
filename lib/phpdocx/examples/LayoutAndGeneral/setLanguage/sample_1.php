<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//set the default language to Spanish using standard ISO codes
$docx->setLanguage('es-ES');
//add a couple of paragraphs, one in spanish and the other in English
$docx->addText('Este texto está en español y no debería estar marcado si se utiliza el corrector ortográfico.');
//whenever you start editing the file the following text will be underline by the spell checker.
$docx->addText('Now in english.');

$docx->createDocx('example_setLanguage_1');