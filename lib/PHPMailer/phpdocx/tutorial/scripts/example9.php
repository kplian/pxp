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

//We first prepare an item list element with more sophisticated formatting:

$paramsItem = array(
	array(
		'text' => 'This is the text associated with the first item',
		'b' => 'single',
		'color' => 'b70000',
	),
	array(
		'text' => ' now without bold'
	),
	array(
		'text' => ' and blue',
		'color' => '0000b7',
	)
);

$myItem = $docx->addElement('addText', $paramsItem);

//Let us now to add a nested unordered list
$myList = array($myItem,
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

$valuesTable = array(
	array(
	'cell_1_1',
	'cell_1_2',
	'cell_1_3',
	'cell_1_4'
	),
	array(
	'cell_2_1',
	'cell_2_2',
	'cell_2_3',
	'cell_2_4'
	),
	array(
	'cell_3_1',
	'cell_3_2',
	'cell_3_3',
	'cell_3_4'
	)
);

$paramsTable = array('TBLSTYLEval' => 'MediumGrid3-accent5PHPDOCX');

$docx->addTable($valuesTable, $paramsTable);


$myHTML = '<br /><p style="font-family: Calibri; font-size: 11pt">We include a table with rowspans and colspans using the embedHTML method.</p>
<table style="font-family: Calibri; font-size: 11pt">
  <tr>
	  <td>header 1</td>
	  <td>header 2</td>
	  <td>header 3</td>
	  <td>header 4</td>
  </tr>
  <tr>
	  <td rowspan="2" colspan="2">cell_1_1</td>
	  <td>cell_1_3</td>
	  <td>cell_1_4</td>
  </tr>
  <tr>
	  <td>cell_2_3</td>
	  <td>cell_2_4</td>
  </tr>
  <tr>
	  <td>cell_3_1</td>
	  <td>cell_3_2</td>
	  <td>cell_3_3</td>
	  <td>cell_3_4</td>
  </tr>
</table>';

$docx->embedHTML($myHTML, array('tableStyle' => 'MediumGrid3-accent5PHPDOCX'));

$docx->addBreak();

$paramsImg = array(
'name' => '../img/image.png',//path to the image that we would like to insert
'scaling' => 90,//scaling factor, 100 corresponds to no scaling
'spacingTop' => 10,//top padding
'spacingBottom' => 10,//bottom padding
'spacingLeft' => 10,//left padding
'spacingRight' => 10,//right padding
//'dpi' => 96,
'textWrap' => 1//corresponding to square format
);
$docx->addImage($paramsImg);

$docx->createDocx('../word_documents/example_image');


