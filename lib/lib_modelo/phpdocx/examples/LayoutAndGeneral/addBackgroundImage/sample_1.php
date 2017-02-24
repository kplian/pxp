<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
//You should include the relative path to the image you want to use as background
$docx->addBackgroundImage('../../img/image.jpg');
//add a paragraph of text
$docx->addText('Please, use a discrete background image so the text is easily readable.');
$docx->addText('This one is pretty annoying but it illustrates well the functionality :-)');

$docx->createDocx('example_addBackgroundImage_1');
