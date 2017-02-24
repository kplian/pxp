<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$merge = new Phpdocx\BatchProcessing\MultiMerge();
$merge->mergePdf(array('../../files/Test.pdf', '../../files/Test2.pdf', '../../files/Test3.pdf'), 'example_merge_pdf.pdf');