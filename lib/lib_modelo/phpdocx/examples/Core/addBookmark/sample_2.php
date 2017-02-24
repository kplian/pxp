<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();

$bookmarkStart = new WordFragment($docx);
$bookmarkStart->addBookmark(array('type' => 'start', 'name' => 'bookmark_name'));
$bookmarkEnd = new WordFragment($docx);
$bookmarkEnd->addBookmark(array('type' => 'end', 'name' => 'bookmark_name'));

$textRuns = array();
$textRuns[] = array('text' => 'We are only going to bookmark: ');
$textRuns[] = $bookmarkStart;
$textRuns[] = array('text' => 'this words.');
$textRuns[] = $bookmarkEnd;

$docx->addText($textRuns);

$docx->createDocx('example_addBookmark_2');