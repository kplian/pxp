<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$docx->addText('We extract a math equation from an external Word file:');

$docx->addMathEquation('../../files/math.docx', 'docx');

$docx->createDocx('example_addMathDocx_1');