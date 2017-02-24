<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$endnote = new Phpdocx\Elements\WordFragment($docx, 'document');

$endnote->addEndnote(
	array(
		'textDocument' => 'endnote',
		'textEndnote'  => 'The endnote we want to insert.',
	)
);

$text   = array();
$text[] = array('text' => 'Here comes the ');
$text[] = $endnote;
$text[] = array('text' => ' and some other text.');

$docx->addText($text);
$docx->addText('Some other text.');

$docx->createDocx('example_addEndnote_1');