<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//A paragraph composed of two runs of text with different properties
$text = array();
$text[] =
    array(
        'text' => 'We know this looks ugly',
        'underline' => 'single'
);
$text[] =
    array(
        'text' => ' but we only want to illustrate some of the functionality of the addText method.',
        'bold' => true
);
//we also add some borders to the paragraph to illustrate that functionality
$paragraphOptions = array( 'border' => 'double',
    'borderColor' => 'b70000',
    'borderWidth' => 12,
    'borderSpacing' => 8,
    'borderTopColor' => '000000'//we overwritte the top border color property
    );
$docx->addText($text, $paragraphOptions);

$docx->createDocx('example_addText_2');