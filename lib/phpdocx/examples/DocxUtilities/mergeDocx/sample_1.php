<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$merge = new Phpdocx\BatchProcessing\MultiMerge();
$merge->mergeDocx('../../files/Text.docx', array('../../files/second.docx', '../../files/SimpleExample.docx'), 'example_merge_docx.docx', array());