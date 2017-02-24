<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$link = new Phpdocx\Elements\WordFragment($docx);
$link->addLink('Google', array('url'=> 'http://www.google.es'));

$runs = array();
$runs[] = array('text' => 'Now we include a link to ');
$runs[] = $link;
$runs[] = array('text' => ' in the middle of a pragraph of plain text.');

$docx->addText($runs);

$docx->createDocx('example_addLink_2');