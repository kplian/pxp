<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$newDocx = new Phpdocx\Utilities\DocxUtilities();
$options = array( 'document' => true,
                                    'endnotes' => true,
                                    'comments' => true,
                                    'headersAndFooters' => true,
                                    'footnotes' => true);

$newDocx->searchAndRemove('../../files/second.docx', 'example_removedParagraphDocx.docx', 'different', $options);