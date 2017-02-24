<?php

//path to  the CreateDocx class within your PHPDocX installation
require_once '../../../classes/CreateDocx.inc';

$docx = new CreateDocx();
$docx->importHeadersAndFooters('../../files/TemplateHeaderAndFooter.docx');
$docx->addText('This is the resulting word document with imported header and footer.');
//You may import only the header with
//$docx->importHeadersAndFooters('TemplateHeaderAndFooter.docx', 'header');
//and only the footer with
//$docx->importHeadersAndFooters('TemplateHeaderAndFooter.docx', 'footer');

$docx->createDocx('example_importHeadersAndFooters_1');