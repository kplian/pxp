<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$newDocx = new Phpdocx\Utilities\DocxUtilities();
$newDocx->setLineNumbering('../../files/second.docx', 'example_setLineNumbering.docx', array('start' => 25));