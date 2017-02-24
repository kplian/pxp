<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//Custom Bullets
$latinListOptions              = array();
$latinListOptions[0]['type']   = 'bullet';
$latinListOptions[0]['format'] = 'G';
$latinListOptions[0]['font']   = 'Wingdings';
$latinListOptions[1]['type']   = 'bullet';
$latinListOptions[1]['format'] = 'F';
$latinListOptions[1]['font']   = 'Wingdings';
//Create the list style with name: latin
$docx->createListStyle('funnyBullets', $latinListOptions);
//List items
$myList = array('item 1', array('subitem 1.1', 'subitem 1.2'), 'item 2');
//Insert custom list into the Word document
$docx->addList($myList, 'funnyBullets');
//Save the Word document
$docx->createDocx('example_createListStyle_2');