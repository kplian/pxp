<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$footnote = new Phpdocx\Elements\WordFragment($docx, 'document');

$footnote->addFootnote(
    array(
        'textDocument' => 'footnote',
        'textFootnote' => 'The footnote we want to insert.',
    )
);
                    

$text = array();
$text[]= array('text' => 'Here comes the ');
$text[]= $footnote;
$text[]= array('text' => ' and some other text.');


$docx->addText($text);
$docx->addText('Some other text.');

$docx->createDocx('example_addFootnote_1');