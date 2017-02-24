<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\XMLAPI('config.xml');
$docx->setDocumentProperties('settings.xml');
$docx->addContent('content.xml');

$docx->render();