<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

$docx->addText('Quisque ullamcorper, dolor eget eleifend consequat, 
    justo nunc ultricies quam, sed ullamcorper lectus urna ac justo. 
    Phasellus sed libero ut dui hendrerit tempus. Mauris tincidunt 
    laoreet sapien, feugiat viverra justo dictum eu. Cras at eros ac 
    urna accumsan varius. Vestibulum cursus gravida sollicitudin. 
    Donec vestibulum lectus id sem malesuada volutpat. Praesent et ipsum orci. 
    Sed rutrum eros id erat fermentum in auctor velit auctor. 
    Nam bibendum rutrum augue non pellentesque. Donec in mauris dui, 
    non sagittis dui. Phasellus quam leo, ultricies sit amet cursus nec, 
    elementum at est. Proin blandit volutpat odio ac dignissim. 
    In at lacus dui, sed scelerisque ante. Aliquam tempor, 
    metus sed malesuada vehicula, neque massa malesuada dolor, 
    vel semper massa ante eu nibh.');


//create a simple Word fragment to insert into the table
$textFragment = new Phpdocx\Elements\WordFragment($docx);
$text = array();
$text[] = array('text' => 'Fit text and ');
$text[] = array('text' => 'Word fragment', 'bold' => true);
$textFragment->addText($text);

//stablish some row properties for the first row
$trProperties = array();
$trProperties[0] = array('minHeight' => 1000, 
    'tableHeader' => true
    );

$col_1_1 = array( 'rowspan' => 4,
    'value' => '1_1', 
    'backgroundColor' => 'cccccc',
    'borderColor' => 'b70000',
    'border' => 'single',
    'borderTopColor' => '0000FF',
    'borderWidth' => 16,
    'cellMargin' => 200,
    );

$col_2_2 = array('rowspan' => 2, 
    'colspan' => 2, 
    'width' => 200,
    'value' => $textFragment, 
    'backgroundColor' => 'ffff66',
    'borderColor' => 'b70000',
    'border' => 'single',
    'cellMargin' => 200,
    'fitText' => 'on',
    'vAlign' => 'bottom',
    );

$col_2_4 = array( 'rowspan' => 3,
    'value' => 'Some rotated text', 
    'backgroundColor' => 'eeeeee',
    'borderColor' => 'b70000',
    'border' => 'single',
    'borderWidth' => 16,
    'textDirection' => 'tbRl',
    );

//set teh global table properties
$options = array('columnWidths' => array(400,1400,400,400,400), 
'border' => 'single', 
'borderWidth' => 4, 
'borderColor' => 'cccccc', 
'borderSettings' => 'inside', 
'float' => array('align' => 'right', 
    'textMargin_top' => 300, 
    'textMargin_right' => 400, 
    'textMargin_bottom' => 300, 
    'textMargin_left' => 400
        ),
    );
$values = array(
    array($col_1_1, '1_2', '1_3', '1_4', '1_5'),
    array($col_2_2, $col_2_4, '2_5'),
    array('3_5'),
    array('4_2', '4_3', '4_5'),
);

$docx->addTable($values, $options, $trProperties);

$docx->addText('In pretium neque vitae sem posuere volutpat. 
    Class aptent taciti sociosqu ad litora torquent per conubia nostra, 
    per inceptos himenaeos. Quisque eget ultricies ipsum. Cras vitae suscipit 
    erat. Nullam fermentum risus sed urna fermentum placerat laoreet arcu lobortis. 
    Integer nisl erat, vehicula eget posuere id, mollis fermentum mi. 
    Phasellus quis nulla orci. Suspendisse malesuada lectus et turpis facilisis 
    id imperdiet tellus luctus. In hac habitasse platea dictumst. Proin a mattis turpis. 
    Aliquam sit amet velit a lacus hendrerit bibendum. Mauris euismod dictum augue eget condimentum.');



$docx->createDocx('example_addTable_3');