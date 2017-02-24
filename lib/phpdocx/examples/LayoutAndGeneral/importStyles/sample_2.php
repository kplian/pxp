<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
//You may first check the available styles using the parseStyles('../files/TemplateStyles.docx') methohd

$docx->importStyles('../../files/stylesTemplate.docx', 'merge', array('heading 1'));

$docx->addText('This is the resulting paragraph with a standard heading style.', array('pStyle' => 'Heading1'));

//You may also import a complete XML style sheet by
//$docx->importStyles('../files/TemplateStyles.docx', $type= 'replace');

$docx->createDocx('example_importStyles_2');