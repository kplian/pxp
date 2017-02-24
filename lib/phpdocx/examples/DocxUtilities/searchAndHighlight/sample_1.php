<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx = new Phpdocx\Utilities\DocxUtilities();
$options = array( 'highlightColor' => 'green',
                                    'document' => true,
                                    'endnotes' => true,
                                    'comments' => true,
                                    'headersAndFooters' => true,
                                    'footnotes' => true);
$docx->searchAndHighlight('../../files/second.docx', 'example_highlightedDocx.docx', 'data', $options);