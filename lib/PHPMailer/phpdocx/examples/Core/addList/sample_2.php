<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();


$itemList= array(
    'Line 1',
    array(
        'Line A',
        'Line B',
        'Line C'
    ),
    'Line 2',
    'Line 3',
);

//we set the style type to 2: ordered list

$docx->addList($itemList, 2);


$docx->createDocx('example_addList_2');