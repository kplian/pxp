<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$docx->removeChapter('../../files/headings.docx', 'example_removeChapter.docx', 'First Heading');