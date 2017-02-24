<?php

/**
 * Tutorial example
 *
 * @category   Phpdocx
 * @package    tutorial
 * @subpackage easy
 * @copyright  Copyright (c) 2009-2011 Narcea Producciones Multimedia S.L.
 *             (http://www.2mdc.com)
 * @license    http://www.phpdocx.com/wp-content/themes/lightword/pro_license.php
 * @version    1.8
 * @link       http://www.phpdocx.com
 * @since      01/03/2012
 */
require_once '../../classes/CreateDocx.inc';

$docx = new CreateDocx();

//Importing header and footer from external .docx file
$docx ->importHeadersAndFooters('../word_documents/templateHeaderAndFooter.docx');
$text = array();
$text[] =
	array(
	'text' => 'I am going to write',
	);
$text[] =
	array(
	'text' => ' Hello World!',
	'b' => 'single',
	);

$text[] =
	array(
	'text' => ' using bold characters.',
	);
$docx->addText($text);

//Let us now to add a nested unordered list
$myList = array('item 1',
                'item 2',
                array('subitem 2_1',
                      'subitem 2_2'),
                'item 3',
                array('subitem 3_1',
                      'subitem 3_2',
                      array('sub_subitem 3_2_1',
                            'sub_subitem 3_2_1')),
                'item 4');
								
$docx->addList($myList, array('val' => 1));

$docx->createDocx('../word_documents/hello_world_list');
