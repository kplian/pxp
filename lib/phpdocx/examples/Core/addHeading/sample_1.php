<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addHeading('First level title', 0);


$text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, ' .
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
$docx->addText($text);

$docx->addHeading('Second level title',1);
$docx->addText($text);

$options = array(
    'color' => 'FF0000',
    'textAlign' => 'center',
    'fontSize' => 13
    );

$docx->addHeading('Third level title with additional custom formatting',2,$options);
$docx->addText($text);



$docx->createDocx('example_addHeading_1');