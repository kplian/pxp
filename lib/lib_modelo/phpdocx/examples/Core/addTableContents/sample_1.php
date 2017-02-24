<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
$docx->addText('Table of Contents', array('bold' => true, 'fontSize' => 14));
$legend = array('text' => 'Click here to update the TOC', 
    'color' => 'B70000', 
    'bold' => true, 
    'fontSize' => 12);
$docx->addTableContents(array('autoUpdate' => true), $legend, '../../files/crazyTOC.docx');
//we add now some headings so tehy show up in the TOC
$docx->addText('Chapter 1', array('pStyle' => 'Heading1PHPDOCX'));
$docx->addText('Section', array('pStyle' => 'Heading2PHPDOCX'));
$docx->addText('Another TOC entry', array('pStyle' => 'Heading3PHPDOCX'));

$docx->createDocx('example_addTableContents_1');