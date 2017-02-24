<?php

require_once '../../../Classes/Phpdocx/Create/CreateDocx.inc';

$docx       = new Phpdocx\Create\CreateDocx();
$properties = array(
	'title'              => 'My title',
	'subject'            => 'My subject',
	'creator'            => 'The creator',
	'keywords'           => 'keyword 1, keyword 2, keyword 3',
	'description'        => 'The description could be much longer than this',
	'category'           => 'My category',
	'contentStatus'      => 'Draft',
	'Manager'            => 'The boss',
	'Company'            => 'My company',
	'custom'             => array(
		'My custom text'    => array('text'    => 'This is a reasonably large text'),
		'My custom number'  => array('number'  => '4567'),
		'My custom date'    => array('date'    => '1962-01-27T23:00:00Z'),
		'My custom boolean' => array('boolean' => true)
	)
);
$docx->addProperties($properties);

$text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, '.
'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '.
'enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut'.
'aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit '.
'in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '.
'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '.
'officia deserunt mollit anim id est laborum.';

$paramsText = array(
	'b'    => 'single',
	'font' => 'Arial',
);

$docx->addText($text, $paramsText);

$docx->createDocx('example_addProperties_1');