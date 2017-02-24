<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
//You may first check the available styles using the parseStyles('../files/TemplateStyles.docx') methohd

$docx->importStyles('../../files/TemplateStyles.docx', 'merge', array('crazyStyle'));

$docx->addText('This is the resulting paragraph with the "CrazyStyle".', array('pStyle' => 'crazyStyle'));

//You may also import a complete XML style sheet by
//$docx->importStyles('../files/TemplateStyles.docx', $type= 'replace');

$docx->createDocx('example_importStyles_1');