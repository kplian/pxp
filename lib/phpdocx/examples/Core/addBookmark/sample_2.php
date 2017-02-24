<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$bookmarkStart = new Phpdocx\Elements\WordFragment($docx);
$bookmarkStart->addBookmark(array('type' => 'start', 'name' => 'bookmark_name'));
$bookmarkEnd = new Phpdocx\Elements\WordFragment($docx);
$bookmarkEnd->addBookmark(array('type' => 'end', 'name' => 'bookmark_name'));

$textRuns   = array();
$textRuns[] = array('text' => 'We are only going to bookmark: ');
$textRuns[] = $bookmarkStart;
$textRuns[] = array('text' => 'this words.');
$textRuns[] = $bookmarkEnd;

$docx->addText($textRuns);

$docx->createDocx('example_addBookmark_2');