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

$docx->createDocx('../word_documents/hello_world_headersAndFooters');
