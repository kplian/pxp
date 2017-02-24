<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('We extract a math equation from an external Word file:');

$docx->addMathEquation('../../files/math.docx', 'docx');

$docx->createDocx('example_addMathDocx_1');