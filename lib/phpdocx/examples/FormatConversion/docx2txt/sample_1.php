<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$options = array('paragraph' => true, 'list' => true,'table' => true, 'footnote' => true, 'endnote' => true, 'chart' => 0);
Phpdocx\Create\CreateDocx::DOCX2TXT('../../files/Text.docx', 'document_1.txt', $options);