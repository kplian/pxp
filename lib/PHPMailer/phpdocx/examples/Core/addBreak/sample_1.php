<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' .
    'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut' .
    'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit ' .
    'in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

$docx->addText($text);

$docx->addText($text);

$docx->addBreak(array('type' => 'line'));

$docx->addText($text);

$docx->addBreak(array('type' => 'line', 'number' => 2));

$docx->addText($text);

$docx->addBreak(array('type' => 'page'));

$docx->addText($text);

$docx->createDocx('example_addBreak_1');