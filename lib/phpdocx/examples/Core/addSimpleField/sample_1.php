<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();

//first we add certain properties to our Word document
$properties = array(
'title' => 'The title of the document.',
'creator' => 'The autor of the document.',
'description' => 'A description of the document.'
);

$docx->addProperties($properties);

$docx->addText('We add a few simple fields that render the above properties:');

$options = array(
    'pStyle'=>'Heading1PHPDOCX'
    );

$docx->addSimpleField('TITLE','','', $options);

$docx->addSimpleField('AUTHOR');
$docx->addSimpleField('NUMPAGES');
$docx->addSimpleField('COMMENTS');

//we prompt the user to updat the fields on openning
$docx->docxSettings(array('updateFields'=>'true'));


$docx->createDocx('example_addSimpleField_1');
