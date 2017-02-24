<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//Style options
$style = array(
	'color'        => 'b70000',
	'fontSize'     => 26,
	'tabPositions' => array(array('$type' => 'clear', 'position' => 1600),
		array('$type' => 'clear', 'leader' => 'dot', 'position' => 2800),
		array('$type' => 'clear', 'leader' => 'dot', 'position' => 4000),
	)
);
//Create custom style
$docx->createParagraphStyle('myStyle', $style);
//insert a paragraph with that style
$text[] = array('text' => 'Tabbed text:');
$text[] = array('text' => 'One', 'tab' => true);
$text[] = array('text' => 'Two', 'tab' => true);
$text[] = array('text' => 'Three', 'tab' => true);

$docx->addText($text, array('pStyle' => 'myStyle'));

$docx->createDocx('example_createParagraphStyle_2');