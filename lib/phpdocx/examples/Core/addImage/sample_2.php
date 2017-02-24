<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();


$options = array(
    'src' => '../../img/image.png',
    'scaling' => 40,
    'spacingTop' => 0,
    'spacingBottom' => 0,
    'spacingLeft' => 0,
    'spacingRight' => 20,
    'textWrap' => 1,
);

$docx->addImage($options);

$text = 'There is more than one way to make that the text wraps around an image. ';
$text .= 'Maybe the simplest is the one used here with the option textWrap = 1. ';
$text.= 'You may also placed it on the right using the float option.';


$docx->addText($text);

$docx->addBreak(array('type' => 'line'));

$text = 'Although you can have a little more control using Word fragments. ';
$text .= 'This si so because in the first example the image is in a paragraph of its own ';
$text.= 'while here it is inserted in the same paragraph as this text.';

$image = new Phpdocx\Elements\WordFragment($docx);
$options = array(
    'src' => '../../img/image.png',
    'scaling' => 40,
    'spacingTop' => 0,
    'spacingBottom' => 0,
    'spacingLeft' => 20,
    'spacingRight' => 0,
    'textWrap' => 1,
    'float' => 'right',
);
$image->addImage($options);

$runs = array();
$runs[] = $image;
$runs[] = array('text' => $text);
$docx->addText($runs);


$docx->createDocx('example_addImage_2');