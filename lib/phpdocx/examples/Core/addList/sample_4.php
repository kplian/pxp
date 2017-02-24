<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$itemList = array(
    'Line 1',
    'Line 2',
    'Line 3',
    'Line 4',
    'Line 5'
);

//stablish some global run properties for each list item

$options = array(
	'font' => 'Arial',
	'italic' => true,
	'fontSize' => 14,
	'color' => 'b70000'
	);

//we set the style type to 1: unordered list

$docx->addList($itemList, 1, $options);


$docx->createDocx('example_addList_4');