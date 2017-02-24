<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//Custom options
$latinListOptions              = array();
$latinListOptions[0]['type']   = 'lowerLetter';
$latinListOptions[0]['format'] = '%1.';
$latinListOptions[1]['type']   = 'lowerRoman';
$latinListOptions[1]['format'] = '%1.%2.';
//Create the list style with name: latin
$docx->createListStyle('latin', $latinListOptions);
//List items
$myList = array('item 1', array('subitem 1.1', 'subitem 1.2'), 'item 2');
//Insert custom list into the Word document
$docx->addList($myList, 'latin');
//Save the Word document
$docx->createDocx('example_createListStyle_1');