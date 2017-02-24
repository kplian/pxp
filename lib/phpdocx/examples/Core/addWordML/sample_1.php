<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Create\CreateDocx();
$docx->addText('We are now going to add a paragraph by inserting a chunk of WordML code.');

$wordML = '<w:p><w:r><w:t>A very simple paragraph with only text.</w:t></w:r></w:p>';
$docx->addWordML($wordML);

$docx->addText('Beaware that this is not, in general, a recommendable practice unless you are truly familiar with the OOXML standard.');

$docx->createDocx('example_addWordML_1');